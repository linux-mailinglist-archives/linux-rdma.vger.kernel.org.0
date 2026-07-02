Return-Path: <linux-rdma+bounces-22690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aXMkEKNnRmpYSwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 15:29:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803316F859E
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 15:29:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MlnuSYkt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22690-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22690-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8B030EE36B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2B4A13AC;
	Thu,  2 Jul 2026 13:19:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706464A13A6;
	Thu,  2 Jul 2026 13:19:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998393; cv=fail; b=ArQUHrOFxAtdYU2bbZCCNcqFul+aHLZO4g0HocVeTzjzyRjKZklsyiMbfUm79sdTTXbSRSuCMkU/iJCsCtG52CApygYuURZffjd5yBYPzHIHbpANRLidq+1RE85TZNl51l49ArRH5GHr8zif34SLJ9CPtWnyE0w2mDpF7NApqMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998393; c=relaxed/simple;
	bh=PdBVS+k9vSf6zy2FX7HIIQC60tdoHETAih48kHqE/Z8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWw5pc1hvwOK7QpzbWSpbSavoe2mZMN8mFhV1220vPxuqxrKu9gGwSQ2D4SHm11mTA1HlK9VDkLj++RIXPwLrg4ZOPJfWvP7lMAHdos9LYV3gnH8n4Obkeej+XtUYrzbVNersDLvnRMVWKdrzErOoiNad45fEbtSMK/MJqDCYHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlnuSYkt; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srkA0GXEAJSrVVV9K16cfZ8nB9mH3vi1s63cZAVjtFQuDOWe1t3QioyNfdMVa1ypJP1HY9rpzpifUx/VmHG25I5frEQAENCtfCUi8sEGcEkHJEZt8/zZCXc32flZaI1v4SSTVdBJFxCMHp+AnkddlUbjem5ufXcNoMG7z7Ul+VGERJuiOHuxV2d6Dw8zVdX2j6iRaA2r680OGdsBcOdQ5WbicR4oDfWSIHFo5iDlQty980Au+t3PdOO+pGQMyyfg4do3/HeC5AoB76/4C15KmzIC5hIBbHWj/zB85FDJq+YCgt1BwbSXLRQNsxaphC6WVQzixZ29Ad8crbPc4W7Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fk6okSqBVEAM+OnIqgEUP2atRIp5mTTaqLOv6xmRes=;
 b=XUf84kBMTnCJNH0SjvTFiNZIRRDD4Nt91F9gN7oD4LYZcSupeUYwxOzdRTs1EMZjfcB67o/Edk++eukNURyy3VGOeLJl3FX6w4WhPwxR0SI6snBkcgKnGIvs4/B5EDsMn+4L2i5JQStvO1G0/xB8/Ar6zOkrovAFaEAmAz288SxRum22/0noOGOMCbDxnqrjLhsz7lLbXV8TMAD+ikuv4SqMUNn6IdLk31wUaOeAZ4OKwL2pfzPmwt1lvRDKjzrQiJ7O0zU87F8TTASaz1uGnoPCMGnaF9OWc0/YH14VA3hrG65I8UIERqAoFT8rqTOfCrABN0hURgLFDvSi8t03pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fk6okSqBVEAM+OnIqgEUP2atRIp5mTTaqLOv6xmRes=;
 b=MlnuSYktrg+BzrbYdnCITPqc9EeGLFSCcIKfCe4Gx/DngSaR0L5zlohbqsW6/QzHtdT7Wq2uWDWkLyBwyczGMhDDmC025367gUwWrOeIWVlbIeQk1sBWNdzy0Wig+cztlyD3s8AgVnI/K4ctLlDrN9EIdT3nfsv7Txeim6wvzfBJzjMvLF4HZokDRLrZ+OQj1e8jWu5ybLUvOqhQ16hl16wa8o7unmyB/CmvTu2wQsApujJ/rbz9B/xNr/GyF6hNY32h7nL7hQE0EX4evtjruItHaHzwVRalrcZzwecKATXPcoH2odqA1My1jAvKWSQNBiTflwXGRXqs4EW0LjSK5Q==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 13:19:36 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 13:19:36 +0000
Message-ID: <127fd374-e03b-423a-b500-4d14c629e15b@nvidia.com>
Date: Thu, 2 Jul 2026 16:19:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: MACsec: annotate context list
 traversals
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, borisp@nvidia.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net, dtatulea@nvidia.com,
 cjubran@nvidia.com, horms@kernel.org, jianbol@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260701124030.3208833-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260701124030.3208833-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 572621f9-da04-401e-069c-08ded83c904f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kbazw56X34knnW0Hvt63miXh65HZhPl8EvPvE6AojM+ahlMUGdsoGTRouDCsyynfMWrsNeDw2MG/bHYzNLIx+BW9qd4S8dJ/+xdGTOR+43b63h1srC6n1HI3XF3p+zCwiEWJXuv+gvrkaisc5A9IncU17Of3vFV1uErcRJnkSJrs+jjFYFfwKDlaeJDbTEIsjjVjw7lgP7XA8PqxImDdxwy61NxH9mI15Y1ZgxwolipxXgSCisAy0AE84UWzeHGkfGapN6wSlP8wrGozdC25oS3AAT20ZbBdYlkYsKCl3AVfSzGjrtH9UGw2ha2XWmfzGWrl+IBJyFIA+SKUHtXlvkaMudm9yvUbFucUWdZs3SijW9333+Je4WoC+B6vrDHsPZbv72V/foKYLPczCob+VV6oT2SNJ33AcNoR61NQQv1X7JpSsVrvRz8DHyInMTB8dsphnTR00h50PDLx/yh/dLNWjbrn3pAMjL/EyxPonqd4cpCW9mVmxXN6CgFQ5pZc/nMdNIG8eQXsLTPxTFo5vMNDlX9EvLCMdzbfFk5X8SWsuW3fv0+IdvDbGrzRHwGoNOfJHLagzYCGqSfp4HM8BNBuN9Lqa9H2l4VKHljTbIVdgbFYXwtBA7P/DDAc/JxiG48r0SFXzk9WJoRMNNuEDez4jDXz0qMNCJnwGZaoByI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGNFdUsyTHlYUHhpWGlrVVQ5cWpFaWFjdkhQZlpmQzZmUjBRdEVCME54UTQv?=
 =?utf-8?B?SU5Jdk1pbGhrTUlTN2ZhU2JXNW5jU0tXQTVDeks5UHVNVExXMk5mcXBDL0tL?=
 =?utf-8?B?WXBMdXN1ZFpGZHlBbWwxUDNPMjdsRm0zTXkzTzJRV2l5WitqTDlXZGtLMXVa?=
 =?utf-8?B?ZU1YMlVzdm1CWHFzQ3lzZ0N1ck1ncUZUWkhmRkswVTZvRTRzYTRpZ252SGpO?=
 =?utf-8?B?RXhVSUpHN3RiOFMvTG82S3NhYzhGUGoyL3pVa25zdFArc3A3c2lBQTVSdWdt?=
 =?utf-8?B?SUhvVm11K2FoTTJQejJJWWhHWUs5UkR0Ukp3RFJmM3BUcW9QVk9hS0wxOVhN?=
 =?utf-8?B?ZUlXYXpTTzFjUkF5SC9CZEVHc2kvRU1EUDkxVUVPcGFuMlcrN3RrT0hUOUUy?=
 =?utf-8?B?Zm5zUm5LQTFzTUtwQlAwbVp5Mkg3L0d6VHhLWmsvYnE5Qk4wOHRqQVJ4aFJH?=
 =?utf-8?B?NG1zS0VBWENRdEEzbHJnQjJrMGYyRkdpYm1CU2JVeTB1Z2tMbWkyMDU0S2Q5?=
 =?utf-8?B?WDV5VGtMclIyRlh5R3F1bS8ybHYwM1lzRTJzRkpNUWM5N3hvS21FTmJpVjVi?=
 =?utf-8?B?OXg4bjkrK0xsejN0WEN6Wjd4Mzk2dCtvWnJSdkFDVkhNZ2NZU282NFNRUmpP?=
 =?utf-8?B?M2hON3lGTUV0bTRPWW5IaW1VVmw0OTdzcThERTZkT2swZGxvNTVnUnNJejIw?=
 =?utf-8?B?R05NVE1mUjVpaG5SYXYxYS9FK3JNQm5hRjRYMklacER5cFk3SkpRS2JBYlNC?=
 =?utf-8?B?NzBHbHQ0bklwaUwxMkUxbzJGZ2x1eUc4OW9odzFFT2h1Y0M1Rlh3NFFQdXNy?=
 =?utf-8?B?cmlCSmpCT2NQNnlUMDAwdkxKV2FGYndxNzBMY0RXSjU3M3VTTVpubm9iaEd2?=
 =?utf-8?B?MnpMcGMxUmpSb0VRYUE1bEx6bjROTCtJWGxKS3BFWnYyWk1oUDRhNVUxdmtP?=
 =?utf-8?B?WlJZMlZwYVVxZHlIeVlVRFZGaGsvS01pZE84dWdpM2VPWEZFUlB6U3VjcmNU?=
 =?utf-8?B?SXF5dzZsTCtON015UlZFbE5nR1B5WXN4UGl2Y2NZckhRS2g0QXhhOEQ2Mm9J?=
 =?utf-8?B?RWI1ZjBIV3ppdVZqVUc4OXpHN3UyMnk0K3I5VzhwMXFjMkVZMXNPeURvTzlT?=
 =?utf-8?B?REpVUzdZQ0lic1JQS3pzVVEzbUVMbkxNWXc4RHdPNTBUWTl4RGlvMTFkSEtI?=
 =?utf-8?B?QXdNT1ZhQVF2TWV1NEpZZDRCblNCUTNBbStrMmFwdHZ2RTQ0SjJQbkJ0U1hx?=
 =?utf-8?B?VFJWVHQxMFg4UzhwbVozNWR5K1Jkc3k4ZENSMldFcUUxdzZsQ2RvNXVPVURN?=
 =?utf-8?B?b21iK1pEUEZqT3RhYThtS1RnelVHdHhJNzNXRTV3anFlYWI0R0ZCSFRUQ0U0?=
 =?utf-8?B?TWJ4NlphNElCSEpsdG1Lbm0yK3BEMW03dm1nQ1JYaEZSSU4xVkZnODV1b3VH?=
 =?utf-8?B?RjlrQjIzRy9MdUR4UFhYVXFBWllmY3Q3K2JPRGtOMXhQZXRiOXhjL0VIa0tP?=
 =?utf-8?B?bkc1cFRuTzZRdzhZdXd1UzhNSEF0THhYVTNSNmZzSG5DMXRkWDhpWFFrYTVB?=
 =?utf-8?B?QlBFa001SW9EVTJNbktrUkk2US9LM2ZwL1pVMkNYYzVkU3NuYWtLMG50cG15?=
 =?utf-8?B?Y2VLWnRiallSbE9nbUltSUFmQURvSnp3RHYrOUFFZVl3aEhwTEZPb1dOQ1dh?=
 =?utf-8?B?M3Z6bFRPc2lNVSt6NWoyckhHL2RNK0hNWjBJRlJaYVpNODI4YTZyNnJ5ZW1G?=
 =?utf-8?B?cVdoVmZqN3dEYXlnRGhLZ1RqMFJVRnA2MDJqNUg0MVlBemhOSHZyNy9OTlNY?=
 =?utf-8?B?RWswWURTR3BzcmR2ckhmYmhZMzBPRk9QVGlERk5VeitSNTN4Vy9WellvUSs1?=
 =?utf-8?B?Q1p5Z0NrR2JFYjlzWjJwekpoQWlRejhvODJ6VEpTOGpSRFl5WS9Od1d2RGs5?=
 =?utf-8?B?VTVTaGxOZjYvbzNLWjMzSVF4ZUJnN3JuRTF4UVpsT0dGV3NodndQK3M3NS9t?=
 =?utf-8?B?TUJUckI5Y1lIT2NCZzgwZDhwa05GUWg0a2t4NGRUdm9HdUVSSTczQkhScUJM?=
 =?utf-8?B?dzhvMVkrTWluTjdyUlFVaEIvQWJGYkdFY2Q5VUtSOFJUaTdrdVR3eFA5QWtD?=
 =?utf-8?B?V0x6bFdXZHp3UllhTzZMTyt0RWs0Mzl6VFFqUFJIVVhIMXJ0UFpBOG1RMGRv?=
 =?utf-8?B?QmZqVkx6OTQwRjlBdjU1MzZIRjlTTEpoRFFQMXlUSDNYekJjSmVObVV2NEFO?=
 =?utf-8?B?aHVKQ0crc0syUDJMT1BlS2I3M2RJOHFrSm5GVTBScHY3L21vTE1sN1lJb0pS?=
 =?utf-8?B?ZFJzSGRLa1JObSs5MncrSHdjemZsODcyeitEY0t3T3c5MTZQMkFpQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572621f9-da04-401e-069c-08ded83c904f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:19:36.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+wUA1mZ/ykIjoPvxZgwHcvHvzLEZPLhOo+X7ywuYk/MrY1ctRHdmXr2lgbiE3P15jzoY/g+sjQSb8G812P4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:borisp@nvidia.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sd@queasysnail.net,m:dtatulea@nvidia.com,m:cjubran@nvidia.com,m:horms@kernel.org,m:jianbol@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22690-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 803316F859E



On 01/07/2026 15:40, Runyu Xiao wrote:
> The MACsec offload control paths take macsec->lock before looking up
> MACsec device and RX SC contexts. The lookup helpers walk RCU lists, but
> the iterators do not currently pass the mutex condition, so
> CONFIG_PROVE_RCU_LIST cannot see the existing writer/control-path
> protection.
> 
> Pass lockdep_is_held(&macsec->lock) to the list iterators in the MACsec
> lookup helpers. The RX SC helper does not otherwise need the MACsec
> context, so pass it in only to express the existing lockdep condition.
> 
> This was found by our static analysis tool and then manually reviewed
> against the current tree. The dynamic triage evidence is a
> target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> to documenting the existing protection contract.
> 
> This is a lockdep annotation cleanup. It does not change MACsec context
> lifetime or list updates.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   .../mellanox/mlx5/core/en_accel/macsec.c      | 23 +++++++++++--------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> index 528b04d4de41..3028e327e36d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> @@ -405,11 +405,13 @@ static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
>   }
>   
>   static struct mlx5e_macsec_rx_sc *
> -mlx5e_macsec_get_rx_sc_from_sc_list(const struct list_head *list, sci_t sci)
> +mlx5e_macsec_get_rx_sc_from_sc_list(struct mlx5e_macsec *macsec,
> +				    const struct list_head *list, sci_t sci)
>   {
>   	struct mlx5e_macsec_rx_sc *iter;
>   
> -	list_for_each_entry_rcu(iter, list, rx_sc_list_element) {
> +	list_for_each_entry_rcu(iter, list, rx_sc_list_element,
> +				lockdep_is_held(&macsec->lock)) {
>   		if (iter->sci == sci)
>   			return iter;
>   	}
> @@ -473,14 +475,15 @@ static bool mlx5e_macsec_secy_features_validate(struct macsec_context *ctx)
>   }
>   
>   static struct mlx5e_macsec_device *
> -mlx5e_macsec_get_macsec_device_context(const struct mlx5e_macsec *macsec,
> +mlx5e_macsec_get_macsec_device_context(struct mlx5e_macsec *macsec,

Looking at the changes below, I don't find the const removal necessary.

>   				       const struct macsec_context *ctx)
>   {
>   	struct mlx5e_macsec_device *iter;
>   	const struct list_head *list;
>   
>   	list = &macsec->macsec_device_list_head;
> -	list_for_each_entry_rcu(iter, list, macsec_device_list_element) {
> +	list_for_each_entry_rcu(iter, list, macsec_device_list_element,
> +				lockdep_is_held(&macsec->lock)) {
>   		if (iter->netdev == ctx->secy->netdev)
>   			return iter;
>   	}
> @@ -692,7 +695,7 @@ static int mlx5e_macsec_add_rxsc(struct macsec_context *ctx)
>   	}
>   
>   	rx_sc_list = &macsec_device->macsec_rx_sc_list_head;
> -	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(rx_sc_list, ctx_rx_sc->sci);
> +	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(macsec, rx_sc_list, ctx_rx_sc->sci);
>   	if (rx_sc) {
>   		netdev_err(ctx->netdev, "MACsec offload: rx_sc (sci %lld) already exists\n",
>   			   ctx_rx_sc->sci);
> @@ -775,7 +778,7 @@ static int mlx5e_macsec_upd_rxsc(struct macsec_context *ctx)
>   	}
>   
>   	list = &macsec_device->macsec_rx_sc_list_head;
> -	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(list, ctx_rx_sc->sci);
> +	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(macsec, list, ctx_rx_sc->sci);
>   	if (!rx_sc) {
>   		err = -EINVAL;
>   		goto out;
> @@ -853,7 +856,7 @@ static int mlx5e_macsec_del_rxsc(struct macsec_context *ctx)
>   	}
>   
>   	list = &macsec_device->macsec_rx_sc_list_head;
> -	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(list, ctx->rx_sc->sci);
> +	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(macsec, list, ctx->rx_sc->sci);
>   	if (!rx_sc) {
>   		netdev_err(ctx->netdev,
>   			   "MACsec offload rx_sc sci %lld doesn't exist\n",
> @@ -894,7 +897,7 @@ static int mlx5e_macsec_add_rxsa(struct macsec_context *ctx)
>   	}
>   
>   	list = &macsec_device->macsec_rx_sc_list_head;
> -	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(list, sci);
> +	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(macsec, list, sci);
>   	if (!rx_sc) {
>   		netdev_err(ctx->netdev,
>   			   "MACsec offload rx_sc sci %lld doesn't exist\n",
> @@ -978,7 +981,7 @@ static int mlx5e_macsec_upd_rxsa(struct macsec_context *ctx)
>   	}
>   
>   	list = &macsec_device->macsec_rx_sc_list_head;
> -	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(list, sci);
> +	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(macsec, list, sci);
>   	if (!rx_sc) {
>   		netdev_err(ctx->netdev,
>   			   "MACsec offload rx_sc sci %lld doesn't exist\n",
> @@ -1035,7 +1038,7 @@ static int mlx5e_macsec_del_rxsa(struct macsec_context *ctx)
>   	}
>   
>   	list = &macsec_device->macsec_rx_sc_list_head;
> -	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(list, sci);
> +	rx_sc = mlx5e_macsec_get_rx_sc_from_sc_list(macsec, list, sci);
>   	if (!rx_sc) {
>   		netdev_err(ctx->netdev,
>   			   "MACsec offload rx_sc sci %lld doesn't exist\n",


