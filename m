Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9343CF5F5
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhGTHhF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:05 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:43520
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234203AbhGTHhD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ9y1pwKEoLKWEdxodIEKpCc1iOS+oYdynANyy4WJibBJvyRMdLpB7ttOXS6gC7Asgy52Ts1PBKTlW3dc+vBAbOCFTcjcT3OJr6Saak7aVQJ8/Oun/pWmc0sAvtkNW2KkKmr3YOdAyPJHcbf6bgIM3R8m6M3MuAbwJa11G0C4fOsAOGiPZAi3AOT5/tPm5hnWRH0SxrIkADuMSKRogmzBSsoVP+5I20W/tdrfvDCJResN2SrP08P2rUX7dZarTdeqvsukNxvD4EKjimHocYnFJKyDcexuzC7Q3HbHvNhMtga/a8DjF28qU+88yaBk1PH1RmAqAw2MSnwmhjCP01GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dad7dCr/rrehHosZQA/sHRcqNL7OVXtWf5uztU+8iJs=;
 b=FoU98zZGPf5sEio/CS9salm3j3jBa1+0gPvwqbaus7eus8tKKFhAmPXkplVr3ohOKSjJwELcbl0tTGCHtO6301LlpsncyBwS0BmmsCas/T1vEv6pxXcLXI5o2a/it0hTL/3Wql3/gKdyYM7zoklApG1oRQ57IJLyflhRctUiHDZd7iim8/drpvMQCh9KPoLuq0kLRSAye0hN6W3YY4Lk8cvKJA3XoCojh+zqxbhECrSB/v48oIdKTng+NEGIbSUUeqFDAjthx9YIq8awRx0WOxqjOtrmIWPOw2PFA6Ono6fBMfjA56ZlaUALppaqc1M2kAt5FsIgQ+kStXPMWiJ30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dad7dCr/rrehHosZQA/sHRcqNL7OVXtWf5uztU+8iJs=;
 b=gpPMHv+BP0rdAn1nAYfE6BWkj7pVGcuZaoryNb9PCmdtMIhjHkE49LRXXD8UIBHrn7Paoucr1Q/botH2eDWeB/UfXy8PLwb/PB9YUXAotCaUinGx6MYto4QWZR7w9lXbDmmMIS8S7gfWNCXYrGmrTgqKCQ5hylz8PQowMuKmHOHlgdhy4MlidX4wEZquEIcxSeP8vKHY+akpH3VTxQ/IEGZhkDXfE3CX/6F+QHiNOjvyjeJU8vOKODRuacRGW2IXa7UiUHixnZeNlq/LrQ5ERRvsCG0RBNZA23tG8RFc8FXA8wJSAQHA8afnOxdvDQmvBhvJyXcvCYY8tojcxy4KUw==
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 08:17:39 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::43) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:39 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:38 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:36 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 05/27] verbs: Enable verbs_open_device() to work over non sysfs devices
Date:   Tue, 20 Jul 2021 11:16:25 +0300
Message-ID: <20210720081647.1980-6-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ee62a54-b2e5-441a-bb42-08d94b56d6d0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-Microsoft-Antispam-PRVS: <SN6PR12MB276585AF713B832AE28DFB75C3E29@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UIVxFpKeBxFKXwCj0lmpKP2VTG9OGk5yZAnNNVAODHN7MdxH9CANDEqT0w0ibyJs20vVpjyKNSR4Lh9ZpJmnmVZI1ZRXbGC/4C5GqxvM6S0lrBWIoS5sjbomYdJfklITn2qtW6Y9Q+mGTuDEKkbaEhsUCKGiSOGO4GszFuzcnqr1Ek3HWQ0RsrRG/LfpdMbbAchV5YNu8mAAIeQagYH5vi5DMKh5E+9tIk7baQGApr3uLEXh8fyrCuSQLrzT81pPQjdIhwqgUjQqDgsXlOp8i6zg6hY9rcsFe3gVQDMdwoPqVABjoS/w6wbPu4qm4vt9g2ubcgoTW9eXJu/IIl7V2MOJ9J8XZ4qOSjqplHlqWbyOTEnQWz9thzViYftZ9S2AyNuH4IZYfWNRaxfawNzg2NDczfLsPUgQNLwGNFWyU2O8PQS9RZ60Y80enU9HREAe13b1z4rLEKKIgict1TLd+vWHWWZfqEnXbhEBsJ0AWbQW9/sze97fpwMQdPsvj+WFM5uNjP4D1pT+mQ6npUlqF9CWyxTMXKcl2k/AnzYLaMj+F6RhG2EadgR1eir9CPXWIOS6QfYwzjWlux2/AZ6HhUhzC0yeOlvYYVxxUAsbGYnMUfuEyZr+k2YL5EGJkGx4561LE06iQr0wp0d3Wl0VzALvYUjFB6wYji+sUH/zz1+fDqUa+/tDq24O0+c4HH2DJmQvVUS+MK2iSkC4HGRpQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(316002)(70206006)(70586007)(47076005)(82310400003)(356005)(82740400003)(7636003)(36906005)(4326008)(54906003)(36756003)(107886003)(6666004)(86362001)(5660300002)(336012)(26005)(426003)(186003)(6916009)(8676002)(2616005)(7696005)(8936002)(1076003)(2906002)(83380400001)(36860700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:39.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee62a54-b2e5-441a-bb42-08d94b56d6d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enable verbs_open_device() to work over non sysfs devices as of mlx5
over VFIO.

Any other API over verbs_sysfs_dev should fail cleanly.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/device.c | 39 ++++++++++++++++++++++-----------------
 libibverbs/sysfs.c  |  5 +++++
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/libibverbs/device.c b/libibverbs/device.c
index 2f0b3b7..bd6a019 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -124,7 +124,7 @@ LATEST_SYMVER_FUNC(ibv_get_device_guid, 1_1, "IBVERBS_1.1",
 	int i;
 
 	pthread_mutex_lock(&dev_list_lock);
-	if (sysfs_dev->flags & VSYSFS_READ_NODE_GUID) {
+	if (sysfs_dev && sysfs_dev->flags & VSYSFS_READ_NODE_GUID) {
 		guid = sysfs_dev->node_guid;
 		pthread_mutex_unlock(&dev_list_lock);
 		return htobe64(guid);
@@ -154,7 +154,7 @@ int ibv_get_device_index(struct ibv_device *device)
 {
 	struct verbs_sysfs_dev *sysfs_dev = verbs_get_device(device)->sysfs;
 
-	return sysfs_dev->ibdev_idx;
+	return sysfs_dev ? sysfs_dev->ibdev_idx : -1;
 }
 
 void verbs_init_cq(struct ibv_cq *cq, struct ibv_context *context,
@@ -323,18 +323,20 @@ static void set_lib_ops(struct verbs_context *vctx)
 struct ibv_context *verbs_open_device(struct ibv_device *device, void *private_data)
 {
 	struct verbs_device *verbs_device = verbs_get_device(device);
-	int cmd_fd;
+	int cmd_fd = -1;
 	struct verbs_context *context_ex;
 	int ret;
 
-	/*
-	 * We'll only be doing writes, but we need O_RDWR in case the
-	 * provider needs to mmap() the file.
-	 */
-	cmd_fd = open_cdev(verbs_device->sysfs->sysfs_name,
-			   verbs_device->sysfs->sysfs_cdev);
-	if (cmd_fd < 0)
-		return NULL;
+	if (verbs_device->sysfs) {
+		/*
+		 * We'll only be doing writes, but we need O_RDWR in case the
+		 * provider needs to mmap() the file.
+		 */
+		cmd_fd = open_cdev(verbs_device->sysfs->sysfs_name,
+				   verbs_device->sysfs->sysfs_cdev);
+		if (cmd_fd < 0)
+			return NULL;
+	}
 
 	/*
 	 * cmd_fd ownership is transferred into alloc_context, if it fails
@@ -345,11 +347,13 @@ struct ibv_context *verbs_open_device(struct ibv_device *device, void *private_d
 		return NULL;
 
 	set_lib_ops(context_ex);
-	if (context_ex->context.async_fd == -1) {
-		ret = ibv_cmd_alloc_async_fd(&context_ex->context);
-		if (ret) {
-			ibv_close_device(&context_ex->context);
-			return NULL;
+	if (verbs_device->sysfs) {
+		if (context_ex->context.async_fd == -1) {
+			ret = ibv_cmd_alloc_async_fd(&context_ex->context);
+			if (ret) {
+				ibv_close_device(&context_ex->context);
+				return NULL;
+			}
 		}
 	}
 
@@ -428,7 +432,8 @@ out:
 void verbs_uninit_context(struct verbs_context *context_ex)
 {
 	free(context_ex->priv);
-	close(context_ex->context.cmd_fd);
+	if (context_ex->context.cmd_fd != -1)
+		close(context_ex->context.cmd_fd);
 	if (context_ex->context.async_fd != -1)
 		close(context_ex->context.async_fd);
 	ibverbs_device_put(context_ex->context.device);
diff --git a/libibverbs/sysfs.c b/libibverbs/sysfs.c
index 8ba4472..d898432 100644
--- a/libibverbs/sysfs.c
+++ b/libibverbs/sysfs.c
@@ -127,6 +127,11 @@ int ibv_read_ibdev_sysfs_file(char *buf, size_t size,
 	va_list va;
 	int res;
 
+	if (!sysfs_dev) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	va_start(va, fnfmt);
 	if (vasprintf(&path, fnfmt, va) < 0) {
 		va_end(va);
-- 
1.8.3.1

