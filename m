Return-Path: <linux-rdma+bounces-12278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17121B092BA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B7A5A230C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A8301152;
	Thu, 17 Jul 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yz2YK3wy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54853301148;
	Thu, 17 Jul 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771888; cv=fail; b=ftLBcOa76iidcBwSqP/ntXan8N4Ar4yiLwbIg/e46ke8iM5KzUg8oY4eWwIZHtAcFdrK6tLj+aP5IZi5eMM8xO4KPE2IJob4JQfBOHAUaNS1GJQOUsK9j6OpU5PsDkjBUMNaHe9qNNzkt2aJj36OzylbjFGi+toi/daj6V5060Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771888; c=relaxed/simple;
	bh=WmXQQv2UtdJzZWZdVBllO6IB2bXPg2AMdRzmgAddVws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EMB7QKz91r/2Kd7E2mGfiloHvC5F9TkB67GSTJKNvqmK0b27OF1bCR3Kz6tOapSzyYjkbYMPu2NCj+eNbzshr07dZW5OzHOjEw6+0K7NQ8fm4e+XCdPZiwGYjEliCjvPGAlmqD+qMHCms9BfkVax0bYvblaFsO3KZONjxsBwvlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yz2YK3wy; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKUINbYmPim1O7DZBW3EQpkSMA1Nf5eOpcw9aC0eJHewPGWWSdsYuN6yomYO3Vuo4bWT7BFDQgsLSMk71TEWF/n/LqMgJLwyHKhdf/9apB689BoQemdVBTSM1j9WfIKBjdjmpcvc9sg8QWCQQF5ItTLhnYtC4zKzkhxZX/hrqtmI8oao5Zt27xH/aDgV8UbeErj4wsIeDinJ9KWTatOaPinH3vunYFhnHNN8fYqKPVz5FIrN8wayFGWP7fBwGahMahvBfHwU/+RvCBVwRrhenGx0ll5ko4AYWnVsaqJRmwfSc/xVWq3M0caxn2/pY/Ns0GJ6tmfaZPLKotXIw1VnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RswRWyl15MjPYS8nnVsiecSwperUjVvr21Hor323A6A=;
 b=f7W3w/x2rHLXb9qLSIDA/3QeiflA50l8r88h9zWT4wPKfKAlSoTmKK5XJKOiv0gKHFaDba+Py30PC0hjHluiifPbZY+7JlzTKfdBX6jyqclY2YZ7eeYz0AbR0cUTDa9Elzdu0DS7bzxznmX+mTn+m7LGKbFL4Es32rN/U0UZWv9gIERuTQ2kkq/OC4hCx0fIjXmXXGDNldOHY5XyA1KmERhG0qIWxi2hU3/Vbv+xuULf3PVJDe0f39YUsxvICmhn/9A2lSqxXENt7H6dCj9dzI49yWGE/1pOAy0jgFDyR7cmYwPXVX1HkJmR+P49xip28ej4+kMGED23/Rl2cvp3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RswRWyl15MjPYS8nnVsiecSwperUjVvr21Hor323A6A=;
 b=Yz2YK3wyrDo2SERycabHuN6FqVx55WB17MMQdvLoiHH0EVrYbOFPH7/+EDHFxQdUIWzLi2FLNoDFoR6p+TyICsgzVVExfF1VeEflq9sbeSlGNn5n6877+S7zX/Jhj23Rlo3PToSQ8oCPpiM5IU2ZenyhQouxVle3TVttO5hu4a/cZEd7Sb8ttF6Iga+JmjduCeg/8x4GMSns+3oHyr4aGCGycJXDTrwvckWQoR96IhbZDrvOjspMqQRAVrvqQrpBwcyoRHIm4L2AIiCou0u5//WsIOg+8ey0t1Xf/3/i0+HUdNP9IroLctMF1hDfLcHqb7osfSyw8+Sq5pHMBIZsPA==
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 17:04:43 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::b2) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 17:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 17:04:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 10:04:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 10:04:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 10:04:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/3] net/mlx5: misc changes 2025-07-17
Date: Thu, 17 Jul 2025 20:03:09 +0300
Message-ID: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: d4699b32-58b1-4a9b-4102-08ddc5540662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zng5ZVhpSHVJK3pNeVA5dEpIWUJ4aXJXWFovVDhXMHh5ZDQ3blFhMHlTSTNw?=
 =?utf-8?B?NzlSeW41K3ZHT0J1bVMwRUtwVjBZUGh0aDIyaDBySTlWTndOWlRwQlQ5dE1i?=
 =?utf-8?B?d2FzOFZ6c0JWUFBOVFlzNHlkbmJ3UnZxeHMzZTdGTEY5Vkh0bUt1ZFRHbVVy?=
 =?utf-8?B?UkdUUFZBbkpNS2Nma1ZTcUF5UXVNVUlYaTg3TXB0aHl6WjduYk1pOHNLTlpk?=
 =?utf-8?B?RkZadDNuTTMzWnV0KzVHN1d0cFFHcTc2UE5NSllJYmVJNm9aNUJ0K05Ma3ha?=
 =?utf-8?B?ZVpaQU5zejVWUlIxVmhMRnVUaWhOWTJ6Wm9qMTRjT3NHTHpFYjAyU1p5VFF5?=
 =?utf-8?B?Tk1JVWd6M2xOYmdKMStvZ2ZUUlp3aGR3UEVQWDJXZGR2eUlRZU5MUFNSR3F3?=
 =?utf-8?B?WENVaXI3M2xWdWxEV1kwZEE1c1czc2FYRUhrUTIvNkpDTkcwSEkreDg1N3Qx?=
 =?utf-8?B?MU4xRjRKQ0c4Z2FyTEFwV0k4QzNRZHNrWnptV0Mza1A1Nm9BbVlXOTZOVnV3?=
 =?utf-8?B?ZC9VL3RHb0dFRUg5OHpJUU9CMmFNeS9iTWN0ckhIM2JRTjJOcCtrZUJqY1dx?=
 =?utf-8?B?THNseFRSVjVhYk82Q3NHQnQ4NlZqc2lkRnJ6SUtrLzErN2N4d0xJQlJvazhn?=
 =?utf-8?B?amMvU3RhUGR6dWswSlU0T3dka2dEOGhMVHE3TndRNFlHRWJiSzJTbzkxZUZH?=
 =?utf-8?B?cXp5QmZwb00vdGlFTlh6MU1ySWVBenBWdG5LWUxjRmxsZFEzaDA4dEhHZTZK?=
 =?utf-8?B?OEY3anZFUWwraU45ckN0R2VCSjlKaTF0dmhORWpMeFlua2JDdXBQTEo3cEo3?=
 =?utf-8?B?aFd4RDlCbFZoY0o1dXZCVHU3N0JGMnlZUHU2anNraDgraTgycWlvcDBaRys0?=
 =?utf-8?B?dVBVb0pOK0hONFhhdW53RCtrYm1vcVJDaDJHUWN0enFpWHdjUU1BQTF2UmpC?=
 =?utf-8?B?YTJIZlJCeEZpMms0RS9YNXRwYWVRRHR4OFAxMEZZTnNIRjJsc0c1NGh4T3RH?=
 =?utf-8?B?QWE2enJBMHA3dURHMXhNZXBQeG50VkR6Rzh2Z0wvVUc1VW1WK29KdXNObHJj?=
 =?utf-8?B?bEZCWG12SXZYL1VvK3c4am9xZXQ2UGdlWUQrSmJrLzN5RU1ZazVUT2YvTTBB?=
 =?utf-8?B?bGp6b1F0WnRseFByVjZ4dFRkaHNJOEN6cWJRL0orNzd5ZnR3OUFUVENqazgr?=
 =?utf-8?B?NDJQNFhUanl6YU5DZ2Zub29RWktFM2ZnL21WZTRmRUJ6MHcxMVMwUEl5M01D?=
 =?utf-8?B?dHlMcThQVXdSSk1jemtFaTVrVUtGOCtHc2NHSEsyWCsybkdpQnBYVyt6Z3hx?=
 =?utf-8?B?YmhwdFl3YVdzd3FKSWhybEcxZFJ0RDc0VFI1eDNjQXNvZWhtM0xIRzE1OXR2?=
 =?utf-8?B?aG8rTUZCOW1aVy9YUncwczgyOXpRUi8wN1VDWVlJL2tWS2thaHF2bWNIS1BC?=
 =?utf-8?B?VHR1RDVFYlAwOUFpb0RiV3ZSdHBDQ3JXMFRVV0lrV0hUQy9YMENoWGNrajRB?=
 =?utf-8?B?L1ozclVvRHIyTzJETkZpWXk1QzZEYTZpN3FDWVh4WU1MMUNabmdpRFhmOUhH?=
 =?utf-8?B?M0U0VHdLZ1RYSEx0NWlZM0JuY1FNcDFabGkyTy95V2xEUkF6Q3NId1RBY1U4?=
 =?utf-8?B?V0pnbFA2WUhZT3pZOTBqcWxuaG52MERZY012VXAzNGdLT2RjeldIRER6dXVT?=
 =?utf-8?B?aHNZRHoxYVcwN01TNTlSRnkvNERTV21JUksyM2trNnpBZTVmY0pSSHNOckpm?=
 =?utf-8?B?ZWx4dE1Ed3lNZWhoUHFhY3BLelFxcklMM0RMQjBRczl6b1EwaFNmQVVXeUQ5?=
 =?utf-8?B?L2FrOVdyT0xCc1JFdGYzSFk5S3h0dG5PSnRHcFgyaHU1cnc0cGxCNVVWSnoz?=
 =?utf-8?B?WUZQL040NWNqNUt3dHpZTGU5MWJFOEI3bHJKYTFHNFA5SjZjaUxvVmR3RHBD?=
 =?utf-8?B?TkxBdWtaTGN4SU83aDNDU0hHM0dJUVZkTERrSVpEamZYMFVCL3UyM3o4KzRx?=
 =?utf-8?B?WHJadlJHU0NSeUZaUXNGYWZmTlVxOGRTNEVlYzBTVFdOcnhrL1Y4Yk1BUXFm?=
 =?utf-8?Q?dHLEeU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:04:43.0018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4699b32-58b1-4a9b-4102-08ddc5540662
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Hi,

This series contains misc enhancements to the mlx5 driver.

Regards,
Tariq

Alexandre Cassen (1):
  net/mlx5e: Support routed networks during IPsec MACs initialization

Feng Liu (1):
  net/mlx5e: Expose TIS via devlink tx reporter diagnose

Shay Drory (1):
  net/mlx5: Allocate cpu_mask on heap to fix frame size warning for
    large NR_CPUS

 .../mellanox/mlx5/core/en/reporter_tx.c       | 25 ++++++
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 82 ++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 19 +++--
 .../mellanox/mlx5/core/irq_affinity.c         | 21 +++--
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 37 ++++++---
 5 files changed, 158 insertions(+), 26 deletions(-)


base-commit: a96cee9b369ee47b5309311d0d71cb6663b123fc
-- 
2.31.1


