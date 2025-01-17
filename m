Return-Path: <linux-rdma+bounces-7069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D3A14EA3
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066A0188A7B2
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AD1FECD0;
	Fri, 17 Jan 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4b5BAlT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D51FECAF;
	Fri, 17 Jan 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114287; cv=fail; b=tBnsoU39WsHHW/Vs9HQflhBTdk1RN3F7euE9TSKKpOUdncG3xzSXzDEB8IdsWL/uzatcXO8eFcYaoQE70nKOIYPD9sAljKicJDW0PFt85l8TkyI+cQwLQiBGAclwRiIagBDIlny6ChrPOtkm62zz72HwbpACKncT4kfpraUyJxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114287; c=relaxed/simple;
	bh=7zmfLu2eypzPDzM7WsBZIrQYTEoFAf9wt47oqbb52Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qOQwuC4nEiukAHxmkX9gPM9GtAulQeBIjn2krJ6yzw8LS3o5SX5KeGNsEM4vDclskCaI4WJnKRHzMarM4cYwUVB77lfAcVw0qKfk9B4CxrYaTfveq0LdaIxiuDbYDeyzzFu4A/ZfqFfKHMuwkSTUYkE6VDK8zUbmBAy06V0DACk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4b5BAlT; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIyBcptPp+aGJMS4eAAIJ18NZYjuYugXlCWSdRNzJCOqMyW5b2+qQuST2+ehhIVF3DCezxgk3BJs7inDVxmmSJXHBNN1acBOE9JAHsZmgkx3+bYBH3n//zcS6mD6obiDDeFBQYpae5+J0LRPquZjD2IUtVt7dP6Zkr08YlAUc8RQtqu5gmaNhExKd8kvaZRE9LOEAwXdEW/w43XIJj3x4zocJa5lRaPLBB4vr239330nigc/NBLQGcbuoQBZbq1j/scVJC+ka2WfGSKnxCxFN+tTiB25MsUvKOOGPoOWp2J2/Tm84n2o6jYAf5LGZfOiov3wENvDG6GWFBBCZhW6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyWMAYr45P2/PMjCmze75xiv0ezzjjKsh8uNJmjYjV4=;
 b=lgjnUyX57kKnoCCLC8zope9wvKkGR+Strxc+ls8Sq+4UX4zMXA1STGlsl0p+SmZWslmTvXF1tdiCti8M7RHDFdiZQSmqH0EbbNA0pH4Mmq1kn9vwZBkmVkaZznbAHf4sWial9Tz3zn7/7+ttAd8Pouit/y/3hOYsqqFhXHOIreyK4xxADRqCAqSDL7rCEWvBNdAfanIFZB+lRI6nGeUe5Bif1p85PSMEme/tpsdrbpyPL9CCRFr1OTrtxCIC+An+IBbUTjonjGUD9aCaA3f2kMEKqSTOnmLcB8bwmk0KAWpF/IJQf4XDKjfY9StwPdFq/fG3vnxfIMPhhUGhWvKikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyWMAYr45P2/PMjCmze75xiv0ezzjjKsh8uNJmjYjV4=;
 b=A4b5BAlTnP5YGTYtccTEmLrfI5wUtf0+aRbynjOT0J/UADGetztWZ6l1I6+Qg0E0Y1nNQWZI+HG/eaLJRGR6oEDJ/on6c078AJPdHRlAjvybBGeKNSAI8g9af5j1NNYnypcezUSa9pG2dSNEdykdZnHONYl0Bty/ti2NC7l7u3LWwOZWpqXcOVEjE8AOopFBiFoJmE1UrYzQPOHyqDov+1GYVM9SKsOwasC3UJPnyTmGdPPJhs3AUclloinUk+zvGfWKxsQljt+h0FoJFfkR+jwvMooDeFaCB0IPB4ydY7Q8FmCumWyE5k2B4nXUfgg+wDkdrygf/Sz1zp+JxyP1zg==
Received: from SN4PR0501CA0099.namprd05.prod.outlook.com
 (2603:10b6:803:42::16) by PH7PR12MB5853.namprd12.prod.outlook.com
 (2603:10b6:510:1d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 11:44:41 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::88) by SN4PR0501CA0099.outlook.office365.com
 (2603:10b6:803:42::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Fri,
 17 Jan 2025 11:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 11:44:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 03:44:34 -0800
Received: from [172.27.49.209] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 03:44:30 -0800
Message-ID: <a600d7e1-2cb3-466c-8e0c-0e0a4e9fc5c8@nvidia.com>
Date: Fri, 17 Jan 2025 13:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5: fix unintentional sign extension on shift
 of dest_attr->vport.vhca_id
To: Colin Ian King <colin.i.king@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250116181700.96437-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250116181700.96437-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dbe5f0-b9c6-4f60-24f9-08dd36ec545b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDYvcEUxeStSTUJvUXI2WEZRYlQ4UmVWbzd6Wjcwc0JXT1djVU5tNjAyVTNY?=
 =?utf-8?B?Z2NSam42eEFyVEdtUW45K04yTGlZc1hNOFJZRDZyNEgxc3JsWjV3S3BFQ1R4?=
 =?utf-8?B?VFRoNVlSOCtRUVNici90cC91YVhGOFFMS3Z2cUg4ekRnSmE2cFJ1WitLQ081?=
 =?utf-8?B?MVVXYzBENUxEZElITGZCazc2aWdXK1ArYmtUamNvUmNKV2cvSVg3NWtJcjVP?=
 =?utf-8?B?citYOEl4NmtOSTJ0bUd6T1BjcHVxcWF3YXpXMVh3MFFBZVUwMEZHMDVwUEw0?=
 =?utf-8?B?Z1V3eWM0MEhieVE3a1o2MzN3bjhHb25McGJzNVFpbENuK2F0RnB1aHBxWU5C?=
 =?utf-8?B?Wk43eVVpTUUxVlZjUGpPSDdYT1VvZ2NHbjdHdDJITDZLbEppVVEwTlJuL203?=
 =?utf-8?B?Vjg2S25aZUlCNTFyTlhaZzBvNmt0RkNyVVJTNjhsVFQvRDlTeFdBUVBGL3Q3?=
 =?utf-8?B?a21IbFBuZk9lQU1aU1hqQTFYVFBOem9hUEdZVFppZzJkSUptd3hGdWlybmln?=
 =?utf-8?B?dHgrT3RwWWFkaHVJK2taRElRUCtlTzJ0Ymg2bjY5RHh2TjZkcnFHWFpBT0xH?=
 =?utf-8?B?R2ZDSUcwWWsvbHRpblVZTzZqdTM0dWtpUjNwKzJHY0pYdUZDZGlSa1VrVmJu?=
 =?utf-8?B?b0ZZVGowNVV6RGxaNGJhZVBnK0d3VlQzc2JiMXhRaDZRYmlkTkRJV3BkZzJS?=
 =?utf-8?B?VHJIWVpOeTlKclZVVVJ2TGZhSjNreU5TWDlrYm5wNkc1eVJEeXlIVjB4RFdP?=
 =?utf-8?B?TTRKdnZ3ejR2KytZT3hnb1RNcFBScDJmOG1GOUpXaXMzczhDMnB1QzJHNkJW?=
 =?utf-8?B?eUVYVUJ0TGpYS2VuNTdsSnJucUd5UlVCamJ5V0lYcUJ5czNMbzBxczN4V0s0?=
 =?utf-8?B?cTJYUGdEbkkvdlpmTXFxd2VpOEpXSDBMbTRLalVPM2ZXV05mK2VQeVJDcC8y?=
 =?utf-8?B?UTA0WkdFN1RvdGVZSUYvUzVkUmJNSG1aS3BHdm9uc044dUlaRXh4NDM1ZFRm?=
 =?utf-8?B?WS9qR0I1aU9YZEdQS1J3NWV1RWxCOFJCbVdRaUNmUThNT1VZSTlxSUp0K0dU?=
 =?utf-8?B?YzlQTHd4cmRaYnMzNExMU2M0eXduanZVa29KOWlTM2hyUjAvdy9WSE5XL2lM?=
 =?utf-8?B?ZTZHbkNweFhOMUl5eXdsYWQvUFlkR3BJS2FrS2IzNEIvVXIyNjI4SG9oUnYy?=
 =?utf-8?B?YzBZQW1WME9wQUtvRklvUXNVTGdTOXR3UThTZEcvWVZzVXVqV2pDcllvZCto?=
 =?utf-8?B?Q3dmZzdGZWJDYkQ2ajdrZHJGQnc2eTlVdmtEUUQ5LzJXQ3JrVnJ3MDFoVE5y?=
 =?utf-8?B?cEx3RkNZVHFyVEVUWDR4VkFuWDVOU0pFSkNuc2VRcEgwbWRIOHdCOGh1MDJE?=
 =?utf-8?B?Qlh6WCszMlk4YmtsL0dUTEVtRjhzc3VlZVlyOFE2UWdjeEtJaGJ1VlZsSkwx?=
 =?utf-8?B?N2JsclJxcTNDMnlKSkdGU3IxM3BsZ3VocnBySnl6RHJzMXROcFBEWUVMMFQ2?=
 =?utf-8?B?VzIrdUVvWlZ0WnFodWozQXBJTkdTVk5LdGZmTVpMVHZTUEtkYjdDOGY0U2tJ?=
 =?utf-8?B?aitQSEZveHAwdHg5K3FIcWV6eFN5NmF5Z3hnempvOE5VMGk5cXJYblBXd1JM?=
 =?utf-8?B?aW1yTEw3blduRHV2dkdFcHZOeGpTRUZlaGVqcUkyNXZpaVFJbnB3N1VxYkdv?=
 =?utf-8?B?eG5JSUVaRWZ1RVNvSUZGaE5IYnUzSnB3dkN4SWtUOTI3WnlOM2RTQkRTak91?=
 =?utf-8?B?NXo1a2xKeFdrUnlCV2NqdjY0bHRTMUN6RHZEcnViTDZpckNPaTVLcVNpakoy?=
 =?utf-8?B?dE9Gd0JsV0NUMkh4bTZkSkcrUjJJQ2JDSzZwM1hZUlE2Z2xWaFBUNDlnWkhM?=
 =?utf-8?B?b3BlRG1xZWZNZXpDRFJ0U1V0SkZiV1R3VHZ3NzNaQ2tLZVpyY3RxQzA2eUZS?=
 =?utf-8?B?QzdhZnhvZThDUVBDRTVQSnQxWlZ0VEZnRFZSVTJPNW44NGJhTlEvcnl4M29m?=
 =?utf-8?Q?XKIDjP9CUzBW6eNROm5f3Mly46vAuM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:44:41.0357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dbe5f0-b9c6-4f60-24f9-08dd36ec545b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853



On 1/16/2025 8:17 PM, Colin Ian King wrote:
> Shifting dest_attr->vport.vhca_id << 16 results in a promotion from an
> unsigned 16 bit integer to a 32 bit signed integer, this is then sign
> extended to a 64 bit unsigned long on 64 bitarchitectures. If vhca_id is
> greater than 0x7fff then this leads to a sign extended result where all
> the upper 32 bits of idx are set to 1. Fix this by casting vhca_id
> to the same type as idx before performing the shift.
> 
> Fixes: 8e2e08a6d1e0 ("net/mlx5: fs, add support for dest vport HWS action")
> Signed-off-by: Colin Ian King<colin.i.king@gmail.com>

Acked-by: Moshe Shemesh <moshe@nvidia.com>


