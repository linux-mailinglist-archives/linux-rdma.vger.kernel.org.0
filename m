Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF127091D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgIRXR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:17:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14640 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRXR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 19:17:26 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f653fab0000>; Fri, 18 Sep 2020 16:15:55 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:17:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:17:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgdqHFlHx2+fd/0doyDMOhIwKyfWE89Uafn8vVxQMjaPUptvC2fm1NEeDj3csKF6M3gY3RXe+ktLgqp0IaJhXoUEQw7GsP2zMx04ha/LdL48Y8RCwhEjgX40Q/IvM7KYsULQAynUetxSSvwec0G8+ry1asqXumJulDdiWOf+W9hGV55L2fdAtvjhaL0pSvE+F4sB2doZVNxAERIv1AxT7aRK7+JRDXYhGmRaC8w42hxhgPL6b/omdmJcYmy1s0y+tvWKQ+r0OUuAMZKEoLZLnuGohiClScRggVd5UeEkzWX0yhtAgOEmF13jGqiSXAE6Uux5BnWjamvbbafsQL19lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI8o+UhbGtIV6mxaDqO8TrLXkp1ZFhOS1ISJpt4a3z4=;
 b=juGeBaOjUlLN1jKdmeljHHG0zle8aDXFLs/xclmaz6WuVKIa/x3x/85Qvt0/Y1WGuQXdwEaLkc1UY3UBJnmLmmKneKHgsy3b9bWpWsj49Sgt3SxtT11D6A5BDQHP+FbB9J9RvuaYYO0TgDLqLBFvjSaOVeNRxf50sP6KeWoaT/gdQCRsv1nKb/jEaPnbRkJm5PtE9f1oyIbXjONVBwkHlqur4mp5cRK7/7ZRCx8fi5YROht11lHd6e9ENphF9wQ26mUAM3mThvYGGEY3xIC1yIiwUUdiSEL/ofvHRSUVh9+RrzB5O1/ZjgTE45uE2Cv7lTplPPETTM6LoIAFr2Jt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 23:17:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:17:23 +0000
Date:   Fri, 18 Sep 2020 20:17:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 06/14] RDMA/restrack: Improve readability in
 task name management
Message-ID: <20200918231721.GA374249@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-7-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-7-leon@kernel.org>
X-ClientProxiedBy: MN2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:208:a8::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0012.namprd12.prod.outlook.com (2603:10b6:208:a8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 23:17:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJPd3-001tIK-Ji; Fri, 18 Sep 2020 20:17:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d2a1b1-171c-4bf1-90cc-08d85c28ffa2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12431C44582B7C2319E0E8BFC23F0@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F81zvbwW/CdJVXxcFLT3ZB5EGd3XCKM8rvUDs4YrHh+f2mJmC5R09V9XZORz3FQm4zFv432XcLEL+eAW0kCKuNLVLSNPo5cuySaF3FGLpllIzkYV7XkKIeus5AlofvdtZqvVy7CdxUTWN7D+gYH0pt281gSg91IKXVEuu1dMSvAUAiu2LlBeYlYtQ4tDrMks4eU0UlOM6w26Wsgor6sPV/ou8oK28M+mNllH6AD7g2cnAtngcxJZ4vYHrTqwMbW86nTVxXVOV7O9wq/J0+6INV99BaancGV2rIN8srql69rvgjScu3ybbtmppeGBOWzx6eKWRCf92xKu80YTIF2z2Gef3nd7+lG1B1FCAahBYRdCyNKC4mcj1fKLe8B1bh+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(83380400001)(33656002)(2906002)(426003)(2616005)(36756003)(9786002)(9746002)(186003)(54906003)(30864003)(1076003)(26005)(86362001)(8676002)(66476007)(4326008)(6916009)(8936002)(478600001)(66946007)(316002)(5660300002)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NyAS7QHFrsFWqPVdC3UXO2x5KRL9Dzis95Oy94d0LSOLaj9yqzvsiux9Kz+VAy4i43mQT3//GaTcM/YxjTaCkmO345V4szvDQubFFaIvZYx+uWLvKNMHWnZgWGGsY9L1GX9I7Tv8XLa7kGH41O5ra07w24/v0vjIk/1DTOuh8g7CfmBRIUZJjKQp65qSDal/XoWbQhwJwBN+or9IbUN3guvIs+UAdK7MVBnIMg39ahHl3XFU38dfSoj9X7HY6amTBoTYI3w7VQSAAtmct84wRQDz65POE+jvOi2oi9p6PXP88Gub3DtP9gTdSX0ZUt9xeiSuAlYGVzRprOM6nsM9xMd3B2DCEz3N65AYHmcCFlWNqYOLuSPoO6dY+SNrbflDsebt+bhBlFr/RNoDj/Ig9zJd+1w08dO0I/FSvi/rH/vftajccJcBAdGM4v6JocehCCykdjMFzrPvNmdoy35z+/d+Jm++oszVImT8fRU2JIRvee0WfrWk9H3EMDK8ggdF2VTmVPiqOgQocrLDK+k+N6K0HUTc8CJzW8KbEL58JJ42B+PjqkjHCjAdK5S/B5hanPp3KmnYK20ZvmKQ43SxJULpEs3BR9pn4pa2jSAQqfkdnH5MUZkWkm0nlLUZJwVuvtSlCE18BI/R+8dAuZNGOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d2a1b1-171c-4bf1-90cc-08d85c28ffa2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:17:23.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGH9H/oQB0Vsk+19vR1LJ8tU+itAyULdGdNRmuToOJ5wZGRj1uGFhJ/Xqqmj6NVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600470955; bh=OI8o+UhbGtIV6mxaDqO8TrLXkp1ZFhOS1ISJpt4a3z4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=V7l0swd574rl9CUDHRaG6sorcq4+J1BLVCOxMRV7CMb/EYIABvQRzBnS0Vry1fdL6
         r+9gCzHv45K/asI2HgJq04kbRhtyNjqFTAxDi44Gm45vRfx9e8lMAkx7AQuEQWr9L/
         Dk427MzZAwKqR6z4E3iYxBvZs5d919xTnCbKXoNkXvKGCZnu2nCwjb8Pk1gbsDmcK3
         3JTABtHNUIiu4WWN8wOSZDSI42F3vqU0Urjrp4Oc/NyOKmeoA9/Xbpaopaum7CpaE2
         0+OyRTD/iwJoaD3A+RLH9IgH+Sn2fi6HyUfYbDDYPJxJn96O4wuw+IYc/1+Ch3s1rt
         S1koGBsJR48IQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:48PM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index feed3c04979a..3fc3c821743d 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -467,10 +467,13 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
>  	id_priv->id.route.addr.dev_addr.transport =
>  		rdma_node_get_transport(cma_dev->device->node_type);
>  	list_add_tail(&id_priv->list, &cma_dev->id_list);
> -	if (id_priv->res.kern_name)
> -		rdma_restrack_add(&id_priv->res);
> -	else
> -		rdma_restrack_uadd(&id_priv->res);
> +	/*
> +	 * For example UCMA doesn't set kern_name and below function will
> +	 * attach to "current" task.
> +	 */
> +	rdma_restrack_set_name(&id_priv->res, id_priv->res.kern_name);
> +	rdma_restrack_add(&id_priv->res);

I don't understand why the set_name was added here, looks wrong. For
the non-null case we either already have a task set because
rdma_create_id did it, or this is spawned from a listening_id and this
is WQ, so no reason to capture a WQ as the task.

I suppose the idea is that the rdma_restrack_set_name() in
rdma_accept() fixes this, but that isn't allowed either, there is no
locking so calling rdma_restrack_set_name() after rdma_restrack_add()
can't be done.

Without adding a bunch of locking someplace I think everything must
flow from the orignial rdma_cm_listen which was created in a
reasonable context, ie instead of passing name around the parent
restrack should be passed.

I came up with something like this

Can you put this and the patches here in a series please, up to this
patch all looks OK otherwise.

Jason

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index aecc60a5f8c3fe..b123811f33234a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -457,7 +457,6 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	 * For example UCMA doesn't set kern_name and below function will
 	 * attach to "current" task.
 	 */
-	rdma_restrack_set_name(&id_priv->res, id_priv->res.kern_name);
 	rdma_restrack_add(&id_priv->res);
 
 	trace_cm_id_attach(id_priv, cma_dev->device);
@@ -825,10 +824,10 @@ static void cma_id_put(struct rdma_id_private *id_priv)
 		complete(&id_priv->comp);
 }
 
-struct rdma_cm_id *__rdma_create_id(struct net *net,
-				    rdma_cm_event_handler event_handler,
-				    void *context, enum rdma_ucm_port_space ps,
-				    enum ib_qp_type qp_type, const char *caller)
+static struct rdma_id_private *
+__rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
+		 void *context, enum rdma_ucm_port_space ps,
+		 enum ib_qp_type qp_type, const struct rdma_id_private *parent)
 {
 	struct rdma_id_private *id_priv;
 
@@ -856,11 +855,44 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->seq_num &= 0x00ffffff;
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
-	rdma_restrack_set_name(&id_priv->res, caller);
+	if (parent)
+		rdma_restrack_parent_name(&id_priv->res, &parent->res);
 
-	return &id_priv->id;
+	return id_priv;
+}
+
+struct rdma_cm_id *
+__rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
+			void *context, enum rdma_ucm_port_space ps,
+			enum ib_qp_type qp_type, const char *caller)
+{
+	struct rdma_id_private *ret;
+
+	ret = __rdma_create_id(net, event_handler, context, ps, qp_type, NULL);
+	if (IS_ERR(ret))
+		return ERR_CAST(ret);
+
+	rdma_restrack_set_name(&ret->res, caller);
+	return &ret->id;
+}
+EXPORT_SYMBOL(__rdma_create_kernel_id);
+
+struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
+				       void *context,
+				       enum rdma_ucm_port_space ps,
+				       enum ib_qp_type qp_type)
+{
+	struct rdma_id_private *ret;
+
+	ret = __rdma_create_id(current->nsproxy->net_ns, event_handler, context,
+			       ps, qp_type, NULL);
+	if (IS_ERR(ret))
+		return ERR_CAST(ret);
+
+	rdma_restrack_set_name(&ret->res, NULL);
+	return &ret->id;
 }
-EXPORT_SYMBOL(__rdma_create_id);
+EXPORT_SYMBOL(rdma_create_user_id);
 
 static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
 {
@@ -2032,14 +2064,15 @@ cma_ib_new_conn_id(const struct rdma_cm_id *listen_id,
 	int ret;
 
 	listen_id_priv = container_of(listen_id, struct rdma_id_private, id);
-	id = __rdma_create_id(listen_id->route.addr.dev_addr.net,
-			    listen_id->event_handler, listen_id->context,
-			    listen_id->ps, ib_event->param.req_rcvd.qp_type,
-			    listen_id_priv->res.kern_name);
-	if (IS_ERR(id))
+	id_priv = __rdma_create_id(listen_id->route.addr.dev_addr.net,
+				   listen_id->event_handler, listen_id->context,
+				   listen_id->ps,
+				   ib_event->param.req_rcvd.qp_type,
+				   listen_id_priv);
+	if (IS_ERR(id_priv))
 		return NULL;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
+	id = &id_priv->id;
 	if (cma_save_net_info((struct sockaddr *)&id->route.addr.src_addr,
 			      (struct sockaddr *)&id->route.addr.dst_addr,
 			      listen_id, ib_event, ss_family, service_id))
@@ -2093,13 +2126,13 @@ cma_ib_new_udp_id(const struct rdma_cm_id *listen_id,
 	int ret;
 
 	listen_id_priv = container_of(listen_id, struct rdma_id_private, id);
-	id = __rdma_create_id(net, listen_id->event_handler, listen_id->context,
-			      listen_id->ps, IB_QPT_UD,
-			      listen_id_priv->res.kern_name);
-	if (IS_ERR(id))
+	id_priv = __rdma_create_id(net, listen_id->event_handler,
+				   listen_id->context, listen_id->ps, IB_QPT_UD,
+				   listen_id_priv);
+	if (IS_ERR(id_priv))
 		return NULL;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
+	id = &id_priv->id;
 	if (cma_save_net_info((struct sockaddr *)&id->route.addr.src_addr,
 			      (struct sockaddr *)&id->route.addr.dst_addr,
 			      listen_id, ib_event, ss_family,
@@ -2335,7 +2368,6 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 			       struct iw_cm_event *iw_event)
 {
-	struct rdma_cm_id *new_cm_id;
 	struct rdma_id_private *listen_id, *conn_id;
 	struct rdma_cm_event event = {};
 	int ret = -ECONNABORTED;
@@ -2355,16 +2387,14 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 		goto out;
 
 	/* Create a new RDMA id for the new IW CM ID */
-	new_cm_id = __rdma_create_id(listen_id->id.route.addr.dev_addr.net,
-				     listen_id->id.event_handler,
-				     listen_id->id.context,
-				     RDMA_PS_TCP, IB_QPT_RC,
-				     listen_id->res.kern_name);
-	if (IS_ERR(new_cm_id)) {
+	conn_id = __rdma_create_id(listen_id->id.route.addr.dev_addr.net,
+				   listen_id->id.event_handler,
+				   listen_id->id.context, RDMA_PS_TCP,
+				   IB_QPT_RC, listen_id);
+	if (IS_ERR(conn_id)) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	conn_id = container_of(new_cm_id, struct rdma_id_private, id);
 	mutex_lock_nested(&conn_id->handler_mutex, SINGLE_DEPTH_NESTING);
 	conn_id->state = RDMA_CM_CONNECT;
 
@@ -2469,7 +2499,6 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 			      struct cma_device *cma_dev)
 {
 	struct rdma_id_private *dev_id_priv;
-	struct rdma_cm_id *id;
 	struct net *net = id_priv->id.route.addr.dev_addr.net;
 	int ret;
 
@@ -2478,13 +2507,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
 		return;
 
-	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
-			      id_priv->id.qp_type, id_priv->res.kern_name);
-	if (IS_ERR(id))
+	dev_id_priv =
+		__rdma_create_id(net, cma_listen_handler, id_priv,
+				 id_priv->id.ps, id_priv->id.qp_type, id_priv);
+	if (IS_ERR(dev_id_priv))
 		return;
 
-	dev_id_priv = container_of(id, struct rdma_id_private, id);
-
 	dev_id_priv->state = RDMA_CM_ADDR_BOUND;
 	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
 	       rdma_addr_size(cma_src_addr(id_priv)));
@@ -2497,7 +2525,7 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	dev_id_priv->tos_set = id_priv->tos_set;
 	dev_id_priv->tos = id_priv->tos;
 
-	ret = rdma_listen(id, id_priv->backlog);
+	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
 	if (ret)
 		dev_warn(&cma_dev->device->dev,
 			 "RDMA CMA: cma_listen_on_dev, error %d\n", ret);
@@ -4152,8 +4180,25 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
 }
 
-int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		  const char *caller)
+/**
+ * rdma_accept - Called to accept a connection request or response.
+ * @id: Connection identifier associated with the request.
+ * @conn_param: Information needed to establish the connection.  This must be
+ *   provided if accepting a connection request.  If accepting a connection
+ *   response, this parameter must be NULL.
+ *
+ * Typically, this routine is only called by the listener to accept a connection
+ * request.  It must also be called on the active side of a connection if the
+ * user is performing their own QP transitions.
+ *
+ * In the case of error, a reject message is sent to the remote side and the
+ * state of the qp associated with the id is modified to error, such that any
+ * previously posted receive buffers would be flushed.
+ *
+ * This function is for use by kernel ULPs and must be called from under the
+ * handler callback.
+ */
+int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
 	struct rdma_id_private *id_priv =
 		container_of(id, struct rdma_id_private, id);
@@ -4161,8 +4206,6 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 
 	lockdep_assert_held(&id_priv->handler_mutex);
 
-	rdma_restrack_set_name(&id_priv->res, caller);
-
 	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		return -EINVAL;
 
@@ -4201,10 +4244,10 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 	rdma_reject(id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
 	return ret;
 }
-EXPORT_SYMBOL(__rdma_accept);
+EXPORT_SYMBOL(rdma_accept);
 
-int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		      const char *caller, struct rdma_ucm_ece *ece)
+int rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		    struct rdma_ucm_ece *ece)
 {
 	struct rdma_id_private *id_priv =
 		container_of(id, struct rdma_id_private, id);
@@ -4212,9 +4255,9 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 	id_priv->ece.vendor_id = ece->vendor_id;
 	id_priv->ece.attr_mod = ece->attr_mod;
 
-	return __rdma_accept(id, conn_param, caller);
+	return rdma_accept(id, conn_param);
 }
-EXPORT_SYMBOL(__rdma_accept_ece);
+EXPORT_SYMBOL(rdma_accept_ece);
 
 void rdma_lock_handler(struct rdma_cm_id *id)
 {
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 0c67acf2169d69..4aeeaaed0f17dd 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -189,7 +189,7 @@ EXPORT_SYMBOL(rdma_restrack_set_name);
  * @parent: parent resource entry
  */
 void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
-			       struct rdma_restrack_entry *parent)
+			       const struct rdma_restrack_entry *parent)
 {
 	if (rdma_is_kernel_res(parent))
 		dst->kern_name = parent->kern_name;
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 49c1d84cca2da4..6a04fc41f73801 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -32,5 +32,5 @@ void rdma_restrack_new(struct rdma_restrack_entry *res,
 void rdma_restrack_set_name(struct rdma_restrack_entry *res,
 			    const char *caller);
 void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
-			       struct rdma_restrack_entry *parent);
+			       const struct rdma_restrack_entry *parent);
 #endif /* _RDMA_CORE_RESTRACK_H_ */
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index a5595bd489b089..2901847a01021a 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -456,8 +456,7 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 		return -ENOMEM;
 
 	ctx->uid = cmd.uid;
-	cm_id = __rdma_create_id(current->nsproxy->net_ns,
-				 ucma_event_handler, ctx, cmd.ps, qp_type, NULL);
+	cm_id = rdma_create_user_id(ucma_event_handler, ctx, cmd.ps, qp_type);
 	if (IS_ERR(cm_id)) {
 		ret = PTR_ERR(cm_id);
 		goto err1;
@@ -1126,7 +1125,7 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
 		mutex_lock(&ctx->mutex);
 		rdma_lock_handler(ctx->cm_id);
-		ret = __rdma_accept_ece(ctx->cm_id, &conn_param, NULL, &ece);
+		ret = rdma_accept_ece(ctx->cm_id, &conn_param, &ece);
 		if (!ret) {
 			/* The uid must be set atomically with the handler */
 			ctx->uid = cmd.uid;
@@ -1136,7 +1135,7 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 	} else {
 		mutex_lock(&ctx->mutex);
 		rdma_lock_handler(ctx->cm_id);
-		ret = __rdma_accept_ece(ctx->cm_id, NULL, NULL, &ece);
+		ret = rdma_accept_ece(ctx->cm_id, NULL, &ece);
 		rdma_unlock_handler(ctx->cm_id);
 		mutex_unlock(&ctx->mutex);
 	}
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index c1334c9a7aa858..c672ae1da26bb5 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -110,11 +110,14 @@ struct rdma_cm_id {
 	u8			 port_num;
 };
 
-struct rdma_cm_id *__rdma_create_id(struct net *net,
-				    rdma_cm_event_handler event_handler,
-				    void *context, enum rdma_ucm_port_space ps,
-				    enum ib_qp_type qp_type,
-				    const char *caller);
+struct rdma_cm_id *
+__rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
+			void *context, enum rdma_ucm_port_space ps,
+			enum ib_qp_type qp_type, const char *caller);
+struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
+				       void *context,
+				       enum rdma_ucm_port_space ps,
+				       enum ib_qp_type qp_type);
 
 /**
  * rdma_create_id - Create an RDMA identifier.
@@ -132,9 +135,9 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
  * The event handler callback serializes on the id's mutex and is
  * allowed to sleep.
  */
-#define rdma_create_id(net, event_handler, context, ps, qp_type) \
-	__rdma_create_id((net), (event_handler), (context), (ps), (qp_type), \
-			 KBUILD_MODNAME)
+#define rdma_create_id(net, event_handler, context, ps, qp_type)               \
+	__rdma_create_kernel_id(net, event_handler, context, ps, qp_type,      \
+				KBUILD_MODNAME)
 
 /**
   * rdma_destroy_id - Destroys an RDMA identifier.
@@ -250,34 +253,12 @@ int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
  */
 int rdma_listen(struct rdma_cm_id *id, int backlog);
 
-int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		  const char *caller);
+int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
 
 void rdma_lock_handler(struct rdma_cm_id *id);
 void rdma_unlock_handler(struct rdma_cm_id *id);
-int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		      const char *caller, struct rdma_ucm_ece *ece);
-
-/**
- * rdma_accept - Called to accept a connection request or response.
- * @id: Connection identifier associated with the request.
- * @conn_param: Information needed to establish the connection.  This must be
- *   provided if accepting a connection request.  If accepting a connection
- *   response, this parameter must be NULL.
- *
- * Typically, this routine is only called by the listener to accept a connection
- * request.  It must also be called on the active side of a connection if the
- * user is performing their own QP transitions.
- *
- * In the case of error, a reject message is sent to the remote side and the
- * state of the qp associated with the id is modified to error, such that any
- * previously posted receive buffers would be flushed.
- *
- * This function is for use by kernel ULPs and must be called from under the
- * handler callback.
- */
-#define rdma_accept(id, conn_param) \
-	__rdma_accept((id), (conn_param),  KBUILD_MODNAME)
+int rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		    struct rdma_ucm_ece *ece);
 
 /**
  * rdma_notify - Notifies the RDMA CM of an asynchronous event that has
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 10bfed0fcd3262..d3a1cc5be7bcef 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -110,7 +110,7 @@ int rdma_restrack_count(struct ib_device *dev,
  * rdma_is_kernel_res() - check the owner of resource
  * @res:  resource entry
  */
-static inline bool rdma_is_kernel_res(struct rdma_restrack_entry *res)
+static inline bool rdma_is_kernel_res(const struct rdma_restrack_entry *res)
 {
 	return !res->user;
 }
