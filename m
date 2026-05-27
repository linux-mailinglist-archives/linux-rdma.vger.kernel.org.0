Return-Path: <linux-rdma+bounces-21348-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA3YBGPjFmpIvAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21348-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:28:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDD5E42CA
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0C813029625
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5403F166A;
	Wed, 27 May 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PF1sBbjV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BF3EF650;
	Wed, 27 May 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884639; cv=fail; b=E2L3UQs+hJ3/0QVK7Zv7RZ62GNcEbgx28cO3IEEGty/acN/dVyKzt4RcipujX1yzgsSSOquL536TmvxTsptDUk0thkFyeN2uY8JU3i4lQ/HjjbsydtIc+ObKZCk6cjQhJDQcm9pOqBi5l8nvyto/hQUocbQYW4o/D4HeVjqheCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884639; c=relaxed/simple;
	bh=/g1BRLN8Wc/onC/28kaqRbxgXMw2qGnu7TDfpVfAegw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQgjx79QtvW2AmMJfKMc4K7eeZNuNSPGRp8TjonHERJX4QxaqQg++vRQxtgARM+bshdT5aC+A5OTaQbGh6yuuGHP7H7PrnuJUa5+fFsABJKC/OUgE3wCXqMX1FYHzNEDJhOsdLOFgeEaoLmUB8dYXzmFyJbEluLZ3Niu1GvBZyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PF1sBbjV; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYKxU8Z4wIrOjcOYRRIKrKGS2PfjM6F63eVhnxvmsuGjDzPsgBSehy2J8c/keGXJ6woRXVjpTaDbK2gTjEcefg4YXN5jfcu9Y8mFCCyDnCsW8lmo7s6b4HAKz948PT/W0FZ4Uy/xvNwZ9SYoDqwAeWyUz8NWItAOV3wZfwRxWjYrlEWymCUj7ppEAgSJ+TWdhx2YPE9bhsv212jYJ4WOzQxOfVjvsXfTMfedILXV/y3178/rZ6twZf6QU9h+GESCw6swfFI4UlL4BkDSb0WQrZI/ItqJw3IkNW9oRHSeoYxlvTjUnBewdLK0honP9lcW5zWW89HUICC8Tk+dDX9Ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LFJ8TI5Xgp4EunNlZxLxAdgx/Pxmn/Au79ZrPFZ5cA=;
 b=WbQyC2f0x2XJhztTM8NaHXfW0k4JgXs69Bztp/I67sQzxVWSqAVz/ao9ZTKB8+vFkuUItjFLK1f0Eo9pSdq5N7f9ePpl1NbPmeJIqjlFrU7HxCkUh8jIR51i8g2TgMsBIXNaKkLZrOkcH6vhCPlG93LkuCdcTHuTJanMP74ddj6u9By6Y6tRW8hR1tszSM/38AYP4aUSpSuynY4dFdHFm7bK/KrWZTCpMPS+9UeRAo/Y7IZ9p5tHaUQKT2Z6lq9WhhqE0ODIk4EfxsxbhRhiLtvsvUKeAc23NSGYVMHDOwPCrxoYKcz17OdjXk7ny3/020QUZ1nAlS/XDwtVKGjm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LFJ8TI5Xgp4EunNlZxLxAdgx/Pxmn/Au79ZrPFZ5cA=;
 b=PF1sBbjVKliOxbWcKsMnk6zV3km8qm1d2KNl7Qdpl5pj4RapYbizQZSFQoFnet3lU1r2U0x12/OowrgZJDjN14WuBAm8I5h7I5efhobDu5yeudmCtYRUKrs/E6eiQ8bmMn1IRrwXhp235qis6SFVCRCCsEApMVz1QQTm8WDi+BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:23:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 12:23:52 +0000
Message-ID: <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
Date: Wed, 27 May 2026 14:23:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527121438.GJ2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ecebcf-9664-4648-bc7e-08debbead045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099006|3023799007|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	f+kRIcoiug/uMwykUen5Yk7KgfHCjhGVzvco1n8eYT26nBZVToi0PJA/LGs2c+HXxhYUjkKtV2kzECi8vXGSzPTfNYngk8HtTCFyCP79hpVifQDsMvSpWu7FhJJVpETL0Eh1luGHoWi8c7Qpa1pGJOjDn+3ZliuW8vuRZO+WSwv++WprKntm8UDgLZ/8deWasVN4uQVBj1idiCZJc3oG5xZz+3C7ICYozb/DdvlMtK7myoB2k5CgpJrVDEVF1cs5H5brOg7vplADWrXH3SukkrGLuP5UUqdfDSZFDTO6bSavZoLBFZyBdfFcYXFBNhCByg3ICtOMgNYtS4NVk5gloadicZUHCqBBKaZC/yZj/9tzBUlDDsE+qY8vajPD7Xto/A0pa5XRpQd79MtNvwnBT7aJal/33GJCuWq6Qc3UV1W5dxR3XrYwRVu5HlmYNk7JxSKVgCny8shtFsh2IZg+zS7iW9kNNbkDoHI8VnsVvQPCNMaqxk3VTs0gfmSzSqhzleIm/yLL2P30PBoGtn5So6NnerNqBRS3878aolCAhQWvsKDpTc6Hqcib3+mQvdkxIOkCCxlPCtVwJOStQeVuJmv5cu5NppQeU8jAbwnQE/wQs75ZKRmTwqCNN4tp1ok45jPnTvGbibvzxoIGT3LEYXXIUQ0iK5jvwUqQhQ70SeP3lCbMpOjfa74vr3E33C5S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(3023799007)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJmbzJXeEZxTFdISnVidGNxTlJMaGFzU1NMVEpCM1ExeFU5Y0hOZFp1VEox?=
 =?utf-8?B?alhqSEtUMFJzUVRKaTFiVUo2YmY2TFM3ODQ5SElYamRnbDliT04zRkM0eWxy?=
 =?utf-8?B?YmVDTHcvUXl1Sjh5d2lNL3BhL1RZNkNJNk9jRkNjNCtCaXB2NGVMZlhUV3Bo?=
 =?utf-8?B?TXBuVGZmMW9pSllmWlBJT1ZCeG9LcnFHVG9sSHJvWVFPN0hJY1VaV05xYncz?=
 =?utf-8?B?QmhjdUl3WFJiSXhNY21DbWpMeDZqTFBLTkVJbGhNaG9CdTVDVlFtMDVKTUZk?=
 =?utf-8?B?Uk1qUStGV29vNHBSVlBnK28zc29nYWo4NlVYRDlzSkdrb1VTc004clNNZnVx?=
 =?utf-8?B?dk5sRXlaK3crZ3dCV2ZiS1FxQU83VHZqWStIdFQrb0JtU3lyWTZjejNZMStR?=
 =?utf-8?B?WkxXUEFvL080MDFCN2h5ZmordzEvQXVjMDVIaVQvY0NrZE4rOHhOQlZxNWNT?=
 =?utf-8?B?dE16YjVqRWsyMkVaR2dsTC9PT0pBL0gwUnhiMlVLT25GRkh6MGZ5ZE1ubVVh?=
 =?utf-8?B?blIybEM4cXFnd3FlYU9WTU5xQlJPRzZSdGU3bkJNNk1WcUZDQnpneldIWGNo?=
 =?utf-8?B?SVNYdU10ZEIzU2Y4QUY1dHRBdnJtVTRZaWNLSWNFK2poZnJibHJBLzErUlVO?=
 =?utf-8?B?VTgzSW9JUXlreGpBVUpzZDFSTWZFeVNuRkZTRVV3Qmt2ZWxORE8xcXNwa0py?=
 =?utf-8?B?VzVmVzhiRVVYMitUWUhTM29iYWN2UmdTV0FCd3V4Rml3RG5PZVBFeXVPU3Br?=
 =?utf-8?B?ZHdHeUdXUzk1TVpsa3JTL1dHZDJTUlZEZit3ZFpXekJBbDc2WHNaV21nbVov?=
 =?utf-8?B?L0ovV2UvN3RlbElycTA1YmVSLzA4bkFHTFBwSEMyVU92YkI2VXMwbUFRT0dG?=
 =?utf-8?B?YzNtZ2VNM3JCdUlLLzcwdDFMTEgxWWJrNHcwaVZyTExvNUsvUGVLa1ZFUlJy?=
 =?utf-8?B?blhWN2RzL28ydHhkUG5hZHF6ODMxd2YxR2YvTWVWRHBNd1BaeTNsTXI2cU10?=
 =?utf-8?B?TFJxR2JKYXZOUXVmanlEbjJ4c0dYZ0FjT1F6QTlGRE44bkpOazY5SVpSNllY?=
 =?utf-8?B?K2hSb1dXZmtRbk0yQytXaTFvdHE4VkhSWnFZZzFkUXJGL3hTMmlOU0pXQnlZ?=
 =?utf-8?B?V0VPRHVjVjFHSDRHekQydDZhWnJoc2lwdHptUEpaWjBxenYzUERseGhQRVBQ?=
 =?utf-8?B?ayt1TEZZNHhWSHZLa0lNZmM0cnFRcUFzdWVrMUFheUF3QVRCWDk4NjFqdGZX?=
 =?utf-8?B?Y0NZR2lnY0c3cmF5TzVPbnJFS3d5bHFzMk84VlE1MDJvRjF5UGZhb1VnSW9v?=
 =?utf-8?B?L1E4ZmoxQ3dpOFB4azZBTUltWVROMXlCb0J1cW01ZVkySE1TMDlnTnN1emUw?=
 =?utf-8?B?UklKcFMzdERtTDhmTGFNS0N5cWVkSG9wdHkxa1hYVEU3M1AzOWNLOVN1cWV4?=
 =?utf-8?B?TDNUL2dOUzNXYW9HbWpiWkpXNlZtMEpTOWxIUEJhaGdDQkh2akIwcGh5SzAx?=
 =?utf-8?B?QmlWTHJmMGtiRjk0TjFaUVFRSXNjSzZIVXVhMElZbWJTMU1XSjgrbnlVRkZ6?=
 =?utf-8?B?UjRNVTNUN043d05pZ1FrZzdneUdLeTh5aHkrOUxFTlhPMVRUYzl1ekc5ZThY?=
 =?utf-8?B?STgrQkVvMWJzNkZuM044RElKaEFJODByNmN1dHhsLzhLLzJtd2p1UTFKei9S?=
 =?utf-8?B?bUIvVVJrNWpXcTFHdzNtTWtNT3VQRXErQm9kTkJoU0NsOEdhRkMzQ2N2dVhW?=
 =?utf-8?B?NEdDTld4N3Y3SWE2eE16MDdhYWQ5Ykp5cU5qdlQ0eWZlWWVEUjJ2Mk4wZHRI?=
 =?utf-8?B?OTlHT3pnTStCeFhiU29yQ05IM0FOT1JvWXNGVmVpLzIxVmpJbnJGbXdXamJw?=
 =?utf-8?B?VFVHLy9PSFhML2d2MTU2c2VLU1p1N25BSFZPeXJESU84OGdvNWxRMUYwcGtu?=
 =?utf-8?B?emE2L2VUbXE1UGtuYk5leU9WWGppSkNVWVFaT1ltTWJSd0lEUTZIOStPR25H?=
 =?utf-8?B?Z3I2K3Z6TzgyeDZtYjBrMUh2L2RiK2lrbURIYk8zaGhtL2RiMWg3SFJmSHhO?=
 =?utf-8?B?RzFWVnpZZUdibHJFMU0xY1FCZkxneHBsaTlESmNwS25ESWVJZTNKR0N4azNa?=
 =?utf-8?B?RzlwMmdPWHcyN3dyeUliM3M0bTZUd3pzd3BRZm5nOE9Dbyt5a0ZQZkxDL0x1?=
 =?utf-8?B?TzExNk9NZVpQdWhmU29IT2RIOVFlMFcxQm10VmpnTFhsMEJHd0g1bll2NlFi?=
 =?utf-8?B?K1FCQnFNZDFQa1VmK0I3blRLZ1JFbkVZakRPcURIRXdyeWFocEdQcTd0VXJu?=
 =?utf-8?Q?cOo9IXavBe6HtTxegz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ecebcf-9664-4648-bc7e-08debbead045
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:23:52.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzte/Q/iFZROdcV0+MhUNgwzY2XmjqBWcxhJT5b6L/guw/GddtjkKjnH2uYi7TVH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21348-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BDBDD5E42CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 14:14, Jason Gunthorpe wrote:
> On Wed, May 27, 2026 at 08:55:49AM +0200, Christian König wrote:
>> On 5/26/26 16:43, Zhiping Zhang wrote:
>>> This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
>>> export path, allowing importing drivers (e.g. mlx5) to use the
>>> exporter's steering tag when performing peer-to-peer DMA into a
>>> VFIO-owned device.
>>
>> I'm not an expert for TPH, but that sounds very strange to me.
>>
>> As far as I know the TLP Processing Hints allow devices to give a
>> steering tag to the root complex together with memory accesses to
>> give fine grained control about cache usage. In other words it is an
>> extension to the classic snoop bit.
> 
> TPHS includes an bit of data on every TLP and the data transits to the
> eventual completer.
> 
> It does not have to be a root port.
>  
>> For P2P that is obviously nonsense because we don't have P2P support
>> for cached accesses.
> 
> For P2P the TPH data on the TLP will transit to the P2P completer
> unchanged.
> 
> It is up to the completer do define what it does with the TPH data.
> 
> Typically root ports in CPUs will use TPH data for cache placement
> instructions. But who knows what a P2P device will use it for.
> 
> In Linux the driver that owns the completing address space gets to
> specify how the TPH data works based on its own device specific
> knowledge.

Yeah that's a good point, I should probably rephrase the question.

I'm aware of how TPH works by adding the extra ST to the TLP.

But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?

I only know about the caching use case for the root complex and that's clearly not the case here.

Regards,
Christian.


> 
> Jason


