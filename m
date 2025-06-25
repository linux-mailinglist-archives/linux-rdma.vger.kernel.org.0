Return-Path: <linux-rdma+bounces-11604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5B2AE73DC
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 02:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32FC19222E3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0B481B6;
	Wed, 25 Jun 2025 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kr4aWFO9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BC4207F;
	Wed, 25 Jun 2025 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811767; cv=fail; b=Ae1K1wIxhQsLI4h5Qx4fZWkfdQ282bMcgDSLohfqoxdjm8VLh+n+cu1sgL48AYkp6uyvRhulSmxTApMZq+DFPJtR4D+bUZfiWU7TJ2x1qHHSVHX0fMGGeZn87IF/AZTvBlwpp625is52Bj3KWdTK2Ml/VeGpgN0gQbFFrx/iZMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811767; c=relaxed/simple;
	bh=OI/RTVrSFVcYvfWmWxhWalCSNuo+p2K8VNenjvefyM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDJrTNYVpJCSyQ/bba5P00x9Q8gWb3dRarque4jDKulCHEx4fD5DSB4YtFyFSggM965koQd2X78FVJQyYsGZLjlzyzbJWu8xL9bQjdZZO3EEynjyi+DeJJVoMwV5uk6CBjHfTD7SnftAIa7VIwTwXzs9ugZyh0NbsMl/5Hzw0ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kr4aWFO9; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybrIHY6xz/Dyru0zMcSSefNibrF8uYZJJNMwrvZ3Xyj6Ra8/EMVzonsTQenl4EWGb/buMonZXJ1ws4v6JNbtnMNEQhabeucYmy2uAhcz4bs34iT8TTUaQMttNRve9fQLS25u3l85Dt0eYx6mi9N/AYRyAzF7R+wojva7jXIdMJg5ebI+o/MKHpjHCItpYgorhEXZ0/+JCxyasCRmblEYQg1bzTuXIhc+YMpmNF0qUUHT/sZue25lc4SP7YY0lUN/V+nwz/tdM2Y7GiNwg2qGSCkDcE3KKO5riasHxsMsbDYpCBVnUXEIEg8pGHR7UDEASvl3dpn1gFF7Ee5p3biMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bknk7Vakuo6CI6+YpO7jQP+18CZqcMQ3ODATWAivr3A=;
 b=gAY/7Am83orjX4s3sm+DcclMM7Nf6lRrI2SbpX4q1OVRGytXPNhcW5Mf/UM99qAYdqUxx9EE4tlWgmtNLnZ0xwgcmqMy07ifliPD2iXoXtLygzCf2taWZgLMPso0KfSeduQFdO+PlIUKBCuuumWeFbAhrhG6gLG5qLf0R7p0w7wVF09axyrRUnNCenVDsXA6O1G8thVKSQXouiUAcqkoyVYb5rtp6JoaYOfg2dqPW0dG+nsS9hWMzpAPvT65hdX6yOiPw77+CLSGTJ2deSTSVpsRP7d31SNLZpbep7J698X4UNSV1zDhUgh918UzbJSN7tbJTejquESQH07RCAuWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bknk7Vakuo6CI6+YpO7jQP+18CZqcMQ3ODATWAivr3A=;
 b=Kr4aWFO9OYjLWPs1qv1DnUpxuP77/D2BR3R0CL6VFBuYKVwcZATR5rypiTMgLcSTWE663tK+PdHtSf7HKcHZpHi6b10STg1Gn/qy6Ukt885S99t91LhztMyz8sNtLUQkKwlOQvDVZVJs8oSQnW8UP+72lZ51yAs82jE74pobwLxp1QWwKFGlNwaFDyAVE5r64Mi/hRsr66zZlmex5+iV2VKuZqTEvoyYg5QGCRk2GaSRZQ5A8AsyHJkPHaKQPC8PVkHuwXDg+miLl176QIVrxDLyFPVytBXAiTVPi23HwBBjy9uLKLcHPnMrjNU+lWBG9L/Db8IPQOJ1p04jXeDIIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 00:36:02 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 00:36:02 +0000
Message-ID: <dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>
Date: Wed, 25 Jun 2025 03:35:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule
 skip logic
To: Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com,
 Vlad Dogaru <vdogaru@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-4-mbloch@nvidia.com>
 <20250624183832.GF1562@horms.kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20250624183832.GF1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ada156-ab47-4ce1-9f10-08ddb38042ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0x4OE5HTmp4cFJ4OE9ZeWIvMzFlY0dpMVdFbnNzKzRSenlySlBNNmx1bjRo?=
 =?utf-8?B?cEE3WE5XSzI2MW1MQ2xsREE2OEFjNnk5UDF1T01qQk82WGVSNmhybUFYTVM4?=
 =?utf-8?B?aENEUVNjWnZ4QmVNRHk3azdTUHFxMWtRa2NWYjV4TktVN2NOcC9oY2ZoVHph?=
 =?utf-8?B?T3lCZ09ncTArK2FCMEg3M2l2OUgrS29xL1F2OTV6ZnFDalNRbTk2ZUJJQ0ZW?=
 =?utf-8?B?aEJPMmhwclE2cWJMOGk4SzlubjlJWGEwVHdZblY4eFpDYzFrVWF1MzNQeHI0?=
 =?utf-8?B?ZU9ZK2tvcFJQbTdoQVBzYUk4Nk9zbDNMdm5vSHVrL2M3a3h6R0MrQ2RWU280?=
 =?utf-8?B?QzBPUmpWdnFiYkMzcFQramxrZVhEb3poeXVNQnhsbGJWVUVDcXE4NC9SdzJa?=
 =?utf-8?B?YU1nTVB0dzFaVDdnTlR1aGZwaTNrOXJXZ0lEK1dqMml3N3JqSmdMVnkzOFhI?=
 =?utf-8?B?YkZ2M0FETXpjV1BVa08yaFI3dHZ2SWZ0d3ppbTdTSEZ4OXJ1Q2hRTi9kWk9p?=
 =?utf-8?B?MUF6ZEQ3ekNBZ3RvS3NqTUwybnY1NGZkaThJT1lLbFpGR0hmdVYyL1EzaGVx?=
 =?utf-8?B?VGZYa2ZaSkNmc2lLN1AzU1VXTXczV2Fobkh4VDZtOFVrNkEyVWpVZDRGL0NU?=
 =?utf-8?B?dEpLVHVGRGZTMGFLRzR2a2EyQitKMi80RTB2NUh5bHBpNUQ2UThjNkJIUFl4?=
 =?utf-8?B?M3poNGV0NGtxempPRjNEWVdrQTFyWXZVQ3dsZWMzMHZvbjR3ZW1WTnBRVFcv?=
 =?utf-8?B?RzJycE9ZWERuRFFTVGhJTkVyOFlQQUdrNldydGFLd3RFbnd3Z2pvSVF3Zm4x?=
 =?utf-8?B?MGE5REZTWUJqaWJHRlp5SW9zVk1nZ3dtcnZMR25aY3cxQzVJbDBsdjFpdldq?=
 =?utf-8?B?ZmMxRXhzSjNGWmwvNjY5MmJNK3pnaHVqc0dNTXBVeVlVS21TOFd4QUJhTitK?=
 =?utf-8?B?OUtOVFB4YlBLMHJBR1dRYnh3TnN1N1hjT0FDZTBaKzZuQ3JxVUU1THF6SzhO?=
 =?utf-8?B?TVY4SGdDMEx4NG5FU0tmYkpIVVh5c3FYclRnK1hBTlVjd3pEK05FRmhRQ053?=
 =?utf-8?B?VkxYNk9KVk1sNFIweWJhdGpmc0ZpV25WdUtmbXdEQUFxTXdIZUR1dmxOZjdk?=
 =?utf-8?B?YWFWdFRGNzc5RWZVNjV5V2lxM0oyYUFyK2pRaUZzNmVZM3kwQzFsNHRHUGFN?=
 =?utf-8?B?VThKY2UyVEV6TXgwREkxVnpaeGFrMHp4ZTBaWDYzS3Z4WmMxaDliNHYzK0Ji?=
 =?utf-8?B?Ry9JbW54R1I5M24xVy9lRkEyNVRQc2owYkpMRHdKMi9PL0h1U1hkbFBodVdu?=
 =?utf-8?B?OUFsQzN6cDQ2OFZiQ2NvbTNYbG52ejd4M1VBaGE3WHltVGlNT0VtTWJUQ2hR?=
 =?utf-8?B?bFZmVEVRNm9KQTJ0aU1OV3JJWkUxbFE1aGZvV0ljNDQrZGNMSlV4dzNGVFI3?=
 =?utf-8?B?dE1kbk9mVkIrdnYvbUVTNkNBOXlpb29TcUhCMmdpRDUxOGhjb0hvRlR5ZWNs?=
 =?utf-8?B?anVOaEtBQnpmZThFL240eUE3ejZ0L3VhTlBtNzg2N2J5a2J2VVBROVhLTGhZ?=
 =?utf-8?B?MDcvdDh4WUQxT0RFM3dCRzMzL0krOFJ0UlR1amxJWXBoQ0htYmluZFplMWRa?=
 =?utf-8?B?V2ZWaGFlRytNRzFPUVdVSHIxQXphdUU3YVBjVTQ5S2lTT2RVU3dDcnlHQnkv?=
 =?utf-8?B?K2d2V2pPRW1LWVJoaStHTHhHNEhQQjhXZ2N1Y1dycTRsNGp4Q3dWV2hnUkh1?=
 =?utf-8?B?UGpKTGVDQlNQc0pRcDN6OC9EUFpXT1FxSDRyaGFJUXhpOERFOXNFR0pYMDB1?=
 =?utf-8?B?eUMxV1JxaVVvUWMvMGJPQkl2K2NwM0J6OThEYUdpSCs1RjVsQXdNS05UNzR5?=
 =?utf-8?B?NGVlZmJ1cS9jTFRhOG50WUZvVWVJbVBnUk5nMkFhMUZqZmc0OWIyYlhMQlVQ?=
 =?utf-8?Q?wOqxoYc0g8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkhpaFlVVjlmdzZqU1VoZFhpbmE2VHFaZ3lZSHg4clhJY3BVMHB1c2dXL09r?=
 =?utf-8?B?d2ZwNVJPRVBIWlJqVVY2OUdJbUlmc1pLZjZUQWZocGFFc2NHR3BYaW1wZnVD?=
 =?utf-8?B?SnkvaklKbC9wRVQvUndGZXFWT3l6R25VeFBZcmdsRmo3eitzanNsZVpFRVll?=
 =?utf-8?B?UDk2TWFNR3dBcUpxTnJkQ2NaQi9QNkRKeDFVRmEwb1RibVZCcTFzTXhMOTdS?=
 =?utf-8?B?VE9pUHJUd2xOSzExUU9ZUnlHbldva0IyQ2NLOENPTVdyUzVCU1pFbTFTWTMz?=
 =?utf-8?B?bzlvaXlvcnRzVDFZWU9tWDdITnlOOXJ4dDIvZ29adWdkNWVNOHBWRVZXa2Jj?=
 =?utf-8?B?cmQ3M3ZKV2F2VFYwMlVibUJyVkpJTGxtaFI4cTJQdHVjdXJtWWVHRDFkU0hZ?=
 =?utf-8?B?ajhFd0NQSDNMODZPWi8zNkljZDhnTXMzeVl6TFVzY1A3dm55c2hLZkRFRVJN?=
 =?utf-8?B?YmhKLzFFT2ZqSW1SWTJ0Q3pzTG5JUFphVGdjYkVNMkJZdEhnaS9BNC9SSEps?=
 =?utf-8?B?bFZNeCtIeVVvUzFIK2Z1Mjl5L25zZnlESzFpR01kSDJjejNWZmtkbkIybTly?=
 =?utf-8?B?ZTNOVFcvR3RWSFBDUUxyaldNcmtraVd3QzZLLzY5aml6Ty9Cemgwd2xzeURi?=
 =?utf-8?B?cElWNjdIeFpITjgyZDkyRUJwN1p5QzBXajliQlJoNU8vb3lmbnhuV0wyeUhD?=
 =?utf-8?B?b2piYmdzTmN0aHNLVXdPdFFGclRrRzNJU1R2akMyQm5vTllMYzRWWHg3RFhX?=
 =?utf-8?B?RkhGOEpQTGdaQURKbkpuZUt5THZ1alVqU25rWG9xcmgyZE5QM2k3Z0JTY0F1?=
 =?utf-8?B?YzIzTjk2bml5cndtMHRXZXpDZWtlWUEwSjZPa2NWb2NKQlJ0NDJtRzlIL0xM?=
 =?utf-8?B?OVphZkxtWi9Fb3c3MjZhR1ErbEt4bVNRb2N2M3NNbUpCTTRBTGtJc2tlM3VQ?=
 =?utf-8?B?ZHhmZEwvNW85M2F4dWhoaTVJMlJWbnpVcWR2cTZ0b1VwcDZoaDZxSUh1TS9Z?=
 =?utf-8?B?bWpoZVVMVkhscU0xNVgyTEc4NXhXMXNSSWZJMTJ0eENZb2c3dXJDb3ZQUWhN?=
 =?utf-8?B?bk1DbEZrK2UxVVNROEJrVi9ha2tTeGYzb09sOUNUVEh2aFcvM1pTR3Jpa3Nr?=
 =?utf-8?B?bXZmTXBzSXNzSXFqYS9sWTMxVHcyK1Z0eEVZTGwvd3FnT0d5OVR3ZmFHUHIw?=
 =?utf-8?B?SnRjby9PQmoxVGpVUFZZNlk2cmx5OHNmUWhSdDAwd1RoZlhGSnQwZ0R3Unhv?=
 =?utf-8?B?NndCc2k1bEpSWVFSZlFqUVgvMFc3YUZxSjNBRXRGUHZ4TXltZk9DSHpvL2M0?=
 =?utf-8?B?QUpTSE9jaVhxYzVteHBHU3NRSzVtZHJwWWVhRGNrSjBFS1AxaURacUs3L3ZI?=
 =?utf-8?B?ZDBTSUxBRk52a0d2bllUc0dKQWxZcmJFVzUvaFQvUEF0SjMwZG4wZ3BaYnFo?=
 =?utf-8?B?a2U3Vy9MRFcwUTRuS2RFQ1Z0QnR3OGdIbnpvQTNVZy9uNEFxVHpxaERkNEk1?=
 =?utf-8?B?TVcwQjVRTHVCdGxiajhJOHk0R2lWM3BQYitXaXIxMzArRFVOZjhnNXN3S0pI?=
 =?utf-8?B?V3paV0NxUXRBT3AzWlM4UnI0MEJoSGRyeVVSbnhNbXRFa2k4SDR6Z1hybDNr?=
 =?utf-8?B?MGRIc2N4OXhHdFFZc3hvQkw2M3dMMHN1a0NzVFQ2aVpqUFh3cTV0bFh6b1BF?=
 =?utf-8?B?WWM5R0R5MDIwa2ZqVk5XSVZZekltR0JPbVQ4eUh1Vldtck9tdS85SU1DdlFO?=
 =?utf-8?B?VmtsTHZzd3ltdll3MXlmUzJrVzRCY0l4YkxjRzk1ei8zOUl4QWQyTEtZYU5j?=
 =?utf-8?B?L1ZkVG00Q1V5RUU4Qjd1all3VEF4RjZtVmtIRlU2REJFZGMrVUlFeG5nZ0JK?=
 =?utf-8?B?V0pPMnFrQk9PY09XVEZmVUlqUmZOUFJGSzN1REtFSGZ2aVFucXVxdEJOOVFy?=
 =?utf-8?B?Q0RXVGVHNXFzemtoRnAxYTFHUExENnNGY0F3WWNCcGhwNlg0RHBWZFJRbFFH?=
 =?utf-8?B?Qytkb25BTGxQUEl1ZmdFL2RlZ3krOEY0T0lLZ2svM3BWcmF5aGxUYTBhNi95?=
 =?utf-8?B?b1F4bk40c0diUFZrSlpZV3J5dGtMa0g1S1FjaGZqMVIvRUp1RnkxYU9GbTZL?=
 =?utf-8?Q?Q8Llq+Xa4s9t1U+ZBOAeZVPLm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ada156-ab47-4ce1-9f10-08ddb38042ea
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 00:36:01.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JoKur1h62RrfqRO0aZxs8Lgs/wyjSiCBf681IDUCxDZHrdlAm5gBg6RAzd2aKB/OeABEfzuSFaHYlgLBdXbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

Hi Simon,
Thanks for reviewing the patches!

On 24-Jun-25 21:38, Simon Horman wrote:
> On Sun, Jun 22, 2025 at 08:22:21PM +0300, Mark Bloch wrote:
>> From: Vlad Dogaru <vdogaru@nvidia.com>
>>
>> The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
>> RX and TX rules individually, so export this function for future usage.
>>
>> While we're in there, reduce nesting by adding a couple of early return
>> statements.
> 
> I'm all for reducing nesting. But this patch has two distinct changes.
> Please consider splitting it into two patches.

Not sure I'd send the refactor thing alone - it isn't worth the effort
IMHO... But since I'm already in here - sure, will sent it in a separate
patch.


>>
>> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> 
> ...


