Return-Path: <linux-rdma+bounces-11779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E41AEE63C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADFA170912
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7CF2E7F13;
	Mon, 30 Jun 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="SX1zvyMX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8862BE7D1
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306302; cv=fail; b=b/xr8joPv4aCPFqauh02/Yi9ulCoi1wRH4PCHTYEWeF8mKdWR+Y1UtDiKEDCK03TNQRblefR//x1P7uHo5fw3bYzLSXRLewevEM1HQbOLtdxR0hWSUq4Zjmobn35qfy1NO1VGDPF+7j6pZRqzp1TOpuuW9ugy4nhNL2U8Wbc0lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306302; c=relaxed/simple;
	bh=G9SwVKY4dxBpC9+RXFBxcF1Zw8wDm+In2PhtoSAH2HU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRX9r9OmkHo0mHx8KOfRy8SjsFk6GFlrgLSoxyidzdTuJiepTCM7EJsogFqEfL3I2OobDgXT+JZt2zALFtsp5ikr0IM7n/pWybKDv4/GHJKR+SGZKURgQGnVcA6DnSNkz9NE3g71O6TnhVmitkpik2b0shPxwEbviN+EBQ/neB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=SX1zvyMX; arc=fail smtp.client-ip=40.107.93.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGXCKy3afp7li7yfswSxM0unVu1m3TTZKidkB2NZ0TUfqnFDTZTcbxihs+J+t47stRJb56hJqF5ugpnp18L6wIeKkbsad86ikApejoWBTHuYP+Ql9azmpVgo8V+YLMFaHkbyKtTmrM+Hi4VOYQikzFCL3TnNXjak09Wu6h8PycwmsxhoLJw1ERvYzwQ8ufK5P5tBqclm5bjwgd9eLOPxcnwkHnzqLyLGvoKNN8/AukvXmMktfGwVnj5f3MWrZ7SmNmLcoO4LgrOfZphHL2KuC7N2hG2as/qsS0lny+hnbLKUlIdvV/ADXBd0OhVnpEytjJsBLbrVpi16C1Y+NYcj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/20H3x/GC+qBLF681vZH5LOjXE8PLrMyW1485MnPvk=;
 b=RxLHW3xetrKq9y6+gFE2GiGnpq/FZFF7HNq/5muTLSmkP5OOYq5XKiQ2uJ6y14Skm1AYr9WRyYwos8u3rC8AfTO5YbvRGjksnrvBWv38CPdcafBzas/gBrucOB4cWP66ilbLKIVvHdpcMP/vZJ3ll6oct4gbmQosQOEGBJ3XuOgy84zaxiFN+v2sHDxTQk0yqaQOtxR4B0Pg7lUEmYObnock5ZIqlfqComhKZWnYQw+tkVYsBqBvZJAlSdz/jEf1QWoHvexKegNLD8gjyvcYLFo1F3Yqy4Zg9+DTBEIHHfZvZe6nbECQEKE0NqB7ZuCSAu949tK3ir4mvbW3Nbl32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/20H3x/GC+qBLF681vZH5LOjXE8PLrMyW1485MnPvk=;
 b=SX1zvyMXfCkqvasqYAlaBYKo5SOPw5Gw48h8jmUv9RMymIBzqU0OIozkqJxXNKcosYw/6Dl2+EDaTryk+sZFbauhpZWTHIUu8YfGKhjKiVm1NZPlycunAVkiJcPnrEBfXvZwr/87KAamOOSyalCyiI5TpfZQjqQkyLNMiyI5P8xAKh7uA9i9Tfvqj4/ZxtuQzVWwVcJv9tP8EFPQosP4p/ijWnxjiSpK8u1vYMQPlqAU4qOpRS20mRH5I2M1zfA3b19fqfVcNcgpRnOJEXOIYj4v8dnR6otL5ngA9z7WOH0Pb0pw2ldEvvvg9GWDMcra4RtO6ljkKOSI1s1BQAisow==
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by SA1PR01MB9106.prod.exchangelabs.com (2603:10b6:806:45b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.32; Mon, 30 Jun 2025 17:58:09 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::16) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Mon,
 30 Jun 2025 17:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:07 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id BAD7514D71A;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id F0DC91811CE73;
	Mon, 30 Jun 2025 11:30:17 -0400 (EDT)
Subject: [PATCH for-next 06/23] RDMA/hfi1: Remove opa_vnic
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:17 -0400
Message-ID:
 <175129741787.1859400.7033099190800356659.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA1PR01MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 41aa25b2-c16c-4e11-31b9-08ddb7ffab65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDkvRDZBcjVFL1d0RUV5SUpoZlNYeXhCZ0ZlM3NHcnpBMkhzSTVkOHBDblNa?=
 =?utf-8?B?NzVKTUdiY1pvZmxzYmQxUUFzcy9MTnoyZFExQU9XUFJ2c2lha2NSb3hYczAr?=
 =?utf-8?B?aTVnRit5WEtEdUJPRjhmdjZMcnVmYzZwNUNLNjhsVnJnTW1BSXVyREVjNGdH?=
 =?utf-8?B?T1ZCclZpb0lTbWEvdVJoV0lRVkdnUW9aRi9ZY3ozWkFoT2ZXMDB1RCtmNVZD?=
 =?utf-8?B?QTgyZkpTTFdSZ3JBbzdBNHozdUlRVEk5azljNUxuQkRoL2VUN1F2S280TGFv?=
 =?utf-8?B?eUFVZlBqcDEycUV1c0dEOU0xT3JlcTQwQXdMTkxpS3Q5amR4LzMvVkJlMWRy?=
 =?utf-8?B?NGZLMG9DdE1FOHJtcVVXZUtxZzh2c3h3YVBacTNXcm00NmlFUW9yOWpyUWFw?=
 =?utf-8?B?NUFxN25ZRnA3QlUyd2FEd1FZUzAveGpLbnZxRmx3c0xybTFBYVY1TkhkcWJV?=
 =?utf-8?B?K3RrbEVMVXZlc2NCMi9LOUo4eDNPQ1luL2tXSTQ4Vk1OM2FSVXRvWmZEUXh2?=
 =?utf-8?B?UnNTT256Q1pMb1RRZk5FbDhrUTNuUE9ZTWlScGgxMlBKcVBNNWVXd01iK3lK?=
 =?utf-8?B?NEQwKzdzQk1OcmhSVWxNcUtOVlNCRWE5ZDBhL3hIQW1SN2hyQmFiNUJQUmFS?=
 =?utf-8?B?QUhNeGVES2U4ZzlFUjZIL2pZVU5ERjFicUQxY0lnRkdoeUxKRkZWS0szRm9B?=
 =?utf-8?B?MXBCR2s1ZTMzS1BMR1hnYnZPSjRBTmFTNmVhYUREVzVTK0VlOXh6Z0tVZFNX?=
 =?utf-8?B?RGFaQnBkdHM3VE5DSk1TeEVVU2Y1aUJKVEhMVWJ3UitOTzk0MW16YkttR3kw?=
 =?utf-8?B?L1B1LzkvdndueE1sZ29OdktscVk0UVIzZUFDaFpSSXl0VGErdlhNYS9DSi9E?=
 =?utf-8?B?ZzJYUFUxdGhKZDJWZ0t5aHd6bFpVZWw3V1BWR2ZETkVmaDdsMDhqY1ZmL1RB?=
 =?utf-8?B?MC92aTRoWFFOQ1RpcnVwdXZiTkxPNVEwWmJNRVlHalpQNWpxTmtaYitROGxt?=
 =?utf-8?B?UXFza05NTkZ4VDJOSXZpU3NFeEpWQUFmYXlyYnRiVGtjbzExZTlqYStEVnZw?=
 =?utf-8?B?bG9JRlRwZEUrNWVYdjJQOTBnNjhDUUpQMnZwTkQ4ZXJoNGV6bEdMT1dxeFJv?=
 =?utf-8?B?Nm8xdGl0Q2RVZHVDaGc2UGNVQXJ5U0NFU1JTS0xJU09vN2hxbEUwUEx0L2lU?=
 =?utf-8?B?WHpYRXNaSXd2WFZ6VWJaZ0xycDRqU0FkQnpxdnVVa2N5NXZjaTlTRThsY0JH?=
 =?utf-8?B?NzcxSFRGTWh3VXRZNUV6NkdsVldrdUR6VGUzM2JNQWZZMTdBbzVJenJSZHJ1?=
 =?utf-8?B?T0RjZUc3aVB6REpPWTd3dnZ4dU1KUGVHTWQ1QW1CTzJvamI1TGIvV3dnRU40?=
 =?utf-8?B?QkxaVERnTEZ3MDZreUs1U0JKVzdDaFcwUjdkc3VaUFl1Qk1hQmp6QUNZRnp6?=
 =?utf-8?B?QjRDQjZUUkpZYmk4OTVnS0hIOTJWL1NMbFZHNEV3ZlEvUEQ2M0Yrc04vbWNk?=
 =?utf-8?B?RjUzdTduZGNGS3hma0xYekowTS9hV2xKUmIxY0RNQVo2UUc3K2haMDFpbVdi?=
 =?utf-8?B?RExBRkJ2bmhESGlpOHB1WUlRK1hvTjF1eE9MN1VTOTdwNGEvSHI5SWx2NzQ3?=
 =?utf-8?B?L0hsMzJNanJHMGpoNWNhUlUrdWc3Y01zUXpDQ3hRWVNaTFY0WUcvMFpOZXl4?=
 =?utf-8?B?Z1k5alErODBwWlFRZEljd2g2Tlc3WE9yTXgrK1VlSGNKNW44VWNKaDNzMUd6?=
 =?utf-8?B?bmdXcEZEblVqUEFxOGdDVm5zRGR3T3duVUxGLzFQcEhLdHlKb0psZGZHQXVa?=
 =?utf-8?B?QXFrMHV2R3o5R2pSdUdvY1d2SlZJdFNGSnRzL3VGRno5U1ptZHMyU1gyZWZI?=
 =?utf-8?B?V29Mak1oMG9CRHIzU1lGZlpjVE1kL0hsQ3ZzQVAydlBMbGNzbnJIK2NVQkxq?=
 =?utf-8?B?SWk4bXJSWlJGRTc4ZHBEaE5HbVZVemNSb2FlVzl4NWtBRjA1cUFDNjNaYXRI?=
 =?utf-8?B?UVZQYnJaZERZWjRzRU8wVStJaTg1Z2g1bC9FaGdmVHF6NW9GM2o1bGZMNk5V?=
 =?utf-8?Q?kuvtpu?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:07.4634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41aa25b2-c16c-4e11-31b9-08ddb7ffab65
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB9106

OPA Vnic has been abandoned and left to rot. Time to excise.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 Documentation/infiniband/opa_vnic.rst              |  159 ---
 .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 ---
 MAINTAINERS                                        |    6 
 drivers/infiniband/Kconfig                         |    2 
 drivers/infiniband/hw/hfi1/Makefile                |    4 
 drivers/infiniband/hw/hfi1/aspm.c                  |    2 
 drivers/infiniband/hw/hfi1/chip.c                  |   54 -
 drivers/infiniband/hw/hfi1/chip.h                  |    2 
 drivers/infiniband/hw/hfi1/driver.c                |   13 
 drivers/infiniband/hw/hfi1/hfi.h                   |   20 
 drivers/infiniband/hw/hfi1/init.c                  |    4 
 drivers/infiniband/hw/hfi1/mad.c                   |    1 
 drivers/infiniband/hw/hfi1/msix.c                  |    4 
 drivers/infiniband/hw/hfi1/netdev.h                |    8 
 drivers/infiniband/hw/hfi1/netdev_rx.c             |    3 
 drivers/infiniband/hw/hfi1/verbs.c                 |    2 
 drivers/infiniband/hw/hfi1/vnic.h                  |  126 --
 drivers/infiniband/hw/hfi1/vnic_main.c             |  615 ------------
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |  282 -----
 drivers/infiniband/ulp/Makefile                    |    1 
 drivers/infiniband/ulp/opa_vnic/Kconfig            |    9 
 drivers/infiniband/ulp/opa_vnic/Makefile           |    9 
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c   |  513 ----------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |  524 ----------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |  183 ---
 .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |  329 ------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |  400 --------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    | 1056 --------------------
 .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |  390 -------
 29 files changed, 20 insertions(+), 4857 deletions(-)
 delete mode 100644 Documentation/infiniband/opa_vnic.rst
 delete mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
 delete mode 100644 drivers/infiniband/hw/hfi1/vnic.h
 delete mode 100644 drivers/infiniband/hw/hfi1/vnic_main.c
 delete mode 100644 drivers/infiniband/hw/hfi1/vnic_sdma.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/Kconfig
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/Makefile
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c

diff --git a/Documentation/infiniband/opa_vnic.rst b/Documentation/infiniband/opa_vnic.rst
deleted file mode 100644
index 2f888d9ffec0..000000000000
--- a/Documentation/infiniband/opa_vnic.rst
+++ /dev/null
@@ -1,159 +0,0 @@
-=================================================================
-Intel Omni-Path (OPA) Virtual Network Interface Controller (VNIC)
-=================================================================
-
-Intel Omni-Path (OPA) Virtual Network Interface Controller (VNIC) feature
-supports Ethernet functionality over Omni-Path fabric by encapsulating
-the Ethernet packets between HFI nodes.
-
-Architecture
-=============
-The patterns of exchanges of Omni-Path encapsulated Ethernet packets
-involves one or more virtual Ethernet switches overlaid on the Omni-Path
-fabric topology. A subset of HFI nodes on the Omni-Path fabric are
-permitted to exchange encapsulated Ethernet packets across a particular
-virtual Ethernet switch. The virtual Ethernet switches are logical
-abstractions achieved by configuring the HFI nodes on the fabric for
-header generation and processing. In the simplest configuration all HFI
-nodes across the fabric exchange encapsulated Ethernet packets over a
-single virtual Ethernet switch. A virtual Ethernet switch, is effectively
-an independent Ethernet network. The configuration is performed by an
-Ethernet Manager (EM) which is part of the trusted Fabric Manager (FM)
-application. HFI nodes can have multiple VNICs each connected to a
-different virtual Ethernet switch. The below diagram presents a case
-of two virtual Ethernet switches with two HFI nodes::
-
-                               +-------------------+
-                               |      Subnet/      |
-                               |     Ethernet      |
-                               |      Manager      |
-                               +-------------------+
-                                  /          /
-                                /           /
-                              /            /
-                            /             /
-  +-----------------------------+  +------------------------------+
-  |  Virtual Ethernet Switch    |  |  Virtual Ethernet Switch     |
-  |  +---------+    +---------+ |  | +---------+    +---------+   |
-  |  | VPORT   |    |  VPORT  | |  | |  VPORT  |    |  VPORT  |   |
-  +--+---------+----+---------+-+  +-+---------+----+---------+---+
-           |                 \        /                 |
-           |                   \    /                   |
-           |                     \/                     |
-           |                    /  \                    |
-           |                  /      \                  |
-       +-----------+------------+  +-----------+------------+
-       |   VNIC    |    VNIC    |  |    VNIC   |    VNIC    |
-       +-----------+------------+  +-----------+------------+
-       |          HFI           |  |          HFI           |
-       +------------------------+  +------------------------+
-
-
-The Omni-Path encapsulated Ethernet packet format is as described below.
-
-==================== ================================
-Bits                 Field
-==================== ================================
-Quad Word 0:
-0-19                 SLID (lower 20 bits)
-20-30                Length (in Quad Words)
-31                   BECN bit
-32-51                DLID (lower 20 bits)
-52-56                SC (Service Class)
-57-59                RC (Routing Control)
-60                   FECN bit
-61-62                L2 (=10, 16B format)
-63                   LT (=1, Link Transfer Head Flit)
-
-Quad Word 1:
-0-7                  L4 type (=0x78 ETHERNET)
-8-11                 SLID[23:20]
-12-15                DLID[23:20]
-16-31                PKEY
-32-47                Entropy
-48-63                Reserved
-
-Quad Word 2:
-0-15                 Reserved
-16-31                L4 header
-32-63                Ethernet Packet
-
-Quad Words 3 to N-1:
-0-63                 Ethernet packet (pad extended)
-
-Quad Word N (last):
-0-23                 Ethernet packet (pad extended)
-24-55                ICRC
-56-61                Tail
-62-63                LT (=01, Link Transfer Tail Flit)
-==================== ================================
-
-Ethernet packet is padded on the transmit side to ensure that the VNIC OPA
-packet is quad word aligned. The 'Tail' field contains the number of bytes
-padded. On the receive side the 'Tail' field is read and the padding is
-removed (along with ICRC, Tail and OPA header) before passing packet up
-the network stack.
-
-The L4 header field contains the virtual Ethernet switch id the VNIC port
-belongs to. On the receive side, this field is used to de-multiplex the
-received VNIC packets to different VNIC ports.
-
-Driver Design
-==============
-Intel OPA VNIC software design is presented in the below diagram.
-OPA VNIC functionality has a HW dependent component and a HW
-independent component.
-
-The support has been added for IB device to allocate and free the RDMA
-netdev devices. The RDMA netdev supports interfacing with the network
-stack thus creating standard network interfaces. OPA_VNIC is an RDMA
-netdev device type.
-
-The HW dependent VNIC functionality is part of the HFI1 driver. It
-implements the verbs to allocate and free the OPA_VNIC RDMA netdev.
-It involves HW resource allocation/management for VNIC functionality.
-It interfaces with the network stack and implements the required
-net_device_ops functions. It expects Omni-Path encapsulated Ethernet
-packets in the transmit path and provides HW access to them. It strips
-the Omni-Path header from the received packets before passing them up
-the network stack. It also implements the RDMA netdev control operations.
-
-The OPA VNIC module implements the HW independent VNIC functionality.
-It consists of two parts. The VNIC Ethernet Management Agent (VEMA)
-registers itself with IB core as an IB client and interfaces with the
-IB MAD stack. It exchanges the management information with the Ethernet
-Manager (EM) and the VNIC netdev. The VNIC netdev part allocates and frees
-the OPA_VNIC RDMA netdev devices. It overrides the net_device_ops functions
-set by HW dependent VNIC driver where required to accommodate any control
-operation. It also handles the encapsulation of Ethernet packets with an
-Omni-Path header in the transmit path. For each VNIC interface, the
-information required for encapsulation is configured by the EM via VEMA MAD
-interface. It also passes any control information to the HW dependent driver
-by invoking the RDMA netdev control operations::
-
-        +-------------------+ +----------------------+
-        |                   | |       Linux          |
-        |     IB MAD        | |      Network         |
-        |                   | |       Stack          |
-        +-------------------+ +----------------------+
-                 |               |          |
-                 |               |          |
-        +----------------------------+      |
-        |                            |      |
-        |      OPA VNIC Module       |      |
-        |  (OPA VNIC RDMA Netdev     |      |
-        |     & EMA functions)       |      |
-        |                            |      |
-        +----------------------------+      |
-                    |                       |
-                    |                       |
-           +------------------+             |
-           |     IB core      |             |
-           +------------------+             |
-                    |                       |
-                    |                       |
-        +--------------------------------------------+
-        |                                            |
-        |      HFI1 Driver with VNIC support         |
-        |                                            |
-        +--------------------------------------------+
diff --git a/Documentation/translations/zh_CN/infiniband/opa_vnic.rst b/Documentation/translations/zh_CN/infiniband/opa_vnic.rst
deleted file mode 100644
index 12b147fbf792..000000000000
--- a/Documentation/translations/zh_CN/infiniband/opa_vnic.rst
+++ /dev/null
@@ -1,156 +0,0 @@
-.. include:: ../disclaimer-zh_CN.rst
-
-:Original: Documentation/infiniband/opa_vnic.rst
-
-:翻译:
-
- 司延腾 Yanteng Si <siyanteng@loongson.cn>
-
-:校译:
-
- 王普宇 Puyu Wang <realpuyuwang@gmail.com>
- 时奎亮 Alex Shi <alexs@kernel.org>
-
-.. _cn_infiniband_opa_vnic:
-
-=============================================
-英特尔全路径（OPA）虚拟网络接口控制器（VNIC）
-=============================================
-
-英特尔全路径（OPA）虚拟网络接口控制器（VNIC）功能通过封装HFI节点之间的以
-太网数据包，支持Omni-Path结构上的以太网功能。
-
-体系结构
-========
-
-Omni-Path封装的以太网数据包的交换模式涉及Omni-Path结构拓扑上覆盖的一个或
-多个虚拟以太网交换机。Omni-Path结构上的HFI节点的一个子集被允许在特定的虚
-拟以太网交换机上交换封装的以太网数据包。虚拟以太网交换机是通过配置结构上的
-HFI节点实现的逻辑抽象，用于生成和处理报头。在最简单的配置中，整个结构的所有
-HFI节点通过一个虚拟以太网交换机交换封装的以太网数据包。一个虚拟以太网交换机，
-实际上是一个独立的以太网网络。该配置由以太网管理器（EM）执行，它是可信的结
-构管理器（FM）应用程序的一部分。HFI节点可以有多个VNIC，每个连接到不同的虚
-拟以太网交换机。下图介绍了两个虚拟以太网交换机与两个HFI节点的情况::
-
-                               +-------------------+
-                               |      子网/        |
-                               |     以太网        |
-                               |      管理         |
-                               +-------------------+
-                                  /          /
-                                /           /
-                              /            /
-                            /             /
-  +-----------------------------+  +------------------------------+
-  |     虚拟以太网切换          |  |      虚拟以太网切换          |
-  |  +---------+    +---------+ |  | +---------+    +---------+   |
-  |  | VPORT   |    |  VPORT  | |  | |  VPORT  |    |  VPORT  |   |
-  +--+---------+----+---------+-+  +-+---------+----+---------+---+
-           |                 \        /                 |
-           |                   \    /                   |
-           |                     \/                     |
-           |                    /  \                    |
-           |                  /      \                  |
-       +-----------+------------+  +-----------+------------+
-       |   VNIC    |    VNIC    |  |    VNIC   |    VNIC    |
-       +-----------+------------+  +-----------+------------+
-       |          HFI           |  |          HFI           |
-       +------------------------+  +------------------------+
-
-
-Omni-Path封装的以太网数据包格式如下所述。
-
-==================== ================================
-位                   域
-==================== ================================
-Quad Word 0:
-0-19                 SLID (低20位)
-20-30                长度 (以四字为单位)
-31                   BECN 位
-32-51                DLID (低20位)
-52-56                SC (服务级别)
-57-59                RC (路由控制)
-60                   FECN 位
-61-62                L2 (=10, 16B 格式)
-63                   LT (=1, 链路传输头 Flit)
-
-Quad Word 1:
-0-7                  L4 type (=0x78 ETHERNET)
-8-11                 SLID[23:20]
-12-15                DLID[23:20]
-16-31                PKEY
-32-47                熵
-48-63                保留
-
-Quad Word 2:
-0-15                 保留
-16-31                L4 头
-32-63                以太网数据包
-
-Quad Words 3 to N-1:
-0-63                 以太网数据包 (pad拓展)
-
-Quad Word N (last):
-0-23                 以太网数据包 (pad拓展)
-24-55                ICRC
-56-61                尾
-62-63                LT (=01, 链路传输尾 Flit)
-==================== ================================
-
-以太网数据包在传输端被填充，以确保VNIC OPA数据包是四字对齐的。“尾”字段
-包含填充的字节数。在接收端，“尾”字段被读取，在将数据包向上传递到网络堆
-栈之前，填充物被移除（与ICRC、尾和OPA头一起）。
-
-L4头字段包含VNIC端口所属的虚拟以太网交换机ID。在接收端，该字段用于将收
-到的VNIC数据包去多路复用到不同的VNIC端口。
-
-驱动设计
-========
-
-英特尔OPA VNIC的软件设计如下图所示。OPA VNIC功能有一个依赖于硬件的部分
-和一个独立于硬件的部分。
-
-对IB设备分配和释放RDMA netdev设备的支持已经被加入。RDMA netdev支持与
-网络堆栈的对接，从而创建标准的网络接口。OPA_VNIC是一个RDMA netdev设备
-类型。
-
-依赖于HW的VNIC功能是HFI1驱动的一部分。它实现了分配和释放OPA_VNIC RDMA
-netdev的动作。它涉及VNIC功能的HW资源分配/管理。它与网络堆栈接口并实现所
-需的net_device_ops功能。它在传输路径中期待Omni-Path封装的以太网数据包，
-并提供对它们的HW访问。在将数据包向上传递到网络堆栈之前，它把Omni-Path头
-从接收的数据包中剥离。它还实现了RDMA netdev控制操作。
-
-OPA VNIC模块实现了独立于硬件的VNIC功能。它由两部分组成。VNIC以太网管理
-代理（VEMA）作为一个IB客户端向IB核心注册，并与IB MAD栈接口。它与以太网
-管理器（EM）和VNIC netdev交换管理信息。VNIC netdev部分分配和释放OPA_VNIC
-RDMA netdev设备。它在需要时覆盖由依赖HW的VNIC驱动设置的net_device_ops函数，
-以适应任何控制操作。它还处理以太网数据包的封装，在传输路径中使用Omni-Path头。
-对于每个VNIC接口，封装所需的信息是由EM通过VEMA MAD接口配置的。它还通过调用
-RDMA netdev控制操作将任何控制信息传递给依赖于HW的驱动程序::
-
-        +-------------------+ +----------------------+
-        |                   | |       Linux          |
-        |     IB MAD        | |       网络           |
-        |                   | |       栈             |
-        +-------------------+ +----------------------+
-                 |               |          |
-                 |               |          |
-        +----------------------------+      |
-        |                            |      |
-        |      OPA VNIC 模块         |      |
-        |  (OPA VNIC RDMA Netdev     |      |
-        |     & EMA 函数)            |      |
-        |                            |      |
-        +----------------------------+      |
-                    |                       |
-                    |                       |
-           +------------------+             |
-           |     IB 核心      |             |
-           +------------------+             |
-                    |                       |
-                    |                       |
-        +--------------------------------------------+
-        |                                            |
-        |      HFI1 驱动和 VNIC 支持                 |
-        |                                            |
-        +--------------------------------------------+
diff --git a/MAINTAINERS b/MAINTAINERS
index dd844ac8d910..c95f54b45fc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,12 +18263,6 @@ L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-optee.c
 
-OPA-VNIC DRIVER
-M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
-L:	linux-rdma@vger.kernel.org
-S:	Supported
-F:	drivers/infiniband/ulp/opa_vnic
-
 OPEN ALLIANCE 10BASE-T1S MACPHY SERIAL INTERFACE FRAMEWORK
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a5827d11e934..abf8fd114a2c 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -110,6 +110,4 @@ source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
 source "drivers/infiniband/ulp/rtrs/Kconfig"
 
-source "drivers/infiniband/ulp/opa_vnic/Kconfig"
-
 endif # INFINIBAND
diff --git a/drivers/infiniband/hw/hfi1/Makefile b/drivers/infiniband/hw/hfi1/Makefile
index 5d977f363684..b5551bd4703b 100644
--- a/drivers/infiniband/hw/hfi1/Makefile
+++ b/drivers/infiniband/hw/hfi1/Makefile
@@ -49,9 +49,7 @@ hfi1-y := \
 	user_pages.o \
 	user_sdma.o \
 	verbs.o \
-	verbs_txreq.o \
-	vnic_main.o \
-	vnic_sdma.o
+	verbs_txreq.o
 
 ifdef CONFIG_DEBUG_FS
 hfi1-y += debugfs.o
diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
index 9b508eaf441d..4b64a338d0d6 100644
--- a/drivers/infiniband/hw/hfi1/aspm.c
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -179,7 +179,7 @@ static  void aspm_ctx_timer_function(struct timer_list *t)
 }
 
 /*
- * Disable interrupt processing for verbs contexts when PSM or VNIC contexts
+ * Disable interrupt processing for verbs contexts when PSM contexts
  * are open.
  */
 void aspm_disable_all(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index e908f529335d..b63650ba8946 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -85,12 +85,12 @@ struct flag_table {
 /*
  * RSM instance allocation
  *   0 - User Fecn Handling
- *   1 - Vnic
+ *   1 - Deprecated
  *   2 - AIP
  *   3 - Verbs
  */
 #define RSM_INS_FECN              0
-#define RSM_INS_VNIC              1
+#define RSM_INS_DEPRECATED        1
 #define RSM_INS_AIP               2
 #define RSM_INS_VERBS             3
 
@@ -152,15 +152,6 @@ struct flag_table {
 #define DETH_AIP_SQPN_SELECT_OFFSET \
 	DETH_AIP_SQPN_OFFSET(DETH_AIP_SQPN_BIT_OFFSET)
 
-/* RSM fields for Vnic */
-/* L2_TYPE: QW 0, OFFSET 61 - for match */
-#define L2_TYPE_QW             0ull
-#define L2_TYPE_BIT_OFFSET     61ull
-#define L2_TYPE_OFFSET(off)    ((L2_TYPE_QW << QW_SHIFT) | (off))
-#define L2_TYPE_MATCH_OFFSET   L2_TYPE_OFFSET(L2_TYPE_BIT_OFFSET)
-#define L2_TYPE_MASK           3ull
-#define L2_16B_VALUE           2ull
-
 /* L4_TYPE QW 1, OFFSET 0 - for match */
 #define L4_TYPE_QW              1ull
 #define L4_TYPE_BIT_OFFSET      0ull
@@ -6844,9 +6835,9 @@ static void rxe_kernel_unfreeze(struct hfi1_devdata *dd)
 	for (i = 0; i < dd->num_rcv_contexts; i++) {
 		rcd = hfi1_rcd_get_by_index(dd, i);
 
-		/* Ensure all non-user contexts(including vnic) are enabled */
+		/* Ensure all non-user contexts are enabled */
 		if (!rcd ||
-		    (i >= dd->first_dyn_alloc_ctxt && !rcd->is_vnic)) {
+		    (i >= dd->first_dyn_alloc_ctxt )) {
 			hfi1_rcd_put(rcd);
 			continue;
 		}
@@ -8467,7 +8458,7 @@ int hfi1_netdev_rx_napi(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-/* Receive packet napi handler for netdevs VNIC and AIP  */
+/* Receive packet napi handler for netdevs AIP  */
 irqreturn_t receive_context_interrupt_napi(int irq, void *data)
 {
 	struct hfi1_ctxtdata *rcd = data;
@@ -14506,7 +14497,7 @@ static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
 	int ctxt_count = hfi1_netdev_ctxt_count(dd);
 
 	/* We already have contexts mapped in RMT */
-	if (has_rsm_rule(dd, RSM_INS_VNIC) || has_rsm_rule(dd, RSM_INS_AIP)) {
+	if (has_rsm_rule(dd, RSM_INS_AIP)) {
 		dd_dev_info(dd, "Contexts are already mapped in RMT\n");
 		return true;
 	}
@@ -14587,37 +14578,6 @@ void hfi1_init_aip_rsm(struct hfi1_devdata *dd)
 	}
 }
 
-/* Initialize RSM for VNIC */
-void hfi1_init_vnic_rsm(struct hfi1_devdata *dd)
-{
-	int rmt_start = hfi1_netdev_get_free_rmt_idx(dd);
-	struct rsm_rule_data rrd = {
-		/* Add rule for vnic */
-		.offset = rmt_start,
-		.pkt_type = 4,
-		/* Match 16B packets */
-		.field1_off = L2_TYPE_MATCH_OFFSET,
-		.mask1 = L2_TYPE_MASK,
-		.value1 = L2_16B_VALUE,
-		/* Match ETH L4 packets */
-		.field2_off = L4_TYPE_MATCH_OFFSET,
-		.mask2 = L4_16B_TYPE_MASK,
-		.value2 = L4_16B_ETH_VALUE,
-		/* Calc context from veswid and entropy */
-		.index1_off = L4_16B_HDR_VESWID_OFFSET,
-		.index1_width = ilog2(NUM_NETDEV_MAP_ENTRIES),
-		.index2_off = L2_16B_ENTROPY_OFFSET,
-		.index2_width = ilog2(NUM_NETDEV_MAP_ENTRIES)
-	};
-
-	hfi1_enable_rsm_rule(dd, RSM_INS_VNIC, &rrd);
-}
-
-void hfi1_deinit_vnic_rsm(struct hfi1_devdata *dd)
-{
-	clear_rsm_rule(dd, RSM_INS_VNIC);
-}
-
 void hfi1_deinit_aip_rsm(struct hfi1_devdata *dd)
 {
 	/* only actually clear the rule if it's the last user asking to do so */
@@ -15195,7 +15155,7 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 		 (dd->revision >> CCE_REVISION_SW_SHIFT)
 		    & CCE_REVISION_SW_MASK);
 
-	/* alloc VNIC/AIP rx data */
+	/* alloc AIP rx data */
 	ret = hfi1_alloc_rx(dd);
 	if (ret)
 		goto bail_cleanup;
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 6992f6d40255..56e03d486ace 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1392,8 +1392,6 @@ int hfi1_set_ctxt_pkey(struct hfi1_devdata *dd, struct hfi1_ctxtdata *ctxt,
 		       u16 pkey);
 int hfi1_clear_ctxt_pkey(struct hfi1_devdata *dd, struct hfi1_ctxtdata *ctxt);
 void hfi1_read_link_quality(struct hfi1_devdata *dd, u8 *link_quality);
-void hfi1_init_vnic_rsm(struct hfi1_devdata *dd);
-void hfi1_deinit_vnic_rsm(struct hfi1_devdata *dd);
 
 irqreturn_t general_interrupt(int irq, void *data);
 irqreturn_t sdma_interrupt(int irq, void *data);
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 3da90f2eb8e7..01943571a153 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -20,7 +20,6 @@
 #include "qp.h"
 #include "sdma.h"
 #include "debugfs.h"
-#include "vnic.h"
 #include "fault.h"
 
 #include "ipoib.h"
@@ -909,11 +908,11 @@ static void set_all_fastpath(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 	u16 i;
 
 	/*
-	 * For dynamically allocated kernel contexts (like vnic) switch
+	 * For dynamically allocated kernel contexts switch
 	 * interrupt handler only for that context. Otherwise, switch
 	 * interrupt handler for all statically allocated kernel contexts.
 	 */
-	if (rcd->ctxt >= dd->first_dyn_alloc_ctxt && !rcd->is_vnic) {
+	if (rcd->ctxt >= dd->first_dyn_alloc_ctxt) {
 		hfi1_rcd_get(rcd);
 		hfi1_set_fast(rcd);
 		hfi1_rcd_put(rcd);
@@ -922,7 +921,7 @@ static void set_all_fastpath(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 
 	for (i = HFI1_CTRL_CTXT + 1; i < dd->num_rcv_contexts; i++) {
 		rcd = hfi1_rcd_get_by_index(dd, i);
-		if (rcd && (i < dd->first_dyn_alloc_ctxt || rcd->is_vnic))
+		if (rcd && (i < dd->first_dyn_alloc_ctxt))
 			hfi1_set_fast(rcd);
 		hfi1_rcd_put(rcd);
 	}
@@ -938,7 +937,7 @@ void set_all_slowpath(struct hfi1_devdata *dd)
 		rcd = hfi1_rcd_get_by_index(dd, i);
 		if (!rcd)
 			continue;
-		if (i < dd->first_dyn_alloc_ctxt || rcd->is_vnic)
+		if (i < dd->first_dyn_alloc_ctxt)
 			rcd->do_interrupt = rcd->slow_handler;
 
 		hfi1_rcd_put(rcd);
@@ -1399,7 +1398,7 @@ int hfi1_reset_device(int unit)
 		goto bail;
 	}
 
-	/* If there are any user/vnic contexts, we cannot reset */
+	/* If there are any user contexts, we cannot reset */
 	mutex_lock(&hfi1_mutex);
 	if (dd->rcd)
 		if (hfi1_stats.sps_ctxts) {
@@ -1898,7 +1897,7 @@ const rhf_rcv_function_ptr netdev_rhf_rcv_functions[] = {
 	[RHF_RCV_TYPE_EAGER] = process_receive_invalid,
 	[RHF_RCV_TYPE_IB] = hfi1_ipoib_ib_rcv,
 	[RHF_RCV_TYPE_ERROR] = process_receive_error,
-	[RHF_RCV_TYPE_BYPASS] = hfi1_vnic_bypass_rcv,
+	[RHF_RCV_TYPE_BYPASS] = process_receive_invalid,
 	[RHF_RCV_TYPE_INVALID5] = process_receive_invalid,
 	[RHF_RCV_TYPE_INVALID6] = process_receive_invalid,
 	[RHF_RCV_TYPE_INVALID7] = process_receive_invalid,
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index cb630551cf1a..5a0310f758dc 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -212,10 +212,6 @@ struct hfi1_ctxtdata {
 	u8 rhf_offset;
 	/* dynamic receive available interrupt timeout */
 	u8 rcvavail_timeout;
-	/* Indicates that this is vnic context */
-	bool is_vnic;
-	/* vnic queue index this context is mapped to */
-	u8 vnic_q_idx;
 	/* Is ASPM interrupt supported for this context */
 	bool aspm_intr_supported;
 	/* ASPM state (enabled/disabled) for this context */
@@ -402,7 +398,6 @@ struct hfi1_packet {
 #define OPA_16B_L4_FM		0x08
 #define OPA_16B_L4_IB_LOCAL	0x09
 #define OPA_16B_L4_IB_GLOBAL	0x0A
-#define OPA_16B_L4_ETHR		OPA_VNIC_L4_ETHR
 
 /*
  * OPA 16B Management
@@ -997,14 +992,6 @@ struct hfi1_asic_data {
 #define NUM_MAP_ENTRIES	 256
 #define NUM_MAP_REGS      32
 
-/* Virtual NIC information */
-struct hfi1_vnic_data {
-	struct kmem_cache *txreq_cache;
-	u8 num_vports;
-};
-
-struct hfi1_vnic_vport_info;
-
 /* device data struct now contains only "general per-device" info.
  * fields related to a physical IB port are in a hfi1_pportdata struct.
  */
@@ -1298,9 +1285,6 @@ struct hfi1_devdata {
 	send_routine process_dma_send;
 	void (*pio_inline_send)(struct hfi1_devdata *dd, struct pio_buf *pbuf,
 				u64 pbc, const void *from, size_t count);
-	int (*process_vnic_dma_send)(struct hfi1_devdata *dd, u8 q_idx,
-				     struct hfi1_vnic_vport_info *vinfo,
-				     struct sk_buff *skb, u64 pbc, u8 plen);
 	/* hfi1_pportdata, points to array of (physical) port-specific
 	 * data structs, indexed by pidx (0..n-1)
 	 */
@@ -1314,7 +1298,6 @@ struct hfi1_devdata {
 	u16 flags;
 	/* Number of physical ports available */
 	u8 num_pports;
-	/* Lowest context number which can be used by user processes or VNIC */
 	u8 first_dyn_alloc_ctxt;
 	/* adding a new field here would make it part of this cacheline */
 
@@ -1353,11 +1336,8 @@ struct hfi1_devdata {
 	bool aspm_enabled;	/* ASPM state: enabled/disabled */
 	struct rhashtable *sdma_rht;
 
-	/* vnic data */
-	struct hfi1_vnic_data vnic;
 	/* Lock to protect IRQ SRC register access */
 	spinlock_t irq_src_lock;
-	int vnic_num_vports;
 	struct hfi1_netdev_rx *netdev_rx;
 	struct hfi1_affinity_node *affinity_entry;
 
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index b35f92e7d865..1eae00fdd439 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -26,7 +26,6 @@
 #include "verbs.h"
 #include "aspm.h"
 #include "affinity.h"
-#include "vnic.h"
 #include "exp_rcv.h"
 #include "netdev.h"
 
@@ -349,7 +348,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
 		 * We do this here because we have to take into account all
 		 * the RcvArray entries that previous context would have
 		 * taken and we have to account for any extra groups assigned
-		 * to the static (kernel) or dynamic (vnic/user) contexts.
+		 * to the static (kernel) or dynamic (user) contexts.
 		 */
 		if (ctxt < dd->first_dyn_alloc_ctxt) {
 			if (ctxt < kctxt_ngroups) {
@@ -851,7 +850,6 @@ int hfi1_init(struct hfi1_devdata *dd, int reinit)
 	dd->process_pio_send = hfi1_verbs_send_pio;
 	dd->process_dma_send = hfi1_verbs_send_dma;
 	dd->pio_inline_send = pio_copy;
-	dd->process_vnic_dma_send = hfi1_vnic_send_dma;
 
 	if (is_ax(dd)) {
 		atomic_set(&dd->drop_packet, DROP_PACKET_ON);
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index b39f63ce6dfc..de2dfd59cede 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -12,7 +12,6 @@
 #include "mad.h"
 #include "trace.h"
 #include "qp.h"
-#include "vnic.h"
 
 /* the reset value from the FM is supposed to be 0xffff, handle both */
 #define OPA_LINK_WIDTH_RESET_OLD 0x0fff
diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index 77d2ece9a9cb..cc57c7e39337 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -24,7 +24,6 @@ int msix_initialize(struct hfi1_devdata *dd)
 	 *	one for the general, "slow path" interrupt
 	 *	one per used SDMA engine
 	 *	one per kernel receive context
-	 *	one for each VNIC context
 	 *      ...any new IRQs should be added here.
 	 */
 	total = 1 + dd->num_sdma + dd->n_krcv_queues + dd->num_netdev_contexts;
@@ -128,8 +127,7 @@ static int msix_request_rcd_irq_common(struct hfi1_ctxtdata *rcd,
 				       irq_handler_t thread,
 				       const char *name)
 {
-	int nr = msix_request_irq(rcd->dd, rcd, handler, thread,
-				  rcd->is_vnic ? IRQ_NETDEVCTXT : IRQ_RCVCTXT,
+	int nr = msix_request_irq(rcd->dd, rcd, handler, thread, IRQ_RCVCTXT,
 				  name);
 	if (nr < 0)
 		return nr;
diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index 07c8f77c9181..c6440bd07d2e 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -14,7 +14,7 @@
 
 /**
  * struct hfi1_netdev_rxq - Receive Queue for HFI
- * Both IPoIB and VNIC netdevices will be working on the rx abstraction.
+ * IPoIB netdevices will be working on the rx abstraction.
  * @napi: napi object
  * @rx: ptr to netdev_rx
  * @rcd:  ptr to receive context data
@@ -25,10 +25,6 @@ struct hfi1_netdev_rxq {
 	struct hfi1_ctxtdata *rcd;
 };
 
-/*
- * Number of netdev contexts used. Ensure it is less than or equal to
- * max queues supported by VNIC (HFI1_VNIC_MAX_QUEUE).
- */
 #define HFI1_MAX_NETDEV_CTXTS   8
 
 /* Number of NETDEV RSM entries */
@@ -42,7 +38,7 @@ struct hfi1_netdev_rxq {
  * @num_rx_q:	number of receive queues
  * @rmt_index:	first free index in RMT Array
  * @msix_start: first free MSI-X interrupt vector.
- * @dev_tbl:	netdev table for unique identifier VNIC and IPoIb VLANs.
+ * @dev_tbl:	netdev table for unique identifier IPoIb VLANs.
  * @enabled:	atomic counter of netdevs enabling receive queues.
  *		When 0 NAPI will be disabled.
  * @netdevs:	atomic counter of netdevs using dummy netdev.
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 8608044203bb..ca2ae52b21e3 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -78,7 +78,6 @@ static int hfi1_netdev_allocate_ctxt(struct hfi1_devdata *dd,
 	uctxt->fast_handler = handle_receive_interrupt_napi_fp;
 	uctxt->slow_handler = handle_receive_interrupt_napi_sp;
 	hfi1_set_seq_cnt(uctxt, 1);
-	uctxt->is_vnic = true;
 
 	hfi1_stats.sps_ctxts++;
 
@@ -427,7 +426,7 @@ void hfi1_netdev_disable_queues(struct hfi1_devdata *dd)
 
 /**
  * hfi1_netdev_add_data - Registers data with unique identifier
- * to be requested later this is needed for VNIC and IPoIB VLANs
+ * to be requested later this is needed for IPoIB VLANs
  * implementations.
  * This call is protected by mutex idr_lock.
  *
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 49e0f79b950c..9f318928ac65 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -21,7 +21,6 @@
 #include "qp.h"
 #include "verbs_txreq.h"
 #include "debugfs.h"
-#include "vnic.h"
 #include "fault.h"
 #include "affinity.h"
 #include "ipoib.h"
@@ -1729,7 +1728,6 @@ static const struct ib_device_ops hfi1_dev_ops = {
 
 	.alloc_hw_device_stats = hfi1_alloc_hw_device_stats,
 	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
-	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
 	.device_group = &ib_hfi1_attr_group,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
 	.get_hw_stats = get_hw_stats,
diff --git a/drivers/infiniband/hw/hfi1/vnic.h b/drivers/infiniband/hw/hfi1/vnic.h
deleted file mode 100644
index bbafeb5fc0ec..000000000000
--- a/drivers/infiniband/hw/hfi1/vnic.h
+++ /dev/null
@@ -1,126 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/*
- * Copyright(c) 2017 - 2020 Intel Corporation.
- */
-
-#ifndef _HFI1_VNIC_H
-#define _HFI1_VNIC_H
-#include <rdma/opa_vnic.h>
-#include "hfi.h"
-#include "sdma.h"
-
-#define HFI1_VNIC_MAX_TXQ     16
-#define HFI1_VNIC_MAX_PAD     12
-
-/* L4 header definitions */
-#define HFI1_VNIC_L4_HDR_OFFSET  OPA_VNIC_L2_HDR_LEN
-
-#define HFI1_VNIC_GET_L4_HDR(data)   \
-	(*((u16 *)((u8 *)(data) + HFI1_VNIC_L4_HDR_OFFSET)))
-
-#define HFI1_VNIC_GET_VESWID(data)   \
-	(HFI1_VNIC_GET_L4_HDR(data) & 0xFFF)
-
-/* Service class */
-#define HFI1_VNIC_SC_OFFSET_LOW 6
-#define HFI1_VNIC_SC_OFFSET_HI  7
-#define HFI1_VNIC_SC_SHIFT      4
-
-#define HFI1_VNIC_MAX_QUEUE 16
-#define HFI1_NUM_VNIC_CTXT 8
-
-/**
- * struct hfi1_vnic_sdma - VNIC per Tx ring SDMA information
- * @dd - device data pointer
- * @sde - sdma engine
- * @vinfo - vnic info pointer
- * @wait - iowait structure
- * @stx - sdma tx request
- * @state - vnic Tx ring SDMA state
- * @q_idx - vnic Tx queue index
- */
-struct hfi1_vnic_sdma {
-	struct hfi1_devdata *dd;
-	struct sdma_engine  *sde;
-	struct hfi1_vnic_vport_info *vinfo;
-	struct iowait wait;
-	struct sdma_txreq stx;
-	unsigned int state;
-	u8 q_idx;
-	bool pkts_sent;
-};
-
-/**
- * struct hfi1_vnic_rx_queue - HFI1 VNIC receive queue
- * @idx: queue index
- * @vinfo: pointer to vport information
- * @netdev: network device
- * @napi: netdev napi structure
- * @skbq: queue of received socket buffers
- */
-struct hfi1_vnic_rx_queue {
-	u8                           idx;
-	struct hfi1_vnic_vport_info *vinfo;
-	struct net_device           *netdev;
-	struct napi_struct           napi;
-};
-
-/**
- * struct hfi1_vnic_vport_info - HFI1 VNIC virtual port information
- * @dd: device data pointer
- * @netdev: net device pointer
- * @flags: state flags
- * @lock: vport lock
- * @num_tx_q: number of transmit queues
- * @num_rx_q: number of receive queues
- * @vesw_id: virtual switch id
- * @rxq: Array of receive queues
- * @stats: per queue stats
- * @sdma: VNIC SDMA structure per TXQ
- */
-struct hfi1_vnic_vport_info {
-	struct hfi1_devdata *dd;
-	struct net_device   *netdev;
-	unsigned long        flags;
-
-	/* Lock used around state updates */
-	struct mutex         lock;
-
-	u8  num_tx_q;
-	u8  num_rx_q;
-	u16 vesw_id;
-	struct hfi1_vnic_rx_queue rxq[HFI1_NUM_VNIC_CTXT];
-
-	struct opa_vnic_stats  stats[HFI1_VNIC_MAX_QUEUE];
-	struct hfi1_vnic_sdma  sdma[HFI1_VNIC_MAX_TXQ];
-};
-
-#define v_dbg(format, arg...) \
-	netdev_dbg(vinfo->netdev, format, ## arg)
-#define v_err(format, arg...) \
-	netdev_err(vinfo->netdev, format, ## arg)
-#define v_info(format, arg...) \
-	netdev_info(vinfo->netdev, format, ## arg)
-
-/* vnic hfi1 internal functions */
-void hfi1_vnic_setup(struct hfi1_devdata *dd);
-int hfi1_vnic_txreq_init(struct hfi1_devdata *dd);
-void hfi1_vnic_txreq_deinit(struct hfi1_devdata *dd);
-
-void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet);
-void hfi1_vnic_sdma_init(struct hfi1_vnic_vport_info *vinfo);
-bool hfi1_vnic_sdma_write_avail(struct hfi1_vnic_vport_info *vinfo,
-				u8 q_idx);
-
-/* vnic rdma netdev operations */
-struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
-				      u32 port_num,
-				      enum rdma_netdev_t type,
-				      const char *name,
-				      unsigned char name_assign_type,
-				      void (*setup)(struct net_device *));
-int hfi1_vnic_send_dma(struct hfi1_devdata *dd, u8 q_idx,
-		       struct hfi1_vnic_vport_info *vinfo,
-		       struct sk_buff *skb, u64 pbc, u8 plen);
-
-#endif /* _HFI1_VNIC_H */
diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
deleted file mode 100644
index 16a4c297a897..000000000000
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ /dev/null
@@ -1,615 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/*
- * Copyright(c) 2017 - 2020 Intel Corporation.
- */
-
-/*
- * This file contains HFI1 support for VNIC functionality
- */
-
-#include <linux/io.h>
-#include <linux/if_vlan.h>
-
-#include "vnic.h"
-#include "netdev.h"
-
-#define HFI_TX_TIMEOUT_MS 1000
-
-#define HFI1_VNIC_RCV_Q_SIZE   1024
-
-#define HFI1_VNIC_UP 0
-
-static DEFINE_SPINLOCK(vport_cntr_lock);
-
-#define SUM_GRP_COUNTERS(stats, qstats, x_grp) do {            \
-		u64 *src64, *dst64;                            \
-		for (src64 = &qstats->x_grp.unicast,           \
-			dst64 = &stats->x_grp.unicast;         \
-			dst64 <= &stats->x_grp.s_1519_max;) {  \
-			*dst64++ += *src64++;                  \
-		}                                              \
-	} while (0)
-
-#define VNIC_MASK (0xFF)
-#define VNIC_ID(val) ((1ull << 24) | ((val) & VNIC_MASK))
-
-/* hfi1_vnic_update_stats - update statistics */
-static void hfi1_vnic_update_stats(struct hfi1_vnic_vport_info *vinfo,
-				   struct opa_vnic_stats *stats)
-{
-	struct net_device *netdev = vinfo->netdev;
-	u8 i;
-
-	/* add tx counters on different queues */
-	for (i = 0; i < vinfo->num_tx_q; i++) {
-		struct opa_vnic_stats *qstats = &vinfo->stats[i];
-		struct rtnl_link_stats64 *qnstats = &vinfo->stats[i].netstats;
-
-		stats->netstats.tx_fifo_errors += qnstats->tx_fifo_errors;
-		stats->netstats.tx_carrier_errors += qnstats->tx_carrier_errors;
-		stats->tx_drop_state += qstats->tx_drop_state;
-		stats->tx_dlid_zero += qstats->tx_dlid_zero;
-
-		SUM_GRP_COUNTERS(stats, qstats, tx_grp);
-		stats->netstats.tx_packets += qnstats->tx_packets;
-		stats->netstats.tx_bytes += qnstats->tx_bytes;
-	}
-
-	/* add rx counters on different queues */
-	for (i = 0; i < vinfo->num_rx_q; i++) {
-		struct opa_vnic_stats *qstats = &vinfo->stats[i];
-		struct rtnl_link_stats64 *qnstats = &vinfo->stats[i].netstats;
-
-		stats->netstats.rx_fifo_errors += qnstats->rx_fifo_errors;
-		stats->netstats.rx_nohandler += qnstats->rx_nohandler;
-		stats->rx_drop_state += qstats->rx_drop_state;
-		stats->rx_oversize += qstats->rx_oversize;
-		stats->rx_runt += qstats->rx_runt;
-
-		SUM_GRP_COUNTERS(stats, qstats, rx_grp);
-		stats->netstats.rx_packets += qnstats->rx_packets;
-		stats->netstats.rx_bytes += qnstats->rx_bytes;
-	}
-
-	stats->netstats.tx_errors = stats->netstats.tx_fifo_errors +
-				    stats->netstats.tx_carrier_errors +
-				    stats->tx_drop_state + stats->tx_dlid_zero;
-	stats->netstats.tx_dropped = stats->netstats.tx_errors;
-
-	stats->netstats.rx_errors = stats->netstats.rx_fifo_errors +
-				    stats->netstats.rx_nohandler +
-				    stats->rx_drop_state + stats->rx_oversize +
-				    stats->rx_runt;
-	stats->netstats.rx_dropped = stats->netstats.rx_errors;
-
-	netdev->stats.tx_packets = stats->netstats.tx_packets;
-	netdev->stats.tx_bytes = stats->netstats.tx_bytes;
-	netdev->stats.tx_fifo_errors = stats->netstats.tx_fifo_errors;
-	netdev->stats.tx_carrier_errors = stats->netstats.tx_carrier_errors;
-	netdev->stats.tx_errors = stats->netstats.tx_errors;
-	netdev->stats.tx_dropped = stats->netstats.tx_dropped;
-
-	netdev->stats.rx_packets = stats->netstats.rx_packets;
-	netdev->stats.rx_bytes = stats->netstats.rx_bytes;
-	netdev->stats.rx_fifo_errors = stats->netstats.rx_fifo_errors;
-	netdev->stats.multicast = stats->rx_grp.mcastbcast;
-	netdev->stats.rx_length_errors = stats->rx_oversize + stats->rx_runt;
-	netdev->stats.rx_errors = stats->netstats.rx_errors;
-	netdev->stats.rx_dropped = stats->netstats.rx_dropped;
-}
-
-/* update_len_counters - update pkt's len histogram counters */
-static inline void update_len_counters(struct opa_vnic_grp_stats *grp,
-				       int len)
-{
-	/* account for 4 byte FCS */
-	if (len >= 1515)
-		grp->s_1519_max++;
-	else if (len >= 1020)
-		grp->s_1024_1518++;
-	else if (len >= 508)
-		grp->s_512_1023++;
-	else if (len >= 252)
-		grp->s_256_511++;
-	else if (len >= 124)
-		grp->s_128_255++;
-	else if (len >= 61)
-		grp->s_65_127++;
-	else
-		grp->s_64++;
-}
-
-/* hfi1_vnic_update_tx_counters - update transmit counters */
-static void hfi1_vnic_update_tx_counters(struct hfi1_vnic_vport_info *vinfo,
-					 u8 q_idx, struct sk_buff *skb, int err)
-{
-	struct ethhdr *mac_hdr = (struct ethhdr *)skb_mac_header(skb);
-	struct opa_vnic_stats *stats = &vinfo->stats[q_idx];
-	struct opa_vnic_grp_stats *tx_grp = &stats->tx_grp;
-	u16 vlan_tci;
-
-	stats->netstats.tx_packets++;
-	stats->netstats.tx_bytes += skb->len + ETH_FCS_LEN;
-
-	update_len_counters(tx_grp, skb->len);
-
-	/* rest of the counts are for good packets only */
-	if (unlikely(err))
-		return;
-
-	if (is_multicast_ether_addr(mac_hdr->h_dest))
-		tx_grp->mcastbcast++;
-	else
-		tx_grp->unicast++;
-
-	if (!__vlan_get_tag(skb, &vlan_tci))
-		tx_grp->vlan++;
-	else
-		tx_grp->untagged++;
-}
-
-/* hfi1_vnic_update_rx_counters - update receive counters */
-static void hfi1_vnic_update_rx_counters(struct hfi1_vnic_vport_info *vinfo,
-					 u8 q_idx, struct sk_buff *skb, int err)
-{
-	struct ethhdr *mac_hdr = (struct ethhdr *)skb->data;
-	struct opa_vnic_stats *stats = &vinfo->stats[q_idx];
-	struct opa_vnic_grp_stats *rx_grp = &stats->rx_grp;
-	u16 vlan_tci;
-
-	stats->netstats.rx_packets++;
-	stats->netstats.rx_bytes += skb->len + ETH_FCS_LEN;
-
-	update_len_counters(rx_grp, skb->len);
-
-	/* rest of the counts are for good packets only */
-	if (unlikely(err))
-		return;
-
-	if (is_multicast_ether_addr(mac_hdr->h_dest))
-		rx_grp->mcastbcast++;
-	else
-		rx_grp->unicast++;
-
-	if (!__vlan_get_tag(skb, &vlan_tci))
-		rx_grp->vlan++;
-	else
-		rx_grp->untagged++;
-}
-
-/* This function is overloaded for opa_vnic specific implementation */
-static void hfi1_vnic_get_stats64(struct net_device *netdev,
-				  struct rtnl_link_stats64 *stats)
-{
-	struct opa_vnic_stats *vstats = (struct opa_vnic_stats *)stats;
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-
-	hfi1_vnic_update_stats(vinfo, vstats);
-}
-
-static u64 create_bypass_pbc(u32 vl, u32 dw_len)
-{
-	u64 pbc;
-
-	pbc = ((u64)PBC_IHCRC_NONE << PBC_INSERT_HCRC_SHIFT)
-		| PBC_INSERT_BYPASS_ICRC | PBC_CREDIT_RETURN
-		| PBC_PACKET_BYPASS
-		| ((vl & PBC_VL_MASK) << PBC_VL_SHIFT)
-		| (dw_len & PBC_LENGTH_DWS_MASK) << PBC_LENGTH_DWS_SHIFT;
-
-	return pbc;
-}
-
-/* hfi1_vnic_maybe_stop_tx - stop tx queue if required */
-static void hfi1_vnic_maybe_stop_tx(struct hfi1_vnic_vport_info *vinfo,
-				    u8 q_idx)
-{
-	netif_stop_subqueue(vinfo->netdev, q_idx);
-	if (!hfi1_vnic_sdma_write_avail(vinfo, q_idx))
-		return;
-
-	netif_start_subqueue(vinfo->netdev, q_idx);
-}
-
-static netdev_tx_t hfi1_netdev_start_xmit(struct sk_buff *skb,
-					  struct net_device *netdev)
-{
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-	u8 pad_len, q_idx = skb->queue_mapping;
-	struct hfi1_devdata *dd = vinfo->dd;
-	struct opa_vnic_skb_mdata *mdata;
-	u32 pkt_len, total_len;
-	int err = -EINVAL;
-	u64 pbc;
-
-	v_dbg("xmit: queue %d skb len %d\n", q_idx, skb->len);
-	if (unlikely(!netif_oper_up(netdev))) {
-		vinfo->stats[q_idx].tx_drop_state++;
-		goto tx_finish;
-	}
-
-	/* take out meta data */
-	mdata = (struct opa_vnic_skb_mdata *)skb->data;
-	skb_pull(skb, sizeof(*mdata));
-	if (unlikely(mdata->flags & OPA_VNIC_SKB_MDATA_ENCAP_ERR)) {
-		vinfo->stats[q_idx].tx_dlid_zero++;
-		goto tx_finish;
-	}
-
-	/* add tail padding (for 8 bytes size alignment) and icrc */
-	pad_len = -(skb->len + OPA_VNIC_ICRC_TAIL_LEN) & 0x7;
-	pad_len += OPA_VNIC_ICRC_TAIL_LEN;
-
-	/*
-	 * pkt_len is how much data we have to write, includes header and data.
-	 * total_len is length of the packet in Dwords plus the PBC should not
-	 * include the CRC.
-	 */
-	pkt_len = (skb->len + pad_len) >> 2;
-	total_len = pkt_len + 2; /* PBC + packet */
-
-	pbc = create_bypass_pbc(mdata->vl, total_len);
-
-	skb_get(skb);
-	v_dbg("pbc 0x%016llX len %d pad_len %d\n", pbc, skb->len, pad_len);
-	err = dd->process_vnic_dma_send(dd, q_idx, vinfo, skb, pbc, pad_len);
-	if (unlikely(err)) {
-		if (err == -ENOMEM)
-			vinfo->stats[q_idx].netstats.tx_fifo_errors++;
-		else if (err != -EBUSY)
-			vinfo->stats[q_idx].netstats.tx_carrier_errors++;
-	}
-	/* remove the header before updating tx counters */
-	skb_pull(skb, OPA_VNIC_HDR_LEN);
-
-	if (unlikely(err == -EBUSY)) {
-		hfi1_vnic_maybe_stop_tx(vinfo, q_idx);
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_BUSY;
-	}
-
-tx_finish:
-	/* update tx counters */
-	hfi1_vnic_update_tx_counters(vinfo, q_idx, skb, err);
-	dev_kfree_skb_any(skb);
-	return NETDEV_TX_OK;
-}
-
-static u16 hfi1_vnic_select_queue(struct net_device *netdev,
-				  struct sk_buff *skb,
-				  struct net_device *sb_dev)
-{
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-	struct opa_vnic_skb_mdata *mdata;
-	struct sdma_engine *sde;
-
-	mdata = (struct opa_vnic_skb_mdata *)skb->data;
-	sde = sdma_select_engine_vl(vinfo->dd, mdata->entropy, mdata->vl);
-	return sde->this_idx;
-}
-
-/* hfi1_vnic_decap_skb - strip OPA header from the skb (ethernet) packet */
-static inline int hfi1_vnic_decap_skb(struct hfi1_vnic_rx_queue *rxq,
-				      struct sk_buff *skb)
-{
-	struct hfi1_vnic_vport_info *vinfo = rxq->vinfo;
-	int max_len = vinfo->netdev->mtu + VLAN_ETH_HLEN;
-	int rc = -EFAULT;
-
-	skb_pull(skb, OPA_VNIC_HDR_LEN);
-
-	/* Validate Packet length */
-	if (unlikely(skb->len > max_len))
-		vinfo->stats[rxq->idx].rx_oversize++;
-	else if (unlikely(skb->len < ETH_ZLEN))
-		vinfo->stats[rxq->idx].rx_runt++;
-	else
-		rc = 0;
-	return rc;
-}
-
-static struct hfi1_vnic_vport_info *get_vnic_port(struct hfi1_devdata *dd,
-						  int vesw_id)
-{
-	int vnic_id = VNIC_ID(vesw_id);
-
-	return hfi1_netdev_get_data(dd, vnic_id);
-}
-
-static struct hfi1_vnic_vport_info *get_first_vnic_port(struct hfi1_devdata *dd)
-{
-	struct hfi1_vnic_vport_info *vinfo;
-	int next_id = VNIC_ID(0);
-
-	vinfo = hfi1_netdev_get_first_data(dd, &next_id);
-
-	if (next_id > VNIC_ID(VNIC_MASK))
-		return NULL;
-
-	return vinfo;
-}
-
-void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet)
-{
-	struct hfi1_devdata *dd = packet->rcd->dd;
-	struct hfi1_vnic_vport_info *vinfo = NULL;
-	struct hfi1_vnic_rx_queue *rxq;
-	struct sk_buff *skb;
-	int l4_type, vesw_id = -1, rc;
-	u8 q_idx;
-	unsigned char *pad_info;
-
-	l4_type = hfi1_16B_get_l4(packet->ebuf);
-	if (likely(l4_type == OPA_16B_L4_ETHR)) {
-		vesw_id = HFI1_VNIC_GET_VESWID(packet->ebuf);
-		vinfo = get_vnic_port(dd, vesw_id);
-
-		/*
-		 * In case of invalid vesw id, count the error on
-		 * the first available vport.
-		 */
-		if (unlikely(!vinfo)) {
-			struct hfi1_vnic_vport_info *vinfo_tmp;
-
-			vinfo_tmp = get_first_vnic_port(dd);
-			if (vinfo_tmp) {
-				spin_lock(&vport_cntr_lock);
-				vinfo_tmp->stats[0].netstats.rx_nohandler++;
-				spin_unlock(&vport_cntr_lock);
-			}
-		}
-	}
-
-	if (unlikely(!vinfo)) {
-		dd_dev_warn(dd, "vnic rcv err: l4 %d vesw id %d ctx %d\n",
-			    l4_type, vesw_id, packet->rcd->ctxt);
-		return;
-	}
-
-	q_idx = packet->rcd->vnic_q_idx;
-	rxq = &vinfo->rxq[q_idx];
-	if (unlikely(!netif_oper_up(vinfo->netdev))) {
-		vinfo->stats[q_idx].rx_drop_state++;
-		return;
-	}
-
-	skb = netdev_alloc_skb(vinfo->netdev, packet->tlen);
-	if (unlikely(!skb)) {
-		vinfo->stats[q_idx].netstats.rx_fifo_errors++;
-		return;
-	}
-
-	memcpy(skb->data, packet->ebuf, packet->tlen);
-	skb_put(skb, packet->tlen);
-
-	pad_info = skb->data + skb->len - 1;
-	skb_trim(skb, (skb->len - OPA_VNIC_ICRC_TAIL_LEN -
-		       ((*pad_info) & 0x7)));
-
-	rc = hfi1_vnic_decap_skb(rxq, skb);
-
-	/* update rx counters */
-	hfi1_vnic_update_rx_counters(vinfo, rxq->idx, skb, rc);
-	if (unlikely(rc)) {
-		dev_kfree_skb_any(skb);
-		return;
-	}
-
-	skb_checksum_none_assert(skb);
-	skb->protocol = eth_type_trans(skb, rxq->netdev);
-
-	napi_gro_receive(&rxq->napi, skb);
-}
-
-static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
-{
-	struct hfi1_devdata *dd = vinfo->dd;
-	struct net_device *netdev = vinfo->netdev;
-	int rc;
-
-	/* ensure virtual eth switch id is valid */
-	if (!vinfo->vesw_id)
-		return -EINVAL;
-
-	rc = hfi1_netdev_add_data(dd, VNIC_ID(vinfo->vesw_id), vinfo);
-	if (rc < 0)
-		return rc;
-
-	rc = hfi1_netdev_rx_init(dd);
-	if (rc)
-		goto err_remove;
-
-	netif_carrier_on(netdev);
-	netif_tx_start_all_queues(netdev);
-	set_bit(HFI1_VNIC_UP, &vinfo->flags);
-
-	return 0;
-
-err_remove:
-	hfi1_netdev_remove_data(dd, VNIC_ID(vinfo->vesw_id));
-	return rc;
-}
-
-static void hfi1_vnic_down(struct hfi1_vnic_vport_info *vinfo)
-{
-	struct hfi1_devdata *dd = vinfo->dd;
-
-	clear_bit(HFI1_VNIC_UP, &vinfo->flags);
-	netif_carrier_off(vinfo->netdev);
-	netif_tx_disable(vinfo->netdev);
-	hfi1_netdev_remove_data(dd, VNIC_ID(vinfo->vesw_id));
-
-	hfi1_netdev_rx_destroy(dd);
-}
-
-static int hfi1_netdev_open(struct net_device *netdev)
-{
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-	int rc;
-
-	mutex_lock(&vinfo->lock);
-	rc = hfi1_vnic_up(vinfo);
-	mutex_unlock(&vinfo->lock);
-	return rc;
-}
-
-static int hfi1_netdev_close(struct net_device *netdev)
-{
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-
-	mutex_lock(&vinfo->lock);
-	if (test_bit(HFI1_VNIC_UP, &vinfo->flags))
-		hfi1_vnic_down(vinfo);
-	mutex_unlock(&vinfo->lock);
-	return 0;
-}
-
-static int hfi1_vnic_init(struct hfi1_vnic_vport_info *vinfo)
-{
-	struct hfi1_devdata *dd = vinfo->dd;
-	int rc = 0;
-
-	mutex_lock(&hfi1_mutex);
-	if (!dd->vnic_num_vports) {
-		rc = hfi1_vnic_txreq_init(dd);
-		if (rc)
-			goto txreq_fail;
-	}
-
-	rc = hfi1_netdev_rx_init(dd);
-	if (rc) {
-		dd_dev_err(dd, "Unable to initialize netdev contexts\n");
-		goto alloc_fail;
-	}
-
-	hfi1_init_vnic_rsm(dd);
-
-	dd->vnic_num_vports++;
-	hfi1_vnic_sdma_init(vinfo);
-
-alloc_fail:
-	if (!dd->vnic_num_vports)
-		hfi1_vnic_txreq_deinit(dd);
-txreq_fail:
-	mutex_unlock(&hfi1_mutex);
-	return rc;
-}
-
-static void hfi1_vnic_deinit(struct hfi1_vnic_vport_info *vinfo)
-{
-	struct hfi1_devdata *dd = vinfo->dd;
-
-	mutex_lock(&hfi1_mutex);
-	if (--dd->vnic_num_vports == 0) {
-		hfi1_deinit_vnic_rsm(dd);
-		hfi1_vnic_txreq_deinit(dd);
-	}
-	mutex_unlock(&hfi1_mutex);
-	hfi1_netdev_rx_destroy(dd);
-}
-
-static void hfi1_vnic_set_vesw_id(struct net_device *netdev, int id)
-{
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-	bool reopen = false;
-
-	/*
-	 * If vesw_id is being changed, and if the vnic port is up,
-	 * reset the vnic port to ensure new vesw_id gets picked up
-	 */
-	if (id != vinfo->vesw_id) {
-		mutex_lock(&vinfo->lock);
-		if (test_bit(HFI1_VNIC_UP, &vinfo->flags)) {
-			hfi1_vnic_down(vinfo);
-			reopen = true;
-		}
-
-		vinfo->vesw_id = id;
-		if (reopen)
-			hfi1_vnic_up(vinfo);
-
-		mutex_unlock(&vinfo->lock);
-	}
-}
-
-/* netdev ops */
-static const struct net_device_ops hfi1_netdev_ops = {
-	.ndo_open = hfi1_netdev_open,
-	.ndo_stop = hfi1_netdev_close,
-	.ndo_start_xmit = hfi1_netdev_start_xmit,
-	.ndo_select_queue = hfi1_vnic_select_queue,
-	.ndo_get_stats64 = hfi1_vnic_get_stats64,
-};
-
-static void hfi1_vnic_free_rn(struct net_device *netdev)
-{
-	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
-
-	hfi1_vnic_deinit(vinfo);
-	mutex_destroy(&vinfo->lock);
-	free_netdev(netdev);
-}
-
-struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
-				      u32 port_num,
-				      enum rdma_netdev_t type,
-				      const char *name,
-				      unsigned char name_assign_type,
-				      void (*setup)(struct net_device *))
-{
-	struct hfi1_devdata *dd = dd_from_ibdev(device);
-	struct hfi1_vnic_vport_info *vinfo;
-	struct net_device *netdev;
-	struct rdma_netdev *rn;
-	int i, size, rc;
-
-	if (!dd->num_netdev_contexts)
-		return ERR_PTR(-ENOMEM);
-
-	if (!port_num || (port_num > dd->num_pports))
-		return ERR_PTR(-EINVAL);
-
-	if (type != RDMA_NETDEV_OPA_VNIC)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	size = sizeof(struct opa_vnic_rdma_netdev) + sizeof(*vinfo);
-	netdev = alloc_netdev_mqs(size, name, name_assign_type, setup,
-				  chip_sdma_engines(dd),
-				  dd->num_netdev_contexts);
-	if (!netdev)
-		return ERR_PTR(-ENOMEM);
-
-	rn = netdev_priv(netdev);
-	vinfo = opa_vnic_dev_priv(netdev);
-	vinfo->dd = dd;
-	vinfo->num_tx_q = chip_sdma_engines(dd);
-	vinfo->num_rx_q = dd->num_netdev_contexts;
-	vinfo->netdev = netdev;
-	rn->free_rdma_netdev = hfi1_vnic_free_rn;
-	rn->set_id = hfi1_vnic_set_vesw_id;
-
-	netdev->features = NETIF_F_HIGHDMA | NETIF_F_SG;
-	netdev->hw_features = netdev->features;
-	netdev->vlan_features = netdev->features;
-	netdev->watchdog_timeo = msecs_to_jiffies(HFI_TX_TIMEOUT_MS);
-	netdev->netdev_ops = &hfi1_netdev_ops;
-	mutex_init(&vinfo->lock);
-
-	for (i = 0; i < vinfo->num_rx_q; i++) {
-		struct hfi1_vnic_rx_queue *rxq = &vinfo->rxq[i];
-
-		rxq->idx = i;
-		rxq->vinfo = vinfo;
-		rxq->netdev = netdev;
-	}
-
-	rc = hfi1_vnic_init(vinfo);
-	if (rc)
-		goto init_fail;
-
-	return netdev;
-init_fail:
-	mutex_destroy(&vinfo->lock);
-	free_netdev(netdev);
-	return ERR_PTR(rc);
-}
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
deleted file mode 100644
index 6caf01ba0bca..000000000000
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ /dev/null
@@ -1,282 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/*
- * Copyright(c) 2017 - 2018 Intel Corporation.
- */
-
-/*
- * This file contains HFI1 support for VNIC SDMA functionality
- */
-
-#include "sdma.h"
-#include "vnic.h"
-
-#define HFI1_VNIC_SDMA_Q_ACTIVE   BIT(0)
-#define HFI1_VNIC_SDMA_Q_DEFERRED BIT(1)
-
-#define HFI1_VNIC_TXREQ_NAME_LEN   32
-#define HFI1_VNIC_SDMA_DESC_WTRMRK 64
-
-/*
- * struct vnic_txreq - VNIC transmit descriptor
- * @txreq: sdma transmit request
- * @sdma: vnic sdma pointer
- * @skb: skb to send
- * @pad: pad buffer
- * @plen: pad length
- * @pbc_val: pbc value
- */
-struct vnic_txreq {
-	struct sdma_txreq       txreq;
-	struct hfi1_vnic_sdma   *sdma;
-
-	struct sk_buff         *skb;
-	unsigned char           pad[HFI1_VNIC_MAX_PAD];
-	u16                     plen;
-	__le64                  pbc_val;
-};
-
-static void vnic_sdma_complete(struct sdma_txreq *txreq,
-			       int status)
-{
-	struct vnic_txreq *tx = container_of(txreq, struct vnic_txreq, txreq);
-	struct hfi1_vnic_sdma *vnic_sdma = tx->sdma;
-
-	sdma_txclean(vnic_sdma->dd, txreq);
-	dev_kfree_skb_any(tx->skb);
-	kmem_cache_free(vnic_sdma->dd->vnic.txreq_cache, tx);
-}
-
-static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
-					   struct vnic_txreq *tx)
-{
-	int i, ret = 0;
-
-	ret = sdma_txadd_kvaddr(
-		sde->dd,
-		&tx->txreq,
-		tx->skb->data,
-		skb_headlen(tx->skb));
-	if (unlikely(ret))
-		goto bail_txadd;
-
-	for (i = 0; i < skb_shinfo(tx->skb)->nr_frags; i++) {
-		skb_frag_t *frag = &skb_shinfo(tx->skb)->frags[i];
-
-		/* combine physically continuous fragments later? */
-		ret = sdma_txadd_page(sde->dd,
-				      &tx->txreq,
-				      skb_frag_page(frag),
-				      skb_frag_off(frag),
-				      skb_frag_size(frag),
-				      NULL, NULL, NULL);
-		if (unlikely(ret))
-			goto bail_txadd;
-	}
-
-	if (tx->plen)
-		ret = sdma_txadd_kvaddr(sde->dd, &tx->txreq,
-					tx->pad + HFI1_VNIC_MAX_PAD - tx->plen,
-					tx->plen);
-
-bail_txadd:
-	return ret;
-}
-
-static int build_vnic_tx_desc(struct sdma_engine *sde,
-			      struct vnic_txreq *tx,
-			      u64 pbc)
-{
-	int ret = 0;
-	u16 hdrbytes = 2 << 2;  /* PBC */
-
-	ret = sdma_txinit_ahg(
-		&tx->txreq,
-		0,
-		hdrbytes + tx->skb->len + tx->plen,
-		0,
-		0,
-		NULL,
-		0,
-		vnic_sdma_complete);
-	if (unlikely(ret))
-		goto bail_txadd;
-
-	/* add pbc */
-	tx->pbc_val = cpu_to_le64(pbc);
-	ret = sdma_txadd_kvaddr(
-		sde->dd,
-		&tx->txreq,
-		&tx->pbc_val,
-		hdrbytes);
-	if (unlikely(ret))
-		goto bail_txadd;
-
-	/* add the ulp payload */
-	ret = build_vnic_ulp_payload(sde, tx);
-bail_txadd:
-	return ret;
-}
-
-/* setup the last plen bypes of pad */
-static inline void hfi1_vnic_update_pad(unsigned char *pad, u8 plen)
-{
-	pad[HFI1_VNIC_MAX_PAD - 1] = plen - OPA_VNIC_ICRC_TAIL_LEN;
-}
-
-int hfi1_vnic_send_dma(struct hfi1_devdata *dd, u8 q_idx,
-		       struct hfi1_vnic_vport_info *vinfo,
-		       struct sk_buff *skb, u64 pbc, u8 plen)
-{
-	struct hfi1_vnic_sdma *vnic_sdma = &vinfo->sdma[q_idx];
-	struct sdma_engine *sde = vnic_sdma->sde;
-	struct vnic_txreq *tx;
-	int ret = -ECOMM;
-
-	if (unlikely(READ_ONCE(vnic_sdma->state) != HFI1_VNIC_SDMA_Q_ACTIVE))
-		goto tx_err;
-
-	if (unlikely(!sde || !sdma_running(sde)))
-		goto tx_err;
-
-	tx = kmem_cache_alloc(dd->vnic.txreq_cache, GFP_ATOMIC);
-	if (unlikely(!tx)) {
-		ret = -ENOMEM;
-		goto tx_err;
-	}
-
-	tx->sdma = vnic_sdma;
-	tx->skb = skb;
-	hfi1_vnic_update_pad(tx->pad, plen);
-	tx->plen = plen;
-	ret = build_vnic_tx_desc(sde, tx, pbc);
-	if (unlikely(ret))
-		goto free_desc;
-
-	ret = sdma_send_txreq(sde, iowait_get_ib_work(&vnic_sdma->wait),
-			      &tx->txreq, vnic_sdma->pkts_sent);
-	/* When -ECOMM, sdma callback will be called with ABORT status */
-	if (unlikely(ret && unlikely(ret != -ECOMM)))
-		goto free_desc;
-
-	if (!ret) {
-		vnic_sdma->pkts_sent = true;
-		iowait_starve_clear(vnic_sdma->pkts_sent, &vnic_sdma->wait);
-	}
-	return ret;
-
-free_desc:
-	sdma_txclean(dd, &tx->txreq);
-	kmem_cache_free(dd->vnic.txreq_cache, tx);
-tx_err:
-	if (ret != -EBUSY)
-		dev_kfree_skb_any(skb);
-	else
-		vnic_sdma->pkts_sent = false;
-	return ret;
-}
-
-/*
- * hfi1_vnic_sdma_sleep - vnic sdma sleep function
- *
- * This function gets called from sdma_send_txreq() when there are not enough
- * sdma descriptors available to send the packet. It adds Tx queue's wait
- * structure to sdma engine's dmawait list to be woken up when descriptors
- * become available.
- */
-static int hfi1_vnic_sdma_sleep(struct sdma_engine *sde,
-				struct iowait_work *wait,
-				struct sdma_txreq *txreq,
-				uint seq,
-				bool pkts_sent)
-{
-	struct hfi1_vnic_sdma *vnic_sdma =
-		container_of(wait->iow, struct hfi1_vnic_sdma, wait);
-
-	write_seqlock(&sde->waitlock);
-	if (sdma_progress(sde, seq, txreq)) {
-		write_sequnlock(&sde->waitlock);
-		return -EAGAIN;
-	}
-
-	vnic_sdma->state = HFI1_VNIC_SDMA_Q_DEFERRED;
-	if (list_empty(&vnic_sdma->wait.list)) {
-		iowait_get_priority(wait->iow);
-		iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
-	}
-	write_sequnlock(&sde->waitlock);
-	return -EBUSY;
-}
-
-/*
- * hfi1_vnic_sdma_wakeup - vnic sdma wakeup function
- *
- * This function gets called when SDMA descriptors becomes available and Tx
- * queue's wait structure was previously added to sdma engine's dmawait list.
- * It notifies the upper driver about Tx queue wakeup.
- */
-static void hfi1_vnic_sdma_wakeup(struct iowait *wait, int reason)
-{
-	struct hfi1_vnic_sdma *vnic_sdma =
-		container_of(wait, struct hfi1_vnic_sdma, wait);
-	struct hfi1_vnic_vport_info *vinfo = vnic_sdma->vinfo;
-
-	vnic_sdma->state = HFI1_VNIC_SDMA_Q_ACTIVE;
-	if (__netif_subqueue_stopped(vinfo->netdev, vnic_sdma->q_idx))
-		netif_wake_subqueue(vinfo->netdev, vnic_sdma->q_idx);
-};
-
-inline bool hfi1_vnic_sdma_write_avail(struct hfi1_vnic_vport_info *vinfo,
-				       u8 q_idx)
-{
-	struct hfi1_vnic_sdma *vnic_sdma = &vinfo->sdma[q_idx];
-
-	return (READ_ONCE(vnic_sdma->state) == HFI1_VNIC_SDMA_Q_ACTIVE);
-}
-
-void hfi1_vnic_sdma_init(struct hfi1_vnic_vport_info *vinfo)
-{
-	int i;
-
-	for (i = 0; i < vinfo->num_tx_q; i++) {
-		struct hfi1_vnic_sdma *vnic_sdma = &vinfo->sdma[i];
-
-		iowait_init(&vnic_sdma->wait, 0, NULL, NULL,
-			    hfi1_vnic_sdma_sleep,
-			    hfi1_vnic_sdma_wakeup, NULL, NULL);
-		vnic_sdma->sde = &vinfo->dd->per_sdma[i];
-		vnic_sdma->dd = vinfo->dd;
-		vnic_sdma->vinfo = vinfo;
-		vnic_sdma->q_idx = i;
-		vnic_sdma->state = HFI1_VNIC_SDMA_Q_ACTIVE;
-
-		/* Add a free descriptor watermark for wakeups */
-		if (vnic_sdma->sde->descq_cnt > HFI1_VNIC_SDMA_DESC_WTRMRK) {
-			struct iowait_work *work;
-
-			INIT_LIST_HEAD(&vnic_sdma->stx.list);
-			vnic_sdma->stx.num_desc = HFI1_VNIC_SDMA_DESC_WTRMRK;
-			work = iowait_get_ib_work(&vnic_sdma->wait);
-			list_add_tail(&vnic_sdma->stx.list, &work->tx_head);
-		}
-	}
-}
-
-int hfi1_vnic_txreq_init(struct hfi1_devdata *dd)
-{
-	char buf[HFI1_VNIC_TXREQ_NAME_LEN];
-
-	snprintf(buf, sizeof(buf), "hfi1_%u_vnic_txreq_cache", dd->unit);
-	dd->vnic.txreq_cache = kmem_cache_create(buf,
-						 sizeof(struct vnic_txreq),
-						 0, SLAB_HWCACHE_ALIGN,
-						 NULL);
-	if (!dd->vnic.txreq_cache)
-		return -ENOMEM;
-	return 0;
-}
-
-void hfi1_vnic_txreq_deinit(struct hfi1_devdata *dd)
-{
-	kmem_cache_destroy(dd->vnic.txreq_cache);
-	dd->vnic.txreq_cache = NULL;
-}
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 4d0004b58377..51b0d41699b8 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -4,5 +4,4 @@ obj-$(CONFIG_INFINIBAND_SRP)		+= srp/
 obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
-obj-$(CONFIG_INFINIBAND_OPA_VNIC)	+= opa_vnic/
 obj-$(CONFIG_INFINIBAND_RTRS)		+= rtrs/
diff --git a/drivers/infiniband/ulp/opa_vnic/Kconfig b/drivers/infiniband/ulp/opa_vnic/Kconfig
deleted file mode 100644
index 4d43d055fa8e..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/Kconfig
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config INFINIBAND_OPA_VNIC
-	tristate "Cornelis OPX VNIC support"
-	depends on X86_64 && INFINIBAND
-	help
-	This is Omni-Path Express (OPX) Virtual Network Interface Controller (VNIC)
-	driver for Ethernet over Omni-Path feature. It implements the HW
-	independent VNIC functionality. It interfaces with Linux stack for
-	data path and IB MAD for the control path.
diff --git a/drivers/infiniband/ulp/opa_vnic/Makefile b/drivers/infiniband/ulp/opa_vnic/Makefile
deleted file mode 100644
index 196183817cdc..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Makefile - Cornelis Omni-Path Express Virtual Network Controller driver
-# Copyright(c) 2017, Intel Corporation.
-# Copyright(c) 2021, Cornelis Networks.
-#
-obj-$(CONFIG_INFINIBAND_OPA_VNIC) += opa_vnic.o
-
-opa_vnic-y := opa_vnic_netdev.o opa_vnic_encap.o opa_vnic_ethtool.o \
-              opa_vnic_vema.o opa_vnic_vema_iface.o
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
deleted file mode 100644
index 31cd361416ac..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
+++ /dev/null
@@ -1,513 +0,0 @@
-/*
- * Copyright(c) 2017 Intel Corporation.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains OPA VNIC encapsulation/decapsulation function.
- */
-
-#include <linux/if_ether.h>
-#include <linux/if_vlan.h>
-
-#include "opa_vnic_internal.h"
-
-/* OPA 16B Header fields */
-#define OPA_16B_LID_MASK        0xFFFFFull
-#define OPA_16B_SLID_HIGH_SHFT  8
-#define OPA_16B_SLID_MASK       0xF00ull
-#define OPA_16B_DLID_MASK       0xF000ull
-#define OPA_16B_DLID_HIGH_SHFT  12
-#define OPA_16B_LEN_SHFT        20
-#define OPA_16B_SC_SHFT         20
-#define OPA_16B_RC_SHFT         25
-#define OPA_16B_PKEY_SHFT       16
-
-#define OPA_VNIC_L4_HDR_SHFT    16
-
-/* L2+L4 hdr len is 20 bytes (5 quad words) */
-#define OPA_VNIC_HDR_QW_LEN   5
-
-static inline void opa_vnic_make_header(u8 *hdr, u32 slid, u32 dlid, u16 len,
-					u16 pkey, u16 entropy, u8 sc, u8 rc,
-					u8 l4_type, u16 l4_hdr)
-{
-	/* h[1]: LT=1, 16B L2=10 */
-	u32 h[OPA_VNIC_HDR_QW_LEN] = {0, 0xc0000000, 0, 0, 0};
-
-	h[2] = l4_type;
-	h[3] = entropy;
-	h[4] = l4_hdr << OPA_VNIC_L4_HDR_SHFT;
-
-	/* Extract and set 4 upper bits and 20 lower bits of the lids */
-	h[0] |= (slid & OPA_16B_LID_MASK);
-	h[2] |= ((slid >> (20 - OPA_16B_SLID_HIGH_SHFT)) & OPA_16B_SLID_MASK);
-
-	h[1] |= (dlid & OPA_16B_LID_MASK);
-	h[2] |= ((dlid >> (20 - OPA_16B_DLID_HIGH_SHFT)) & OPA_16B_DLID_MASK);
-
-	h[0] |= (len << OPA_16B_LEN_SHFT);
-	h[1] |= (rc << OPA_16B_RC_SHFT);
-	h[1] |= (sc << OPA_16B_SC_SHFT);
-	h[2] |= ((u32)pkey << OPA_16B_PKEY_SHFT);
-
-	memcpy(hdr, h, OPA_VNIC_HDR_LEN);
-}
-
-/*
- * Using a simple hash table for mac table implementation with the last octet
- * of mac address as a key.
- */
-static void opa_vnic_free_mac_tbl(struct hlist_head *mactbl)
-{
-	struct opa_vnic_mac_tbl_node *node;
-	struct hlist_node *tmp;
-	int bkt;
-
-	if (!mactbl)
-		return;
-
-	vnic_hash_for_each_safe(mactbl, bkt, tmp, node, hlist) {
-		hash_del(&node->hlist);
-		kfree(node);
-	}
-	kfree(mactbl);
-}
-
-static struct hlist_head *opa_vnic_alloc_mac_tbl(void)
-{
-	u32 size = sizeof(struct hlist_head) * OPA_VNIC_MAC_TBL_SIZE;
-	struct hlist_head *mactbl;
-
-	mactbl = kzalloc(size, GFP_KERNEL);
-	if (!mactbl)
-		return ERR_PTR(-ENOMEM);
-
-	vnic_hash_init(mactbl);
-	return mactbl;
-}
-
-/* opa_vnic_release_mac_tbl - empty and free the mac table */
-void opa_vnic_release_mac_tbl(struct opa_vnic_adapter *adapter)
-{
-	struct hlist_head *mactbl;
-
-	mutex_lock(&adapter->mactbl_lock);
-	mactbl = rcu_access_pointer(adapter->mactbl);
-	rcu_assign_pointer(adapter->mactbl, NULL);
-	synchronize_rcu();
-	opa_vnic_free_mac_tbl(mactbl);
-	adapter->info.vport.mac_tbl_digest = 0;
-	mutex_unlock(&adapter->mactbl_lock);
-}
-
-/*
- * opa_vnic_query_mac_tbl - query the mac table for a section
- *
- * This function implements query of specific function of the mac table.
- * The function also expects the requested range to be valid.
- */
-void opa_vnic_query_mac_tbl(struct opa_vnic_adapter *adapter,
-			    struct opa_veswport_mactable *tbl)
-{
-	struct opa_vnic_mac_tbl_node *node;
-	struct hlist_head *mactbl;
-	int bkt;
-	u16 loffset, lnum_entries;
-
-	rcu_read_lock();
-	mactbl = rcu_dereference(adapter->mactbl);
-	if (!mactbl)
-		goto get_mac_done;
-
-	loffset = be16_to_cpu(tbl->offset);
-	lnum_entries = be16_to_cpu(tbl->num_entries);
-
-	vnic_hash_for_each(mactbl, bkt, node, hlist) {
-		struct __opa_vnic_mactable_entry *nentry = &node->entry;
-		struct opa_veswport_mactable_entry *entry;
-
-		if ((node->index < loffset) ||
-		    (node->index >= (loffset + lnum_entries)))
-			continue;
-
-		/* populate entry in the tbl corresponding to the index */
-		entry = &tbl->tbl_entries[node->index - loffset];
-		memcpy(entry->mac_addr, nentry->mac_addr,
-		       ARRAY_SIZE(entry->mac_addr));
-		memcpy(entry->mac_addr_mask, nentry->mac_addr_mask,
-		       ARRAY_SIZE(entry->mac_addr_mask));
-		entry->dlid_sd = cpu_to_be32(nentry->dlid_sd);
-	}
-	tbl->mac_tbl_digest = cpu_to_be32(adapter->info.vport.mac_tbl_digest);
-get_mac_done:
-	rcu_read_unlock();
-}
-
-/*
- * opa_vnic_update_mac_tbl - update mac table section
- *
- * This function updates the specified section of the mac table.
- * The procedure includes following steps.
- *  - Allocate a new mac (hash) table.
- *  - Add the specified entries to the new table.
- *    (except the ones that are requested to be deleted).
- *  - Add all the other entries from the old mac table.
- *  - If there is a failure, free the new table and return.
- *  - Switch to the new table.
- *  - Free the old table and return.
- *
- * The function also expects the requested range to be valid.
- */
-int opa_vnic_update_mac_tbl(struct opa_vnic_adapter *adapter,
-			    struct opa_veswport_mactable *tbl)
-{
-	struct opa_vnic_mac_tbl_node *node, *new_node;
-	struct hlist_head *new_mactbl, *old_mactbl;
-	int i, bkt, rc = 0;
-	u8 key;
-	u16 loffset, lnum_entries;
-
-	mutex_lock(&adapter->mactbl_lock);
-	/* allocate new mac table */
-	new_mactbl = opa_vnic_alloc_mac_tbl();
-	if (IS_ERR(new_mactbl)) {
-		mutex_unlock(&adapter->mactbl_lock);
-		return PTR_ERR(new_mactbl);
-	}
-
-	loffset = be16_to_cpu(tbl->offset);
-	lnum_entries = be16_to_cpu(tbl->num_entries);
-
-	/* add updated entries to the new mac table */
-	for (i = 0; i < lnum_entries; i++) {
-		struct __opa_vnic_mactable_entry *nentry;
-		struct opa_veswport_mactable_entry *entry =
-							&tbl->tbl_entries[i];
-		u8 *mac_addr = entry->mac_addr;
-		u8 empty_mac[ETH_ALEN] = { 0 };
-
-		v_dbg("new mac entry %4d: %02x:%02x:%02x:%02x:%02x:%02x %x\n",
-		      loffset + i, mac_addr[0], mac_addr[1], mac_addr[2],
-		      mac_addr[3], mac_addr[4], mac_addr[5],
-		      entry->dlid_sd);
-
-		/* if the entry is being removed, do not add it */
-		if (!memcmp(mac_addr, empty_mac, ARRAY_SIZE(empty_mac)))
-			continue;
-
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node) {
-			rc = -ENOMEM;
-			goto updt_done;
-		}
-
-		node->index = loffset + i;
-		nentry = &node->entry;
-		memcpy(nentry->mac_addr, entry->mac_addr,
-		       ARRAY_SIZE(nentry->mac_addr));
-		memcpy(nentry->mac_addr_mask, entry->mac_addr_mask,
-		       ARRAY_SIZE(nentry->mac_addr_mask));
-		nentry->dlid_sd = be32_to_cpu(entry->dlid_sd);
-		key = node->entry.mac_addr[OPA_VNIC_MAC_HASH_IDX];
-		vnic_hash_add(new_mactbl, &node->hlist, key);
-	}
-
-	/* add other entries from current mac table to new mac table */
-	old_mactbl = rcu_access_pointer(adapter->mactbl);
-	if (!old_mactbl)
-		goto switch_tbl;
-
-	vnic_hash_for_each(old_mactbl, bkt, node, hlist) {
-		if ((node->index >= loffset) &&
-		    (node->index < (loffset + lnum_entries)))
-			continue;
-
-		new_node = kzalloc(sizeof(*new_node), GFP_KERNEL);
-		if (!new_node) {
-			rc = -ENOMEM;
-			goto updt_done;
-		}
-
-		new_node->index = node->index;
-		memcpy(&new_node->entry, &node->entry, sizeof(node->entry));
-		key = new_node->entry.mac_addr[OPA_VNIC_MAC_HASH_IDX];
-		vnic_hash_add(new_mactbl, &new_node->hlist, key);
-	}
-
-switch_tbl:
-	/* switch to new table */
-	rcu_assign_pointer(adapter->mactbl, new_mactbl);
-	synchronize_rcu();
-
-	adapter->info.vport.mac_tbl_digest = be32_to_cpu(tbl->mac_tbl_digest);
-updt_done:
-	/* upon failure, free the new table; otherwise, free the old table */
-	if (rc)
-		opa_vnic_free_mac_tbl(new_mactbl);
-	else
-		opa_vnic_free_mac_tbl(old_mactbl);
-
-	mutex_unlock(&adapter->mactbl_lock);
-	return rc;
-}
-
-/* opa_vnic_chk_mac_tbl - check mac table for dlid */
-static uint32_t opa_vnic_chk_mac_tbl(struct opa_vnic_adapter *adapter,
-				     struct ethhdr *mac_hdr)
-{
-	struct opa_vnic_mac_tbl_node *node;
-	struct hlist_head *mactbl;
-	u32 dlid = 0;
-	u8 key;
-
-	rcu_read_lock();
-	mactbl = rcu_dereference(adapter->mactbl);
-	if (unlikely(!mactbl))
-		goto chk_done;
-
-	key = mac_hdr->h_dest[OPA_VNIC_MAC_HASH_IDX];
-	vnic_hash_for_each_possible(mactbl, node, hlist, key) {
-		struct __opa_vnic_mactable_entry *entry = &node->entry;
-
-		/* if related to source mac, skip */
-		if (unlikely(OPA_VNIC_DLID_SD_IS_SRC_MAC(entry->dlid_sd)))
-			continue;
-
-		if (!memcmp(node->entry.mac_addr, mac_hdr->h_dest,
-			    ARRAY_SIZE(node->entry.mac_addr))) {
-			/* mac address found */
-			dlid = OPA_VNIC_DLID_SD_GET_DLID(node->entry.dlid_sd);
-			break;
-		}
-	}
-
-chk_done:
-	rcu_read_unlock();
-	return dlid;
-}
-
-/* opa_vnic_get_dlid - find and return the DLID */
-static uint32_t opa_vnic_get_dlid(struct opa_vnic_adapter *adapter,
-				  struct sk_buff *skb, u8 def_port)
-{
-	struct __opa_veswport_info *info = &adapter->info;
-	struct ethhdr *mac_hdr = (struct ethhdr *)skb_mac_header(skb);
-	u32 dlid;
-
-	dlid = opa_vnic_chk_mac_tbl(adapter, mac_hdr);
-	if (dlid)
-		return dlid;
-
-	if (is_multicast_ether_addr(mac_hdr->h_dest)) {
-		dlid = info->vesw.u_mcast_dlid;
-	} else {
-		if (is_local_ether_addr(mac_hdr->h_dest)) {
-			dlid = ((uint32_t)mac_hdr->h_dest[5] << 16) |
-				((uint32_t)mac_hdr->h_dest[4] << 8)  |
-				mac_hdr->h_dest[3];
-			if (unlikely(!dlid))
-				v_warn("Null dlid in MAC address\n");
-		} else if (def_port != OPA_VNIC_INVALID_PORT) {
-			if (def_port < OPA_VESW_MAX_NUM_DEF_PORT)
-				dlid = info->vesw.u_ucast_dlid[def_port];
-		}
-	}
-
-	return dlid;
-}
-
-/* opa_vnic_get_sc - return the service class */
-static u8 opa_vnic_get_sc(struct __opa_veswport_info *info,
-			  struct sk_buff *skb)
-{
-	struct ethhdr *mac_hdr = (struct ethhdr *)skb_mac_header(skb);
-	u16 vlan_tci;
-	u8 sc;
-
-	if (!__vlan_get_tag(skb, &vlan_tci)) {
-		u8 pcp = OPA_VNIC_VLAN_PCP(vlan_tci);
-
-		if (is_multicast_ether_addr(mac_hdr->h_dest))
-			sc = info->vport.pcp_to_sc_mc[pcp];
-		else
-			sc = info->vport.pcp_to_sc_uc[pcp];
-	} else {
-		if (is_multicast_ether_addr(mac_hdr->h_dest))
-			sc = info->vport.non_vlan_sc_mc;
-		else
-			sc = info->vport.non_vlan_sc_uc;
-	}
-
-	return sc;
-}
-
-u8 opa_vnic_get_vl(struct opa_vnic_adapter *adapter, struct sk_buff *skb)
-{
-	struct ethhdr *mac_hdr = (struct ethhdr *)skb_mac_header(skb);
-	struct __opa_veswport_info *info = &adapter->info;
-	u8 vl;
-
-	if (skb_vlan_tag_present(skb)) {
-		u8 pcp = skb_vlan_tag_get(skb) >> VLAN_PRIO_SHIFT;
-
-		if (is_multicast_ether_addr(mac_hdr->h_dest))
-			vl = info->vport.pcp_to_vl_mc[pcp];
-		else
-			vl = info->vport.pcp_to_vl_uc[pcp];
-	} else {
-		if (is_multicast_ether_addr(mac_hdr->h_dest))
-			vl = info->vport.non_vlan_vl_mc;
-		else
-			vl = info->vport.non_vlan_vl_uc;
-	}
-
-	return vl;
-}
-
-/* opa_vnic_get_rc - return the routing control */
-static u8 opa_vnic_get_rc(struct __opa_veswport_info *info,
-			  struct sk_buff *skb)
-{
-	u8 proto, rout_ctrl;
-
-	switch (vlan_get_protocol(skb)) {
-	case htons(ETH_P_IPV6):
-		proto = ipv6_hdr(skb)->nexthdr;
-		if (proto == IPPROTO_TCP)
-			rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc,
-							  IPV6_TCP);
-		else if (proto == IPPROTO_UDP)
-			rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc,
-							  IPV6_UDP);
-		else
-			rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc, IPV6);
-		break;
-	case htons(ETH_P_IP):
-		proto = ip_hdr(skb)->protocol;
-		if (proto == IPPROTO_TCP)
-			rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc,
-							  IPV4_TCP);
-		else if (proto == IPPROTO_UDP)
-			rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc,
-							  IPV4_UDP);
-		else
-			rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc, IPV4);
-		break;
-	default:
-		rout_ctrl = OPA_VNIC_ENCAP_RC_EXT(info->vesw.rc, DEFAULT);
-	}
-
-	return rout_ctrl;
-}
-
-/* opa_vnic_calc_entropy - calculate the packet entropy */
-u8 opa_vnic_calc_entropy(struct sk_buff *skb)
-{
-	u32 hash = skb_get_hash(skb);
-
-	/* store XOR of all bytes in lower 8 bits */
-	hash ^= hash >> 8;
-	hash ^= hash >> 16;
-
-	/* return lower 8 bits as entropy */
-	return (u8)(hash & 0xFF);
-}
-
-/* opa_vnic_get_def_port - get default port based on entropy */
-static inline u8 opa_vnic_get_def_port(struct opa_vnic_adapter *adapter,
-				       u8 entropy)
-{
-	u8 flow_id;
-
-	/* Add the upper and lower 4-bits of entropy to get the flow id */
-	flow_id = ((entropy & 0xf) + (entropy >> 4));
-	return adapter->flow_tbl[flow_id & (OPA_VNIC_FLOW_TBL_SIZE - 1)];
-}
-
-/* Calculate packet length including OPA header, crc and padding */
-static inline int opa_vnic_wire_length(struct sk_buff *skb)
-{
-	u32 pad_len;
-
-	/* padding for 8 bytes size alignment */
-	pad_len = -(skb->len + OPA_VNIC_ICRC_TAIL_LEN) & 0x7;
-	pad_len += OPA_VNIC_ICRC_TAIL_LEN;
-
-	return (skb->len + pad_len) >> 3;
-}
-
-/* opa_vnic_encap_skb - encapsulate skb packet with OPA header and meta data */
-void opa_vnic_encap_skb(struct opa_vnic_adapter *adapter, struct sk_buff *skb)
-{
-	struct __opa_veswport_info *info = &adapter->info;
-	struct opa_vnic_skb_mdata *mdata;
-	u8 def_port, sc, rc, entropy, *hdr;
-	u16 len, l4_hdr;
-	u32 dlid;
-
-	hdr = skb_push(skb, OPA_VNIC_HDR_LEN);
-
-	entropy = opa_vnic_calc_entropy(skb);
-	def_port = opa_vnic_get_def_port(adapter, entropy);
-	len = opa_vnic_wire_length(skb);
-	dlid = opa_vnic_get_dlid(adapter, skb, def_port);
-	sc = opa_vnic_get_sc(info, skb);
-	rc = opa_vnic_get_rc(info, skb);
-	l4_hdr = info->vesw.vesw_id;
-
-	mdata = skb_push(skb, sizeof(*mdata));
-	mdata->vl = opa_vnic_get_vl(adapter, skb);
-	mdata->entropy = entropy;
-	mdata->flags = 0;
-	if (unlikely(!dlid)) {
-		mdata->flags = OPA_VNIC_SKB_MDATA_ENCAP_ERR;
-		return;
-	}
-
-	opa_vnic_make_header(hdr, info->vport.encap_slid, dlid, len,
-			     info->vesw.pkey, entropy, sc, rc,
-			     OPA_VNIC_L4_ETHR, l4_hdr);
-}
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
deleted file mode 100644
index 012fc27c5c93..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ /dev/null
@@ -1,524 +0,0 @@
-#ifndef _OPA_VNIC_ENCAP_H
-#define _OPA_VNIC_ENCAP_H
-/*
- * Copyright(c) 2017 Intel Corporation.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains all OPA VNIC declaration required for encapsulation
- * and decapsulation of Ethernet packets
- */
-
-#include <linux/types.h>
-#include <rdma/ib_mad.h>
-
-/* EMA class version */
-#define OPA_EMA_CLASS_VERSION               0x80
-
-/*
- * Define the Intel vendor management class for OPA
- * ETHERNET MANAGEMENT
- */
-#define OPA_MGMT_CLASS_INTEL_EMA            0x34
-
-/* EM attribute IDs */
-#define OPA_EM_ATTR_CLASS_PORT_INFO                 0x0001
-#define OPA_EM_ATTR_VESWPORT_INFO                   0x0011
-#define OPA_EM_ATTR_VESWPORT_MAC_ENTRIES            0x0012
-#define OPA_EM_ATTR_IFACE_UCAST_MACS                0x0013
-#define OPA_EM_ATTR_IFACE_MCAST_MACS                0x0014
-#define OPA_EM_ATTR_DELETE_VESW                     0x0015
-#define OPA_EM_ATTR_VESWPORT_SUMMARY_COUNTERS       0x0020
-#define OPA_EM_ATTR_VESWPORT_ERROR_COUNTERS         0x0022
-
-/* VNIC configured and operational state values */
-#define OPA_VNIC_STATE_DROP_ALL        0x1
-#define OPA_VNIC_STATE_FORWARDING      0x3
-
-#define OPA_VESW_MAX_NUM_DEF_PORT   16
-#define OPA_VNIC_MAX_NUM_PCP        8
-
-#define OPA_VNIC_EMA_DATA    (OPA_MGMT_MAD_SIZE - IB_MGMT_VENDOR_HDR)
-
-/* Defines for vendor specific notice(trap) attributes */
-#define OPA_INTEL_EMA_NOTICE_TYPE_INFO 0x04
-
-/* INTEL OUI */
-#define INTEL_OUI_1 0x00
-#define INTEL_OUI_2 0x06
-#define INTEL_OUI_3 0x6a
-
-/* Trap opcodes sent from VNIC */
-#define OPA_VESWPORT_TRAP_IFACE_UCAST_MAC_CHANGE 0x1
-#define OPA_VESWPORT_TRAP_IFACE_MCAST_MAC_CHANGE 0x2
-#define OPA_VESWPORT_TRAP_ETH_LINK_STATUS_CHANGE 0x3
-
-#define OPA_VNIC_DLID_SD_IS_SRC_MAC(dlid_sd)  (!!((dlid_sd) & 0x20))
-#define OPA_VNIC_DLID_SD_GET_DLID(dlid_sd)    ((dlid_sd) >> 8)
-
-/* VNIC Ethernet link status */
-#define OPA_VNIC_ETH_LINK_UP     1
-#define OPA_VNIC_ETH_LINK_DOWN   2
-
-/* routing control */
-#define OPA_VNIC_ENCAP_RC_DEFAULT   0
-#define OPA_VNIC_ENCAP_RC_IPV4      4
-#define OPA_VNIC_ENCAP_RC_IPV4_UDP  8
-#define OPA_VNIC_ENCAP_RC_IPV4_TCP  12
-#define OPA_VNIC_ENCAP_RC_IPV6      16
-#define OPA_VNIC_ENCAP_RC_IPV6_TCP  20
-#define OPA_VNIC_ENCAP_RC_IPV6_UDP  24
-
-#define OPA_VNIC_ENCAP_RC_EXT(w, b) (((w) >> OPA_VNIC_ENCAP_RC_ ## b) & 0x7)
-
-/**
- * struct opa_vesw_info - OPA vnic switch information
- * @fabric_id: 10-bit fabric id
- * @vesw_id: 12-bit virtual ethernet switch id
- * @rsvd0: reserved bytes
- * @def_port_mask: bitmask of default ports
- * @rsvd1: reserved bytes
- * @pkey: partition key
- * @rsvd2: reserved bytes
- * @u_mcast_dlid: unknown multicast dlid
- * @u_ucast_dlid: array of unknown unicast dlids
- * @rsvd3: reserved bytes
- * @rc: routing control
- * @eth_mtu: Ethernet MTU
- * @rsvd4: reserved bytes
- */
-struct opa_vesw_info {
-	__be16  fabric_id;
-	__be16  vesw_id;
-
-	u8      rsvd0[6];
-	__be16  def_port_mask;
-
-	u8      rsvd1[2];
-	__be16  pkey;
-
-	u8      rsvd2[4];
-	__be32  u_mcast_dlid;
-	__be32  u_ucast_dlid[OPA_VESW_MAX_NUM_DEF_PORT];
-
-	__be32  rc;
-
-	u8      rsvd3[56];
-	__be16  eth_mtu;
-	u8      rsvd4[2];
-} __packed;
-
-/**
- * struct opa_per_veswport_info - OPA vnic per port information
- * @port_num: port number
- * @eth_link_status: current ethernet link state
- * @rsvd0: reserved bytes
- * @base_mac_addr: base mac address
- * @config_state: configured port state
- * @oper_state: operational port state
- * @max_mac_tbl_ent: max number of mac table entries
- * @max_smac_ent: max smac entries in mac table
- * @mac_tbl_digest: mac table digest
- * @rsvd1: reserved bytes
- * @encap_slid: base slid for the port
- * @pcp_to_sc_uc: sc by pcp index for unicast ethernet packets
- * @pcp_to_vl_uc: vl by pcp index for unicast ethernet packets
- * @pcp_to_sc_mc: sc by pcp index for multicast ethernet packets
- * @pcp_to_vl_mc: vl by pcp index for multicast ethernet packets
- * @non_vlan_sc_uc: sc for non-vlan unicast ethernet packets
- * @non_vlan_vl_uc: vl for non-vlan unicast ethernet packets
- * @non_vlan_sc_mc: sc for non-vlan multicast ethernet packets
- * @non_vlan_vl_mc: vl for non-vlan multicast ethernet packets
- * @rsvd2: reserved bytes
- * @uc_macs_gen_count: generation count for unicast macs list
- * @mc_macs_gen_count: generation count for multicast macs list
- * @rsvd3: reserved bytes
- */
-struct opa_per_veswport_info {
-	__be32  port_num;
-
-	u8      eth_link_status;
-	u8      rsvd0[3];
-
-	u8      base_mac_addr[ETH_ALEN];
-	u8      config_state;
-	u8      oper_state;
-
-	__be16  max_mac_tbl_ent;
-	__be16  max_smac_ent;
-	__be32  mac_tbl_digest;
-	u8      rsvd1[4];
-
-	__be32  encap_slid;
-
-	u8      pcp_to_sc_uc[OPA_VNIC_MAX_NUM_PCP];
-	u8      pcp_to_vl_uc[OPA_VNIC_MAX_NUM_PCP];
-	u8      pcp_to_sc_mc[OPA_VNIC_MAX_NUM_PCP];
-	u8      pcp_to_vl_mc[OPA_VNIC_MAX_NUM_PCP];
-
-	u8      non_vlan_sc_uc;
-	u8      non_vlan_vl_uc;
-	u8      non_vlan_sc_mc;
-	u8      non_vlan_vl_mc;
-
-	u8      rsvd2[48];
-
-	__be16  uc_macs_gen_count;
-	__be16  mc_macs_gen_count;
-
-	u8      rsvd3[8];
-} __packed;
-
-/**
- * struct opa_veswport_info - OPA vnic port information
- * @vesw: OPA vnic switch information
- * @vport: OPA vnic per port information
- *
- * On host, each of the virtual ethernet ports belongs
- * to a different virtual ethernet switches.
- */
-struct opa_veswport_info {
-	struct opa_vesw_info          vesw;
-	struct opa_per_veswport_info  vport;
-};
-
-/**
- * struct opa_veswport_mactable_entry - single entry in the forwarding table
- * @mac_addr: MAC address
- * @mac_addr_mask: MAC address bit mask
- * @dlid_sd: Matching DLID and side data
- *
- * On the host each virtual ethernet port will have
- * a forwarding table. These tables are used to
- * map a MAC to a LID and other data. For more
- * details see struct opa_veswport_mactable_entries.
- * This is the structure of a single mactable entry
- */
-struct opa_veswport_mactable_entry {
-	u8      mac_addr[ETH_ALEN];
-	u8      mac_addr_mask[ETH_ALEN];
-	__be32  dlid_sd;
-} __packed;
-
-/**
- * struct opa_veswport_mactable - Forwarding table array
- * @offset: mac table starting offset
- * @num_entries: Number of entries to get or set
- * @mac_tbl_digest: mac table digest
- * @tbl_entries: Array of table entries
- *
- * The EM sends down this structure in a MAD indicating
- * the starting offset in the forwarding table that this
- * entry is to be loaded into and the number of entries
- * that that this MAD instance contains
- * The mac_tbl_digest has been added to this MAD structure. It will be set by
- * the EM and it will be used by the EM to check if there are any
- * discrepancies with this value and the value
- * maintained by the EM in the case of VNIC port being deleted or unloaded
- * A new instantiation of a VNIC will always have a value of zero.
- * This value is stored as part of the vnic adapter structure and will be
- * accessed by the GET and SET routines for both the mactable entries and the
- * veswport info.
- */
-struct opa_veswport_mactable {
-	__be16                              offset;
-	__be16                              num_entries;
-	__be32                              mac_tbl_digest;
-	struct opa_veswport_mactable_entry  tbl_entries[];
-} __packed;
-
-/**
- * struct opa_veswport_summary_counters - summary counters
- * @vp_instance: vport instance on the OPA port
- * @vesw_id: virtual ethernet switch id
- * @veswport_num: virtual ethernet switch port number
- * @tx_errors: transmit errors
- * @rx_errors: receive errors
- * @tx_packets: transmit packets
- * @rx_packets: receive packets
- * @tx_bytes: transmit bytes
- * @rx_bytes: receive bytes
- * @tx_unicast: unicast packets transmitted
- * @tx_mcastbcast: multicast/broadcast packets transmitted
- * @tx_untagged: non-vlan packets transmitted
- * @tx_vlan: vlan packets transmitted
- * @tx_64_size: transmit packet length is 64 bytes
- * @tx_65_127: transmit packet length is >=65 and < 127 bytes
- * @tx_128_255: transmit packet length is >=128 and < 255 bytes
- * @tx_256_511: transmit packet length is >=256 and < 511 bytes
- * @tx_512_1023: transmit packet length is >=512 and < 1023 bytes
- * @tx_1024_1518: transmit packet length is >=1024 and < 1518 bytes
- * @tx_1519_max: transmit packet length >= 1519 bytes
- * @rx_unicast: unicast packets received
- * @rx_mcastbcast: multicast/broadcast packets received
- * @rx_untagged: non-vlan packets received
- * @rx_vlan: vlan packets received
- * @rx_64_size: received packet length is 64 bytes
- * @rx_65_127: received packet length is >=65 and < 127 bytes
- * @rx_128_255: received packet length is >=128 and < 255 bytes
- * @rx_256_511: received packet length is >=256 and < 511 bytes
- * @rx_512_1023: received packet length is >=512 and < 1023 bytes
- * @rx_1024_1518: received packet length is >=1024 and < 1518 bytes
- * @rx_1519_max: received packet length >= 1519 bytes
- * @reserved: reserved bytes
- *
- * All the above are counters of corresponding conditions.
- */
-struct opa_veswport_summary_counters {
-	__be16  vp_instance;
-	__be16  vesw_id;
-	__be32  veswport_num;
-
-	__be64  tx_errors;
-	__be64  rx_errors;
-	__be64  tx_packets;
-	__be64  rx_packets;
-	__be64  tx_bytes;
-	__be64  rx_bytes;
-
-	__be64  tx_unicast;
-	__be64  tx_mcastbcast;
-
-	__be64  tx_untagged;
-	__be64  tx_vlan;
-
-	__be64  tx_64_size;
-	__be64  tx_65_127;
-	__be64  tx_128_255;
-	__be64  tx_256_511;
-	__be64  tx_512_1023;
-	__be64  tx_1024_1518;
-	__be64  tx_1519_max;
-
-	__be64  rx_unicast;
-	__be64  rx_mcastbcast;
-
-	__be64  rx_untagged;
-	__be64  rx_vlan;
-
-	__be64  rx_64_size;
-	__be64  rx_65_127;
-	__be64  rx_128_255;
-	__be64  rx_256_511;
-	__be64  rx_512_1023;
-	__be64  rx_1024_1518;
-	__be64  rx_1519_max;
-
-	__be64  reserved[16];
-} __packed;
-
-/**
- * struct opa_veswport_error_counters - error counters
- * @vp_instance: vport instance on the OPA port
- * @vesw_id: virtual ethernet switch id
- * @veswport_num: virtual ethernet switch port number
- * @tx_errors: transmit errors
- * @rx_errors: receive errors
- * @rsvd0: reserved bytes
- * @tx_smac_filt: smac filter errors
- * @rsvd1: reserved bytes
- * @rsvd2: reserved bytes
- * @rsvd3: reserved bytes
- * @tx_dlid_zero: transmit packets with invalid dlid
- * @rsvd4: reserved bytes
- * @tx_logic: other transmit errors
- * @rsvd5: reserved bytes
- * @tx_drop_state: packet tansmission in non-forward port state
- * @rx_bad_veswid: received packet with invalid vesw id
- * @rsvd6: reserved bytes
- * @rx_runt: received ethernet packet with length < 64 bytes
- * @rx_oversize: received ethernet packet with length > MTU size
- * @rsvd7: reserved bytes
- * @rx_eth_down: received packets when interface is down
- * @rx_drop_state: received packets in non-forwarding port state
- * @rx_logic: other receive errors
- * @rsvd8: reserved bytes
- * @rsvd9: reserved bytes
- *
- * All the above are counters of corresponding error conditions.
- */
-struct opa_veswport_error_counters {
-	__be16  vp_instance;
-	__be16  vesw_id;
-	__be32  veswport_num;
-
-	__be64  tx_errors;
-	__be64  rx_errors;
-
-	__be64  rsvd0;
-	__be64  tx_smac_filt;
-	__be64  rsvd1;
-	__be64  rsvd2;
-	__be64  rsvd3;
-	__be64  tx_dlid_zero;
-	__be64  rsvd4;
-	__be64  tx_logic;
-	__be64  rsvd5;
-	__be64  tx_drop_state;
-
-	__be64  rx_bad_veswid;
-	__be64  rsvd6;
-	__be64  rx_runt;
-	__be64  rx_oversize;
-	__be64  rsvd7;
-	__be64  rx_eth_down;
-	__be64  rx_drop_state;
-	__be64  rx_logic;
-	__be64  rsvd8;
-
-	__be64  rsvd9[16];
-} __packed;
-
-/**
- * struct opa_veswport_trap - Trap message sent to EM by VNIC
- * @fabric_id: 10 bit fabric id
- * @veswid: 12 bit virtual ethernet switch id
- * @veswportnum: logical port number on the Virtual switch
- * @opaportnum: physical port num (redundant on host)
- * @veswportindex: switch port index on opa port 0 based
- * @opcode: operation
- * @reserved: 32 bit for alignment
- *
- * The VNIC will send trap messages to the Ethernet manager to
- * inform it about changes to the VNIC config, behaviour etc.
- * This is the format of the trap payload.
- */
-struct opa_veswport_trap {
-	__be16  fabric_id;
-	__be16  veswid;
-	__be32  veswportnum;
-	__be16  opaportnum;
-	u8      veswportindex;
-	u8      opcode;
-	__be32  reserved;
-} __packed;
-
-/**
- * struct opa_vnic_iface_mac_entry - single entry in the mac list
- * @mac_addr: MAC address
- */
-struct opa_vnic_iface_mac_entry {
-	u8 mac_addr[ETH_ALEN];
-};
-
-/**
- * struct opa_veswport_iface_macs - Msg to set globally administered MAC
- * @start_idx: position of first entry (0 based)
- * @num_macs_in_msg: number of MACs in this message
- * @tot_macs_in_lst: The total number of MACs the agent has
- * @gen_count: gen_count to indicate change
- * @entry: The mac list entry
- *
- * Same attribute IDS and attribute modifiers as in locally administered
- * addresses used to set globally administered addresses
- */
-struct opa_veswport_iface_macs {
-	__be16 start_idx;
-	__be16 num_macs_in_msg;
-	__be16 tot_macs_in_lst;
-	__be16 gen_count;
-	struct opa_vnic_iface_mac_entry entry[];
-} __packed;
-
-/**
- * struct opa_vnic_vema_mad - Generic VEMA MAD
- * @mad_hdr: Generic MAD header
- * @rmpp_hdr: RMPP header for vendor specific MADs
- * @reserved: reserved bytes
- * @oui: Unique org identifier
- * @data: MAD data
- */
-struct opa_vnic_vema_mad {
-	struct ib_mad_hdr  mad_hdr;
-	struct ib_rmpp_hdr rmpp_hdr;
-	u8                 reserved;
-	u8                 oui[3];
-	u8                 data[OPA_VNIC_EMA_DATA];
-};
-
-/**
- * struct opa_vnic_notice_attr - Generic Notice MAD
- * @gen_type: Generic/Specific bit and type of notice
- * @oui_1: Vendor ID byte 1
- * @oui_2: Vendor ID byte 2
- * @oui_3: Vendor ID byte 3
- * @trap_num: Trap number
- * @toggle_count: Notice toggle bit and count value
- * @issuer_lid: Trap issuer's lid
- * @reserved: reserved bytes
- * @issuer_gid: Issuer GID (only if Report method)
- * @raw_data: Trap message body
- */
-struct opa_vnic_notice_attr {
-	u8     gen_type;
-	u8     oui_1;
-	u8     oui_2;
-	u8     oui_3;
-	__be16 trap_num;
-	__be16 toggle_count;
-	__be32 issuer_lid;
-	__be32 reserved;
-	u8     issuer_gid[16];
-	u8     raw_data[64];
-} __packed;
-
-/**
- * struct opa_vnic_vema_mad_trap - Generic VEMA MAD Trap
- * @mad_hdr: Generic MAD header
- * @rmpp_hdr: RMPP header for vendor specific MADs
- * @reserved: reserved bytes
- * @oui: Unique org identifier
- * @notice: Notice structure
- */
-struct opa_vnic_vema_mad_trap {
-	struct ib_mad_hdr            mad_hdr;
-	struct ib_rmpp_hdr           rmpp_hdr;
-	u8                           reserved;
-	u8                           oui[3];
-	struct opa_vnic_notice_attr  notice;
-};
-
-#endif /* _OPA_VNIC_ENCAP_H */
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
deleted file mode 100644
index 316959940d2f..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * Copyright(c) 2017 Intel Corporation.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains OPA VNIC ethtool functions
- */
-
-#include <linux/ethtool.h>
-
-#include "opa_vnic_internal.h"
-
-enum {NETDEV_STATS, VNIC_STATS};
-
-struct vnic_stats {
-	char stat_string[ETH_GSTRING_LEN];
-	struct {
-		int sizeof_stat;
-		int stat_offset;
-	};
-};
-
-#define VNIC_STAT(m)            { sizeof_field(struct opa_vnic_stats, m),   \
-				  offsetof(struct opa_vnic_stats, m) }
-
-static struct vnic_stats vnic_gstrings_stats[] = {
-	/* NETDEV stats */
-	{"rx_packets", VNIC_STAT(netstats.rx_packets)},
-	{"tx_packets", VNIC_STAT(netstats.tx_packets)},
-	{"rx_bytes", VNIC_STAT(netstats.rx_bytes)},
-	{"tx_bytes", VNIC_STAT(netstats.tx_bytes)},
-	{"rx_errors", VNIC_STAT(netstats.rx_errors)},
-	{"tx_errors", VNIC_STAT(netstats.tx_errors)},
-	{"rx_dropped", VNIC_STAT(netstats.rx_dropped)},
-	{"tx_dropped", VNIC_STAT(netstats.tx_dropped)},
-
-	/* SUMMARY counters */
-	{"tx_unicast", VNIC_STAT(tx_grp.unicast)},
-	{"tx_mcastbcast", VNIC_STAT(tx_grp.mcastbcast)},
-	{"tx_untagged", VNIC_STAT(tx_grp.untagged)},
-	{"tx_vlan", VNIC_STAT(tx_grp.vlan)},
-
-	{"tx_64_size", VNIC_STAT(tx_grp.s_64)},
-	{"tx_65_127", VNIC_STAT(tx_grp.s_65_127)},
-	{"tx_128_255", VNIC_STAT(tx_grp.s_128_255)},
-	{"tx_256_511", VNIC_STAT(tx_grp.s_256_511)},
-	{"tx_512_1023", VNIC_STAT(tx_grp.s_512_1023)},
-	{"tx_1024_1518", VNIC_STAT(tx_grp.s_1024_1518)},
-	{"tx_1519_max", VNIC_STAT(tx_grp.s_1519_max)},
-
-	{"rx_unicast", VNIC_STAT(rx_grp.unicast)},
-	{"rx_mcastbcast", VNIC_STAT(rx_grp.mcastbcast)},
-	{"rx_untagged", VNIC_STAT(rx_grp.untagged)},
-	{"rx_vlan", VNIC_STAT(rx_grp.vlan)},
-
-	{"rx_64_size", VNIC_STAT(rx_grp.s_64)},
-	{"rx_65_127", VNIC_STAT(rx_grp.s_65_127)},
-	{"rx_128_255", VNIC_STAT(rx_grp.s_128_255)},
-	{"rx_256_511", VNIC_STAT(rx_grp.s_256_511)},
-	{"rx_512_1023", VNIC_STAT(rx_grp.s_512_1023)},
-	{"rx_1024_1518", VNIC_STAT(rx_grp.s_1024_1518)},
-	{"rx_1519_max", VNIC_STAT(rx_grp.s_1519_max)},
-
-	/* ERROR counters */
-	{"rx_fifo_errors", VNIC_STAT(netstats.rx_fifo_errors)},
-	{"rx_length_errors", VNIC_STAT(netstats.rx_length_errors)},
-
-	{"tx_fifo_errors", VNIC_STAT(netstats.tx_fifo_errors)},
-	{"tx_carrier_errors", VNIC_STAT(netstats.tx_carrier_errors)},
-
-	{"tx_dlid_zero", VNIC_STAT(tx_dlid_zero)},
-	{"tx_drop_state", VNIC_STAT(tx_drop_state)},
-	{"rx_drop_state", VNIC_STAT(rx_drop_state)},
-	{"rx_oversize", VNIC_STAT(rx_oversize)},
-	{"rx_runt", VNIC_STAT(rx_runt)},
-};
-
-#define VNIC_STATS_LEN  ARRAY_SIZE(vnic_gstrings_stats)
-
-/* vnic_get_drvinfo - get driver info */
-static void vnic_get_drvinfo(struct net_device *netdev,
-			     struct ethtool_drvinfo *drvinfo)
-{
-	strscpy(drvinfo->driver, opa_vnic_driver_name, sizeof(drvinfo->driver));
-	strscpy(drvinfo->bus_info, dev_name(netdev->dev.parent),
-		sizeof(drvinfo->bus_info));
-}
-
-/* vnic_get_sset_count - get string set count */
-static int vnic_get_sset_count(struct net_device *netdev, int sset)
-{
-	return (sset == ETH_SS_STATS) ? VNIC_STATS_LEN : -EOPNOTSUPP;
-}
-
-/* vnic_get_ethtool_stats - get statistics */
-static void vnic_get_ethtool_stats(struct net_device *netdev,
-				   struct ethtool_stats *stats, u64 *data)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	struct opa_vnic_stats vstats;
-	int i;
-
-	memset(&vstats, 0, sizeof(vstats));
-	spin_lock(&adapter->stats_lock);
-	adapter->rn_ops->ndo_get_stats64(netdev, &vstats.netstats);
-	spin_unlock(&adapter->stats_lock);
-	for (i = 0; i < VNIC_STATS_LEN; i++) {
-		char *p = (char *)&vstats + vnic_gstrings_stats[i].stat_offset;
-
-		data[i] = (vnic_gstrings_stats[i].sizeof_stat ==
-			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-	}
-}
-
-/* vnic_get_strings - get strings */
-static void vnic_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
-{
-	int i;
-
-	if (stringset != ETH_SS_STATS)
-		return;
-
-	for (i = 0; i < VNIC_STATS_LEN; i++)
-		ethtool_puts(&data, vnic_gstrings_stats[i].stat_string);
-}
-
-/* ethtool ops */
-static const struct ethtool_ops opa_vnic_ethtool_ops = {
-	.get_drvinfo = vnic_get_drvinfo,
-	.get_link = ethtool_op_get_link,
-	.get_strings = vnic_get_strings,
-	.get_sset_count = vnic_get_sset_count,
-	.get_ethtool_stats = vnic_get_ethtool_stats,
-};
-
-/* opa_vnic_set_ethtool_ops - set ethtool ops */
-void opa_vnic_set_ethtool_ops(struct net_device *netdev)
-{
-	netdev->ethtool_ops = &opa_vnic_ethtool_ops;
-}
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
deleted file mode 100644
index dd942dd642bd..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
+++ /dev/null
@@ -1,329 +0,0 @@
-#ifndef _OPA_VNIC_INTERNAL_H
-#define _OPA_VNIC_INTERNAL_H
-/*
- * Copyright(c) 2017 Intel Corporation.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains OPA VNIC driver internal declarations
- */
-
-#include <linux/bitops.h>
-#include <linux/etherdevice.h>
-#include <linux/hashtable.h>
-#include <linux/sizes.h>
-#include <rdma/opa_vnic.h>
-
-#include "opa_vnic_encap.h"
-
-#define OPA_VNIC_VLAN_PCP(vlan_tci)  \
-			(((vlan_tci) & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT)
-
-/* Flow to default port redirection table size */
-#define OPA_VNIC_FLOW_TBL_SIZE    32
-
-/* Invalid port number */
-#define OPA_VNIC_INVALID_PORT     0xff
-
-struct opa_vnic_adapter;
-
-/*
- * struct __opa_vesw_info - OPA vnic virtual switch info
- *
- * Same as opa_vesw_info without bitwise attribute.
- */
-struct __opa_vesw_info {
-	u16  fabric_id;
-	u16  vesw_id;
-
-	u8   rsvd0[6];
-	u16  def_port_mask;
-
-	u8   rsvd1[2];
-	u16  pkey;
-
-	u8   rsvd2[4];
-	u32  u_mcast_dlid;
-	u32  u_ucast_dlid[OPA_VESW_MAX_NUM_DEF_PORT];
-
-	u32  rc;
-
-	u8   rsvd3[56];
-	u16  eth_mtu;
-	u8   rsvd4[2];
-} __packed;
-
-/*
- * struct __opa_per_veswport_info - OPA vnic per port info
- *
- * Same as opa_per_veswport_info without bitwise attribute.
- */
-struct __opa_per_veswport_info {
-	u32  port_num;
-
-	u8   eth_link_status;
-	u8   rsvd0[3];
-
-	u8   base_mac_addr[ETH_ALEN];
-	u8   config_state;
-	u8   oper_state;
-
-	u16  max_mac_tbl_ent;
-	u16  max_smac_ent;
-	u32  mac_tbl_digest;
-	u8   rsvd1[4];
-
-	u32  encap_slid;
-
-	u8   pcp_to_sc_uc[OPA_VNIC_MAX_NUM_PCP];
-	u8   pcp_to_vl_uc[OPA_VNIC_MAX_NUM_PCP];
-	u8   pcp_to_sc_mc[OPA_VNIC_MAX_NUM_PCP];
-	u8   pcp_to_vl_mc[OPA_VNIC_MAX_NUM_PCP];
-
-	u8   non_vlan_sc_uc;
-	u8   non_vlan_vl_uc;
-	u8   non_vlan_sc_mc;
-	u8   non_vlan_vl_mc;
-
-	u8   rsvd2[48];
-
-	u16  uc_macs_gen_count;
-	u16  mc_macs_gen_count;
-
-	u8   rsvd3[8];
-} __packed;
-
-/*
- * struct __opa_veswport_info - OPA vnic port info
- *
- * Same as opa_veswport_info without bitwise attribute.
- */
-struct __opa_veswport_info {
-	struct __opa_vesw_info            vesw;
-	struct __opa_per_veswport_info    vport;
-};
-
-/*
- * struct __opa_veswport_trap - OPA vnic trap info
- *
- * Same as opa_veswport_trap without bitwise attribute.
- */
-struct __opa_veswport_trap {
-	u16	fabric_id;
-	u16	veswid;
-	u32	veswportnum;
-	u16	opaportnum;
-	u8	veswportindex;
-	u8	opcode;
-	u32	reserved;
-} __packed;
-
-/**
- * struct opa_vnic_ctrl_port - OPA virtual NIC control port
- * @ibdev: pointer to ib device
- * @ops: opa vnic control operations
- * @num_ports: number of opa ports
- */
-struct opa_vnic_ctrl_port {
-	struct ib_device           *ibdev;
-	struct opa_vnic_ctrl_ops   *ops;
-	u8                          num_ports;
-};
-
-/**
- * struct opa_vnic_adapter - OPA VNIC netdev private data structure
- * @netdev: pointer to associated netdev
- * @ibdev: ib device
- * @cport: pointer to opa vnic control port
- * @rn_ops: rdma netdev's net_device_ops
- * @port_num: OPA port number
- * @vport_num: vesw port number
- * @lock: adapter lock
- * @info: virtual ethernet switch port information
- * @vema_mac_addr: mac address configured by vema
- * @umac_hash: unicast maclist hash
- * @mmac_hash: multicast maclist hash
- * @mactbl: hash table of MAC entries
- * @mactbl_lock: mac table lock
- * @stats_lock: statistics lock
- * @flow_tbl: flow to default port redirection table
- * @trap_timeout: trap timeout
- * @trap_count: no. of traps allowed within timeout period
- */
-struct opa_vnic_adapter {
-	struct net_device             *netdev;
-	struct ib_device              *ibdev;
-	struct opa_vnic_ctrl_port     *cport;
-	const struct net_device_ops   *rn_ops;
-
-	u8 port_num;
-	u8 vport_num;
-
-	/* Lock used around concurrent updates to netdev */
-	struct mutex lock;
-
-	struct __opa_veswport_info  info;
-	u8                          vema_mac_addr[ETH_ALEN];
-	u32                         umac_hash;
-	u32                         mmac_hash;
-	struct hlist_head  __rcu   *mactbl;
-
-	/* Lock used to protect updates to mac table */
-	struct mutex mactbl_lock;
-
-	/* Lock used to protect access to vnic counters */
-	spinlock_t stats_lock;
-
-	u8 flow_tbl[OPA_VNIC_FLOW_TBL_SIZE];
-
-	unsigned long trap_timeout;
-	u8            trap_count;
-};
-
-/* Same as opa_veswport_mactable_entry, but without bitwise attribute */
-struct __opa_vnic_mactable_entry {
-	u8  mac_addr[ETH_ALEN];
-	u8  mac_addr_mask[ETH_ALEN];
-	u32 dlid_sd;
-} __packed;
-
-/**
- * struct opa_vnic_mac_tbl_node - OPA VNIC mac table node
- * @hlist: hash list handle
- * @index: index of entry in the mac table
- * @entry: entry in the table
- */
-struct opa_vnic_mac_tbl_node {
-	struct hlist_node                    hlist;
-	u16                                  index;
-	struct __opa_vnic_mactable_entry     entry;
-};
-
-#define v_dbg(format, arg...) \
-	netdev_dbg(adapter->netdev, format, ## arg)
-#define v_err(format, arg...) \
-	netdev_err(adapter->netdev, format, ## arg)
-#define v_info(format, arg...) \
-	netdev_info(adapter->netdev, format, ## arg)
-#define v_warn(format, arg...) \
-	netdev_warn(adapter->netdev, format, ## arg)
-
-#define c_err(format, arg...) \
-	dev_err(&cport->ibdev->dev, format, ## arg)
-#define c_info(format, arg...) \
-	dev_info(&cport->ibdev->dev, format, ## arg)
-#define c_dbg(format, arg...) \
-	dev_dbg(&cport->ibdev->dev, format, ## arg)
-
-/* The maximum allowed entries in the mac table */
-#define OPA_VNIC_MAC_TBL_MAX_ENTRIES  2048
-/* Limit of smac entries in mac table */
-#define OPA_VNIC_MAX_SMAC_LIMIT       256
-
-/* The last octet of the MAC address is used as the key to the hash table */
-#define OPA_VNIC_MAC_HASH_IDX         5
-
-/* The VNIC MAC hash table is of size 2^8 */
-#define OPA_VNIC_MAC_TBL_HASH_BITS    8
-#define OPA_VNIC_MAC_TBL_SIZE  BIT(OPA_VNIC_MAC_TBL_HASH_BITS)
-
-/* VNIC HASH MACROS */
-#define vnic_hash_init(hashtable) __hash_init(hashtable, OPA_VNIC_MAC_TBL_SIZE)
-
-#define vnic_hash_add(hashtable, node, key)                                   \
-	hlist_add_head(node,                                                  \
-		&hashtable[hash_min(key, ilog2(OPA_VNIC_MAC_TBL_SIZE))])
-
-#define vnic_hash_for_each_safe(name, bkt, tmp, obj, member)                  \
-	for ((bkt) = 0, obj = NULL;                                           \
-		    !obj && (bkt) < OPA_VNIC_MAC_TBL_SIZE; (bkt)++)           \
-		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
-
-#define vnic_hash_for_each_possible(name, obj, member, key)                   \
-	hlist_for_each_entry(obj,                                             \
-		&name[hash_min(key, ilog2(OPA_VNIC_MAC_TBL_SIZE))], member)
-
-#define vnic_hash_for_each(name, bkt, obj, member)                            \
-	for ((bkt) = 0, obj = NULL;                                           \
-		    !obj && (bkt) < OPA_VNIC_MAC_TBL_SIZE; (bkt)++)           \
-		hlist_for_each_entry(obj, &name[bkt], member)
-
-extern char opa_vnic_driver_name[];
-
-struct opa_vnic_adapter *opa_vnic_add_netdev(struct ib_device *ibdev,
-					     u8 port_num, u8 vport_num);
-void opa_vnic_rem_netdev(struct opa_vnic_adapter *adapter);
-void opa_vnic_encap_skb(struct opa_vnic_adapter *adapter, struct sk_buff *skb);
-u8 opa_vnic_get_vl(struct opa_vnic_adapter *adapter, struct sk_buff *skb);
-u8 opa_vnic_calc_entropy(struct sk_buff *skb);
-void opa_vnic_process_vema_config(struct opa_vnic_adapter *adapter);
-void opa_vnic_release_mac_tbl(struct opa_vnic_adapter *adapter);
-void opa_vnic_query_mac_tbl(struct opa_vnic_adapter *adapter,
-			    struct opa_veswport_mactable *tbl);
-int opa_vnic_update_mac_tbl(struct opa_vnic_adapter *adapter,
-			    struct opa_veswport_mactable *tbl);
-void opa_vnic_query_ucast_macs(struct opa_vnic_adapter *adapter,
-			       struct opa_veswport_iface_macs *macs);
-void opa_vnic_query_mcast_macs(struct opa_vnic_adapter *adapter,
-			       struct opa_veswport_iface_macs *macs);
-void opa_vnic_get_summary_counters(struct opa_vnic_adapter *adapter,
-				   struct opa_veswport_summary_counters *cntrs);
-void opa_vnic_get_error_counters(struct opa_vnic_adapter *adapter,
-				 struct opa_veswport_error_counters *cntrs);
-void opa_vnic_get_vesw_info(struct opa_vnic_adapter *adapter,
-			    struct opa_vesw_info *info);
-void opa_vnic_set_vesw_info(struct opa_vnic_adapter *adapter,
-			    struct opa_vesw_info *info);
-void opa_vnic_get_per_veswport_info(struct opa_vnic_adapter *adapter,
-				    struct opa_per_veswport_info *info);
-void opa_vnic_set_per_veswport_info(struct opa_vnic_adapter *adapter,
-				    struct opa_per_veswport_info *info);
-void opa_vnic_vema_report_event(struct opa_vnic_adapter *adapter, u8 event);
-void opa_vnic_set_ethtool_ops(struct net_device *netdev);
-void opa_vnic_vema_send_trap(struct opa_vnic_adapter *adapter,
-			     struct __opa_veswport_trap *data, u32 lid);
-
-#endif /* _OPA_VNIC_INTERNAL_H */
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
deleted file mode 100644
index 071f35711468..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
+++ /dev/null
@@ -1,400 +0,0 @@
-/*
- * Copyright(c) 2017 Intel Corporation.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains OPA Virtual Network Interface Controller (VNIC) driver
- * netdev functionality.
- */
-
-#include <linux/if_vlan.h>
-#include <linux/crc32.h>
-
-#include "opa_vnic_internal.h"
-
-#define OPA_TX_TIMEOUT_MS 1000
-
-#define OPA_VNIC_SKB_HEADROOM  \
-			ALIGN((OPA_VNIC_HDR_LEN + OPA_VNIC_SKB_MDATA_LEN), 8)
-
-/* This function is overloaded for opa_vnic specific implementation */
-static void opa_vnic_get_stats64(struct net_device *netdev,
-				 struct rtnl_link_stats64 *stats)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	struct opa_vnic_stats vstats;
-
-	memset(&vstats, 0, sizeof(vstats));
-	spin_lock(&adapter->stats_lock);
-	adapter->rn_ops->ndo_get_stats64(netdev, &vstats.netstats);
-	spin_unlock(&adapter->stats_lock);
-	memcpy(stats, &vstats.netstats, sizeof(*stats));
-}
-
-/* opa_netdev_start_xmit - transmit function */
-static netdev_tx_t opa_netdev_start_xmit(struct sk_buff *skb,
-					 struct net_device *netdev)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-
-	v_dbg("xmit: queue %d skb len %d\n", skb->queue_mapping, skb->len);
-	/* pad to ensure mininum ethernet packet length */
-	if (unlikely(skb->len < ETH_ZLEN)) {
-		if (skb_padto(skb, ETH_ZLEN))
-			return NETDEV_TX_OK;
-
-		skb_put(skb, ETH_ZLEN - skb->len);
-	}
-
-	opa_vnic_encap_skb(adapter, skb);
-	return adapter->rn_ops->ndo_start_xmit(skb, netdev);
-}
-
-static u16 opa_vnic_select_queue(struct net_device *netdev, struct sk_buff *skb,
-				 struct net_device *sb_dev)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	struct opa_vnic_skb_mdata *mdata;
-	int rc;
-
-	/* pass entropy and vl as metadata in skb */
-	mdata = skb_push(skb, sizeof(*mdata));
-	mdata->entropy = opa_vnic_calc_entropy(skb);
-	mdata->vl = opa_vnic_get_vl(adapter, skb);
-	rc = adapter->rn_ops->ndo_select_queue(netdev, skb, sb_dev);
-	skb_pull(skb, sizeof(*mdata));
-	return rc;
-}
-
-static void opa_vnic_update_state(struct opa_vnic_adapter *adapter, bool up)
-{
-	struct __opa_veswport_info *info = &adapter->info;
-
-	mutex_lock(&adapter->lock);
-	/* Operational state can only be DROP_ALL or FORWARDING */
-	if ((info->vport.config_state == OPA_VNIC_STATE_FORWARDING) && up) {
-		info->vport.oper_state = OPA_VNIC_STATE_FORWARDING;
-		info->vport.eth_link_status = OPA_VNIC_ETH_LINK_UP;
-	} else {
-		info->vport.oper_state = OPA_VNIC_STATE_DROP_ALL;
-		info->vport.eth_link_status = OPA_VNIC_ETH_LINK_DOWN;
-	}
-
-	if (info->vport.config_state == OPA_VNIC_STATE_FORWARDING)
-		netif_dormant_off(adapter->netdev);
-	else
-		netif_dormant_on(adapter->netdev);
-	mutex_unlock(&adapter->lock);
-}
-
-/* opa_vnic_process_vema_config - process vema configuration updates */
-void opa_vnic_process_vema_config(struct opa_vnic_adapter *adapter)
-{
-	struct __opa_veswport_info *info = &adapter->info;
-	struct rdma_netdev *rn = netdev_priv(adapter->netdev);
-	u8 port_num[OPA_VESW_MAX_NUM_DEF_PORT] = { 0 };
-	struct net_device *netdev = adapter->netdev;
-	u8 i, port_count = 0;
-	u16 port_mask;
-
-	/* If the base_mac_addr is changed, update the interface mac address */
-	if (memcmp(info->vport.base_mac_addr, adapter->vema_mac_addr,
-		   ARRAY_SIZE(info->vport.base_mac_addr))) {
-		struct sockaddr saddr;
-
-		memcpy(saddr.sa_data, info->vport.base_mac_addr,
-		       ARRAY_SIZE(info->vport.base_mac_addr));
-		mutex_lock(&adapter->lock);
-		eth_commit_mac_addr_change(netdev, &saddr);
-		memcpy(adapter->vema_mac_addr,
-		       info->vport.base_mac_addr, ETH_ALEN);
-		mutex_unlock(&adapter->lock);
-	}
-
-	rn->set_id(netdev, info->vesw.vesw_id);
-
-	/* Handle MTU limit change */
-	rtnl_lock();
-	netdev->max_mtu = max_t(unsigned int, info->vesw.eth_mtu,
-				netdev->min_mtu);
-	if (netdev->mtu > netdev->max_mtu)
-		dev_set_mtu(netdev, netdev->max_mtu);
-	rtnl_unlock();
-
-	/* Update flow to default port redirection table */
-	port_mask = info->vesw.def_port_mask;
-	for (i = 0; i < OPA_VESW_MAX_NUM_DEF_PORT; i++) {
-		if (port_mask & 1)
-			port_num[port_count++] = i;
-		port_mask >>= 1;
-	}
-
-	/*
-	 * Build the flow table. Flow table is required when destination LID
-	 * is not available. Up to OPA_VNIC_FLOW_TBL_SIZE flows supported.
-	 * Each flow need a default port number to get its dlid from the
-	 * u_ucast_dlid array.
-	 */
-	for (i = 0; i < OPA_VNIC_FLOW_TBL_SIZE; i++)
-		adapter->flow_tbl[i] = port_count ? port_num[i % port_count] :
-						    OPA_VNIC_INVALID_PORT;
-
-	/* update state */
-	opa_vnic_update_state(adapter, !!(netdev->flags & IFF_UP));
-}
-
-/*
- * Set the power on default values in adapter's vema interface structure.
- */
-static inline void opa_vnic_set_pod_values(struct opa_vnic_adapter *adapter)
-{
-	adapter->info.vport.max_mac_tbl_ent = OPA_VNIC_MAC_TBL_MAX_ENTRIES;
-	adapter->info.vport.max_smac_ent = OPA_VNIC_MAX_SMAC_LIMIT;
-	adapter->info.vport.config_state = OPA_VNIC_STATE_DROP_ALL;
-	adapter->info.vport.eth_link_status = OPA_VNIC_ETH_LINK_DOWN;
-	adapter->info.vesw.eth_mtu = ETH_DATA_LEN;
-}
-
-/* opa_vnic_set_mac_addr - change mac address */
-static int opa_vnic_set_mac_addr(struct net_device *netdev, void *addr)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	struct sockaddr *sa = addr;
-	int rc;
-
-	if (!memcmp(netdev->dev_addr, sa->sa_data, ETH_ALEN))
-		return 0;
-
-	mutex_lock(&adapter->lock);
-	rc = eth_mac_addr(netdev, addr);
-	mutex_unlock(&adapter->lock);
-	if (rc)
-		return rc;
-
-	adapter->info.vport.uc_macs_gen_count++;
-	opa_vnic_vema_report_event(adapter,
-				   OPA_VESWPORT_TRAP_IFACE_UCAST_MAC_CHANGE);
-	return 0;
-}
-
-/*
- * opa_vnic_mac_send_event - post event on possible mac list exchange
- *  Send trap when digest from uc/mc mac list differs from previous run.
- *  Digest is evaluated similar to how cksum does.
- */
-static void opa_vnic_mac_send_event(struct net_device *netdev, u8 event)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	struct netdev_hw_addr *ha;
-	struct netdev_hw_addr_list *hw_list;
-	u32 *ref_crc;
-	u32 l, crc = 0;
-
-	switch (event) {
-	case OPA_VESWPORT_TRAP_IFACE_UCAST_MAC_CHANGE:
-		hw_list = &netdev->uc;
-		adapter->info.vport.uc_macs_gen_count++;
-		ref_crc = &adapter->umac_hash;
-		break;
-	case OPA_VESWPORT_TRAP_IFACE_MCAST_MAC_CHANGE:
-		hw_list = &netdev->mc;
-		adapter->info.vport.mc_macs_gen_count++;
-		ref_crc = &adapter->mmac_hash;
-		break;
-	default:
-		return;
-	}
-	netdev_hw_addr_list_for_each(ha, hw_list) {
-		crc = crc32_le(crc, ha->addr, ETH_ALEN);
-	}
-	l = netdev_hw_addr_list_count(hw_list) * ETH_ALEN;
-	crc = ~crc32_le(crc, (void *)&l, sizeof(l));
-
-	if (crc != *ref_crc) {
-		*ref_crc = crc;
-		opa_vnic_vema_report_event(adapter, event);
-	}
-}
-
-/* opa_vnic_set_rx_mode - handle uc/mc mac list change */
-static void opa_vnic_set_rx_mode(struct net_device *netdev)
-{
-	opa_vnic_mac_send_event(netdev,
-				OPA_VESWPORT_TRAP_IFACE_UCAST_MAC_CHANGE);
-
-	opa_vnic_mac_send_event(netdev,
-				OPA_VESWPORT_TRAP_IFACE_MCAST_MAC_CHANGE);
-}
-
-/* opa_netdev_open - activate network interface */
-static int opa_netdev_open(struct net_device *netdev)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	int rc;
-
-	rc = adapter->rn_ops->ndo_open(adapter->netdev);
-	if (rc) {
-		v_dbg("open failed %d\n", rc);
-		return rc;
-	}
-
-	/* Update status and send trap */
-	opa_vnic_update_state(adapter, true);
-	opa_vnic_vema_report_event(adapter,
-				   OPA_VESWPORT_TRAP_ETH_LINK_STATUS_CHANGE);
-	return 0;
-}
-
-/* opa_netdev_close - disable network interface */
-static int opa_netdev_close(struct net_device *netdev)
-{
-	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
-	int rc;
-
-	rc = adapter->rn_ops->ndo_stop(adapter->netdev);
-	if (rc) {
-		v_dbg("close failed %d\n", rc);
-		return rc;
-	}
-
-	/* Update status and send trap */
-	opa_vnic_update_state(adapter, false);
-	opa_vnic_vema_report_event(adapter,
-				   OPA_VESWPORT_TRAP_ETH_LINK_STATUS_CHANGE);
-	return 0;
-}
-
-/* netdev ops */
-static const struct net_device_ops opa_netdev_ops = {
-	.ndo_open = opa_netdev_open,
-	.ndo_stop = opa_netdev_close,
-	.ndo_start_xmit = opa_netdev_start_xmit,
-	.ndo_get_stats64 = opa_vnic_get_stats64,
-	.ndo_set_rx_mode = opa_vnic_set_rx_mode,
-	.ndo_select_queue = opa_vnic_select_queue,
-	.ndo_set_mac_address = opa_vnic_set_mac_addr,
-};
-
-/* opa_vnic_add_netdev - create vnic netdev interface */
-struct opa_vnic_adapter *opa_vnic_add_netdev(struct ib_device *ibdev,
-					     u8 port_num, u8 vport_num)
-{
-	struct opa_vnic_adapter *adapter;
-	struct net_device *netdev;
-	struct rdma_netdev *rn;
-	int rc;
-
-	netdev = ibdev->ops.alloc_rdma_netdev(ibdev, port_num,
-					      RDMA_NETDEV_OPA_VNIC,
-					      "veth%d", NET_NAME_UNKNOWN,
-					      ether_setup);
-	if (!netdev)
-		return ERR_PTR(-ENOMEM);
-	else if (IS_ERR(netdev))
-		return ERR_CAST(netdev);
-
-	rn = netdev_priv(netdev);
-	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
-	if (!adapter) {
-		rc = -ENOMEM;
-		goto adapter_err;
-	}
-
-	rn->clnt_priv = adapter;
-	rn->hca = ibdev;
-	rn->port_num = port_num;
-	adapter->netdev = netdev;
-	adapter->ibdev = ibdev;
-	adapter->port_num = port_num;
-	adapter->vport_num = vport_num;
-	adapter->rn_ops = netdev->netdev_ops;
-
-	netdev->netdev_ops = &opa_netdev_ops;
-	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	netdev->hard_header_len += OPA_VNIC_SKB_HEADROOM;
-	mutex_init(&adapter->lock);
-	mutex_init(&adapter->mactbl_lock);
-	spin_lock_init(&adapter->stats_lock);
-
-	SET_NETDEV_DEV(netdev, ibdev->dev.parent);
-
-	opa_vnic_set_ethtool_ops(netdev);
-
-	opa_vnic_set_pod_values(adapter);
-
-	rc = register_netdev(netdev);
-	if (rc)
-		goto netdev_err;
-
-	netif_carrier_off(netdev);
-	netif_dormant_on(netdev);
-	v_info("initialized\n");
-
-	return adapter;
-netdev_err:
-	mutex_destroy(&adapter->lock);
-	mutex_destroy(&adapter->mactbl_lock);
-	kfree(adapter);
-adapter_err:
-	rn->free_rdma_netdev(netdev);
-
-	return ERR_PTR(rc);
-}
-
-/* opa_vnic_rem_netdev - remove vnic netdev interface */
-void opa_vnic_rem_netdev(struct opa_vnic_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct rdma_netdev *rn = netdev_priv(netdev);
-
-	v_info("removing\n");
-	unregister_netdev(netdev);
-	opa_vnic_release_mac_tbl(adapter);
-	mutex_destroy(&adapter->lock);
-	mutex_destroy(&adapter->mactbl_lock);
-	kfree(adapter);
-	rn->free_rdma_netdev(netdev);
-}
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
deleted file mode 100644
index 21c6cea8b1db..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ /dev/null
@@ -1,1056 +0,0 @@
-/*
- * Copyright(c) 2017 Intel Corporation.
- * Copyright(c) 2021 Cornelis Networks.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains OPX Virtual Network Interface Controller (VNIC)
- * Ethernet Management Agent (EMA) driver
- */
-
-#include <linux/module.h>
-#include <linux/xarray.h>
-#include <rdma/ib_addr.h>
-#include <rdma/ib_verbs.h>
-#include <rdma/opa_smi.h>
-#include <rdma/opa_port_info.h>
-
-#include "opa_vnic_internal.h"
-
-char opa_vnic_driver_name[] = "opa_vnic";
-
-/*
- * The trap service level is kept in bits 3 to 7 in the trap_sl_rsvd
- * field in the class port info MAD.
- */
-#define GET_TRAP_SL_FROM_CLASS_PORT_INFO(x)  (((x) >> 3) & 0x1f)
-
-/* Cap trap bursts to a reasonable limit good for normal cases */
-#define OPA_VNIC_TRAP_BURST_LIMIT 4
-
-/*
- * VNIC trap limit timeout.
- * Inverse of cap2_mask response time out (1.0737 secs) = 0.9
- * secs approx IB spec 13.4.6.2.1 PortInfoSubnetTimeout and
- * 13.4.9 Traps.
- */
-#define OPA_VNIC_TRAP_TIMEOUT  ((4096 * (1UL << 18)) / 1000)
-
-#define OPA_VNIC_UNSUP_ATTR  \
-		cpu_to_be16(IB_MGMT_MAD_STATUS_UNSUPPORTED_METHOD_ATTRIB)
-
-#define OPA_VNIC_INVAL_ATTR  \
-		cpu_to_be16(IB_MGMT_MAD_STATUS_INVALID_ATTRIB_VALUE)
-
-#define OPA_VNIC_CLASS_CAP_TRAP   0x1
-
-/* Maximum number of VNIC ports supported */
-#define OPA_VNIC_MAX_NUM_VPORT    255
-
-/**
- * struct opa_vnic_vema_port -- VNIC VEMA port details
- * @cport: pointer to port
- * @mad_agent: pointer to mad agent for port
- * @class_port_info: Class port info information.
- * @tid: Transaction id
- * @port_num: OPA port number
- * @vports: vnic ports
- * @event_handler: ib event handler
- * @lock: adapter interface lock
- */
-struct opa_vnic_vema_port {
-	struct opa_vnic_ctrl_port      *cport;
-	struct ib_mad_agent            *mad_agent;
-	struct opa_class_port_info      class_port_info;
-	u64                             tid;
-	u8                              port_num;
-	struct xarray                   vports;
-	struct ib_event_handler         event_handler;
-
-	/* Lock to query/update network adapter */
-	struct mutex                    lock;
-};
-
-static int opa_vnic_vema_add_one(struct ib_device *device);
-static void opa_vnic_vema_rem_one(struct ib_device *device,
-				  void *client_data);
-
-static struct ib_client opa_vnic_client = {
-	.name   = opa_vnic_driver_name,
-	.add    = opa_vnic_vema_add_one,
-	.remove = opa_vnic_vema_rem_one,
-};
-
-/**
- * vema_get_vport_num -- Get the vnic from the mad
- * @recvd_mad:  Received mad
- *
- * Return: returns value of the vnic port number
- */
-static inline u8 vema_get_vport_num(struct opa_vnic_vema_mad *recvd_mad)
-{
-	return be32_to_cpu(recvd_mad->mad_hdr.attr_mod) & 0xff;
-}
-
-/**
- * vema_get_vport_adapter -- Get vnic port adapter from recvd mad
- * @recvd_mad: received mad
- * @port: ptr to port struct on which MAD was recvd
- *
- * Return: vnic adapter
- */
-static inline struct opa_vnic_adapter *
-vema_get_vport_adapter(struct opa_vnic_vema_mad *recvd_mad,
-		       struct opa_vnic_vema_port *port)
-{
-	u8 vport_num = vema_get_vport_num(recvd_mad);
-
-	return xa_load(&port->vports, vport_num);
-}
-
-/**
- * vema_mac_tbl_req_ok -- Check if mac request has correct values
- * @mac_tbl: mac table
- *
- * This function checks for the validity of the offset and number of
- * entries required.
- *
- * Return: true if offset and num_entries are valid
- */
-static inline bool vema_mac_tbl_req_ok(struct opa_veswport_mactable *mac_tbl)
-{
-	u16 offset, num_entries;
-	u16 req_entries = ((OPA_VNIC_EMA_DATA - sizeof(*mac_tbl)) /
-			   sizeof(mac_tbl->tbl_entries[0]));
-
-	offset = be16_to_cpu(mac_tbl->offset);
-	num_entries = be16_to_cpu(mac_tbl->num_entries);
-
-	return ((num_entries <= req_entries) &&
-		(offset + num_entries <= OPA_VNIC_MAC_TBL_MAX_ENTRIES));
-}
-
-/*
- * Return the power on default values in the port info structure
- * in big endian format as required by MAD.
- */
-static inline void vema_get_pod_values(struct opa_veswport_info *port_info)
-{
-	memset(port_info, 0, sizeof(*port_info));
-	port_info->vport.max_mac_tbl_ent =
-		cpu_to_be16(OPA_VNIC_MAC_TBL_MAX_ENTRIES);
-	port_info->vport.max_smac_ent =
-		cpu_to_be16(OPA_VNIC_MAX_SMAC_LIMIT);
-	port_info->vport.oper_state = OPA_VNIC_STATE_DROP_ALL;
-	port_info->vport.config_state = OPA_VNIC_STATE_DROP_ALL;
-	port_info->vesw.eth_mtu = cpu_to_be16(ETH_DATA_LEN);
-}
-
-/**
- * vema_add_vport -- Add a new vnic port
- * @port: ptr to opa_vnic_vema_port struct
- * @vport_num: vnic port number (to be added)
- *
- * Return a pointer to the vnic adapter structure
- */
-static struct opa_vnic_adapter *vema_add_vport(struct opa_vnic_vema_port *port,
-					       u8 vport_num)
-{
-	struct opa_vnic_ctrl_port *cport = port->cport;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = opa_vnic_add_netdev(cport->ibdev, port->port_num, vport_num);
-	if (!IS_ERR(adapter)) {
-		int rc;
-
-		adapter->cport = cport;
-		rc = xa_insert(&port->vports, vport_num, adapter, GFP_KERNEL);
-		if (rc < 0) {
-			opa_vnic_rem_netdev(adapter);
-			adapter = ERR_PTR(rc);
-		}
-	}
-
-	return adapter;
-}
-
-/**
- * vema_get_class_port_info -- Get class info for port
- * @port:  Port on whic MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- *
- * This function copies the latest class port info value set for the
- * port and stores it for generating traps
- */
-static void vema_get_class_port_info(struct opa_vnic_vema_port *port,
-				     struct opa_vnic_vema_mad *recvd_mad,
-				     struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_class_port_info *port_info;
-
-	port_info = (struct opa_class_port_info *)rsp_mad->data;
-	memcpy(port_info, &port->class_port_info, sizeof(*port_info));
-	port_info->base_version = OPA_MGMT_BASE_VERSION;
-	port_info->class_version = OPA_EMA_CLASS_VERSION;
-
-	/*
-	 * Set capability mask bit indicating agent generates traps,
-	 * and set the maximum number of VNIC ports supported.
-	 */
-	port_info->cap_mask = cpu_to_be16((OPA_VNIC_CLASS_CAP_TRAP |
-					   (OPA_VNIC_MAX_NUM_VPORT << 8)));
-
-	/*
-	 * Since a get routine is always sent by the EM first we
-	 * set the expected response time to
-	 * 4.096 usec * 2^18 == 1.0737 sec here.
-	 */
-	port_info->cap_mask2_resp_time = cpu_to_be32(18);
-}
-
-/**
- * vema_set_class_port_info -- Get class info for port
- * @port:  Port on whic MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- *
- * This function updates the port class info for the specific vnic
- * and sets up the response mad data
- */
-static void vema_set_class_port_info(struct opa_vnic_vema_port *port,
-				     struct opa_vnic_vema_mad *recvd_mad,
-				     struct opa_vnic_vema_mad *rsp_mad)
-{
-	memcpy(&port->class_port_info, recvd_mad->data,
-	       sizeof(port->class_port_info));
-
-	vema_get_class_port_info(port, recvd_mad, rsp_mad);
-}
-
-/**
- * vema_get_veswport_info -- Get veswport info
- * @port:      source port on which MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- */
-static void vema_get_veswport_info(struct opa_vnic_vema_port *port,
-				   struct opa_vnic_vema_mad *recvd_mad,
-				   struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_veswport_info *port_info =
-				  (struct opa_veswport_info *)rsp_mad->data;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (adapter) {
-		memset(port_info, 0, sizeof(*port_info));
-		opa_vnic_get_vesw_info(adapter, &port_info->vesw);
-		opa_vnic_get_per_veswport_info(adapter,
-					       &port_info->vport);
-	} else {
-		vema_get_pod_values(port_info);
-	}
-}
-
-/**
- * vema_set_veswport_info -- Set veswport info
- * @port:      source port on which MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- *
- * This function gets the port class infor for vnic
- */
-static void vema_set_veswport_info(struct opa_vnic_vema_port *port,
-				   struct opa_vnic_vema_mad *recvd_mad,
-				   struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_vnic_ctrl_port *cport = port->cport;
-	struct opa_veswport_info *port_info;
-	struct opa_vnic_adapter *adapter;
-	u8 vport_num;
-
-	vport_num = vema_get_vport_num(recvd_mad);
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (!adapter) {
-		adapter = vema_add_vport(port, vport_num);
-		if (IS_ERR(adapter)) {
-			c_err("failed to add vport %d: %ld\n",
-			      vport_num, PTR_ERR(adapter));
-			goto err_exit;
-		}
-	}
-
-	port_info = (struct opa_veswport_info *)recvd_mad->data;
-	opa_vnic_set_vesw_info(adapter, &port_info->vesw);
-	opa_vnic_set_per_veswport_info(adapter, &port_info->vport);
-
-	/* Process the new config settings */
-	opa_vnic_process_vema_config(adapter);
-
-	vema_get_veswport_info(port, recvd_mad, rsp_mad);
-	return;
-
-err_exit:
-	rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-}
-
-/**
- * vema_get_mac_entries -- Get MAC entries in VNIC MAC table
- * @port:      source port on which MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- *
- * This function gets the MAC entries that are programmed into
- * the VNIC MAC forwarding table. It checks for the validity of
- * the index into the MAC table and the number of entries that
- * are to be retrieved.
- */
-static void vema_get_mac_entries(struct opa_vnic_vema_port *port,
-				 struct opa_vnic_vema_mad *recvd_mad,
-				 struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_veswport_mactable *mac_tbl_in, *mac_tbl_out;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (!adapter) {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-		return;
-	}
-
-	mac_tbl_in = (struct opa_veswport_mactable *)recvd_mad->data;
-	mac_tbl_out = (struct opa_veswport_mactable *)rsp_mad->data;
-
-	if (vema_mac_tbl_req_ok(mac_tbl_in)) {
-		mac_tbl_out->offset = mac_tbl_in->offset;
-		mac_tbl_out->num_entries = mac_tbl_in->num_entries;
-		opa_vnic_query_mac_tbl(adapter, mac_tbl_out);
-	} else {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-	}
-}
-
-/**
- * vema_set_mac_entries -- Set MAC entries in VNIC MAC table
- * @port:      source port on which MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- *
- * This function sets the MAC entries in the VNIC forwarding table
- * It checks for the validity of the index and the number of forwarding
- * table entries to be programmed.
- */
-static void vema_set_mac_entries(struct opa_vnic_vema_port *port,
-				 struct opa_vnic_vema_mad *recvd_mad,
-				 struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_veswport_mactable *mac_tbl;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (!adapter) {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-		return;
-	}
-
-	mac_tbl = (struct opa_veswport_mactable *)recvd_mad->data;
-	if (vema_mac_tbl_req_ok(mac_tbl)) {
-		if (opa_vnic_update_mac_tbl(adapter, mac_tbl))
-			rsp_mad->mad_hdr.status = OPA_VNIC_UNSUP_ATTR;
-	} else {
-		rsp_mad->mad_hdr.status = OPA_VNIC_UNSUP_ATTR;
-	}
-	vema_get_mac_entries(port, recvd_mad, rsp_mad);
-}
-
-/**
- * vema_set_delete_vesw -- Reset VESW info to POD values
- * @port:      source port on which MAD was received
- * @recvd_mad: pointer to the received mad
- * @rsp_mad:   pointer to respose mad
- *
- * This function clears all the fields of veswport info for the requested vesw
- * and sets them back to the power-on default values. It does not delete the
- * vesw.
- */
-static void vema_set_delete_vesw(struct opa_vnic_vema_port *port,
-				 struct opa_vnic_vema_mad *recvd_mad,
-				 struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_veswport_info *port_info =
-				  (struct opa_veswport_info *)rsp_mad->data;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (!adapter) {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-		return;
-	}
-
-	vema_get_pod_values(port_info);
-	opa_vnic_set_vesw_info(adapter, &port_info->vesw);
-	opa_vnic_set_per_veswport_info(adapter, &port_info->vport);
-
-	/* Process the new config settings */
-	opa_vnic_process_vema_config(adapter);
-
-	opa_vnic_release_mac_tbl(adapter);
-
-	vema_get_veswport_info(port, recvd_mad, rsp_mad);
-}
-
-/**
- * vema_get_mac_list -- Get the unicast/multicast macs.
- * @port:      source port on which MAD was received
- * @recvd_mad: Received mad contains fields to set vnic parameters
- * @rsp_mad:   Response mad to be built
- * @attr_id:   Attribute ID indicating multicast or unicast mac list
- */
-static void vema_get_mac_list(struct opa_vnic_vema_port *port,
-			      struct opa_vnic_vema_mad *recvd_mad,
-			      struct opa_vnic_vema_mad *rsp_mad,
-			      u16 attr_id)
-{
-	struct opa_veswport_iface_macs *macs_in, *macs_out;
-	int max_entries = (OPA_VNIC_EMA_DATA - sizeof(*macs_out)) / ETH_ALEN;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (!adapter) {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-		return;
-	}
-
-	macs_in = (struct opa_veswport_iface_macs *)recvd_mad->data;
-	macs_out = (struct opa_veswport_iface_macs *)rsp_mad->data;
-
-	macs_out->start_idx = macs_in->start_idx;
-	if (macs_in->num_macs_in_msg)
-		macs_out->num_macs_in_msg = macs_in->num_macs_in_msg;
-	else
-		macs_out->num_macs_in_msg = cpu_to_be16(max_entries);
-
-	if (attr_id == OPA_EM_ATTR_IFACE_MCAST_MACS)
-		opa_vnic_query_mcast_macs(adapter, macs_out);
-	else
-		opa_vnic_query_ucast_macs(adapter, macs_out);
-}
-
-/**
- * vema_get_summary_counters -- Gets summary counters.
- * @port:      source port on which MAD was received
- * @recvd_mad: Received mad contains fields to set vnic parameters
- * @rsp_mad:   Response mad to be built
- */
-static void vema_get_summary_counters(struct opa_vnic_vema_port *port,
-				      struct opa_vnic_vema_mad *recvd_mad,
-				      struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_veswport_summary_counters *cntrs;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (adapter) {
-		cntrs = (struct opa_veswport_summary_counters *)rsp_mad->data;
-		opa_vnic_get_summary_counters(adapter, cntrs);
-	} else {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-	}
-}
-
-/**
- * vema_get_error_counters -- Gets summary counters.
- * @port:      source port on which MAD was received
- * @recvd_mad: Received mad contains fields to set vnic parameters
- * @rsp_mad:   Response mad to be built
- */
-static void vema_get_error_counters(struct opa_vnic_vema_port *port,
-				    struct opa_vnic_vema_mad *recvd_mad,
-				    struct opa_vnic_vema_mad *rsp_mad)
-{
-	struct opa_veswport_error_counters *cntrs;
-	struct opa_vnic_adapter *adapter;
-
-	adapter = vema_get_vport_adapter(recvd_mad, port);
-	if (adapter) {
-		cntrs = (struct opa_veswport_error_counters *)rsp_mad->data;
-		opa_vnic_get_error_counters(adapter, cntrs);
-	} else {
-		rsp_mad->mad_hdr.status = OPA_VNIC_INVAL_ATTR;
-	}
-}
-
-/**
- * vema_get -- Process received get MAD
- * @port:      source port on which MAD was received
- * @recvd_mad: Received mad
- * @rsp_mad:   Response mad to be built
- */
-static void vema_get(struct opa_vnic_vema_port *port,
-		     struct opa_vnic_vema_mad *recvd_mad,
-		     struct opa_vnic_vema_mad *rsp_mad)
-{
-	u16 attr_id = be16_to_cpu(recvd_mad->mad_hdr.attr_id);
-
-	switch (attr_id) {
-	case OPA_EM_ATTR_CLASS_PORT_INFO:
-		vema_get_class_port_info(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_VESWPORT_INFO:
-		vema_get_veswport_info(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_VESWPORT_MAC_ENTRIES:
-		vema_get_mac_entries(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_IFACE_UCAST_MACS:
-	case OPA_EM_ATTR_IFACE_MCAST_MACS:
-		vema_get_mac_list(port, recvd_mad, rsp_mad, attr_id);
-		break;
-	case OPA_EM_ATTR_VESWPORT_SUMMARY_COUNTERS:
-		vema_get_summary_counters(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_VESWPORT_ERROR_COUNTERS:
-		vema_get_error_counters(port, recvd_mad, rsp_mad);
-		break;
-	default:
-		rsp_mad->mad_hdr.status = OPA_VNIC_UNSUP_ATTR;
-		break;
-	}
-}
-
-/**
- * vema_set -- Process received set MAD
- * @port:      source port on which MAD was received
- * @recvd_mad: Received mad contains fields to set vnic parameters
- * @rsp_mad:   Response mad to be built
- */
-static void vema_set(struct opa_vnic_vema_port *port,
-		     struct opa_vnic_vema_mad *recvd_mad,
-		     struct opa_vnic_vema_mad *rsp_mad)
-{
-	u16 attr_id = be16_to_cpu(recvd_mad->mad_hdr.attr_id);
-
-	switch (attr_id) {
-	case OPA_EM_ATTR_CLASS_PORT_INFO:
-		vema_set_class_port_info(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_VESWPORT_INFO:
-		vema_set_veswport_info(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_VESWPORT_MAC_ENTRIES:
-		vema_set_mac_entries(port, recvd_mad, rsp_mad);
-		break;
-	case OPA_EM_ATTR_DELETE_VESW:
-		vema_set_delete_vesw(port, recvd_mad, rsp_mad);
-		break;
-	default:
-		rsp_mad->mad_hdr.status = OPA_VNIC_UNSUP_ATTR;
-		break;
-	}
-}
-
-/**
- * vema_send -- Send handler for VEMA MAD agent
- * @mad_agent: pointer to the mad agent
- * @mad_wc:    pointer to mad send work completion information
- *
- * Free all the data structures associated with the sent MAD
- */
-static void vema_send(struct ib_mad_agent *mad_agent,
-		      struct ib_mad_send_wc *mad_wc)
-{
-	rdma_destroy_ah(mad_wc->send_buf->ah, RDMA_DESTROY_AH_SLEEPABLE);
-	ib_free_send_mad(mad_wc->send_buf);
-}
-
-/**
- * vema_recv -- Recv handler for VEMA MAD agent
- * @mad_agent: pointer to the mad agent
- * @send_buf: Send buffer if found, else NULL
- * @mad_wc:    pointer to mad send work completion information
- *
- * Handle only set and get methods and respond to other methods
- * as unsupported. Allocate response buffer and address handle
- * for the response MAD.
- */
-static void vema_recv(struct ib_mad_agent *mad_agent,
-		      struct ib_mad_send_buf *send_buf,
-		      struct ib_mad_recv_wc *mad_wc)
-{
-	struct opa_vnic_vema_port *port;
-	struct ib_ah              *ah;
-	struct ib_mad_send_buf    *rsp;
-	struct opa_vnic_vema_mad  *vema_mad;
-
-	if (!mad_wc || !mad_wc->recv_buf.mad)
-		return;
-
-	port = mad_agent->context;
-	ah = ib_create_ah_from_wc(mad_agent->qp->pd, mad_wc->wc,
-				  mad_wc->recv_buf.grh, mad_agent->port_num);
-	if (IS_ERR(ah))
-		goto free_recv_mad;
-
-	rsp = ib_create_send_mad(mad_agent, mad_wc->wc->src_qp,
-				 mad_wc->wc->pkey_index, 0,
-				 IB_MGMT_VENDOR_HDR, OPA_VNIC_EMA_DATA,
-				 GFP_KERNEL, OPA_MGMT_BASE_VERSION);
-	if (IS_ERR(rsp))
-		goto err_rsp;
-
-	rsp->ah = ah;
-	vema_mad = rsp->mad;
-	memcpy(vema_mad, mad_wc->recv_buf.mad, IB_MGMT_VENDOR_HDR);
-	vema_mad->mad_hdr.method = IB_MGMT_METHOD_GET_RESP;
-	vema_mad->mad_hdr.status = 0;
-
-	/* Lock ensures network adapter is not removed */
-	mutex_lock(&port->lock);
-
-	switch (mad_wc->recv_buf.mad->mad_hdr.method) {
-	case IB_MGMT_METHOD_GET:
-		vema_get(port, (struct opa_vnic_vema_mad *)mad_wc->recv_buf.mad,
-			 vema_mad);
-		break;
-	case IB_MGMT_METHOD_SET:
-		vema_set(port, (struct opa_vnic_vema_mad *)mad_wc->recv_buf.mad,
-			 vema_mad);
-		break;
-	default:
-		vema_mad->mad_hdr.status = OPA_VNIC_UNSUP_ATTR;
-		break;
-	}
-	mutex_unlock(&port->lock);
-
-	if (!ib_post_send_mad(rsp, NULL)) {
-		/*
-		 * with post send successful ah and send mad
-		 * will be destroyed in send handler
-		 */
-		goto free_recv_mad;
-	}
-
-	ib_free_send_mad(rsp);
-
-err_rsp:
-	rdma_destroy_ah(ah, RDMA_DESTROY_AH_SLEEPABLE);
-free_recv_mad:
-	ib_free_recv_mad(mad_wc);
-}
-
-/**
- * vema_get_port -- Gets the opa_vnic_vema_port
- * @cport: pointer to control dev
- * @port_num: Port number
- *
- * This function loops through the ports and returns
- * the opa_vnic_vema port structure that is associated
- * with the OPA port number
- *
- * Return: ptr to requested opa_vnic_vema_port strucure
- *         if success, NULL if not
- */
-static struct opa_vnic_vema_port *
-vema_get_port(struct opa_vnic_ctrl_port *cport, u8 port_num)
-{
-	struct opa_vnic_vema_port *port = (void *)cport + sizeof(*cport);
-
-	if (port_num > cport->num_ports)
-		return NULL;
-
-	return port + (port_num - 1);
-}
-
-/**
- * opa_vnic_vema_send_trap -- This function sends a trap to the EM
- * @adapter: pointer to vnic adapter
- * @data: pointer to trap data filled by calling function
- * @lid:  issuers lid (encap_slid from vesw_port_info)
- *
- * This function is called from the VNIC driver to send a trap if there
- * is somethng the EM should be notified about. These events currently
- * are
- * 1) UNICAST INTERFACE MACADDRESS changes
- * 2) MULTICAST INTERFACE MACADDRESS changes
- * 3) ETHERNET LINK STATUS changes
- * While allocating the send mad the remote site qpn used is 1
- * as this is the well known QP.
- *
- */
-void opa_vnic_vema_send_trap(struct opa_vnic_adapter *adapter,
-			     struct __opa_veswport_trap *data, u32 lid)
-{
-	struct opa_vnic_ctrl_port *cport = adapter->cport;
-	struct ib_mad_send_buf *send_buf;
-	struct opa_vnic_vema_port *port;
-	struct ib_device *ibp;
-	struct opa_vnic_vema_mad_trap *trap_mad;
-	struct opa_class_port_info *class;
-	struct rdma_ah_attr ah_attr;
-	struct ib_ah *ah;
-	struct opa_veswport_trap *trap;
-	u32 trap_lid;
-	u16 pkey_idx;
-
-	if (!cport)
-		goto err_exit;
-	ibp = cport->ibdev;
-	port = vema_get_port(cport, data->opaportnum);
-	if (!port || !port->mad_agent)
-		goto err_exit;
-
-	if (time_before(jiffies, adapter->trap_timeout)) {
-		if (adapter->trap_count == OPA_VNIC_TRAP_BURST_LIMIT) {
-			v_warn("Trap rate exceeded\n");
-			goto err_exit;
-		} else {
-			adapter->trap_count++;
-		}
-	} else {
-		adapter->trap_count = 0;
-	}
-
-	class = &port->class_port_info;
-	/* Set up address handle */
-	memset(&ah_attr, 0, sizeof(ah_attr));
-	ah_attr.type = rdma_ah_find_type(ibp, port->port_num);
-	rdma_ah_set_sl(&ah_attr,
-		       GET_TRAP_SL_FROM_CLASS_PORT_INFO(class->trap_sl_rsvd));
-	rdma_ah_set_port_num(&ah_attr, port->port_num);
-	trap_lid = be32_to_cpu(class->trap_lid);
-	/*
-	 * check for trap lid validity, must not be zero
-	 * The trap sink could change after we fashion the MAD but since traps
-	 * are not guaranteed we won't use a lock as anyway the change will take
-	 * place even with locking.
-	 */
-	if (!trap_lid) {
-		c_err("%s: Invalid dlid\n", __func__);
-		goto err_exit;
-	}
-
-	rdma_ah_set_dlid(&ah_attr, trap_lid);
-	ah = rdma_create_ah(port->mad_agent->qp->pd, &ah_attr, 0);
-	if (IS_ERR(ah)) {
-		c_err("%s:Couldn't create new AH = %p\n", __func__, ah);
-		c_err("%s:dlid = %d, sl = %d, port = %d\n", __func__,
-		      rdma_ah_get_dlid(&ah_attr), rdma_ah_get_sl(&ah_attr),
-		      rdma_ah_get_port_num(&ah_attr));
-		goto err_exit;
-	}
-
-	if (ib_find_pkey(ibp, data->opaportnum, IB_DEFAULT_PKEY_FULL,
-			 &pkey_idx) < 0) {
-		c_err("%s:full key not found, defaulting to partial\n",
-		      __func__);
-		if (ib_find_pkey(ibp, data->opaportnum, IB_DEFAULT_PKEY_PARTIAL,
-				 &pkey_idx) < 0)
-			pkey_idx = 1;
-	}
-
-	send_buf = ib_create_send_mad(port->mad_agent, 1, pkey_idx, 0,
-				      IB_MGMT_VENDOR_HDR, IB_MGMT_MAD_DATA,
-				      GFP_ATOMIC, OPA_MGMT_BASE_VERSION);
-	if (IS_ERR(send_buf)) {
-		c_err("%s:Couldn't allocate send buf\n", __func__);
-		goto err_sndbuf;
-	}
-
-	send_buf->ah = ah;
-
-	/* Set up common MAD hdr */
-	trap_mad = send_buf->mad;
-	trap_mad->mad_hdr.base_version = OPA_MGMT_BASE_VERSION;
-	trap_mad->mad_hdr.mgmt_class = OPA_MGMT_CLASS_INTEL_EMA;
-	trap_mad->mad_hdr.class_version = OPA_EMA_CLASS_VERSION;
-	trap_mad->mad_hdr.method = IB_MGMT_METHOD_TRAP;
-	port->tid++;
-	trap_mad->mad_hdr.tid = cpu_to_be64(port->tid);
-	trap_mad->mad_hdr.attr_id = IB_SMP_ATTR_NOTICE;
-
-	/* Set up vendor OUI */
-	trap_mad->oui[0] = INTEL_OUI_1;
-	trap_mad->oui[1] = INTEL_OUI_2;
-	trap_mad->oui[2] = INTEL_OUI_3;
-
-	/* Setup notice attribute portion */
-	trap_mad->notice.gen_type = OPA_INTEL_EMA_NOTICE_TYPE_INFO << 1;
-	trap_mad->notice.oui_1 = INTEL_OUI_1;
-	trap_mad->notice.oui_2 = INTEL_OUI_2;
-	trap_mad->notice.oui_3 = INTEL_OUI_3;
-	trap_mad->notice.issuer_lid = cpu_to_be32(lid);
-
-	/* copy the actual trap data */
-	trap = (struct opa_veswport_trap *)trap_mad->notice.raw_data;
-	trap->fabric_id = cpu_to_be16(data->fabric_id);
-	trap->veswid = cpu_to_be16(data->veswid);
-	trap->veswportnum = cpu_to_be32(data->veswportnum);
-	trap->opaportnum = cpu_to_be16(data->opaportnum);
-	trap->veswportindex = data->veswportindex;
-	trap->opcode = data->opcode;
-
-	/* If successful send set up rate limit timeout else bail */
-	if (ib_post_send_mad(send_buf, NULL)) {
-		ib_free_send_mad(send_buf);
-	} else {
-		if (adapter->trap_count)
-			return;
-		adapter->trap_timeout = jiffies +
-					usecs_to_jiffies(OPA_VNIC_TRAP_TIMEOUT);
-		return;
-	}
-
-err_sndbuf:
-	rdma_destroy_ah(ah, 0);
-err_exit:
-	v_err("Aborting trap\n");
-}
-
-static void opa_vnic_event(struct ib_event_handler *handler,
-			   struct ib_event *record)
-{
-	struct opa_vnic_vema_port *port =
-		container_of(handler, struct opa_vnic_vema_port, event_handler);
-	struct opa_vnic_ctrl_port *cport = port->cport;
-	struct opa_vnic_adapter *adapter;
-	unsigned long index;
-
-	if (record->element.port_num != port->port_num)
-		return;
-
-	c_dbg("OPA_VNIC received event %d on device %s port %d\n",
-	      record->event, dev_name(&record->device->dev),
-	      record->element.port_num);
-
-	if (record->event != IB_EVENT_PORT_ERR &&
-	    record->event != IB_EVENT_PORT_ACTIVE)
-		return;
-
-	xa_for_each(&port->vports, index, adapter) {
-		if (record->event == IB_EVENT_PORT_ACTIVE)
-			netif_carrier_on(adapter->netdev);
-		else
-			netif_carrier_off(adapter->netdev);
-	}
-}
-
-/**
- * vema_unregister -- Unregisters agent
- * @cport: pointer to control port
- *
- * This deletes the registration by VEMA for MADs
- */
-static void vema_unregister(struct opa_vnic_ctrl_port *cport)
-{
-	struct opa_vnic_adapter *adapter;
-	unsigned long index;
-	int i;
-
-	for (i = 1; i <= cport->num_ports; i++) {
-		struct opa_vnic_vema_port *port = vema_get_port(cport, i);
-
-		if (!port->mad_agent)
-			continue;
-
-		/* Lock ensures no MAD is being processed */
-		mutex_lock(&port->lock);
-		xa_for_each(&port->vports, index, adapter)
-			opa_vnic_rem_netdev(adapter);
-		mutex_unlock(&port->lock);
-
-		ib_unregister_mad_agent(port->mad_agent);
-		port->mad_agent = NULL;
-		mutex_destroy(&port->lock);
-		xa_destroy(&port->vports);
-		ib_unregister_event_handler(&port->event_handler);
-	}
-}
-
-/**
- * vema_register -- Registers agent
- * @cport: pointer to control port
- *
- * This function registers the handlers for the VEMA MADs
- *
- * Return: returns 0 on success. non zero otherwise
- */
-static int vema_register(struct opa_vnic_ctrl_port *cport)
-{
-	struct ib_mad_reg_req reg_req = {
-		.mgmt_class = OPA_MGMT_CLASS_INTEL_EMA,
-		.mgmt_class_version = OPA_MGMT_BASE_VERSION,
-		.oui = { INTEL_OUI_1, INTEL_OUI_2, INTEL_OUI_3 }
-	};
-	int i;
-
-	set_bit(IB_MGMT_METHOD_GET, reg_req.method_mask);
-	set_bit(IB_MGMT_METHOD_SET, reg_req.method_mask);
-
-	/* register ib event handler and mad agent for each port on dev */
-	for (i = 1; i <= cport->num_ports; i++) {
-		struct opa_vnic_vema_port *port = vema_get_port(cport, i);
-		int ret;
-
-		port->cport = cport;
-		port->port_num = i;
-
-		INIT_IB_EVENT_HANDLER(&port->event_handler,
-				      cport->ibdev, opa_vnic_event);
-		ib_register_event_handler(&port->event_handler);
-
-		xa_init(&port->vports);
-		mutex_init(&port->lock);
-		port->mad_agent = ib_register_mad_agent(cport->ibdev, i,
-							IB_QPT_GSI, &reg_req,
-							IB_MGMT_RMPP_VERSION,
-							vema_send, vema_recv,
-							port, 0);
-		if (IS_ERR(port->mad_agent)) {
-			ret = PTR_ERR(port->mad_agent);
-			port->mad_agent = NULL;
-			mutex_destroy(&port->lock);
-			vema_unregister(cport);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * opa_vnic_ctrl_config_dev -- This function sends a trap to the EM
- * by way of ib_modify_port to indicate support for ethernet on the
- * fabric.
- * @cport: pointer to control port
- * @en: enable or disable ethernet on fabric support
- */
-static void opa_vnic_ctrl_config_dev(struct opa_vnic_ctrl_port *cport, bool en)
-{
-	struct ib_port_modify pm = { 0 };
-	int i;
-
-	if (en)
-		pm.set_port_cap_mask = OPA_CAP_MASK3_IsEthOnFabricSupported;
-	else
-		pm.clr_port_cap_mask = OPA_CAP_MASK3_IsEthOnFabricSupported;
-
-	for (i = 1; i <= cport->num_ports; i++)
-		ib_modify_port(cport->ibdev, i, IB_PORT_OPA_MASK_CHG, &pm);
-}
-
-/**
- * opa_vnic_vema_add_one -- Handle new ib device
- * @device: ib device pointer
- *
- * Allocate the vnic control port and initialize it.
- */
-static int opa_vnic_vema_add_one(struct ib_device *device)
-{
-	struct opa_vnic_ctrl_port *cport;
-	int rc, size = sizeof(*cport);
-
-	if (!rdma_cap_opa_vnic(device))
-		return -EOPNOTSUPP;
-
-	size += device->phys_port_cnt * sizeof(struct opa_vnic_vema_port);
-	cport = kzalloc(size, GFP_KERNEL);
-	if (!cport)
-		return -ENOMEM;
-
-	cport->num_ports = device->phys_port_cnt;
-	cport->ibdev = device;
-
-	/* Initialize opa vnic management agent (vema) */
-	rc = vema_register(cport);
-	if (!rc)
-		c_info("VNIC client initialized\n");
-
-	ib_set_client_data(device, &opa_vnic_client, cport);
-	opa_vnic_ctrl_config_dev(cport, true);
-	return 0;
-}
-
-/**
- * opa_vnic_vema_rem_one -- Handle ib device removal
- * @device: ib device pointer
- * @client_data: ib client data
- *
- * Uninitialize and free the vnic control port.
- */
-static void opa_vnic_vema_rem_one(struct ib_device *device,
-				  void *client_data)
-{
-	struct opa_vnic_ctrl_port *cport = client_data;
-
-	c_info("removing VNIC client\n");
-	opa_vnic_ctrl_config_dev(cport, false);
-	vema_unregister(cport);
-	kfree(cport);
-}
-
-static int __init opa_vnic_init(void)
-{
-	int rc;
-
-	rc = ib_register_client(&opa_vnic_client);
-	if (rc)
-		pr_err("VNIC driver register failed %d\n", rc);
-
-	return rc;
-}
-module_init(opa_vnic_init);
-
-static void opa_vnic_deinit(void)
-{
-	ib_unregister_client(&opa_vnic_client);
-}
-module_exit(opa_vnic_deinit);
-
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_AUTHOR("Cornelis Networks");
-MODULE_DESCRIPTION("Cornelis OPX Virtual Network driver");
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
deleted file mode 100644
index 292c037aa239..000000000000
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
+++ /dev/null
@@ -1,390 +0,0 @@
-/*
- * Copyright(c) 2017 Intel Corporation.
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains OPA VNIC EMA Interface functions.
- */
-
-#include "opa_vnic_internal.h"
-
-/**
- * opa_vnic_vema_report_event - sent trap to report the specified event
- * @adapter: vnic port adapter
- * @event: event to be reported
- *
- * This function calls vema api to sent a trap for the given event.
- */
-void opa_vnic_vema_report_event(struct opa_vnic_adapter *adapter, u8 event)
-{
-	struct __opa_veswport_info *info = &adapter->info;
-	struct __opa_veswport_trap trap_data;
-
-	trap_data.fabric_id = info->vesw.fabric_id;
-	trap_data.veswid = info->vesw.vesw_id;
-	trap_data.veswportnum = info->vport.port_num;
-	trap_data.opaportnum = adapter->port_num;
-	trap_data.veswportindex = adapter->vport_num;
-	trap_data.opcode = event;
-
-	opa_vnic_vema_send_trap(adapter, &trap_data, info->vport.encap_slid);
-}
-
-/**
- * opa_vnic_get_summary_counters - get summary counters
- * @adapter: vnic port adapter
- * @cntrs: pointer to destination summary counters structure
- *
- * This function populates the summary counters that is maintained by the
- * given adapter to destination address provided.
- */
-void opa_vnic_get_summary_counters(struct opa_vnic_adapter *adapter,
-				   struct opa_veswport_summary_counters *cntrs)
-{
-	struct opa_vnic_stats vstats;
-	__be64 *dst;
-	u64 *src;
-
-	memset(&vstats, 0, sizeof(vstats));
-	spin_lock(&adapter->stats_lock);
-	adapter->rn_ops->ndo_get_stats64(adapter->netdev, &vstats.netstats);
-	spin_unlock(&adapter->stats_lock);
-
-	cntrs->vp_instance = cpu_to_be16(adapter->vport_num);
-	cntrs->vesw_id = cpu_to_be16(adapter->info.vesw.vesw_id);
-	cntrs->veswport_num = cpu_to_be32(adapter->port_num);
-
-	cntrs->tx_errors = cpu_to_be64(vstats.netstats.tx_errors);
-	cntrs->rx_errors = cpu_to_be64(vstats.netstats.rx_errors);
-	cntrs->tx_packets = cpu_to_be64(vstats.netstats.tx_packets);
-	cntrs->rx_packets = cpu_to_be64(vstats.netstats.rx_packets);
-	cntrs->tx_bytes = cpu_to_be64(vstats.netstats.tx_bytes);
-	cntrs->rx_bytes = cpu_to_be64(vstats.netstats.rx_bytes);
-
-	/*
-	 * This loop depends on layout of
-	 * opa_veswport_summary_counters opa_vnic_stats structures.
-	 */
-	for (dst = &cntrs->tx_unicast, src = &vstats.tx_grp.unicast;
-	     dst < &cntrs->reserved[0]; dst++, src++) {
-		*dst = cpu_to_be64(*src);
-	}
-}
-
-/**
- * opa_vnic_get_error_counters - get error counters
- * @adapter: vnic port adapter
- * @cntrs: pointer to destination error counters structure
- *
- * This function populates the error counters that is maintained by the
- * given adapter to destination address provided.
- */
-void opa_vnic_get_error_counters(struct opa_vnic_adapter *adapter,
-				 struct opa_veswport_error_counters *cntrs)
-{
-	struct opa_vnic_stats vstats;
-
-	memset(&vstats, 0, sizeof(vstats));
-	spin_lock(&adapter->stats_lock);
-	adapter->rn_ops->ndo_get_stats64(adapter->netdev, &vstats.netstats);
-	spin_unlock(&adapter->stats_lock);
-
-	cntrs->vp_instance = cpu_to_be16(adapter->vport_num);
-	cntrs->vesw_id = cpu_to_be16(adapter->info.vesw.vesw_id);
-	cntrs->veswport_num = cpu_to_be32(adapter->port_num);
-
-	cntrs->tx_errors = cpu_to_be64(vstats.netstats.tx_errors);
-	cntrs->rx_errors = cpu_to_be64(vstats.netstats.rx_errors);
-	cntrs->tx_dlid_zero = cpu_to_be64(vstats.tx_dlid_zero);
-	cntrs->tx_drop_state = cpu_to_be64(vstats.tx_drop_state);
-	cntrs->tx_logic = cpu_to_be64(vstats.netstats.tx_fifo_errors +
-				      vstats.netstats.tx_carrier_errors);
-
-	cntrs->rx_bad_veswid = cpu_to_be64(vstats.netstats.rx_nohandler);
-	cntrs->rx_runt = cpu_to_be64(vstats.rx_runt);
-	cntrs->rx_oversize = cpu_to_be64(vstats.rx_oversize);
-	cntrs->rx_drop_state = cpu_to_be64(vstats.rx_drop_state);
-	cntrs->rx_logic = cpu_to_be64(vstats.netstats.rx_fifo_errors);
-}
-
-/**
- * opa_vnic_get_vesw_info -- Get the vesw information
- * @adapter: vnic port adapter
- * @info: pointer to destination vesw info structure
- *
- * This function copies the vesw info that is maintained by the
- * given adapter to destination address provided.
- */
-void opa_vnic_get_vesw_info(struct opa_vnic_adapter *adapter,
-			    struct opa_vesw_info *info)
-{
-	struct __opa_vesw_info *src = &adapter->info.vesw;
-	int i;
-
-	info->fabric_id = cpu_to_be16(src->fabric_id);
-	info->vesw_id = cpu_to_be16(src->vesw_id);
-	memcpy(info->rsvd0, src->rsvd0, ARRAY_SIZE(src->rsvd0));
-	info->def_port_mask = cpu_to_be16(src->def_port_mask);
-	memcpy(info->rsvd1, src->rsvd1, ARRAY_SIZE(src->rsvd1));
-	info->pkey = cpu_to_be16(src->pkey);
-
-	memcpy(info->rsvd2, src->rsvd2, ARRAY_SIZE(src->rsvd2));
-	info->u_mcast_dlid = cpu_to_be32(src->u_mcast_dlid);
-	for (i = 0; i < OPA_VESW_MAX_NUM_DEF_PORT; i++)
-		info->u_ucast_dlid[i] = cpu_to_be32(src->u_ucast_dlid[i]);
-
-	info->rc = cpu_to_be32(src->rc);
-
-	memcpy(info->rsvd3, src->rsvd3, ARRAY_SIZE(src->rsvd3));
-	info->eth_mtu = cpu_to_be16(src->eth_mtu);
-	memcpy(info->rsvd4, src->rsvd4, ARRAY_SIZE(src->rsvd4));
-}
-
-/**
- * opa_vnic_set_vesw_info -- Set the vesw information
- * @adapter: vnic port adapter
- * @info: pointer to vesw info structure
- *
- * This function updates the vesw info that is maintained by the
- * given adapter with vesw info provided. Reserved fields are stored
- * and returned back to EM as is.
- */
-void opa_vnic_set_vesw_info(struct opa_vnic_adapter *adapter,
-			    struct opa_vesw_info *info)
-{
-	struct __opa_vesw_info *dst = &adapter->info.vesw;
-	int i;
-
-	dst->fabric_id = be16_to_cpu(info->fabric_id);
-	dst->vesw_id = be16_to_cpu(info->vesw_id);
-	memcpy(dst->rsvd0, info->rsvd0, ARRAY_SIZE(info->rsvd0));
-	dst->def_port_mask = be16_to_cpu(info->def_port_mask);
-	memcpy(dst->rsvd1, info->rsvd1, ARRAY_SIZE(info->rsvd1));
-	dst->pkey = be16_to_cpu(info->pkey);
-
-	memcpy(dst->rsvd2, info->rsvd2, ARRAY_SIZE(info->rsvd2));
-	dst->u_mcast_dlid = be32_to_cpu(info->u_mcast_dlid);
-	for (i = 0; i < OPA_VESW_MAX_NUM_DEF_PORT; i++)
-		dst->u_ucast_dlid[i] = be32_to_cpu(info->u_ucast_dlid[i]);
-
-	dst->rc = be32_to_cpu(info->rc);
-
-	memcpy(dst->rsvd3, info->rsvd3, ARRAY_SIZE(info->rsvd3));
-	dst->eth_mtu = be16_to_cpu(info->eth_mtu);
-	memcpy(dst->rsvd4, info->rsvd4, ARRAY_SIZE(info->rsvd4));
-}
-
-/**
- * opa_vnic_get_per_veswport_info -- Get the vesw per port information
- * @adapter: vnic port adapter
- * @info: pointer to destination vport info structure
- *
- * This function copies the vesw per port info that is maintained by the
- * given adapter to destination address provided.
- * Note that the read only fields are not copied.
- */
-void opa_vnic_get_per_veswport_info(struct opa_vnic_adapter *adapter,
-				    struct opa_per_veswport_info *info)
-{
-	struct __opa_per_veswport_info *src = &adapter->info.vport;
-
-	info->port_num = cpu_to_be32(src->port_num);
-	info->eth_link_status = src->eth_link_status;
-	memcpy(info->rsvd0, src->rsvd0, ARRAY_SIZE(src->rsvd0));
-
-	memcpy(info->base_mac_addr, src->base_mac_addr,
-	       ARRAY_SIZE(info->base_mac_addr));
-	info->config_state = src->config_state;
-	info->oper_state = src->oper_state;
-	info->max_mac_tbl_ent = cpu_to_be16(src->max_mac_tbl_ent);
-	info->max_smac_ent = cpu_to_be16(src->max_smac_ent);
-	info->mac_tbl_digest = cpu_to_be32(src->mac_tbl_digest);
-	memcpy(info->rsvd1, src->rsvd1, ARRAY_SIZE(src->rsvd1));
-
-	info->encap_slid = cpu_to_be32(src->encap_slid);
-	memcpy(info->pcp_to_sc_uc, src->pcp_to_sc_uc,
-	       ARRAY_SIZE(info->pcp_to_sc_uc));
-	memcpy(info->pcp_to_vl_uc, src->pcp_to_vl_uc,
-	       ARRAY_SIZE(info->pcp_to_vl_uc));
-	memcpy(info->pcp_to_sc_mc, src->pcp_to_sc_mc,
-	       ARRAY_SIZE(info->pcp_to_sc_mc));
-	memcpy(info->pcp_to_vl_mc, src->pcp_to_vl_mc,
-	       ARRAY_SIZE(info->pcp_to_vl_mc));
-	info->non_vlan_sc_uc = src->non_vlan_sc_uc;
-	info->non_vlan_vl_uc = src->non_vlan_vl_uc;
-	info->non_vlan_sc_mc = src->non_vlan_sc_mc;
-	info->non_vlan_vl_mc = src->non_vlan_vl_mc;
-	memcpy(info->rsvd2, src->rsvd2, ARRAY_SIZE(src->rsvd2));
-
-	info->uc_macs_gen_count = cpu_to_be16(src->uc_macs_gen_count);
-	info->mc_macs_gen_count = cpu_to_be16(src->mc_macs_gen_count);
-	memcpy(info->rsvd3, src->rsvd3, ARRAY_SIZE(src->rsvd3));
-}
-
-/**
- * opa_vnic_set_per_veswport_info -- Set vesw per port information
- * @adapter: vnic port adapter
- * @info: pointer to vport info structure
- *
- * This function updates the vesw per port info that is maintained by the
- * given adapter with vesw per port info provided. Reserved fields are
- * stored and returned back to EM as is.
- */
-void opa_vnic_set_per_veswport_info(struct opa_vnic_adapter *adapter,
-				    struct opa_per_veswport_info *info)
-{
-	struct __opa_per_veswport_info *dst = &adapter->info.vport;
-
-	dst->port_num = be32_to_cpu(info->port_num);
-	memcpy(dst->rsvd0, info->rsvd0, ARRAY_SIZE(info->rsvd0));
-
-	memcpy(dst->base_mac_addr, info->base_mac_addr,
-	       ARRAY_SIZE(dst->base_mac_addr));
-	dst->config_state = info->config_state;
-	memcpy(dst->rsvd1, info->rsvd1, ARRAY_SIZE(info->rsvd1));
-
-	dst->encap_slid = be32_to_cpu(info->encap_slid);
-	memcpy(dst->pcp_to_sc_uc, info->pcp_to_sc_uc,
-	       ARRAY_SIZE(dst->pcp_to_sc_uc));
-	memcpy(dst->pcp_to_vl_uc, info->pcp_to_vl_uc,
-	       ARRAY_SIZE(dst->pcp_to_vl_uc));
-	memcpy(dst->pcp_to_sc_mc, info->pcp_to_sc_mc,
-	       ARRAY_SIZE(dst->pcp_to_sc_mc));
-	memcpy(dst->pcp_to_vl_mc, info->pcp_to_vl_mc,
-	       ARRAY_SIZE(dst->pcp_to_vl_mc));
-	dst->non_vlan_sc_uc = info->non_vlan_sc_uc;
-	dst->non_vlan_vl_uc = info->non_vlan_vl_uc;
-	dst->non_vlan_sc_mc = info->non_vlan_sc_mc;
-	dst->non_vlan_vl_mc = info->non_vlan_vl_mc;
-	memcpy(dst->rsvd2, info->rsvd2, ARRAY_SIZE(info->rsvd2));
-	memcpy(dst->rsvd3, info->rsvd3, ARRAY_SIZE(info->rsvd3));
-}
-
-/**
- * opa_vnic_query_mcast_macs - query multicast mac list
- * @adapter: vnic port adapter
- * @macs: pointer mac list
- *
- * This function populates the provided mac list with the configured
- * multicast addresses in the adapter.
- */
-void opa_vnic_query_mcast_macs(struct opa_vnic_adapter *adapter,
-			       struct opa_veswport_iface_macs *macs)
-{
-	u16 start_idx, num_macs, idx = 0, count = 0;
-	struct netdev_hw_addr *ha;
-
-	start_idx = be16_to_cpu(macs->start_idx);
-	num_macs = be16_to_cpu(macs->num_macs_in_msg);
-	netdev_for_each_mc_addr(ha, adapter->netdev) {
-		struct opa_vnic_iface_mac_entry *entry = &macs->entry[count];
-
-		if (start_idx > idx++)
-			continue;
-		else if (num_macs == count)
-			break;
-		memcpy(entry, ha->addr, sizeof(*entry));
-		count++;
-	}
-
-	macs->tot_macs_in_lst = cpu_to_be16(netdev_mc_count(adapter->netdev));
-	macs->num_macs_in_msg = cpu_to_be16(count);
-	macs->gen_count = cpu_to_be16(adapter->info.vport.mc_macs_gen_count);
-}
-
-/**
- * opa_vnic_query_ucast_macs - query unicast mac list
- * @adapter: vnic port adapter
- * @macs: pointer mac list
- *
- * This function populates the provided mac list with the configured
- * unicast addresses in the adapter.
- */
-void opa_vnic_query_ucast_macs(struct opa_vnic_adapter *adapter,
-			       struct opa_veswport_iface_macs *macs)
-{
-	u16 start_idx, tot_macs, num_macs, idx = 0, count = 0, em_macs = 0;
-	struct netdev_hw_addr *ha;
-
-	start_idx = be16_to_cpu(macs->start_idx);
-	num_macs = be16_to_cpu(macs->num_macs_in_msg);
-	/* loop through dev_addrs list first */
-	for_each_dev_addr(adapter->netdev, ha) {
-		struct opa_vnic_iface_mac_entry *entry = &macs->entry[count];
-
-		/* Do not include EM specified MAC address */
-		if (!memcmp(adapter->info.vport.base_mac_addr, ha->addr,
-			    ARRAY_SIZE(adapter->info.vport.base_mac_addr))) {
-			em_macs++;
-			continue;
-		}
-
-		if (start_idx > idx++)
-			continue;
-		else if (num_macs == count)
-			break;
-		memcpy(entry, ha->addr, sizeof(*entry));
-		count++;
-	}
-
-	/* loop through uc list */
-	netdev_for_each_uc_addr(ha, adapter->netdev) {
-		struct opa_vnic_iface_mac_entry *entry = &macs->entry[count];
-
-		if (start_idx > idx++)
-			continue;
-		else if (num_macs == count)
-			break;
-		memcpy(entry, ha->addr, sizeof(*entry));
-		count++;
-	}
-
-	tot_macs = netdev_hw_addr_list_count(&adapter->netdev->dev_addrs) +
-		   netdev_uc_count(adapter->netdev) - em_macs;
-	macs->tot_macs_in_lst = cpu_to_be16(tot_macs);
-	macs->num_macs_in_msg = cpu_to_be16(count);
-	macs->gen_count = cpu_to_be16(adapter->info.vport.uc_macs_gen_count);
-}



