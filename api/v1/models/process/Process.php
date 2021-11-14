<?php
namespace api\v1\models\process;

use api\v1\models\globe\GlobeLabs;
use core\misc\Database;
use core\misc\Defaults;
use core\misc\Utilities;
use DateTime;

class Process
{

    public static function statistics()
    {
        $customers = (new Database())->processQuery("SELECT count(*) as `count`, customer_status FROM customer GROUP BY customer_status", []);
        $employees = (new Database())->processQuery("SELECT count(*) as `count`, emp_status FROM employee GROUP BY emp_status", []);
        $todos = (new Database())->processQuery("SELECT count(*) as `count`, todo_status FROM todo GROUP BY todo_status", []);
        
        return Utilities::response(true, null, [
            "customer" => self::processStatuses($customers, 'customer_status'),
            "employee" => self::processStatuses($employees, 'emp_status'),
            "todo" => self::processStatuses($todos, 'todo_status'),
        ]);
    }

    public static function processStatuses($data, $columnStatus)
    {
        $status = [];

        foreach ($data as $row) {
            $status[(string)$columnStatus.'_'.$row[$columnStatus]] = $row['count'];
        }

        return $status;
    }

    public static function dashboard()
    {
        $search = Utilities::fetchDataFromArray($_GET, 'search');

        if (is_null($search) || $search == ''){
            $customers = (new Database())->processQuery("SELECT * FROM customer ORDER BY customer_updated_at DESC, customer_created_at DESC", []);
            $output = [];
        }else {
            $search = "%{$search}%";
            $customers = (new Database())->processQuery("SELECT * FROM customer WHERE customer_last_name like ? or customer_first_name like ? ORDER BY customer_updated_at DESC, customer_created_at DESC", [$search, $search]);
        }
        
        foreach ($customers as $customer) {
            $output[$customer['customer_status']][] = $customer;
        }

        return Utilities::response(true, null, $output);
    }

    public static function dashboardDetail()
    {
        $customerId = Utilities::fetchRequiredDataFromArray($_GET, 'customer_id');
        $customers = (new Database())->processQuery("SELECT * FROM customer WHERE customer_id = ?", [$customerId]);

        return Utilities::response(true, null, $customers);
    }

    public static function updateCustomer()
    {
        $customerId = Utilities::fetchRequiredDataFromArray($_POST, 'customer_id');
        $status = Utilities::fetchRequiredDataFromArray($_POST, 'status');
        $customer = (new Database())->processQuery("UPDATE customer SET customer_status = ?, customer_updated_at = now() WHERE customer_id = ?", [$status, $customerId]);

        return Utilities::response(((!empty($customer['response']) && $customer['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function deleteCustomer()
    {
        $customerId = Utilities::fetchRequiredDataFromArray($_POST, 'customer_id');
        $customer = (new Database())->processQuery("DELETE FROM customer WHERE customer_id = ?", [$customerId]);

        return Utilities::response(((!empty($customer['response']) && $customer['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    // ============================================================

    public static function getEmployeeList()
    {
        $search = Utilities::fetchDataFromArray($_GET, 'search');
        // $offset = is_null(Utilities::fetchDataFromArray($_GET, 'offset')) ? 0 : (int) Utilities::fetchDataFromArray($_GET, 'offset') ;
        // $limit =   is_null(Utilities::fetchDataFromArray($_GET, 'limit')) ? 10 : (int) Utilities::fetchDataFromArray($_GET, 'limit') ;

        if (is_null($search) || $search == ''){
            $total = (new Database())->processQuery("SELECT count(*) as `count` FROM employee  ORDER BY emp_last_name ASC", []);
            $employees = (new Database())->processQuery("SELECT * FROM employee  ORDER BY  emp_last_name ASC", []);
        }else {
            $search = "%{$search}%";

            $total = (new Database())->processQuery("SELECT count(*) as `count` FROM employee WHERE emp_last_name like ? or emp_first_name like ? ORDER BY  emp_last_name ASC", [$search, $search]);

            $employees = (new Database())->processQuery("SELECT * FROM employee WHERE emp_last_name like ? or emp_first_name like ? ORDER BY  emp_last_name ASC", [$search, $search]);
        }
        
        return Utilities::response(true, null, ["employees" => $employees, "count" => isset($total) && count(reset($total)['count']) > 0 ? reset($total)['count'] : 0]);
    }

    public static function getActiveEmployeeList()
    {
        $employees = (new Database())->processQuery("SELECT * FROM employee  WHERE emp_status = 1 ORDER BY emp_last_name ASC", []);
        
        return Utilities::response(true, null, ["employees" => $employees, "count" => count($employees)]);
    }


    public static function createEmployee()
    {
        $fname = Utilities::fetchRequiredDataFromArray($_POST, 'fname');
        $lname = Utilities::fetchRequiredDataFromArray($_POST, 'lname');
        $email = strtolower(trim(Utilities::fetchRequiredDataFromArray($_POST, 'email')));
        $mobile = substr(preg_replace( '/[^0-9]/', '', Utilities::fetchRequiredDataFromArray($_POST, 'mobile')), -10, 10);
        $employees = (new Database())->processQuery("SELECT * FROM employee WHERE emp_mobile_number = ? OR emp_email = ?", [$mobile, $email]);

        // if (count($employees) > 0) {
        //     return Utilities::response(false, ["error" => "Account already exist. Unable to complete process."], null);
        // }

        // $output = (new Database())->processQuery("INSERT INTO employee (emp_first_name, emp_last_name, emp_mobile_number, emp_email, emp_created_at) VALUES (?,?,?,?,now())", [$fname, $lname, $mobile, $email]);

        // return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
        if (empty($employees)) {
            $output = (new Database())->processQuery("INSERT INTO employee (emp_first_name, emp_last_name, emp_mobile_number, emp_email, emp_created_at) VALUES (?,?,?,?,now())", [$fname, $lname, $mobile, $email]);

            return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
        }else{
            return Utilities::response(false, ["error" => "Account already exist. Unable to complete process."], null);
        }
    }

    public static function updateEmployee()
    {
        $empId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $fname = Utilities::fetchRequiredDataFromArray($_POST, 'fname');
        $lname = Utilities::fetchRequiredDataFromArray($_POST, 'lname');
        $email = strtolower(trim(Utilities::fetchRequiredDataFromArray($_POST, 'email')));
        $mobile = substr(preg_replace( '/[^0-9]/', '', Utilities::fetchRequiredDataFromArray($_POST, 'mobile')), -10, 10);
        $employees = (new Database())->processQuery("SELECT * FROM employee WHERE (emp_mobile_number = ? OR emp_email = ?) AND emp_id = ? AND emp_status = 0", [$mobile, $email, $empId]);
        $check = (new Database())->processQuery("SELECT * FROM employee WHERE emp_mobile_number = ? OR emp_email = ?", [$mobile, $email]);

        if (empty($employees)) {
            return Utilities::response(false, ["error" => "E-mail/Mobile Number already in use or Employee is already Active. Unable to complete process."], null);
        }
        if ($check == $employees){
            $output = (new Database())->processQuery("UPDATE employee SET emp_first_name = ?, emp_last_name = ?, emp_mobile_number = ?, emp_email = ?, emp_updated_at = now() WHERE emp_id = ? and emp_status = 0", [$fname, $lname, $mobile, $email, $empId]);

            return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
            
        }else{
            return Utilities::response(false, ["error" => "E-mail/Mobile Number already in use."], null);
        }

        // $output = (new Database())->processQuery("UPDATE employee SET emp_first_name = ?, emp_last_name = ?, emp_mobile_number = ?, emp_email = ?, emp_updated_at = now() WHERE emp_id = ? and emp_status = 0", [$fname, $lname, $mobile, $email, $empId]);

        // return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function updateEmployeeStatus($mobileNumber, $status)
    {
        $output = (new Database())->processQuery("UPDATE employee SET emp_status = ?, emp_updated_at = now() WHERE emp_mobile_number = ?", [$status, $mobileNumber]);
        return ((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false);
    }

    public static function getEmployee()
    {
        $empId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $employee = (new Database())->processQuery("SELECT * FROM employee WHERE emp_id = ?", [$empId]);

        return Utilities::response(true, null, (reset($employee) ?? null));
    }

    public static function deleteEmployee()
    {
        $empId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $employee = (new Database())->processQuery("SELECT emp_mobile_number FROM employee WHERE emp_id = ? LIMIT 1", [$empId]);

        if (!empty($employee)) {
            $output = (new Database())->processQuery("DELETE FROM employee WHERE emp_id = ?", [$empId]);
            $deleteMessage = (new Database())->processQuery("DELETE FROM sent_message WHERE sent_message_mobile = ?", [$employee[0]['emp_mobile_number']]);
    
            return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
        } else {
            return Utilities::response(false, "Cannot find the employee.", "");
        }
    }
    
    // ============================================================

    public static function getTodoList()
    {
        $search = Utilities::fetchDataFromArray($_GET, 'search');

        if (is_null($search) || $search == ''){
            $todos = (new Database())->processQuery("SELECT * FROM todo ORDER BY todo_created_at DESC, todo_updated_at DESC", []);
            $output = [];

        }else {
            $search = "%{$search}%";
            $todos = (new Database())->processQuery("SELECT * FROM todo WHERE todo_title like ? ORDER BY todo_created_at DESC, todo_updated_at DESC", [$search]);
        }
        foreach ($todos as $todo) {
            $output[$todo['todo_status']][] = $todo;
        }
        return Utilities::response(true, null, $output);
    }

    public static function getTodoDetail()
    {
        $todoId = Utilities::fetchRequiredDataFromArray($_POST, 'todo_id');
        $todo = (new Database())->processQuery("SELECT * FROM todo WHERE todo_id =? LIMIT 1 ", [$todoId]);

        return Utilities::response(true, null, $todo);
    }

    public static function createTodo()
    {
        $title = Utilities::fetchRequiredDataFromArray($_POST, 'title');
        $description = Utilities::fetchRequiredDataFromArray($_POST, 'description');
        $address = Utilities::fetchRequiredDataFromArray($_POST, 'address');
        $deadline = Utilities::formatDate(Utilities::fetchRequiredDataFromArray($_POST, 'deadline'), 'Y-m-d H:i:s');
        $date = date('Y-m-d H:i:s');
        
        if ($deadline < $date){
            return Utilities::response(false, "Unable to process.", "");
        }else{
            $output = (new Database())->processQuery("INSERT INTO todo (todo_title, todo_description, todo_address, todo_deadline, todo_created_at) VALUES (?,?,?,?,now())", [$title, $description, $address, $deadline]);

            return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
        }
        
    }

    public static function updateTodo()
    {
        $todoId = Utilities::fetchRequiredDataFromArray($_POST, 'todo_id');
        $status = Utilities::fetchRequiredDataFromArray($_POST, 'status');

        $todo = (new Database())->processQuery("UPDATE todo SET todo_status = ?, todo_updated_at = now() WHERE todo_id = ?", [$status, $todoId]);

        return Utilities::response(((!empty($todo['response']) && $todo['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function deleteTodo()
    {
        $todoId = array_map(function($payload) {return (int) $payload;}, Utilities::fetchRequiredDataFromArrayAsArray($_POST, 'todo_id'));
        $params = "(".str_repeat('?,', count($todoId) - 1).'?)';
        $todo = (new Database())->processQuery("DELETE FROM todo WHERE todo_id in $params", $todoId);
        return Utilities::response(((!empty($todo['response']) && $todo['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }


    
    // ============================================================


    
    public static function createMessage()
    {
        $message = Utilities::fetchRequiredDataFromArray($_POST, 'message_content');
        $numbers = Utilities::fetchRequiredDataFromArrayAsArray($_POST, 'message_numbers');

        $output = [];

        $params = "(".str_repeat('?,', count($numbers) - 1).'?)';       
        $checkEmployee = (new Database())->processQuery("SELECT * FROM `employee` INNER JOIN  `opt_in` on `opt_in_mobile_number` = `emp_mobile_number` WHERE `emp_status` = 1 and `opt_in_mobile_number` in $params", $numbers);

        if (!empty($checkEmployee)) {
            $insertMessage = (new Database())->processQuery("INSERT INTO `message` (message_content, message_created_at) VALUES (?, now())", [$message]);

            if ((!empty($insertMessage['response']) && $insertMessage['response'] == Defaults::SUCCESS)) {
        
                foreach ($checkEmployee as $employee) {
                    
                    $mn = $employee['opt_in_mobile_number'];
                    $tkn = $employee['opt_in_token'];

                    (new Database())->processQuery("INSERT INTO `sent_message` (sent_message_message, sent_message_mobile) VALUES (?, ?)", [$insertMessage['last_inserted_id'], $mn]);
                    $output[] = GlobeLabs::sendSms($mn, $tkn, $message);
                }
            }
        }

        return Utilities::response(true, null,  $output);

    }

    public static function getSentMessages()
    {
        $search = Utilities::fetchDataFromArray($_GET, 'search');
        // $offset = is_null(Utilities::fetchDataFromArray($_GET, 'offset')) ? 0 : (int) Utilities::fetchDataFromArray($_GET, 'offset') ;
        // $limit =   is_null(Utilities::fetchDataFromArray($_GET, 'limit')) ? 10 : (int) Utilities::fetchDataFromArray($_GET, 'limit') ;
        
        if (is_null($search) || $search == ''){
            $messages = (new Database())->processQuery("SELECT * FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile LEFT JOIN `message` ON message_id = sent_message_message ORDER BY sent_created_at DESC", []);
            $total = (new Database())->processQuery("SELECT COUNT(*) as `count` FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile LEFT JOIN `message` ON message_id = sent_message_message ORDER BY sent_created_at DESC ", []);

        }else {
            $search = "%{$search}%";
            $messages = (new Database())->processQuery("SELECT * FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile LEFT JOIN `message` ON message_id = sent_message_message WHERE emp_last_name like ? or emp_first_name like ? ORDER BY  emp_last_name ASC", [$search, $search]);
            $total = (new Database())->processQuery("SELECT COUNT(*) as `count` FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile LEFT JOIN `message` ON message_id = sent_message_message WHERE emp_last_name like ? or emp_first_name like ? ORDER BY sent_created_at DESC ", [$search, $search]);
        }
        return Utilities::response(true, null, ['count' => isset($total) && count(reset($total)['count']) > 0? reset($total)['count'] : 0, 'messages' => $messages]);
    }

    public static function deleteSentMessage()
    {
        $sentMessageId = array_map(function($payload) {return (int) $payload;}, Utilities::fetchRequiredDataFromArrayAsArray($_POST, 'sent_message_id'));
        $params = "(".str_repeat('?,', count($sentMessageId) - 1).'?)';
        $sentMessage = (new Database())->processQuery("DELETE FROM sent_message WHERE sent_message_id in $params", $sentMessageId);
        return Utilities::response(((!empty($sentMessage['response']) && $sentMessage['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function getSentMessagesDetail()
    {
        $sentMessageId = Utilities::fetchRequiredDataFromArray($_GET, 'sent_message_id');
        $messages = (new Database())->processQuery("SELECT * FROM sent_message LEFT JOIN employee ON emp_mobile_number = sent_message_mobile LEFT JOIN `message` ON message_id = sent_message_message WHERE sent_message_id = ? ", [$sentMessageId]);
        return Utilities::response(true, null, $messages);
    }

    public static function createContacts()
    {
        $contact = Utilities::fetchRequiredDataFromArray($_POST, 'emp_status');
        $contactId = Utilities::fetchRequiredDataFromArray($_POST, 'emp_id');
        $output = (new Database())->processQuery("UPDATE `employee` SET emp_status = ?, emp_updated_at = now() WHERE emp_id = ?", [$contact, $contactId]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    // ============================================================

    public static function createInquiry()
    {
        $cFname = Utilities::fetchRequiredDataFromArray($_POST, 'customer_first_name');
        $cLname = Utilities::fetchRequiredDataFromArray($_POST, 'customer_last_name');
        $cMn = Utilities::fetchRequiredDataFromArray($_POST, 'customer_mobile_number');
        $cEmail = strtolower(trim(Utilities::fetchRequiredDataFromArray($_POST, 'customer_email')));
        $cInq = Utilities::fetchRequiredDataFromArray($_POST, 'customer_inquiry_details'); 

        
        $output = (new Database())->processQuery("INSERT INTO customer (customer_first_name, customer_last_name, customer_mobile_number, customer_email, customer_inquiry_details) VALUES (?,?,?,?,?)", [$cFname, $cLname, $cMn, $cEmail, $cInq]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    // ============================================================

    public static function createService()
    {
        $serv_name = Utilities::fetchRequiredDataFromArray($_POST, 'serv_name');
        $serv_price = Utilities::fetchRequiredDataFromArray($_POST, 'serv_price');
        $serv_description = Utilities::fetchRequiredDataFromArray($_POST, 'serv_description');
        $serv_image = Utilities::imageDataUploader(Utilities::fetchRequiredDataFromArray($_POST, 'serv_image'));
        if ($serv_image['status']===false)
        {
            return Utilities::response(false, $serv_image['error'], null);
        }

        $output = (new Database())->processQuery("INSERT INTO services (service_title, service_price, service_description, service_image) VALUES (?,?,?,?)", [$serv_name, $serv_price, $serv_description, $serv_image['content']['path']]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function getServiceList()
    {
        $search = Utilities::fetchDataFromArray($_GET, 'search');
        // $offset = is_null(Utilities::fetchDataFromArray($_GET, 'offset')) ? 0 : (int) Utilities::fetchDataFromArray($_GET, 'offset') ;
        // $limit =   is_null(Utilities::fetchDataFromArray($_GET, 'limit')) ? 10 : (int) Utilities::fetchDataFromArray($_GET, 'limit') ;

        $total = (new Database())->processQuery("SELECT count(*) as `count` FROM services  ORDER BY service_created_at DESC", []);

        if (is_null($search) || $search == ''){
            $services = (new Database())->processQuery("SELECT * FROM services  ORDER BY service_created_at DESC", []);
        }else {
            $search = "%{$search}%";
            $services = (new Database())->processQuery("SELECT * FROM services WHERE service_title like ? ORDER BY service_created_at DESC", [$search]);
        }
        return Utilities::response(true, null, ['services' => $services, 'count' => isset($total) && count(reset($total)['count']) > 0? reset($total)['count'] : 0]);
    }

    public static function createProduct()
    {
        $prod_name = Utilities::fetchRequiredDataFromArray($_POST, 'prod_name');
        $prod_price = Utilities::fetchRequiredDataFromArray($_POST, 'prod_price');
        $prod_image = Utilities::imageDataUploader(Utilities::fetchRequiredDataFromArray($_POST, 'prod_image'));
        if ($prod_image['status']===false)
        {
            return Utilities::response(false, $prod_image['error'], null);
        }

        $output = (new Database())->processQuery("INSERT INTO products (product_name, product_price, product_image) VALUES (?,?,?)", [$prod_name, $prod_price, $prod_image['content']['path']]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);       
    }

    public static function getProductList()
    {
        $search = Utilities::fetchDataFromArray($_GET, 'search');
        // $offset = is_null(Utilities::fetchDataFromArray($_GET, 'offset')) ? 0 : (int) Utilities::fetchDataFromArray($_GET, 'offset') ;
        // $limit =   is_null(Utilities::fetchDataFromArray($_GET, 'limit')) ? 10 : (int) Utilities::fetchDataFromArray($_GET, 'limit') ;

        $total = (new Database())->processQuery("SELECT COUNT(*) as `count` FROM products  ORDER BY product_created_at DESC", []);

        if (is_null($search) || $search == ''){
            $products = (new Database())->processQuery("SELECT * FROM products  ORDER BY product_created_at DESC", []);
        }else {
            $search = "%{$search}%";
            $products = (new Database())->processQuery("SELECT * FROM products WHERE product_name like ? ORDER BY product_created_at DESC", [$search]);
        }
        return Utilities::response(true, null, ["products" => $products, 'count' => isset($total) && count(reset($total)['count']) > 0? reset($total)['count'] : 0]);
    }

    public static function updateService()
    {
        $serv_id = Utilities::fetchRequiredDataFromArray($_POST, 'serviceId');
        $serv_name = Utilities::fetchRequiredDataFromArray($_POST, 'serviceName');
        $serv_price = Utilities::fetchRequiredDataFromArray($_POST, 'servicePrice');
        // $serv_image = Utilities::checkImage($_FILES, 'serviceImage');
        $serv_description = Utilities::fetchRequiredDataFromArray($_POST, 'serviceDescription');

        $output = (new Database())->processQuery("UPDATE services SET service_title = ?, service_description = ?, service_price = ?, service_updated_at = now() WHERE service_id = ?", [$serv_name, $serv_description, $serv_price, $serv_id]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function deleteService()
    {
        $serv_id = Utilities::fetchRequiredDataFromArray($_POST, 'serviceId');
        $service = (new Database())->processQuery("SELECT * FROM services WHERE service_id = ?", [$serv_id]);

        if (!empty($service)) {
            $output = (new Database())->processQuery("DELETE FROM services WHERE service_id = ?", [$serv_id]);

            return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
        } else {
            return Utilities::response(false, "Cannot find the service.", "");
        }
    }   
    public static function serviceDetail()
    {
        $serviceId = Utilities::fetchRequiredDataFromArray($_GET, 'service_id');
        $services = (new Database())->processQuery("SELECT * FROM services WHERE service_id = ?", [$serviceId]);

        return Utilities::response(true, null, $services);
    }
 

    public static function updateProduct()
    {
        $pId = Utilities::fetchRequiredDataFromArray($_POST, 'pId');
        $pName = Utilities::fetchRequiredDataFromArray($_POST, 'pName');
        $pPrice = Utilities::fetchRequiredDataFromArray($_POST, 'pPrice');
        // $pImage = Utilities::fetchRequiredDataFromArray($_POST, 'pImage');

        $output = (new Database())->processQuery("UPDATE products SET product_name = ?, product_price = ?, product_updated_at = now() WHERE product_id = ?", [$pName, $pPrice, $pId]);

        return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
    }

    public static function deleteProduct()
    {
        $pId = Utilities::fetchRequiredDataFromArray($_POST, 'pId');
        $product = (new Database())->processQuery("SELECT * FROM products WHERE product_id = ?", [$pId]);

        if (!empty($product)) {
            $output = (new Database())->processQuery("DELETE FROM products WHERE product_id = ?", [$pId]);

            return Utilities::response(((!empty($output['response']) && $output['response'] == Defaults::SUCCESS) ? true : false), null, null);
        } else {
            return Utilities::response(false, "Cannot find the product.", "");
        }
    }  

    // ========================================

    public static function changeUser()
    {
        
    }
}
