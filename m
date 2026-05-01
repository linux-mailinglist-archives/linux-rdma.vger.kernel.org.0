Return-Path: <linux-rdma+bounces-19806-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCX2DKfv82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19806-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:11:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E54A926B
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D42305933E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE919005E;
	Fri,  1 May 2026 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kl8do1sH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D627713;
	Fri,  1 May 2026 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594133; cv=fail; b=WisEd0NBfPJl+n350i4QBYsQdRtWBuJOnBUf6mvpMm6YlAZFnhkNoN/tZGSabnsm93WJkuTi48wiW2TxmiypY/2ftoQcpKANKWiIepBJidM8KCnrsMJxJF+tn8gAZ3E/K/vTrPzeq1v5L+AGg8IPQ+4j7C3yfsaLLD4R5eFkf9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594133; c=relaxed/simple;
	bh=0LP2z+xOWOZyqcniogbbmCcafb827GhVfc2PpurE3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsNlIgabuKnm3J3OEdxXOY+SYhlKgnkNnt4Qwajt6IxwHcZvJ1ONnHMuOeyLti1q7VyLqOctpglOLaWo5BLGB4JWnZrvgn3ZUEHp9TOA74rAmJI5la16yAW7gZ1vYYxVe6KLJaQ7EsFlGN3dlQLPlwlCUsyBOvQjbRZ/uwyOHcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kl8do1sH; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlsYlbBGM5kYGVDnoLKOH9FJ5CLLpXeM6jY/ep9kc0GxetkrW2iwoHOAMHmfr1HSJ1TPKCbY4bFVG/sWRDVhW8dbx7Wk/K4jPXknmAe7gXEgjrO02UzapEi2V44ZSk9SjZEsoxQCE+sS7UTTEu2H0ovunzJOeOnxBxh0/Evkw5X5OyGl+fSnErnWqdLSo4MN/Od7rK167NFrEBiNxkorRT2yg17jl4UUCEUbSmEMy+yFKFZy4RSLrauHl49f0wqcHzvm1WM8wDcP1n0Pbp+EG3LIOPBtK3dDrXMRg678Lt8bADiddRMXBDLsgWyrp+c5kPJ79a5u/sq2Xu59qxTNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idxx0sOW2jDAzunM8BtnfSE47qawcM/8bv+SQmPiIFo=;
 b=ejckCD2GGwzmoL71WJMwYpr78I155/QS1WAoco65LSeFJYpB7kO1mx/yWqIqEUkoXn4/UqfrUyDBIHqMa6XcmlmWD5rBdbJVn+63+ixN0M0qF9DAlLBM3TuOGw3Vr1Ypq/7Fv1X6lYbQcnllVHUpMlCsMLmf+IrOJD4KCmvCKVnkZA3iihTS6NjWupcxY/+NwbQ1sgTM+TjfrsTSfdmnqmnMxxmJoE+XR0chfHJDSCxF3AIpGSQ3KHS+IQltB2k01BHonwgMXaLTGfsTz9xUoXoI+1ojiBP25SM0ahHcNdF3YThOegqWfGHqzjSFFCCAb614n5PURSvcvToHzRNILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idxx0sOW2jDAzunM8BtnfSE47qawcM/8bv+SQmPiIFo=;
 b=kl8do1sHBlf4ytGiPqWsimEj65JrSw+uJqUawJu+TnidY/5zgwXOUaNHd9jSwprhHvvUbBDjfesPQctKa6/1JrTK3NJeQYe8YY3qepq521FnQAGI7uCQn9pFXafN3Ax7c5VjBusnIigCIotyU6hPNCeVFL3fMqCgQUbubUr26dbMfCeDrTfnt951PcQyFfRoozA+63vHxWV/R0ANRl5s9F8KVK1UcjtvS2zq+IKWPgPOwF0KtYeuolO5RBWrL5cHcjVf7Ki21n1gkXzizqa6Nx+CbWFse3tuKSgHbyGmaOr3JU/oRtDZbk+PTrHfahUFywBvMq45c6FDyKkqaQ5o6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 00:08:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:43 +0000
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
Subject: [PATCH 08/11] vfio: selftests: Add dev_dbg
Date: Thu, 30 Apr 2026 21:08:34 -0300
Message-ID: <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:23a::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f0c97c-6758-4e74-01dc-08dea715cdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KDZLhxaNawG3T6K1RRE/UoSGF0Grfj7mL2oufA4Z3r/pKEywwrl3VfsApjRFf+u6rq7o7Q45GBzjZdyg7EJ/SQKVhHo2XUlx4KzEPQo3xp/etf5+7gUdSwk7f3dzY4/t0G79Ql4uza5bLO5kLPZibauD6rMhSR6hcVG4K2WHKVqebcDaBVx3XbEfeoBf25CP5efMasuKJJIpXNO1UzYVhSttO0dIyk8vjwcVC2Db5avAChePuGwCBuADu1rOsjjZxOsHRb4T3f6WsJzN8ON+hY4lGuoJjtjo7/j1nNWZIHegvP/joSbLyVbqJyVzcblLW6GyPm4x1aCN2uWVndO7wasxdkiNNfB96Cl9j8ksmCZLX2VXn3E5dzurXM3XK1tIzSS9FgT1K3zu4qQADQkE77FU+cPw+J0kLlUrT5moZXv6DQSWmCPmA8Ffw+OF1Qse3iJbyhWPtaBWnpVtBYs/shzlzkHyea8iQDJR3/zud0O87SDSiWLQ7OD7GymOUzXU8Za3UPVvUJmbPO14URBMSs8OJb5Hz1mn8e8WDLbSwbmunIqVatbx3Ed2Ifn+d7iTj6XFW72KIFJKsi8fUnW/+wtTkFiiJrjP2fsdmj3MVT1cbG8IxwRqw282bBzYUTvPy21mvcIDvcD4MUd8gYabSbp0fdLyWV7i8o87wdrKgvf4+iiPSe+phvQOD8fcnXLCRrk87WomnqZ+NUyS6HSQDtR/JBZtaVyO8Mt1fg05fww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SWV7KTqAzgNzQKj7yvIUaJJ1r5xiwtIRqIECDKdL/oVIHKCBO1T80DemQNL8?=
 =?us-ascii?Q?bl4GQmm8qrx1pU8awkEZIKiySMaqhNd870sKKbV1pK8lu0oyDUUxNF9u2Via?=
 =?us-ascii?Q?05Zy1FSXLBHkwzVe2lk8Y82T2X+uB1VOptqQPyx0F6MbT4EgfUQK4np+w4IR?=
 =?us-ascii?Q?lE8HaEhdg6O+kcQjSOVpjacIX4aa08RyuIEhUL3PvBLWDPRl2H8c1dxXo7JC?=
 =?us-ascii?Q?x/ku7aJkFO7KDFE9VurHzehZjg6xdMZMdxBGkJgtC0+PYr+4DEhTNIdQlbjX?=
 =?us-ascii?Q?O2GdcbYTCW1LZHNJ610C+59W/n0106mdJoNLHmKhQBwQRHB1rPcXoEvPs98K?=
 =?us-ascii?Q?6oO5k+zPMaMIj/z5HKZCj/bNBgubdzktCo+Srly1tfU//V9iAOt5rmYt21mp?=
 =?us-ascii?Q?mC6aWhARyVUQh9lXadvOKbcrBfYWC+whZIbSjb5x3vJ/QZiN+UIJpAFLEDMP?=
 =?us-ascii?Q?O/bH6PE7b/1bbqb3EezMZgYZMKqCw/whUwpHl89bFxIoM3JFX9gUjuP23kuI?=
 =?us-ascii?Q?TymeWkHtmdzG8zK/ZxLnihbvtsAsw3r+NiCrfLm7qpTS9rp8ZKf7asWZ/Wlh?=
 =?us-ascii?Q?5gIv1paGmsuOZKftucqLdZJavbU1cpKP1WO9zE9700kdSD5Nw4mYSKayy/0h?=
 =?us-ascii?Q?TqBVJroa95qhNv+dzH8x4H7Z6wc+Hd60DqkoxQsjc18Lb0i1f0WYqgvJ29jm?=
 =?us-ascii?Q?jnGpzx+OFHyauGSXj7/HQB+w4ntJ1AAybGRQeS18QoL3wSYJqEBcelzEaDd8?=
 =?us-ascii?Q?pfwGg1WiCgqBbdlKUsvWaWzxeE01zE9V+IsU9eC7toMxXoX3++YWmMlrr4W6?=
 =?us-ascii?Q?CF3iukFNhYAboUVZEPXqWsWeoahgCZWmuyfIQ8190oKC24dPi/tEpiyh/Xgm?=
 =?us-ascii?Q?ejI4SLR5VFx7f4W6PPcZzHHflj2GHhcXWANxpF3v3OiN9YYUmq37JySV2We0?=
 =?us-ascii?Q?oyUtpQrIwUCnD+9b6z5dOH48MvpHz48DVUZDJwP8POD4Hbd3AhULjl+9qGnP?=
 =?us-ascii?Q?BDW81HtdqhppdamAof8RGMhm8ZeXtCwIgGKRrBYLlGJOdiUtgABFvctO3RNO?=
 =?us-ascii?Q?EyH8sOlqVCE7xManKoDqnt1JfWCRY4YFLISQxXrbvO0aPX0p9kJapqE8fj5i?=
 =?us-ascii?Q?83VHqANo/Nk289ftIdvOzPK42e7iMDL9gMKuiEKPx+nXRnTro/AadDYclZ64?=
 =?us-ascii?Q?X3V1uxVCNXFz0SUh2MwL3KydJONacwDMPbNhxUW8R4RZ2wLPaLRazEH0Hezo?=
 =?us-ascii?Q?hBck1ou1iuEFIYvVUcaI/UHCdzmuITAVNvDgr0HC+U0RNrY7zzna3oUGyLA0?=
 =?us-ascii?Q?wc/SqG6JDOEj9Po2/QTz2LMguZ6Y/RN97+EcE/2zS36cIQVNVDx3Zh7zDGOx?=
 =?us-ascii?Q?+hYc7w5CuewxO+0xtD4Kje5NP1UvU2G0laM0vKhbZZ5zA0rKQwyqGYoeUTmx?=
 =?us-ascii?Q?AaUq+VPpGnlxEUi5XkKTl2R6/2N+QR1eL2BzQD4+4Twrz1iHjIF8oXMlcKfS?=
 =?us-ascii?Q?V58HRPtT5IGQLnHdDdEZkVH9wJspFWFOmes/oYeKnX5nUmqmTiIGvlZqXsZL?=
 =?us-ascii?Q?BVhwtbx684AZUQY+MkttMTtLF8IqDEkxKZbVgJlNAUazoIxOxLvKvtUqqvWd?=
 =?us-ascii?Q?cqs66PQ9zLcJ/DFEFxfZoXAt5irglhPBj7JJ7rbrZD75DNCnAu/Iz4u9XgZ4?=
 =?us-ascii?Q?RhAuvw2GoIAE9kMU/hX5hxYiYwOTUjR4Gv2X5301QoIDfmc+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f0c97c-6758-4e74-01dc-08dea715cdb4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:42.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPGEn5ehgXNj1D8cWPiBoTkjaPM5Dly5tWzAmGXk3waOEqTLmaeAMMNa6IJPIrYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Rspamd-Queue-Id: C84E54A926B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19806-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Enable it with a #define DEBUG at the top of the file. Allows leaving
behind debugging prints that are useful in case future changes are
required.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../selftests/vfio/lib/include/libvfio/vfio_pci_device.h    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index bb4525abd01a22..2d587b988c09fa 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -38,6 +38,12 @@ struct vfio_pci_device {
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
+#ifdef DEBUG
+#define dev_dbg dev_info
+#else
+#define dev_dbg(_dev, _fmt, ...) do { } while (0)
+#endif
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
-- 
2.43.0


