Return-Path: <linux-rdma+bounces-13217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6141B50C12
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580364E2BAC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01C242935;
	Wed, 10 Sep 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGDu/411"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4964315F;
	Wed, 10 Sep 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473380; cv=fail; b=AOmQZcCmyA8puONUqzThA388c6UUC7u5Xv4/yxM0BgGO7kreZZSNKqMVVnBDzNkxsXeaN2Bt5w6OYBCU6++rlUOtDhcikxYESFaoXXceUUc40LXeFrugpJ0WTym7vXTX8L8Vyx+g5esEOaoQvDm4WsFkvplGjKVcgX44YCAKoGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473380; c=relaxed/simple;
	bh=+GXizo1yEPcGYd3VNj2dvlJPffnmRTia0Wjm7fgK2Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C9IyzUHGTwV5HjCGnTtjxjSrC29utYbLTBKvEwR0hlCinT4oQ4Ph2actUnj81bKtHkRmbv+Oit5pOFWHUlz+NuGVItjfeCSI1S2rag0/vXhhgsBpyyeVlJrQX13KYtdncVHC8/X1bbD3r9iiGgJ5ZElwljOUSGwHZ5OBdZZr3cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGDu/411; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm8jluPpHSYiO82THoTfrBkxotItMSfvc8oB1j0qz4iLDTBRDALYJiDC7OPpdjQOmUgs8AMtu/tosFzTCe2dpdq2EULRejR9o7VE+JjxR8rfR2et/bMdiT3iRuHeUXh95JrDsf+nwB4maBTovDeAbklYzQKqsG9Fk/23lRZegsCl5IMchTI7u2CGke+gUu7RKv652wtya1Zrc0m/Z+zbHwM9qeaSd7Cx8lFkOe+u7RDFjnO2zZWCXDTyDEU9p1BYsXcRiFtL9pkThFo01ol7uhZgL3IH9IuPw4fxvWM9LfDx6ex8gASEnPDHd/64xXlJCMGvNcZyRAmYETZx5OvSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to8nBnDZsNDzpK5OwZHVnldqUTK5Aws8L0mkZR2fYUc=;
 b=rekf+XteDf85LPeBzoNadTWlF5qUblbWxvgRg19iBYWUovwY2VUjq8Qk64/WKvwmygLVuEDBcKPm+ngB7asMjcvrY7jyfW9s8hxVHM2uMyi95Q6Yd5rypB7ItDAPvF4A40sJBMTNZBzl7trGtSXCmoDlZXrrnx1BFslDma55yc3/w9+XExq/vVDYunx4+9hpps5pz8Lcqx6iLxm2QDEae0rNKYZfF31me1uwWunYbgpgQdRlku3Y95QheA4z3r/Ham2xan8tPj1+OQe+05jQaBPzAMCDcBVz0ffgUfYyITb8ihrPIW0s/X5NAoxs5SOaT355BtWVKSW5fl6CITvauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to8nBnDZsNDzpK5OwZHVnldqUTK5Aws8L0mkZR2fYUc=;
 b=bGDu/411GzNzlPTq5MUDf17WvL8sYIFtCSsFSJrLW2pX7XCWOgzA6WA2gV0ISwRiqpCJzoPR9lRu1u3ebycXOi2rpkJGKjiUCx5EfwbvNQzHiCbCTKDgs8RNqqR77feBVnDuHPsq+gQIQKgG0yVz+az8mup/XIxw7S7kpVRwmByTUHLtzt70oiavnyNhfVayyL5Blk03IPff6HsqxcPjMOMr1gqabbIQlmsiiU/Hh0w1tONyGr04NP9iklZu4r3jj1Etq6rwLxZRDWbXt50cvZdtyaJ+6L2+pwHfWFRQYtuw6x4O4u4QgaHVR28tXRMXiuzEd9u9YZQoIWwIM8nnBw==
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 03:02:54 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1a) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Wed,
 10 Sep 2025 03:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 03:02:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 20:02:33 -0700
Received: from [172.29.225.228] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 20:02:25 -0700
Message-ID: <05a83eb7-7fb1-46ae-b7ba-bd366446b5f5@nvidia.com>
Date: Wed, 10 Sep 2025 11:01:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with
 inconsistent netns
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-3-git-send-email-tariqt@nvidia.com>
 <20250909182319.6bfa8511@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250909182319.6bfa8511@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcd6d1d-ce98-45d0-5f1a-08ddf016897e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QndiRlZDK3NJbVdaRWtjd3g2YkdpVlBnUHR0blRvQVY1WkplSUVnTVdHNWMx?=
 =?utf-8?B?cG5hTmY3UWljSkpYUUpwcUx2WThYQVd4cTRyVTBUYWt5SGNqRzdlaFp3anNU?=
 =?utf-8?B?cVZ3djYrcmVxV0p3ZnhBdnJGS3Z4ekUxcTQ5VWNpT1RwUUI3dzBaQitXb2NG?=
 =?utf-8?B?bHZLL0pxVUN0WEpqVFVnM2JwUmxFOGFBcUpUdWJjbEViTXV6M2h2dExkcEhh?=
 =?utf-8?B?NDVDWDBRd3g4UDlWVytPRmNoL1RIWXA2SHNZUlZzdUNjUE0wbWRDV1RZM1U4?=
 =?utf-8?B?UVVNVExNSDJGUmtsYUl2OXA2cmVxQ3NQempnb3pqWEcyOW9VdjlRUUtwTFRo?=
 =?utf-8?B?MnBwS29kVno0MFlFU3FyT3ZZTWRpanNVQ3E2QlY5Tm1FcStYWjFybzdEZDFD?=
 =?utf-8?B?NjVtUmRaeHNlL3RRdW5UQ3NXQ20yamlOTnF5RVdFaDROdWlQY21DeE5HY2lX?=
 =?utf-8?B?dm1LancxNVRLY2phRDZWekduVGZwSCtrdC9rK01jdzRzcDlMZkEwdU5qQzlz?=
 =?utf-8?B?U1lnaFhTMVpsb2tvNWUrV2hKeGtjYmlOWjZ3bGRoUXBMRk43Ui9DU0Q2d0Fj?=
 =?utf-8?B?MW9xNVhud3pXaFdsbldqWUVCSEovRG5vS3NWRlFoSXhpOUxZblV2Wjd2Zkd2?=
 =?utf-8?B?eVQrWHAzRCtnNXB3cStyUjM3MGxxYUx4WUtjcWFqOER0MnJpOGpwWG9KTlBy?=
 =?utf-8?B?K1oyMmtuejV1S1NmZUNsSnN5OTBtaWdlaUs5TkZHVFBYUzlpL2E4Tm8rUUxX?=
 =?utf-8?B?SWlxNHJWRTl2eVpkb0QvTVlocGdkanN3TzJTdzgyUTJTVEZhSExOZnFCd0pE?=
 =?utf-8?B?M1FxNmplZUc1T0lQREtuVzdZOWZ6dk5kVUZWQ0VEREFiYUlIdVM4cTNIL0Ri?=
 =?utf-8?B?QTQrd3hjSE54eVZ0U1NKU09Denh2N2MyTlhrcTFSMHp5ZzgxODk5YzRlRVJU?=
 =?utf-8?B?OFN4SHNWTW4rWTZDSXpEcnRuSG5NVGpkZXM4SVE4MEJHaGZranZXK0lBd3Bm?=
 =?utf-8?B?eGp0VUdjMHNxQlA4UEp2cUxYUFgrL2s4UEF3bXdUUm10bkV4b09SbnloaGRw?=
 =?utf-8?B?UVZ5elRPZVFjVVM2dEswTmQwdG42VXlaeFpLbmp4Nng2WXlZa1J2MmptUHU4?=
 =?utf-8?B?QThxYlVXYSt4Zkg2WFJ4VE9aMVJSRTJ4NGlWZEJQeTY0bHlWeG9RZHZrdTcw?=
 =?utf-8?B?L0k4ajU0eHM1Qit2dk5ocVpCdjRnNFBrelZmL0NqSlNrNjBTM3BxUVpyWHVn?=
 =?utf-8?B?UWRlZE1VNDM2UzBZWW4ra3haaWNYdk9ySk9TMnYrRVBUN21EeXFHdWJBNExo?=
 =?utf-8?B?YjVvakZad2ZOY3BuaStVNGxLeE81WjJCUWQzeWxxQitoVThaS0poV3hZOUpp?=
 =?utf-8?B?cXN1b2NmVnVRWlV0TXFBam5XeWZyeEhDY0dBcmxjbEwzRTh4aGgrbzVRRnJG?=
 =?utf-8?B?L2c3VGM1bUVNU25vMDRLN3ZZQmdtSXZ3dklzaTRNR3B4UE1yanBvbkZ4Mk55?=
 =?utf-8?B?bHFlRVVCb2xOdXEzdGZrbC9GZ042VmVIUDVKQXVFZlltRC9OQ1VnYTJScWdZ?=
 =?utf-8?B?dy9MbExDenlLelIzNkxpWDRIYkI5RHVvSjd3cGJCNWZlSlVVc3VMNUpobXAz?=
 =?utf-8?B?NFF3d1JZOU15TEpnY0svSVZ3TVltNzF5QlF0ekE5cllWTmhoc1lma0JoUnJx?=
 =?utf-8?B?V2ZIM3dlOHAwc05FZEt3VW1BM1FxRjRpU3VFcFZDcmFGSEVhT2d2ZHFuMi9R?=
 =?utf-8?B?Vk53MHlHMHdGdmU5cUEwTDN1dXJwdGlRcnhuaEYyVjA2SHRRQXM4ZXZyZXN2?=
 =?utf-8?B?dVJUSHlXSFV1UTNBOTZ2ckRYaEhpMWsvdzZMUkpVZ00xSXZsdUVHaDRsenF2?=
 =?utf-8?B?dXJWU3JoK2JYQndpT3dnTXVhK0JzeTduOXg2TnBKZzRUMVJkdDBFcUh0bC9y?=
 =?utf-8?B?L29ud0JvcDBRdHM3L3FJOURwNlR3eHhWRnAzMXB5RS82dGZERk9pMWFJdEFU?=
 =?utf-8?B?WU5MVHFqemtIVVllMWRYSks4YWx3VFNyaFhhM1M5R3QwbTRQOHBGT0FiQUxN?=
 =?utf-8?Q?ABKXAY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 03:02:54.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd6d1d-ce98-45d0-5f1a-08ddf016897e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A



On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
> On Mon, 8 Sep 2025 13:07:05 +0300 Tariq Toukan wrote:
>> If the PF's netns has been moved and differs from the devlink's netns,
>> enabling switchdev mode would create an invalid state where
>> representors and PF exist in different namespaces.
>>
>> To prevent this inconsistent configuration,
> 
> Could you explain clearly what is the problem with having different
> netdevs in different namespaces? From networking perspective it really
> doesn't matter.

There is a requirement from customer who wants to manage openvswitch in 
a container. But he can't complete the steps (changing eswitch and 
configuring OVS) in the container if the netns are different.
Besides, ibdev is dependent on netdev, there is refcnt issue if netdev 
is moved to other netns but devlink netns is not changed by "devlink dev 
reload netns" command.

Thanks!
Jianbo


