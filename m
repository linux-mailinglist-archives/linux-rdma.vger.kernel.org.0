Return-Path: <linux-rdma+bounces-15444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFEFD11737
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5473027E33
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FD53469F8;
	Mon, 12 Jan 2026 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KvSOytJL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD13090D5;
	Mon, 12 Jan 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209472; cv=fail; b=gyLUPcTi0Sfowx7wV4dmr/GkOFbGz/cdMVtLoX+qMR+SezSdSgz9RmgwbNsCoSPnvb3PFxDdQKtFOA6HpcqE/v7fEfwpP+kRzsxFI77Hv4NfYaDCcaLphpwjb/swNnCFzHpkdC6FA4MG99NB67h7cs+6zNAE77e0Q91aQTsedl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209472; c=relaxed/simple;
	bh=kpj0yYeJ4Y85WfstiT5Wjbgx9TXJf0e4TSKG5zeX8BA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lcLHQdSRc9e/5eQr2kBEJIMcHCRXoWXkFCXyjZyiX0KqWhHxRPrSE1EJJ8s9vimRy9oBgyf4c3oC2ZNh4UvHwGc0mGH6jSSa+BFIKm5alIr3kWT80v/YirP5UPGdYD2IyjRo9EPVK12gQLqNvc+tr6YytSgzcG4saUHeQO9eV9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KvSOytJL; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuuKwM538F2Xo5MzSjrzMHgH4JwNiEW7W+stXI3thgffJHETSi1+mTYxBoCp6oqxUCVYj41VUTkVXHKHyU4+TGGiO+JNjGkBeUMp9ujTAvm1yI4m+P03xj2VrJKbJgLP3pTBGcQNah8gibQVHfHHHN8WH+ClUBu2jHX7Wam/SFT02/+xylvfxEuJRHjQoixT9Kez/6Cd7v261aOP/rf29NAHJwG/J7LJZqcxVn2kWyqmObv4+NHQbO5ry6OSzpEhtYWYYLkZhOU3VMG0ikZzRycSoFbr5DQXEWySo7OXYaia1BA5RliTbfdrjtZcgc7zDUyBuX1fOfHv1S6C/OlZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myFghWdf3q1V4E7q9MVQYhgsZleu+lSJw3FsIwot38k=;
 b=k/wP2ocMIh6s8aIPPECFbz+7yMyFCcCehyzUe1rTwZvck2FAqCjrdOb8AMUmx162AYFsw0KgOQS2SphtRjYeAKBw9rAmm3/hw/ptoWX0eMxrkJ92+1bxu5FPUiBAtHe5J6JsWOzAe67hK4gZkdN6sM4Z0HftGjXHfupQ6k8nGfQx209fM52WtjQHrcOGrqm5p/ptSju/ZIeRMxCJQf4LHLsFFMfgyh6NNne0Gj1uPQAK025DyCSBNcPUQKAkmSdyud0LQnORQMJIPtM9X7cljYFYlaByIUwvd1vwEvsRDapgoTtvah2rJQ0jh0Y/QrZ0SF8eMtPWYPzIP78A/R8HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myFghWdf3q1V4E7q9MVQYhgsZleu+lSJw3FsIwot38k=;
 b=KvSOytJLlv7H9Tty/mo0GsaUjEEJ5eQOut1TGUU9QkKh6YFb1NpUdariSBMpbCT6tlsi58wOfCcOwf8D/+rOVlqDUoekpRzsynXe8IhEXiZWqnVqEC+5sVjqbL5YnqmBSzbTBt+olBXofBbAb31YqLT0NlzZPU+/wROgx0hPWOePLCPzlYl6My0OE+gMefHaUHDV5sZvauZ/+dNsi/iITEuT+G/vFin/bFWfrRhCh2oWbu0C8SkcWbuYltbPUAvduiWyfGHlejhKeaex3e23oJdocDDbtB326rnxkqsLGWJ4RwG2BnFekfDCpyXX4FAQ4H66AGq3yrkhSroaNzxo1w==
Received: from BLAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:36e::26)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:17:47 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::a9) by BLAPR05CA0011.outlook.office365.com
 (2603:10b6:208:36e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 09:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:17:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:32 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:17:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:17:27 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next V2 0/3] Introduce and use netif_xmit_timeout_ms() helper
Date: Mon, 12 Jan 2026 11:16:20 +0200
Message-ID: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e70a707-d1a4-4846-1093-08de51bb73b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T20rWStzR3pFS2E1SjNuTzdBbXlPWjQ0Zjc3TXdaUTUwOFRYUFNnNmxqc01u?=
 =?utf-8?B?R0JINDdwWTRVOW56OGxzQTI2RHduQjB0ZWdPZVZJTXFoNmw0ZGtpc01yY2xL?=
 =?utf-8?B?UWpyajlyR0JaRGhxcEFHTjZMTnVoM3B4bFUxWHA2RlNyb09NRi9OWEZPNWNh?=
 =?utf-8?B?MzZvYnhjUlg1eWIzaHFkT0FlL1dEaDFVQU54RzNxTDZIUDlDZll0dTJURDhk?=
 =?utf-8?B?Zms0cDhkL2UyT3BoQ3VIbHJwa25lL3p0Z2JKYi81WTY1WTVjeWcrd1FYeHhU?=
 =?utf-8?B?QkhhMDBsMUU1RUZISXI5eFBlUTUxeUZDK01QbUl4M1lIZmYxNzEzWWpaTlNk?=
 =?utf-8?B?QldRSXNxNGhYMjJDMVlqbFAwZnVPVTRJa2FISlZVNmVWdEJBL1F1bGRXd1Rn?=
 =?utf-8?B?SjJHTnNtRlhHY2R3MkoyTjlMQ1VzdjZaaWh5Nk5yMUJKd2psVlppMU16dm9p?=
 =?utf-8?B?MXp5WWg3QmhGcXVQQnBKcTBPVHZNM3RRU1VjRnRPT09PclM2TS9IMHpINWs5?=
 =?utf-8?B?azhFaWEyS2E2MGxTd1BSejJiLysvZ3k2V3FaOXc5YnhYU2NjZVJuNnVPWVZY?=
 =?utf-8?B?WmNocU43Y0tINFM2bU1ObEU1TkpYOHVVVTk5QlRLK1NEajdEWTZUSFdsVnBv?=
 =?utf-8?B?Ymtqb2xtZnhoSEJXajdtanJEcVoyYzhPSE1XUXUrUUV3c3orTldxQWZvdTJa?=
 =?utf-8?B?MmxKSTJRcWVURVpuRmROejlEV0JyTXpwWEpuUlhST05zTy94d1draHVXVldX?=
 =?utf-8?B?aThyM0Q2SVQzQ0xoOFNNWXk4eTZmMkJlQUl3WmNTYkF3Q2lyUVZkWVRTMFFH?=
 =?utf-8?B?a2FXZHo2cnEvMzhhTG41Z21RQVQvWHJiVUFDNlVSOUN1Q3F4aFE4S2I3dmNx?=
 =?utf-8?B?dGhSYlJKelppRjFiOHc1bThCQzZTY1VBMm5pOUtPM1JGdEZoeEsxSTJCV0w1?=
 =?utf-8?B?ejdBTGFwVER5U2JyVXEvcEdFMGRvbkJGalpoRVBhYlRoWnN1SjNUV245WXFy?=
 =?utf-8?B?cTYvbnVuYk5GejNLTmJWRm55d1Q2SDRhYzRyYkFsU1pSNG15Z3JqL0tEekE1?=
 =?utf-8?B?K3B4dEhWSys2Q0ZLbXVzTHdMTW1NZWlyOXpKQlN6VEh5Vi9BOGFSNXZCVnAr?=
 =?utf-8?B?RTdlVjloK2xxY0poT1hEbnc1cmNlZ2c0d3h6NlUrRDBXb3lXTGxRdjQ0amVu?=
 =?utf-8?B?UjQrOHRWRk1heHdaSDVWN3BqWE8yYU1HWHdIWllPK0RpVVJCU1FXelJ2LytB?=
 =?utf-8?B?cTdoc1kxVnpFMFlscGVXQVBrTEw1NFRrNGU4N0d5bHpYb2pzL3lPZ2J4SUdw?=
 =?utf-8?B?NGY3QkZPaHRVUENYOGhpSDQ3dFpSazJlOGthd3F2VGZXTzNKdkcvdmRaQit0?=
 =?utf-8?B?TDFlQjdRYU43YUVrajdZbmJvektYMTR2NkY5U0MvYWRpUjdIZnNvamRmajVZ?=
 =?utf-8?B?amdsRmFtS3ZDUnBQZlowV1pZUG80QnZkR29pcGlHRWRSRlBJRGIyOEYzT1pK?=
 =?utf-8?B?Z09ydmRnaElJaDJyYXcrb01IaTdOMWhZVVpoR3BZVTFBL2hXczFyNnRNczhI?=
 =?utf-8?B?NXA0SVhzb3grL1RHQ2QvMi9URFdmY0RrYTdPeHFlY1JOdUZiWlBvL0t4MFpK?=
 =?utf-8?B?TnFZZ09XS1V5UmtXQjZZM1hsamRDb1VrYks1aThOOFhjbUhCbkIvMXpab09U?=
 =?utf-8?B?ajdaVElZNVMwRG15amVkSEN6ekhIMi9qUmpHaCtNdjNHOW41ZzN0cHBPSmVU?=
 =?utf-8?B?ejNTcm9DdzFEWkF6M05xYU5wWWQ2REw1MHRGRXZldVlwZEg4R3lJZFFISHUz?=
 =?utf-8?B?UmlIRzBjT05oQWsrN1htbUFOd0RMYmMreUxSVnF6UUZoTEwrUEkrdWk5SGhD?=
 =?utf-8?B?dEhNY3lEZmNNZldJd3lrcTQwRHZHN3RvbzM2M2hwd3o2TlNpaUo3cHN6TmlH?=
 =?utf-8?B?SXh2aWZNd2VkeG9DeUMvTkZFb1JZYXVpOE9uTzErRytEMm1PNnZ5YXYyZFRB?=
 =?utf-8?B?Uk01U2JibVFDTFVQL2cxMXlhZXlHL3Nod2NFNnhqRnc4Rnkwa0tvS01uTjlL?=
 =?utf-8?B?TDJ4RHNDaFZVZmRJNE5LRCtVZ3BMU3BLdHJqbkhyZjlwWjBGVzc1bHpOaUtq?=
 =?utf-8?Q?vPmA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:17:47.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e70a707-d1a4-4846-1093-08de51bb73b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069

Hi,

This is V2, find V1 here:
https://lore.kernel.org/all/1764054776-1308696-1-git-send-email-tariqt@nvidia.com/

This series by Shahar introduces a new helper function
netif_xmit_timeout_ms() to check if a TX queue has timed out and report
the timeout duration.
It also encapsulates the check for whether the TX queue is stopped.

Replace duplicated open-coded timeout check in hns3 driver with the new
helper.

For mlx5e, refine the TX timeout recovery flow to act only on SQs whose
transmit timestamp indicates an actual timeout, as determined by the
helper. This prevents unnecessary channel reopen events caused by
attempting recovery on queues that are merely stopped but not truly
timed out.

Regards,
Tariq

V2:
- Rebase.
- Move helper to include/net/netdev_queues.h.
- Remove output paramter trans_start from the new helper.
- Revert the code in dev_watchdog to not use the helper.
- Fix the helper name in commit message.

Shahar Shitrit (3):
  net: Introduce netif_xmit_timeout_ms() helper
  net: hns3: Use netif_xmit_timeout_ms() helper
  net/mlx5e: Refine TX timeout handling to skip non-timed-out SQ

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 12 +++++-------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 include/net/netdev_queues.h                       | 11 +++++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)


base-commit: 60d8484c4cec811f5ceb6550655df74490d1a165
-- 
2.31.1


