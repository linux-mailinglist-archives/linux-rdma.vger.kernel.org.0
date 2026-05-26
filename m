Return-Path: <linux-rdma+bounces-21264-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGRGFgD2FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21264-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E962C5CF6D8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C003018771
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E64290DBB;
	Tue, 26 May 2026 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e86I1Zbl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2029D275
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758587; cv=fail; b=Wrb9Jvk86cmar8G7IluPmP5e373WIFfYcdBBtX1UHletwaDO8iQIKJCMVJ4N67JC3a6zAUh9i+fTbR9OoK0IvLy5NG/RgaCyyPm8CaylAu3OBTCFszuARMdkrkxl7W3rEzsSleEF9Cd6DXRyi/kfwSrnrOESlo+DRB75vjLYsS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758587; c=relaxed/simple;
	bh=qYOdhwUPzh3XCT0ayU9woKJSs8wO6kRyLhY7mXOIgEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoQj8KN+TNT2OVekW4aXlXk0fc8IlIxXL+bWbCgXxu7+VE3PbfuDH+jOimMt8Dn+BXP7H+QvnwDyQYV5FNQhr1nAGEHiMF1Dlz+MD0CSKpugEMZ6RM3Cnf21VguJVjerrIGa5ruixyj/StMYBN69JVFvcVJZa5d4239Ok09d/3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e86I1Zbl; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr2yleo0Gxtsoe5wmIuid6fojHfyk4VKZKYyuQ3oxUR0rNZhy2qGhLGBUM1LIEDxuIG2/UgRrZlWCxv1oE2XKkoX4ZBi+zjPrLR34luYiLKGc2sHoIGfMmo781AMtaU9VzsI431BuZsGZUyRJBAcdW+h43dz/980FJYbcvcx59EFn7vcmli6Zg942Av0ABuR+CZDFRJiTCfpzFRV6JPjh9CEc916H50Rq1IALb4ICYXADvPDKuT7DI++Jd7bUTWLyYPFsfD9+F4ICkslVBIMmw5LgAcDCoi8nWHnPZeq381Hv1NAdrH4TbPAtRaCs3aycUVB1Zvyhs0UEEH5eiiW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGv06KHuJgjtC0nyz7iy7u7nyZOc91mfuqJAqboC1LQ=;
 b=Zfvrz73MBTq+IdMr22roGV9Z4ZFnDuW7w/fepTjiFddE9x9Zsyo/FMzNJo9WhNMzIH+yvAAs6q1S9rYYJv2SnfSpTM6KU+NSloD/QZepNZ6o8+sAIKWVlttE6bLaeIAi6c1wRgWdAMeLTHPrCw8HcNjrnSuxUIivd6OKF1htm6llyZZufBHrCypX8b2O3IGOz9/WzFIyQQVOWXJIH853CWlzNdsq6tKX8oWSTNCOkfMF5MJXkYOHPAlSZNwi0JhOhjHvVhpdm/sK8fA/j8vhdXADnWIBrCKsCNWoi3aMIufGJYwE28xQVvbmgC/AnMAUZkI8GFZT40K4QrA+BkrSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGv06KHuJgjtC0nyz7iy7u7nyZOc91mfuqJAqboC1LQ=;
 b=e86I1Zbl+HUdu3TJFhON5yV5sPFDns7d83nld42TbV1sB0UXXxfRI2N9Ht43i0qL2OCNll4Jr1FM4xRfk3jsiE1F84qGn/hSN6W8pDwt8b1WwrNwNtmaBWbnGx/QxgijUpSAddFyphFMax0M7pF3A5ATQ2qKOeKNeCaa20NBxpah7exUpJBmfsXYHfwbRJD/+lIc+snw4IT0fmJ3Rk8HekmHk5C0G3TM7M8xn6C1qUpqHil0W3iJqYKkEsFinfVpN/7Vq/btpxBxNcda1yseu8i6xcjcc+QrRgvKsoYA38FpqRYWE3Z/TZiOnptHa8PNcfDPHwdKEgSOe3j27+gmAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:47 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 4/6] RDMA/core: Make a new module for the uverbs components needed by drivers
Date: Mon, 25 May 2026 22:22:40 -0300
Message-ID: <4-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::16) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 942d89f7-2e9c-43c9-cebc-08debac54ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|5023799004|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	VM3+1RNI0nJinr5RZQMeLoHr9d6ZVUZjCGq/9cbzqZtydX/R49Cvh5O5m3RYe+aUfLv76TciYB3V8Nyi5i5DtGP3OJe4v2DeUjtJ7dcF33NVSdAGpGgOoot9A4D0NSPQNrQGXrN3Zm13aUK15+5mX7n+jM9KPJorrSAP+I9l1PU+ufafaXqohWyXWA/G25ASONHOWYKwi+yKGlQVMtMiqc09JVUAvD4QRlWKiG+QumPYh/p+BqD/rosmKYRs98ODFwXAEwetXKwXXO4LW2cDdedleieJK682sZG3sDIelaD/eoJOzaydNjjy7/j9Q7wxlrtxOJy3fAaqivIajqrPbsXZ0jRbctbDiONDNS5occGL9wvqdFZAdx6ZFbedw5Ta28Nx3KJSyNXzZPrN/EkW+PuRgHGfCJLMCVm3FPSvG68yPWh3x5ApANUeen3CnmPNmAOa/da5OKX1Mg7jH/Gl42pHazhl6NI8QWrCHULZ+fE8Pt1B1oUz5D7BEE5Hr1dbskoJRFHGqle+LVRz/L2Vv7QmhnxoDNP6s19l2N0ezEcf3Fr7f14cOS2wvd2ti9mi/c8q4VzpBNJTeSf77muYGOqEuxNsrc++AdBJ541EETjUgVSl0h1hXMQy9HIEAqNf9KDLl+MrmTx9jCvJ3b8kGfqc0woe2rs+dPVSIRkHSwp82RE7NfzaGEBSFSQZF8xE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(5023799004)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXxo4r1nxaobB/Nt7kh2NJ9XTmbtzw1sCruZ1Qu1wODOjFLqiC4WuH4oARlo?=
 =?us-ascii?Q?w38c/5p3MrPJt/B+O+wQupZml4KetBuSuE4rRUMYjod5rn+5yL5Ocp4v+DTt?=
 =?us-ascii?Q?z2ro+xWaQvfBfmrQvTpzhbrxTbPQJeHkDGwGsjldgGf/PfH1U9qIbTUFfTLq?=
 =?us-ascii?Q?DLXMpplG8AxHsHzXMHDDGlc0gCpPuVoQAsYpW0sDxq0FtaNrrL+PRX1p2/sK?=
 =?us-ascii?Q?EdgOAVg+f1D1LwIhmcNguIrQR1yHTluTU/ucdNePGd/pnKo4L2FkyyyUF/zz?=
 =?us-ascii?Q?RtZowHkFf27DwBDZSEXLxdiInAFZlbD5UaKaEWcNi8iboUmrrUroBsgUHzxy?=
 =?us-ascii?Q?j1Wxp2xw9l2qkBFjZcc5S4yFLu31CQDQ7+s+PgPfCilMnRBLT+VVyLnR4ztS?=
 =?us-ascii?Q?si9DYlhHiuuOU7sS9rVx9q+c2wVz+Q0cKtJfngQYGgRb4vNIuRjct8MsJ6hy?=
 =?us-ascii?Q?OqH3Qi7qTmxojH4fZ28thfG5+psK3S1DhDWeyKvTal8I/VHmOOd3X8enKpE1?=
 =?us-ascii?Q?bJO4ttZ+kdX2N1Py2Wf1z02Xw6AkcPtsOknqjw37Kclhe1qH1YVY6hcQNB4l?=
 =?us-ascii?Q?3opjepxhPJ8RDnfTrEY0YUy7DdtC8rnTA/es/MEs/Pj1KHwVPz8tirRX5b4x?=
 =?us-ascii?Q?USborwm1+LLRUp4fPYAgGxlATC0QrlsYaaqgGro+FLPAmAe+dpWMvh4dHozx?=
 =?us-ascii?Q?GlXcai7mzNjT+2UWZfyt/l+abuUZ9IcS+KruSNCf1foC3jtiWKqtK3tr3tLE?=
 =?us-ascii?Q?+XMk+OqsqKaYzrtQ0gDm8L32z2FihAztouCXjMTIQn5fJgQcGxpYVfkhJagq?=
 =?us-ascii?Q?y4wwulpck3qTPcVuYX476Qds8kNMT3qw6Mukor3wqQVNBJEjjRCTliC4IEv+?=
 =?us-ascii?Q?cawYUAoBtlCsEqjrULHeIwWUA6JTg3oCXT6kbYtYeGAx6J9i7/h9rQGtTrRs?=
 =?us-ascii?Q?P3EmTeqwlka5UAKX8qbXBXUS2Q5m4/UDMdKA8titkUQpEqiNSXnB2WCIBy3h?=
 =?us-ascii?Q?Fwkse63E/wII4C/HbTbSZUNyRPqlBzTuMvYz9n/r0FHascKrixoFN4OXt6H2?=
 =?us-ascii?Q?bWqe1Lhmrb8t86V2p0B/q8G5SZqMV4tPO6MnJ4Sj//DA4tAlSHL1h8tZUjVI?=
 =?us-ascii?Q?2TRr+Z1dQTlEzo+UmhnA9rRE/84DXIlKpJmd0h3VWqHJHE5Owqn4cAe/+lHT?=
 =?us-ascii?Q?rbGxNOkJab3lpSsXxpeqD4iR1oFAe2BenKL6h/inPLj0sKtRWKKG1wOJFSj/?=
 =?us-ascii?Q?ApHiYkmmQ1awhrZ30EGEvPPz9PmFQ+6+EFLUKLaC9tljV7sDE5f6yRr5+P5y?=
 =?us-ascii?Q?GKKaIu9G/OH9BQbfAVFVy99o3ptilD8KLX/fRIhmvf+5d0qYJOy94y9AsM89?=
 =?us-ascii?Q?EykEhrBmn7IZVvfgNSxwuHM/UZZkIvvN1OHKT60krFO1eq4CJREhDG/88eHp?=
 =?us-ascii?Q?8hPDcZmUcpE9BI7f0CkTZEp1JX5/O4YHypUUFkcwk0h6cjsEoLnmYpXrkz+U?=
 =?us-ascii?Q?3abdcPp6lMOIHKw/wW8pYMOTZZpnprRf+Y3GpB4DuJgADB5J68Eb6pB3woRf?=
 =?us-ascii?Q?+iWoyiJ4ArgNzX5DafsvrkxrIkD8HjHp3+2YgopbG+yoCcB8vsrvJIqmnga/?=
 =?us-ascii?Q?+jrOpiSfmyE+u7jNUjpV3ja3AvXb3KCz34i3CbdxoT3NJWkfU4URBp0iGgnI?=
 =?us-ascii?Q?DcV9JtJiUyQxmYcT2dbYjgU2MkRtHy7iwib6+a41A5PAbf7B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942d89f7-2e9c-43c9-cebc-08debac54ace
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:46.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sYTGqAIBPSmw2dnEl/xyu7bCPM9bUiynuNFYqfjQyCsxwWDANP57DZcwT3L+pQ8
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
	TAGGED_FROM(0.00)[bounces-21264-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: E962C5CF6D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To maintain the split where ib_uverbs.ko should not be depended on by
drivers, add a new module ib_uverbs_support.ko which contains the driver
called functions that are too large or too rare to be placed in
ib_uverbs_core.ko

Start by moving most of rdma_core.c into this module, making some
adjustments to split it from the actual uverbs FD code.

This was not done originally because we lacked EXPORT_SYMBOL_NS and I had
a fear that drivers would abuse this interface surface.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      |   8 +-
 drivers/infiniband/core/rdma_core.c   | 120 ++++++++++++--------------
 drivers/infiniband/core/rdma_core.h   |   1 -
 drivers/infiniband/core/uverbs.h      |   9 ++
 drivers/infiniband/core/uverbs_main.c | 100 +++++++++++++--------
 5 files changed, 133 insertions(+), 105 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 8c2ba2ce035176..e2ff9c2be9d377 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -5,7 +5,9 @@ user_access-$(CONFIG_INFINIBAND_ADDR_TRANS)	:= rdma_ucm.o
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_cm.o iw_cm.o \
 					$(infiniband-y)
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
-obj-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_uverbs.o $(user_access-y)
+obj-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_uverbs.o \
+					$(user_access-y) \
+					ib_uverbs_support.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o cache.o netlink.o \
@@ -34,7 +36,7 @@ rdma_ucm-y :=			ucma.o
 ib_umad-y :=			user_mad.o
 
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
-				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
+				uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
 				uverbs_std_types_dmabuf.o \
 				uverbs_std_types_dmah.o \
@@ -46,3 +48,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_wq.o \
 				uverbs_std_types_qp.o \
 				ucaps.o
+
+ib_uverbs_support-y :=		rdma_core.o
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 71e3d58d26e654..b81a1540d0fb59 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -42,6 +42,40 @@
 #include "core_priv.h"
 #include "rdma_core.h"
 
+static void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
+
+void ib_uverbs_release_file(struct kref *ref)
+{
+	struct ib_uverbs_file *file =
+		container_of(ref, struct ib_uverbs_file, ref);
+	struct ib_device *ib_dev;
+	int srcu_key;
+
+	release_ufile_idr_uobject(file);
+
+	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
+	ib_dev = srcu_dereference(file->device->ib_dev,
+				  &file->device->disassociate_srcu);
+	if (ib_dev && !ib_dev->ops.disassociate_ucontext)
+		module_put(ib_dev->ops.owner);
+	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
+
+	if (refcount_dec_and_test(&file->device->refcount))
+		ib_uverbs_comp_dev(file->device);
+
+	if (file->default_async_file)
+		uverbs_uobject_put(&file->default_async_file->uobj);
+	put_device(&file->device->dev);
+
+	if (file->disassociate_page)
+		__free_pages(file->disassociate_page, 0);
+	mutex_destroy(&file->disassociation_lock);
+	mutex_destroy(&file->umap_lock);
+	mutex_destroy(&file->ucontext_lock);
+	kfree(file);
+}
+EXPORT_SYMBOL_NS_GPL(ib_uverbs_release_file, "rdma_core");
+
 static void uverbs_uobject_free(struct kref *ref)
 {
 	kfree_rcu(container_of(ref, struct ib_uobject, ref), rcu);
@@ -214,6 +248,7 @@ int uobj_destroy(struct ib_uobject *uobj, struct uverbs_attr_bundle *attrs)
 	up_read(&ufile->hw_destroy_rwsem);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(uobj_destroy, "rdma_core");
 
 /*
  * uobj_get_destroy destroys the HW object and returns a handle to the uobj
@@ -239,6 +274,7 @@ struct ib_uobject *__uobj_get_destroy(const struct uverbs_api_object *obj,
 
 	return uobj;
 }
+EXPORT_SYMBOL_NS_GPL(__uobj_get_destroy, "rdma_core");
 
 /*
  * Does both uobj_get_destroy() and uobj_put_destroy().  Returns 0 on success
@@ -255,6 +291,7 @@ int __uobj_perform_destroy(const struct uverbs_api_object *obj, u32 id,
 	uobj_put_destroy(uobj);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(__uobj_perform_destroy, "rdma_core");
 
 /* alloc_uobj must be undone by uverbs_destroy_uobject() */
 static struct ib_uobject *alloc_uobj(struct uverbs_attr_bundle *attrs,
@@ -420,6 +457,7 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	uverbs_uobject_put(uobj);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_lookup_get_uobject, "rdma_core");
 
 static struct ib_uobject *
 alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
@@ -522,6 +560,7 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(rdma_alloc_begin_uobject, "rdma_core");
 
 static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
 {
@@ -668,6 +707,7 @@ void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_alloc_commit_uobject, "rdma_core");
 
 /*
  * new_uobj will be assigned to the handle currently used by to_uobj, and
@@ -697,6 +737,7 @@ void rdma_assign_uobject(struct ib_uobject *to_uobj, struct ib_uobject *new_uobj
 	 */
 	uverbs_destroy_uobject(to_uobj, RDMA_REMOVE_DESTROY, attrs);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_assign_uobject, "rdma_core");
 
 /*
  * This consumes the kref for uobj. It is up to the caller to unwind the HW
@@ -727,6 +768,7 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_alloc_abort_uobject, "rdma_core");
 
 static void lookup_put_idr_uobject(struct ib_uobject *uobj,
 				   enum rdma_lookup_mode mode)
@@ -770,13 +812,15 @@ void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 	/* Pairs with the kref obtained by type->lookup_get */
 	uverbs_uobject_put(uobj);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_lookup_put_uobject, "rdma_core");
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 {
 	xa_init_flags(&ufile->idr, XA_FLAGS_ALLOC);
 }
+EXPORT_SYMBOL_NS_GPL(setup_ufile_idr_uobject, "rdma_core");
 
-void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
+static void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 {
 	struct ib_uobject *entry;
 	unsigned long id;
@@ -839,6 +883,7 @@ int uverbs_uobject_release(struct ib_uobject *uobj)
 	uverbs_uobject_put(uobj);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(uverbs_uobject_release, "rdma_core");
 
 /*
  * Users of UVERBS_TYPE_ALLOC_FD should set this function as the struct
@@ -878,41 +923,8 @@ int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL(uverbs_uobject_fd_release);
 
-/*
- * Drop the ucontext off the ufile and completely disconnect it from the
- * ib_device
- */
-static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
-				   enum rdma_remove_reason reason)
-{
-	struct ib_ucontext *ucontext = ufile->ucontext;
-	struct ib_device *ib_dev = ucontext->device;
-
-	/*
-	 * If we are closing the FD then the user mmap VMAs must have
-	 * already been destroyed as they hold on to the filep, otherwise
-	 * they need to be zap'd.
-	 */
-	if (reason == RDMA_REMOVE_DRIVER_REMOVE) {
-		uverbs_user_mmap_disassociate(ufile);
-		if (ib_dev->ops.disassociate_ucontext)
-			ib_dev->ops.disassociate_ucontext(ucontext);
-	}
-
-	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
-			   RDMACG_RESOURCE_HCA_HANDLE);
-
-	rdma_restrack_del(&ucontext->res);
-
-	ib_dev->ops.dealloc_ucontext(ucontext);
-	WARN_ON(!xa_empty(&ucontext->mmap_xa));
-	kfree(ucontext);
-
-	ufile->ucontext = NULL;
-}
-
-static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
-				  enum rdma_remove_reason reason)
+int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
+			   enum rdma_remove_reason reason)
 {
 	struct uverbs_attr_bundle attrs = { .ufile = ufile };
 	struct ib_ucontext *ucontext = ufile->ucontext;
@@ -953,36 +965,7 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 	}
 	return ret;
 }
-
-/*
- * Destroy the ucontext and every uobject associated with it.
- *
- * This is internally locked and can be called in parallel from multiple
- * contexts.
- */
-void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
-			     enum rdma_remove_reason reason)
-{
-	down_write(&ufile->hw_destroy_rwsem);
-
-	/*
-	 * If a ucontext was never created then we can't have any uobjects to
-	 * cleanup, nothing to do.
-	 */
-	if (!ufile->ucontext)
-		goto done;
-
-	while (!list_empty(&ufile->uobjects) &&
-	       !__uverbs_cleanup_ufile(ufile, reason)) {
-	}
-
-	if (WARN_ON(!list_empty(&ufile->uobjects)))
-		__uverbs_cleanup_ufile(ufile, RDMA_REMOVE_DRIVER_FAILURE);
-	ufile_destroy_ucontext(ufile, reason);
-
-done:
-	up_write(&ufile->hw_destroy_rwsem);
-}
+EXPORT_SYMBOL_NS_GPL(__uverbs_cleanup_ufile, "rdma_core");
 
 const struct uverbs_obj_type_class uverbs_fd_class = {
 	.alloc_begin = alloc_begin_fd_uobject,
@@ -1020,6 +1003,7 @@ uverbs_get_uobject_from_file(u16 object_id, enum uverbs_obj_access access,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(uverbs_get_uobject_from_file, "rdma_core");
 
 void uverbs_finalize_object(struct ib_uobject *uobj,
 			    enum uverbs_obj_access access, bool hw_obj_valid,
@@ -1052,6 +1036,7 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 		WARN_ON(true);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(uverbs_finalize_object, "rdma_core");
 
 /**
  * rdma_uattrs_has_raw_cap() - Returns whether a rdma device linked to the
@@ -1081,3 +1066,6 @@ bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs)
 	return has_cap;
 }
 EXPORT_SYMBOL(rdma_uattrs_has_raw_cap);
+
+MODULE_DESCRIPTION("InfiniBand uverbs objects");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 55f1e3558856f1..b626d3d24d087d 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -70,7 +70,6 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile);
-void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
 
 struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs);
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index a1de8fe9c90bf1..c64dd6b94e1067 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -359,4 +359,13 @@ static inline void ib_uverbs_dmabuf_done(struct kref *kref)
 	complete(&priv->comp);
 }
 
+int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
+			   enum rdma_remove_reason reason);
+
+static inline void ib_uverbs_comp_dev(struct ib_uverbs_device *dev)
+{
+	complete(&dev->comp);
+}
+
+
 #endif /* UVERBS_H */
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index a937d276c5c076..ab6f1e3cb47a18 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -61,6 +61,7 @@
 MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand userspace verbs access");
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS("rdma_core");
 
 enum {
 	IB_UVERBS_MAJOR       = 231,
@@ -165,42 +166,6 @@ void ib_uverbs_detach_umcast(struct ib_qp *qp,
 	}
 }
 
-static void ib_uverbs_comp_dev(struct ib_uverbs_device *dev)
-{
-	complete(&dev->comp);
-}
-
-void ib_uverbs_release_file(struct kref *ref)
-{
-	struct ib_uverbs_file *file =
-		container_of(ref, struct ib_uverbs_file, ref);
-	struct ib_device *ib_dev;
-	int srcu_key;
-
-	release_ufile_idr_uobject(file);
-
-	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
-	ib_dev = srcu_dereference(file->device->ib_dev,
-				  &file->device->disassociate_srcu);
-	if (ib_dev && !ib_dev->ops.disassociate_ucontext)
-		module_put(ib_dev->ops.owner);
-	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
-
-	if (refcount_dec_and_test(&file->device->refcount))
-		ib_uverbs_comp_dev(file->device);
-
-	if (file->default_async_file)
-		uverbs_uobject_put(&file->default_async_file->uobj);
-	put_device(&file->device->dev);
-
-	if (file->disassociate_page)
-		__free_pages(file->disassociate_page, 0);
-	mutex_destroy(&file->disassociation_lock);
-	mutex_destroy(&file->umap_lock);
-	mutex_destroy(&file->ucontext_lock);
-	kfree(file);
-}
-
 static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 				    struct file *filp, char __user *buf,
 				    size_t count, loff_t *pos,
@@ -985,6 +950,69 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	return ret;
 }
 
+/*
+ * Drop the ucontext off the ufile and completely disconnect it from the
+ * ib_device
+ */
+static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
+			    enum rdma_remove_reason reason)
+{
+	struct ib_ucontext *ucontext = ufile->ucontext;
+	struct ib_device *ib_dev = ucontext->device;
+
+	/*
+	 * If we are closing the FD then the user mmap VMAs must have
+	 * already been destroyed as they hold on to the filep, otherwise
+	 * they need to be zap'd.
+	 */
+	if (reason == RDMA_REMOVE_DRIVER_REMOVE) {
+		uverbs_user_mmap_disassociate(ufile);
+		if (ib_dev->ops.disassociate_ucontext)
+			ib_dev->ops.disassociate_ucontext(ucontext);
+	}
+
+	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
+			   RDMACG_RESOURCE_HCA_HANDLE);
+
+	rdma_restrack_del(&ucontext->res);
+
+	ib_dev->ops.dealloc_ucontext(ucontext);
+	WARN_ON(!xa_empty(&ucontext->mmap_xa));
+	kfree(ucontext);
+
+	ufile->ucontext = NULL;
+}
+
+/*
+ * Destroy the ucontext and every uobject associated with it.
+ *
+ * This is internally locked and can be called in parallel from multiple
+ * contexts.
+ */
+void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
+			     enum rdma_remove_reason reason)
+{
+	down_write(&ufile->hw_destroy_rwsem);
+
+	/*
+	 * If a ucontext was never created then we can't have any uobjects to
+	 * cleanup, nothing to do.
+	 */
+	if (!ufile->ucontext)
+		goto done;
+
+	while (!list_empty(&ufile->uobjects) &&
+	       !__uverbs_cleanup_ufile(ufile, reason)) {
+	}
+
+	if (WARN_ON(!list_empty(&ufile->uobjects)))
+		__uverbs_cleanup_ufile(ufile, RDMA_REMOVE_DRIVER_FAILURE);
+	ufile_destroy_ucontext(ufile, reason);
+
+done:
+	up_write(&ufile->hw_destroy_rwsem);
+}
+
 static int ib_uverbs_close(struct inode *inode, struct file *filp)
 {
 	struct ib_uverbs_file *file = filp->private_data;
-- 
2.43.0


