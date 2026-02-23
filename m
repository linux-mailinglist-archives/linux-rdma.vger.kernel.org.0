Return-Path: <linux-rdma+bounces-17065-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENmqOd67nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17065-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:43:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351217D11C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEFC2301A50B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAC3783C9;
	Mon, 23 Feb 2026 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOvkxEq8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066136998B;
	Mon, 23 Feb 2026 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879382; cv=fail; b=Bafaf5aBksGhNU9l/IuoFLVLbXGz2/145dDQHacmzmI/0VFl1OI4U/b9q/rXKbrjDUSKnhUQKEavr4i/S8EzM5oW0lXQcFUx+OF7kkzGE5rcRz8EBPammx33Dn9tCWlN8mgPNuEKC/PaZWqjoor7pGKYL2TcISQVjWTKwVivZ2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879382; c=relaxed/simple;
	bh=Y59Jvh4RmL8d0KJxoWp3jxqlVK2ejHudNymcyeMqkZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RVmtru3PIECwov002t6uqtk8hyKKiojyK9WKorRElJB7XC1oALLnntPheSyhYVLnqWV/BH3fxZx+GGbmeLbOtVQbKO3JDIjU27jh0MXqaT6aHH9KXGWoULmtlt5IjWC0vdZ3xkF09ykZNJ30TUu000EJduLT1oFDLeqPeebaM8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOvkxEq8; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnYNB3FMcQlc85Bpnc4qE13yMc/wNeW6RiQYja4MRVUCpyUo/u7DR64YR3IwQsKjd+bOSAnAE0UTzEfpq8k7G6v36acmTZe+1AriVnEVbVNGkwPoo75tC9IxXFyhAsY/dzPYbXbWvwzsISoAudKz+GSa07HapXz1fUgjYvNnhsfE6hdLZt9SSmwn3YBoxvhKgWRMaS69/ZayT8xycviJ+N3acYi0m+n9HI/PRtwFnPPBIdZVejroL9iOiGr6oorj8FiQLFzv4q8C2JusFDjfvReeLRCPMo46JNb/4EKpVd/z+jy7D8wdwBxognsXdnx/yaa9VQSSdubiailTKc2DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/tLU3TCduRiR10Exlb+N28fwEvA2XERdSsXWSFezJE=;
 b=W9CSjfFXaUHuzCx5sx8uFXgRRRGihP2MAHh2jz8174IaND2rH4stEWG6Oakc/M8zgwJfD5AQETlPFAprDf2VXw5TM+IFXqOG2x20SPgf/D0OGPO4G/Sj2TFmxoiGPN9kNIEgBeeIGVsrXyRUZGbvaMs53XZEQYP1t8XS3Ov7ELgShbHHAuIt3Xv6xapJ+zaR7RKauFx3POwXhnP0lGtfbP+Rjd+E8U+QTxARm9qf0jNtBK8N+xgp033sq/WPVjh7CeorizD8mJHsKbP75yx71Qy5A/HX4hmHGYhMoCdwgyegIpezKBkS6KJ/lQWkOvRHNhLRBdLu4QEDqR8srKsYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/tLU3TCduRiR10Exlb+N28fwEvA2XERdSsXWSFezJE=;
 b=aOvkxEq8k1djwaIvnzfEUNS9Oe+c9uoZj1pzS9Uu7KZEEQ5bb0uem0kbZHv+aVJom/zxkquxA6HWGHj5j/PnIgi7Ak+/Q4+5tkFnMPA3QH636qhbA5CIL61wM3CYtnAdbWTdHFZTArwMymoF2gZ4ldEtn6VtlgAYcy26w7PLQner44aJjAP54tGfHEcotSjVxWryFsNwJsbStf8PIhC2O2ZuGDPWB/268g+/x3kc0i7lyvbuOtNWGbx7JmmDSuS5cYcP1OLR0NjYU1aLIvjBzpP+i+LMehVmJAX7lg8N8+lrO8PxdvfG/1XNOOBM3g3Mi+Z8wfkjFiHGcW2X+iHnUw==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:42:52 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::67) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:42:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:42:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 00/15] net/mlx5e: SHAMPO, Allow high order pages in zerocopy mode
Date: Mon, 23 Feb 2026 22:41:40 +0200
Message-ID: <20260223204155.1783580-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4d8a4c-c60c-4961-c4e0-08de731c1d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NfH8Hm+MSGKXOenKHdg/kAoRofVNEtzMnzfeDXjnxvvVscPs1WIxpwcNnkQL?=
 =?us-ascii?Q?v+qFTcuhoDvLFtekrrivQ72c1olPQW/EQTQKqdaPNIfbvo8jaqEAWE0/BM+E?=
 =?us-ascii?Q?ihy+4w4gejkohcf3IbXP4KliKYfkhRVXxX7l0NM64hrhswIb2A85grdisyom?=
 =?us-ascii?Q?43SP5GiGhubG7m40uqBbbwZe4a6Bgdq7sdgljoEHfEAU/ktMsN0S+zOaZu/O?=
 =?us-ascii?Q?smNQEjw7KoCk1sfI/ttoR/eDHaCJcmei2z2hud5YlRlGlBGxZKQ/dCznrWso?=
 =?us-ascii?Q?TfM+AEV4b0bNt10Wxnb3WSbKdutLRod6EH/VX1qWg/Vaf/XVbXRAInfp8sJH?=
 =?us-ascii?Q?BqKkaVMq5/1D07fXgzURQu2aKlzj6NaRuKGD5azNFEMnbMlMRMI5JGF0tejT?=
 =?us-ascii?Q?1ids9DhP0lIbnPNEnHTXJl/vC2fkv/Knypt3g47K94AIipVGAuxK6yBIhaDr?=
 =?us-ascii?Q?IVg1d4ma4wJreDugbuOvye3flecvWa86GK+AnjJJgU0B8xJgNFyYvEMgK+Kr?=
 =?us-ascii?Q?dInstLOmPT6VF0i2iZQxDOOqvGqEMzEBs12ETLKcUT7kjcxywXrIqCs90dS0?=
 =?us-ascii?Q?EO5WuDmpGvDKLSKyR8OytlLPKlwTglIHG/QgATv0miLfqgzzj18N1P32fvm+?=
 =?us-ascii?Q?3F3K8uxduoWaLf06lL8u6arUjN2pWIciJlVi1MsXoIn5OUEoGk0I2JbxpDXo?=
 =?us-ascii?Q?6bmoxea72Bkk+bbZkJiQRBiBzdLiVrnVNXBg6wt+ervflL1XATlOJTRXYSNF?=
 =?us-ascii?Q?Jk1yXbk1S8VXxSiq2WXc6d4EAdg3e0EXi5KaiswusJi4ffI37gN1N+3EqVxm?=
 =?us-ascii?Q?qVGtrPe7AOsRSkKtm75DJYcB842F/2dNvb52f7Hc7PkAixAlYzMdSeJ6JtaO?=
 =?us-ascii?Q?VASPKJq4D4q317xWGmzy5tFDgv+FviTxDnEq/WcgwxzhXrL7X9b2cykNhCGA?=
 =?us-ascii?Q?fkWEn9/CdXF9Cv58wTRCOJfLfOFtbXWw3T581ytVwyLkuZytEIa+5UeH9q0+?=
 =?us-ascii?Q?eQsL0IFYXGIBLWhWDvwQF2/rv44bBC6sYSA1rctcDV+2mBQuGsR0JyaTMvR9?=
 =?us-ascii?Q?XR2mz2RcO3exsNlCT9jLFVVDGvCuatAfMZ3HWjGYMB6m9T7gJN803zrLMGys?=
 =?us-ascii?Q?gx3BXlKSezMOIYXY29ZJTQpbT1SKKg6hoE7MIZ3dwtepuDbOPk/9fSBtPfyO?=
 =?us-ascii?Q?AXYSE2tT15spNHiu2XknogWFY41Nrnr8NIBjxHMdcQfZfznqw6MFAUZl/M5R?=
 =?us-ascii?Q?3bYitEel8RBIrqSLe4BqqZmnC34C1Vq+Xr2DWQ4nnkOQvmAIqzQ1UUD5sWLE?=
 =?us-ascii?Q?PS886yzJ/grnm0rCZ0Cc/CustBa9Hlj/r45Y7Ol/fwoOEgiK++8Gmrk2Mhfl?=
 =?us-ascii?Q?zZc2++yRXt/obHUFHCK483v0NbmFWA26YpwF8hnfjLCuaR8oe7IpMvp27coA?=
 =?us-ascii?Q?rKFuZpTuFVcyzfyYm1OxTqFTZ6Vh4WZmyM4/8MLE9u+GjkVKh0lObrr4DKli?=
 =?us-ascii?Q?7GZwPiYHGm0bnOXmPMxwBe1qODKj4SbCLDZGJ5zLVczRoQ4MOv2VUCL6oB48?=
 =?us-ascii?Q?b1UtnTKvm7KpzdbuWhNcalTREEj9VpTvKDAb15zrZeFrYN9/koJMy82UcAlh?=
 =?us-ascii?Q?8jRBkf3VIUNrK0Wdg0n1wodyX2WoJ9Zj48Lt0OZBDlBTxX3dFxfXx2WxP9+u?=
 =?us-ascii?Q?2j/E+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lWLWV/UOHCrE4J6YHrtfDN9U8ZrefRy1R/0mWMFoykBl72g/ZtqJS/c/ewFOucCVi2dzpT6x2pUlBg7cs1fVCfq3YuY5pICT+LOa5TtRzKjwhhTX648S006+xcbrx4zaEa3Kp4+nBxx20dheZKKv6/JjtuydVh2ounch2JGE8ShcuzI3CusBf8HaLyjummHNQpw9ufvpnOJC4t14Fv73G3m2OrzJnz08EutoE8MAkgqfoe7YEEvn/DqSB1MHzgfOYGBXi4MUpSOMm+qnj5IYnhJeOlxt7kSwZR1EeO32a2bi02GwEnujQ4jnOs0D8O07LB9gzFBIB0k2fVX6TGMIS03ViSZJ0QleoF3rKLbcQCy+DNXKCOv7IJ11EtlqBTf69gs0yBM3V8LDzklI/T50KpgpFiIlpMoHfy/jVbPhwpaXDFklPVr/SBagbaDwLkJZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:42:52.1508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d8a4c-c60c-4961-c4e0-08de731c1d6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17065-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7351217D11C
X-Rspamd-Action: no action

Hi,

This series adds support for high order pages when io_uring/devmem
zero copy is used.

See detailed description by Dragos below.

Regards,
Tariq


The first patches are moving code around to allow using queue specific
parameters that are not just for XSK. They are a bit large as they touch
a lot of functions.

The middle part of the series is updating various formulas to remove
remaining hardcoded use of PAGE_SIZE/PAGE_SHIFT.

The last part adds support for high order pages by implementing the
queue configuration functions and allowing larger rx_page_size
configurations when in zero-copy mode.

Results show an increase in BW and a decrease in CPU usage.
The benchmark was done with the zcrx samples from liburing [0].

rx_buf_len=4K, oncpu [1]:
packets=3358832 (MB=820027), rps=55794 (MB/s=13621)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    1.56    0.00   18.09   13.42    0.00   66.80    0.00    0.00    0.00    0.12

rx_buf_len=128K, oncpu [2]:
packets=3781376 (MB=923187), rps=62813 (MB/s=15335)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    0.33    0.00    7.61   18.86    0.00   73.08    0.00    0.00    0.00    0.12

rx_buf_len=4K, offcpu [3]:
packets=3460368 (MB=844816), rps=57481 (MB/s=14033)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    0.00    0.00    0.26    0.00    0.00   92.63    0.00    0.00    0.00    7.11
Average:      11    3.04    0.00   68.09   28.87    0.00    0.00    0.00    0.00    0.00    0.00

rx_buf_len=128K, offcpu [4]:
packets=4119840 (MB=1005820), rps=68435 (MB/s=16707)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    0.00    0.00    0.87    0.00    0.00   63.77    0.00    0.00    0.00   35.36
Average:      11    1.96    0.00   43.68   54.37    0.00    0.00    0.00    0.00    0.00    0.00

[0] https://github.com/isilence/liburing/tree/zcrx/rx-buf-len

[1] commands:
  $> taskset -c 9 ./zcrx 6 -i eth2 -q 9 -A 1 -B 4096 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

[2] commands:
  $> taskset -c 9 ./zcrx 6 -i eth2 -q 9 -A 1 -B 131072 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

[3] commands:
  $> taskset -c 11 ./zcrx 6 -i eth2 -q 9 -A 1 -B 4096 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

[4] commands:
  $> taskset -c 11 ./zcrx 6 -i eth2 -q 9 -A 1 -B 131072 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

Dragos Tatulea (15):
  net/mlx5e: Make mlx5e_rq_param naming consistent
  net/mlx5e: Extract striding rq param calculation in function
  net/mlx5e: Extract max_xsk_wqebbs into its own function
  net/mlx5e: Expose and rename xsk channel parameter function
  net/mlx5e: Alloc xsk channel param out of mlx5e_open_xsk()
  net/mlx5e: Move xsk param into new option container struct
  net/mlx5e: Drop unused channel parameters
  net/mlx5e: SHAMPO, Always calculate page size
  net/mlx5e: Set page_pool order based on calculated page_shift
  net/mlx5e: Alloc rq drop page based on calculated page_shift
  net/mlx5e: RX, Make page frag bias more robust
  net/mlx5e: Add queue config ops for page size
  net/mlx5e: Pass netdev queue config to param calculations
  net/mlx5e: Add param helper to calculate max page size
  net/mlx5e: SHAMPO, Allow high order pages in zerocopy mode

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   9 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   | 415 +++++++++++-------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  45 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/pool.c |  23 +-
 .../mellanox/mlx5/core/en/xsk/setup.c         |  59 +--
 .../mellanox/mlx5/core/en/xsk/setup.h         |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 194 +++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  36 +-
 11 files changed, 502 insertions(+), 297 deletions(-)


base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.44.0


