Return-Path: <linux-rdma+bounces-16648-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIdLHGTUhWl7HAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16648-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 12:45:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7EFFD549
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD733024137
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87833C501;
	Fri,  6 Feb 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="urDPkdUp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD721767D;
	Fri,  6 Feb 2026 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770378333; cv=fail; b=jIhV/5aRFhQkPguy1vBEVgGbSLr7eD0j4HhndoiMoXYOKjI8zuRqPz3SV+HGGBOpe/5xIHnDvBJv33BBDzcsQluh1lq+j7Dx799BZA/BOXNXowrg2JAKjAj9UxKnmLkSWDLDsHWVP9ibNdyvMUe5BrRkQPVDUhdkPbqDa6gAZZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770378333; c=relaxed/simple;
	bh=kPVnkjyaygVyJ9mVKHyxZORr6nLqn9Gj3xCbBgASzJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qv5tcaFKauxjGWSczaterY4YC4oHdSxjN+fVEw9Bk/BcQrSybOJHnD4ki1Ofm6JoU/2Pd4yjFL+D48B9t3y9+HywsJ0/O64HrPVq9/PBo5ufRp3yTdzeOps/CVaL3lB8l4sxUsEbntDYlRmb+GhcuuTIuXre1nHUIYfEUsRmds8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=urDPkdUp; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9ZDW/A4/qifgK8DVs2xOrvZpB/I0FF1wDoIb0/oAELRTrERaOaXmqxveMfSR08v3G6elMYEswNj0bUR/iLS6T+YaKj823OZRyYDJrLErAQK5TVHLw6oIGzl+fQZmjTswQaaHduLyzuPtrVsEWjl9La3u5Vlo41IpnKWnWRlSUkO+mbWNJygSU22q6LncThks2zGzgyuThUs8fVlUbWd8Tj+mIPGvlWhP8a9KNF8jd8niMPCHSYkm8qTHPEucPJG0aJX3211ui8hO8RbFWDC4NvPsgTD9ag+9lMz/niRW/w0myyaWLc3+OTEOvbUukFyKaI2fZ9bN6XNcyDBaYi5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5J+0g3f5my0dL+R5SgpaWfjNr0gE4ATodUHqItwf4Y=;
 b=UCpedjzlVREbS2Z2nvkEG9wLY6wb0FOHDx0xxqPgo4KsjdJmcGDK8a8vkz90Vbj3AvyEiow1tFsfsSSPKazpWOHSLIEOcGKqcpm1E1lX5Ejbgt/fuD7zLwYKx+/Z8bKWCO43iwom8qlnVMSpS6ssd9laEuEHV+EHfoMDHeYyGueYPbJMBW1++I98c6LkU21QPLF8juZK3dNRuptrMPKzsL5h71j9lvELTMlX5GHg+e8bsOaFE+1XswHhrjRsVVm2rfW3PcVto//wDeQX6RiNePFAvFSxMXCQRufXm1Wd5D+KSbCYrl552Ew5zS6P7l34IPxNZVMeo5s3l64GGuKXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arndb.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5J+0g3f5my0dL+R5SgpaWfjNr0gE4ATodUHqItwf4Y=;
 b=urDPkdUpb7tLhZ9urVQK5eaAtPg06L//vRdWrB4DFLgNVZZhxWNeURRtRBEGah4m1j0nf3LTNjCS3QmI7EpotqCqtbVqUpZJjQCiFlNL31aDC5YY2K+HIwUHUU8sFHUuBSVjvWwSoACcLh1m1oCipzZ2zg27Zmeio6cTcG2+v04Zr1m0F1ilMoJ06Zy1485D7zDIsSKwh1F6NGCN6gKOt7aFRZlX7kivPD5p/dFsifC9OeLOGRLRaxBOwubrkopdSkJM7zlhoCV/gaOJBmwwSurXgj03LgfHGmhLmyKDl9/ijcvBEcdJBs9ygoBnH6qDcg/RDbGZDt5YyQkZzdUh3w==
Received: from PH7PR13CA0018.namprd13.prod.outlook.com (2603:10b6:510:174::22)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 11:45:28 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::39) by PH7PR13CA0018.outlook.office365.com
 (2603:10b6:510:174::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 11:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:45:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 03:45:11 -0800
Received: from [172.29.249.233] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 03:45:07 -0800
Message-ID: <448e9cf4-f31b-44ca-a352-916d53386843@nvidia.com>
Date: Fri, 6 Feb 2026 19:45:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net-next] net/mlx5e: fix ip6_dst_lookup link failure
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Raed Salem <raeds@nvidia.com>, Netdev
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260204130057.4107804-1-arnd@kernel.org>
 <8da9781c-4b89-41cc-8810-8312ef7c2c81@nvidia.com>
 <2ec67d1a-32ae-479e-99c2-dc5042d9f57e@app.fastmail.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <2ec67d1a-32ae-479e-99c2-dc5042d9f57e@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0975fe-3295-4d37-f101-08de65753986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1UwSnFVSlZ6VEFBZ1EzRmdyY012Y1BJbWc0SHR3ZzBKUjBnaUNPNWkxRnNG?=
 =?utf-8?B?bHpSRlQ3RFc2dFNBV3VpL2dZN3ZQcmR0VkVodGx3NVZFdzNqK3hOZytTWFpV?=
 =?utf-8?B?Zkd6M25YdmgzeER2UVNyODhBcytmbklveUl1akg0Kzg1eUxjZUFteGcwbzRn?=
 =?utf-8?B?blZqMGRKcS9pbVNkSFNuSGJlMHJQUUVmcFp5eThENW1YRlAxY0t3ZHBVMDRh?=
 =?utf-8?B?SWVTSXNxRzVoeExXb0MybE5LQlZmVTQ0RzljUElKUWJrSjRPdFdBZ050Z0l6?=
 =?utf-8?B?MUY2VU1lZGFKYjdBWEpHclY0a2FVYlJHcUFJNHQvUG5YSGNNVld4WGMzc3cy?=
 =?utf-8?B?Z1BmeWVyZXFSQ3FuUDJjMXRZQVFZYXNhWmxkUGZiNzdJaGhhWER2YzdBUjM5?=
 =?utf-8?B?WWhWR2MyOUdnaVlUdElVb2p6MTNEd0VYcldkczREMk5MSlM0N1JoV0xQa09J?=
 =?utf-8?B?SS9nbGUyRzVmSSs2TFg4dmVLTjZvMHl3eFFuczZLRlgyNEwzRldIRk5XVm4w?=
 =?utf-8?B?TllJaktVam1DWG9vbUtBWWt5N0dWZTgzTjkvWDJzQ1BTVEJUU3k0VVNsMHF0?=
 =?utf-8?B?WmhSY2xaUy81RS9zelAySHN5Sk9pL0tJUXRYWFhlM3dpRmMzRGl3VTZCQ1dN?=
 =?utf-8?B?UGFjb1pwbXcwWkhxSXdkNGpGZ3Y5MTVTSzZkL3puUUtxQzI2cXBhekVzUDAw?=
 =?utf-8?B?VTNqRWkwbjg4eDI5dTFUL2JPdVF1alFHS25HeDM2M0dUT2pnTHVoL05kS2JZ?=
 =?utf-8?B?ZFZzMnEzMVkrMUVGdFVUb3lXTnpHdkJ1TjBIZm1GeVFLU2FIT0MwZDJ2cktV?=
 =?utf-8?B?RlBpTGswOWhPci9jMHZKeEJnM0RCTjlRNDNoOExpWFgrbzZ6ZDZPTVM2MEtZ?=
 =?utf-8?B?SFVWd0UxSlRwYzJ0VjdZL0dZVWpnK254bW1JWFB3eEZBQ1JmY2w0bTdxUGJt?=
 =?utf-8?B?aDM5Y25sNEErakhCcE1nN21kajNUcEIzaURNZFBoTnlWZkhtRDVmRklQZGdS?=
 =?utf-8?B?K0thUGVFV1ppU01QZ2N2VlM2Q2paSHU4MExLeGxmVHBESVpnc2ZRUnZhUUdH?=
 =?utf-8?B?cVNFc05pZ25vYlpQV1ZVNi90OXQzZ3Jub2FETkxOSjZ6ZzU1QzVEOG5hbEdk?=
 =?utf-8?B?Q2xDSEhrSThUTExpamM5QUYvdjJ3b2pJYVphbWcyWjhmaWFNWTlvN3pkUWVS?=
 =?utf-8?B?TG52eVMyeXVYMmtTSnRLZHFBSzVoeXJKZkhFK0VFRWQxN3lqK25YL0tVWGhN?=
 =?utf-8?B?UmVSSVh5WHdPVFBXQTdXM2V4Nkl4djhlWnB5ZnpqNE9rZHpVNmxBTC9EWXAv?=
 =?utf-8?B?UjVaYWhyeUR5TGhSQ2syOFFvOVJkT3RiN3I1NHczc0ZaRmFrc1Q0aFgwUkZr?=
 =?utf-8?B?dkdjUDJNcjR2cnVzc01XZUI0dkpKaUI1ZXNTR0JrYWY1dllYVVZwZnFwaSs4?=
 =?utf-8?B?SUVxaFU1QjRSS0E4aVVXUmw3a0preXY1RFE2T3lhRCttTVpiWE1oL0d5ajRm?=
 =?utf-8?B?L1duS2s4aXdWNEI1UE1TNGEzN2VwdVZaYlFjMVhXK2RtRFlMcEJmSHlCWTlr?=
 =?utf-8?B?dXhJakpBVEZIVW1UZWc4YVNOUWh1LzdmYzNJdHBZZmhZcWtkZDBFd0VKU0hu?=
 =?utf-8?B?b09MY2owRUo0TEo5akFIZVkzd21Ya2hTTGZpUjhXRENLT2xCeXZYYWx5UlEz?=
 =?utf-8?B?K29kT2ZBMEc1RVNTRHI5WEhFdXV6WUxxY3JBMjYvV1FpOUJ4YWFWUG1nMWNz?=
 =?utf-8?B?REFiUTFjc1JtbkxhTCtBd2NBd3JiSGN1MUVYM1AwWndDRUU3RVZCMDY1cFNy?=
 =?utf-8?B?SnRMdFJRbHdiRUl0aC9GamR2Z3FZbi96dzdyQUNYbHV5cDQxMjdMOVFPOGNr?=
 =?utf-8?B?TlNydlhxSVRaV3RYbm44RUhTZDdQaS9SdC92MXhVcmFTSlVqa1dlMWpoSXZF?=
 =?utf-8?B?TWNqQi9WTWZCV1ltV0VIR29ROXhmWGczVmlzRGVrK2Q2Z2t5WnFyY3RiQkFr?=
 =?utf-8?B?d1BiYThSekJhRTVwY25kRlY3K1lLVm1Uc1NKTGFpRytNRnhkQW85V3VYNlFY?=
 =?utf-8?B?WXV0VkxwdzhEYThMZnpOeVFDOEg4ZWwyNW1nd1JONzQzcGd2bnMwRjNzSU55?=
 =?utf-8?B?OWpKNUlhdHJhNHk2ZWQrREhIcjJ2bHNjNU04aWtDTzRES1V5cEJHL0VsOE52?=
 =?utf-8?B?NVJNYWZObEMxUWhjM0VGL09icG02NHpFUCszSlpwVW1Qay81ek5HWVNnU00x?=
 =?utf-8?Q?yHuezV9OnBbOfN0abNnbYWudu5DPqyFRXjXxQKXvt4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fM6oYD6WmvqQVzx1ULppswKCQGN9k1cuGDGFRuicCqz1/zxv8Quqta679m/lQ+4giswzjl3NIklJJGDrGAzel1HSUxwhoGRsvtaGecTUZ97y+WTkLnYq50mxhpStaR6WGEHZR7/s443zlZxxkkLwagUXc98ua7ubs+7kqmLw1i1b1QSFVElu8DAw20HQpBLVJfo9f3gNDNEdGi254HTHxmOaT/WkWm8Tu1WWhByYz0snvbL2FQKtHGOJpHNze5/Av9xXEphTGigLt88/P2jwT7dx/XS5XUvfQMj8lhMiOfZdIHnwwpI1PZVvnF9s1/ak6CM8D6AA87RiMZGfPsibm39H7FHbWvgPimUqFrtsugawdvUQD44ptLK6Z+S2Hay0acgZGKCG4SmPdtjsU+ZkSLWWuxpo4WnPwBFZmVR+hTvieaHkQfHSDIapaKaTqvJy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:45:28.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0975fe-3295-4d37-f101-08de65753986
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16648-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianbol@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CA7EFFD549
X-Rspamd-Action: no action



On 2/6/2026 6:00 PM, Arnd Bergmann wrote:
> On Fri, Feb 6, 2026, at 10:56, Jianbo Liu wrote:
>> On 2/4/2026 9:00 PM, Arnd Bergmann wrote:
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
>>> index 9cf394c66939..c298efe93f97 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
>>> @@ -154,6 +154,7 @@ config MLX5_EN_IPSEC
>>>    	depends on MLX5_CORE_EN
>>>    	depends on XFRM_OFFLOAD
>>>    	depends on INET_ESP_OFFLOAD || INET6_ESP_OFFLOAD
>>> +	depends on IPV6!=m || MLX5_CORE=m
>>
>> Thanks for the fix.
>> I received a report for this same error here:
>> https://lore.kernel.org/oe-kbuild-all/202512261850.P5Jp5BSz-lkp@intel.com/
>>
>> We were about to send a fix ourselves, it is to simply add:
>>     depends on IPV6 || !IPV6
>> Is there a specific reason to prefer "depends on IPV6!=m ||
>> MLX5_CORE=m"? To me, the IPV6 || !IPV6 syntax seems a bit cleaner.
> 
> MLX5_EN_IPSEC needs the dependency, but this is a 'bool' symbols.
> 
> The "IPV6 || !IPV6" syntax only works on tristate symbols, so you'd
> have to put it into CONFIG_MLX5_CORE itself, but MLX5_CORE does
> not actually have the IPV6 dependency unless MLX5_EN_IPSEC is
> enabled.
> 

Right, I meant moving the dependency to CONFIG_MLX5_CORE.
Your patch restricts only MLX5_EN_IPSEC, which causes the link error, 
even if it silently disables IPsec in that specific config.

Acked-by: Jianbo Liu <jianbol@nvidia.com>

>       Arnd


