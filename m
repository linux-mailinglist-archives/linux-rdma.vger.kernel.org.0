Return-Path: <linux-rdma+bounces-20696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OUAIdvBBWrXawIAu9opvQ
	(envelope-from <linux-rdma+bounces-20696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:36:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB565541B8A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B7203061DD3
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946B389104;
	Thu, 14 May 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abz8rNkV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E833C3421;
	Thu, 14 May 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762153; cv=fail; b=dkQzibWlEnMpgLN+a7LYXAoW3zlbVyVM+InmtnWDqgJKy3dn5CdjbOSea5R80YC+m/PeLWZJm8AroYaadZSdnVkvPuSid8q+AGucCQyDYkkTa/w3MlWJOaP1mXuy29W5UktaFrHHtFaYywXV0/wo/dcqBj9/eB4AjEW+tDvILJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762153; c=relaxed/simple;
	bh=+p/fmXvUiICgLRekY2CNZUwRvcVvzMDHF47AfBtkOKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VBA0f31Vej5yCqpl/T5/gfyF/xML/XqMXnrBDoFLc0BdBXPefW+Am4XSULRJxAFY7rivI7dXNF2OScLNAXZaSUTIjrGlJ6/4zpyIe4sGLBq0kkSJg6mWCEg7YWc/FXZaNVXBLP1y1Bf+xzzPM7Mj/Au9aB4Ie0o02+DMIM3m2O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abz8rNkV; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv2zDF/RLbriLXY32eP4FRA6wiLAYqh/MHON7OKjqwzCUB1dSpsGVBXD6JqTjcdVY4J8sXytt8sV1rEG0Lhy0Wvyv5kezuXafbYGm1jGHTi+LHEanOEK8smJfcrOzknHjzUS9DXTLiJGhEGcmR6aahdZWarAInxXF2S2CKR45OpEiuAnB9OeLJ5VSBS2JcI7IbB7W8c2jHx/KAlH7j0ElVKUAKaSQIRx3jzfqeUKmUYykIIRiKtqoHuoaWhbqmcLMUcCr5dhdEqlAAIAqXUk9axSwD3kUHx/3wLOT7ZhAma1xxTefDIYEvc6JvWmz6DKxDTKfdOsp+zn98L/JDpyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgt6d0H7PT8GOnZ9B6ENbAwjyDVauzu/Yggv/dlk/ys=;
 b=MipMrFfuK6cD5bbRjdAKFddu6L4soigF6gO1Z7tLAymn+Tl3fJbrJIQktXkfYQhesUuL/aEMQDanaFIf3XlvyfN5Pa9LLETXupJVz6RBuWeqHqQtvZf5xKsgdQKa+Ap17jI2pYmNPu7FPu6/sIpN9PmP63ttFw6EdXS0MxtdSfdApyY21hc5LNGiaTh1NaygBuZYObEsycswRex/oAmNVM/0pelxqsd/PS+tQ5NwPGiTYJ1jnssr5J8YUd8dUZPQCiaZwWzOftGolLfFBhtlEKhxTq4k+BLTHK5omuplAbCWiT8krtGCPP6w9N11kHIuk2oLJ1lrMtPksmeUNnEr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgt6d0H7PT8GOnZ9B6ENbAwjyDVauzu/Yggv/dlk/ys=;
 b=abz8rNkVRnAtNuzlHTuvbWGgpBFS5i3CBpa1xnjLKLF5YS/MlzB7qul8JZ0GpiD7wKbDRY37U/dX/g8tVoeiougW7AuMx3VZx2RL8Tug89v8BUvphSpyYlUSg7GEJRCroBesViuF0NW1emY4SBv0i+ZXkV4LA1mOtMaEZqiRx1BnNzLHoYtPUmjgXT/iug6np+SeRh59tcYWkGgzHYMvzRMiqm6PaXrUb+JSmi9NQMpHvWRve8LuxwupLGW21wOahXsokqZ3WzGgrNXP31clhfe+F3Lh7KpG1P7bDfmSZjHnD/jBuKIBke51m95NqwuozugOchEzC2klA/p+ltM84g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 14 May
 2026 12:35:45 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 12:35:44 +0000
Message-ID: <a5936aa0-6798-4f8f-a238-49ba590b0ca3@nvidia.com>
Date: Thu, 14 May 2026 14:35:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>
References: <20260507095330.318892-1-tariqt@nvidia.com>
 <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
 <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
 <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com>
 <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
 <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com>
 <47630ed4-3028-4716-816e-d4f803423b37@nvidia.com>
 <CAMB2axMOWSsYGyuXOnCQUrpCTGJa_Yy5mKOxErX7N2x3BTLKbg@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMB2axMOWSsYGyuXOnCQUrpCTGJa_Yy5mKOxErX7N2x3BTLKbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::11) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 45781dfa-28b7-403b-0432-08deb1b550e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	3FGEwUSbfWqkVFEyGyG5Cgvw8UL5Yclo043yVmYgXnHHzSm26L++PBgqaCSpxGYRtsbBJNk03tRTr4JxxfcElbgD7Z1osAb/zJ80A44DO4+dx2k3Y9M6UGkK4rHMscV/wCfSEVjL/Tk50k6R8ygQyPBe8Tu0DBv/iXY9UqqBxmRYjooQbjMPVmscjvYBmbsFRGJ5iTiLny9WxTBbwNqGa4wv4h839+jDjjT9sID1eridtuYAUjUlFY0jTtYUHYGrC1yGay0MqLdF2BsNGqP96uiRMn5Kmhz+CmQPonWWdlOfmAcqEapvEr0krg2x4eRLlkFyjfaLTcdVSYfCqpU5H7XmYCXQSXC2/Wz+qDgpW1suAzgB/w0bd0dI9a1FjoITtjEDTWvTEjtW9y2HTJVJjJhc447oDQbm9kfkXZ+9zj8WI540/OSdY+kbHIvCSEaD0+s+/zjQoClPZjs/c3jQVCNCPaWk2rWnSBpO3BY0Lndh16uzjg8iEjKg7fS+dtRHVNw+fARqKnevmyDYg2km9bKl1eB4GAwvbE31zLJlZ0o1yyTznitHWokeOKUHVH5o237Uvpu0+153RCoG76xSZeRxoUhlUN4PEY7KjPjtc0JqWbY0g1/EGSIXSAzE5Vy1bCBY61Kb+upSaWKNCnsGuUcfvvMyy9G70dx8E3nvyKXkGR4D7vcvZjQgJ/YLolaq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2Q4QjU3WWQzZDBpelpwbk10RXNiWXJqNFEvZW5yOWFTU3kzb3BtUSt4bGFr?=
 =?utf-8?B?d1E3cGQzejV5OHNPbitqNk4ybzBkYkMvSy8wZmJWT2lLMXM4NnpudkVQWk8r?=
 =?utf-8?B?SHFpTXpaOWtWdVZjMnFRVE1RNlRzMzNkMHpNcWtZdHVDRDNmSGhMbHorcWpR?=
 =?utf-8?B?UlRQL20vR1ZGSVBDbFQ3ZEtkTkVtZ3VTSlZtcEtzUE5yYU9zYXlESklJTlVR?=
 =?utf-8?B?S3lnOURxUTI2VnJXNGg2SHZIbnBiUnJRdlYzWHlUeXEyOFo2YnNvZ1kxMit4?=
 =?utf-8?B?NkdEOUIxbkRBZTFscWhxdlVVUjRYWVdSTzRnaDJXNk9jMmtuRFgzQUFHRUt2?=
 =?utf-8?B?cTJYUEJ0bmdYRDhaQWpZekk5WXlBZ3c0SW8xYitRMEF0WHRzdlFmeTFaR3F1?=
 =?utf-8?B?b0pUZ0dmNnBrNG9qeHNocjJhZHFBNGZMTHVrbzNieVdidEJtRG1kL2owZDNM?=
 =?utf-8?B?WUl0VEFEQ1pBVFVWNHMzTUFGWCtDWFlkSmVtWmI4aVljZmNpVnNrVWxvODhG?=
 =?utf-8?B?bW0zbG1ZQi81NE1QUUZ2eEZRcklOaXhrRHJaUXhWWDlJVGxOblhNN0FCd2lI?=
 =?utf-8?B?QnVzVWZFUk96V3lHUWdCaGZ0eEViYmVQcTVwOWg5aWtBbTNvQllidlhhQ3F4?=
 =?utf-8?B?K0QyVlBMZm1ld1VpdXlJNkN4aHl3VWxjTFhmM05kbFpud2xnQXMxWFdESDRV?=
 =?utf-8?B?cm5uMWRKRGlRdDA1UVF3YXdDQWxjRWVQYk1ESlNndVRoTnVMdWsyT0h6R3pH?=
 =?utf-8?B?bzgwY0VJVEdHRnMyZXVudldFMlVaV3FPR2ZIVGEza29iNUtSdWU2R0RTQ29B?=
 =?utf-8?B?MVRBei9XTXVMWkQ3Q1hweS9xMTJ3dml2ci93MDA5NllrN0J1V2lhY0c2cHVv?=
 =?utf-8?B?R0JQZXBrVVI1bGxvaVh0U0dmM1prR1ppMG9HbTF2YjN5R3RjZW93MmNHUWhM?=
 =?utf-8?B?bGJkeVpuVUpuWVQ5TmYxU2tYaS8wQzVvajRaK2hTNWJPcDhsa0R3MFAzNmJv?=
 =?utf-8?B?L2RRcmtCT0dSZjBHU0VNNFFFOFI3KzE4N1BjZ0tHV1BsNDk4enF5ZHNRc2ls?=
 =?utf-8?B?Q2hqSEwzc2hidTlLV3VDTmRRejRwOXRlUDFSZklhYjlBT1lYQUNWdUlDS0F1?=
 =?utf-8?B?Z0tZMDd6Ylh2aE5Wb1krbHdhZTMzSkVpRmtYV1JVRDRjOVQvL1QzV1lmMmU4?=
 =?utf-8?B?WU1QZWV3TGY0K2Rkc0VxdExkajBhY21nb2pVdlVIMFlYbnZkenVZaWJRcllR?=
 =?utf-8?B?aUJQNFdQUlNVRmZpTm9jellXK0tPLzJvVHNGbGJxTG5WVS8rSVlaeFBnaEJB?=
 =?utf-8?B?cmk5aDZlNWZHVG83TGVUM3RrUmpVSGVRQWdUSi9sT2lvZDJnWWxsYnNFSHgv?=
 =?utf-8?B?WDJSZjJtdEpkcWFENjU2bnE1aFR5ZjIyQ0tDMk9xMW5hbXhUSUVIMkZHRzhU?=
 =?utf-8?B?Ylh0emkxUG5tVGMrR0ZzbHVabmJvM1g1SmVWWXJ5aEhWQUM4dDluSXlZYXRP?=
 =?utf-8?B?Q3BWeXpJOXJjMzZuSGxsK0Q1QUlmN1FTUVNqc2pQaVM1V2k2bjF5cy83d3JY?=
 =?utf-8?B?SjFyV1pQL0JmRzZ2NEdhVjdORWhRMm8xNnUzazFRcUhSem16d0tjTkh0SlNi?=
 =?utf-8?B?QWR5Zk11Z3VDY2wxampMM0FwWVJVckd1QmFMUTlaalQwVmFqQmpBVDNNejJu?=
 =?utf-8?B?YURhM3ZSSm1yOXVodWpKRmU4UVN5ZWZWejNqUms4UXFIUHd3NHZWNEdNUVQz?=
 =?utf-8?B?ZDV3TzZjdnY5Q0N0NS8yQXhEcC9wdmlNNkp2UmRwbkxmeExVMzNQUnBzc3dk?=
 =?utf-8?B?L2FSVnBlc1VIYm1Rc3dBMC9PYnFMOTY3Q3dWejk5dmV2ODRjTCtEbEErVi9K?=
 =?utf-8?B?cGkzc3Z3M0c5QVpvdDVza1BxcTNiaktmRzhPL3lTMjJIdDJaWTVKd2RXTDlo?=
 =?utf-8?B?ekNzTUtNZnZlWDg5VWg2ZG0yclhYWGpPRXJOQWU0cXJGSnBvYiswYVArMlhh?=
 =?utf-8?B?aFFwZ0ZpMitXME5IMlk0cXRqVm9ob1VYYit4bXJLVTJNcFJiSC9tRWQxbzQ5?=
 =?utf-8?B?NlUxTm5GUVQ4aWxsVHNkcFA5OThDaklTanZNVFNpVVQ3algva3ZaQmxDQlNp?=
 =?utf-8?B?d3FIeExFbHpKRVp2a3Q4UzA2UjFvUytKNE8xcng2RmF0c2xxM2tDRWVqVlo3?=
 =?utf-8?B?NnBJU2I2SDc0OG41Y1pWclkyOGRQY3ZQaUpMMk43TnNwcGt5Y01wZWlmd20y?=
 =?utf-8?B?TWdxRlZxQzJ5cUtKMGIwU2ZRZW9Dc2pNL3BGaS9WVHZpREI4Y0pPTURtM2ov?=
 =?utf-8?B?OFdTVEhEUnMrZ3JCZ25pNXlTNnlYNHN1TzVCcFlyZWI0Z2cxSG1Ldz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45781dfa-28b7-403b-0432-08deb1b550e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 12:35:44.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnL73S6Q6bYKfhw3jB2Jl62wfPIftQUZqFWKUyhyvJn2D1YuJtt3a13g3nVSuasBm2wVz0dNiKMtYYAq7Gb7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
X-Rspamd-Queue-Id: EB565541B8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20696-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Action: no action



On 12.05.26 18:30, Amery Hung wrote:
>> That would work, but maybe with one less conditional:
>>
>> if (!len)
>>         __pskb_pull_tail(skb, min(headlen, skb->data_len);
>> else if (len < ETH_HLEN)
>>         __pskb_pull_tail(skb, min(ETH_LEN - len, skb->data_len));
>>
>> Tariq suggested to make sure that we have an xdp selftest for this.
>> Will take it as a follow-up after this series.
>>
> 
> Sounds good. Make sense.
> 
Holding off the patch for a bit. I was curious how bad it would be to
always pull at most ETH_HLEN (as in the else case) and not to read the
headlen anymore. So far results are encouraging. This would simplify
the logic.

Thanks,
Dragos

