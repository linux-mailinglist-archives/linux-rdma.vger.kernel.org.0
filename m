Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBB383A64
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhEQQtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:35 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:7601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239164AbhEQQtN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxXqCzfEMQysZ91dmSkHF5EGdZTpnE2MIE/cKWi2/ACmGQQwLwUPI1+ynJtpdJZQjCbBat2XqqwW4QF46MUOGMpurfb3uf9lxnvwxZE8SnQ6lRQIyREGouCaY7XdnKPO2w5xd3MKFD1OoWavU0gqpbEr7O1/DWk9kVxR+u6JE85DVzpeiL3+4WWYCTARfLiF064cd9oP+1X2O1emgIk6c3YiBCbwF8yID3SKA2yaaovTB3GJILoLhmyR89jjLx68AebaxFbM9GvRzrYbXilM9nOrMukeGOHPkjzZtYAHzq1iRw8F+aRAr2eh/ANqJAtRQN6fzrGqFqH6l3d7/bUF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVGny7kKGS3oYFlBlPHKn79Yka9irl2ImLfhJB8TZu4=;
 b=baspgV+oja5qAQv8KAiBsMI2imNJ/WoB7utK8hhoIT28k8zOJ5qbNEqcPWryx3JFIVUURK4/P/Ob2QHOBlrnzFFlg59FiCIs1+cRb8yqmN8P8lVdPDEqqMWZACAVRYE9dVyxBpcfFdqt/nQ47zIfUh8DDR1CUmF3M9jmbbNaWhZGfhImXUanirTDRwTgGUlx4Krm7ayFVXXf+IW5YjsXX+NXOzXPJAOiuK8MtFZu3OK4dw5rlyW5Avo0t1pd/nD5b3ga84ppn5SEorbkXDx08yZVa5WoTJV7mxkUFLuMOvKC9xhmRlrarMlBOB5DZ0p+nNKuS4CSCanEzgVgXRSR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVGny7kKGS3oYFlBlPHKn79Yka9irl2ImLfhJB8TZu4=;
 b=Scn/XhqXSSHSEzAvxIPJo4p1kiCOt1rrZxI9zw4XpmioVPjSMnal5PvjVQD7o/B0PTXUc/YUCqMAhQzfVuGhDNJQLgCEJ0RPataasq5ynCTWUzdrmaqg7qDi6WvvBXp6QCf4NPVo9EjfPTa1pf//hfzMgsa9uHSmcIM5luhFJBD266sdjylkjYruYm5HmDLOmSI9FQ2qoJ+mdQ4ljGaSSeL2ysLbTno3Wo54srkR1VQ4WwB26ZjRZXjbXA1dh9LYZm6yXCAcCtALBDb4UVq2eG9Drmkf39pP0VCsTbsYBvCu/InGfiOSplqennkY1eu7R3QAe7UwZpZnXvu4XL6H/g==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 13/13] RDMA: Change ops->init_port to ops->get_port_groups
Date:   Mon, 17 May 2021 13:47:41 -0300
Message-Id: <13-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:208:236::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:208:236::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 16:47:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LZ8-BT; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55acebb3-e723-4a26-1cdb-08d919537de0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858E63A12BC38FB055C4595C22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOfBj7B54yE4wse25ELTkVJzUYyQ56qaHiK0xLFr7KpDjRSdjTSAnMIa0dda2dIeeI/h3jze/Z0s1blPWEJ7emwBfkkualSFCc/VHPpc885XlfNC7hpC3sIP31MCmlBtuxOkpHM9dRs/tVfQRgK9K6iUyPIl0VjLDG0q4rXIos8dUMBnj1qvSak2Gq146mM0s6WYeMndhNFdwf16DrXnVHN80/oK5f1m1DcVbcvxKmn5YVf/RCZW+lPItBqGJok4nI6HNgyDCtpD+ScD9v3vC1f8ZTapcdywcOtM6I2Yx65PJrEfqAFFuA8tFfqhpMSuXm2CcCZ2sQzAZtQvPEGRddZvQYLldrvRW66uiUg7Il+9tQ931HdEhcxybJrOMpN2B1YyXt1GSCVm//7nrDnjsKB+cMaIO282rmEIgMk3ugcMeBatoc9oPQMFwjk7DvYMM7pquy/ye2ZSsDC6/yKhEEhZHaFiFBy30nyyIv9oj7HAyPXY9Wd+Apj+f4zp7pMWBdxYUptGO4yiHI3TWH2hLjvJwPclfajyR3fkLtvbSRptdjujE3e7phxg51RCTaeNazj9yqNp9EWudubLKTlNqpB56ijRIG46fyryO/pzbKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(110136005)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vuq11q22PjmliM6I/yUC/29y1k9PxsgZtb2FXKlYgtOtneboZaVWZVmujqxB?=
 =?us-ascii?Q?Zo/TQz/WK14DkshRVn3FcyQn+jQpvMvezcm1gHqM7E1jSzfQpFlUHftfFvs4?=
 =?us-ascii?Q?RDIU+elak4Jxr2WXw5ol538J3Q5Ja3GpRUBGVzoFHKq9D2+HcnabbTxd3G9F?=
 =?us-ascii?Q?2QUyeVf0eOq3jxTIdCsnn0EYUm8RSpo3ak0c9HhLS1Bz11yQsaDZIMne9nt9?=
 =?us-ascii?Q?LTI9QsbnWnro6fwY0gycGnDQMUAjgB6MsjNUQsN6fsffSDSw2QS7YCXj+WNV?=
 =?us-ascii?Q?/6u28R+DxxlKqa1UuWvGiV9VU2fGnRvXxIwQNR7QP40CM5TmElxj4cVi10c0?=
 =?us-ascii?Q?cE+1wpg2Y36uz8tamWksUi3eM3GEPoSerY5/KRh1tMIy7JyC2MFPddIa26hR?=
 =?us-ascii?Q?0jV2I6kmd3ucQ6urxgKNWA2knwk2cvZ3rqqMx0F8to6ZQgw5YUnDivcIoa2Q?=
 =?us-ascii?Q?Pw6nzLTPmIawdr9VLjUGh0/zBZ7LI+LYoETg/2Ii1jHPtX3WEZzLkbppmJeE?=
 =?us-ascii?Q?Oi42C137rQ5G3j4/s5iTzf4Em1VOsbz4mcoM9OeD64kWXnaPUeWCjxIHdfP7?=
 =?us-ascii?Q?MSHmfeBpT1h06xfFBh171diH0A/p8Mgkb46yXAeQpt8KYniejFlbcaiXrY5U?=
 =?us-ascii?Q?yQrYcEKySHLkVbrkcNlOEGD+3LqpI0VwQhZXheU8GaQ1VSiIdjCrn/A0lTcu?=
 =?us-ascii?Q?fFjbYEF2PtKAmMbyZ1V4vhhUFnsQ0i5wwXLKeK1fwmkZH9Mc+tzoVf3nIC/O?=
 =?us-ascii?Q?153QasrN2sctQpeTnxBE/K0YMrtfF18FshkTABa+VCozgfBuL3xUhIvKabvL?=
 =?us-ascii?Q?sgyjg/jWKhvkLgv10Up4hsUDCNYTGgXJL3AsJluws4i/BVS2fEhomq1dR7Nt?=
 =?us-ascii?Q?X94o4KP0l75cnfnmmg/ZiBF1UYs3ixJVobC0K6upovpPSh4B2A28kt51pg6/?=
 =?us-ascii?Q?Ufj7AKte2QXTPRikK+exXxnadlgniIwfKUFCO01wL3SJPgKUm0cnlWFKeqxm?=
 =?us-ascii?Q?zOFettJ9wTeGswAk3/Y9wdfaTL6pSjVng4UDmOHJ7nh+usZ+9wzB4/3hNmUo?=
 =?us-ascii?Q?vu08c5dQ443qzI3H5nByr0ZompP0ygmj6TU0MrzVaQtIrB7URAovuQvha/86?=
 =?us-ascii?Q?ewB9ykcf1EqTORakQg63FjXQmO7/IU5klFmi+Cj+fTdjYQowVfngPMNLcw/K?=
 =?us-ascii?Q?XPw4z31U99PZKhTQw1I08+UGWsM4fTf+T1c3JhTJRp+qTQmkX2jZiEblutYv?=
 =?us-ascii?Q?xzM8zTZhZEESjAMs8HebxWInYIUcooHnlOJK3m9Sr6Hhc9PgFzBMwGIk3HgM?=
 =?us-ascii?Q?AV1R7WMPDewHpPy2zr8Q/5sR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55acebb3-e723-4a26-1cdb-08d919537de0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:43.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jE4uCvamxfPag7WQg5kBtItoDiJsWo92ihzQwgoQG0DEjHaWs/xD2ZWodwDjChO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

init_port was only being used to register sysfs attributes against the
port kobject. Now that all users are creating attribute_group's we can
simply return the attribute_group list from the driver and the core code
can handle it.

This makes all the sysfs management quite straightforward and prevents any
driver from abusing the naked port kobject in future because no driver
code can access it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c      |  4 +--
 drivers/infiniband/core/sysfs.c       | 36 +++++++++------------------
 drivers/infiniband/hw/hfi1/hfi.h      |  4 +--
 drivers/infiniband/hw/hfi1/sysfs.c    | 10 +++-----
 drivers/infiniband/hw/hfi1/verbs.c    |  2 +-
 drivers/infiniband/hw/qib/qib.h       |  5 ++--
 drivers/infiniband/hw/qib/qib_sysfs.c | 22 +++-------------
 drivers/infiniband/hw/qib/qib_verbs.c |  4 +--
 drivers/infiniband/sw/rdmavt/vt.c     |  2 +-
 include/rdma/ib_sysfs.h               |  4 ---
 include/rdma/ib_verbs.h               |  5 ++--
 11 files changed, 30 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 030a4041b2e03b..28898558dda4c3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1703,7 +1703,7 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 * port_cleanup infrastructure is implemented, this limitation will be
 	 * removed.
 	 */
-	if (!dev->ops.disassociate_ucontext || dev->ops.init_port ||
+	if (!dev->ops.disassociate_ucontext || dev->ops.get_port_groups ||
 	    ib_devices_shared_netns) {
 		ret = -EOPNOTSUPP;
 		goto ns_err;
@@ -2668,7 +2668,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_guid);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
-	SET_DEVICE_OP(dev_ops, init_port);
+	SET_DEVICE_OP(dev_ops, get_port_groups);
 	SET_DEVICE_OP(dev_ops, iw_accept);
 	SET_DEVICE_OP(dev_ops, iw_add_ref);
 	SET_DEVICE_OP(dev_ops, iw_connect);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 5d9c8bfc280d8f..595a3d22263bf0 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -69,6 +69,7 @@ struct ib_port {
 
 	struct attribute_group groups[3];
 	const struct attribute_group *groups_list[5];
+	const struct attribute_group **driver_groups;
 	u32 port_num;
 	struct port_table_attribute attrs_list[];
 };
@@ -128,22 +129,6 @@ static ssize_t port_attr_store(struct kobject *kobj,
 	return port_attr->store(p->ibdev, p->port_num, port_attr, buf, count);
 }
 
-int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
-				const struct attribute_group **groups)
-{
-	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
-				   groups);
-}
-EXPORT_SYMBOL(ib_port_sysfs_create_groups);
-
-void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
-				 const struct attribute_group **groups)
-{
-	return sysfs_remove_groups(&ibdev->port_data[port_num].sysfs->kobj,
-				   groups);
-}
-EXPORT_SYMBOL(ib_port_sysfs_remove_groups);
-
 struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
 					       u32 *port_num)
 {
@@ -1253,6 +1238,13 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	ret = sysfs_create_groups(&p->kobj, p->groups_list);
 	if (ret)
 		goto err_del;
+	if (device->ops.get_port_groups && is_full_dev) {
+		p->driver_groups =
+			device->ops.get_port_groups(device, port_num);
+		ret = sysfs_create_groups(&p->kobj, p->driver_groups);
+		if (ret)
+			goto err_groups;
+	}
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
@@ -1260,6 +1252,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 
 	return p;
 
+err_groups:
+	sysfs_remove_groups(&p->kobj, p->groups_list);
 err_del:
 	kobject_del(&p->kobj);
 err_put:
@@ -1273,6 +1267,8 @@ static void destroy_port(struct ib_port *port)
 	    port->ibdev->port_data[port->port_num].sysfs == port)
 		port->ibdev->port_data[port->port_num].sysfs = NULL;
 	list_del(&port->kobj.entry);
+	if (port->driver_groups)
+		sysfs_remove_groups(&port->kobj, port->driver_groups);
 	sysfs_remove_groups(&port->kobj, port->groups_list);
 	kobject_del(&port->kobj);
 	kobject_put(&port->kobj);
@@ -1407,7 +1403,6 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 int ib_setup_port_attrs(struct ib_core_device *coredev)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
-	bool is_full_dev = &device->coredev == coredev;
 	u32 port_num;
 	int ret;
 
@@ -1433,13 +1428,6 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 		ret = setup_gid_attrs(port, &attr);
 		if (ret)
 			goto err_put;
-
-		if (device->ops.init_port && is_full_dev) {
-			ret = device->ops.init_port(device, port_num,
-						    &port->kobj);
-			if (ret)
-				goto err_put;
-		}
 	}
 	return 0;
 
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 87e101fb1f658a..d0d86af19fbf3d 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2188,8 +2188,8 @@ extern const struct attribute_group ib_hfi1_attr_group;
 int hfi1_device_create(struct hfi1_devdata *dd);
 void hfi1_device_remove(struct hfi1_devdata *dd);
 
-int hfi1_create_port_files(struct ib_device *ibdev, u32 port_num,
-			   struct kobject *kobj);
+const struct attribute_group **hfi1_get_port_groups(struct ib_device *ibdev,
+						    u32 port_num);
 int hfi1_verbs_register_sysfs(struct hfi1_devdata *dd);
 void hfi1_verbs_unregister_sysfs(struct hfi1_devdata *dd);
 /* Hook for sysfs read of QSFP */
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 326c6c2842f2f3..b299ae37023d32 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -606,10 +606,10 @@ static const struct attribute_group *hfi1_port_groups[] = {
 	NULL,
 };
 
-int hfi1_create_port_files(struct ib_device *ibdev, u32 port_num,
-			   struct kobject *kobj)
+const struct attribute_group **hfi1_get_port_groups(struct ib_device *ibdev,
+						    u32 port_num)
 {
-	return ib_port_sysfs_create_groups(ibdev, port_num, hfi1_port_groups);
+	return hfi1_port_groups;
 }
 
 struct sde_attribute {
@@ -740,8 +740,4 @@ void hfi1_verbs_unregister_sysfs(struct hfi1_devdata *dd)
 	/* Unwind operations in hfi1_verbs_register_sysfs() */
 	for (i = 0; i < dd->num_sdma; i++)
 		kobject_put(&dd->per_sdma[i].kobj);
-
-	for (i = 0; i < dd->num_pports; i++)
-		ib_port_sysfs_remove_groups(&dd->verbs_dev.rdi.ibdev, i + 1,
-					    hfi1_port_groups);
 }
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 85deba07a6754b..33c757e6b88d30 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1791,7 +1791,7 @@ static const struct ib_device_ops hfi1_dev_ops = {
 	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
 	.get_hw_stats = get_hw_stats,
-	.init_port = hfi1_create_port_files,
+	.get_port_groups = hfi1_get_port_groups,
 	.modify_device = modify_device,
 	/* keep process mad in the driver */
 	.process_mad = hfi1_process_mad,
diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 3decd6d0843172..d07b766d50fabc 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1366,9 +1366,8 @@ extern const struct attribute_group qib_attr_group;
 int qib_device_create(struct qib_devdata *);
 void qib_device_remove(struct qib_devdata *);
 
-int qib_create_port_files(struct ib_device *ibdev, u32 port_num,
-			  struct kobject *kobj);
-void qib_verbs_unregister_sysfs(struct qib_devdata *);
+const struct attribute_group **qib_get_port_groups(struct ib_device *ibdev,
+						   u32 port_num);
 /* Hook for sysfs read of QSFP */
 extern int qib_qsfp_dump(struct qib_pportdata *ppd, char *buf, int len);
 
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 2c81285d245fa7..835684d43e09f0 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -715,8 +715,8 @@ const struct attribute_group qib_attr_group = {
 	.attrs = qib_attributes,
 };
 
-int qib_create_port_files(struct ib_device *ibdev, u32 port_num,
-			  struct kobject *kobj)
+const struct attribute_group **qib_get_port_groups(struct ib_device *ibdev,
+						   u32 port_num)
 {
 	struct qib_devdata *dd = dd_from_ibdev(ibdev);
 	struct qib_pportdata *ppd = &dd->pport[port_num - 1];
@@ -729,21 +729,5 @@ int qib_create_port_files(struct ib_device *ibdev, u32 port_num,
 
 	if (qib_cc_table_size && ppd->congestion_entries_shadow)
 		*cur_group++ = &port_ccmgta_attribute_group;
-
-	return ib_port_sysfs_create_groups(ibdev, port_num, ppd->groups);
-}
-
-/*
- * Unregister and remove our files in /sys/class/infiniband.
- */
-void qib_verbs_unregister_sysfs(struct qib_devdata *dd)
-{
-	int i;
-
-	for (i = 0; i < dd->num_pports; i++) {
-		struct qib_pportdata *ppd = &dd->pport[i];
-
-		ib_port_sysfs_remove_groups(&dd->verbs_dev.rdi.ibdev, i,
-					    ppd->groups);
-	}
+	return ppd->groups;
 }
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index d17d034ecdfd9f..5552440f843bb1 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1483,7 +1483,7 @@ static const struct ib_device_ops qib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_QIB,
 
-	.init_port = qib_create_port_files,
+	.get_port_groups = qib_get_port_groups,
 	.modify_device = qib_modify_device,
 	.process_mad = qib_process_mad,
 };
@@ -1644,8 +1644,6 @@ void qib_unregister_ib_device(struct qib_devdata *dd)
 {
 	struct qib_ibdev *dev = &dd->verbs_dev;
 
-	qib_verbs_unregister_sysfs(dd);
-
 	rvt_unregister_device(&dd->verbs_dev.rdi);
 
 	if (!list_empty(&dev->piowait))
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 12ebe041a5da9b..e701ceff449b4a 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -418,7 +418,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		 * These functions are not part of verbs specifically but are
 		 * required for rdmavt to function.
 		 */
-		if ((!rdi->ibdev.ops.init_port) ||
+		if ((!rdi->ibdev.ops.get_port_groups) ||
 		    (!rdi->driver_f.get_pci_dev))
 			return -EINVAL;
 		break;
diff --git a/include/rdma/ib_sysfs.h b/include/rdma/ib_sysfs.h
index f869d0e4fd3030..3b77cfd74d9a30 100644
--- a/include/rdma/ib_sysfs.h
+++ b/include/rdma/ib_sysfs.h
@@ -31,10 +31,6 @@ struct ib_port_attribute {
 #define IB_PORT_ATTR_WO(_name)                                                 \
 	struct ib_port_attribute ib_port_attr_##_name = __ATTR_WO(_name)
 
-int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
-				const struct attribute_group **groups);
-void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
-				 const struct attribute_group **groups);
 struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
 					       u32 *port_num);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5f70aab1f8663b..5120a279a685e7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2551,8 +2551,9 @@ struct ib_device_ops {
 	 * This function is called once for each port when a ib device is
 	 * registered.
 	 */
-	int (*init_port)(struct ib_device *device, u32 port_num,
-			 struct kobject *port_sysfs);
+	const struct attribute_group **(*get_port_groups)(
+		struct ib_device *device, u32 port_num);
+
 	/**
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
-- 
2.31.1

