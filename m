Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02CA27D408
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgI2Q6F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 12:58:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgI2Q6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 12:58:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TGt3KF113712
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 16:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from :
 references : to : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2020-01-29;
 bh=lJHm5tKgmOiKcpT9DENAD2KbUwjREDBMVEfH6PL+iiQ=;
 b=Acn6nzZaguuQGw2UnxWUupeqUyDT6lajgP8grNh5sm466g4ma7jwInHHhvJpLDf8Yytt
 b7P3oqj3ifeJq+SoOIACdVIcLdM7quWi0Y0SKnA66DWMPg8PykyM+q4xONzr66GQY4E8
 mja3N5aVfvu3MbbO//7w+Ehzq2oOjo3MT6QUZ4E4IY+z75kcs/tQr+sdfuiO+8uwIjN0
 Lo3BxbxpySO/2frjMO4YUGnzo8KdNYl6Qj+g6/RcNdEt0xpl0G2RyDZK60Uph8VAGvln
 1JTK/s4I+tUtgH5OQ3JZ5a1/LAOgf/w0V1T7vhj0pdWt56935Id7p0PQBcZPAO+8Ag20 Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33sx9n40tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 16:57:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TGuQrK188748
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 16:57:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33tfhxx1vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 16:57:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08TGvw7s022668
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 16:57:58 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 09:57:55 -0700
Subject: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
References: <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
 <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
Organization: Oracle Corporation
To:     linux-rdma@vger.kernel.org
Message-ID: <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
Date:   Wed, 30 Sep 2020 00:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------BE11F2B46F009C6EF46DCF0D"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290143
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------BE11F2B46F009C6EF46DCF0D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/7/20 9:48 PM, Ka-Cheong Poon wrote:

> This may require a number of changes and the way a client interacts with
> the current RDMA framework.  For example, currently a client registers
> once using one struct ib_client and gets device notifications for all
> namespaces and devices.  Suppose there is rdma_[un]register_net_client(),
> it may need to require a client to use a different struct ib_client to
> register for each net namespace.  And struct ib_client probably needs to
> have a field to store the net namespace.  Probably all those client
> interaction functions will need to be modified.  Since the clients xarray
> is global, more clients may mean performance implication, such as it takes
> longer to go through the whole clients xarray.
> 
> There are probably many other subtle changes required.  It may turn out to
> be not so straight forward.  Is this community willing the take such changes?
> I can take a stab at it if the community really thinks that this is preferred.


Attached is a diff of a prototype for the above.  This exercise is
to see what needs to be done to have a more network namespace aware
interface for RDMA client registration.

Currently, there are ib_[un]register_client().  Under the RDMA namespace
exclusive mode, all RDMA devices are assigned to the init_net namespace
initially.  A kernel module uses this interface to register with the RDMA
subsystem.  When a device is assigned to a namespace, the client's
registered remove upcall is called with the device as the parameter (this
is removing from the init_net namespace).  Then the client's add upcall
is called with the device as the parameter (this is assigning to the new
namespace).  When that namespace is removed (*), a similar sequence of
events happen, a remove upcall (removing from the namespace) is followed
by add upcall (assigning back to the init_net namespace).  All the RDMA
clients are stored in a global struct xarray called clients (in device.c)
and each client is assigned a client ID.

This exercise adds the rdma_[un]register_net_client() for those clients
which want to have more separation between different namespaces.  This
interface takes a struct net parameter.  A kernel module uses this to
indicate that it is only interested in the RDMA events related to the
given network namespace.  Suppose a client uses init_net as the parameter.
In the above example when a device is assigned to a namespace, only the
client's remove upcall is called (removing from the init_net namespace).
The add upcall is not followed.  Then when the namespace is removed, the
client's add upcall is called (re-assigning back to the init_net namespace).
Suppose a client uses a specific namespace as the parameter.  When a device
is assigned to that specific namespace, the client's add upcall is called.
When the client unregisters with RDMA (or when the namespace is going away),
the client's remove upcall is called.  The RDMA clients are stored in each
namespace's struct rdma_dev_net and each client is assigned a client ID
in that namespace (this means that it is unique only in that namespace but
not unique globally among all namespaces).

This seemingly simple exercise turned out to be not so simple because of
the need to keep the existing interface with the existing behavior.  So only
when a client uses the new interface, the behavior is changed to what is
described above.  There should be no change of behavior to any existing
RDMA client.  There are several obstacles to overcome for this change.  One
difficulty is the global client ID since a lot of code rely on this ID as an
index the both the global clients xarray and individual device's client_data
xarray.  Detailed changes are in the attached diff if folks are interested.

Note that the new interface has one obvious issue, it does not make much sense
in RDMA shared network namespace mode.  In the shared mode, all devices are
associated with init_net.  So if a client uses the new interface to register
a specific namespace other than init_net, it will never get any upcall.  This
and the difficulties in adding a seemingly simple interface makes me wonder
about the following questions.

Is the RDMA shared namespace mode the preferred mode to use as it is the
default mode?  Is it expected that a client knows the running mode before
interacting with the RDMA subsystem?  Is a client not supposed to differentiate
different namespaces?  Besides the current add client upcall, another example
related to this is about event handling.  Suppose a client calls rdma_create_id()
to create listeners in different namespaces but with the same event handler.
A new connection comes in and the event handler is called for an
RDMA_CM_EVENT_CONNECT_REQUEST event.  There is no obvious namespace info regarding
the event.  It seems that the only way to find out the namespace info is to
use the context of struct rdma_cm_id.  The client must somehow add the namespace
info to the context since the subsystem does not provide any help.  Is this the
assumed solution?  BTW, this exercise still does not remove the need to have
rdma_dev_to_netns() as the add upcall does not provide any namespace info.  Given
all these questions, the rdma_[un]register_net_client() do not seem to fit in
the current way in interacting with the RDMA subsystem unfortunately.

Thanks.


(*) Note that in __rdma_create_id(), it does a get_net(net) to put a
     reference on a namespace.  Suppose a kernel module calls rdma_create_id()
     in its namespace .init function to create an RDMA listener and calls
     rdma_destroy_id() in its namespace .exit function to destroy it.  Since
     __rdma_create_id() adds a reference to a namespace, when a sys admin
     deletes a namespace (say `ip netns del ...`), the namespace won't be
     deleted because of this reference.  And the module will not release this
     reference until its .exit function is called only when the namespace is
     deleted.  To resolve this issue, in the diff (in __rdma_create_id()), I
     did something similar to the kern check in sk_alloc().



-- 
K. Poon
ka-cheong.poon@oracle.com



--------------BE11F2B46F009C6EF46DCF0D
Content-Type: text/x-patch; charset=UTF-8;
 name="rdma_register_client.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rdma_register_client.diff"

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 7f0e91e92968..15eb91eee200 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -873,7 +873,10 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	INIT_LIST_HEAD(&id_priv->listen_list);
 	INIT_LIST_HEAD(&id_priv->mc_list);
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
-	id_priv->id.route.addr.dev_addr.net = get_net(net);
+	if (caller)
+		id_priv->id.route.addr.dev_addr.net = net;
+	else
+		id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
 
 	return &id_priv->id;
@@ -1819,8 +1822,12 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
 static void _destroy_id(struct rdma_id_private *id_priv,
 			enum rdma_cm_state state)
 {
+	bool rel_net = true;
+
 	cma_cancel_operation(id_priv, state);
 
+	if (id_priv->res.kern_name)
+		rel_net = false;
 	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
@@ -1846,7 +1853,8 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 	if (id_priv->id.route.addr.dev_addr.sgid_attr)
 		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
 
-	put_net(id_priv->id.route.addr.dev_addr.net);
+	if (rel_net)
+		put_net(id_priv->id.route.addr.dev_addr.net);
 	kfree(id_priv);
 }
 
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index a1e6a67b2c4a..3c6c3cd516f3 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -66,6 +66,11 @@ struct rdma_dev_net {
 	struct sock *nl_sock;
 	possible_net_t net;
 	u32 id;
+
+	u32			rdn_highest_client_id;
+	struct xarray		rdn_clients;
+	struct rw_semaphore	rdn_clients_rwsem;
+
 };
 
 extern const struct attribute_group ib_dev_attr_group;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c36b4d2b61e0..f113c9b2e547 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -93,10 +93,7 @@ static DEFINE_XARRAY_FLAGS(devices, XA_FLAGS_ALLOC);
 static DECLARE_RWSEM(devices_rwsem);
 #define DEVICE_REGISTERED XA_MARK_1
 
-static u32 highest_client_id;
 #define CLIENT_REGISTERED XA_MARK_1
-static DEFINE_XARRAY_FLAGS(clients, XA_FLAGS_ALLOC);
-static DECLARE_RWSEM(clients_rwsem);
 
 static void ib_client_put(struct ib_client *client)
 {
@@ -399,6 +396,7 @@ static int rename_compat_devs(struct ib_device *device)
 
 int ib_device_rename(struct ib_device *ibdev, const char *name)
 {
+	struct rdma_dev_net *rdn;
 	unsigned long index;
 	void *client_data;
 	int ret;
@@ -424,10 +422,12 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 	ret = rename_compat_devs(ibdev);
 
 	downgrade_write(&devices_rwsem);
+	rdn = rdma_net_to_dev_net(read_pnet(&ibdev->coredev.rdma_net));
+
 	down_read(&ibdev->client_data_rwsem);
 	xan_for_each_marked(&ibdev->client_data, index, client_data,
 			    CLIENT_DATA_REGISTERED) {
-		struct ib_client *client = xa_load(&clients, index);
+		struct ib_client *client = xa_load(&rdn->rdn_clients, index);
 
 		if (!client || !client->rename)
 			continue;
@@ -504,6 +504,7 @@ static void ib_device_release(struct device *device)
 
 	xa_destroy(&dev->compat_devs);
 	xa_destroy(&dev->client_data);
+	xa_destroy(&dev->net_client_data);
 	kfree_rcu(dev, rcu_head);
 }
 
@@ -594,6 +595,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 	 * destroyed if the user stores NULL in the client data.
 	 */
 	xa_init_flags(&device->client_data, XA_FLAGS_ALLOC);
+	xa_init_flags(&device->net_client_data, XA_FLAGS_ALLOC);
 	init_rwsem(&device->client_data_rwsem);
 	xa_init_flags(&device->compat_devs, XA_FLAGS_ALLOC);
 	mutex_init(&device->compat_devs_mutex);
@@ -631,6 +633,7 @@ void ib_dealloc_device(struct ib_device *device)
 
 	WARN_ON(!xa_empty(&device->compat_devs));
 	WARN_ON(!xa_empty(&device->client_data));
+	WARN_ON(!xa_empty(&device->net_client_data));
 	WARN_ON(refcount_read(&device->refcount));
 	rdma_restrack_clean(device);
 	/* Balances with device_initialize */
@@ -647,8 +650,9 @@ EXPORT_SYMBOL(ib_dealloc_device);
  * or remove is fully completed.
  */
 static int add_client_context(struct ib_device *device,
-			      struct ib_client *client)
+			      struct ib_client *client, bool net_client)
 {
+	struct xarray *cl_data;
 	int ret = 0;
 
 	if (!device->kverbs_provider && !client->no_kverbs_req)
@@ -663,16 +667,20 @@ static int add_client_context(struct ib_device *device,
 		goto out_unlock;
 	refcount_inc(&device->refcount);
 
+	if (net_client)
+		cl_data = &device->net_client_data;
+	else
+		cl_data = &device->client_data;
+
 	/*
 	 * Another caller to add_client_context got here first and has already
 	 * completely initialized context.
 	 */
-	if (xa_get_mark(&device->client_data, client->client_id,
+	if (xa_get_mark(cl_data, client->client_id,
 		    CLIENT_DATA_REGISTERED))
 		goto out;
 
-	ret = xa_err(xa_store(&device->client_data, client->client_id, NULL,
-			      GFP_KERNEL));
+	ret = xa_err(xa_store(cl_data, client->client_id, NULL, GFP_KERNEL));
 	if (ret)
 		goto out;
 	downgrade_write(&device->client_data_rwsem);
@@ -692,8 +700,7 @@ static int add_client_context(struct ib_device *device,
 	}
 
 	/* Readers shall not see a client until add has been completed */
-	xa_set_mark(&device->client_data, client->client_id,
-		    CLIENT_DATA_REGISTERED);
+	xa_set_mark(cl_data, client->client_id, CLIENT_DATA_REGISTERED);
 	up_read(&device->client_data_rwsem);
 	return 0;
 
@@ -706,20 +713,26 @@ static int add_client_context(struct ib_device *device,
 }
 
 static void remove_client_context(struct ib_device *device,
-				  unsigned int client_id)
+				  unsigned int client_id,
+				  struct rdma_dev_net *rdn, bool net_client)
 {
 	struct ib_client *client;
+	struct xarray *cl_data;
 	void *client_data;
 
+	if (net_client)
+		cl_data = &device->net_client_data;
+	else
+		cl_data = &device->client_data;
+
 	down_write(&device->client_data_rwsem);
-	if (!xa_get_mark(&device->client_data, client_id,
-			 CLIENT_DATA_REGISTERED)) {
+	if (!xa_get_mark(cl_data, client_id, CLIENT_DATA_REGISTERED)) {
 		up_write(&device->client_data_rwsem);
 		return;
 	}
-	client_data = xa_load(&device->client_data, client_id);
-	xa_clear_mark(&device->client_data, client_id, CLIENT_DATA_REGISTERED);
-	client = xa_load(&clients, client_id);
+	client_data = xa_load(cl_data, client_id);
+	xa_clear_mark(cl_data, client_id, CLIENT_DATA_REGISTERED);
+	client = xa_load(&rdn->rdn_clients, client_id);
 	up_write(&device->client_data_rwsem);
 
 	/*
@@ -734,7 +747,10 @@ static void remove_client_context(struct ib_device *device,
 	if (client->remove)
 		client->remove(device, client_data);
 
-	xa_erase(&device->client_data, client_id);
+	if (client->net_client)
+		xa_erase(&device->net_client_data, client_id);
+	else
+		xa_erase(&device->client_data, client_id);
 	ib_device_put(device);
 	ib_client_put(client);
 }
@@ -924,6 +940,7 @@ static int add_one_compat_dev(struct ib_device *device,
 		goto insert_err;
 
 	mutex_unlock(&device->compat_devs_mutex);
+
 	return 0;
 
 insert_err:
@@ -1099,6 +1116,9 @@ static void rdma_dev_exit_net(struct net *net)
 
 	rdma_nl_net_exit(rnet);
 	xa_erase(&rdma_nets, rnet->id);
+
+	WARN_ON(!xa_empty(&rnet->rdn_clients));
+	xa_destroy(&rnet->rdn_clients);
 }
 
 static __net_init int rdma_dev_init_net(struct net *net)
@@ -1114,6 +1134,9 @@ static __net_init int rdma_dev_init_net(struct net *net)
 	if (ret)
 		return ret;
 
+	xa_init_flags(&rnet->rdn_clients, XA_FLAGS_ALLOC);
+	init_rwsem(&rnet->rdn_clients_rwsem);
+
 	/* No need to create any compat devices in default init_net. */
 	if (net_eq(net, &init_net))
 		return 0;
@@ -1263,9 +1286,14 @@ static int setup_device(struct ib_device *device)
 
 static void disable_device(struct ib_device *device)
 {
+	struct rdma_dev_net *init_rdn, *rdn;
+	struct net *net;
 	u32 cid;
 
 	WARN_ON(!refcount_read(&device->refcount));
+	init_rdn = rdma_net_to_dev_net(&init_net);
+	net = read_pnet(&device->coredev.rdma_net);
+	rdn = rdma_net_to_dev_net(net);
 
 	down_write(&devices_rwsem);
 	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
@@ -1277,12 +1305,21 @@ static void disable_device(struct ib_device *device)
 	 * clients can be added to this ib_device past this point we only need
 	 * the maximum possible client_id value here.
 	 */
-	down_read(&clients_rwsem);
-	cid = highest_client_id;
-	up_read(&clients_rwsem);
+	down_read(&init_rdn->rdn_clients_rwsem);
+	cid = init_rdn->rdn_highest_client_id;
+	up_read(&init_rdn->rdn_clients_rwsem);
 	while (cid) {
 		cid--;
-		remove_client_context(device, cid);
+		remove_client_context(device, cid, init_rdn, false);
+	}
+
+	rdn = rdma_net_to_dev_net(net);
+	down_read(&rdn->rdn_clients_rwsem);
+	cid = rdn->rdn_highest_client_id;
+	up_read(&rdn->rdn_clients_rwsem);
+	while (cid) {
+		cid--;
+		remove_client_context(device, cid, rdn, true);
 	}
 
 	/* Pairs with refcount_set in enable_device */
@@ -1297,6 +1334,26 @@ static void disable_device(struct ib_device *device)
 	remove_compat_devs(device);
 }
 
+static int add_net_client_context(struct rdma_dev_net *rdn,
+				  struct ib_device *device, bool net_client)
+{
+	struct ib_client *client;
+	unsigned long index;
+	int ret = 0;
+
+	down_read(&rdn->rdn_clients_rwsem);
+	xa_for_each_marked(&rdn->rdn_clients, index, client,
+			   CLIENT_REGISTERED) {
+		if (client->net_client == net_client)
+			ret = add_client_context(device, client, net_client);
+		if (ret)
+			break;
+	}
+	up_read(&rdn->rdn_clients_rwsem);
+
+	return ret;
+}
+
 /*
  * An enabled device is visible to all clients and to all the public facing
  * APIs that return a device pointer. This always returns with a new get, even
@@ -1304,8 +1361,8 @@ static void disable_device(struct ib_device *device)
  */
 static int enable_device_and_get(struct ib_device *device)
 {
-	struct ib_client *client;
-	unsigned long index;
+	struct rdma_dev_net *rdn;
+	struct net *net;
 	int ret = 0;
 
 	/*
@@ -1321,20 +1378,27 @@ static int enable_device_and_get(struct ib_device *device)
 	 * DEVICE_REGISTERED while we are completing the client setup.
 	 */
 	downgrade_write(&devices_rwsem);
-
 	if (device->ops.enable_driver) {
 		ret = device->ops.enable_driver(device);
 		if (ret)
 			goto out;
 	}
 
-	down_read(&clients_rwsem);
-	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
-		ret = add_client_context(device, client);
-		if (ret)
-			break;
-	}
-	up_read(&clients_rwsem);
+	/* For backward compatibility, always add client context for all "old"
+	 * registered clients using ib_register_client().
+	 */
+	rdn = rdma_net_to_dev_net(&init_net);
+	ret = add_net_client_context(rdn, device, false);
+	if (ret)
+		goto out;
+
+	/* Now add client context for clients registered using
+	 * rdma_register_net_client().
+	 */
+	net = read_pnet(&device->coredev.rdma_net);
+	rdn = rdma_net_to_dev_net(net);
+	ret = add_net_client_context(rdn, device, true);
+
 	if (!ret)
 		ret = add_compat_devs(device);
 out:
@@ -1711,37 +1775,49 @@ static struct pernet_operations rdma_dev_net_ops = {
 	.size = sizeof(struct rdma_dev_net),
 };
 
-static int assign_client_id(struct ib_client *client)
+static int assign_client_id(struct net *net, struct ib_client *client,
+			    bool net_client)
 {
+	struct rdma_dev_net *rdn;
 	int ret;
 
-	down_write(&clients_rwsem);
+	rdn = rdma_net_to_dev_net(net);
+
+	down_write(&rdn->rdn_clients_rwsem);
+
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
 	 * registration order.
 	 */
-	client->client_id = highest_client_id;
-	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
+	client->client_id = rdn->rdn_highest_client_id;
+	ret = xa_insert(&rdn->rdn_clients, client->client_id, client,
+			GFP_KERNEL);
 	if (ret)
 		goto out;
 
-	highest_client_id++;
-	xa_set_mark(&clients, client->client_id, CLIENT_REGISTERED);
+	rdn->rdn_highest_client_id++;
+	xa_set_mark(&rdn->rdn_clients, client->client_id, CLIENT_REGISTERED);
+	client->net_client = net_client;
 
 out:
-	up_write(&clients_rwsem);
+	up_write(&rdn->rdn_clients_rwsem);
 	return ret;
 }
 
-static void remove_client_id(struct ib_client *client)
+static void remove_client_id(struct net *net, struct ib_client *client)
 {
-	down_write(&clients_rwsem);
-	xa_erase(&clients, client->client_id);
-	for (; highest_client_id; highest_client_id--)
-		if (xa_load(&clients, highest_client_id - 1))
+	struct rdma_dev_net *rdn;
+	struct xarray *clients;
+
+	rdn = rdma_net_to_dev_net(net);
+	clients = &rdn->rdn_clients;
+	down_write(&rdn->rdn_clients_rwsem);
+	xa_erase(clients, client->client_id);
+	for (; rdn->rdn_highest_client_id; rdn->rdn_highest_client_id--)
+		if (xa_load(clients, rdn->rdn_highest_client_id - 1))
 			break;
-	up_write(&clients_rwsem);
+	up_write(&rdn->rdn_clients_rwsem);
 }
 
 /**
@@ -1765,13 +1841,13 @@ int ib_register_client(struct ib_client *client)
 
 	refcount_set(&client->uses, 1);
 	init_completion(&client->uses_zero);
-	ret = assign_client_id(client);
+	ret = assign_client_id(&init_net, client, false);
 	if (ret)
 		return ret;
 
 	down_read(&devices_rwsem);
 	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
-		ret = add_client_context(device, client);
+		ret = add_client_context(device, client, false);
 		if (ret) {
 			up_read(&devices_rwsem);
 			ib_unregister_client(client);
@@ -1783,6 +1859,34 @@ int ib_register_client(struct ib_client *client)
 }
 EXPORT_SYMBOL(ib_register_client);
 
+int rdma_register_net_client(struct net *net, struct ib_client *client)
+{
+	struct ib_device *device;
+	unsigned long index;
+	int ret;
+
+	refcount_set(&client->uses, 1);
+	init_completion(&client->uses_zero);
+	ret = assign_client_id(net, client, true);
+	if (ret)
+		return ret;
+
+	down_read(&devices_rwsem);
+	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
+		if (!net_eq(net, read_pnet(&device->coredev.rdma_net)))
+			continue;
+		ret = add_client_context(device, client, true);
+		if (ret) {
+			up_read(&devices_rwsem);
+			rdma_unregister_net_client(net, client);
+			return ret;
+		}
+	}
+	up_read(&devices_rwsem);
+	return 0;
+}
+EXPORT_SYMBOL(rdma_register_net_client);
+
 /**
  * ib_unregister_client - Unregister an IB client
  * @client:Client to unregister
@@ -1797,12 +1901,14 @@ EXPORT_SYMBOL(ib_register_client);
 void ib_unregister_client(struct ib_client *client)
 {
 	struct ib_device *device;
+	struct rdma_dev_net *rdn;
 	unsigned long index;
 
-	down_write(&clients_rwsem);
+	rdn = rdma_net_to_dev_net(&init_net);
+	down_write(&rdn->rdn_clients_rwsem);
 	ib_client_put(client);
-	xa_clear_mark(&clients, client->client_id, CLIENT_REGISTERED);
-	up_write(&clients_rwsem);
+	xa_clear_mark(&rdn->rdn_clients, client->client_id, CLIENT_REGISTERED);
+	up_write(&rdn->rdn_clients_rwsem);
 
 	/* We do not want to have locks while calling client->remove() */
 	rcu_read_lock();
@@ -1811,7 +1917,7 @@ void ib_unregister_client(struct ib_client *client)
 			continue;
 		rcu_read_unlock();
 
-		remove_client_context(device, client->client_id);
+		remove_client_context(device, client->client_id, rdn, false);
 
 		ib_device_put(device);
 		rcu_read_lock();
@@ -1823,19 +1929,58 @@ void ib_unregister_client(struct ib_client *client)
 	 * removal is ongoing. Wait until all removals are completed.
 	 */
 	wait_for_completion(&client->uses_zero);
-	remove_client_id(client);
+	remove_client_id(&init_net, client);
 }
 EXPORT_SYMBOL(ib_unregister_client);
 
+void rdma_unregister_net_client(struct net *net, struct ib_client *client)
+{
+	struct ib_device *device;
+	struct rdma_dev_net *rdn;
+	unsigned long index;
+
+	rdn = rdma_net_to_dev_net(net);
+	down_write(&rdn->rdn_clients_rwsem);
+	ib_client_put(client);
+	xa_clear_mark(&rdn->rdn_clients, client->client_id, CLIENT_REGISTERED);
+	up_write(&rdn->rdn_clients_rwsem);
+
+	/* We do not want to have locks while calling client->remove() */
+	rcu_read_lock();
+	xa_for_each (&devices, index, device) {
+		if (!ib_device_try_get(device))
+			continue;
+		rcu_read_unlock();
+
+		remove_client_context(device, client->client_id, rdn, true);
+
+		ib_device_put(device);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+	/*
+	 * remove_client_context() is not a fence, it can return even though a
+	 * removal is ongoing. Wait until all removals are completed.
+	 */
+	wait_for_completion(&client->uses_zero);
+	remove_client_id(net, client);
+}
+EXPORT_SYMBOL(rdma_unregister_net_client);
+
 static int __ib_get_global_client_nl_info(const char *client_name,
 					  struct ib_client_nl_info *res)
 {
 	struct ib_client *client;
+	struct rdma_dev_net *rdn;
 	unsigned long index;
 	int ret = -ENOENT;
 
-	down_read(&clients_rwsem);
-	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
+	/* No network namespace info available... */
+	rdn = rdma_net_to_dev_net(&init_net);
+	down_read(&rdn->rdn_clients_rwsem);
+	xa_for_each_marked (&rdn->rdn_clients, index, client,
+			    CLIENT_REGISTERED) {
 		if (strcmp(client->name, client_name) != 0)
 			continue;
 		if (!client->get_global_nl_info) {
@@ -1849,7 +1994,7 @@ static int __ib_get_global_client_nl_info(const char *client_name,
 			get_device(res->cdev);
 		break;
 	}
-	up_read(&clients_rwsem);
+	up_read(&rdn->rdn_clients_rwsem);
 	return ret;
 }
 
@@ -1857,14 +2002,24 @@ static int __ib_get_client_nl_info(struct ib_device *ibdev,
 				   const char *client_name,
 				   struct ib_client_nl_info *res)
 {
+	struct xarray *cl_data, *cls;
+	struct rdma_dev_net *rdn;
 	unsigned long index;
 	void *client_data;
 	int ret = -ENOENT;
 
 	down_read(&ibdev->client_data_rwsem);
-	xan_for_each_marked (&ibdev->client_data, index, client_data,
+	if (ib_devices_shared_netns) {
+		rdn = rdma_net_to_dev_net(&init_net);
+		cl_data = &ibdev->client_data;
+	} else {
+		rdn = rdma_net_to_dev_net(read_pnet(&ibdev->coredev.rdma_net));
+		cl_data = &ibdev->net_client_data;
+	}
+	cls = &rdn->rdn_clients;
+	xan_for_each_marked (cl_data, index, client_data,
 			     CLIENT_DATA_REGISTERED) {
-		struct ib_client *client = xa_load(&clients, index);
+		struct ib_client *client = xa_load(cls, index);
 
 		if (!client || strcmp(client->name, client_name) != 0)
 			continue;
@@ -1939,13 +2094,17 @@ int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
 void ib_set_client_data(struct ib_device *device, struct ib_client *client,
 			void *data)
 {
+	struct xarray *cl_data;
 	void *rc;
 
 	if (WARN_ON(IS_ERR(data)))
 		data = NULL;
 
-	rc = xa_store(&device->client_data, client->client_id, data,
-		      GFP_KERNEL);
+	if (client->net_client)
+		cl_data = &device->net_client_data;
+	else
+		cl_data = &device->client_data;
+	rc = xa_store(cl_data, client->client_id, data, GFP_KERNEL);
 	WARN_ON(xa_is_err(rc));
 }
 EXPORT_SYMBOL(ib_set_client_data);
@@ -2523,20 +2682,27 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev,
 					    const struct sockaddr *addr)
 {
 	struct net_device *net_dev = NULL;
+	struct rdma_dev_net *init_rdn, *rdn;
 	unsigned long index;
 	void *client_data;
 
 	if (!rdma_protocol_ib(dev, port))
 		return NULL;
 
+	init_rdn = rdma_net_to_dev_net(&init_net);
+	rdn = rdma_net_to_dev_net(read_pnet(&dev->coredev.rdma_net));
 	/*
 	 * Holding the read side guarantees that the client will not become
 	 * unregistered while we are calling get_net_dev_by_params()
 	 */
 	down_read(&dev->client_data_rwsem);
+	/* First try all the non-net registered clients, and then the net
+	 * registered clients.
+	 */
 	xan_for_each_marked (&dev->client_data, index, client_data,
 			     CLIENT_DATA_REGISTERED) {
-		struct ib_client *client = xa_load(&clients, index);
+		struct ib_client *client = xa_load(&init_rdn->rdn_clients,
+						   index);
 
 		if (!client || !client->get_net_dev_by_params)
 			continue;
@@ -2546,6 +2712,22 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev,
 		if (net_dev)
 			break;
 	}
+	if (!net_dev) {
+		xan_for_each_marked(&dev->net_client_data, index, client_data,
+				     CLIENT_DATA_REGISTERED) {
+			struct ib_client *client = xa_load(&rdn->rdn_clients,
+							   index);
+
+			if (!client || !client->get_net_dev_by_params)
+				continue;
+
+			net_dev = client->get_net_dev_by_params(dev, port,
+								pkey, gid, addr,
+								client_data);
+			if (net_dev)
+				break;
+		}
+	}
 	up_read(&dev->client_data_rwsem);
 
 	return net_dev;
@@ -2749,6 +2931,12 @@ static int __init ib_core_init(void)
 
 	rdma_nl_init();
 
+	ret = register_pernet_device(&rdma_dev_net_ops);
+	if (ret) {
+		pr_warn("Couldn't init compat dev. ret %d\n", ret);
+		goto err_compat;
+	}
+
 	ret = addr_init();
 	if (ret) {
 		pr_warn("Couldn't init IB address resolution\n");
@@ -2773,12 +2961,6 @@ static int __init ib_core_init(void)
 		goto err_sa;
 	}
 
-	ret = register_pernet_device(&rdma_dev_net_ops);
-	if (ret) {
-		pr_warn("Couldn't init compat dev. ret %d\n", ret);
-		goto err_compat;
-	}
-
 	nldev_init();
 	rdma_nl_register(RDMA_NL_LS, ibnl_ls_cb_table);
 	roce_gid_mgmt_init();
@@ -2809,11 +2991,11 @@ static void __exit ib_core_cleanup(void)
 	roce_gid_mgmt_cleanup();
 	nldev_exit();
 	rdma_nl_unregister(RDMA_NL_LS);
-	unregister_pernet_device(&rdma_dev_net_ops);
 	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
 	ib_sa_cleanup();
 	ib_mad_cleanup();
 	addr_cleanup();
+	unregister_pernet_device(&rdma_dev_net_ops);
 	rdma_nl_exit();
 	class_unregister(&ib_class);
 	destroy_workqueue(ib_comp_unbound_wq);
@@ -2821,7 +3003,6 @@ static void __exit ib_core_cleanup(void)
 	/* Make sure that any pending umem accounting work is done. */
 	destroy_workqueue(ib_wq);
 	flush_workqueue(system_unbound_wq);
-	WARN_ON(!xa_empty(&clients));
 	WARN_ON(!xa_empty(&devices));
 }
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c0b2fa7e9b95..1f3f497a870a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2729,6 +2729,9 @@ struct ib_device {
 	char iw_ifname[IFNAMSIZ];
 	u32 iw_driver_flags;
 	u32 lag_flags;
+
+	/* Also protected by client_data_rwsem */
+	struct xarray			net_client_data;
 };
 
 struct ib_client_nl_info;
@@ -2770,6 +2773,7 @@ struct ib_client {
 
 	/* kverbs are not required by the client */
 	u8 no_kverbs_req:1;
+	u8 net_client:1;
 };
 
 /*
@@ -2807,6 +2811,9 @@ void ib_unregister_device_queued(struct ib_device *ib_dev);
 int ib_register_client   (struct ib_client *client);
 void ib_unregister_client(struct ib_client *client);
 
+int rdma_register_net_client(struct net *net, struct ib_client *client);
+void rdma_unregister_net_client(struct net *net, struct ib_client *client);
+
 void __rdma_block_iter_start(struct ib_block_iter *biter,
 			     struct scatterlist *sglist,
 			     unsigned int nents,
@@ -2852,7 +2859,10 @@ rdma_block_iter_dma_address(struct ib_block_iter *biter)
 static inline void *ib_get_client_data(struct ib_device *device,
 				       struct ib_client *client)
 {
-	return xa_load(&device->client_data, client->client_id);
+	if (client->net_client) 
+		return xa_load(&device->net_client_data, client->client_id);
+	else
+		return xa_load(&device->client_data, client->client_id);
 }
 void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 			 void *data);

--------------BE11F2B46F009C6EF46DCF0D--
