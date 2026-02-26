Return-Path: <linux-rdma+bounces-17238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMZeG2eKoGnekgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 19:01:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9191AD2E4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6F1531BC411
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB100355F4F;
	Thu, 26 Feb 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Azvr99h0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABF355F27;
	Thu, 26 Feb 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127559; cv=fail; b=V20q41dA3r8uViJLQ6JBu9FQbk5o3IGPhBfoIeHChdGu5D8nYGdeb08Z39CLvD7xJiq0Ca3aKquy/9E7pn1fXEfYp2bDNNnZ05qITru72ujncatSZAxvtv7i7VUV8CWxDnynWTWbBfWViR8A4uoHR3UvU9fWBqMizlV9TdPhamE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127559; c=relaxed/simple;
	bh=eKyWH9Twt2jVPyHViUONl1Q0S45Jc5a6Cwr9vEUCc4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E2+EDjJAViOnnys44XnedOKIvSZfvcubepcNsurHBRHeyLU5A9nDRwK56YtV70cPAzCK7TV06RuDQiaWF8YuvqHV4Ouu7gv2zwnVXTGe4W/Z81jHdwjxmNwR4VnyDGfS1jn1JVEjU54uMcPO1kDRxbSbrU6LO5dUGo418KFjl0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Azvr99h0; arc=fail smtp.client-ip=40.107.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhDM83xBFS90NR0QfLj2cqWstN0Pvf+N0NlCoD3880tt1MXdmWMgkDatsoNITi/gdtaBcvbIJrIxfpDRnE8EiEulhdcwgW3dpSL9T9FdCK7NwkQ/Gj/fqPvpfZdgL+OlqJvtmJNBczSr60/1T7PYCzvlYr59wFZriJZIxT6lpbFXB5XEuXSaplWrAD/ubX2vE2jMCMs4XizzpxqkBlTeafgmYFMUzXajMrNdF4lDsBg9/ozSU6usl33gog4wNRSpIINaFkJRkHLoSRIAbLdIMcxgeKJLlQmYeF6vXgiFw7Em/zO/0EaSYnCsYloPnDpTdmsiJd35ZPwvOknK++qwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MvOGeNz3nu587NFk+zyP4uN3zBBw2wQoe+oQGGOh/o=;
 b=fEkABGM0PpYHmvHV8hHPT6jwB+eWyDu4kR1CMo3xiTyejl0YOBchb0hiRTJie61SQep1zgaH6FNblLHwMetzBq9x5DM1w0BVVe7HyD+TZYC3WAh0fEKiC+1SSzShzZgaEndwQnN08TbuEhFdlEXNeeYjgMAVjJ/88kOgyry4DpknW/eyxaVpNMtfRxHgouCqfuiZAFCJrtnsmTxSCT+7RoyXK2FMS6JoGFjzRObFPntq08UUV1IFbXASszoB+gmPfdfWgZShe1AEMQGeaYaVXcFGkbjWqpqULN/gVfkiSTPRVLTIqRhW+UCBx6wV4n0E7kEgYH+G2wweGCdfoLB/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MvOGeNz3nu587NFk+zyP4uN3zBBw2wQoe+oQGGOh/o=;
 b=Azvr99h0b28xSxRQ3cjKD35yLTESjt4Vi9lVKOxskVA3rFrcfwRorkcjYdLLpNl2EFPElcdzRT8Uw03fUgm2HiadVYsTG07WYkohMjjdsRY6az/0UGJFm/7P0c+utxJAQL86sSMzK1ydr3sD6d4xEvD35WfZlkf4c3o5Y7UrsDYZifROmIAfwHkJlZNJGs/YlO5aJA2NH9dj2qyr0/XyUwClPhl2z4lqPIz5t+DsO2fUvu88VSXg6gljydNE7MSxTIgbpOAaTy/1Cn735qjaX/RsceohE1mtLMsps+g4F6Y9pGbeMPqfny/RLQ4JU6Bant1UkpJghN86IPmAdMfM3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 17:39:14 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 17:39:14 +0000
Message-ID: <48c7be0a-0dcc-48c3-92dd-6cdc390adc44@nvidia.com>
Date: Thu, 26 Feb 2026 19:39:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v4 02/11] IB/core: Introduce FRMR pools
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
 <20260226-frmr_pools-v4-2-95360b54f15e@nvidia.com>
 <20260226141143.GJ12611@unreal>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20260226141143.GJ12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 638414f9-7327-4afe-6302-08de755df52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	/NXiSbctXJx53Dw/u4ripi8TAgFFp9embMr+WMwg3HM5qQvqdzX2ypm+0bcT6IqOL9YTQE74MssDTJJLGjWt5c9DoTx73cd3ZVVvZSyt3DNP15EebH4lRKDaAi0j9tfcqS2OR5LHGDc6vaexGcw/mUlNZU0FTuNUUoh60145cXWcT4yLBxZ+AwzvmLEAdfyyRX83+uAwjZ/xQLsTNFPHBLoYbG/OIFeZbCx9IepBBI1AHHwFCEor0BxRmXEtTRQbwlfeedBribV/m23RQavFsW4Hy0G/xBFy5HiQHjsAr7+x0K9183xThVTRfsPTthXr8LUzLEN1GM2QLU5AFz34qOcUwGhuqdPJt7diTN2nYEyh8LFdX5W2prMQOmEjcEAs8fzNOGU4eeuvFblas5YKpwwJKZc+nmkzTWGHNdUHF5uLPv/tyjq7FlaJ6SznauUnfSzI+O3TcuLeWjA80PBuV+dZJ+FbbKtkABKIlfU0Ckgfjx0j34+KG8zzEoPpzqYwt9m6ZnaCXZY1+mNN14O05MAhjy0ck358R8hrs9PsfDyY9EA5ncHKphXoKCq9/EzyNX/5YFOimcBS9CaIpI67o5jocPBszdhGD8HoMUnGPYKP84xKeB/Zl5uQT2+pIFDTTAnAvyx4UY/yB2rLZ1+4p/v3tTvsOumcK1LwNkdumqR4eL8dTQVkjLVYDWqRWr+mjqyawH4qxOMLJ1/c0EppRLB8DnZJ12ZNCBSxkdi2M0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1h0ZkJqRlJMbFBBYWhGRXlRQ3ZuNTcvd28xYWt1OHltYTc0b2tVU2dHT1NJ?=
 =?utf-8?B?bjlFTk5ReTdoWWpRdThRMVYySnNTZWpCMGJ2VTIrTFRFUmd3WlZ0RVhwR0ow?=
 =?utf-8?B?MUlGQm1NNGZOa2RIWm94QWJpeXFwdDdibDk5YStsOVpnbjdhM2trb3p6WVNX?=
 =?utf-8?B?QS9FZnBrVlljR2k2QXVZNFByT09EWXBMbmdxb1J1VUJjYzkrb0g4a2M3Rzgz?=
 =?utf-8?B?WlI4cG5SczY2bU9mWlEwd01JWFJhbCtaZDVBUnZjbEYrdWhNZGxzRm1wUzJ5?=
 =?utf-8?B?RWlUSWZmU2NwR3hZemhOc2dzWkRyL3JsVHRQQU1lbW81S3FOMGhsNXBsbVFv?=
 =?utf-8?B?SzdONVRlQmVDQjFRRXdWNHBLM1NZK3BvS1UrNXVNSFY1MHJuSWpsU2habTNv?=
 =?utf-8?B?cExNcTBUaDNiNHdtck44dFJ5YUg0TytSeHJKRGtNT0lpdjhWUi8rK2NXK3dO?=
 =?utf-8?B?K1plMGlXcGR3SENFVWg0ODhVSUliVXBiemZxS25Sc2NDVW1lQkl3eW5JQXJR?=
 =?utf-8?B?ZkN4UGt3OXpKcGg5cERybXVnQVd5RW92UXRicGMxN3BhM1dKdTZubEZockRo?=
 =?utf-8?B?YXZZRTBhZDA4dW81WGVCdGZrZ2h5ZWtBNGlCVFVCMkF2TER4Uk1jK0J1N2k3?=
 =?utf-8?B?bFVIVVkrcHVLUitmYUxXTkVFVDJxZE9XRkI0aVEyWnhmaWV6SlRNMmxCZEVl?=
 =?utf-8?B?T3JmQnFZRUwvNHQ1Q1FOV2hrSlBtU1JUa0U2VGkrc0xjTEkySzZlNzhMS1c2?=
 =?utf-8?B?dEJycytydzFKaWdmUGpnbTVKRG0ycEtveDVGMTdkYVhONTlaNktqV1JNa1FT?=
 =?utf-8?B?WloxLytmTlk5dkZFYWJlNit3R3I4R0N4NTFMNURnaTN2Zy9IYjViUC9GYVJQ?=
 =?utf-8?B?eTlkcU9qbHQ0WXpnODNVN21ySUMzZmJtY0pKMytsV0xvNGNGTUF0eldDUVVL?=
 =?utf-8?B?d2Q3M3gyVmY1VGphQlBZTWtkOHl6ZzdrK0g0RWVUTU9JZXRReXFNZHdBN21y?=
 =?utf-8?B?bXpTUkxWOU9ObjZacTQ4S1ZHQzBMb0QzcWpXQ2tsZmRzeWtzTzg0eWJMWTVP?=
 =?utf-8?B?THo3ZXZiQUNHVnJna1ZiRGpTN1JKVlZ3UkNVbVhkRTQ0Q0l1Mm9OQ082SGkr?=
 =?utf-8?B?YlI1N0U2WitvbHFPOWJRS3ZqVzZSRkdzKzhEVmpndjRjc0VtV1V4ZEozZkx6?=
 =?utf-8?B?alFPNkpvRDMrNlRlTEMvRUhMaGIvajUvbysrWlltUDFBYnpWa3VUcTFoa1pW?=
 =?utf-8?B?ZDdRV1NFNnh1K2ZHeURiak5xOTQzTXI5bFl3aFkzSE56UXM5Y0s4NjVXOUF3?=
 =?utf-8?B?TlIzOFhJeUNiK1hreGU1QTlCUk5wTzFDWFI3c21RbmxvbzVBTms5eGt1RHNY?=
 =?utf-8?B?OU9peDNHaGJ2ZVN5Q2tjOUUvcFFJcThJZE5IV01mVnM3cFMvbEtIOHNnOXFz?=
 =?utf-8?B?L0doOHkrTnhLYjFZd285dVh0NHl0OFZuZWVtb0d2OUVxdzZVSFRhdmNsWEdW?=
 =?utf-8?B?cUVTRWJKY2tYcWdvV2tQWkRMNXRRdjB1bUNWUitiOE1GVzBpNitSeWtISThR?=
 =?utf-8?B?eTJQaGZJT3E4NWhMVk1Pa3NUWUxjTFBXOHZZNVdsYnJxVzhKUUM5WERCTDU5?=
 =?utf-8?B?Y25mN3g3b1ZmOWk5UzV2NWFjQXh3cFNyaEhyKzdkVE5VZDVkYnFPNzhiZEE5?=
 =?utf-8?B?M291c1BuWDMrU29zTlJUU1I4SkpiMXpTNnovanF6Nlo5b0d3c21jdTAvNk9n?=
 =?utf-8?B?UjhZM1F3VlNaYlJweTNoMEk0Z3JSc1NMTk5lWHViOU84U1VDVWlSTEhvSjRa?=
 =?utf-8?B?THBCR0tFeEg4K1A2QTNHdStQbUpGc1BOb3laaFR3dlBGZzJvdXZaNDhWbWxa?=
 =?utf-8?B?WUdGRjFOd3MvcExlS051NkQweE1FVStKd0VjcDU0cXhDM2Y2VU9HNTVycFVF?=
 =?utf-8?B?aW9aUWcrMkgyL2l2RWMydnRlcktpTGpaZDZsb0NZcEJSWmZWaGh3WlVqMnNZ?=
 =?utf-8?B?T3RCKzV0dUJRczZGckthbVVtR0pweTgwVUZzQkVYNXNkTEZiSE92VVZiMHZZ?=
 =?utf-8?B?ODFXUEQxbVI2WXFYOTZZbG5TQktJRkFKaFFOUTA2UjAyZ3NVU1ZCS3Y0Mzhy?=
 =?utf-8?B?SmdDZGY5T2toeW9tT0ZWdk10WktzbWk5K05mL0UwWGhtZlk4YWJicVpKbkdI?=
 =?utf-8?B?TThOaHZsTjZzWTFKYWpPUVVQZXl1UXJ6bVJyNVZpdFM4V1dudi8yYUlieGpN?=
 =?utf-8?B?bHBnbEIrb2xjMGxBdkdPVVZ3R2FuZ3hzUFlXWkk2UEFOVVYxWXFmRXd5VUtO?=
 =?utf-8?B?NkNsZ1E0dmJUQjVFVHVWU0hBWG9lUGh4ZDRTbzcvZklKY1JUaG1uQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638414f9-7327-4afe-6302-08de755df52e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 17:39:14.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu9bm3zbJ9AFDRfAEOqQW1MBqTugJoMSiXW5F4/hYLqcztFPsMr6AGtFKQA9HFi92kRwIjryaQ/Bq2coetTfZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17238-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: DC9191AD2E4
X-Rspamd-Action: no action



On 2/26/2026 4:11 PM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Feb 26, 2026 at 03:52:07PM +0200, Edward Srouji wrote:
>> From: Michael Guralnik <michaelgur@nvidia.com>
>>
>> Add a generic Fast Registration Memory Region pools mechanism to allow
>> drivers to optimize memory registration performance.
>> Drivers that have the ability to reuse MRs or their underlying HW
>> objects can take advantage of the mechanism to keep a 'handle' for those
>> objects and use them upon user request.
>> We assume that to achieve this goal a driver and its HW should implement
>> a modify operation for the MRs that is able to at least clear and set the
>> MRs and in more advanced implementations also support changing a subset
>> of the MRs properties.
>>
>> The mechanism is built using an RB-tree consisting of pools, each pool
>> represents a set of MR properties that are shared by all of the MRs
>> residing in the pool and are unmodifiable by the vendor driver or HW.
>>
>> The exposed API from ib_core to the driver has 4 operations:
>> Init and cleanup - handles data structs and locks for the pools.
>> Push and pop - store and retrieve 'handle' for a memory registration
>> or deregistrations request.
>>
>> The FRMR pools mechanism implements the logic to search the RB-tree for
>> a pool with matching properties and create a new one when needed and
>> requires the driver to implement creation and destruction of a 'handle'
>> when pool is empty or a handle is requested or is being destroyed.
>>
>> Later patch will introduce Netlink API to interact with the FRMR pools
>> mechanism to allow users to both configure and track its usage.
>> A vendor wishing to configure FRMR pool without exposing it or without
>> exposing internal MR properties to users, should use the
>> kernel_vendor_key field in the pools key. This can be useful in a few
>> cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
>> property that the user registering the memory might not be aware of.
>>
>> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
>> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>> ---
>>   drivers/infiniband/core/Makefile     |   2 +-
>>   drivers/infiniband/core/frmr_pools.c | 319 +++++++++++++++++++++++++++++++++++
>>   drivers/infiniband/core/frmr_pools.h |  48 ++++++
>>   include/rdma/frmr_pools.h            |  37 ++++
>>   include/rdma/ib_verbs.h              |   8 +
>>   5 files changed, 413 insertions(+), 1 deletion(-)
> 
> <...>
> 
>> +// SPDX-License-Identifier: GPL-2.0-only
> 
> <...>
> 
>> +EXPORT_SYMBOL(ib_frmr_pools_init);
> 
> It is odd to see these two lines together. Either update the SPDX license to
> 'GPL-2.0 OR Linux-OpenIB', as we do for uverbs, and keep EXPORT_SYMBOL() as is,
> or keep the current SPDX-License-Identifier and switch to EXPORT_SYMBOL_GPL().
> 

Ugh, I missed that.
BTW, we already have the same inconsistency in other core files such as 
cq.c, mr_pools.c, rw.c, and more...
Let's replace the license with 'GPL-2.0 OR Linux-OpenIB' to stay 
consistent with the rest of the RDMA core, where all exported symbols 
are used under the dual license.
Do you need me to send v5 for this?

> Thanks


