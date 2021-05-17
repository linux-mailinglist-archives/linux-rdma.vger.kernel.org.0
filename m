Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03D383A63
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhEQQte (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:34 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:14656
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237996AbhEQQtK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpdPmiqnHOnIpcsptQlDKWGwxFMJuadprVOLRtLTQnnsTGqZ9IlS+gTM71LHJPkpU2MklwEhyZPoldLts0ITaX6bunKsejxxxNPZAz6ukqiEH11tuMcyAOiIhrQQtYwFubEdVwZoeQeGhDiQx3EAheTHgl5XCgDXWbfwh8m69ALzBPOw2rvslWqIfLHZ5Iuz7J/ZRfgNbV30vt5inXyT3eoGi9hKiBiPtTBR7rTmnsWciFXN/tiZDqU/bQC8Y1SebkqIrO1PrhvzOIen+Kr+MZ50ZwDxDe/X9UmZ95IbIJ2wimeumrqekYRpvZjCHSuTZK5/lIMn8eaO16jbVJc5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xO15ZxGy5MNGV12VE4Xd6fLI68vRw2erWsdjCJQW3U=;
 b=WP1puGmvvaCYX+E2qFuQHeN92gezFihePsclO5XBN3zJ4jHwx3Qgg/4LXBbzaJWeq/NNPDiVvfxfmeqTFLKNvRokqPP5Novd84JXsQqmWJaumQazMp35FdgLPinJDfBH038qD9Y7L4GG41PUdPFzW/hCPOOAyZIi1o9ADbL4DmiI7ZgPbNX4VhGXM2OmudI6QQkU9GhwAjNfAOuvFlHwq4PfEAGnd9h9iubHKsFpjudr/jnUfM1QXoTgMDoBOmv96dd1tUCgPvF6ly5EPxmLk3xYaEILbSUkSmeW40RnXbtncBJwbcUce1O/uY1cujUOO964/4YipEs2YQUevEDQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xO15ZxGy5MNGV12VE4Xd6fLI68vRw2erWsdjCJQW3U=;
 b=fTExg+Lt0Y7thRhgIJS0nJ47HZ/Tqw3+iDOKM3HH22Kbg0B09aDA4yqvgSABp99FtaXwHHllLShl7nM0ref6eaWC/ZadEIHbM5hAOHreW71/mJxCswbhBKUjObBuQRTgFrWFQldSZkfL1aorJ48xv38Tr2pJ+s+LPqMFUu4nkeyhLxQKCj34dGy9MXMEqKmgB/D/zQow5Ly6SGA4Ucqvb06mz56B3FPyOHKoGTMLApb35sW3pKJGM5OXLUl0uyKBsDuAsK1Hf2aMZIpZvGEhiNJkhRnIlUpXDsKANNPtEclBxxEjz6JQ2sKaTWKtm7sbOfYXgr7n2EaFGiv0w81rHw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 12/13] RDMA/hfi1: Use attributes for the port sysfs
Date:   Mon, 17 May 2021 13:47:40 -0300
Message-Id: <12-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 16:47:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LZ4-9r; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64b60d2-3813-4793-1d73-08d919537dd7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285806007EB6B579B01AC081C22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Y9q7fMSx+AR7AtFJxV0bBN2GETJKyxZeAu48EuB3KBKt1hSKbgebwBHoEyzEdvpsnQYK5HOQVXy2yc8X5AQ/s97t1BTAX8Ncu6PVwOcZaTRuU7POQzIncg92mYHFP3EF8v1wjmpjMIB3GARQZzBPqrf1VWgRF2+fgZmTDBePHDolvMnWp1TCq5alqHKevUPeq+7lHC9ZQ/gKG60dezwW/4sfAdlXE4SCnTUOrg70NmVvy9Iw8yKPM5+CRjssL3TZUPSctQfpsFBY6OXja9rfvrGgCquDlkJ4XBHlPC1+ISRKbMbsPh5JGGL0tHwLacFlf7KBw7YYsj4Un7icCjVtTB4nopwdWHxUHD/KId1eJkWNbB4X0vyC6B/noQTiIr04O91BRCMJAd76F7f6co28ItPYWvVYoQps5RkGtevNjB7Prt6kVQ3lyLzETTZ5pR4o7H1iT6Of1TJmW2tnf196FtgeQ2ooiiembsqXxynbxVzEVOMtUMwgThw+g92bwefyuP+Ib8gzuD9apN0SH0Vyp8sDU/fFdWVfWx7l/10Y7DRPCKippeDTm8cBfDki0/Djm6TXu2H+AMs9f0jtGQXHNrsI8e9WQ7s1jQLjNegjvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(110136005)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jRVxxSgNNmahRM5uhg/In07CVbyIUAYhxvPAtqVddPqKBwW/BPito+d46ne1?=
 =?us-ascii?Q?xaIALQfcQh1QbQGlwym7SeDejqL34+wnxXzGyX6S9vSsrnsIYXsS3Znebt00?=
 =?us-ascii?Q?m0Y5JbaWNoMli/VnWoR0X8BI8Di2L7E//asXuA4e/42OPsbigmy6jvCjFX/j?=
 =?us-ascii?Q?mVPgkOQoMy/APVJhcdlRrW+WO0A+b6DGomH80tmMQczWqrKXW24KfMWrKoSn?=
 =?us-ascii?Q?UfKY/YDD9IsVFPXOQoo7vkAHswu05Xtuzq1oSCJ1cKGhjcRVeEw+KyO0hFbT?=
 =?us-ascii?Q?yxxTwe3NMaTai9MGA9PFGYAdwxDbbaKlBOHvxLZOxSFszWozHWLQni2xAMHu?=
 =?us-ascii?Q?3hXqIA2K1mT0hC1zvmjKpOekita62rPux+QwBQ/VCb47szlw7+GG9TdKqs/3?=
 =?us-ascii?Q?Sr8uW1ynTxoIvOD26WiZuRQgpMwM/jsaepjzD99xtBGN4nDdnOo8IWBPxGTt?=
 =?us-ascii?Q?O4LQkngEeeYSHILvtQJpec2pyp8782nNsp0v7gbgykAppsUTdw2r42Xv2UqS?=
 =?us-ascii?Q?GvL0HziHZ3QKizC0cPpeyNJSWRqAC3wNJbAqW0D9IdCemL4hAeSWUDVRz2Jm?=
 =?us-ascii?Q?UT0P/A1c9G+l29Y4sWnkbd/wixygohRCG8L0bNIp0JAxFsfrCZfOPKNhJpaH?=
 =?us-ascii?Q?mDxuiNXcGAIxqwvDdVSEVgrwIupUGssjZn5hNL6olRKY1cUyt6z2VVtE5wLS?=
 =?us-ascii?Q?PwHO6rwdNPho9NRLZ8ljY7BdBDKvO+ftoQtuWseXu2i5jDvV6L9JWzzhHND1?=
 =?us-ascii?Q?a8VnzP9cdyZDCCMJsRzG594RrzOOPI2ocZZBTxugS70NQ2OoEMj2WBrYf0ME?=
 =?us-ascii?Q?u69D3kFB+ggZ4PtdRyZerVF0zinVdP1sl4rriObZwYKXKQh58uEkNwwlK6BT?=
 =?us-ascii?Q?o1QnkKEKl8V8LQfQKCGI1s0S8FSSmpj8wXYDjuVe/dPljalKDg5+izY7ECIx?=
 =?us-ascii?Q?neFK7GlLOnS6rjZLNkuXyfPGVFaQF68LSH15SxYueHcvZ7wb6OeQY+N14btp?=
 =?us-ascii?Q?JyS3prlJBEVuzXs7rX5fs96iaY6MounCKeKwRKM+ARoRNiOWutt+8YDv5u80?=
 =?us-ascii?Q?lBnfljB5+N4nKre6grcbImKtPL6zETXxTPRAKBcNqwizTM++BQOI5vQU76GH?=
 =?us-ascii?Q?TPMbk9FlZxmN1rTkkbWH0bEAkae6ZvgbUFYaRGSkZf/gmA8/PqbPBenxw7NW?=
 =?us-ascii?Q?Qdurz6jk3gvIUqDb0aLuazcNrIlfKTN2F4d/lFUgmd8X3ENc/VGIT8hCQWlw?=
 =?us-ascii?Q?R/WckuiSEhup+em7PLG5KT9CWop4HVD3TJ4vqufNYUFLqR+DCzjp5rwFeDV5?=
 =?us-ascii?Q?BWZJo9UnIZYmQhwP7habyhcy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64b60d2-3813-4793-1d73-08d919537dd7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:43.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru9b4Fcw9ohQBIAfx0Qefdjx5SGt3M9x5tZTzv9OjQP+rfqb5ZPo5NU2Uj9OxRDW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hfi1 should not be creating a mess of kobjects to attach to the port
kobject - this is all attributes. The proper API is to create an
attribute_group list and create it against the port's kobject.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hfi1/hfi.h   |   4 -
 drivers/infiniband/hw/hfi1/sysfs.c | 529 +++++++++++------------------
 2 files changed, 193 insertions(+), 340 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 867ae0b1aa9593..87e101fb1f658a 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -772,10 +772,6 @@ struct hfi1_pportdata {
 	struct hfi1_ibport ibport_data;
 
 	struct hfi1_devdata *dd;
-	struct kobject pport_cc_kobj;
-	struct kobject sc2vl_kobj;
-	struct kobject sl2sc_kobj;
-	struct kobject vl2mtu_kobj;
 
 	/* PHY support */
 	struct qsfp_data qsfp_info;
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index eaf441ece25eb8..326c6c2842f2f3 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -45,11 +45,21 @@
  *
  */
 #include <linux/ctype.h>
+#include <rdma/ib_sysfs.h>
 
 #include "hfi.h"
 #include "mad.h"
 #include "trace.h"
 
+static struct hfi1_pportdata *hfi1_get_pportdata_kobj(struct kobject *kobj)
+{
+	u32 port_num;
+	struct ib_device *ibdev = ib_port_sysfs_get_ibdev_kobj(kobj, &port_num);
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+
+	return &dd->pport[port_num - 1];
+}
+
 /*
  * Start of per-port congestion control structures and support code
  */
@@ -57,13 +67,12 @@
 /*
  * Congestion control table size followed by table entries
  */
-static ssize_t read_cc_table_bin(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
-				 char *buf, loff_t pos, size_t count)
+static ssize_t cc_table_bin_read(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *bin_attr, char *buf,
+				 loff_t pos, size_t count)
 {
 	int ret;
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, pport_cc_kobj);
+	struct hfi1_pportdata *ppd = hfi1_get_pportdata_kobj(kobj);
 	struct cc_state *cc_state;
 
 	ret = ppd->total_cct_entry * sizeof(struct ib_cc_table_entry_shadow)
@@ -89,30 +98,19 @@ static ssize_t read_cc_table_bin(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-
-static void port_release(struct kobject *kobj)
-{
-	/* nothing to do since memory is freed by hfi1_free_devdata() */
-}
-
-static const struct bin_attribute cc_table_bin_attr = {
-	.attr = {.name = "cc_table_bin", .mode = 0444},
-	.read = read_cc_table_bin,
-	.size = PAGE_SIZE,
-};
+static BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
 
 /*
  * Congestion settings: port control, control map and an array of 16
  * entries for the congestion entries - increase, timer, event log
  * trigger threshold and the minimum injection rate delay.
  */
-static ssize_t read_cc_setting_bin(struct file *filp, struct kobject *kobj,
+static ssize_t cc_setting_bin_read(struct file *filp, struct kobject *kobj,
 				   struct bin_attribute *bin_attr,
 				   char *buf, loff_t pos, size_t count)
 {
+	struct hfi1_pportdata *ppd = hfi1_get_pportdata_kobj(kobj);
 	int ret;
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, pport_cc_kobj);
 	struct cc_state *cc_state;
 
 	ret = sizeof(struct opa_congestion_setting_attr_shadow);
@@ -136,27 +134,30 @@ static ssize_t read_cc_setting_bin(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
+static BIN_ATTR_RO(cc_setting_bin, PAGE_SIZE);
 
-static const struct bin_attribute cc_setting_bin_attr = {
-	.attr = {.name = "cc_settings_bin", .mode = 0444},
-	.read = read_cc_setting_bin,
-	.size = PAGE_SIZE,
-};
-
-struct hfi1_port_attr {
-	struct attribute attr;
-	ssize_t	(*show)(struct hfi1_pportdata *, char *);
-	ssize_t	(*store)(struct hfi1_pportdata *, const char *, size_t);
+static struct bin_attribute *port_cc_bin_attributes[] = {
+	&bin_attr_cc_setting_bin,
+	&bin_attr_cc_table_bin,
+	NULL
 };
 
-static ssize_t cc_prescan_show(struct hfi1_pportdata *ppd, char *buf)
+static ssize_t cc_prescan_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
 {
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi1_pportdata *ppd = &dd->pport[port_num - 1];
+
 	return sysfs_emit(buf, "%s\n", ppd->cc_prescan ? "on" : "off");
 }
 
-static ssize_t cc_prescan_store(struct hfi1_pportdata *ppd, const char *buf,
+static ssize_t cc_prescan_store(struct ib_device *ibdev, u32 port_num,
+				struct ib_port_attribute *attr, const char *buf,
 				size_t count)
 {
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi1_pportdata *ppd = &dd->pport[port_num - 1];
+
 	if (!memcmp(buf, "on", 2))
 		ppd->cc_prescan = true;
 	else if (!memcmp(buf, "off", 3))
@@ -164,60 +165,41 @@ static ssize_t cc_prescan_store(struct hfi1_pportdata *ppd, const char *buf,
 
 	return count;
 }
+static IB_PORT_ATTR_ADMIN_RW(cc_prescan);
 
-static struct hfi1_port_attr cc_prescan_attr =
-		__ATTR(cc_prescan, 0600, cc_prescan_show, cc_prescan_store);
-
-static ssize_t cc_attr_show(struct kobject *kobj, struct attribute *attr,
-			    char *buf)
-{
-	struct hfi1_port_attr *port_attr =
-		container_of(attr, struct hfi1_port_attr, attr);
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, pport_cc_kobj);
-
-	return port_attr->show(ppd, buf);
-}
-
-static ssize_t cc_attr_store(struct kobject *kobj, struct attribute *attr,
-			     const char *buf, size_t count)
-{
-	struct hfi1_port_attr *port_attr =
-		container_of(attr, struct hfi1_port_attr, attr);
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, pport_cc_kobj);
-
-	return port_attr->store(ppd, buf, count);
-}
-
-static const struct sysfs_ops port_cc_sysfs_ops = {
-	.show = cc_attr_show,
-	.store = cc_attr_store
-};
-
-static struct attribute *port_cc_default_attributes[] = {
-	&cc_prescan_attr.attr,
+static struct attribute *port_cc_attributes[] = {
+	&ib_port_attr_cc_prescan.attr,
 	NULL
 };
 
-static struct kobj_type port_cc_ktype = {
-	.release = port_release,
-	.sysfs_ops = &port_cc_sysfs_ops,
-	.default_attrs = port_cc_default_attributes
+static const struct attribute_group port_cc_group = {
+	.name = "CCMgtA",
+	.attrs = port_cc_attributes,
+	.bin_attrs = port_cc_bin_attributes,
 };
 
 /* Start sc2vl */
-#define HFI1_SC2VL_ATTR(N)				    \
-	static struct hfi1_sc2vl_attr hfi1_sc2vl_attr_##N = { \
-		.attr = { .name = __stringify(N), .mode = 0444 }, \
-		.sc = N \
-	}
-
 struct hfi1_sc2vl_attr {
-	struct attribute attr;
+	struct ib_port_attribute attr;
 	int sc;
 };
 
+static ssize_t sc2vl_attr_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi1_sc2vl_attr *sattr =
+		container_of(attr, struct hfi1_sc2vl_attr, attr);
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+
+	return sysfs_emit(buf, "%u\n", *((u8 *)dd->sc2vl + sattr->sc));
+}
+
+#define HFI1_SC2VL_ATTR(N)                                                     \
+	static struct hfi1_sc2vl_attr hfi1_sc2vl_attr_##N = {                  \
+		.attr = __ATTR(N, 0444, sc2vl_attr_show, NULL),                \
+		.sc = N,                                                       \
+	}
+
 HFI1_SC2VL_ATTR(0);
 HFI1_SC2VL_ATTR(1);
 HFI1_SC2VL_ATTR(2);
@@ -251,78 +233,70 @@ HFI1_SC2VL_ATTR(29);
 HFI1_SC2VL_ATTR(30);
 HFI1_SC2VL_ATTR(31);
 
-static struct attribute *sc2vl_default_attributes[] = {
-	&hfi1_sc2vl_attr_0.attr,
-	&hfi1_sc2vl_attr_1.attr,
-	&hfi1_sc2vl_attr_2.attr,
-	&hfi1_sc2vl_attr_3.attr,
-	&hfi1_sc2vl_attr_4.attr,
-	&hfi1_sc2vl_attr_5.attr,
-	&hfi1_sc2vl_attr_6.attr,
-	&hfi1_sc2vl_attr_7.attr,
-	&hfi1_sc2vl_attr_8.attr,
-	&hfi1_sc2vl_attr_9.attr,
-	&hfi1_sc2vl_attr_10.attr,
-	&hfi1_sc2vl_attr_11.attr,
-	&hfi1_sc2vl_attr_12.attr,
-	&hfi1_sc2vl_attr_13.attr,
-	&hfi1_sc2vl_attr_14.attr,
-	&hfi1_sc2vl_attr_15.attr,
-	&hfi1_sc2vl_attr_16.attr,
-	&hfi1_sc2vl_attr_17.attr,
-	&hfi1_sc2vl_attr_18.attr,
-	&hfi1_sc2vl_attr_19.attr,
-	&hfi1_sc2vl_attr_20.attr,
-	&hfi1_sc2vl_attr_21.attr,
-	&hfi1_sc2vl_attr_22.attr,
-	&hfi1_sc2vl_attr_23.attr,
-	&hfi1_sc2vl_attr_24.attr,
-	&hfi1_sc2vl_attr_25.attr,
-	&hfi1_sc2vl_attr_26.attr,
-	&hfi1_sc2vl_attr_27.attr,
-	&hfi1_sc2vl_attr_28.attr,
-	&hfi1_sc2vl_attr_29.attr,
-	&hfi1_sc2vl_attr_30.attr,
-	&hfi1_sc2vl_attr_31.attr,
+static struct attribute *port_sc2vl_attributes[] = {
+	&hfi1_sc2vl_attr_0.attr.attr,
+	&hfi1_sc2vl_attr_1.attr.attr,
+	&hfi1_sc2vl_attr_2.attr.attr,
+	&hfi1_sc2vl_attr_3.attr.attr,
+	&hfi1_sc2vl_attr_4.attr.attr,
+	&hfi1_sc2vl_attr_5.attr.attr,
+	&hfi1_sc2vl_attr_6.attr.attr,
+	&hfi1_sc2vl_attr_7.attr.attr,
+	&hfi1_sc2vl_attr_8.attr.attr,
+	&hfi1_sc2vl_attr_9.attr.attr,
+	&hfi1_sc2vl_attr_10.attr.attr,
+	&hfi1_sc2vl_attr_11.attr.attr,
+	&hfi1_sc2vl_attr_12.attr.attr,
+	&hfi1_sc2vl_attr_13.attr.attr,
+	&hfi1_sc2vl_attr_14.attr.attr,
+	&hfi1_sc2vl_attr_15.attr.attr,
+	&hfi1_sc2vl_attr_16.attr.attr,
+	&hfi1_sc2vl_attr_17.attr.attr,
+	&hfi1_sc2vl_attr_18.attr.attr,
+	&hfi1_sc2vl_attr_19.attr.attr,
+	&hfi1_sc2vl_attr_20.attr.attr,
+	&hfi1_sc2vl_attr_21.attr.attr,
+	&hfi1_sc2vl_attr_22.attr.attr,
+	&hfi1_sc2vl_attr_23.attr.attr,
+	&hfi1_sc2vl_attr_24.attr.attr,
+	&hfi1_sc2vl_attr_25.attr.attr,
+	&hfi1_sc2vl_attr_26.attr.attr,
+	&hfi1_sc2vl_attr_27.attr.attr,
+	&hfi1_sc2vl_attr_28.attr.attr,
+	&hfi1_sc2vl_attr_29.attr.attr,
+	&hfi1_sc2vl_attr_30.attr.attr,
+	&hfi1_sc2vl_attr_31.attr.attr,
 	NULL
 };
 
-static ssize_t sc2vl_attr_show(struct kobject *kobj, struct attribute *attr,
-			       char *buf)
-{
-	struct hfi1_sc2vl_attr *sattr =
-		container_of(attr, struct hfi1_sc2vl_attr, attr);
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, sc2vl_kobj);
-	struct hfi1_devdata *dd = ppd->dd;
-
-	return sysfs_emit(buf, "%u\n", *((u8 *)dd->sc2vl + sattr->sc));
-}
-
-static const struct sysfs_ops hfi1_sc2vl_ops = {
-	.show = sc2vl_attr_show,
+static const struct attribute_group port_sc2vl_group = {
+	.name = "sc2vl",
+	.attrs = port_sc2vl_attributes,
 };
-
-static struct kobj_type hfi1_sc2vl_ktype = {
-	.release = port_release,
-	.sysfs_ops = &hfi1_sc2vl_ops,
-	.default_attrs = sc2vl_default_attributes
-};
-
 /* End sc2vl */
 
 /* Start sl2sc */
-#define HFI1_SL2SC_ATTR(N)				    \
-	static struct hfi1_sl2sc_attr hfi1_sl2sc_attr_##N = {	  \
-		.attr = { .name = __stringify(N), .mode = 0444 }, \
-		.sl = N						  \
-	}
-
 struct hfi1_sl2sc_attr {
-	struct attribute attr;
+	struct ib_port_attribute attr;
 	int sl;
 };
 
+static ssize_t sl2sc_attr_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi1_sl2sc_attr *sattr =
+		container_of(attr, struct hfi1_sl2sc_attr, attr);
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi1_ibport *ibp = &dd->pport[port_num - 1].ibport_data;
+
+	return sysfs_emit(buf, "%u\n", ibp->sl_to_sc[sattr->sl]);
+}
+
+#define HFI1_SL2SC_ATTR(N)                                                     \
+	static struct hfi1_sl2sc_attr hfi1_sl2sc_attr_##N = {                  \
+		.attr = __ATTR(N, 0444, sl2sc_attr_show, NULL), .sl = N        \
+	}
+
 HFI1_SL2SC_ATTR(0);
 HFI1_SL2SC_ATTR(1);
 HFI1_SL2SC_ATTR(2);
@@ -356,79 +330,72 @@ HFI1_SL2SC_ATTR(29);
 HFI1_SL2SC_ATTR(30);
 HFI1_SL2SC_ATTR(31);
 
-static struct attribute *sl2sc_default_attributes[] = {
-	&hfi1_sl2sc_attr_0.attr,
-	&hfi1_sl2sc_attr_1.attr,
-	&hfi1_sl2sc_attr_2.attr,
-	&hfi1_sl2sc_attr_3.attr,
-	&hfi1_sl2sc_attr_4.attr,
-	&hfi1_sl2sc_attr_5.attr,
-	&hfi1_sl2sc_attr_6.attr,
-	&hfi1_sl2sc_attr_7.attr,
-	&hfi1_sl2sc_attr_8.attr,
-	&hfi1_sl2sc_attr_9.attr,
-	&hfi1_sl2sc_attr_10.attr,
-	&hfi1_sl2sc_attr_11.attr,
-	&hfi1_sl2sc_attr_12.attr,
-	&hfi1_sl2sc_attr_13.attr,
-	&hfi1_sl2sc_attr_14.attr,
-	&hfi1_sl2sc_attr_15.attr,
-	&hfi1_sl2sc_attr_16.attr,
-	&hfi1_sl2sc_attr_17.attr,
-	&hfi1_sl2sc_attr_18.attr,
-	&hfi1_sl2sc_attr_19.attr,
-	&hfi1_sl2sc_attr_20.attr,
-	&hfi1_sl2sc_attr_21.attr,
-	&hfi1_sl2sc_attr_22.attr,
-	&hfi1_sl2sc_attr_23.attr,
-	&hfi1_sl2sc_attr_24.attr,
-	&hfi1_sl2sc_attr_25.attr,
-	&hfi1_sl2sc_attr_26.attr,
-	&hfi1_sl2sc_attr_27.attr,
-	&hfi1_sl2sc_attr_28.attr,
-	&hfi1_sl2sc_attr_29.attr,
-	&hfi1_sl2sc_attr_30.attr,
-	&hfi1_sl2sc_attr_31.attr,
+static struct attribute *port_sl2sc_attributes[] = {
+	&hfi1_sl2sc_attr_0.attr.attr,
+	&hfi1_sl2sc_attr_1.attr.attr,
+	&hfi1_sl2sc_attr_2.attr.attr,
+	&hfi1_sl2sc_attr_3.attr.attr,
+	&hfi1_sl2sc_attr_4.attr.attr,
+	&hfi1_sl2sc_attr_5.attr.attr,
+	&hfi1_sl2sc_attr_6.attr.attr,
+	&hfi1_sl2sc_attr_7.attr.attr,
+	&hfi1_sl2sc_attr_8.attr.attr,
+	&hfi1_sl2sc_attr_9.attr.attr,
+	&hfi1_sl2sc_attr_10.attr.attr,
+	&hfi1_sl2sc_attr_11.attr.attr,
+	&hfi1_sl2sc_attr_12.attr.attr,
+	&hfi1_sl2sc_attr_13.attr.attr,
+	&hfi1_sl2sc_attr_14.attr.attr,
+	&hfi1_sl2sc_attr_15.attr.attr,
+	&hfi1_sl2sc_attr_16.attr.attr,
+	&hfi1_sl2sc_attr_17.attr.attr,
+	&hfi1_sl2sc_attr_18.attr.attr,
+	&hfi1_sl2sc_attr_19.attr.attr,
+	&hfi1_sl2sc_attr_20.attr.attr,
+	&hfi1_sl2sc_attr_21.attr.attr,
+	&hfi1_sl2sc_attr_22.attr.attr,
+	&hfi1_sl2sc_attr_23.attr.attr,
+	&hfi1_sl2sc_attr_24.attr.attr,
+	&hfi1_sl2sc_attr_25.attr.attr,
+	&hfi1_sl2sc_attr_26.attr.attr,
+	&hfi1_sl2sc_attr_27.attr.attr,
+	&hfi1_sl2sc_attr_28.attr.attr,
+	&hfi1_sl2sc_attr_29.attr.attr,
+	&hfi1_sl2sc_attr_30.attr.attr,
+	&hfi1_sl2sc_attr_31.attr.attr,
 	NULL
 };
 
-static ssize_t sl2sc_attr_show(struct kobject *kobj, struct attribute *attr,
-			       char *buf)
-{
-	struct hfi1_sl2sc_attr *sattr =
-		container_of(attr, struct hfi1_sl2sc_attr, attr);
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, sl2sc_kobj);
-	struct hfi1_ibport *ibp = &ppd->ibport_data;
-
-	return sysfs_emit(buf, "%u\n", ibp->sl_to_sc[sattr->sl]);
-}
-
-static const struct sysfs_ops hfi1_sl2sc_ops = {
-	.show = sl2sc_attr_show,
-};
-
-static struct kobj_type hfi1_sl2sc_ktype = {
-	.release = port_release,
-	.sysfs_ops = &hfi1_sl2sc_ops,
-	.default_attrs = sl2sc_default_attributes
+static const struct attribute_group port_sl2sc_group = {
+	.name = "sl2sc",
+	.attrs = port_sl2sc_attributes,
 };
 
 /* End sl2sc */
 
 /* Start vl2mtu */
 
-#define HFI1_VL2MTU_ATTR(N) \
-	static struct hfi1_vl2mtu_attr hfi1_vl2mtu_attr_##N = { \
-		.attr = { .name = __stringify(N), .mode = 0444 }, \
-		.vl = N						  \
-	}
-
 struct hfi1_vl2mtu_attr {
-	struct attribute attr;
+	struct ib_port_attribute attr;
 	int vl;
 };
 
+static ssize_t vl2mtu_attr_show(struct ib_device *ibdev, u32 port_num,
+				struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi1_vl2mtu_attr *vlattr =
+		container_of(attr, struct hfi1_vl2mtu_attr, attr);
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+
+	return sysfs_emit(buf, "%u\n", dd->vld[vlattr->vl].mtu);
+}
+
+#define HFI1_VL2MTU_ATTR(N)                                                    \
+	static struct hfi1_vl2mtu_attr hfi1_vl2mtu_attr_##N = {                \
+		.attr = __ATTR(N, 0444, vl2mtu_attr_show, NULL),               \
+		.vl = N,                                                       \
+	}
+
 HFI1_VL2MTU_ATTR(0);
 HFI1_VL2MTU_ATTR(1);
 HFI1_VL2MTU_ATTR(2);
@@ -446,46 +413,29 @@ HFI1_VL2MTU_ATTR(13);
 HFI1_VL2MTU_ATTR(14);
 HFI1_VL2MTU_ATTR(15);
 
-static struct attribute *vl2mtu_default_attributes[] = {
-	&hfi1_vl2mtu_attr_0.attr,
-	&hfi1_vl2mtu_attr_1.attr,
-	&hfi1_vl2mtu_attr_2.attr,
-	&hfi1_vl2mtu_attr_3.attr,
-	&hfi1_vl2mtu_attr_4.attr,
-	&hfi1_vl2mtu_attr_5.attr,
-	&hfi1_vl2mtu_attr_6.attr,
-	&hfi1_vl2mtu_attr_7.attr,
-	&hfi1_vl2mtu_attr_8.attr,
-	&hfi1_vl2mtu_attr_9.attr,
-	&hfi1_vl2mtu_attr_10.attr,
-	&hfi1_vl2mtu_attr_11.attr,
-	&hfi1_vl2mtu_attr_12.attr,
-	&hfi1_vl2mtu_attr_13.attr,
-	&hfi1_vl2mtu_attr_14.attr,
-	&hfi1_vl2mtu_attr_15.attr,
+static struct attribute *port_vl2mtu_attributes[] = {
+	&hfi1_vl2mtu_attr_0.attr.attr,
+	&hfi1_vl2mtu_attr_1.attr.attr,
+	&hfi1_vl2mtu_attr_2.attr.attr,
+	&hfi1_vl2mtu_attr_3.attr.attr,
+	&hfi1_vl2mtu_attr_4.attr.attr,
+	&hfi1_vl2mtu_attr_5.attr.attr,
+	&hfi1_vl2mtu_attr_6.attr.attr,
+	&hfi1_vl2mtu_attr_7.attr.attr,
+	&hfi1_vl2mtu_attr_8.attr.attr,
+	&hfi1_vl2mtu_attr_9.attr.attr,
+	&hfi1_vl2mtu_attr_10.attr.attr,
+	&hfi1_vl2mtu_attr_11.attr.attr,
+	&hfi1_vl2mtu_attr_12.attr.attr,
+	&hfi1_vl2mtu_attr_13.attr.attr,
+	&hfi1_vl2mtu_attr_14.attr.attr,
+	&hfi1_vl2mtu_attr_15.attr.attr,
 	NULL
 };
 
-static ssize_t vl2mtu_attr_show(struct kobject *kobj, struct attribute *attr,
-				char *buf)
-{
-	struct hfi1_vl2mtu_attr *vlattr =
-		container_of(attr, struct hfi1_vl2mtu_attr, attr);
-	struct hfi1_pportdata *ppd =
-		container_of(kobj, struct hfi1_pportdata, vl2mtu_kobj);
-	struct hfi1_devdata *dd = ppd->dd;
-
-	return sysfs_emit(buf, "%u\n", dd->vld[vlattr->vl].mtu);
-}
-
-static const struct sysfs_ops hfi1_vl2mtu_ops = {
-	.show = vl2mtu_attr_show,
-};
-
-static struct kobj_type hfi1_vl2mtu_ktype = {
-	.release = port_release,
-	.sysfs_ops = &hfi1_vl2mtu_ops,
-	.default_attrs = vl2mtu_default_attributes
+static const struct attribute_group port_vl2mtu_group = {
+	.name = "vl2mtu",
+	.attrs = port_vl2mtu_attributes,
 };
 
 /* end of per-port file structures and support code */
@@ -649,100 +599,17 @@ const struct attribute_group ib_hfi1_attr_group = {
 	.attrs = hfi1_attributes,
 };
 
+static const struct attribute_group *hfi1_port_groups[] = {
+	&port_sc2vl_group,
+	&port_sl2sc_group,
+	&port_vl2mtu_group,
+	NULL,
+};
+
 int hfi1_create_port_files(struct ib_device *ibdev, u32 port_num,
 			   struct kobject *kobj)
 {
-	struct hfi1_pportdata *ppd;
-	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
-	int ret;
-
-	if (!port_num || port_num > dd->num_pports) {
-		dd_dev_err(dd,
-			   "Skipping infiniband class with invalid port %u\n",
-			   port_num);
-		return -ENODEV;
-	}
-	ppd = &dd->pport[port_num - 1];
-
-	ret = kobject_init_and_add(&ppd->sc2vl_kobj, &hfi1_sc2vl_ktype, kobj,
-				   "sc2vl");
-	if (ret) {
-		dd_dev_err(dd,
-			   "Skipping sc2vl sysfs info, (err %d) port %u\n",
-			   ret, port_num);
-		/*
-		 * Based on the documentation for kobject_init_and_add(), the
-		 * caller should call kobject_put even if this call fails.
-		 */
-		goto bail_sc2vl;
-	}
-	kobject_uevent(&ppd->sc2vl_kobj, KOBJ_ADD);
-
-	ret = kobject_init_and_add(&ppd->sl2sc_kobj, &hfi1_sl2sc_ktype, kobj,
-				   "sl2sc");
-	if (ret) {
-		dd_dev_err(dd,
-			   "Skipping sl2sc sysfs info, (err %d) port %u\n",
-			   ret, port_num);
-		goto bail_sl2sc;
-	}
-	kobject_uevent(&ppd->sl2sc_kobj, KOBJ_ADD);
-
-	ret = kobject_init_and_add(&ppd->vl2mtu_kobj, &hfi1_vl2mtu_ktype, kobj,
-				   "vl2mtu");
-	if (ret) {
-		dd_dev_err(dd,
-			   "Skipping vl2mtu sysfs info, (err %d) port %u\n",
-			   ret, port_num);
-		goto bail_vl2mtu;
-	}
-	kobject_uevent(&ppd->vl2mtu_kobj, KOBJ_ADD);
-
-	ret = kobject_init_and_add(&ppd->pport_cc_kobj, &port_cc_ktype,
-				   kobj, "CCMgtA");
-	if (ret) {
-		dd_dev_err(dd,
-			   "Skipping Congestion Control sysfs info, (err %d) port %u\n",
-			   ret, port_num);
-		goto bail_cc;
-	}
-
-	kobject_uevent(&ppd->pport_cc_kobj, KOBJ_ADD);
-
-	ret = sysfs_create_bin_file(&ppd->pport_cc_kobj, &cc_setting_bin_attr);
-	if (ret) {
-		dd_dev_err(dd,
-			   "Skipping Congestion Control setting sysfs info, (err %d) port %u\n",
-			   ret, port_num);
-		goto bail_cc;
-	}
-
-	ret = sysfs_create_bin_file(&ppd->pport_cc_kobj, &cc_table_bin_attr);
-	if (ret) {
-		dd_dev_err(dd,
-			   "Skipping Congestion Control table sysfs info, (err %d) port %u\n",
-			   ret, port_num);
-		goto bail_cc_entry_bin;
-	}
-
-	dd_dev_info(dd,
-		    "Congestion Control Agent enabled for port %d\n",
-		    port_num);
-
-	return 0;
-
-bail_cc_entry_bin:
-	sysfs_remove_bin_file(&ppd->pport_cc_kobj,
-			      &cc_setting_bin_attr);
-bail_cc:
-	kobject_put(&ppd->pport_cc_kobj);
-bail_vl2mtu:
-	kobject_put(&ppd->vl2mtu_kobj);
-bail_sl2sc:
-	kobject_put(&ppd->sl2sc_kobj);
-bail_sc2vl:
-	kobject_put(&ppd->sc2vl_kobj);
-	return ret;
+	return ib_port_sysfs_create_groups(ibdev, port_num, hfi1_port_groups);
 }
 
 struct sde_attribute {
@@ -868,23 +735,13 @@ int hfi1_verbs_register_sysfs(struct hfi1_devdata *dd)
  */
 void hfi1_verbs_unregister_sysfs(struct hfi1_devdata *dd)
 {
-	struct hfi1_pportdata *ppd;
 	int i;
 
 	/* Unwind operations in hfi1_verbs_register_sysfs() */
 	for (i = 0; i < dd->num_sdma; i++)
 		kobject_put(&dd->per_sdma[i].kobj);
 
-	for (i = 0; i < dd->num_pports; i++) {
-		ppd = &dd->pport[i];
-
-		sysfs_remove_bin_file(&ppd->pport_cc_kobj,
-				      &cc_setting_bin_attr);
-		sysfs_remove_bin_file(&ppd->pport_cc_kobj,
-				      &cc_table_bin_attr);
-		kobject_put(&ppd->pport_cc_kobj);
-		kobject_put(&ppd->vl2mtu_kobj);
-		kobject_put(&ppd->sl2sc_kobj);
-		kobject_put(&ppd->sc2vl_kobj);
-	}
+	for (i = 0; i < dd->num_pports; i++)
+		ib_port_sysfs_remove_groups(&dd->verbs_dev.rdi.ibdev, i + 1,
+					    hfi1_port_groups);
 }
-- 
2.31.1

