Return-Path: <linux-rdma+bounces-21262-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH7QGPn1FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21262-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E675CF6CA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C87B301828F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6729A9C3;
	Tue, 26 May 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JW8zBAos"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FB290DBB
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758582; cv=fail; b=MBrUoPc69d68aeu3OqbuhW2EEBHtIFYSgqw84Bl1VwdUJ0JGle6n3JgxiRQ9EyXJ0Na5rGpYicfmd36JYmfxwIpw6lF9S1iLP04sMJZFpadY4sRkwClNbKQV0aOInWY1E0n0Q7RKhI1stz/jhE0CJYLcoGYfJLn6iY7Z4F422eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758582; c=relaxed/simple;
	bh=746gUF9Vhu6nXgoyShTq1KEnm9GtZF6zxIyN37BxcvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L6l4EKr4AHItYRp559s7I9I9LnJ0j5CncV2g+eL9lWJnqA1w70KHoR4PFLnTCWaWMBC/J7ewwBxm7yt4jNalQ1a30b4Vc9XOu/E/FFEGT9vGwkoY9uxHXes7s4dnqPSSqhCG/zmIxO1schYsIAHWGQ2DM66o6cuGKL0h5RtiKLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JW8zBAos; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1q2KawZ99KA0mPoOqab3ioRSJOWZY9ujnDKacNvPtERzCKzSSBvgkkEYck/jkUCze/4Fb0od9oYSzaBqMtQXemC176ZJlHK+sbRW8vLY6PWus3p686/j4DMp1sENk7Z103YPrC4fiunaA78Upec9HNU0t9qt3n3DOOx8vA9kuJ3B7za+ha+kAxqvAKbHUdzsIgXPdxGgpJlKJqrN6FZlFxkMJ0mLcNxdi1aZVelXTilDo8STTrOEUgbqLxSvOIqgRBA5KexpjN778eyKa56y4LcBxmz6k/b9MaWrqK4GmG/M1RJCJzHbhxThmTnSl9bSfU12O5RE7reeuK8cjfYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwlwwJQR0tY45ZMkZsjBh633xDV7LGTxJE2xRNP+qjA=;
 b=KiB+Akz7cuFFzAFoG223UkGLz6Oba2CXST2ZlVq1hT29yuhURI/h57X8zg1oSw3S86SiTg4BTd6hXlt2icQAvn/bTu80Y4WYwqcg+0pFJlXqsR83BTlGq2Y1zMHSR/jpomz8g1A+moUu+pFw1sOVr5fBNMwnRVoqj95sC0madvH0IL21ftHkfeirt9wOB2NWjWytcCP2E/Msm1thR2JFXtrXvlo51SH7zeE/vJF9YopTc/BWsVqNno7M7Ch5iLJSw7QBDqhvgp7YOVcEAhm+tTDbs243FwP6cqMA0U63/eLn338pv3C7ST3ShhEnbtgnAbf055qi2ZqLISxSuVjbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwlwwJQR0tY45ZMkZsjBh633xDV7LGTxJE2xRNP+qjA=;
 b=JW8zBAos7AMzg3FEI15layAmPx0a0NIHLfgYzUe1knybttVoIvF8xru0lsHYuvtM1jUidzL7jicWeQDinP/Tre8rQPMJU+7itNvAzNyQD6IDIghwsSXKxXZV1LVQcaoM2xjSHsrmY7lW+xOf8nAAfYAfEauAXdLm4qPKkI8uVUlsJx5JdqiMa60C0rDqULmYmmiB/HTreM2qCFaLC5XSwcJt3RGYlb5ccrUt2zwoNMHcpriDDv/DX4pApyM8/yL/PrfIfx3vC2R4Wn9P4nA7gnBMPzfPVdVHMKS3Vp0aiqqdEowM+/wIpyRRJlXRHPLW2czXaSMPupoD0wHRFF/v6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:45 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 5/6] RDMA/core: Move ucaps into ib_uverbs_support.ko
Date: Mon, 25 May 2026 22:22:41 -0300
Message-ID: <5-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::27) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bcb2c7-28c3-4426-2761-08debac549cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PVAzXb0LRMOPZWfWpty8oUhmkp+L7lfkX5miVp0b7/0OZu51fKpUuxuH3oXhTUovNzEsVlX0W0pQ0bim0n6WKgAcIlZBWYDYGO7gaXLjCOd5hpFLHltNjg9FH18ZbWZB6bbklWmPBdp33D0kWPT/Bn6zIQzEereXwIdDW9wy9xDt7fTD6SOXv7WgFjJjLSg42IzITHih1C93d1Hy2PiaEVb3ectKH+iR65J5j3BHOo+v7uCpJen3eSs/PrUNFyhH5WW7vrZwXJmCbSXHdYMK/ybvBE66Di+qQRKnmCFql22ODN+MhA6wqp/bEuSCgCIvq892u7iMFZgMOpZw3QPw+6wdFDxBZMzr6KGTDfJIwiGph92UYQ/rPao2mkmoJlOTzsI+CFOuB4Byu/fbJgpK3WTYiH6JC0RNsakFzSOHkEZT3nV6Qj1xXpfKOTUR+nI6rsujcXBU7AF3L7b0yvTJaJV0nI4EbomxlSZm5RmBY0iMopsGBM2Yy0xQ9GXRuV6kER0+Z5Ny25sEqXqZ3pF17/nM1DccixkAGK8vZvEdsQ+4afUGWva38UC1JQmO9I58dbeHXxtS9Z1zpeIj5gBFtJufPCJOGK9xHPkO4m89jddwMB3q0WbFVN9SfDCngKmqZKAZb+9Yo69zfH/GeVJ+1Khzm39kWhpWHCpCx3S63uTqPCppxFx8PJtsnftR9PW0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyPXwemV4rWjVp05pYmFbSLjD5DGU7IbEzUqAhjOy5zIrvZ7k6sRmjvm4CfR?=
 =?us-ascii?Q?QGEsuIMyjLI/z/AE3LpSduydVe3S07vLRePiYv+7Kogm4wuJWHLrdxBZeznb?=
 =?us-ascii?Q?l75vVq5vC6V7KMyXy5AFUK6X52TNduzgt08B9jStFjYwXiDxhE/P6Tzee+p6?=
 =?us-ascii?Q?1jRiI5WwQLBfZCIiAtGjXA/xJSkqiMFqFnHf5GRDpmevVZOhpvKFc50X9F40?=
 =?us-ascii?Q?HzpkBo681gONp5TvCLl1lmEmglXykyGn/5s4uZcKEUTjUYMo0KPfbYucZgtX?=
 =?us-ascii?Q?5RHk9Vri18GVIW4Av4OawKnLSL3J8iHjaY0d8fc8woAKSezqz2a/Tp4aNW5e?=
 =?us-ascii?Q?qYH6krhQMfZP3KC71W2DkmUKNZNe8I0g5HuxY1xPxlRyCdDPjvwN0Cr8UdDf?=
 =?us-ascii?Q?gOq/BlfLIz1evdyjHXG3xtJ3GWA/q/s3wO9S37/y2Z3j+2UfWaf3Ov8t4e5v?=
 =?us-ascii?Q?XI0AFrkiQTozJwhN8LfxUPta0CvTWeE61F3vIoarBCaVEejphNuslQgGJeZU?=
 =?us-ascii?Q?P2mwGaV/XKqPiOZE9fgb/1H9i+slKwayqnhHK1zW1PuC9xJ+38CTeAUAvpUF?=
 =?us-ascii?Q?2A/58vWascQ5oaT73KvQCBHkwa2qLXy4B5b9BZ8uk1QvILMGyybPwcHD6dpT?=
 =?us-ascii?Q?TqVFOFyVOnFeHlkIqGwVRDutOx/HlJwAtbRodMCM9elesod+Xrs3W8pVj8Jy?=
 =?us-ascii?Q?w6xo4+uHMhMEQnRXUWUvDR36RDP9TEDe1i0p3MWsGlx2eY0X+CCXZ36N14Fl?=
 =?us-ascii?Q?B9iYHGrokpdByMmEEgdXtBF5I2H2YC34F1WZdwPxhXa0WSEqIIYXaurlgRWI?=
 =?us-ascii?Q?oBQ0KHavbWac0zIKSaNJ9zMwEubQK1/71dq86qOqk6Xbc+QiHVgkaOF1k8EB?=
 =?us-ascii?Q?PPIYjyLctzOM1nlO97D8cIROj7M8aW88zn4aDjqr+Gzg5OfegQv65oFq2Jsi?=
 =?us-ascii?Q?Vd/yQcdOWdW9BmtqQ/d/zJYLy61guCoAPYmZ2qzCYoZprldQMstAkA10UxT6?=
 =?us-ascii?Q?pZ0SCwkGrrGwOJ6TQ+R4PRCG77y/6uzDqgixvTTJmL3+HyHp3b7DxKsu03eO?=
 =?us-ascii?Q?1cfUoLOu2BbZxhrttbhHosimkeDThBoE6p0/sQg7wtkRrwhpUwysm4HmO4G9?=
 =?us-ascii?Q?mEf+qOlbtQUXUtrAZFXHrG2ZmKn5Q7PTv6ruNv/x2b2B9+HhTK/P4xzPwXe0?=
 =?us-ascii?Q?ymGccz6t1W59TmfOMxe01ZSDK2aw9iMF3WfvHg2zWkheXbXUB3szhzonJilp?=
 =?us-ascii?Q?b5pM1ZTtPiyTWjKkSkn5/hwHd7ZpjxuCpxIKUhr5HBvk4hv3Vm1YbkIkfHpy?=
 =?us-ascii?Q?LVU/a+MVeAqE9Tj9CSGh629Fr0c/m0OheGtAqXaeBfTrvkR4NZZaPGp1n+YH?=
 =?us-ascii?Q?i5FUu734eqLwDj8/MhRC7QRczjrLQchbkijrBQXsHp9sjvgre4v/yp9SWS08?=
 =?us-ascii?Q?1uA8gQDLQv6S1dvvrHba7/9xGa+r7bxGYsoEpsybDtt/kbbBwdMVV0hrCab+?=
 =?us-ascii?Q?KQp194OPjRbDUY9cAdUOkZFrrtxuNU9fpnlaw+EoSo19Jy4RsCafQjRyeXgG?=
 =?us-ascii?Q?UTw63QVhVbnXdmFJLitH96wYwGOXUjMCsCIdi04yZusfKFkV/DupRnWCjbTt?=
 =?us-ascii?Q?c9szKlLY3neIeXgp11ObDS2iNdeCxyDpo/NdzFm+V9Nab4t3yVYHlCtzifIK?=
 =?us-ascii?Q?IICJtvsCI+YHJA0N8L5Ou3Yfha06VXf2YoWj0kFzisJfuuZy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bcb2c7-28c3-4426-2761-08debac549cc
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:44.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0fV0CYph4rChg77Ogv7E2IjLHfiz1f/W3YvbB9pRqZHmPBqI7j2gwu9uOhVQILd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21262-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: B3E675CF6CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5 uses these move them into the support module from ib_uverbs.ko.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      | 6 +++---
 drivers/infiniband/core/ucaps.c       | 5 ++++-
 drivers/infiniband/core/uverbs_main.c | 1 -
 include/rdma/ib_ucaps.h               | 1 -
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index e2ff9c2be9d377..47f645cb76f69e 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -46,7 +46,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_async_fd.o \
 				uverbs_std_types_srq.o \
 				uverbs_std_types_wq.o \
-				uverbs_std_types_qp.o \
-				ucaps.o
+				uverbs_std_types_qp.o
 
-ib_uverbs_support-y :=		rdma_core.o
+ib_uverbs_support-y :=		rdma_core.o \
+				ucaps.o
diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index 948093260dbda1..a998bf6c326cfe 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -51,7 +51,7 @@ static const struct file_operations ucaps_cdev_fops = {
  *
  * This is called once, when removing the ib_uverbs module.
  */
-void ib_cleanup_ucaps(void)
+static __exit void ib_cleanup_ucaps(void)
 {
 	mutex_lock(&ucaps_mutex);
 	if (!ucaps_class_is_registered) {
@@ -265,3 +265,6 @@ int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
 	mutex_unlock(&ucaps_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(ib_get_ucaps, "rdma_core");
+
+module_exit(ib_cleanup_ucaps);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index ab6f1e3cb47a18..3ccf58e96aedeb 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1350,7 +1350,6 @@ static void __exit ib_uverbs_cleanup(void)
 				 IB_UVERBS_NUM_FIXED_MINOR);
 	unregister_chrdev_region(dynamic_uverbs_dev,
 				 IB_UVERBS_NUM_DYNAMIC_MINOR);
-	ib_cleanup_ucaps();
 	mmu_notifier_synchronize();
 }
 
diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
index d9f96be3a553f8..b629c99117d8fe 100644
--- a/include/rdma/ib_ucaps.h
+++ b/include/rdma/ib_ucaps.h
@@ -14,7 +14,6 @@ enum rdma_user_cap {
 	RDMA_UCAP_MAX
 };
 
-void ib_cleanup_ucaps(void);
 int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int ib_create_ucap(enum rdma_user_cap type);
-- 
2.43.0


