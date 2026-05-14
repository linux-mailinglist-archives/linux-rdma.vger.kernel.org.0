Return-Path: <linux-rdma+bounces-20701-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBQ+DDHfBWqjcwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20701-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:41:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C891C543533
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E5E23012D7A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A743407583;
	Thu, 14 May 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YKd0FTPA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCB3F7879;
	Thu, 14 May 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769209; cv=fail; b=i8mmkmQwec5xhjc0uWMvsraUIFLdXhXRny5TvyC2Ps6zYwIwB/2H4BIiN7Qr1P7YsPMefo6PsFfyJDhPN+CZMiMTjVxLhnyvxJ16jfViRqA9zSwW5kyhbnUXFfQ4spWykP16KrZqiWbHj2rAiNUAJbN8UL0V2T4ECAwsFwYSubo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769209; c=relaxed/simple;
	bh=6HQa4YonbC7ICTWvzWPrp/Bpq/o2UNwY3o6U3Vh3qk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WcjQfypTZzppRYDcEXReq2ZOAa8RNdaeyIS/9+G8t+JzW17NYvnNoYtWbYt4l40e5pQSmvmF6Idm47JFL3ay2u1vA8l3/OzJChBtjql1Ix58QyX+0nfdbkkzEvbsDXcpZdPbwfvKtxiPoa8RaX1u+1lf6I+vWllzQyL5jdrKvBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YKd0FTPA; arc=fail smtp.client-ip=52.101.57.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuBuoEohOfz71pA0Fb3MN1G2D5J+0KXixBLg3IHgjtylgEJqjIuB0AJbm3ARoseiB4KEed5gZOWVRbuqCB6Se1qPT2AFQWAGcCivDA/t/kYtr3Nf6q1Y0gwkni1Pi5nRmzQM9yPyxP7ie2LktcNEIePwZH0fNtOkyI3t1H7VAYtBn6ZIZn2o0srcXG66ul5XyAySVTvCLk9uC0zetBEQtfJMt5yyHBseC/bnR66If9hxFc6ojTGINebhMlk9e0Hulq5Cm2w2/hVzWIVYlQqV+0FtZysnxDOF+bVuU0Lrc0jCedwVCo0pc8gRhEFFN9DasT08/OCjjcTOV6Df1UXTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP2hAJYtlOMvW05Uqwoyn6fmzqJIiADFsUqKOlJ7ms8=;
 b=DcsBNuSpTC2/P16ekkrc1UJCLW+AANqEOQuq/mXsfQR9jR3h8g/kSh2Fb8akoISO8IkdJ27AncBGI0YKBYlSk6uyYiNRps6qLnNStaAJO/BkP6NrTv7rTtdkd9NLZOK1MPLU/5b9Ii5kqq/OnKXm9FVwPY5gxZj9vF1Adh+EXaPkFRRwbgPQu+0uunSa4rEG4KPOoVRU3c9F0gnAho9vcMjwyzH4D1oUTLOtiWrtNkrQ1seGP6Wjo/Xz4Xp40nA5s3VZAb6mxlIYfhIy9Sx/R0C3eUyOMBZq5ackEu9q6m3GOKUGr/HFbsV4JLD+u3BWzqWAAU+2bDSs63Ug6bswvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP2hAJYtlOMvW05Uqwoyn6fmzqJIiADFsUqKOlJ7ms8=;
 b=YKd0FTPAZlEeEshCMbGw05TEljZlZdcR+QfkkT55N8r2I7X8T9+PSAYs4BONiqF7rvuFaSUQhisAm/+sg40utw6cV92DhZsJUhhH6C3AWaS1PcUjO6IeCFwBr+wy3F6ITK8mH62nF4IlrWA4eeO56/aeGVCAlurYXreL4zlqctI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 14:33:19 +0000
Received: from DM6PR12MB2860.namprd12.prod.outlook.com
 ([fe80::b2e7:252a:a896:8a19]) by DM6PR12MB2860.namprd12.prod.outlook.com
 ([fe80::b2e7:252a:a896:8a19%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 14:33:19 +0000
Message-ID: <4dc23648-7ec1-b68c-0e1b-282e014e534c@amd.com>
Date: Thu, 14 May 2026 20:03:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next 0/4] RDMA/net/ionic: Misc updates
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Allen Hubbe <allen.hubbe@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Eric Joyner <eric.joyner@amd.com>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506155954.17e984c6@kernel.org>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20260506155954.17e984c6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To DM6PR12MB2860.namprd12.prod.outlook.com
 (2603:10b6:5:186::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ce4a8b-ef7d-4304-0717-08deb1c5bdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	3mBO2HRUWsPtComp3ZZq1+28stQ5qr+ZbwOYy6MU2G6vu1IUizUwVoLeyBMJFQvypPHBb1jYNg8mgyjC4eoP3xelCr/vbp/m4L43GPua0TGrNdPKeJ40Z2+l0s7pZ79uPbdIG+3L/Wt7r2YsHmG0TRDMohSrXUikYatDiDoGoZVAFmW0V2XdDO4OnQ9VNliNwDMy2kZtFqZaEDoekD8HVd9IV8T4fu++2NkFJYtEo2VWywz5AudNISIYOUaRw8a2KqcZdJZceYDmh5Bq6cJZQqsfCJm7RnDUC1OzarcssmyXARChaVSn+ytLTLsf+h0WNZfsxfIEtLQBZk661AeF5PyCh6Bj5GeXW/Hllk6VAvX2VeS3og8izX3xwNK758C79s3+1GgwsiqHvztHqb3E+dcZ9VB2BEnD/OxvN+MmsVn+WC1kG8OrFiqYwEt4+3bTQoYkJ2RvUH/xcC1myxBM4cl4bGNaRINfcHFLk+k1vD+p9ryQxQjTJ14d1TfPLnPBiZKT1TsF0jkKYbiXjKIHjjIOJGoKt/0e2BUw0rEbZnXylF9t0F/OQnG8rZY19gQjHcOCCAZjSN84u3Av1wYfIqmu5az0PA7tNTpu9tURUJbMeQOMC4ckwE4wC1lx8qx8gDg6yN7kNDGlSYxIW8eLm2WeMkjhyiC+7/VZ6sx4f/e5KVHsOcHSg31nHJXzlsmN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2860.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3hPWFJhNGpSTitRUy9UaUdTT20yK2R1RDAxc1F2MFk5OUtLNk9aMGdLTnht?=
 =?utf-8?B?RkUrREdEaVVqK1dTZ2lLNW1mdTE5UE41NXRCeC91blREZDAydmg2UjY5RFFY?=
 =?utf-8?B?NWlKRzEycEtSQXh4UGpiQWMxb2JJRzgxNVgzRml1Y05JYUJRTkxXb3RjdTlw?=
 =?utf-8?B?RlZLc0V4T2RML3M5UGtQWC9FQ3FqNzh1eHBqTkxhbXNtTmkrb1NZWXQ0WUNh?=
 =?utf-8?B?WVlGektuVWpUejJGVmZYRUN5ZGFrTStmZmlLMDBXQW9TdkJUMnNHM1hZbS9G?=
 =?utf-8?B?QUprTXhOYnZ3YW9FNW5wa2pwU2diVVFyMVhUOFU5VGtHV2p5dDh5ZTBQcGFs?=
 =?utf-8?B?RTRqa3BnUnkwbnNjdlliTit3SjFZUDVlbWovRHREUmpURXZhVVZxclRNZEp6?=
 =?utf-8?B?MzJVcmN0ZFZkaEtPTVpuK2EwbG1wL21hdW5vemJOUzhIQ1p0TjNLdGFDQVpt?=
 =?utf-8?B?U2lqUnNuRlh0aC9qUlk0WjYwVS9oNk5LanAxbzRtcmZPazFQNXVuQXg1dE1v?=
 =?utf-8?B?Q1JkbW45eHpzN1hKYWp2VzJaQm5ISThVS2RpTjdGeWlPWnQ3Rkg3TVYvVHFV?=
 =?utf-8?B?MDFDNThoWFB4TmlxeUt1bkhQMEw0UHJoZFUzTW1oYnNWZmhmaG1ramh1clI2?=
 =?utf-8?B?bkVXdzZGVnpzWWMrYlRYUjJMeGJ2Y3dYT2lGUGRNOWxGUDE3Z2hOTnJLM3V4?=
 =?utf-8?B?Z3N0SDF1YzBDSEdYU3h2eEJ0ajdyc2RJc0RjNGNwTGk3V04rNGRzZG5uYmVF?=
 =?utf-8?B?dEEzODlwYWVva1M3QXhGTUpRQ0NCQk5Yd3RxTXJvdDRxZXdvNzMzSWNQbXM5?=
 =?utf-8?B?cjRIL1UxaEkvQXd5ZnpkWGJ3aHFZZmpjTi8xTkZhd0FUR3ZPaisxT3NZSDlr?=
 =?utf-8?B?MDRGaldEU2hxK2ZLMjNlMGR3WkdWLzMwY1ozbzNVMUZtaTBnZERRekYxaGlN?=
 =?utf-8?B?NTBFMkVVRUl2Qzl0TFNJV1JyNnVYSzdZSDNZZVl1SGMzei9tdmxlSVVlck1R?=
 =?utf-8?B?b3VyeHdWNWNubksramU3d1pFN0ZGZWgrL0NkVy9RM3BmL2pDSlV2ckFVNFY0?=
 =?utf-8?B?VXlDSS9LSVZGSlVBMmZOaFlHdUNKVzhlYVhNbDduYThiQXBqUTlxWTRvV2Z6?=
 =?utf-8?B?YkdOc3NkVEx6TE5BMFhtS3NYTjd5SldQT1lTYzZTMzZjWnJudnBMMk9CTWFY?=
 =?utf-8?B?Qkpmd0NSZDBKdUhxVE9mMTI3S25tQjJsVkVpZXJmaFFXSkJrZjlkM0Y3NkVF?=
 =?utf-8?B?VGYrV2t2emtQb01mS0JLRzZ3RHdsS3d3Q2RyM2NDY0pxSmNEbWZpUkVkYUFF?=
 =?utf-8?B?Z0h6Zi9aVUJsTHpGTFhjektOd3JqR3BaV0pTcjkxRHpzMU5SbTdPZzVLODg2?=
 =?utf-8?B?WEZJMEtXS2F0eFVYTURyOXEzY0J5ZWgvVUg0VXRKcXo3aWxCNktSeklCejY2?=
 =?utf-8?B?NkVRMEdmTFViM3Zicm9jTkFLQzRuSzNLNFNRcUplOXdwVXY2NHRxZVVYaXpV?=
 =?utf-8?B?Z0VnYkFNYmlScExrQkdpOVNxWFAyRTBnSzBCY0FPNE4xQk1aeE1BQVZxOUN5?=
 =?utf-8?B?RW9qczlsTWNDaDNyQnJudWJqSjAwazJRSndJNXFFc09RYlZPRWdZVm9QdTVV?=
 =?utf-8?B?Y0g4a2ZEQmZzNVpJUkRMYWFPMUJJQWY2M1RDMFhLanJQQkFFQ0l1TU1DNndy?=
 =?utf-8?B?WnlOZHZjTlArZkV3NWUvd0k2Wkt4eE1HU0R5OS9YOTNJZjRtb1N1RmJJdUpl?=
 =?utf-8?B?VEx4QTc1U21ZUngxNjFqRHJ3cE5GcXZRT2RXUVU1ZUR5L1J5S1A2N0dhSlFB?=
 =?utf-8?B?VUFmVlFNVlVKb1BXdXpUUHlSZFVFYzRxRjB0bGpueUdpUHk4Mm4ySk9Nb2V3?=
 =?utf-8?B?MjhGUlRpYkNBd2o1WlV3VmoxZ1hnTlo2SVpJMlA4d1lsbWZqa1lXczBNTW5W?=
 =?utf-8?B?ZzZ4dllRUTNYOUhySXVrOTgrdnhMZldCSEpGazVjR2NveTV3RFo0a3ZnaFZW?=
 =?utf-8?B?TS90VnJMVVU1VXZmSzRLQmQyWTZBQ1c2ZVJUU0FKS1ExdWVwUjFJcVlEZXpG?=
 =?utf-8?B?OS9CYXlaZURXTlEzODRkNlArbys4QURoZTZ2cVF6c1ZYSEMrNGNEQ2I4TFRj?=
 =?utf-8?B?OEhKcm9DcmxYTEFRSmtzemVYREJJTmZlbUlBNzd5V0lzQ080aExhZEVZNzJp?=
 =?utf-8?B?RHZhWFQxWmIxTEYxcXU2N0VMaEN6aEljSmpLQ1BFQUpoaityVys0NVNyNFI2?=
 =?utf-8?B?NFZVRmhQdTBsZlp6U2wveGJ5RlVBVU44emFDVDBDNU4wcUdLTlNnRUpSclVD?=
 =?utf-8?B?UjFkQ042UkFQRWtBZVhKb280VXlGQ0paMytrOFp5UTAxZjJybXNXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ce4a8b-ef7d-4304-0717-08deb1c5bdbd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2860.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 14:33:18.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEIU6FHDT4JXYp4mckcBHnvMIxBjgPCGMct7jxolmpkSPDMQVMj/4XdVhojblLAtlWyJR94QY6NO220b0P1D8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
X-Rspamd-Queue-Id: C891C543533
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-20701-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Action: no action


On 5/7/26 04:29, Jakub Kicinski wrote:
> On Tue, 5 May 2026 21:19:31 -0700 Eric Joyner wrote:
>> Other smaller additions add a devlink parameter to the ionic ethernet
>> driver for enabling and disabling RDMA,
> My understanding is that the devlink param was expected to change
> the configuration of the device. IOW user can enable/disable RDMA
> to save internal device resources. You seem to be purely preventing
> the auxbus device to be added. So there's nothing gained here compared
> to simply not loading the RDMA driver. What am I missing?
You're right that the current implementation controls only the auxiliary 
bus device registration and doesn't reconfigure firmware resource 
allocation. The intent behind this devlink param is to provide 
per-device granularity for enabling/disabling RDMA. In a system with 
multiple ionic NICs, an administrator may want RDMA active on some 
devices but not others.
That said, if this per-device control justification is sufficient on its 
own, or if firmware-side changes are a hard requirement for this to be 
acceptable?

Thanks,
Abhijit

