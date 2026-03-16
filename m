Return-Path: <linux-rdma+bounces-18226-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDwZLy54uGn5dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18226-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:37:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDA2A10BD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3EE03001FA7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AC364EA6;
	Mon, 16 Mar 2026 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="KK5SEkLx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020088.outbound.protection.outlook.com [52.101.193.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640C35F612
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697065; cv=fail; b=Uq+mS1TpQ7rao9/JhPJpUPZt8xO+jiZ352ioFebwXu1KoWP+0IDNIMXQgBM2Xm3AguecV2D26o0pBEUI61CrGMy90mBJX1128QQQwWgmLULp1ZCShtNuQKziR/0OdjfWdYmvVXviRMR31GxuqKGkh4iA4Y0GCi5EKspgTV5nTzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697065; c=relaxed/simple;
	bh=bkMVWqH7BMxgPpe+Wdrwlj5WeRR262zSirElsVDgvKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l8FpkvDlo9pMj4auhXR25Q1Vsl0FB9dtc52t+G/ZFxSowq+rFDvcKzFeuHokI3eDmz+2jEvPx4WUq/8vYYVw+Ziha7OFUcvPg2NhRunToj7zQrcU2X28e7CvYOY0SW+6lWoVThM2fKsN1/AJ/9bYUwG6+agQtVdO0EC/NmFha3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=KK5SEkLx; arc=fail smtp.client-ip=52.101.193.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocqJnFT9wZHkZyFnMUs/BQHoiKF8Bwhk759cBjoTSNdsYn7v7FpORLb6O+yzB38fUojrVbROhHF5uFi4/OSwPVGIxCKGQlnk51UdhHEP7fcXs6skOKyqipk9sKXcuzuXtnPF6OPV6UBClyRee2QCaKJNWmu9RScizUQ9YhkKVIiwEBD4VGMdx8U0isnr8mACpa4NdgU5oZ4mPB0B/RM5peVjwq6R5PI50phv/dSdVPDf/y3Ox9Cu9/svn2/EyladDXK0mUT5K8cf6hs/WQpMEqrmkNCBqetasRzTzyZbe0tQHe43RxtUC1shM4y9G0RxpLq8clfPYp2mCt2dhia8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6EyKXChpnfIJB8l7XNRVq1IF9n1y/oBR/qCvDRM9no=;
 b=MLM4UvDGTjsHvhTqL9WQVqBoBTY3Atz1mf0KMdZRnjo7ZVQglDOUTUujjzMuWULH0exfaVl2RuYRYAiYi5sv9Xxx5SPJ7zas48tf8YdFzbBKafGoQTEenTh7M2jJCgK0Kb4h/+GnM0cGYsalaLMOupxS1HB0HJnXcu7RW04ZNU6MuGnz7OH5cGJzTxcjlDiRGPDBwOENB6pacJLc65BFplOZbWOcXognmZYblTqfz7VUS8LobC+1k3gOB2kAYpYEGw0L7q50bLSgi0seWBDXfCMG7nX8/4rEWr0wZHTP6TvLCU0tWPYxWnY5IBvXerIjDE3Qigkqb3kUENvv8yLaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6EyKXChpnfIJB8l7XNRVq1IF9n1y/oBR/qCvDRM9no=;
 b=KK5SEkLxPyah8vNzya2NHIuHqrM6DRmH/aNNeneDIxXQiDpOdWmzkSbUwfDE/hXUoB8AP1tlKvUeWC0ZWHr1AlsIWfZ/zJcbuf/GgGM+LmrpWZPqwctDDCn/z2BQ5dw1Vq/9iID3n6Y3Yvx9MVMf3OdTOiCHlrA2xZmXqt9KMW1H0eapSl94zSUkrUjst91I9DRzugh/SV6U+Ex3gGiakMIfRi2K5fqnVmHzgb3AvVnmlElGdMNGubcKckFD++nVEqx3JoefwSQluaVkifgFMi0Awpy+4iDbDyaJxl8tiLkNANhRi0Kb48ozVFHCXzTV9HQq0CiEYN9SPd5o3hGJSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 CH3PR01MB8688.prod.exchangelabs.com (2603:10b6:610:209::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Mon, 16 Mar 2026 21:37:32 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 21:37:34 +0000
Message-ID: <9ce84cf2-e916-4cac-b9a2-65f059b6508d@cornelisnetworks.com>
Date: Mon, 16 Mar 2026 17:37:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next resend 07/24] RDMA/hfi2: Add system core header
 files
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325166078.57064.16035123727786325107.stgit@awdrv-04.cornelisnetworks.com>
 <20260316155826.GD61385@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260316155826.GD61385@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:610:50::15) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|CH3PR01MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d3a016-6de4-46d8-6097-08de83a43c96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Bccdb3nNXOLHvvWNvRgQ0RYj2spbOw2/qP2RZ4/8LJ2/uQmowKHGjvxaQXM03wvV79h1PdkQ8uprtLZX1LbIZpKtvgplaSibpQFGzx2n+wvNJy7z6kg98axGSsvDUqUU1TGz/TX6toQBE4kwMwobLarjbGAyqkRwgWXk0/7EifUpMsfEIa9CDEbpIurJhKMKZz2BLM2bJisz4aLi9PEhRh0yQg+PN1xNNWTNTvvjkDkwZEdRqYnqihVipmwzH2rW1G0qUyoEd/YR8XPiiUsvT4HdjqWExeh6vgFv7NBZ2J0DPfB38a5FXUiQAv/ZmnXX1Tr1V9iaKdUNYXe0ZBq6soQg9by410stx8bfzY0kmdwoNQR+henYzPyI9uVpMOw3g3UYQXrtrnG5R9Se3P00b6gFg3xF5OWk+fhw0XdPLZBUnRCBkpaDNzoDgC00XhZdhUVv069DoVY8KLzHZlRetbZ/2z5o4PkuVQGmnIcN6PVCJVO3FrhkIFaP1XdPulZF4DEI0XtrN1TAQ0PtdM8U1gt6V6L+It/1pVgi+FkmoVB741IAplAlt2I10OMZivuVhONCkmoEXWfrHiXM0TQwvn97aJiOj/6OIxR8BBd6YYgwbgG2AvU5SskIJ5FbW/Es5aR2i/LEwFgi6KdlFXc/r4si9QOxt5w7pIogrRkFA3GYWDf+XvKkgfVFdJtQK7YMohCIPfTqMZnzvd6kYjqR+9Wl4nEalaYrRX6qGHDmC2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTEwckhNeS9SQ2cremIrcG9YZ0FsUDQvSFN6c2lUbmtzVG5Eci9kWWNieXdL?=
 =?utf-8?B?VWg1ei84ZjFETmZHUXM2S2orZlJuWWs4ZkEzaWtVSWFqalBPWVJHaXJia1o4?=
 =?utf-8?B?K2NIdHlxbmRLRlJoSlNLKys1cjNiTEs4em93cU83akUvZDQrckREME9jM1l1?=
 =?utf-8?B?dGpzeEpMdS96RWxvbGkxTGFWNU9zY3RCM2YveTgra2dHY1B2Q2pSck5DNGxj?=
 =?utf-8?B?THdadCtwU1Q4bjJWUlhkYXk0cmdaaVkzRGdxZXdWTlJFQWhQMWJLZ29xbHNF?=
 =?utf-8?B?NTJrS1RQNlNCZzhJRWs1ZEVzQXRLZ3pyT2RBSHN4L2tpMHAxaDNGRDlVemhI?=
 =?utf-8?B?c3pkRUN1am5WYXhSVGloWnBXSlc4VHd0SUw1UytPRjlGZlJsUUZYZW94eS8x?=
 =?utf-8?B?Y205dVlMRC9jYm1aWkN0SVZrbmtOalJEY2wyTzRVYS9RcmY0SkNGUlBNdWNB?=
 =?utf-8?B?SXdMZW5jbGRROFdJb2lSTTZTTkpUS1ZTR1FKUDh4RUNRLzlycWhTRDVlQ1ZX?=
 =?utf-8?B?c3VBTFYycjhnRm1nU0tJbEFBK1hQV0VIRHQ3dlAzSWdBQ3crNm80WU8yVllX?=
 =?utf-8?B?RUpVdThkOG56eVBJd2Y2SFI5T0VIUVN2VG8ydTVvVlZKNFFOMU5jSjFNNUcy?=
 =?utf-8?B?S3hNR0ltbGlhUjFtVGVJRlZWdGVZY2JpQkJodm51QityQmlNM3J5UEttaWpS?=
 =?utf-8?B?Skh1TG1iMjkvWjV5ZVBvSVhLeDlSbzhrOU5tMlNkKzMyYXJ1cXFjOFJBM0pI?=
 =?utf-8?B?ZU1SaEU4Wk9UOXFMNVNYR3ZpWTkxY1BsRkNUOVBFcTkrMktFQ1MralJSczc5?=
 =?utf-8?B?WXlCWi9aZVM0ci8vQ3FKblNld2Z5MGlhdVZnc0t2dmZPL3JDaWhTSTRvMWVL?=
 =?utf-8?B?NVd6TUltNzViQmlVSE96bk9mTUw2c2xuQ25zR0hXNWNib2l6VW1JUmFhbnE1?=
 =?utf-8?B?OVJPS3luNUoyOU1NcFpGcnV6M0lGVU1rSDNNOVBCV24raFJxVy9DR0s1MlRt?=
 =?utf-8?B?djZRZjhSOHQ5NlgzdEU2RUhSNFA3cGZzUFRyNkF4andtV2FlcDhmRndKbk1a?=
 =?utf-8?B?bGtLVVpKNWNuVmhaQmFTRit1dENZK1I1MFViUnpkeVA4ZGorSFQ2dkhvVGh2?=
 =?utf-8?B?Y0ErWUtIYVZWdktzcFN5L1o4RFFISjVEQnpuVUxEeTFra0EycjYvcUxYSlNS?=
 =?utf-8?B?aXZRbWJzUTFibUticnhpTldMYlU3ZTB2eWF0d2luc2Q3RmJyc1BGRDRhaDM5?=
 =?utf-8?B?Q2RCWjk2QWtYbVEwd2FVSlFDOVZvNXloNlRxRkNYRTVwWW84ZGI1Q0pnN1BO?=
 =?utf-8?B?N3lWSFZPSTZVTkpNMGk3QzlkODVoMWtpbFlRU3p0Uml5SGtYMURTaTlha0pr?=
 =?utf-8?B?dlB6S3hXRm5XV0J3M1JBVVg4Tjc1OHlDbDZhRDc4R2FGSjVTUjZMWTErRGp0?=
 =?utf-8?B?UFdjRnluTDVpWFBuQTZFODlJSFVtNGtMMmwraWVQaFE3U1FZeStTZjkyNWVV?=
 =?utf-8?B?Tmp3T3dWQnVWSHVqRjgyeWlTTjdybUZtUjVLUXIyd1FpVEp0MUwrcDFCbXZw?=
 =?utf-8?B?OS9lV3hKSlQ2VjhmczhhbHZIalRuN0tlRkpoNlRCc3NxZGJ1OE1FMEFaL3c3?=
 =?utf-8?B?RzlVVnlCY3g0c2p4VmRqV0tLL2FQZ0JyQzh3SktlYVpYaGRXeTBRMUo1VFRR?=
 =?utf-8?B?YXdGcEtNcytBdktlT0RhTldIRmUrQXYvVFpsdy9zemVIdTlvd3BaY2o5VGNJ?=
 =?utf-8?B?ZTAvZ1hET1pJNS9HVmhrUWdETWgxbWQ1SnJnTGNRQ1JWOVYrd2QxUjRlbWsz?=
 =?utf-8?B?OXYzbzdxMlNxMTkyb0Z3eUlBZ2tOWHF2UUJSbVlqTlFHL3VRak1pZWRPcUtQ?=
 =?utf-8?B?WTloSHNSSS9tQjJtN3ZySXhpVmpldEszTzQ0OTNnWWttb053TlRFNUJ2NW1m?=
 =?utf-8?B?TCt4NzB5b0YyNm5QcXNuKzA4MjBHMk9UTFFBamQ4K05PVFYrd1FZcUJRdTdr?=
 =?utf-8?B?QU9DWkdSTTJUVU5hWStpS2ZqTlpzUDB5ZTZRWkZJZzBVS2x1RkZFMkxxV1J6?=
 =?utf-8?B?aTdPMWNZNi9Tb3BiWSt2bkgrNWdvNG5NY2pMQmpReVBOZkRrZHFtY3czMnNq?=
 =?utf-8?B?K3pabDlYRXBhekpjWjh4UEgreURqclFzVk10UFA4L1dyeFloM3lqWmd0VVQ5?=
 =?utf-8?B?RFc2MC9xLzE1WkFFN0p5Vkh1QkJISWVuQXFmbHJNaXpNV0FXdkJpWnpZeWNG?=
 =?utf-8?B?dnhaQ25tSGpVanZzN280Y1J0K2tDWWZIYzJWTG1nVnV2OFlGV2N5aGF1QkF1?=
 =?utf-8?B?SGgxci9ta0dHOWNEOVlsbDlMRDhGazQxOGozNVV5cnE4bXVjZWljWHJuMXJM?=
 =?utf-8?Q?yvP3s7SKrsyuKJ4dDEWKbDg6WKQHou6PCTkcJ?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d3a016-6de4-46d8-6097-08de83a43c96
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 21:37:34.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UL4e1L11Zw7PTBTXxmI2tyN+FsWJA2QxV9baN/A2Qt0eZb6jjOnVmftTy3jFA1R7Qyay/Op4hYHsfIthwyvcqgO1kNYj4j7glof4M80qyMqEc8KWag4tCCg52bKoEMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8688
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-18226-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+]
X-Rspamd-Queue-Id: C4EDA2A10BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:58 AM, Leon Romanovsky wrote:
> On Wed, Mar 11, 2026 at 01:54:20PM -0400, Dennis Dalessandro wrote:
>> Add header files for hooking into the core system, things like IRQs and
>> affinity.
>>
>> Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
>> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
>> Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
>> Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> ---
>>   drivers/infiniband/hw/hfi2/affinity.h |   86 +++++++++++++++++++++++++++++++++
>>   drivers/infiniband/hw/hfi2/aspm.h     |   36 ++++++++++++++
>>   drivers/infiniband/hw/hfi2/efivar.h   |   17 +++++++
>>   drivers/infiniband/hw/hfi2/eprom.h    |   11 ++++
>>   drivers/infiniband/hw/hfi2/mmu_rb.h   |   78 ++++++++++++++++++++++++++++++
>>   drivers/infiniband/hw/hfi2/msix.h     |   31 ++++++++++++
>>   6 files changed, 259 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
>>   create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
>>   create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
>>   create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
>>   create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
>>   create mode 100644 drivers/infiniband/hw/hfi2/msix.h
> 
> <...>
> 
>> +/* Can be used for both memory and cpu */
>> +enum affinity_flags {
>> +	AFF_AUTO,
>> +	AFF_NUMA_LOCAL,
>> +	AFF_DEV_LOCAL,
>> +	AFF_IRQ_LOCAL
>> +};
> 
> Maybe I'm misremembering, but I recall we already discussed affinity
> management in the driver in the context of hfi1, and our position at the
> time was that handling affinity belongs in user space.

I don't recall specifically, but I do agree it should be handled in user 
space as the ultimate decider. The driver just provides hints as to 
where best to run things for optimal performance. User space is free to 
manage if it chooses.

-Denny


