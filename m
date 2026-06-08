Return-Path: <linux-rdma+bounces-21942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zM4vAweAJmo+XgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 10:40:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBB654257
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 10:40:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=msM7B2S2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21942-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21942-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A995D303A535
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566C3AFD0F;
	Mon,  8 Jun 2026 08:33:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E003B0AE2
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 08:33:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907625; cv=fail; b=pCeAnFSn5tz/deyDbp2rWLYw18j2LTIbu/A/S01Tl1fkDehRHuW+A0IIB4onpyrNtJIHqg/KZDqlxIBZ+0RuXKSye2ZZG8felrW6iTAVvH7Pka0pW7tLr4FzPXFXdp5i+QVRMRoBrTaoCt5dc0tRME4StKduO7lAcD/j/g1c8l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907625; c=relaxed/simple;
	bh=nATBBaVh58f6s8D5/3f7B8pm8C5Q8NtbzGAZCNr9wrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u4M+jbBDfjLDyj9BRrBrJFWru+ten/HLAfaNrxSEjvvo8qiOcbk65BJHWlQKm6G0TF85jymIUAPOM+KrZFDwuxn8vVIA+01T0Av1sVphp2/x+R+kQYhjgRmlOte2+fTVoTgYvffl3GFAbkyiPCMjTRQqv3O5fAbeDRuCeN+zYtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=msM7B2S2; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3EfRdbbGVN0DHb9n4vUWRRbW3vba83xE7t/dNsMQWbU4Qdlhm9GHlNLaZxPT3BLZY3upK8vEyJqq7VR0aJT636adUWdxMxMN4dJGqTWLFF0vicW1+z04zJQJgJo++7sqa2ieOe6QFM/ekl9iQ4q4zi7rX5DlpbD242yiH1bqtgbIvoOaRdNRIz5EhhbRUQjzJxEqfmbqq+RMlL2BtPZ8alDeNAfAkDyuRqjFhvUbWb+YkuSVBOTKyQr//QoHMiOm9jfKLzDJwyaG87x0MDVX/cdfkmBp/YV6V1uv7AJ6UKAijNCqvTEf+p16eB6JEeRIVIaSk+kiiRC8cSOV8ZVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9/I912/wRNfLiMNjB7VOVBcs+Qg2x58NBF/Ex2rHLo=;
 b=tx3Jd9ahDTLome39LrIQcjthHs0Om7GpNFijdwAuie9uqWN8FeZ1M47mjLjIs0AXvvD5xd+2ou0/aGDu1YIE5zC2yWzNZrxPh3CDSMj8ZR16iYBhTV18Wa+nBnqaVX+CYGiOtDNJ7LBQvlWvObtP6yC8pHXIGP1pwTC/ZUrHN9h7iHygc3LlQReFkVTPRhJgUSlGWelnX9AlApOUNkxvrn+FqP5M/bSFBbbB2hNS8EKnlIvGGr1fXUpzANzlcY1zGPUq0+0NV+pYuld5zM2Z+8hdUel8wTJcvyYHhakysLLIU+buom7VfTnymsTCXCOV7PVHWkN555us801ZIIu/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9/I912/wRNfLiMNjB7VOVBcs+Qg2x58NBF/Ex2rHLo=;
 b=msM7B2S2B63dfR4S+yMpdTDKAq4Pl7N7khlLHlYko8ppC1WJvDLYjNsis7Qyuqh+iGZ/+P1S1VR5Sl2oAz6se3xvKL8DXkaVOOzgppJusme0cD5RpPfzzzkfQtA1SsKPg4yei0sc273EGOhqn1HhREYhzuuzGXdcpsZY8fFMBkAJgPSaDnWQSp2VsMqtI6VRmdqw4JXX97hH9dtB0AG6rkPfG3dXWwBBVESzMbUSrc2F962Qzal9I8hHPLlq543qi5lOrmYXloAtE1Gg+i7qm2yjX6zCQJ5fgfEDDHNu6N2tTd2ZA5KJni5EIfsEjtCBfmq/6zC9l4TkbQY4fFi/FA==
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 08:33:40 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::1532:a957:cff0:9ca4]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::1532:a957:cff0:9ca4%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:33:40 +0000
Message-ID: <05605b18-5c19-42b6-a044-33f4b13f6aeb@nvidia.com>
Date: Mon, 8 Jun 2026 11:33:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rxe: Fix dma.length computation in wr_set_sge_list
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org
References: <20260531120721.1347977-1-jholzman@nvidia.com>
 <20260603181104.GA1565410@nvidia.com>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
In-Reply-To: <20260603181104.GA1565410@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccceeb4-bf0d-4d5c-a227-08dec538a458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	1KTdQKa6G3N5CK7uAZfGQVvjTHmaf28ebDW2A7bmMzrm4NoH/sP2Q+ZkPDCNLUAsWFZEb8U9y7oIdEGhd6oHkgCuizG9wOwh8UJ9Mb/rJdzIWED7mTBktTMlbU7NH4fQIUuGG9C+8p86zyvG/QIuJVmMeZ/Fit26R7sfz4hw0ArZIFa7WfY0kKOQMdj7F6iAHedreWUrndhS8yy1lr7VKiFl5hkTTOA9MV1PaAn+BfYrCnX2l61NgxRCvjzqsMGi5sDS6/ZyQBa4hSzxlFJ3YOJxB3Uf6/ItEpAGrL2LW2PnGsp9nDw3j75BcA299TehGKs9dQUmk2CW4Ah2aGnpNhZ8UkTburkbbSENpxTZ3qy0CQC/olRyZycRFF1Y1aOxBp2sJVH+foPfctcWkCM4vKJwKK488jSQNIIw6OFdMGAOrygC/nZL3u4HZQCCOXs5bYajd1H3veiRlL+AHY67fj8cRD3ztVpIy86qvZSLARfCvCWMSF+mpgy6kMgdYlAn/zPvjsLbDip7mgrGSIPFyoxg4c98nl5Y9uDJHu3T+TWQYiXIXUPGfxTazguqiFhGfJCFm2MoV7Ssy/qVaC6vGoKFcau1RfkuGsEePVt5bq29u4+aOprQioUel5ZXpfIGxQ+lgNU28xmcYIE2y7IW1cJfjia64cKzxmEuW9Ar1KtYTv1YmgBLZ9dD3CEeqzXK968UAhIN2xfmOni9znmFJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q09xVEJKczNYMVlleXJWSUQzcVM5MWZZTkk2OE5nSU9LS2VpUy9JMnFRWnh4?=
 =?utf-8?B?VGVNaWdLZlRTMXgrTklwM3ZaZ0hSeVVXM0dlTDhDRFVBZHRBcEM1RmUvY3lw?=
 =?utf-8?B?cWQ3dDBaYUZNSzBteitqUXpPb1FrbSthUEpEc0U5djhscHlLZWp3NCt4TjNv?=
 =?utf-8?B?Q0x0Z3NrUUtoUGlESENEL0ZzU0xNcnpkRldKTnhkU05kN21oclYrQkJTRjB4?=
 =?utf-8?B?RHdUa09ySEhrZzQ0ZURQaEtrTHAra2JLWldIS0poU2NmQ3dGTDJKdmtycWVr?=
 =?utf-8?B?cEplR2p2SzRLdml2MUlFQTI0M0JpQ1Z5VHdjUHpwQmNrdUJOdnRTSENQWXAy?=
 =?utf-8?B?MENUOERlTlY5bmZiMkxWNHZUbEV1V2pFcURMbW9YbC94MDIweHNlNGZXV3lU?=
 =?utf-8?B?RWtHZjFueHhmQzE2TmY2bGpIYUF2eGF5WFBURGEydE5wN0dQYStRVFdrOHo0?=
 =?utf-8?B?ZS9KS01INXhNTm02OVRMTUp5elRjRnBsWDgzd3RTdkMwQ3VVNDY2UDVURXNM?=
 =?utf-8?B?UHBDTW1jTTVEdE4vK0todzEvSCtsWE5DMFUwUVdLMWIrNHl4eEVLRFM2NEJm?=
 =?utf-8?B?WUJmNFhtaG9wSjYyNWptREp0VFVxNEdEdHZRRllmaG5XWHRsaDlyYURVZEdS?=
 =?utf-8?B?cHUvNjN5K2x1TGg4UVRaVS9qc3U2ZFpxZW9rblVCQXJqS0YzRS9xWkdIZjRm?=
 =?utf-8?B?NXZOMVBOUDM0K1lXSlFQekVJRDBXdTNKUkdhQnJmOTIrSklZaFN0dHdBYllz?=
 =?utf-8?B?Z0VYTitsd0xoekhiODJpWndGbmdmWnYxZjREemozVWdtZTVvb3RaT1l3M2VN?=
 =?utf-8?B?S1NaUFlUb3FPQUNNKzJabE1ya05yVi9IYVVPcFozNkhHdnFhUlRKOEprSHRF?=
 =?utf-8?B?S1NBcnJINDFtT082a1UzS2NJUVExTGdZZlZhUldyazNLVDAwRFFhb1l1aUYy?=
 =?utf-8?B?OFZpM1BxSmlLYytVbTVUelQyTGh1SkRIejR0azJVbjdXN0JJdmd2THdXRHN6?=
 =?utf-8?B?NDVua2d1QzdKd25ZY2NDbHdLSUNQUGg2WjVCNm1yZGVsejZlZjhXdWRHQ0Mv?=
 =?utf-8?B?ZTJtZ040SXRRV3dIUFpyaDRzMWdJa0M3VUpMWGVJVHY5TTJ5aWJFckUvaU91?=
 =?utf-8?B?ZmxTTDRDVmczUmJMQ3E3YnFSOFNVMk82eDhrcGpVZWFSSnc2am9kWDBISU5C?=
 =?utf-8?B?a05WNVFwTEd2L010K3VWRDcyQXppZmQ1UG1SVGpIRGNBSy8ySTRzaGF1MWps?=
 =?utf-8?B?TXBzajFzTldybHpKaTlzN0E0VzlIS1NYdDZESlFjVGltNW1PRTQzaE14TFVl?=
 =?utf-8?B?VmZvclNaR1NSNFBBVHpMM0ZhMlZjdFhMbUNsVUM0TXhGTW5JbWY1bnB2MXZM?=
 =?utf-8?B?Y2RjYWNPQmdwR0ZrTTRqOEI3bWErL3RWdmtrQzNVUkNXSDNoN1JLUWY4T3ZG?=
 =?utf-8?B?YXdVN3gwTXlUZVhHenM5YVlUdXpFMld5V1VmQUhIZjA4bHVzRXZBTWxRVzF6?=
 =?utf-8?B?WWRaTUY5dWh5a0VDeTRzOVA1cTIzZk5TeFc0UTAxZ3p4a3BnSVptOStyUXp5?=
 =?utf-8?B?RXhPcXpSby9YNlA0Nk40MklJZFBjdktNNWoyRmFScUE2VEdyNlFKaGxFdHhj?=
 =?utf-8?B?Q2wrM1ZOc1ZSVmVwTm1WNHdDVlVzNk9mQzIybHJkZFEzWUFnZUNyOGJMWU5n?=
 =?utf-8?B?ZWNuc0pCd0pxaTl6WUdqTmszNUVHMG8yNGt4VVh1dUI0bmNpZjFjN0FKT1VH?=
 =?utf-8?B?b0REUWZ4ZWVWOFFNVWVIM1ZaZWpBbG1Ha2hTcm8vTERFWWJMUjJhUE05SDUy?=
 =?utf-8?B?SXdNTEozRnNDTFlpektKaTdGN0xvMkhFS1o0U1poOWo5UmhZak14VVg1N3RV?=
 =?utf-8?B?K05kaDRNTEJFeTR0blZidG9QVld2d050M1NLNzUyRDFvOVpMdlRLTExHQ3Yr?=
 =?utf-8?B?RGc3OUFOamwzaDUrMFVhWlUrVFFzRVpTU0hFaXUwWXlIeTVRdHNPUmErS3Uz?=
 =?utf-8?B?ajJrOTZ1WndZaXNTaDd6U3hmazhCeEcyNXpYRCtPUkxNSG50R1duRUE0Ymxv?=
 =?utf-8?B?ZDhoS3UvVXptMkRJZ3BCdjZBeTBpN21CWWVPd3VvZmpIZFBCdUlXZUJ4c21l?=
 =?utf-8?B?cHdoWEVXZExEUmYvSTJMbkxWY1ExL1IzQ1lxYnZ1Ymk2LzVxclYvalhwY3BE?=
 =?utf-8?B?Zlk5UlpTcEp0MGQ0WUtqclYvRXNKRG5aSWhHS3hxOVQ3a2xNd0FMVTJ5SGJq?=
 =?utf-8?B?Y1JLbUUxN0FWL3NJeFBpSmltY1NBOTlJcnZjSTg3a2p0eUd4dDJFZ0g0bGNy?=
 =?utf-8?B?ZzN6WStKNTR5T005aFVvR0RvY2h4Z3YyeTZJaEs4NnNUcSt1RGtoQWZoc01W?=
 =?utf-8?Q?u1sf1PZx0cCMP2dBga3+7Spjq3S0TwKJ7/PDoCH0IHayD?=
X-MS-Exchange-AntiSpam-MessageData-1: vmnGikNPmehkaQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccceeb4-bf0d-4d5c-a227-08dec538a458
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:33:40.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3v43WsK0dPtsu1+VEmT2ElKA7zrVGknp04f2bL5uapHngvlpUs1FFIFD7ULzfZ2k+NzVxlPqbQFhH0QBIpyBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21942-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jholzman@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jholzman@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DBBB654257


On 6/3/26 21:11, Jason Gunthorpe wrote:
> On Sun, May 31, 2026 at 03:07:21PM +0300, Jared Holzman wrote:
>> wr_set_sge_list() summed the SGE lengths with a loop that never
>> advanced sg_list:
>>
>> 	while (num_sge--)
>> 		tot_length += sg_list->length;
>>
>> so tot_length ended up as num_sge * sg_list[0].length instead of the
>> true sum, and wqe->dma.length / wqe->dma.resid were written with that
>> wrong value. The per-SGE entries themselves were unaffected because
>> they are populated by the preceding memcpy().
>>
>> The kernel rxe driver requires dma.length == sum(sge[i].length) and
>> enforces it in rxe_mr.c:copy_data(), so a multi-SGE WR posted through
>> the ibv_qp_ex builder API (ibv_wr_set_sge_list) on rxe completes with
>> IB_WC_LOC_PROT_ERR once finish_packet()/copy_data() runs off the end
>> of the SGE list.
>>
>> The legacy ibv_post_send path (init_send_wqe) is unaffected; it sums
>> the lengths with an indexed for loop.
>>
>> Fix by computing the total with an indexed loop, matching the style
>> already used in rxe_post_one_recv() and init_send_wqe() in this file.
>>
>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
>> Signed-off-by: Jared Holzman <jholzman@nvidia.com>
>> PR: https://github.com/linux-rdma/rdma-core/pull/1744
> I don't know what this is, upstream doesn't have this code qp_ex
> support or 1a894ca10105
>
> The rdma-core thing looks OK though.
>
> Jason

It is only an rdma-core change.

The commit hash is from rdma-core repo: 
https://github.com/linux-rdma/rdma-core

Jared


