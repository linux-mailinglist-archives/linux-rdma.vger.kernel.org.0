Return-Path: <linux-rdma+bounces-4666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E5E965D61
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F22833BB
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1DF17A5B7;
	Fri, 30 Aug 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s7xf8o9u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2F15A85F;
	Fri, 30 Aug 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011524; cv=fail; b=ajLsIDI2g49fAmzQU4LbAFOfztOEUZG8wnMfL6NNvr9Z5Nc+Whg9ouKCrWTuJmQUbMV3DKoiLCSYM2mTggzipLEAmNmTtfr4nfB0j6F9u3ZBFfjZfkeeKD+WNrSRVzIBblqDIC9MJ4HLDQfIxYUJu1yaRsw+6XXIjIH2yNK2GrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011524; c=relaxed/simple;
	bh=x4ruSCMSCXu6sLOlxM1JrPgB/dHDE/vkiq/S56iyJeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aM5uiVG8/Eh75OmqmAJIXBEzqIYz4i4tMdOOl9wNvp0aakFp1ih8+3uw/FazIMltTrFP+RTJuGDXp7qpOAPX9s/GyIlBjW6PKPLhXrOEeKXvW9CZoBDWlqy7DmGFBQKw7nwQk1VSNJw4mDYNUcjUycgLj05CtQllOt9z556cGug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s7xf8o9u; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgswLqYX7uL3srL9PyM5xZn/7jMVGgN22nUVbAQ6RBS5zwxLxMlSbaelJVzf/IyJ+TpxepHNhVIt6vVBL8qlaHzmnELc2UZLmIpwBz8HhtkOnQ7Q7pVvxvPiHWrTrWW3PlPTwQCPm0ZmOAgAL8Kk96SGQdozvqbRmaXmWD0qswkteSgYN9H8xPY7FV1J/DSRuXIiJSkRehDo6+qPUGIeR/d2bbroSlmX5tO8gRX1wWGIFFZhrAFWCKg5bvmsE8Or1NXk4dSWFbc7owDSYRT2aKWwKnTjoS+UDIuCCkkpwwa3d5gqe++Mc88ZMFXDbNlC3ch9pkmBdTbWrJOniMKXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3YbZBqCnvUv1P21/PpAeHNBFO5Z5zZXfIZV9Axb6rc=;
 b=nhBREyWN5Rz9k79kMBG2XVHNiQJFjyxA9VYaIfBG3TKoasj9NySg424U70aixoUl1+Hp75nCteXBH+qWDzH0Pu5WSqxK5/WK51ZqqQs0IZPezeLu095dQ29MxGcKGnz9cANKJjVroznd4WTp32c5IK0MZKbgwNDJR5NaKHLnOFUellI5pJgTrl4oFbFgDJboTS/xqk3RTs6bFWA9fqR4rQ73CV5Y0x7NBkTU8A0E3KbtYEBKOj0N8KzTz74H0HEr0DuTRAGHQM0tUxMEUXGMQPmTDXs6N2PGQzSMF10P1DRbMTy1AHmkColOgRER6NBRrp79uqG6LNgcPXRw39mfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3YbZBqCnvUv1P21/PpAeHNBFO5Z5zZXfIZV9Axb6rc=;
 b=s7xf8o9uNCSsWwquqPP9QeMXGwZFp3z2ZyjWxsywX+2lx4RBj7O7f83WvSQ6FIjQ6zeq0mEhb7IalpMpFsMW2ZaAOR6IFB+spFXiR3zVS2W9k03VkD+12K9NXA+8f/QJx7EI89e7By53AZlpXrXTdu3L2VS6b3bn4/4jSyfgh4bCiau7bwN+mK9b43kX244/xxfSkBmb2K5xpd/5ehFAESpIsvOrvg7aCl4Ee7Q4ne4ROO6rNgqH/98ybvc1A3bnVjntc9ZM8GULeG47znb8XPZvnkDSeqmuErMLFe86pl3Q+jtH/jrK86MFAnwzDipJ1pEH045fZEbLz0Nb+zmKOQ==
Received: from BL1PR13CA0319.namprd13.prod.outlook.com (2603:10b6:208:2c1::24)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 30 Aug
 2024 09:51:59 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::29) by BL1PR13CA0319.outlook.office365.com
 (2603:10b6:208:2c1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 09:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 09:51:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 02:51:48 -0700
Received: from [172.27.34.164] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 02:51:44 -0700
Message-ID: <36b5d976-1fcb-45b9-97dd-19f048997588@nvidia.com>
Date: Fri, 30 Aug 2024 12:51:43 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Mohamed Khalfella
	<mkhalfella@purestorage.com>
CC: <yzhong@purestorage.com>, Shay Drori <shayd@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
 <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 180876a6-960b-4b16-e5f7-08dcc8d96400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1gxTDNIZ2VwMjRuRHBtQkorSm5JZkFCOXF5VlRjaVkrZVZtVE03T3p3ZkpZ?=
 =?utf-8?B?OE1MVUlZRUtQNTNjVmMxV1NrVGV1Nm4rTmRuVHJjOGZwblE1eThwbi85cnha?=
 =?utf-8?B?N3N4b2ZNc3lYczd5M1d5OE55NnlBZUt5T0NTZEZ1U0kxM2Yxa3hGVkgyMmlC?=
 =?utf-8?B?V0xSN0RTeWlJUlI1Ly93WHJ1UjM4anA0anhvSk16WlNSLzNZeXdvZkRWNERu?=
 =?utf-8?B?cWVqa1poUjIxT2VBdnM3dk1qamNQNGVuaDdHYjFSMnlrWWc4a1YxTnBEUTBn?=
 =?utf-8?B?bVd5L2hKM0pWcHdpVDQxMHVhSzd3cDFBL1lpRzVXcmxCQ1JhVlVBRHdjRXlU?=
 =?utf-8?B?UEYzclFwREFLYStwY0ZIbGRUU1RRNmZ4ZXM5Z3N0Wk1zSWYwSFhlcXpQYW95?=
 =?utf-8?B?MlNBZThkRFBmVThnMUxaV2NlTDJhM3pVeHJqSjN0RzJqVlpwVWR2djdCenJO?=
 =?utf-8?B?T0RlSTlmZnNQTTNHL0J4TldRSGJhYmQ5cHJSeVFBdUFJWnl0dk5FVlFSdnN5?=
 =?utf-8?B?VWlnRTI4QVNEMDZqM25lQlhEb1F5dXc0eUJ2QjBUWlZ5SHBuQ2hUUmlHaXdo?=
 =?utf-8?B?YlcvWUhjNGIyYUdJcUFJckdLbmlNdG1YbUZjb1lQYnZrWGtSRm9NODBuZDdY?=
 =?utf-8?B?UU9PMG0ySnNyQmRtUlN6RkpPNEtJbXh1TGQzbVJqaHRqQ1g5NkU1SytaV2t0?=
 =?utf-8?B?RnJ5R0N2cUhsUTBmRndqdWJwMlAvSnl1QzUwYWtkY1R2OWw4VkNPdjdQT0M4?=
 =?utf-8?B?azNjY2x4cGNjbnZNTkh2MWROL0VyZ1c2clFjYnF6NGhlK0NWdTdwTFFZTlRT?=
 =?utf-8?B?dmZvOXl2dHlwYVZzMVBaVTdCZ0VCOFVPWDYwbUxiQUFsdzBlZ2t6NnhwdnNh?=
 =?utf-8?B?QUIzaTJ0aGREM1lncFJBdmkxNk9XMzMwQ29mSDJPYzFrK01COEUvWldQQnZW?=
 =?utf-8?B?aVBhNE1Pd3djVWNPU2Z1am5XeXFQbUdCalhPWVhvcXhpYVMwL1VnNVVwUkph?=
 =?utf-8?B?S1BxUkNDNHFGekxURFc4MVBRaUd1Nk8yUUJsSlV3akJDWERNWEdlNFZhQlFZ?=
 =?utf-8?B?dWRCMGorQnBJWFUxUjN3MEdBRWpKRkVhVGJRdC9rS05zSlpyanRWL0VXSTha?=
 =?utf-8?B?ZlFINElkdUcvMEc4dzNEMzdTQWtIeEEwRlZxVnQ0WjNTczF0WXN2MzdkRFB4?=
 =?utf-8?B?SmlSUVFTczB5Qlo4WjRGZUdaQjFUNVAwV1J5Rnl1dUl0dUxGNkZET0E5NHNB?=
 =?utf-8?B?Tk1aY3dtSUg0OWErZUUvOHNTRkk3K0kzMG9MbHVmRzJKc1JLT1h1NUgvZFJV?=
 =?utf-8?B?TVM4ajNFMzN5WnZxSmk3UG0zanMvWnN6R3ZObU0yUDVPSnlNcDlwV3N2NUdG?=
 =?utf-8?B?YXNuMDkwMzZDVWlJcnNpL25oVUkxTW15VWxSbE8xWTdGbkRjYkdDWHFuZ0Qx?=
 =?utf-8?B?TzN4aUVzZjBBUzc1cGEyRERoMXp2TzU4Ym9sVm0rU0twRldkdjJTM0pCZ3Mx?=
 =?utf-8?B?ODBzMVdrbUVkN3MyVXNxSTdKMElKSHZtUitjajNSUzZrQUVKN0RVR241ZEdL?=
 =?utf-8?B?Ny9KTDdKY0ZNTDdubjFJTzJ6NnZ5RUtkcTdLeFZqS0tRUFcwZXBSOWZUbjlS?=
 =?utf-8?B?amVZSXVJNlgzaHljd3c3UW9DSDV1dDFpSFR0dFlBOTBmME13dTY3R2pBaDRO?=
 =?utf-8?B?Wm5DSk9ranMyODZRQXNjcElFdU00U0gyTi9UVFZlR0JJR2l3czNiZ1FZc0RC?=
 =?utf-8?B?YmhjdW9nYzdxbzVUR0EweVNFYTh0SExxcVVPWnlxVUNhZEtuS2NFYU5uQmdG?=
 =?utf-8?B?cVphckJsbGhaMWRvMmFPdHdjeUYydkJKaWRqc0I3dm9ncDUySiszOEFKR1V3?=
 =?utf-8?B?YjJXbTNwUnlERDAwbkdBdGVyd3I3UzhvT2QwczZuZ0h3VElZNGNNeTY5VlRo?=
 =?utf-8?Q?J4xfnGxn/PN5RlXeZObW6VsQle4BVJZl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:51:58.9444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180876a6-960b-4b16-e5f7-08dcc8d96400
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065



On 8/30/2024 10:08 AM, Przemek Kitszel wrote:

> 
> On 8/30/24 01:58, Mohamed Khalfella wrote:
>> On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
>>> Changes in v2:
>>> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
>>>    usleep_range() should be enough.
>>> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
>>>    iterations.
>>>
>>> v1: 
>>> https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
>>>
>>> Mohamed Khalfella (1):
>>>    net/mlx5: Added cond_resched() to crdump collection
>>>
>>>   drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> -- 
>>> 2.45.2
>>>
>>
>> Some how I missed to add reviewers were on v1 of this patch.
>>
> 
> You did it right, there is need to provide explicit tag, just engaging
> in the discussion is not enough. v2 is fine, so:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
And fixes tag should be:
Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")

Thanks.

