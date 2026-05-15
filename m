Return-Path: <linux-rdma+bounces-20781-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGLL55ZB2orzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20781-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:36:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1DD555485
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A99AD3059C41
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B33F8EA3;
	Fri, 15 May 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9GYS561"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D33E8339;
	Fri, 15 May 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866223; cv=fail; b=BKsL2QTPNN0piteWAut/eqSdxdC15XsGEKCKuM0gis/O1d3av9rbEvrhVmuM0/GR3BDHxGY7Kl6/5mxmVaNhuJUb2kfxZ9VQY8hvchYjUaymUv29ws5xY5nO8inBcLV1U71ot5Mqw5SI9rIJG0gLFjT3p2cs0lmZEJE6LCYIlSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866223; c=relaxed/simple;
	bh=rftEkbZi4D+TdEiyWt4fh/NmXcyTdKeMs4cHPFE12O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtQ8uKKcVtrAxqKV2kcQbMmnh6fgLrvYciITEsZUPNneZmJfz3Lp0hl79tuqjMZ+TN8o4iZMIbkSaJ/0/QIukAhxpBrmOt1HaMVcrrOMPxWV4sTzDtS0P9zqnyZm/qEUnOXHSU4tUBNiIhrL6W1bnQRLSNLCAE5QQk7MXEoABmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9GYS561; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs7WpCvn1Ez6XTGI9CyEYpI27kvVD+HoRyK+zJ4sgV8A9HDDq2oPpMBFTXk+guewmDnM4am8iA7WfNDo2B78kvcHqQ62PtkUOUba81BcIgUk9VK7OopCBfj1TJMEXl7itTF1H2CwqTdaHTMSQuv9Q3ENHb0N9/yKJXL862J9PbDjHI742zUm2th2xuD/mXKCHZXwjbMNbHUrMw4W4GbJyCNknP0hz6ygrObo1nRkTsBYa8ztGB0eL95QrKJcKkX1D7L7d+/yilRWMJJv1+1waB6jsOR7DLsk0pZpkDinzwteWSUZuyWEhqBkZI3gE3PM6E80ZrdNHmsICwdzCttVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rZnSffH90oykqP+pTlS6Hy5SVEYA4IPtAZnLiBfdNU=;
 b=WM86TBsSkhy15EfjUNW8I9FOzK5oqaEozZplVgEwexcnFNFvLsUkHlprkuzPC+WpBoNIhiuT7hEwhiwAIB/AzgPd3Lzc//un2T90VBpYBoGa1ihAKSLtdBC1xzFIV3BGhJkttN5mk/V23YNWRP5JQVoDnszbmSVdF/CE6BhWdagAr1brdr1Xwt3mrWZE6Mv1Ej4L6gNmmZ9jIkji7eMpAcj18i3El5JveuDzgdipgRDUFzE3T0m2j51LW9ANIlLAEudN+Sje3xhtfn8r1Nl5LERqQ+HozvrrPN8YWvDrISvRvRJuEACX0RjGNY5u2Vmbfw+LrlwhPOfoSIEDZb4sww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rZnSffH90oykqP+pTlS6Hy5SVEYA4IPtAZnLiBfdNU=;
 b=M9GYS561WMpyHR1e5qLGQqxHIu64WLTLtyVIXnOQi2OHMO/+s6yKggvsf7i8la/fsOS+kIGUWuC+iK+zhbGMJQUeMucht7386vx66/Wi+8fA9kHyfcztnOApeetariqQx/+PQWH8kE0K4YxUIjhr22Bpp62CFTO2eIq+tc9iq5EMK39BezlwxhWFd+DS4xFBrKP7BB10QibO0WCbBmWyOFQGjdKW/OnJaFp7aeL3mVHhU5MfgEC6bNDnOFlkpH8Ku3LpGNflwWkdIRR6z1NZBikLZfqxOOJhIJZEUZFF0Zs0sdRaUNE/odzCk5hbyRJAZPyoXBhic18Y+4i5EtF9Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 08/11] vfio: selftests: Add dev_dbg
Date: Fri, 15 May 2026 14:30:05 -0300
Message-ID: <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d9f808-bc9d-48a4-1bed-08deb2a79d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	eC6bZMu3OPdNTRZyeVdUGBmaBCk0pkYTHwtxUzPIYqVk7w45n/O9DmpkaY9han5HsWw52sw6TXUuPXaujG5EVH7kppQp0+4hEdHJGBktLWUAU08i9VxgaN9wtHnr++Ak0WMoArfll1Qx45OPcVSDp6o8cl0KHUw8SD2Fu5JVmxq/+WNtI+1sE1KCiOVFj9AP0nfH8ChGNKA/va+NGDPCaftNaH3IhqqQK23v1+IO9ECUxIIoG2pTFDRdzmSmB+VtyvYU4dndaiNSrOJqvix8zilB3G4RJqnnmCcriD2s5iuOQlfsAKvDhfpHfi0WjP7jmfSFbf441egq1IPi0x06sOs/Q6eHmiVt62PvvJ1v6r1QbBkLTh3GIj05GVf2Z4dqjJ/Q5K1NUXYPRFM3o7ClxRpiddDtd52T2nYuek0pME0PC3RycHUHFLKYVnAa9F9gu6XCsiAV2utOLNhPuZvdm2m6TMbXtC9X07+7EZYwTrk9GwS0qUIQy9vQ9WxUmax7kxaiB8g3876YgqFNRLmYkZ7lsYmLjafnvWRcBDaR49+BaU5IszpXi2teeNgt41pfI3IiArFEcSS/fB6SvQNY2K5oQ22NxJ+kFeBnMuIOjAVrxBRzuy42Au3pYDBworTy23mxQjakX+YZLnJEcRNRXvR8jntOs5UFL5thglrDYK3CjZ+V6YJR6IfnuuwYRMdAtZS5gk2l4/i3Tu83LdJ5qkvdfCD/MSRcYRofpZsNQfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VJJDNded4qSKB3aB24G3ZUUmMmEhUdpBTRwOjPTrpxN8tALJgkSXIQic70H?=
 =?us-ascii?Q?7wHqeFU93510xBkgk1eqNIZZ6QVNBYmO89ZgdixV2o7ZDWOlpcrZPjbnSEkQ?=
 =?us-ascii?Q?o8KRUE1Qr2tGdqX7dH76o/1w5D1c7xRgLUlLkEQcxcRp+Yn6BpbIIFoDxyIW?=
 =?us-ascii?Q?yKs+O4CcWBOWI85mWWuri7tGe9j0dOlxp5WeRx/XffakiJfJKPcvpGyZ/UfY?=
 =?us-ascii?Q?ZPeEVa9QQZfTqmFEEWQeO/pteaSMoaeNvtQSzDCyKAAAiQNtYSEhpe459okA?=
 =?us-ascii?Q?jHD466EDKWAu8UF7BZia37gve2DQOR+Ll0BiColhT/F66IK16pSf/dn8WKNY?=
 =?us-ascii?Q?meBBJ1HubR9sTqLybg2FREUk33rEOBmgi/Lw//pcxw9beTBv73ks0/Okk6AV?=
 =?us-ascii?Q?NcNnB/qhCpgE9HZcKr+np/Fczga6dLH3yqk/4JtHsWt/1jWMvMtIzKZ5ckQ9?=
 =?us-ascii?Q?nG7GMejQ4FcYcN2+pBl1mobotzlw7PzFqa+gOIfhdQWLu3kkBRYAVHUhZTIj?=
 =?us-ascii?Q?e63qSTF/SsxeWINAqvJg+GaYOh5VG4I7Y4viuEpLDQKxH5JTcIPiVTNzIfAH?=
 =?us-ascii?Q?Z/g/5thDaeCpmJ4yuUG6LdC4TZwOiLrPpporGsDQe+IpiP6HEfhQqY8C3MT1?=
 =?us-ascii?Q?xhm96O9VVKu663VkpvTEItXfb2pQrXrC+jY/0Am6GZXtHBzNH81uBu6kCZxH?=
 =?us-ascii?Q?W3ptmJ802CRDi5Putt34K5WpM8b4jB+IQBXdQkgEfcBY40DDCZ/Cjc+mh8WV?=
 =?us-ascii?Q?6kc0WZE4lMu5tmCSL5CgrGW1J6OWS0HQITG9m9QMeLJ4B0/sC7LJgDldXduy?=
 =?us-ascii?Q?AJ+FoLSyofiZ9cvcdnu6EH/0610iTcvOvt4tTskEvsS4Ka17FpCN/b2AhEL+?=
 =?us-ascii?Q?bXzcMzUinbuSRQeB/ZeLrf033aJrJMvvV/ydmJXhoqwdDRFKUaFDEjcFt0de?=
 =?us-ascii?Q?Zc8IsqTJXI65yS/c/6yCcTycax8a8tYG+SBf3F0Ug9MzFUuQQbE9CCVThoJg?=
 =?us-ascii?Q?U195SCNqQ8Lgik1kCh+8db2iio5efZnxJptRl8+8z4wia+rUJaQKaH31NZcE?=
 =?us-ascii?Q?qtQRhdjR/GbaPMQwHMpHr/8LMo4rcC8fQ3W9qf/eqKlfq6AP/u6mp1HpwzjZ?=
 =?us-ascii?Q?F6N7/5vNPGmhLuSaefCjHs5ub4VPF5Ss3N85/al7/1T44/BxqykH7kiQUdLW?=
 =?us-ascii?Q?SScTS8BP/TKlHcY4IYp5tRh/g5YRwwdbTjlcEL4mV1AMGTFCafki1nEZSTdN?=
 =?us-ascii?Q?zOUV7d/P8GrzmBuxTIDQMvhk9AZuc/CKqpGDbFjt7OG3WeVEOQ5Iu/ZY2kDg?=
 =?us-ascii?Q?eh00DtzRJgt8BEQ2qUw13S4cLXttfLA7FkzWuAEB7pqqGIk5OHyvPo0Ayk66?=
 =?us-ascii?Q?X1PT0hS2HASLPhBydsAqA7Re7xJyHubkr9vtIJej7fL5GjZXLuhxgjVrbyj2?=
 =?us-ascii?Q?3TktW1OakL/hQ7mOgXFklQAQ7BVXs3ZJuFHFX+xLAJMzdWdpSicCSVhsZHyP?=
 =?us-ascii?Q?9bms3+M/xfYXVCCe0FDLEFIcjkA3XdtgaI1kBXt186qD/2rt3kgu8bJIsyeT?=
 =?us-ascii?Q?5eJAYtyfGEnd37YqxwvTnCO13r6BQ6043Q7OC9U675Lmr+ZGdJttq9zi2WCu?=
 =?us-ascii?Q?RaFe+qlfaalV8KIyvp9D74rgv2H+HrQDu3cJ+Y2BLSNQOa06u0awKDR8XZqW?=
 =?us-ascii?Q?D+05StBNlxxlFAglOvTnPdkVLHRMfQfd2AXNtxcTcei7nFD1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d9f808-bc9d-48a4-1bed-08deb2a79d8e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:10.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDvcFevGaXHzfNgucJYr6EwlKfGzPwf5ltaJU09zdwKvtF/mzgMnTNNSQFNiWr0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: AA1DD555485
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20781-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

Enable it with a #define DEBUG at the top of the file. Allows leaving
behind debugging prints that are useful in case future changes are
required.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bbbf..3ae9f2418f3036 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -38,6 +38,16 @@ struct vfio_pci_device {
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
+#ifdef DEBUG
+#define dev_dbg dev_info
+#else
+#define dev_dbg(_dev, _fmt, ...)                             \
+	do {                                                 \
+		if (0)                                       \
+			dev_info(_dev, _fmt, ##__VA_ARGS__); \
+	} while (0)
+#endif
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
-- 
2.43.0


