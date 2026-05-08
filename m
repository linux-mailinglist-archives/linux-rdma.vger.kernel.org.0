Return-Path: <linux-rdma+bounces-20239-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHvkL13n/WkPkgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20239-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 15:38:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA34F72AA
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 433DF309F258
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D103ECBF6;
	Fri,  8 May 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dSb2hifj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF03F6613;
	Fri,  8 May 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247068; cv=fail; b=pNKTr1aUfug4CdXDGT7+PTDESeYABELlcA7JWwW9TWOWodmOouR/U/yQELk9uj7pGJlFwNEtcu5BOT1+5wAKfR52mlk336xbFyw+88YA7eap0D9p4Kwnba60eaQiwUmIY8M9kjFxRgAktZ39ywnu/UrAIccEgKJyrCCQdaxlwkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247068; c=relaxed/simple;
	bh=aE0Rg6cc2+xy9fCbT2mSFDoXk4YZ8JmcF3kXA6Cl/kk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDRpBl9jUXHty9c16iImLw0hU9F5TCLa4IIEJ8L2RmTXIlChL7bNkrGBpihhXnpRV21j3tSPRarVXNO023Uqf3UssYLWIW4u6ZrXGL8qSO5VMRJClrRBhgTjlYnwJ2dxCJuTfY8bRQasCFsplxdJzlHo5RuOLQtK1jclLi09l9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dSb2hifj; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZyKQVdeIfO5fdN+Zn2aAkexvqVZCG+n6KNGgM0Ibq4kolV3fE8daLvXVRy8IpXmBKMOmSdk5WMh9Z22tX3wbYN9li7EXOPV/AOZJole6nYK830QlU27K43cXFApoxBqweo5C+kRgsx0VwMpuhIc4W3AaewEYEDGQC5a+GxN/qNxZbJKUoZZMTbmXXq7kVBhpU3QseotXgyvYbUBZDhKJNqgb49cfmfPdav7yVFp/QuvHjQVhVfSlfJr03A2NUX5UP0xtVHR/sJPr6dZyUagXhrZUphXrKgjdOVblqOZwgq6Y8xhV/8h0rsmrgwVrkXe5cIy4+k3o2JkGOLeBAcyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WXLa7xszPrafKb7dVQHEFFYGd6pIR+Hd/OR1Pw6o6c=;
 b=Mo7eb1JFoOVix78N4i4wmzPEw3PZkV9bF80mYooJPlALjnviTe068YwTWlEtbCifJ9DN4b0CeqoHzrYFPvUZp/cxXdhPC5NjJtFKQvGoCkF2ReGj71VPtuvP2YdBaFgZiEr+aaf8f+XkJojSHaQiiJ/cYY6FB6a1x+iwKSKSzIGbXGLwk9Q2jQ3mm8UbI5srIYI0I1GmlOvmshYBH+avsGjvInLB0P8LXnjIqjpT/1i0sqvcl7kyd8bFkwxnd7Vg7Z8r5rGCtqBxcuUGFGDvaP4zCvO78+E/yq7C4aazflercayVD6T1pb69c9XkVzR/U7sko9mqobAQrx0fY8bwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WXLa7xszPrafKb7dVQHEFFYGd6pIR+Hd/OR1Pw6o6c=;
 b=dSb2hifjDbT8+8sMHsjJvYYBtusp68+HfWYW3Gi6/VuuP8jokmebbbaE3k+gslZgILFxPu0psCDN+lttCfT7jwGI66wzNpVod0wTT2poRM0YyZbSNseLvvpN59s22XMGmx8oFwy8JkyVnO7n6V9qt802TsARrEvLgJqR5lloVXqKCIFE/1J6HDRpB+hOvEB+ymX7mz7/nnUeokhJi7Sic6k2l3z2K7y232wyVHWT2OXdENmR+n32Q9uu1k8/rjSD5nDxApQaHLbXemzIkWcqsbQqvsTXRxJ9jN6W6ALBEiRRs0BcLmCzxklFp6evbF1BHVlPl1Oabn2awVxFIdJ/YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 13:30:46 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 13:30:46 +0000
Message-ID: <ec8e758a-6f03-43af-afa8-31632f18737e@nvidia.com>
Date: Fri, 8 May 2026 15:30:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: David Laight <david.laight.linux@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Amery Hung <ameryhung@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
References: <20260507095330.318892-1-tariqt@nvidia.com>
 <20260507095330.318892-3-tariqt@nvidia.com> <20260508134343.6651d7c6@pumpkin>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260508134343.6651d7c6@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: dc84dddc-f3a1-45f8-f041-08dead0602be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mO4WspaQLpXTVuzHc1Jlv+031r0qNSVCUJAIStsN9anHNU13gVgvFOJgaOH7PIhqIf6gyMMp4V8IdAq5CqdQ37ieW8rDS8LZ6G4Yya+EtLkNLeWjDzbbpNlWgbolnCOL+uspKYiIwKGVHRsDoaU2BspVGcjCCeCEJPMy3HmNBwMm7vEZlXLcnetfzI1p/dS907zjQNn69uvMuCfgaJ6SC+eOvb89driHMFLT0CGarlz+bQ8sksnb/kZS1h3wnyoazeT5AL4fno64TTe/jJFcpuT/COIbdnqGtH8TOQ6IW3gmuQfBEEOkPelfkR2Ftb9/fz75vuvOlIez10NaKsb0Dv4DqyHCkYF7sNkxSKMoStN7h0cPSGEVYA9UoV/FkA8AfoDCDAK3EiPS4+I7PMFH+xbMn5PGTF2It20vxBCc2LzHZ1ToNjxeN0yxu9UJsQ4E5pZRDyAl5sJNBcVjdjVI06ug1bItlyNOnwYM/EwqnN46heBjhfYUt12aa0cPFDJKKGlff4r1JueRclYfEGPcUIhKvkhE1Th2qV6lzetn7FoiX11BB7GJ9nj+zdXZL7kyyVuWBfMmHry+yjrEtSTZj5U5zD/oECHNrMF+zb5BkOkhOB96FY/GMQrx0itLJT6cxDbjvp3oczi2L1CuNyhrJEqOu5kIfKtLjbwJlIYpoCZJgtBLVjn/F4+UhWQUAnnT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(22082099003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzRYVW8xMnlDcUdkbkxPeVZuRGZCWWpYS2xpeWY3VEptOC9mYU9Rd1ZXRUcr?=
 =?utf-8?B?aE02ZHAzK091UGduOVFhNkUyU25ZdmNYemR3ZURLMWVUMDRJMzEzK2NPb3Zr?=
 =?utf-8?B?NW54RWxRbzdITFBzN0JKME9TeGFxQW5TNGRqdDAxamVNL21mT29heXVmUU1I?=
 =?utf-8?B?MzFVRjE5YnRnUEhRajBKQmN1ai9xYmVRamk3K2NSSHZocjJCcTNDSlpLVkN2?=
 =?utf-8?B?dytoVCswakNTZTlDclV3TlczVWRTOWFQWkc4bGFsWTNYdjF4RmJZUzY1UVNq?=
 =?utf-8?B?RFM3Nm1OV0tlbDhhYW81c1dnU1pNSkxzcjI3RGtDTE9xU0tNRkNFcVNtNWR3?=
 =?utf-8?B?MVpkMzhnK2pIZW9KSzBxSDhHUXhGOWhaYWRMZEJrWSt3blY0R1I2T0M2Nmpj?=
 =?utf-8?B?Qjc0ZXBlRHN0Z3NIeVEwRmN3QXBKMG1sOUEzb05aOU1VSEZrOEZ2Y1RqOVV6?=
 =?utf-8?B?bW1wUUlmZUl6OTF4ZWxzaU8raGhNbEtTV2J4UXRoTjF0OGJCaTJSa0NpeHpJ?=
 =?utf-8?B?NjNVZTdQc2RCZFMvZEluaWdFYzVmZnBpZ3QrNENQRUNlY2dLS0p3TDJmRi9j?=
 =?utf-8?B?SjNKNE93N1NJZXRXVHF2d2VTZ1dZaURoUTBnM05CQmdCN3Z0ckdFTWRGSC9V?=
 =?utf-8?B?OVlLWFdYa1VzcGVPYXZyeGZlT0ExdDN3UGNWU2lHNC9MbkliMUt1bmVqZ3d4?=
 =?utf-8?B?OUlYSDBGZnMyN1kxOGRGdnFvdU8wb0ZvM01FK3VSNUdYenNCeDRVcElya1M5?=
 =?utf-8?B?TjAvMUVTek5ib24xMmNPMU1yUm5ncWREZGxRQ3orTzVqN29YR2JWSCt4Vnhj?=
 =?utf-8?B?alJRU1gyb1ZGbWNuM1BieTVLdlJqUWl5RjB6TDkvUGZOSnBSZnlGak0rUzIy?=
 =?utf-8?B?YlorYzFyMnp4QkVvU2ozTVZLUmphV1NHdzZraWRsR2FISDhoK3FFanI2VFpz?=
 =?utf-8?B?SVFHRVFWUDhjWnNPRjR5bkdpdndTb3dDSEVYMElyUVR3UVdJanUySVVaRmxr?=
 =?utf-8?B?N1hVdGRmbndzK1dhb0tsdXYzYWx0Tlp2YnMrdmUzelJ6enZKRFJzL0RsdnBv?=
 =?utf-8?B?c1h2eU5yMzd6YWNJSEU5SUxPcDI5NmUrVU9vV0trSUhVOUJkZ0QxV3RSVlRu?=
 =?utf-8?B?cDRRYStWRm9CY0Q4SW0raXVPWWhYYU1MdXdwTDh2c2JZQXdTQjhSOEpFR1Ev?=
 =?utf-8?B?UzBmSmVMdDlOdll2T2trdDdSQjdSQTZvTE15YXhqZzBqZXQwWkV6b0dBbDJQ?=
 =?utf-8?B?Z1hQRU9HTkkrSDZPZzMxakJ1enlTM0hOUkg4OStrd1NqS3E1cWZOT2s5czZj?=
 =?utf-8?B?N2Q4blFMc1RzUzVjMUd2WmZabTNxdmIvbHRDT0NpdEpBNFZLK2xJNzFCWks3?=
 =?utf-8?B?RVFQTHhyZ0loMkQ2THFwZUlnbVMxbXdCa0VpekVIN2JHZGJUWWVsNkNSUlNa?=
 =?utf-8?B?RGhtWk8rTHo3LzZyTk52Z056M2dEODJIZ3huWDBCOXhmV1VOdHFSOXI2c1ZS?=
 =?utf-8?B?Tkw3RklNOWE3WGI0enFYQVAweGtuMHo0UEpzV1hneDJKL3dOQ2dpQzdBSzk3?=
 =?utf-8?B?N2tHUWQ4NVNrdlQzMVBPSkdzVHNEVU8rcDNXRktLVkhnTEpLVW5DY1FEZmkw?=
 =?utf-8?B?dUFwdEFNN1BrMmRVK0svS2kxR3Jwb1VtR1BodUFVR2VxNDR1VzNNMjA4eEth?=
 =?utf-8?B?ZzQ4NXVra3JIZGppTnM5ZHBCaFpVWlhVUFBwQ3AvYWJNSHJoeVkzNlAxcW5p?=
 =?utf-8?B?d01wRkJCK0dJSE9pRHZXYmZnay9yVkFjWS9pR2VuazdjY2l4ZFVSTW1UblJT?=
 =?utf-8?B?RXp0WjBDaWxhSGp3M09pYkxmdlhYV2l5OUJzYmJRVUN2cVFNQ0UvdDlrdVRG?=
 =?utf-8?B?M1hSTytJZ0xPaG03akVtQk1UTTBZS2pzdUVJalFkOW1QOTJkTDh3KzlOMmRl?=
 =?utf-8?B?TFZwdzJKdlk5RERoTVc4U1JFaVNVK2g3WlNGaGtmUFJORGFJTGMxOUZYYjJv?=
 =?utf-8?B?Y1BHY3FPS0ptOTFsc1VHbzZ3b3ZMN25TTy9EaTNZMGVvZ2pFSGs1RGw4Q2Ji?=
 =?utf-8?B?VUxLMkdUNjVnZ3VhMnRsTHd5Ny9tWEJLdzVDQ1BkeGpuR1dkZnE2Uk5KYWIy?=
 =?utf-8?B?eDUrWVlTWnhZTVFXS0NLRXRrYkxCcDYva3gxNTNJOHJzR2lXRlFzVzFEYlZ0?=
 =?utf-8?B?S0pneG8zOTV3ZnJqTldyRjh1dDJVdy9ZdlB6cEVtejJZK085bTkwUnNNYTRX?=
 =?utf-8?B?Y1RxRGNVbTh1OWdya1NxZzIyNHJVRm5rV3VnQmdKYmZJSjgyMXYyc0pJUndX?=
 =?utf-8?B?ZjJiQkFNOUZHUXJEeHdPVElzRVVkbG5Ucmw2elVvYnQ2d25aQzEzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc84dddc-f3a1-45f8-f041-08dead0602be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:30:46.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiG3KZAepBONYTZCYxFgByZjrMfNCDClqfzFoII4hTuJFdWdwAVvNMthOEJnZy+nNyWEVxUlAOFs92dbrwd83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
X-Rspamd-Queue-Id: 28AA34F72AA
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-20239-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 08.05.26 14:43, David Laight wrote:
> On Thu, 7 May 2026 12:53:29 +0300
> Tariq Toukan <tariqt@nvidia.com> wrote:
> 
>> From: Christoph Paasch <cpaasch@openai.com>
>>
>> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
>> bytes from the page-pool to the skb's linear part. Those 256 bytes
>> include part of the payload.
>>
>> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
>> (and skb->head_frag is not set), we end up aggregating packets in the
>> frag_list.
>>
>> This is of course not good when we are CPU-limited. Also causes a worse
>> skb->len/truesize ratio,...
>>
>> So, let's avoid copying parts of the payload to the linear part. We use
>> eth_get_headlen() to parse the headers and compute the length of the
>> protocol headers, which will be used to copy the relevant bits of the
>> skb's linear part.
>>
>> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
>> stack needs to call pskb_may_pull() later on, we don't need to reallocate
>> memory.
>>
>> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
>> LRO enabled):
>>
>> BEFORE:
>> =======
>> (netserver pinned to core receiving interrupts)
>> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>>  87380  16384 262144    60.01    32547.82
>>
>> (netserver pinned to adjacent core receiving interrupts)
>> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>>  87380  16384 262144    60.00    52531.67
>>
>> AFTER:
>> ======
>> (netserver pinned to core receiving interrupts)
>> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>>  87380  16384 262144    60.00    52896.06
>>
>> (netserver pinned to adjacent core receiving interrupts)
>>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>>  87380  16384 262144    60.00    85094.90
>>
>> Additional tests across a larger range of parameters w/ and w/o LRO, w/
>> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
>> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
>> better performance with this patch.
>>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
>> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> index 75ccf40a7f17..301b33419207 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> ...
>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>  				pagep->frags++;
>>  			while (++pagep < frag_page);
>>  
>> -			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
>> -					skb->data_len);
>> +			headlen = min_t(u16, headlen - len, skb->data_len);
> 
> That looks entirely broken.
> skb->data_len can be larger than 65535 so (u16)skb->data_len can
> discard significant bits.
> 
> I can't quite see why the subtract can't overflow either.
> It is entirely non-obvious.
>
A check will be added for that.
 
> There seem to be far too many u16 local variables in this code.
> Typically they just make the code larger because they require the
> compiler mask arithmetic results to 16bits all the time.
> (Only x86 and m68k have instructions for 8 and 16bit arithmetic.)
> The same is true for function parameters and results.
> 
> I think all the min_t() in this file can easily be changed to min().
>
Will use min() here. And for the rest of the datapath files I will look
into a follow-up patch.

Thanks,
Dragos

