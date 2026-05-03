Return-Path: <linux-rdma+bounces-19881-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFtRIS2I92n3igIAu9opvQ
	(envelope-from <linux-rdma+bounces-19881-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 19:38:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEBA4B6CFB
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644F6300737D
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1A375AC4;
	Sun,  3 May 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b20kgcRJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB361DF27D;
	Sun,  3 May 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829925; cv=fail; b=krUjQ1i/t9z8PV+VnCQLPBOdaNtNCsw+nqGOPJYg2W0vaDNzdIP0eNEEbEcjnHqOrKGskcpeFpTJNKY3oZorx13ljtJOSD1g1eXf4t3j+Q0ujAf8OQplsszI5ATcLh7HnZWsvOMaH9NeNNh45T1tKWpMsEwVyt+j6E4uwAxA7k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829925; c=relaxed/simple;
	bh=SD888p3Ao4357HVBR6eEiLlzcOLY1grrAorvigX8Mq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Md+1c382CyDHmR/W3hS9jazlnS0YiqKoWm9abn6fkJUn05vf6XWTWKRCm6Bm5evKRqT4831GFXf2WDrMod6yBUK8QEczaejhH39xIh4ZaG5Ex6ou0PQ9kXb4y2D6QQwHp0yFjJrQqQPrUPHIx5/HspFATCak6ohm8EI1RU7UpyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b20kgcRJ; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKNZkOn8CyKyF/1Fn0JDjRuAbyNBTc/fTDTndKiLuvBwgkZgsh9t3fDADwFh8tkC8lgBjIgMyRKcmn5GJYBwnBKh5vEaauB6USuwGlNErvxTs1shcSEZsDTl49si6Jsv1rfTvAGdcWgMLSHjvEvBpND8nH48gnithvuZMuubyxSs7f2cduxrGb+b7NGwwZ8Nujuin7cuXcU3ugoWVwbcNXKk4kzK2Nu46gKwL6w5LdB8m6BJARllx+kUzzK4vabX5/p7fJSQu21n+Z9L+ulUmo/aWssQMJA0tdhKWh773PKGMPWg9jPn4fPePpHYo4whd4DhA4VGtpjLWNvJU3tWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMlus44j6y9Xu8nS1ZKQ9qr/pNZN18OCkTHdLtL2pZU=;
 b=NMIGK628VAFZsjX1QYYV59LpLrX0mZzOPdXAuVS4Lm9EhfSURXzbtiz1EdRj42mWyLmWy6oXVay7OmR1X8A05yZxnWZBRbaQpXfs+7OlolAS6+zi5m9dSx6gmHq7y/G4OflxjVE+uTr4PscY6HTDE3Y4qDDyDZOspOJqalaZj6ZDRjC6Lg9669IcQggTmKYpPtKpXNlmFhNN2GvQRhEfe9di4PyXO+1fIgqIqZ2TJbGIDMyt3Zn2YIEfHOu5fVxatZNZgfvGRd2KgXi1EcHgYbJl63L5wD5vPxUC1zritqutTEm5I8gOaQxmJ0pkQt87+B+A5wkWhANO+MjFI53ZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMlus44j6y9Xu8nS1ZKQ9qr/pNZN18OCkTHdLtL2pZU=;
 b=b20kgcRJkag3/t+IDD/IPvmmYDH1RxT+ZRRYQhtgqceT+QnAsXqEJ+pU2BSvQh1UnkldcQb/W2bQat8/Sui8Q6asAYo/UBQCu5sfx3swRO3TN2vEAR2SDPe1PP/porsqh2h6xe4U/aW+lSBZ+LyesrCf+QdeZWUz6ex+E9HO1X2q5+RyHGrJSGx+zHhR/mwM880eM8qdUcq/MV55YL1+IO6BFzpwOzFDgD3mUaS3CjUwmXO07ze+wwgrweOOgHYcWnQZDOnGvzcagYV1J76iJanRDAu8YTL36GE6dUDKjM2K3+G7egNCh1Y8igCeu7EjCj8u0fKmUkFsIwnXQ+7wpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 17:38:39 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 17:38:39 +0000
Message-ID: <a77f42e2-2565-4bae-8d24-e69d931b7949@nvidia.com>
Date: Sun, 3 May 2026 20:38:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: Fix flow steering alloc unwind
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: shayd@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260501232031.41688-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260501232031.41688-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: a43c5152-224b-4c6f-e29a-08dea93acfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DF/bU4NNtcGSH28XzoAoRcLO6h/oApbJpYI9+k/fKLJC6NmUS7UxwNlBEM16c0gNrDvYY2ceIbyTuk88Ba8WngkmjOcynLegwi0u+kD/VId36utswLjkJe+HcVm41D/dYyN78YEFj3+Gph8JVp4DhX2zFd2u1Z28Kh6JV2/zE68lj8aA2d15ztfuRcV0jVNP4kAENYOxZbeM8P0No2S3xDl/Ym/QF4A5/+sA7cKT6ck8B8I/TCyPaO/mzpInxRQMfeqINb8Yx116DguzeribuBqzITf1uKKUGwMlU2TZ43YVlg3XkIc7xtkL+rCJ0/1YhUHok7RpW3BHWT4ACYFke7wxrZrPdpLMgA4nsv4DzsHLjNcL1CdF2kjAdRENTq0bgMuyzFHYECWpOGoFN8qLKRhq4AvpbxDQLTCM/ZYf3odGAcImVjXGXDMYrkNX/h4akCzp2ZsbIglWedISkyCGWpSt9VDwU2CR6KEbrEF2YzEQqNWnsr6uNV2ghL4XsUNKt8+zINbE4SGxjKXTJcmkfz/5LDH6fg6JAxq3doWOBw/EqBHpg5OKbXOtvtKKfu0e6g96nZ5EvWTYplJKekP8oT9BaYEQ10chINHZ4i6JlKxwWDPoPtw5cYy/s8AWsXw1JMd8GISGF2WR+08bpzqf3lHCnExOkSqXAMqJZLtazGO2cKG/42zpQaBwyBfteV6e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2I3UGpJUzVydkNWWHU2SlBwRy92MitZQUtocWV3am9pWE03TGdvN0M1Yk1u?=
 =?utf-8?B?c0tjd1BUQlJVNkYyZ29TUUhhWFd2TzE2cFB4cU80cElJdHpRcUNjaGM3OE9V?=
 =?utf-8?B?MU1xRkNHS1IwckZUQWdmVFhQMVhlcHhzREc5bDVuSm1GdzJoSERJRnF6VjNV?=
 =?utf-8?B?eFVpVXMrMjhjUWV4Zmk3TWRuV3FZNzlnTFJiSHhQVWJFUG85NXMzZWpveXdS?=
 =?utf-8?B?RlRoMTYyZktVSUhoVUZiSndqQzhjUElWRGlaZS9udVVXMkg2eXc2ZURIUFVn?=
 =?utf-8?B?RXpPM3NITkxxZ0poVGpaZHcwVlRvcHZyNERQVG5jQkxWaUQzUGduNC9MS21w?=
 =?utf-8?B?K0pveS9ZU2grQzlXSFlyY2JySW9BMWp4dWpPT3RzVEVrb1hHU0FaTGtRSjdj?=
 =?utf-8?B?aW9YUlJsYjhlWFFFVHhoZ2t0SjkxaTBlTXlJRHhValFWVmRyYTA4M1hsSU5n?=
 =?utf-8?B?U0FwSndMS2ZYam5Nbzl1TlEvRjhJNlBidWVNL21TOUI2V1NYZmJHbTRNM3pC?=
 =?utf-8?B?TitaN3VwR1lFZWJDZHRYTDJFR1YzOHU4RlBRazRXZXVDRTJ4RWMzbVJCditr?=
 =?utf-8?B?VUxMd3p6WjV2TUhibEpsOXVTeE1HTEcwM1FoWU1BR0J5UXMxMUtnWCtGU1U1?=
 =?utf-8?B?dElEQ3U0THZqdHJmanpZQVlTeWczc1VHQkhocXUxbjN3bkNuOW1zQkIvYjBh?=
 =?utf-8?B?ZnJuRWRyWW82eks1SHpsUHVDVFZLQ2IyZ29sTmRvV1JQSTBJbk5abFk3Q1lF?=
 =?utf-8?B?TVExbENZOHdQM0ZmbDladGFmTjc3b2ptdXpuK3Y0QnRBZEpDaEQreWE5OHNB?=
 =?utf-8?B?RHlVRW02dFBKMkdkejhHYXQ4WTNnL1FmUWx4TGZ3Ym4xSlloUjBoODg5YXli?=
 =?utf-8?B?T0ZsNG5INVJxaCs2K2JvRU9WT0Z1K1hCc1pLaWFYalFFVEtFTXFUYy9tVkcx?=
 =?utf-8?B?NWdoc3NPYS9OK1dObDhYNllEZ1JXRVh4cERXNlAvcm5lRXErVDhCRTVxVmdO?=
 =?utf-8?B?ZEhJc0dkV1FrQjVuZUd4QndjM1AvSGg2QXFHTEpmeG45NEVteW1mUkdNY3RB?=
 =?utf-8?B?TzVLRVQ2ZjVXbklXdGFYZ2Z1Vjl2bXlZUzdieEUreERUWUlza0dCOFJqVnEy?=
 =?utf-8?B?b1JPVVRPZzYrNU56YkdWKzdtYkxlckt3UTgxMnlxbDZPZnFmbmwxaVVrNGJN?=
 =?utf-8?B?V3N5R0RlandlcGEyN25Vbk9CV2FzVndEdHRZZ0pERGhLMWp0aUJkSHRhVWsz?=
 =?utf-8?B?cFlzRjZSd2FqNGRNRXVkbEREQ01IYVRmc2hsL1hGY1JvRk9HRmZneFpWdHlr?=
 =?utf-8?B?R0ZjOWpJOWZyekQ1WlFCMmRwb1BRaHpVeUhNbUpWdnEybmRPVEhycFlYY1Q4?=
 =?utf-8?B?QVZwMG83Mmhzei8vbHNuZnpvSFlVeUplWFNoaW13UHU4QVNwbnR0QURpWFFt?=
 =?utf-8?B?Z1A3d2FrTTBwY2ZOL0dMNk1sRFJvcWtwUnFVejRkSkRnQlJlWUhqUFV5VmFk?=
 =?utf-8?B?QlNWQ0N6dXpDcXh3SjIxNXQ3S0JrTURMT2RCZFNrSjRwNXhOeldQRmNmQmYy?=
 =?utf-8?B?UFEvTWFRUFhHWTdPNHVvUjRGVXpISzUvZ2pxYUpEKzM1VFpsVjdHN2hDMmFp?=
 =?utf-8?B?aDBPY09seHltbUR3UVV6OHR4T1Q1T05TOUlYZTE1anFiMmdkeEJGcTZFRTUy?=
 =?utf-8?B?RVVmazEyYWI2cU52RzZqQ3hWcjUxbUZpT0JOT09sTFBuYjdwd1hnUnNXckNa?=
 =?utf-8?B?cHJlbnRwWk1lWGxOMElnWncybzhXS3VZaDI0S3U3Y2VqYWFTV1NZWmVOdlNu?=
 =?utf-8?B?dWhES0Fvb2wwdTVyc3dKQk5IY3pwa2VoUnZDMDA2UGJSc0kreVI1Vlp4UkR1?=
 =?utf-8?B?WnprRi8xUzYvS0cyNUhmMWlWN1JOTWEydEFUTm9aRHdTeElGLytldFpwSEcy?=
 =?utf-8?B?MnE3bHRkMWZNdWswNVZGNEdJQVd0S21iU1I3TVNDTVE1U1AxU0JUN0ZKd0VB?=
 =?utf-8?B?YmNSZFRxdmJwbnB3QVg4dExEVzVLWUxuNHMwUllXa01ncmV3SzNXKy9hMVFI?=
 =?utf-8?B?Y3kyZkpaYlNnY1Q5MS9pU0g3RTlncTZHZTV3Zitja3pnRUZFOFBZSUN6UjZV?=
 =?utf-8?B?cUQzV2RvRC9HVGxUejJqNXEzSVJUSmFwMkFZQWV3N2VJTTJDTzlsYmdSN3p1?=
 =?utf-8?B?WklmK3FCVDgzOXJkM0FQaG4xN29INnBRSnFzV1VMVE10WjRuZVpZV2JoRWRm?=
 =?utf-8?B?cnQ4NlRla3d6Q2QwcFlMMWRKZ0MzanlXcVR0ZU5Wc09XaWFrUm52NXNNZ203?=
 =?utf-8?B?ODU3L3QzNWVJSkNCVnppdnhDL2pGRnBkb1MyT2plT2xoeHJqMkdvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43c5152-224b-4c6f-e29a-08dea93acfab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 17:38:39.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxXwpCifwbHZ4NT2HlkdBYnsTfsevxLKGqux41xvjlFfMs0dca9md8VlZZrEDWXob+PS+j9mh4Dymy1N72Njzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
X-Rspamd-Queue-Id: 2CEBA4B6CFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19881-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]



On 02/05/2026 2:20, Prathamesh Deshpande wrote:
> mlx5_fs_core_alloc() uses mlx5_fs_core_free() for its common error path,
> but mlx5_fs_core_free() dereferences dev->priv.steering.
> 
> If mlx5_ft_pool_init() fails, or if allocating the steering object fails,
> dev->priv.steering has not been assigned yet. The error path can then
> dereference NULL while unwinding the original failure.
> 
> Split the unwind paths so only resources that were successfully
> initialized are released.
> 
> Fixes: b33886971dbc ("net/mlx5: Initialize flow steering during driver probe")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/fs_core.c    | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index 61a6ba1e49dd..e1662dcedbf4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -3984,12 +3984,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
>  
>  	err = mlx5_ft_pool_init(dev);
>  	if (err)
> -		goto err;
> +		goto err_fc_stats;
>  
>  	steering = kzalloc_obj(*steering);
>  	if (!steering) {
>  		err = -ENOMEM;
> -		goto err;
> +		goto err_ft_pool;
>  	}
>  
>  	steering->dev = dev;
> @@ -4011,13 +4011,19 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
>  						 0, NULL);
>  	if (!steering->ftes_cache || !steering->fgs_cache) {
>  		err = -ENOMEM;
> -		goto err;
> +		goto err_fs_core;
>  	}
>  
>  	return 0;
>  
> -err:
> -	mlx5_fs_core_free(dev);
> +err_fs_core:
> +	kmem_cache_destroy(steering->ftes_cache);
> +	kmem_cache_destroy(steering->fgs_cache);
> +	kfree(steering);
> +err_ft_pool:
> +	mlx5_ft_pool_destroy(dev);
> +err_fc_stats:
> +	mlx5_cleanup_fc_stats(dev);
>  	return err;
>  }
>  

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Thanks for the fix.

