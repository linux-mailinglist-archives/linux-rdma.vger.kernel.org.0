Return-Path: <linux-rdma+bounces-17779-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJgfAojGrmn2IgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17779-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 14:09:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95387239742
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 461C03067A37
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A43AE6FA;
	Mon,  9 Mar 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTqojE8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BA1D90DF;
	Mon,  9 Mar 2026 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061464; cv=fail; b=htQxzFskDq6WkSAIPCgFGoIoaGguzXURrRig3pEhtuKSt5Dxku4/YLmqGSGYS06JZwut1VlRY2T/YjOSGFxGllBxA1bcp2N37FDYMqmhSaI9qnDIVPxCdeRN0MfRfwXid1HVbAYRwGxT5DLiKAGLTX6vKn1RS6dUodp9XUq9F5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061464; c=relaxed/simple;
	bh=MNyY/rEzkqlIPYA5fX+2YVaHixVYPpD8KnFYhOcPHPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VeQIZoBUBV2LQ4R0qJFOh/V4WQudqfKfMA385AFejCe3bAbkURMKnaGpipheZZHf241eVo+mxTiy3vY7HdVUw7cLDPVFKb5yjuHJTGhIIfZ2F2xy/Qcvylsg8VmEKShtems98qjeU5P4rzYIOCAv8kZONHk8ZzfoxtCmNY20cig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTqojE8O; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQZj2TeagzpofvPlOxYRwU0pm//ruaj2WKVONF3bMgagtm0xE28BWiqmBDew9W2p2sFsQt3qkARfD1fxVGTthkC/4u9DDXhcHuUmvavd+6yZmW6IuYAXKSVxPpQu7+hAOjCuO2vEn/jCvcS1ho6OHX0NX9WlVxeKPu1gvxwOWRL4LiGhGsatxz1QnNe+BDNaYALf8478xdm6twHAd1AQsdCLS69YTDyh7F5luM2+T1hIO9xo88roVa0P51bU0qtHECH2X7idSbr+DgtTAKvh/ylowFOgYA0VhqImMO+zubToCj3ZdnBBlCMflwK1ls97oy/RbpqUCI5w2GVQLKwUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv1qp4m1Be/IRQXkM1RtrDTWGUZ7tKUIiZzDC55RYe0=;
 b=Y8Uky3aaoh7I1OK004Ayn7YinivGGnkhxJQidYPGPbqr95m0rSTHd2pm0XwsqX50MRhkjaXJJqk6GoZeWF+ykISiXEHQxT6lcAEI90bo8crEmHzhFIExuMvuK0OP5mbVtrNBVWW7/QxDpAJXBVFqH+U7CxiGx6WP8enqqCsUeO6kfHFa5PR8SUwez1w2MMJHu+u7ChSRtMRuSReIfEs7bdVib2tqBMpgnjlDzc2dhfqOlJjiBIikEVhXzjsQnisbXwZk9GLgcmxpeU29Cp3DyvnPH3XYilpVvUq2A/4pGWwVSBtZwVAqoz6glLg/PfvYW7TMyIKkXkj1j4r4Kmubdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv1qp4m1Be/IRQXkM1RtrDTWGUZ7tKUIiZzDC55RYe0=;
 b=pTqojE8OQLN2k32m9fQ6EsPZzoZZzjhR09XA7nBlSvNkGYPKUojkHv2aB+9Kr3x/f9W4kbzFEJkkrXJu7XmaaE8W8fxngsrbKINvic2oxqYtOm9axenUIypsviQRy/jQnThXzHvAFx9c83HjJtJoV6QhIVA5KIYn+UTV47wR3RMzrUP7HyT35fFIrhS/I2NvunyvBLzxdnCUumZiLAAduRTyY0yirDgiIiOe0L9yP4M6RYxUaWWfHGv/N00y4iABmN6zPATVS6Tp32mUrHfBDnlD6GF8wT9MklpOvnvIQOfPOayCnzTgKDPf/sahvtYdWkn9rcM8UuzaazyEhaYU4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 13:04:17 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 13:04:15 +0000
Message-ID: <ffed5999-71b3-48cf-a669-2004696dfd6d@nvidia.com>
Date: Mon, 9 Mar 2026 14:04:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/5] net/mlx5e: RX, Fix XDP multi-buf frag counting
 for striding RQ: manual merge
To: Matthieu Baerts <matttbe@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Amery Hung <ameryhung@gmail.com>,
 Nimrod Oren <noren@nvidia.com>, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
References: <20260305142634.1813208-1-tariqt@nvidia.com>
 <20260305142634.1813208-5-tariqt@nvidia.com>
 <9f5282ed-ddda-4d7c-b033-5b6d544d6cf4@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <9f5282ed-ddda-4d7c-b033-5b6d544d6cf4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ef0cba-7342-478a-fd14-08de7ddc5dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	KVMp2W/2gOT6PUCe+kf7hjZAgFfoBqAlnNTfePfYE70Fb74KkQE8MzSgonoKmVHVWw0Xk3wIDbfD+i6Y/OrgNQMPcQZY5wGPtbAMaM04IRZadcsiChuinHDe28l5QHh4wU3vPUhpia+FVN6zyJsup+HkcMRZOt/hYDC5ccqq46nCxcHI/2zRC1nnX+OxYt26RCFt142o6gs8e/+yeUYKCyhAI9b7P7vexPkXS/stK8fWPuEHxS0MUMzmlhtbdjDQ3gLolsq4DWLan0PZgZp3YVQ7mQ57tZ/3NgVGHNwypLQ7TI+0yHVk7MJAwU7D4sFsZOWqiR1ONV7i4uqj27IX+klOsQ3/b2w3JfTfhWcdPlbC2M+BbPI9wu5W/ag50J1xuu1RPziQWhe5SJtD+T48knZAdeLuDJCsxuYPGbH1sA932z1bySK0Q7EK9E7p3vE7raPi7tbhb5jzD4y4FnegtXOy5uatPnjUo247IS4IKf4m1wpWFvq5rssD6hEy2EyrTCuEi0zsK857zLDh8hrIS7FdkntA30P8Ugo+PuVHWGo35Jyb0GXbTJQ2ydO8FVaiZFw8xZpMNpQn2MSu0ma8dDzlURYqgDH+Rlsoy0wUfkbZM0I7pasiqiwkpHPoV5k3+2xtXMP/863z+wXjKn6N6GYli2MtMMpSCkS7jSp01EI3oy7LQaUdTARM9LMMtHZ+nEZqJbyW4NLup6RSogMOm6PHvEpXLw+U7HS6sJZe5Cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmcxNldxTjZEazJlQWtLMlpLWWxmbnZMUG9nTElwbWxXNktpR2FpZXg3M0V2?=
 =?utf-8?B?OTl3amZBL2xhVGdCRVRXbkhiS3FiMUN4ejhZWUNoWmRCYS9Salk2NTRob0FY?=
 =?utf-8?B?VWlBc3VLbXZlakVCN0JIcXhKRTl2R1JHbUJtZ3Z2RmhzRkZPOVdHVUF6Z1Rj?=
 =?utf-8?B?V2Y2ZFV6THovQk9NeUl5UmdFdkN5TmUxK2JNM3gzUWJaemRxTXhRaGVNek1p?=
 =?utf-8?B?OThSSjNzTWFRaXByM2JQT2JDKzgvZGpoeGdGWG5kaTc4blZybzF0K09lTDBw?=
 =?utf-8?B?ckFkREZpK3NPZDNYVnVlVCt5Ymp4VTFwekRIeUZneEFQN0NOV2hZd0xTWjZj?=
 =?utf-8?B?bnAyVkZjeW9zeG5HQ1BYYkJBTmZPNHM2Yi9ubHpGUEJ0dXhDR05uYlB2S0xG?=
 =?utf-8?B?K3dtRHJwd1F5RWY3a0FiMEZmNW5KQWg0QjNIYTdvMGFnZzZJdUxjbWdGZGpz?=
 =?utf-8?B?NXBTVEZXcVRlOVR1dnJlVWJxNWRtdjVQVUpZTDhOYzRSZzFjMVY2WHFYY3p1?=
 =?utf-8?B?TUVYS3NRdk1TU3laMy81N29Fc1ppb05kWFh5TDRUQWx2cmMzTVliSWFiZTJL?=
 =?utf-8?B?d1hQK3E2dFRWYzF0bGw3dG15K2FWZ0I5M1dkR2NjZXdZMjRZVDRVeHExTGZ1?=
 =?utf-8?B?U0Z3VXhmMFphQjdoR2ZoTlVjZlB1anNwQXVsNERNVkF1MjB0b09WczZMSWkv?=
 =?utf-8?B?S2JXMWtmQUYxaWhabHFOZnhrU043TGRKbUlKTnZTRm9BcmpmZG8zbW84d2wy?=
 =?utf-8?B?SVFIY1ZHTTZreWJZZjRSUlNoak9wR2FPSE9kR3VWQU1KaWNrNlp2elVNaGRW?=
 =?utf-8?B?NmdpaElBYzJ4MzhnZ2JrNTJINEZMTFpWc1EvVUdlT0V6NE1PZjZPUndPOFNl?=
 =?utf-8?B?cjB6bG5sZHIrV09iTk9wVGVKcU9PTThkOENma0FYMHVNUmN5L3ZJTDJkWU8z?=
 =?utf-8?B?VTl4UWZqME9Odis3aWNiRHR2b3lNWnpZNTRscjlPUUtveGFSRUFqSzlnN1RW?=
 =?utf-8?B?TDVSN1VQanhsUEtpRE1CdE8rb0c2cHR4WUlJZkYrUlY3QnowQjRvVUlVTHlR?=
 =?utf-8?B?UHlTWU9jTno1ZHQwYlpDY1NvcnU2cTBuMGhRTmlWdGdGWkx0cUszbXVuL2lS?=
 =?utf-8?B?NGdkSG5kWjFOaDRKQ2hZL0VqK0pIOEZxUUpzY0RJeTh3SGdzc1VBcGo4enVk?=
 =?utf-8?B?aS83ekIxcEdWTzV6VktrTkpHUDF1T0p5cUtBR3ErbURZOWdvQVN3N0xGcWF0?=
 =?utf-8?B?YXNIT0NTaTkwd0JBOUQ2Mk9aay82Ymtka2FtTXd6V3pKSUV6ZlpDWENOZ2Rl?=
 =?utf-8?B?ZnBpN1Q5L0hzQVIweDNFR0ZKcWNvQWtZeEJJUDAxQnhHN2FVbkg1S1JZOHow?=
 =?utf-8?B?bElDQnNKOEI2b3VnM0lheGdqMGNnN2QySDJwaEQzY004Y05HZXlVamFMMGsv?=
 =?utf-8?B?NEM5REJwcXYxYWpZUGFUOXhYZ2d6YnQyaWFIci9XbHIreWRSUjgwSUlnY2p1?=
 =?utf-8?B?RzE3RExaQ0E5cEl5cHdURkdMV3FXejY1Zi9EcnY1cmVieUd6NnA0QWJ5dERx?=
 =?utf-8?B?dUdGaUR4dzlsZ3ZCK01kQXBRa0dGWjZMN2t3ejVUMVQraHFhYkJUZlNMcHFK?=
 =?utf-8?B?SWp3SnlCenpIYUhlTzlpSnhvQVdVWEljSDZQcUZlRHY3MHNuMHBHNEhkRFdT?=
 =?utf-8?B?YlJCM2sxQWhjcjJjMzlRcmxXMDhVcEVKcm1URVRoNjVNYmRFRXRkMExSdWNo?=
 =?utf-8?B?VVk4RlRBN3EwWGNiQlRKeVVQMGhDK2NhS3d2TTBrN3UxUGhHVDJKUmJPWVdy?=
 =?utf-8?B?K3FRaldNU205MUJMa1czOThWODlUVG9ZSVd3cnN2eVhEd1BQWXE2S0t4c3F6?=
 =?utf-8?B?ZUpsU2NMVEU0VEhLVXhueFUzVHNJZHVQM1phcDBJSGx5Tzd5T3VMak9NZFVv?=
 =?utf-8?B?WEVnM1FtOUVHZXZCeXBkOW10ZUVYdWJnWDZMTkVRb1VIYXBncnVYNW5mc0ha?=
 =?utf-8?B?Z1NZUTRqa1BhNG8vZ0dTY0VsVGZZcWxSVmpxODh4OUM3ZG5FVnVoZWd2TjRl?=
 =?utf-8?B?NXRRVlhLOEtybkFMK2pZWSt4ckZHUmtQWHhQQURIRkhQTDdhcGFrR1pWbUZq?=
 =?utf-8?B?dnVuZkE0dm5PTUhnNFF2SHBsZVJZMktmNGxVS0hiaWh6cVArWE5YV3hHcVFE?=
 =?utf-8?B?ejVBSFZDUzE3NUxwenFOaFdLR0cxdUpTUGxaQlVTbE93M0M1VzlIQjhieXA0?=
 =?utf-8?B?ZG5JQjBCSkttWllPdVNQbVRIYklhMDlIMldNaUZHcS9NR1MxN3dlcGRvWTFp?=
 =?utf-8?B?NnR0VjM3SGpEZHpzdUNOVVdPdGNyRy81R2dGV084MmNHSzU4WE9lZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ef0cba-7342-478a-fd14-08de7ddc5dbc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:04:15.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiVmwRK5owNHacGzBF11HSZJdbukwGd8YNobGX9p0EDPKdef5DnOk93TntlGuD1bdlpI3IvR0WiDi+yo1L7GAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
X-Rspamd-Queue-Id: 95387239742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17779-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,google.com,redhat.com,lunn.ch,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Matthieu,

On 09.03.26 13:52, Matthieu Baerts wrote:
> Hi Tariq, Dragos,
> 
> +cc: linux-next
> 
> On 05/03/2026 15:26, Tariq Toukan wrote:
>> From: Dragos Tatulea <dtatulea@nvidia.com>
>>
>> XDP multi-buf programs can modify the layout of the XDP buffer when the
>> program calls bpf_xdp_pull_data() or bpf_xdp_adjust_tail(). The
>> referenced commit in the fixes tag corrected the assumption in the mlx5
>> driver that the XDP buffer layout doesn't change during a program
>> execution. However, this fix introduced another issue: the dropped
>> fragments still need to be counted on the driver side to avoid page
>> fragment reference counting issues.
> 
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':
> 
>   db25c42c2e1f ("net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ")
> 
> and this one from 'net-next':
> 
>   dff1c3164a69 ("net/mlx5e: SHAMPO, Always calculate page size")
> 
> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.
> 
Apologies for this. Will take note next time.

> The conflict has been resolved on our side [1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------
> 
> Rerere cache is available in [2].
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/commit/9cbb5f8a4a18
Conflict resolution from [1] seems good.

Acked-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

