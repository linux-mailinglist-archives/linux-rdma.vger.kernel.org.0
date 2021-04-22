Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78E5368739
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDVTe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 15:34:57 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:5516
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236668AbhDVTe5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 15:34:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/+BIzK/X8gHhysUKiOCjYRQihmgNY7x0G5GuUpm6k9iq+hDUx40fEtdpF1LPxlxZX7NVGBFgHJ3uskhTyZTTHz7tuIThBa0/jF9kuReHwM4iE0WvyCEaX0rVWKPWItwNI82xBwhmxIUqj63Ux1D15BmmqnvyH6cMDn/bJzkAoV3b+AN7Nu8MBqTPCCgnQjVUQZ3XpcNPKNyeKeKEM4FjWxbFAYCeA6MQxD7A4cmA+Fq+Ah/0x3pHATYfVumQBQcES3lcLCePS5oOt6WVs+WQD5BPp9QuIDaBt6PxnvKkpN/XMMmJhfiyfZPWT5FM0541/6LXCjt1msh9+cUfEwVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZffegsXq0Wt2omC8gWbSpeWnq60vZpbnX/j3AT7jNoA=;
 b=OmD69yczxfcx1nsRF2UvfVoaBxfY75ke2UmkZyarKB3hgFSSzjeUxr80qqjWyf0tDKW9e8fw8//8psabmaH/76bOtDMQd021CeqNOM9cp3kAW8yq7MVLHDHDHa0jAcHGPJT8TsAUoHsBWu4vCC+6iA3MvY6fYiEOPej69MgJhOC6O1M4B0MNHFL4fei+vFXzXpW/qMEajzrnPsNVXXC0/iw2+EFlX8RAhwIq36r4EE82ico4A6MzxRN8Uoj1SJwN7aarzrJc16asCvHoIWpY2RUh34nXs7EnmamOnjxX0FTz5RP+VxZtPMdyWbYOUja/VB+km481P7uwzFBR0gFxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZffegsXq0Wt2omC8gWbSpeWnq60vZpbnX/j3AT7jNoA=;
 b=mXks5peW569nUXaIIqIPlreWftZRk0At0u2Gy5ndYZw6JOyz8gdPWGjBJRTWmWXVKVJb7fu4ad1uE07qsVwol/cAd4lAGJQBeqAXj7+niD6ahTglU+MQ+t5Bub2h1rFxUk/GTiwB4xUj/ZGonv4v5Z5djRigb7Cewr5hyzRgDk+2kaUx1WTjR5rDP2B9iyGGesYgSD7gsVIDZ/L4xcS81Vh2x2cBWOmyvEvg58evq0uUhU6Vreg8zHAT2kxFh+cd3jG8iHAmGzLaZhLU6egm1zwFhfNkFgTrmE8K0ihu1hk7vSDk2fx72UEq39yGXrCYYCfciaafcu2ZE5lbSwH8nA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 19:34:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 19:34:19 +0000
Date:   Thu, 22 Apr 2021 16:34:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports
 when remove a cm device
Message-ID: <20210422193417.GA2435405@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
 <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Thu, 22 Apr 2021 19:34:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZf5e-00AIvZ-02; Thu, 22 Apr 2021 16:34:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 241f2f4c-ff22-423e-cf50-08d905c59f95
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24906661747CB8E37417D4DEC2469@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf00lFaUAWH6Hj1xEOrzZnRtAS892dkpm1MVX/QtxVBxjVoDrWF7bZENDkjFVfVwzakZN6/GYOwXtZgHigJ2mCwBs4XUVPBFi6IG37uABU2slTgPCh0ug4dqEfpgPX143M0jnH80sJ2r4jhRJuuvdA2A/ez5U2jqxk6uBrb3tbD9aLUpXwcc+QU80asZabpEXWwABjYOsVnNwLnt/sAy8TDKvbsHgRHBFQyVQffw9/k7wX1VupLLK5xsUm672v2JqTD45J75SXFhbeq3oClUpjcMhyG7DE3NSfoN+PZINAGWdRcyB5NGahKJOqi7R0oOBXsDxn/vuwOyoiKpScKiWBzQrPkvCoBVe3wzxRc7Rr3RBdBqh0Z2cGrfkwMvAVKtnENG0HltlD6l98pWjuPkicJ4JjgkCZmXiIZgDl7CmhLQwxoPNHTm/atO1BXfSgmayFW8llpMsNac6J1Z7SFvmX5Z/i/dTB5h6IWnWJnDmFlgmCebykzYp7DwyRl1OPBRytf1OwRBWacUbPmRYMut9gNPxhlwXZ1S5Uyy+2vn4zWTuRkaQan/Dppsy31HONas6Cy1R09wir6CsOknv9JC2UQLZRdm9uYDbgEimjySE4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(83380400001)(4326008)(478600001)(316002)(1076003)(426003)(66556008)(66946007)(186003)(36756003)(6916009)(54906003)(30864003)(2906002)(5660300002)(9786002)(9746002)(33656002)(26005)(2616005)(38100700002)(8936002)(66476007)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oZJro5GV0BzIa/jEXEcuir4iGT8rWPSVp+S9h53W9oHXdWwdKKMR6rfJi4KF?=
 =?us-ascii?Q?DewGvuV7sYlgQR1Wb/YwYhdiWOdJxSWYi0rJlf2jTWW7+tkBvqTUnsaj/UQF?=
 =?us-ascii?Q?bKYcPaxiPD5fCEK1k6rlfb044RQdOnFIxLBsr3uWjIH8PlxGFYp+RVGgNiDG?=
 =?us-ascii?Q?8K+XzsvtmteR7sH4N/fnuaEcYzhMAhrSqNSAs1DYw0VtNon6g1JtVJ7TGkCY?=
 =?us-ascii?Q?oukKKGQ/VYJ7ppr2wPH2PuDrfb5Qvd5X+xngJ8FgDsDY0v9aONZbat/jwDl0?=
 =?us-ascii?Q?LRTRYYUZ66+gnWIGnkcekZw7DMS/jARr/nkuewNoc53jSreTFigHLv5pI6fB?=
 =?us-ascii?Q?otRzHJQ0QNHd6bn+6D1WFybkTvURWItQHXzt9MtqEPA8Nz4XGm69/ypemtrv?=
 =?us-ascii?Q?eT1WIqwpDF4iP2Y5t9tk94Ua9CiQjctrOJ8ZdDTE7gLsG+nokTnLrn2+0edu?=
 =?us-ascii?Q?nppfyjh0jsrMjoZ3/9bgWTfzbwfKW1lN3R173fpXxRt3B3nMWIMOUtp2FARK?=
 =?us-ascii?Q?9P0ogIhmXTN4P4k+C1JewfmlIeF/32uD5b/BXUrUyjUObKwgtTI9jPhkzQQc?=
 =?us-ascii?Q?fXw4nHMWpWxqhYNUgJzjkUIFV8BDII/5atl6QvndSn0hnVrbiYXRUK8Ubq3t?=
 =?us-ascii?Q?Vu2OydCMCHHYKPkOxnDRmBxIM3KC4/yuOT/KwqT5NfP5KWuWLt4gyLLttYZl?=
 =?us-ascii?Q?UNDTF1cPdldSC5oRzft+y7yOolen/bM289HSD8geLwbKCuNrYvzr6bJl2R6e?=
 =?us-ascii?Q?pjTr6nadD9TXExlIrAa8mO2fz8T+yeD/tgELtnDpwXHMsRFoXQqWUBfPV4Mx?=
 =?us-ascii?Q?tE7ZLjRhbg3JU3I2KoOAoaMXyXryoaPyoSK5F3Fo0rNGPkHVfPj+xDgbxTSM?=
 =?us-ascii?Q?HZXe48eOSyPARgqyTkJzwWe4UaJpL3eMwW00LCZWB7IqJvGpN6mEEGfuHd9T?=
 =?us-ascii?Q?D4GHnCcRrS8RBbe7H9GalYbvApzSnr2N0oUoYDL/MQG1k34UoNWJ1/W1Vbz4?=
 =?us-ascii?Q?ZFOfpPTq0KC34OxhSBCGEE9poMDLE5scho+tHU83xQz2jTkR8p4lA4rVCbEX?=
 =?us-ascii?Q?LraXuXczQA8HXy18ezDIVG5LxJtST3ZxWnswLFkiFzKywYY6LzHd5S8eHime?=
 =?us-ascii?Q?YzggNJ6VSIg74HUIGuSpjWVAIwUDqiO55m2yshNb2fjRCiNSQSSB2HCvx5c4?=
 =?us-ascii?Q?1T4tM8kSY/WWtMDJp/UWgYi9Gkmx+tTDpTX40QJfelQRdWEPHY3GNFt8EzaA?=
 =?us-ascii?Q?A8dWLqVZbQJJjcKHyF0PUcxfGHOe9GkFUAqGkEFOxZ6Bo0QsWkDHhL59zArQ?=
 =?us-ascii?Q?QukQGJHFNk1BF3lI+taO0Lqt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241f2f4c-ff22-423e-cf50-08d905c59f95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 19:34:19.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcGopp5w3SX9GnO1Cr8/a6nB6iYEtM+Hf5CIsXFZ7zp+z/p7S8f6ANCuBD5EYZSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 21, 2021 at 02:40:37PM +0300, Leon Romanovsky wrote:
> @@ -4396,6 +4439,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>  	cm_dev->going_down = 1;
>  	spin_unlock_irq(&cm.lock);
>  
> +	list_for_each_entry_safe(cm_id_priv, tmp,
> +				 &cm_dev->cm_id_priv_list, cm_dev_list) {
> +		if (!list_empty(&cm_id_priv->cm_dev_list))
> +			list_del(&cm_id_priv->cm_dev_list);
> +		cm_id_priv->av.port = NULL;
> +		cm_id_priv->alt_av.port = NULL;
> +	}

Ugh, this is in the wrong order, it has to be after the work queue
flush..

Hurm, I didn't see an easy way to fix it up, but I did think of a much
better design!

Generally speaking all we need is the memory of the cm_dev and port to
remain active, we don't need to block or fence with cm_remove_one(),
so just stick a memory kref on this thing and keep the memory. The
only things that needs to seralize with cm_remove_one() are on the
workqueue or take a spinlock (eg because they touch mad_agent)

Try this, I didn't finish every detail, applies on top of your series,
but you'll need to reflow it into new commits:

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3feff999a5e003..c26367006a4485 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -205,8 +205,11 @@ struct cm_port {
 };
 
 struct cm_device {
+	struct kref kref;
 	struct list_head list;
+	struct mutex unregistration_lock;
 	struct ib_device *ib_device;
+	unsigned int num_ports;
 	u8 ack_delay;
 	int going_down;
 	struct list_head cm_id_priv_list;
@@ -262,7 +265,6 @@ struct cm_id_private {
 	/* todo: use alternate port on send failure */
 	struct cm_av av;
 	struct cm_av alt_av;
-	rwlock_t av_rwlock;	/* Do not acquire inside cm.lock */
 
 	void *private_data;
 	__be64 tid;
@@ -287,10 +289,23 @@ struct cm_id_private {
 	atomic_t work_count;
 
 	struct rdma_ucm_ece ece;
-
-	struct list_head cm_dev_list;
 };
 
+static void cm_dev_release(struct kref *kref)
+{
+	struct cm_device *cm_dev = container_of(kref, struct cm_device, kref);
+	unsigned int i;
+
+	for (i = 0; i != cm_dev->num_ports; i++)
+		kfree(cm_dev->port[i]);
+	kfree(cm_dev);
+}
+
+static void cm_device_put(struct cm_device *cm_dev)
+{
+	kref_put(&cm_dev->kref, cm_dev_release);
+}
+
 static void cm_work_handler(struct work_struct *work);
 
 static inline void cm_deref_id(struct cm_id_private *cm_id_priv)
@@ -306,12 +321,12 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	struct ib_ah *ah;
 	int ret;
 
-	read_lock(&cm_id_priv->av_rwlock);
 	if (!cm_id_priv->av.port) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	spin_lock(&cm_id_priv->av.port.cm_dev->unregistration_lock);
 	mad_agent = cm_id_priv->av.port->mad_agent;
 	if (!mad_agent) {
 		ret = -EINVAL;
@@ -330,7 +345,6 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 			       GFP_ATOMIC,
 			       IB_MGMT_BASE_VERSION);
 
-	read_unlock(&cm_id_priv->av_rwlock);
 	if (IS_ERR(m)) {
 		rdma_destroy_ah(ah, 0);
 		ret = PTR_ERR(m);
@@ -346,7 +360,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	return m;
 
 out:
-	read_unlock(&cm_id_priv->av_rwlock);
+	spin_unlock(&cm_id_priv->av.port.cm_dev->unregistration_lock);
 	return ERR_PTR(ret);
 }
 
@@ -465,20 +479,18 @@ static void cm_set_private_data(struct cm_id_private *cm_id_priv,
 	cm_id_priv->private_data_len = private_data_len;
 }
 
-static void add_cm_id_to_cm_dev_list(struct cm_id_private *cm_id_priv,
-				     struct cm_device *cm_dev)
+static void cm_set_av_port(struct cm_av *av, struct cm_port *port)
 {
-	unsigned long flags;
+	struct cm_port *old_port = av->port;
 
-	spin_lock_irqsave(&cm.lock, flags);
-	if (cm_dev->going_down)
-		goto out;
+	if (old_port == port)
+		return;
 
-	if (!list_empty(&cm_id_priv->cm_dev_list))
-		list_del(&cm_id_priv->cm_dev_list);
-	list_add_tail(&cm_id_priv->cm_dev_list, &cm_dev->cm_id_priv_list);
-out:
-	spin_unlock_irqrestore(&cm.lock, flags);
+	av->port = port;
+	if (old_port)
+		cm_device_put(old_port->cm_dev);
+	if (port)
+		kref_get(&old_port->cm_dev->kref);
 }
 
 static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
@@ -505,11 +517,8 @@ static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
 	if (ret)
 		return ret;
 
-	write_lock(&cm_id_priv->av_rwlock);
-	av->port = port;
+	cm_set_av_port(av, port);
 	av->pkey_index = wc->pkey_index;
-	add_cm_id_to_cm_dev_list(cm_id_priv, port->cm_dev);
-	write_unlock(&cm_id_priv->av_rwlock);
 
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;
@@ -521,10 +530,7 @@ static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
 {
 	struct cm_av *av = &cm_id_priv->av;
 
-	write_lock(&cm_id_priv->av_rwlock);
-	av->port = port;
-	add_cm_id_to_cm_dev_list(cm_id_priv, port->cm_dev);
-	write_unlock(&cm_id_priv->av_rwlock);
+	cm_set_av_port(av, port);
 	av->pkey_index = wc->pkey_index;
 	return ib_init_ah_attr_from_wc(port->cm_dev->ib_device,
 				       port->port_num, wc,
@@ -588,12 +594,9 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 		return -EINVAL;
 	cm_dev = port->cm_dev;
 
-	read_lock(&cm_id_priv->av_rwlock);
 	if (!is_priv_av &&
 	    (!cm_id_priv->av.port || cm_dev != cm_id_priv->av.port->cm_dev))
 		ret = -EINVAL;
-
-	read_unlock(&cm_id_priv->av_rwlock);
 	if (ret)
 		return ret;
 
@@ -618,13 +621,8 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	if (ret)
 		return ret;
 
-	write_lock(&cm_id_priv->av_rwlock);
-	av->port = port;
+	cm_set_av_port(av, port);
 	av->timeout = path->packet_life_time + 1;
-	if (is_priv_av)
-		add_cm_id_to_cm_dev_list(cm_id_priv, cm_dev);
-
-	write_unlock(&cm_id_priv->av_rwlock);
 
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;
@@ -905,10 +903,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 	spin_lock_init(&cm_id_priv->lock);
 	init_completion(&cm_id_priv->comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
-	INIT_LIST_HEAD(&cm_id_priv->cm_dev_list);
 	atomic_set(&cm_id_priv->work_count, -1);
 	refcount_set(&cm_id_priv->refcount, 1);
-	rwlock_init(&cm_id_priv->av_rwlock);
 
 	ret = xa_alloc_cyclic(&cm.local_id_table, &id, NULL, xa_limit_32b,
 			      &cm.local_id_next, GFP_KERNEL);
@@ -1027,10 +1023,8 @@ static u8 cm_ack_timeout_req(struct cm_id_private *cm_id_priv,
 {
 	u8 ack_delay = 0;
 
-	read_lock(&cm_id_priv->av_rwlock);
-	if (cm_id_priv->av.port && cm_id_priv->av.port->cm_dev)
+	if (cm_id_priv->av.port)
 		ack_delay = cm_id_priv->av.port->cm_dev->ack_delay;
-	read_unlock(&cm_id_priv->av_rwlock);
 
 	return cm_ack_timeout(ack_delay, packet_life_time);
 }
@@ -1228,8 +1222,6 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		cm_id_priv->timewait_info = NULL;
 	}
 
-	if (!list_empty(&cm_id_priv->cm_dev_list))
-		list_del(&cm_id_priv->cm_dev_list);
 	WARN_ON(cm_id_priv->listen_sharecount);
 	WARN_ON(!RB_EMPTY_NODE(&cm_id_priv->service_node));
 	if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node))
@@ -1246,6 +1238,8 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	rdma_destroy_ah_attr(&cm_id_priv->av.ah_attr);
 	rdma_destroy_ah_attr(&cm_id_priv->alt_av.ah_attr);
 	kfree(cm_id_priv->private_data);
+	cm_set_av_port(&cm_id_priv->av, NULL);
+	cm_set_av_port(&cm_id_priv->alt_av, NULL);
 	kfree_rcu(cm_id_priv, rcu);
 }
 
@@ -1378,10 +1372,13 @@ static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 {
 	u64 hi_tid = 0, low_tid;
 
-	read_lock(&cm_id_priv->av_rwlock);
-	if (cm_id_priv->av.port && cm_id_priv->av.port->mad_agent)
-		hi_tid = ((u64) cm_id_priv->av.port->mad_agent->hi_tid) << 32;
-	read_unlock(&cm_id_priv->av_rwlock);
+	if (cm_id_priv->av.port) {
+		spin_lock(&cm_id_priv->av.port->cm_dev->unregistration_lock);
+		if (cm_id_priv->av.port->mad_agent)
+			hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid)
+				 << 32;
+		spin_unlock(&cm_id_priv->av.port->cm_dev->unregistration_lock);
+	}
 
 	low_tid  = (u64)cm_id_priv->id.local_id;
 	return cpu_to_be64(hi_tid | low_tid);
@@ -1879,12 +1876,10 @@ static void cm_format_req_event(struct cm_work *work,
 	param = &work->cm_event.param.req_rcvd;
 	param->listen_id = listen_id;
 	param->bth_pkey = cm_get_bth_pkey(work);
-	read_lock(&cm_id_priv->av_rwlock);
 	if (cm_id_priv->av.port)
 		param->port = cm_id_priv->av.port->port_num;
 	else
 		param->port = 0;
-	read_unlock(&cm_id_priv->av_rwlock);
 	param->primary_path = &work->path[0];
 	cm_opa_to_ib_sgid(work, param->primary_path);
 	if (cm_req_has_alt_path(req_msg)) {
@@ -2311,13 +2306,11 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	IBA_SET(CM_REP_STARTING_PSN, rep_msg, param->starting_psn);
 	IBA_SET(CM_REP_RESPONDER_RESOURCES, rep_msg,
 		param->responder_resources);
-	read_lock(&cm_id_priv->av_rwlock);
 	if (cm_id_priv->av.port && cm_id_priv->av.port->cm_dev)
 		IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
 			cm_id_priv->av.port->cm_dev->ack_delay);
 	else
 		IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg, 0);
-	read_unlock(&cm_id_priv->av_rwlock);
 	IBA_SET(CM_REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
 	IBA_SET(CM_REP_RNR_RETRY_COUNT, rep_msg, param->rnr_retry_count);
 	IBA_SET(CM_REP_LOCAL_CA_GUID, rep_msg,
@@ -4187,10 +4180,8 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
 						    IB_ACCESS_REMOTE_ATOMIC;
 		qp_attr->pkey_index = cm_id_priv->av.pkey_index;
-		read_lock(&cm_id_priv->av_rwlock);
 		qp_attr->port_num = cm_id_priv->av.port ?
 			cm_id_priv->av.port->port_num : 0;
-		read_unlock(&cm_id_priv->av_rwlock);
 		ret = 0;
 		break;
 	default:
@@ -4234,10 +4225,8 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		}
 		if (rdma_ah_get_dlid(&cm_id_priv->alt_av.ah_attr)) {
 			*qp_attr_mask |= IB_QP_ALT_PATH;
-			read_lock(&cm_id_priv->av_rwlock);
 			qp_attr->alt_port_num = cm_id_priv->alt_av.port ?
 				cm_id_priv->alt_av.port->port_num : 0;
-			read_unlock(&cm_id_priv->av_rwlock);
 			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
 			qp_attr->alt_timeout = cm_id_priv->alt_av.timeout;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
@@ -4296,10 +4285,8 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 			}
 		} else {
 			*qp_attr_mask = IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE;
-			read_lock(&cm_id_priv->av_rwlock);
 			qp_attr->alt_port_num = cm_id_priv->alt_av.port ?
 				cm_id_priv->alt_av.port->port_num : 0;
-			read_unlock(&cm_id_priv->av_rwlock);
 			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
 			qp_attr->alt_timeout = cm_id_priv->alt_av.timeout;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
@@ -4417,9 +4404,11 @@ static int cm_add_one(struct ib_device *ib_device)
 	if (!cm_dev)
 		return -ENOMEM;
 
+	kref_init(&cm_dev->kref);
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
+	cm_dev->num_ports = ib_device->phys_port_cnt;
 	INIT_LIST_HEAD(&cm_dev->cm_id_priv_list);
 
 	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
@@ -4489,10 +4478,9 @@ static int cm_add_one(struct ib_device *ib_device)
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		ib_unregister_mad_agent(port->mad_agent);
 		cm_remove_port_fs(port);
-		kfree(port);
 	}
 free:
-	kfree(cm_dev);
+	cm_device_put(cm_dev);
 	return ret;
 }
 
@@ -4515,21 +4503,15 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 	cm_dev->going_down = 1;
 	spin_unlock_irq(&cm.lock);
 
-	list_for_each_entry_safe(cm_id_priv, tmp,
-				 &cm_dev->cm_id_priv_list, cm_dev_list) {
-		write_lock(&cm_id_priv->av_rwlock);
-		if (!list_empty(&cm_id_priv->cm_dev_list))
-			list_del(&cm_id_priv->cm_dev_list);
-		cm_id_priv->av.port = NULL;
-		cm_id_priv->alt_av.port = NULL;
-		write_unlock(&cm_id_priv->av_rwlock);
-	}
-
 	rdma_for_each_port (ib_device, i) {
+		struct ib_mad_agent *mad_agent;
+
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;
 
 		port = cm_dev->port[i-1];
+		mad_agent = port->mad_agent;
+
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		/*
 		 * We flush the queue here after the going_down set, this
@@ -4537,12 +4519,20 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		 * after that we can call the unregister_mad_agent
 		 */
 		flush_workqueue(cm.wq);
-		ib_unregister_mad_agent(port->mad_agent);
+		/*
+		 * The above ensures no call paths from the work are running,
+		 * the remaining paths all take the unregistration lock
+		 */
+		spin_lock(&cm_dev->unregistration_lock);
+		port->mad_agent = NULL;
+		spin_unlock(&cm_dev->unregistration_lock);
+		ib_unregister_mad_agent(mad_agent);
 		cm_remove_port_fs(port);
-		kfree(port);
 	}
 
-	kfree(cm_dev);
+	/* All touches can only be on call path from the work */
+	cm_dev->ib_device = NULL;
+	cm_device_put(cm_dev);
 }
 
 static int __init ib_cm_init(void)

