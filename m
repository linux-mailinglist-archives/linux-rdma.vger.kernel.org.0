Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5B40CA0C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhIOQ0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 12:26:43 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:9665
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhIOQ0m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 12:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jjv36nBejt40nqOj85UPf/2Bw/Glsbdfb+hK4pPKYyoGoEq+rjU5Y1uyZ4E4MIJ2lHdjIikPBBDCkngfaE451xk+L3cwnoxMrSjki4mCCuE1rK045+yXclur7/+Tr9Q9mY74mqnQp1YnhP/nvrn8szNoV6texfPuJ1kRNQseuxRnyHwgLr+xH7EHGF+y8mCRnxPrn2tWn02FjnQCQKRfokLgxyvJ8YVjQF5Y7q0Qacnj57w/MC5jueUDA80LpWE2r2kOoIS5GEAzAI9wArRRvQrLJ/blV4ehF0LqZKzyUeFluzq8iNzQURuHr6cQ8QAjsxrJG4kPUQ3P2oewD3kHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hKNWaTyQY5R5ah30BuDW+j9xWAbA7xKI0Qq/JmCiblM=;
 b=hw4eK7iEvGDEVTqBavzdEFDCMa9u8J/vF4LVEETOUZqKf3G/OVLOKslDDR/DGnFOrvN4UIzYxe2qk0pSccn7rpjLGfDIMU00XlWaJ+U2cH+YeHjFoEVAfByFl68QFz7rRCQzCoZjpBuLSyJQJKVrZbRYDpwygiEA1Db2/dBOYN5o5gxRJXLAn8fdrn0HUZIf7G7CeC6QEhDcvh1dj+LAwi1I27UYKa6K1b6CQLw3QFDrDS6ZTLdYqJOSXUQOzWZUIzd5aNG9KMszCJAIQCNvpYJjcgtO2TDVUh9TfY9/z8oJkyp7HnjCr0UQsjYTDUq51K0lJjPIyWefiRzzwayQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKNWaTyQY5R5ah30BuDW+j9xWAbA7xKI0Qq/JmCiblM=;
 b=OMNcbkq++9gv9UgSRyAIhw6rJnxqPcV7/NvmmR/qfJNkoOdSvHyoSd91hoQg91HspBm8IW0pFToGlg8hzEa1htFctnsFfC9DTW/mgvg7uu0Sl9/1EJXJz117lDwE3OoF1+ZiXWbvlyljUmkgDp3R0MIJtIHLTHN/6H8dG/iX/5OExPra28of0CW3Xg49+3jaV+P1Bz8dCYK91jaF4HxYI2xHtukobC4Q/RiaI9CJunSOerFtlnf5Fk+DnqAjLd6EMNb80mEx5g9D+Oftjof3HwTblnVTz9igYqbCClT77EnmYXIgqiwW2KS4LOeAEg6cdh/BsBTyl5hyz83u4n+K5Q==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 16:25:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 16:25:21 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/cma: Split apart the multiple uses of the same list heads
Date:   Wed, 15 Sep 2021 13:25:19 -0300
Message-Id: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:40::39) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by BYAPR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:40::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:25:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQXip-00135X-DY     for linux-rdma@vger.kernel.org; Wed, 15 Sep 2021 13:25:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3382b91d-d56f-433d-948e-08d978656a23
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5256D2262E4BCC87C94B9FD2C2DB9@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+7my9zfcI7qhx2TpCvSk1KKNN7CYWOo6Hl7ntf7I9TB9Ybjg8zkFU32lVPlTDr9CC4HO3CpypC49UMSgO9JDquke6ih3svAmuhELI3ms0hfXoLptXqzJx47RaD3vgZvpONE2/RKfSitDzKroh6jEiTprs3xpMUNcQJ/9cH5jGcI2RsPqcW7L56g/fBZUMlisvC19ImWpe23LsxiJ69/1SrASq+ejOGYtbPOQZKHlVUYK+5z6yM01szRZIViUNSM1483Ps0eQ7zQO3csixwMjqTy+TagqPYISJHNik7IteOfFz1tCjv8SWHrQyhitfCiXVrBKgbnQ+v6+0t01xUrvLwjJEwkSB4Gf3PauTJK6Bsg6/h8CSK6KU2OdsfHY5qcIWzdNhcv/5zA9yf2e0908vp/PIrkFJU2Im+TyrtVYu292ZD0tu7n5pl73VJpIwukaQXJ5BPD6wrb1pm82CuqjqsIPm426IoV9zLqrIOEE5823EAGpkfopGKB3gAczSbSCjdQnnyflt1N++jfOUsjcSEluGCW2vU1Ql/soNki9FwayoiuElrGmrg4NfAn29BM40omgSYz1lOFgFHJZvj8RbO5unHxD1LKQsNdcUmJOqvdWMnO8TxyXY2feEOnma+4YiiV5KA1ymrR3MDSRD2CVtmXFcgnl53PVIfcJxQ6E2NZECa2qZPptHIsxPVIsUKX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(2906002)(36756003)(38100700002)(8676002)(186003)(8936002)(26005)(86362001)(83380400001)(6916009)(2616005)(478600001)(426003)(5660300002)(66476007)(66556008)(66946007)(9746002)(9786002)(316002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKyRWvadQGCt+IC/UGdeMSvx52aRW5WXe5WGXEXLcXuUQbX0uM/DwB+tFKsE?=
 =?us-ascii?Q?3TqJ/BO77BE2RLRK0V1ksS/t730z3rlYRq40vJvQg2sl/OpVle5MJlxBuJdh?=
 =?us-ascii?Q?x8zy+iaLzwSmrE+H8Ao9aKlY1XEWXPbAj02F2nd+W1TTRQ3bvUmyaqV0L9Lk?=
 =?us-ascii?Q?YuYfYiaIphbYLFE/1MbKXqdQr9wPUHR0CPNAhLxQqJ76enpeshoYYSnkWuGk?=
 =?us-ascii?Q?81bofoj4zA0r7RTVY5rhqGLFzqM8ftnqEjP7CeQRhyb68u68euR42B+qaKD9?=
 =?us-ascii?Q?xlPdmXWHi3NE4/QmjWzb5FJRU159H8x0hRPoS5H1QszcqzFll/lsSDouJ5ld?=
 =?us-ascii?Q?ONRFinEHciCT6GC7XBaiF0NGZLkQGPGdblOt/s8W75KXC1lfxKf54DVFZ2WK?=
 =?us-ascii?Q?r0KhNAvbjiQ0NN5zcFyVNXRUeOfuunKedU0CRorejTPh8l8KpiAtCMENa9Hr?=
 =?us-ascii?Q?nm3PPN15O8l5+G0MyoeKNhzXXR1lieLvTeCDrtUg/K43t5k65lkFJNQokCGA?=
 =?us-ascii?Q?FYiR/I7c1f3yxp95kV73XjfQO+wFqGgW5YZfGlfRokfI/03oy8CyQgWaWGGy?=
 =?us-ascii?Q?/u/HXMoi2ReDba+M9HvMxWThyGFT+TOFVdTCX/OugGFbt99dwg8NGtdQgHKV?=
 =?us-ascii?Q?hrFk7/0g0Uw9iST/BTiMBDQ7UPln8h8o/Xv1Bcyg/5BMK2oeQQKfh2MNaIaT?=
 =?us-ascii?Q?lJs5bAp3AMBn5VfBAX/eLxmGMf9wGO+LxHHazDJ/G9Xn5XOaJsZf8kgC47O6?=
 =?us-ascii?Q?rt7J2CC8lspNkkWmEiMIY1D/1Mv979wvEMmnRvCRiJTzHZKRH8GMWoSmqPPa?=
 =?us-ascii?Q?iKSmP61EGv0h5BJ7/woSZKb+m06v7dmYFIxtp64IbLIxiX0pv9LjuCZlE+1p?=
 =?us-ascii?Q?yeGo70nc51PQh+ggBhZn66LzlauTvYMPhE8X0YG9168BlbpI9VDsJTJy0PI8?=
 =?us-ascii?Q?kZfHrzVG9Wg1ZmKpT+xEtINo391v/v+ZRnd4w+tv5WZMqXCVzY4xTuYYDDzE?=
 =?us-ascii?Q?4/Gn3KlhbpCoBeFYCPdS1bco5seZBdXbgJ+cL+eHwXLC7/bPe21bwPdXJ4+m?=
 =?us-ascii?Q?1Ttj8M5i3Py1Jxp+h5YT6wMaiYO72HoipTNK9XwqHtL5G4wCHmlDce1p7dya?=
 =?us-ascii?Q?cJivWinJgNznwcSvCJ9iwnD6UnOcOwVg9hxPGJcn0dI6ao8+jvsCCcnZ/DVM?=
 =?us-ascii?Q?2JeTFiUDfXSdz7HqRPNGekkv0s6jz8/IX1aikYkI1sKoWg7s3ocoCZltQogp?=
 =?us-ascii?Q?fzqC/iNoH6kDHnIEdpOflh0DdxG47W+P0koEI0izs/yxeUfK85dSSBG+u4v7?=
 =?us-ascii?Q?wJumBsZfd9XEI5bKqzGEXzad?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3382b91d-d56f-433d-948e-08d978656a23
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:25:21.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQkYWJ0gzN8RvKBzBu1PIXGNeSWklRGiNBt6Fi4QF9+8KeVcbxGU1MeKTmLxdqOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Two list heads in the rdma_id_private are being used for multiple
purposes, to save a few bytes of memory. Give the different purposes
different names and union the memory that is clearly exclusive.

list splits into device_item and listen_any_item. device_item is threaded
onto the cma_device's list and listen_any goes onto the
listen_any_list. IDs doing any listen cannot have devices.

listen_list splits into listen_item and listen_list. listen_list is on the
parent listen any rdma_id_private and listen_item is on child listen that
is bound to a specific cma_dev.

Which name should be used in which case depends on the state and other
factors of the rdma_id_private. Remap all the confusing references to make
sense with the new names, so at least there is some hope of matching the
necessary preconditions with each access.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c      | 34 ++++++++++++++++--------------
 drivers/infiniband/core/cma_priv.h | 11 ++++++++--
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5aa58897965df4..f671771a474288 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -453,7 +453,7 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	id_priv->id.device = cma_dev->device;
 	id_priv->id.route.addr.dev_addr.transport =
 		rdma_node_get_transport(cma_dev->device->node_type);
-	list_add_tail(&id_priv->list, &cma_dev->id_list);
+	list_add_tail(&id_priv->device_item, &cma_dev->id_list);
 
 	trace_cm_id_attach(id_priv, cma_dev->device);
 }
@@ -470,7 +470,7 @@ static void cma_attach_to_dev(struct rdma_id_private *id_priv,
 static void cma_release_dev(struct rdma_id_private *id_priv)
 {
 	mutex_lock(&lock);
-	list_del(&id_priv->list);
+	list_del_init(&id_priv->device_item);
 	cma_dev_put(id_priv->cma_dev);
 	id_priv->cma_dev = NULL;
 	id_priv->id.device = NULL;
@@ -854,6 +854,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	init_completion(&id_priv->comp);
 	refcount_set(&id_priv->refcount, 1);
 	mutex_init(&id_priv->handler_mutex);
+	INIT_LIST_HEAD(&id_priv->device_item);
 	INIT_LIST_HEAD(&id_priv->listen_list);
 	INIT_LIST_HEAD(&id_priv->mc_list);
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
@@ -1647,7 +1648,7 @@ static struct rdma_id_private *cma_find_listener(
 				return id_priv;
 			list_for_each_entry(id_priv_dev,
 					    &id_priv->listen_list,
-					    listen_list) {
+					    listen_item) {
 				if (id_priv_dev->id.device == cm_id->device &&
 				    cma_match_net_dev(&id_priv_dev->id,
 						      net_dev, req))
@@ -1756,14 +1757,15 @@ static void _cma_cancel_listens(struct rdma_id_private *id_priv)
 	 * Remove from listen_any_list to prevent added devices from spawning
 	 * additional listen requests.
 	 */
-	list_del(&id_priv->list);
+	list_del_init(&id_priv->listen_any_item);
 
 	while (!list_empty(&id_priv->listen_list)) {
-		dev_id_priv = list_entry(id_priv->listen_list.next,
-					 struct rdma_id_private, listen_list);
+		dev_id_priv =
+			list_first_entry(&id_priv->listen_list,
+					 struct rdma_id_private, listen_item);
 		/* sync with device removal to avoid duplicate destruction */
-		list_del_init(&dev_id_priv->list);
-		list_del(&dev_id_priv->listen_list);
+		list_del_init(&dev_id_priv->device_item);
+		list_del_init(&dev_id_priv->listen_item);
 		mutex_unlock(&lock);
 
 		rdma_destroy_id(&dev_id_priv->id);
@@ -2556,7 +2558,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
 	if (ret)
 		goto err_listen;
-	list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
+	list_add_tail(&dev_id_priv->listen_item, &id_priv->listen_list);
 	return 0;
 err_listen:
 	/* Caller must destroy this after releasing lock */
@@ -2572,13 +2574,13 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
 	int ret;
 
 	mutex_lock(&lock);
-	list_add_tail(&id_priv->list, &listen_any_list);
+	list_add_tail(&id_priv->listen_any_item, &listen_any_list);
 	list_for_each_entry(cma_dev, &dev_list, list) {
 		ret = cma_listen_on_dev(id_priv, cma_dev, &to_destroy);
 		if (ret) {
 			/* Prevent racing with cma_process_remove() */
 			if (to_destroy)
-				list_del_init(&to_destroy->list);
+				list_del_init(&to_destroy->device_item);
 			goto err_listen;
 		}
 	}
@@ -4868,7 +4870,7 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
 
 	mutex_lock(&lock);
 	list_for_each_entry(cma_dev, &dev_list, list)
-		list_for_each_entry(id_priv, &cma_dev->id_list, list) {
+		list_for_each_entry(id_priv, &cma_dev->id_list, device_item) {
 			ret = cma_netdev_change(ndev, id_priv);
 			if (ret)
 				goto out;
@@ -4928,10 +4930,10 @@ static void cma_process_remove(struct cma_device *cma_dev)
 	mutex_lock(&lock);
 	while (!list_empty(&cma_dev->id_list)) {
 		struct rdma_id_private *id_priv = list_first_entry(
-			&cma_dev->id_list, struct rdma_id_private, list);
+			&cma_dev->id_list, struct rdma_id_private, device_item);
 
-		list_del(&id_priv->listen_list);
-		list_del_init(&id_priv->list);
+		list_del_init(&id_priv->listen_item);
+		list_del_init(&id_priv->device_item);
 		cma_id_get(id_priv);
 		mutex_unlock(&lock);
 
@@ -5008,7 +5010,7 @@ static int cma_add_one(struct ib_device *device)
 
 	mutex_lock(&lock);
 	list_add_tail(&cma_dev->list, &dev_list);
-	list_for_each_entry(id_priv, &listen_any_list, list) {
+	list_for_each_entry(id_priv, &listen_any_list, listen_any_item) {
 		ret = cma_listen_on_dev(id_priv, cma_dev, &to_destroy);
 		if (ret)
 			goto free_listen;
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 5c463da9984536..666d8abdfe4e84 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -55,8 +55,15 @@ struct rdma_id_private {
 
 	struct rdma_bind_list	*bind_list;
 	struct hlist_node	node;
-	struct list_head	list; /* listen_any_list or cma_device.list */
-	struct list_head	listen_list; /* per device listens */
+	union {
+		struct list_head device_item; /* On cma_device->id_list */
+		struct list_head listen_any_item; /* On listen_any_list */
+	};
+	union {
+		/* On rdma_id_private->listen_list */
+		struct list_head listen_item;
+		struct list_head listen_list;
+	};
 	struct cma_device	*cma_dev;
 	struct list_head	mc_list;
 

base-commit: ca465e1f1f9b38fe916a36f7d80c5d25f2337c81
-- 
2.33.0

