Return-Path: <linux-rdma+bounces-13219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B377CB50C4C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 05:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F2D163F1E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 03:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEA25A659;
	Wed, 10 Sep 2025 03:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5cAK7Lb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862331D39C;
	Wed, 10 Sep 2025 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474744; cv=fail; b=E0Pmn+Ln1oPLDC/6WCH1B5Q1PkeqUEEXyhbR7FAj7deJOn5qulaXD4Umex01KpiUes7j8gTMWm3j2uqL13I3nQZzzqkWOuwC3GsMw5S5U/mri5HRZZwKqpPVra6K0Igk7/PiIdkLvp5c5xFYnZTYrhDiijiIo5QTMylGQ64QW98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474744; c=relaxed/simple;
	bh=FEi8oZCT83fUsWm+4Vem/2kl0E0UyM47csU9ozm40q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fFw60hPRi8S/NXnL5eBWeD32kJy2RCMKdJz8ayIc1cNQZzcncHFogWmxCTZPwRkNRJrV9pJpw9PuepbGeKdY2Seh0nOYKll4BHNpl8lrHpPYAkISeEewImJY8MGXKlD8Z+Rut5Nz11jBIZj2xl9zLQJQm3+ZDUFVI2D9BSAbqJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m5cAK7Lb; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CANfAMmbpDR2JwOr4XpRz4f60j2Vb+4SM6p9BiceSQTp3uL8bION8n0oYfbQQS4jqVi6wR17uXN4SBYGd9Z6td5sX4Hh6rQCq+3H81l1J5l+DJrDXY2dszOHQKQlK9rUcOqrn4rPRZSu8enpna8M0duZjp1E4NpCUcWTnLur0POMotdKtc6MFEgiPOzwg08XES6tGFpfuRfGL0tww/S/0z/xog4P5i8ZWW5i4ABsmzEHQ6BGidbjT/flBRmyy9UJJU4f1mnvwlfY5mDmgwIpMRIigp7r7iNGYJgTdWUBK/gHEBqazdm4x6gwNo6EZJNNvGDd/KXPv5NIZjXLlIAhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDXx7GnDEKhUbyv5Shnp1Zw/o9D+lV9ZBlLCKHRs9nw=;
 b=egbog1EGFF0g+0FQ3ZIAlFHPV7NfVVPDMJoB1BqfdZvskNBA+kAYX5AI8675q0f7KMutmufIEXtRNESpThyqdb7oxLUfI4PPwZ3Pe/ZzJXTJczQNcbE3hYDfJD++j00KV+xFD2wOI8pC/iZw3VRMEXbjWZuqDtdlcNhKnIbUQNUPsH3xwuBcsxJKw+4fYtytjxJbqMN7ijSV6knYtasyVbPJ0P/VubpjjdnJ78+cxn8XHRUhkIBlUn1qPo1oNwKKhNoMzHlw+IpU5XWG/8fag0hJuMtSTCSAwGsN/bxy2cZ5shw71sDQcTVwWpeivH+gsdE4AvfB6dSBGpaNZwefCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDXx7GnDEKhUbyv5Shnp1Zw/o9D+lV9ZBlLCKHRs9nw=;
 b=m5cAK7LbBMX/uNmxOYzATbcEA0LYPxIRixM+gGfKGUR+a21u4Ces2QKBTg1Jzc7pG3SK60rOdQQEs3wYwWBrrCDvQI2WuU1uGNj9WT4BbJUIUhPsEX10zmo8oNfcdhrdtGYQUqhRj+XExzDg+8wQFBPObg/LBOfNMgjIMfvOY5h4ehQFK4xvES8L3vcYL6mnwra8LEcytpVWYml0Ky8CbCe3jVg9/C3izcMlywoEk9bVy9j4AtNJUUG4g2cNv14rvRkPQqpWJpGiZ6qe5YS0QWMRfexf4XABpqIOfg+0SAwE4hjXEWGmrkLjpwQSWArqkGtt7hwhOPiPd46OaaBOOQ==
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 10 Sep
 2025 03:25:39 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::b7) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 03:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Wed, 10 Sep 2025 03:25:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 20:25:19 -0700
Received: from [172.29.225.228] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 20:24:15 -0700
Message-ID: <cc776b20-7fc0-4889-be27-29d6fcb3d3ad@nvidia.com>
Date: Wed, 10 Sep 2025 11:23:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against
 device unbind
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-2-git-send-email-tariqt@nvidia.com>
 <20250909182350.3ab98b64@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250909182350.3ab98b64@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afff521-fea6-478c-ca6b-08ddf019b723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHJ2Tm82UFNrQVUvOXFtS0tPdTNrMEhWbUhrejZscmFsL2U3UFVBRSsyM1M1?=
 =?utf-8?B?WnI2K2ZDdDg1VWw4VEpIS0ZxcDRodG5lemp0VVBWK09iQW9xdjJtVDdEa0F4?=
 =?utf-8?B?Mlg0bVNnR2VXQnowL1lTdmhoY2F6ZU9JYitEODB3SWlYdkdWY2RHNjA3UmJ6?=
 =?utf-8?B?YnBVdjljQlFWb3EwcnpVbmZhN0pPdlhja3RtNUJyNFJDaW41V3NZWS9ldFAx?=
 =?utf-8?B?NjhXRW0wc1dXbkFkUGZlU2tRV2thcjZMek92Z0VIb2IwWUFBM3k5dFJBMWEw?=
 =?utf-8?B?anJnVmkvYS9yU2EzQ3dPNnhFdStFVzl2cHNyZHh6VGk0d3JJWXNhSVcrYXdX?=
 =?utf-8?B?UVVkMk1JU04rRlRkTWZIU0UyUEtjZkpnamdaUE1mdzdXbFAreUhzVjdCZENL?=
 =?utf-8?B?VVpXYldxU21JMDR5dVZBcmI4dldvN0VtaUtGSWYxbFpsb0RYUFVuWitYUnRL?=
 =?utf-8?B?L05acUFIV3NrV1pVN0RjS1k2em9BYy9CRng3V1JZYnAvOGRvVnJIdDRrdUdU?=
 =?utf-8?B?TGIzeEhyUGdNcjNtOUp2VDJ1VmRQUGZWbnNPS2ZCVXF6elFBcjNZOWgvdmpz?=
 =?utf-8?B?cDk2UkdicGdQRnExcVVIZHdwSkFjVWV6UGRsS1dWNmc2MHZoL05OamNwQjkr?=
 =?utf-8?B?Y0tzNlpzMHlqUkFSWnpyRUtVbXV3RUdLOTdndWhDQTNEejNwUVB4WXcvNmM3?=
 =?utf-8?B?NVQrSGlLbndzamRTUzk5T0IrdkpFazk3VnpweGhIbWFhTWkxRVlTM2RtWk1W?=
 =?utf-8?B?ckIxNkMyckthNkh3K1poTkIwc0M2TEZoU2VnZUgyV0lHNmppUFNkaWVpUGNL?=
 =?utf-8?B?WXpJZThmQW53UGQzbThkSjRtZjdacTZjV0tCZkJVQWQxandNdU01MFpqcUNj?=
 =?utf-8?B?WU5adk9xTTl2NGxoL3V2MFBYdUFIVWdCRENINXZyY2VYOFNBeHRxQlR1YXNT?=
 =?utf-8?B?T1RTd1JkM245a3h0eStmbVVjNUNxakt4UG5IbWRTWkEwSnlPU1lWL2lFZUtW?=
 =?utf-8?B?Nms0NnI3YU5YSkVvL2lKVXY0WXI0U1JLU2E4S25WZHg4UVI0Z3lFM1NWNHM5?=
 =?utf-8?B?STNKWm1BMzBCR2kzbmhBL3BRWE1sM09Db0FuN0hOL0xyUVA5Z3FGNmhraDNC?=
 =?utf-8?B?M1FnNkVPb3BXSGVHVzFsVER6ZVdNQlUrUXNhRk9qSnd2aFZxZHN0UnBKS0Zv?=
 =?utf-8?B?R2gxeEVvNVNkVlJpMkZoNmp5WmtaK0VJOTAxVFlJaS9ZeS9mOXdMNzFNMlk1?=
 =?utf-8?B?YjdCUFg0MFk2TGFFUHQxenMwSThxZldpUVJGWnN2Y2dYY2pxZDhKeWJ0L0hI?=
 =?utf-8?B?WndoQ25FUGlqRkZERC9UTnRBL24zOUFGMU8zZ2pmL2pXYXpTejdHcG00NThN?=
 =?utf-8?B?NVhqQVU0TlluM01mY2ZNMGJCYnk1NzZDMGpwWG5DS09hRDk1T3R0SFNvQXVU?=
 =?utf-8?B?QVYvdHIxYVRaMDlVSmhteFMwcU1NcWVKa05JSlBWMml6OG16Vk5vakp2WTFE?=
 =?utf-8?B?ZVc3V0Z6ZUE5UDBpYVV0UlE0TkRaK1NHVkNxRmtqcEgwRVI0YUttSjFjNzVw?=
 =?utf-8?B?eUhvb3ZkTU1zcjFlY0Frb2tSVXg3KzBBQnNRbDZsUTlZVklhVEtuL3FLVU02?=
 =?utf-8?B?K2NNMlp1UlMvTUdpVWdmYUJlbmJ1THhwTjl3YjlWMTdDNGJDSlpNT2lqZU51?=
 =?utf-8?B?ZlhHbXZRcU9QWGZjbmtQS3pyaE1jMjZ4MHVkMWpvS1lFSXR5RjRJaktNK0tZ?=
 =?utf-8?B?UTM1UlRrYTlTdmRiVU8rTlpJeldieEFHb0tFNTZ3ak15QVZIVm5YQVNsSlpr?=
 =?utf-8?B?ZXNEM0FxTDExSVZtRTQ5UEtJV0tEWjRUb3lLMkZFRkZCZVFJTFlmOXVXeGZx?=
 =?utf-8?B?WklBdkNmT2cvMmFWOGVTTi9aN3lKdmF5c25GUGVSVlJEZi9qRDdBNmwyb0xT?=
 =?utf-8?B?K3lwL2xtRFhsbkFuQjNvVmNJZlBMaXJjbUd0REppTkFFdjV2UWE3WGRWOUM5?=
 =?utf-8?B?OHllREhkTnliOUNVNnoxektqdWNhcXJUSklpK3kyOGZETkQvQ0lVNTQ5Q28y?=
 =?utf-8?Q?S46nz1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 03:25:39.0453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afff521-fea6-478c-ca6b-08ddf019b723
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724



On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
> On Mon, 8 Sep 2025 13:07:04 +0300 Tariq Toukan wrote:
>> +	struct net_device *netdev = mlx5_uplink_netdev_get(dev);
>> +	struct mlx5e_priv *priv;
>> +	int err;
>> +
>> +	if (!netdev)
>> +		return 0;
> 
> Please don't call in variable init functions which require cleanup
> or error checking.

But in this function, a NULL return from mlx5_uplink_netdev_get is a 
valid condition where it should simply return 0. No cleanup or error 
check is needed.

Thanks!
Jianbo

