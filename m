Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93B134D1F0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhC2Nzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:44 -0400
Received: from mail-mw2nam12on2105.outbound.protection.outlook.com ([40.107.244.105]:45024
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231917AbhC2NzL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvJ3qiw8wKJy49CRu3kwcnEZUm5z1l9kVDSBS+h3FjoePA9i44FTTGQc+V1kbox7IGSRH7VKP9IE7MQxX2+akvm8uQ4xaKnpR4VZ4u5M/udaZnaIXbPyEAfTR7TiR8yVQrKR3UMTfb3m34FLrc6F/o2zM1S54gMTCcHVuks4C2Bi2Z4fEDVpasRhnmOyKW34oOpA/j3GZgkfyEERm6d4DBI/8k87uSa0J9PgB+IQw8jrVhs4pDDxIzv3n8T2uyuYb8b7JeVDIM4Vt/0Gxc9MCZo6Vw/jw1saz0pB57p5e6pIxz2Da/FlFiiL+BLqxD3yUgAbl3qUAfA2Rjf+b1c8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktwNAwb1naGveb/J8TT+NeKbW7Kv4pdVTz/1vC0TI2Q=;
 b=WngaCpDjWpIZFGcrt6Oow1z5uKKWZJ9AtbX6UAM+Ni00VZrrnueOexVFujgu6dK7tvyiLkCDQPkvEk3CUlXSCZ1tvC+nVnFVL/wxHwKwIthXGcXRDgmJiOvVHijByl0ztjSZyf85dyQlAoE+X9L8ovht8wMcqkSmJM1P1xfM/42H05cvXiFfuqgL98/96XNm/OdtljHCsAh2Nz4ofHItk3fRMuJK+NZEHs2lAYcgm0+zAemaejDbAsdXN2vjYZ+VWhig/W+MG5LExz5jgs7Ra2fGSyurt8WemmRQM38wkUXEoVZHQ8PrwO+gJX3y6+MVHI1UK/RVgnR7uOa/B+v2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktwNAwb1naGveb/J8TT+NeKbW7Kv4pdVTz/1vC0TI2Q=;
 b=Id+0C73n5e9nkyF+ocf3txFAP5P0CBRCCP6buDR9j6lmV9beZNCXGrxxUUGasM11OCNaKLWxcfvoTkVKeIyYBN4rCohUUcIVQ2UFCBNENIoeHxZxn/QpA8zVFH1ctOtvLL8roMkbXiLAoQwrpeYoEjKJkn3nf5UL8ahyWHcL4F0x62O8EjbU4rg5G3K2GW3u5A4YcrFkI2QDyROmcz5+7UuQdNPOsMNau6Vy7IstXz/ziwGxz7YjAkRDSX/2LnZwaer/GIWCYWJzol1YP+WrVJtJS2AraoMC0jIupSBZEQssQqNW3xRGTmnL8HB3M0uExSzP3jJ85XqO7cIlb5EVsg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6729.prod.exchangelabs.com (2603:10b6:510:97::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32; Mon, 29 Mar 2021 13:55:10 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:10 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 10/10] IB/hfi1: Rework AIP and VNIC dummy netdev usage
Date:   Mon, 29 Mar 2021 09:54:16 -0400
Message-Id: <1617026056-50483-11-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea8d3ae-8b89-465a-2a93-08d8f2ba447c
X-MS-TrafficTypeDiagnostic: PH0PR01MB6729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6729670B7A9AE4721C857FABF47E9@PH0PR01MB6729.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfZC544ioFmgAURWqOIKFD7lFN0kdEVX8bX0PG0aFSb3R4bQC6wR/PkKPZCfHeJ+L+00e/Poi0DsC+cQEg5VjjFgxRmMv+VqOa22Qe+Xw2sfuKj0jlNpJaWqERpTOfRKCpI0hQ+MZ8iwLNVdA4Aj63omyCYZoKUkyc9O4GWfdui9UQnjkFBeWCmhk35ACpT18NVMV0IKRV0s7PDloxivHv3x8XJW0KMVXiWWcrCg2b+BIbMiqsFjUKN1NCgk/OpQAMGMeGt4V2fZMV55X6LEvCe7DhQYW/aflp6CaNZfOiFFKrXPrfFvgfKnIB6EpyX+xmwVbOvt/3s1lcjJQqh7jdEK4QTjHWtS5i4dHWn+pHkuI3tBdAGWyEwVLrK4wbAwbxYX75gQ/UoBMWy/2Y3yDWSKIgBOGDiuCWL35qkt++vHWNMGrUcl/vLVCJLhchvu6OCmKc5bcXMWG29nxpd9nldtCE1RYp+EUTSgK4booz8Ptgt+5+97O7LUpXPEYlUByBbw8YvnNmttZ5lxfZmX6mpaDFPmi/E1I7G+VPPUI2D3DYHOUFOwFa31XqOfL/2ywCM5AzkqH8NJ2ubR0YvN9PS/VmGXq3ljzmV5oJh5cGh5xF13mykYSTLmvqe4kI893s1tabXJcklldNnlaXyHG1hJq81p+81Hn0Qq+PvUOXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39830400003)(9686003)(30864003)(52116002)(8936002)(8676002)(6486002)(38100700001)(66946007)(316002)(7696005)(16526019)(186003)(2616005)(956004)(66556008)(4326008)(26005)(83380400001)(2906002)(478600001)(54906003)(36756003)(6666004)(66476007)(5660300002)(107886003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NT2K8wbIQPOSdsf9l9tO5Y4YhS9aHf0+DPHVy4uiKCqeTf3/40R77V2VfiCD?=
 =?us-ascii?Q?X+zbCCusdX6csRNCMLZiuPyFSu5YvT7F3DIIj5IETQ7uVQtya5gQhbHxSDOR?=
 =?us-ascii?Q?U2iEz43tNpop2Bp2t4YhwXAD+gjCyV65tbSBYSWNuagxA2HFD1jkPTYkWnbE?=
 =?us-ascii?Q?mIXbKti+fFPYN0Bv5+aBHwebrn7vCm/8W+nZbKhpYgBV6qXiYwOcVDY9uIiu?=
 =?us-ascii?Q?gwQZjbORZYEvq16epjRK9FnFelykvNOiHJj4CYM0f7Dqzvz9sbi7Oy2NW1nK?=
 =?us-ascii?Q?BLwm5S7SWxT2TE0EBLgNQEhtW27oD+wjV6AKMe6QSqi1KKt+IYAGy0roHMdI?=
 =?us-ascii?Q?90RLvaZtayY60VmEZXn5oGahWF5OVZm8UVs7niIWNlRIJMlmN7XnptBsJjcu?=
 =?us-ascii?Q?4m5cjj3s3gSKVL3axop2mmyD2GlJKq2UrIw6JUQUsk9pFwBbsiEZSkvNeQBZ?=
 =?us-ascii?Q?z0hazkOwVqu/oJ9iVDl8Sg5ZEdOpPx/oWTDEE7JH0b6xitpvoChU7f9mVaPE?=
 =?us-ascii?Q?vsuPdJ1dGVs3PtHw3PP1S85XiEV/cYHVmOr7XvjWBdnR1fslsCVKksX/AB7S?=
 =?us-ascii?Q?XxZ1lDVcyCad0wS3jszgxl5UwO+scKB/W37E2to0oFTNfMcBpWbVtB/4l9Hw?=
 =?us-ascii?Q?Ik1uFnEWpHlO313tAkLeEMdwuicEEpUbgXthWthwFRZHKJZtMC2z186ZySsp?=
 =?us-ascii?Q?bROQ0u5u0vWgIAEVggyk+PpSNtzDa/9yztuC5eWlOD0Oe7k2m0V+2dQslpIf?=
 =?us-ascii?Q?bcJH2QqGS3XflijdM47Pl4Qjf9z8NDsJLp4w9ra3r2esNoIqhnkdDOu63zoh?=
 =?us-ascii?Q?AQUCEh0j2vubksIC7dIYgAKxmOwLrN7OogxqszmBmMlE2WDduzqWQSo3o4z7?=
 =?us-ascii?Q?KlOZcI8ZQePDO8CQY+WHWzc5Y2jgZHzIVdzgN49ZgI7W16BhGsuEw8x2zMhf?=
 =?us-ascii?Q?7+6vWYAmXXb56R8AQw6/Xy5za5DSC6SaIKmmoEXwHpgwS8hwY/xOa9616Jk8?=
 =?us-ascii?Q?bas4M4u+OQC3fwWaLuZFj8dgGuIQmVd561Eqb24NCrSDDmg4+03JP5WXzALL?=
 =?us-ascii?Q?IDQGUsAMj2Kmnj8ZDDS0aJtRhZ9qIGRKlLDX0vGhZj5WVyWae4tiRxsh1UmN?=
 =?us-ascii?Q?2gxTo789uScclOWHGHr75nvas1JVQGg1W3poZpSvRlE6eMLxd5lwxdZds/bX?=
 =?us-ascii?Q?McQic11IyMMJ6WQAvA/7jQV3TBhoGAD4tn6tmqi3XXsWdlF8uLSOsPgefVsO?=
 =?us-ascii?Q?FvTaA4tyXEXiW7GyeqsXHrg9tw/nMVMVzQofjYizQDVc6hxFA+b6vvpVebne?=
 =?us-ascii?Q?xAFj8Rq1zcwnoRXv7F6ebRw8?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea8d3ae-8b89-465a-2a93-08d8f2ba447c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:10.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhOlL+EGe478Mfdf5J8E1oZRhA2sdkt6C0TvJy4TCeBMNXqbDFf2WwzECCJ8Gz2MROM1cnnvSp9LPM5WKLex2CGFQ+cGjfQgKvV/PMZUt/D8tfWbH3UZXU7YWWTwIaX5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6729
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

All other users of the dummy netdevice embed the netdev in other
structures:

init_dummy_netdev(&mal->dummy_dev);
init_dummy_netdev(&eth->dummy_dev);
init_dummy_netdev(&ar->napi_dev);
init_dummy_netdev(&irq_grp->napi_ndev);
init_dummy_netdev(&wil->napi_ndev);
init_dummy_netdev(&trans_pcie->napi_dev);
init_dummy_netdev(&dev->napi_dev);
init_dummy_netdev(&bus->mux_dev);

The AIP and VNIC implementation turns that model inside out and used a
kfree() to free what appears to be a netdev struct when in reality, it is
a struct that enbodies the rx state as well as the dummy netdev used to
support napi_poll across disparate receive contexts.  The relationship is
infered by the odd allocation:

	const int netdev_size = sizeof(*dd->dummy_netdev) +
		sizeof(struct hfi1_netdev_priv);
	<snip>
	dd->dummy_netdev = kcalloc_node(1, netdev_size, GFP_KERNEL, dd->node);


Correct the issue by:
- Correctly naming the alloc and free functions
- Renaming hfi1_netdev_priv to hfi1_netdev_rx
- Replacing dd dummy_netdev with a netdev_rx pointer
- Embedding the net_device in hfi1_netdev_rx
- Moving the init_dummy_netdev to the alloc routine
- Adjusting wrappers to fit the new model

Fixes: 6991abcb993c ("IB/hfi1: Add functions to receive accelerated ipoib packets")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/chip.c      |   6 +-
 drivers/infiniband/hw/hfi1/hfi.h       |   4 +-
 drivers/infiniband/hw/hfi1/init.c      |   2 +-
 drivers/infiniband/hw/hfi1/netdev.h    |  39 +++-----
 drivers/infiniband/hw/hfi1/netdev_rx.c | 177 +++++++++++++++++----------------
 5 files changed, 108 insertions(+), 120 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index a156522..5eeae8d 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -15243,8 +15243,8 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 		 (dd->revision >> CCE_REVISION_SW_SHIFT)
 		    & CCE_REVISION_SW_MASK);
 
-	/* alloc netdev data */
-	ret = hfi1_netdev_alloc(dd);
+	/* alloc VNIC/AIP rx data */
+	ret = hfi1_alloc_rx(dd);
 	if (ret)
 		goto bail_cleanup;
 
@@ -15348,7 +15348,7 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 	hfi1_comp_vectors_clean_up(dd);
 	msix_clean_up_interrupts(dd);
 bail_cleanup:
-	hfi1_netdev_free(dd);
+	hfi1_free_rx(dd);
 	hfi1_pcie_ddcleanup(dd);
 bail_free:
 	hfi1_free_devdata(dd);
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index d341b8a..8afb757 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -69,7 +69,6 @@
 #include <rdma/ib_hdrs.h>
 #include <rdma/opa_addr.h>
 #include <linux/rhashtable.h>
-#include <linux/netdevice.h>
 #include <rdma/rdma_vt.h>
 
 #include "chip_registers.h"
@@ -1060,6 +1059,7 @@ struct hfi1_vnic_data {
 #define SERIAL_MAX 16 /* length of the serial number */
 
 typedef int (*send_routine)(struct rvt_qp *, struct hfi1_pkt_state *, u64);
+struct hfi1_netdev_rx;
 struct hfi1_devdata {
 	struct hfi1_ibdev verbs_dev;     /* must be first */
 	/* pointers to related structs for this device */
@@ -1402,7 +1402,7 @@ struct hfi1_devdata {
 	/* Lock to protect IRQ SRC register access */
 	spinlock_t irq_src_lock;
 	int vnic_num_vports;
-	struct net_device *dummy_netdev;
+	struct hfi1_netdev_rx *netdev_rx;
 	struct hfi1_affinity_node *affinity_entry;
 
 	/* Keeps track of IPoIB RSM rule users */
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 6d03aa0..447b5dab 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1775,7 +1775,7 @@ static void remove_one(struct pci_dev *pdev)
 	hfi1_unregister_ib_device(dd);
 
 	/* free netdev data */
-	hfi1_netdev_free(dd);
+	hfi1_free_rx(dd);
 
 	/*
 	 * Disable the IB link, disable interrupts on the device,
diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index 947543a..8aa0746 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -14,15 +14,14 @@
 
 /**
  * struct hfi1_netdev_rxq - Receive Queue for HFI
- * dummy netdev. Both IPoIB and VNIC netdevices will be working on
- * top of this device.
+ * Both IPoIB and VNIC netdevices will be working on the rx abstraction.
  * @napi: napi object
- * @priv: ptr to netdev_priv
+ * @rx: ptr to netdev_rx
  * @rcd:  ptr to receive context data
  */
 struct hfi1_netdev_rxq {
 	struct napi_struct napi;
-	struct hfi1_netdev_priv *priv;
+	struct hfi1_netdev_rx *rx;
 	struct hfi1_ctxtdata *rcd;
 };
 
@@ -36,7 +35,8 @@ struct hfi1_netdev_rxq {
 #define NUM_NETDEV_MAP_ENTRIES HFI1_MAX_NETDEV_CTXTS
 
 /**
- * struct hfi1_netdev_priv: data required to setup and run HFI netdev.
+ * struct hfi1_netdev_rx: data required to setup and run HFI netdev.
+ * @rx_napi:	the dummy netdevice to support "polling" the receive contexts
  * @dd:		hfi1_devdata
  * @rxq:	pointer to dummy netdev receive queues.
  * @num_rx_q:	number of receive queues
@@ -48,7 +48,8 @@ struct hfi1_netdev_rxq {
  * @netdevs:	atomic counter of netdevs using dummy netdev.
  *		When 0 receive queues will be freed.
  */
-struct hfi1_netdev_priv {
+struct hfi1_netdev_rx {
+	struct net_device rx_napi;
 	struct hfi1_devdata *dd;
 	struct hfi1_netdev_rxq *rxq;
 	int num_rx_q;
@@ -61,41 +62,27 @@ struct hfi1_netdev_priv {
 };
 
 static inline
-struct hfi1_netdev_priv *hfi1_netdev_priv(struct net_device *dev)
-{
-	return (struct hfi1_netdev_priv *)&dev[1];
-}
-
-static inline
 int hfi1_netdev_ctxt_count(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
-
-	return priv->num_rx_q;
+	return dd->netdev_rx->num_rx_q;
 }
 
 static inline
 struct hfi1_ctxtdata *hfi1_netdev_get_ctxt(struct hfi1_devdata *dd, int ctxt)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
-
-	return priv->rxq[ctxt].rcd;
+	return dd->netdev_rx->rxq[ctxt].rcd;
 }
 
 static inline
 int hfi1_netdev_get_free_rmt_idx(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
-
-	return priv->rmt_start;
+	return dd->netdev_rx->rmt_start;
 }
 
 static inline
 void hfi1_netdev_set_free_rmt_idx(struct hfi1_devdata *dd, int rmt_idx)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
-
-	priv->rmt_start = rmt_idx;
+	dd->netdev_rx->rmt_start = rmt_idx;
 }
 
 u32 hfi1_num_netdev_contexts(struct hfi1_devdata *dd, u32 available_contexts,
@@ -105,8 +92,8 @@ u32 hfi1_num_netdev_contexts(struct hfi1_devdata *dd, u32 available_contexts,
 void hfi1_netdev_disable_queues(struct hfi1_devdata *dd);
 int hfi1_netdev_rx_init(struct hfi1_devdata *dd);
 int hfi1_netdev_rx_destroy(struct hfi1_devdata *dd);
-int hfi1_netdev_alloc(struct hfi1_devdata *dd);
-void hfi1_netdev_free(struct hfi1_devdata *dd);
+int hfi1_alloc_rx(struct hfi1_devdata *dd);
+void hfi1_free_rx(struct hfi1_devdata *dd);
 int hfi1_netdev_add_data(struct hfi1_devdata *dd, int id, void *data);
 void *hfi1_netdev_remove_data(struct hfi1_devdata *dd, int id);
 void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id);
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index c1fa53d..f8995f3 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -17,11 +17,11 @@
 #include <linux/etherdevice.h>
 #include <rdma/ib_verbs.h>
 
-static int hfi1_netdev_setup_ctxt(struct hfi1_netdev_priv *priv,
+static int hfi1_netdev_setup_ctxt(struct hfi1_netdev_rx *rx,
 				  struct hfi1_ctxtdata *uctxt)
 {
 	unsigned int rcvctrl_ops;
-	struct hfi1_devdata *dd = priv->dd;
+	struct hfi1_devdata *dd = rx->dd;
 	int ret;
 
 	uctxt->rhf_rcv_function_map = netdev_rhf_rcv_functions;
@@ -118,11 +118,11 @@ static void hfi1_netdev_deallocate_ctxt(struct hfi1_devdata *dd,
 	hfi1_free_ctxt(uctxt);
 }
 
-static int hfi1_netdev_allot_ctxt(struct hfi1_netdev_priv *priv,
+static int hfi1_netdev_allot_ctxt(struct hfi1_netdev_rx *rx,
 				  struct hfi1_ctxtdata **ctxt)
 {
 	int rc;
-	struct hfi1_devdata *dd = priv->dd;
+	struct hfi1_devdata *dd = rx->dd;
 
 	rc = hfi1_netdev_allocate_ctxt(dd, ctxt);
 	if (rc) {
@@ -130,7 +130,7 @@ static int hfi1_netdev_allot_ctxt(struct hfi1_netdev_priv *priv,
 		return rc;
 	}
 
-	rc = hfi1_netdev_setup_ctxt(priv, *ctxt);
+	rc = hfi1_netdev_setup_ctxt(rx, *ctxt);
 	if (rc) {
 		dd_dev_err(dd, "netdev ctxt setup failed %d\n", rc);
 		hfi1_netdev_deallocate_ctxt(dd, *ctxt);
@@ -183,31 +183,31 @@ u32 hfi1_num_netdev_contexts(struct hfi1_devdata *dd, u32 available_contexts,
 		    (u32)HFI1_MAX_NETDEV_CTXTS);
 }
 
-static int hfi1_netdev_rxq_init(struct net_device *dev)
+static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
 {
 	int i;
 	int rc;
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dev);
-	struct hfi1_devdata *dd = priv->dd;
+	struct hfi1_devdata *dd = rx->dd;
+	struct net_device *dev = &rx->rx_napi;
 
-	priv->num_rx_q = dd->num_netdev_contexts;
-	priv->rxq = kcalloc_node(priv->num_rx_q, sizeof(struct hfi1_netdev_rxq),
-				 GFP_KERNEL, dd->node);
+	rx->num_rx_q = dd->num_netdev_contexts;
+	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
+			       GFP_KERNEL, dd->node);
 
-	if (!priv->rxq) {
+	if (!rx->rxq) {
 		dd_dev_err(dd, "Unable to allocate netdev queue data\n");
 		return (-ENOMEM);
 	}
 
-	for (i = 0; i < priv->num_rx_q; i++) {
-		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &rx->rxq[i];
 
-		rc = hfi1_netdev_allot_ctxt(priv, &rxq->rcd);
+		rc = hfi1_netdev_allot_ctxt(rx, &rxq->rcd);
 		if (rc)
 			goto bail_context_irq_failure;
 
 		hfi1_rcd_get(rxq->rcd);
-		rxq->priv = priv;
+		rxq->rx = rx;
 		rxq->rcd->napi = &rxq->napi;
 		dd_dev_info(dd, "Setting rcv queue %d napi to context %d\n",
 			    i, rxq->rcd->ctxt);
@@ -227,7 +227,7 @@ static int hfi1_netdev_rxq_init(struct net_device *dev)
 bail_context_irq_failure:
 	dd_dev_err(dd, "Unable to allot receive context\n");
 	for (; i >= 0; i--) {
-		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+		struct hfi1_netdev_rxq *rxq = &rx->rxq[i];
 
 		if (rxq->rcd) {
 			hfi1_netdev_deallocate_ctxt(dd, rxq->rcd);
@@ -235,20 +235,19 @@ static int hfi1_netdev_rxq_init(struct net_device *dev)
 			rxq->rcd = NULL;
 		}
 	}
-	kfree(priv->rxq);
-	priv->rxq = NULL;
+	kfree(rx->rxq);
+	rx->rxq = NULL;
 
 	return rc;
 }
 
-static void hfi1_netdev_rxq_deinit(struct net_device *dev)
+static void hfi1_netdev_rxq_deinit(struct hfi1_netdev_rx *rx)
 {
 	int i;
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dev);
-	struct hfi1_devdata *dd = priv->dd;
+	struct hfi1_devdata *dd = rx->dd;
 
-	for (i = 0; i < priv->num_rx_q; i++) {
-		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &rx->rxq[i];
 
 		netif_napi_del(&rxq->napi);
 		hfi1_netdev_deallocate_ctxt(dd, rxq->rcd);
@@ -256,41 +255,41 @@ static void hfi1_netdev_rxq_deinit(struct net_device *dev)
 		rxq->rcd = NULL;
 	}
 
-	kfree(priv->rxq);
-	priv->rxq = NULL;
-	priv->num_rx_q = 0;
+	kfree(rx->rxq);
+	rx->rxq = NULL;
+	rx->num_rx_q = 0;
 }
 
-static void enable_queues(struct hfi1_netdev_priv *priv)
+static void enable_queues(struct hfi1_netdev_rx *rx)
 {
 	int i;
 
-	for (i = 0; i < priv->num_rx_q; i++) {
-		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &rx->rxq[i];
 
-		dd_dev_info(priv->dd, "enabling queue %d on context %d\n", i,
+		dd_dev_info(rx->dd, "enabling queue %d on context %d\n", i,
 			    rxq->rcd->ctxt);
 		napi_enable(&rxq->napi);
-		hfi1_rcvctrl(priv->dd,
+		hfi1_rcvctrl(rx->dd,
 			     HFI1_RCVCTRL_CTXT_ENB | HFI1_RCVCTRL_INTRAVAIL_ENB,
 			     rxq->rcd);
 	}
 }
 
-static void disable_queues(struct hfi1_netdev_priv *priv)
+static void disable_queues(struct hfi1_netdev_rx *rx)
 {
 	int i;
 
-	msix_netdev_synchronize_irq(priv->dd);
+	msix_netdev_synchronize_irq(rx->dd);
 
-	for (i = 0; i < priv->num_rx_q; i++) {
-		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &rx->rxq[i];
 
-		dd_dev_info(priv->dd, "disabling queue %d on context %d\n", i,
+		dd_dev_info(rx->dd, "disabling queue %d on context %d\n", i,
 			    rxq->rcd->ctxt);
 
 		/* wait for napi if it was scheduled */
-		hfi1_rcvctrl(priv->dd,
+		hfi1_rcvctrl(rx->dd,
 			     HFI1_RCVCTRL_CTXT_DIS | HFI1_RCVCTRL_INTRAVAIL_DIS,
 			     rxq->rcd);
 		napi_synchronize(&rxq->napi);
@@ -307,15 +306,14 @@ static void disable_queues(struct hfi1_netdev_priv *priv)
  */
 int hfi1_netdev_rx_init(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	struct hfi1_netdev_rx *rx = dd->netdev_rx;
 	int res;
 
-	if (atomic_fetch_inc(&priv->netdevs))
+	if (atomic_fetch_inc(&rx->netdevs))
 		return 0;
 
 	mutex_lock(&hfi1_mutex);
-	init_dummy_netdev(dd->dummy_netdev);
-	res = hfi1_netdev_rxq_init(dd->dummy_netdev);
+	res = hfi1_netdev_rxq_init(rx);
 	mutex_unlock(&hfi1_mutex);
 	return res;
 }
@@ -328,12 +326,12 @@ int hfi1_netdev_rx_init(struct hfi1_devdata *dd)
  */
 int hfi1_netdev_rx_destroy(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	struct hfi1_netdev_rx *rx = dd->netdev_rx;
 
 	/* destroy the RX queues only if it is the last netdev going away */
-	if (atomic_fetch_add_unless(&priv->netdevs, -1, 0) == 1) {
+	if (atomic_fetch_add_unless(&rx->netdevs, -1, 0) == 1) {
 		mutex_lock(&hfi1_mutex);
-		hfi1_netdev_rxq_deinit(dd->dummy_netdev);
+		hfi1_netdev_rxq_deinit(rx);
 		mutex_unlock(&hfi1_mutex);
 	}
 
@@ -341,43 +339,46 @@ int hfi1_netdev_rx_destroy(struct hfi1_devdata *dd)
 }
 
 /**
- * hfi1_netdev_alloc - Allocates netdev and private data. It is required
- * because RMT index and MSI-X interrupt can be set only
- * during driver initialization.
- *
+ * hfi1_alloc_rx - Allocates the rx support structure
  * @dd: hfi1 dev data
+ *
+ * Allocate the rx structure to support gathering the receive
+ * resources and the dummy netdev.
+ *
+ * Updates dd struct pointer upon success.
+ *
+ * Return: 0 (success) -error on failure
+ *
  */
-int hfi1_netdev_alloc(struct hfi1_devdata *dd)
+int hfi1_alloc_rx(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv;
-	const int netdev_size = sizeof(*dd->dummy_netdev) +
-		sizeof(struct hfi1_netdev_priv);
+	struct hfi1_netdev_rx *rx;
 
-	dd_dev_info(dd, "allocating netdev size %d\n", netdev_size);
-	dd->dummy_netdev = kcalloc_node(1, netdev_size, GFP_KERNEL, dd->node);
+	dd_dev_info(dd, "allocating rx size %ld\n", sizeof(*rx));
+	rx = kzalloc_node(sizeof(*rx), GFP_KERNEL, dd->node);
 
-	if (!dd->dummy_netdev)
+	if (!rx)
 		return -ENOMEM;
+	rx->dd = dd;
+	init_dummy_netdev(&rx->rx_napi);
 
-	priv = hfi1_netdev_priv(dd->dummy_netdev);
-	priv->dd = dd;
-	xa_init(&priv->dev_tbl);
-	atomic_set(&priv->enabled, 0);
-	atomic_set(&priv->netdevs, 0);
+	xa_init(&rx->dev_tbl);
+	atomic_set(&rx->enabled, 0);
+	atomic_set(&rx->netdevs, 0);
+	dd->netdev_rx = rx;
 
 	return 0;
 }
 
-void hfi1_netdev_free(struct hfi1_devdata *dd)
+void hfi1_free_rx(struct hfi1_devdata *dd)
 {
-	if (dd->dummy_netdev) {
-		struct hfi1_netdev_priv *priv =
-			hfi1_netdev_priv(dd->dummy_netdev);
-
-		dd_dev_info(dd, "hfi1 netdev freed\n");
-		xa_destroy(&priv->dev_tbl);
-		kfree(dd->dummy_netdev);
-		dd->dummy_netdev = NULL;
+	if (dd->netdev_rx) {
+		struct hfi1_netdev_rx *rx = dd->netdev_rx;
+
+		dd_dev_info(dd, "hfi1 rx freed\n");
+		xa_destroy(&rx->dev_tbl);
+		kfree(dd->netdev_rx);
+		dd->netdev_rx = NULL;
 	}
 }
 
@@ -392,33 +393,33 @@ void hfi1_netdev_free(struct hfi1_devdata *dd)
  */
 void hfi1_netdev_enable_queues(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv;
+	struct hfi1_netdev_rx *rx;
 
-	if (!dd->dummy_netdev)
+	if (!dd->netdev_rx)
 		return;
 
-	priv = hfi1_netdev_priv(dd->dummy_netdev);
-	if (atomic_fetch_inc(&priv->enabled))
+	rx = dd->netdev_rx;
+	if (atomic_fetch_inc(&rx->enabled))
 		return;
 
 	mutex_lock(&hfi1_mutex);
-	enable_queues(priv);
+	enable_queues(rx);
 	mutex_unlock(&hfi1_mutex);
 }
 
 void hfi1_netdev_disable_queues(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv;
+	struct hfi1_netdev_rx *rx;
 
-	if (!dd->dummy_netdev)
+	if (!dd->netdev_rx)
 		return;
 
-	priv = hfi1_netdev_priv(dd->dummy_netdev);
-	if (atomic_dec_if_positive(&priv->enabled))
+	rx = dd->netdev_rx;
+	if (atomic_dec_if_positive(&rx->enabled))
 		return;
 
 	mutex_lock(&hfi1_mutex);
-	disable_queues(priv);
+	disable_queues(rx);
 	mutex_unlock(&hfi1_mutex);
 }
 
@@ -434,9 +435,9 @@ void hfi1_netdev_disable_queues(struct hfi1_devdata *dd)
  */
 int hfi1_netdev_add_data(struct hfi1_devdata *dd, int id, void *data)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	struct hfi1_netdev_rx *rx = dd->netdev_rx;
 
-	return xa_insert(&priv->dev_tbl, id, data, GFP_NOWAIT);
+	return xa_insert(&rx->dev_tbl, id, data, GFP_NOWAIT);
 }
 
 /**
@@ -448,9 +449,9 @@ int hfi1_netdev_add_data(struct hfi1_devdata *dd, int id, void *data)
  */
 void *hfi1_netdev_remove_data(struct hfi1_devdata *dd, int id)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	struct hfi1_netdev_rx *rx = dd->netdev_rx;
 
-	return xa_erase(&priv->dev_tbl, id);
+	return xa_erase(&rx->dev_tbl, id);
 }
 
 /**
@@ -461,9 +462,9 @@ void *hfi1_netdev_remove_data(struct hfi1_devdata *dd, int id)
  */
 void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	struct hfi1_netdev_rx *rx = dd->netdev_rx;
 
-	return xa_load(&priv->dev_tbl, id);
+	return xa_load(&rx->dev_tbl, id);
 }
 
 /**
@@ -474,11 +475,11 @@ void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id)
  */
 void *hfi1_netdev_get_first_data(struct hfi1_devdata *dd, int *start_id)
 {
-	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	struct hfi1_netdev_rx *rx = dd->netdev_rx;
 	unsigned long index = *start_id;
 	void *ret;
 
-	ret = xa_find(&priv->dev_tbl, &index, UINT_MAX, XA_PRESENT);
+	ret = xa_find(&rx->dev_tbl, &index, UINT_MAX, XA_PRESENT);
 	*start_id = (int)index;
 	return ret;
 }
-- 
1.8.3.1

