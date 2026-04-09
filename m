Return-Path: <linux-rdma+bounces-19179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Hp02AILo12mPUggAu9opvQ
	(envelope-from <linux-rdma+bounces-19179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 19:57:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD43CE5DD
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E068D300C5A4
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F063C8728;
	Thu,  9 Apr 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTZNr84a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1053C5DBE;
	Thu,  9 Apr 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757434; cv=fail; b=WyJ4qQdlKSs0CEd9ANTJfQUWckvvSCcMxGPbJEgwk2jLGdsFBr3bmFd+v7cTUYJQS2SsyXdsQ8VWxQyecansYeUQ4QB+x5PPXzlq6wM3VYoi535mPU8vNRfJzmhqSZwEJlmpHyTX4zOzzGMYjCM6G2O2OkQCBuyWXn0EiEJA1h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757434; c=relaxed/simple;
	bh=8aQSHKkQPO2u091EAxBa5vO8J+ohzV3/FsPmpQ99Ayk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJV/UTmpPfa/wde1Bl2PsQxt2BSzYSPrR5Ch3D4RSR26qd7YG60Auma5Lk7qduQ/FJZk0u8C4HUiK6bK0Hmf7J1SSYUp/0wuc2fQbreGhg91TpC2PKfVgsnHPjiMhuxVTOt/anzyYa1lC668fUryyDGjc1dKyt6IulOL6DVA8sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTZNr84a; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXkVctmcZsEfnviX66Bpo3XFMXiSsCmJrR3IwjnlkXixF4KqfL5nYPAGFeo14cdrKRwAZhSdxdwvsIJ3U/6WYMVgfrH7je6pPaapT85DlfaxRloVHwBBvTTeuuuiwDxw2KBkPyjUon+nj7EA3CZR1f9iwqhtZ7Q20NjhJtu275FKW0kzY/ccTa+nddTl2m1AM2APGc4WQAXAXnuXbL/avIaRkidgJFqbtbCZFwgMfqDkL28gg5xHHRtLUDXnlawvieV1goKscnoMD58PCNugf7GlBPDvUyQuqZ6ewcKY2FEeMmFGqOs+dlTjJnwGR4RN48yZtB+QV5W8hgN3BY4R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgLLPbETGHbFgu0FRYtaTWF6RD//6mnYK5LEqaTpWKU=;
 b=jMI19U9Hj9l/PGlj3K4OWY8haT3o7napsxpI2vSDNKQ9cDRAimB3RUe04XVQ++tIDhx1JKq+6n+MjpHms23ifQzHVNbsN+8FWEatqd1uxikBl6reIHmrKd5RNyDa9x9bhuHiWanNmX0BxHpzg/jCmMrnmyiFIKWD6CaBvWshPEBT9lrFK1PiSzcQIAQpn07rcCb7GyN+LUEWx3IM14KXZwMzbBPIQyf7/ag00l7UBadgcEb1R44RwuC4Uie4b0JN+4sZfo0GFPzFx91edrLRPcB4aROoV0jsczSTb8vMPRuezqpwz1B1OL2tDTRVnKAJjMbBFpKFkW/a1p8xwyWV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgLLPbETGHbFgu0FRYtaTWF6RD//6mnYK5LEqaTpWKU=;
 b=jTZNr84a2LHy+TfLWeWBdoy3pFksevYw9R58LyUZaGaHhFB5STFwXtFp1TSFFZhxYhPHHnfn30c4Mkgb+orG53IYoU83mU8Dvq6p7cQHjv42jqiAOw0xZgN9ZuDW+0TAr++tfchFM1K3VCatKNQY149NXXXFRnL5isHOf2WXeB3PnVJPSLFslDejJOowkKNkh+G/uA5tn1jXvM/SnjMfpIHTCCBmLRwcofC0pWLFYNQ3mGbPr60g9d40YtVNdbctZ8SDIM+Ev2+aP+LTo/BsC4YAVJDtOJsJCIR2e66i61BJS9zuBX/X1PH5/FIbO1+M2g54ZlKC2lYavrCD3tntgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 17:57:08 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 17:57:08 +0000
Message-ID: <f31e93c7-660f-4321-8db6-5c8e15689595@nvidia.com>
Date: Thu, 9 Apr 2026 20:57:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net/mlx5: Lag: refactor representor reload
 handling
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-2-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba2d382-cf7a-4bec-09c1-08de96616aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qWUvLEJhFj/Y4Tvh8hEUoq2tCuOgTMP+swgc1sIK5/KpcVZPmHbJhJcC9/UrPA230CC1BF0hJxQv/tg0X1IDVT9evMVBS7yg1F/SegU2m/zZVB1gYoHWxETRGdccg/8RKdhwXVJHTXIKb6Uz62x+/6wjzExRISpM/n6+OfFi55cOT1vDDXnlcF4qsBgeMcfKe0B9LIi6JI2/LM/nayEA2euNjyDiuR/tCnehoF1rmo3rH/mzWJFRSgu0l67rQ7raUVFvCR4W3NqUv2pGCKXfvP+fhSneWwabwc4JxKvr/g8jODB7LbAPvVBYLyhOVkR7nBA0phLukoi7LjKoLv5Am1oU1jJGkyOImJ6EIXenfm5GTRBlz0LvikWUpBREwZVX16a3xAgeF5KF0AVwyn7w0F0GVJDmHy/NKC0OegRUrtwfFyS2DVAmpqwvp03AlglGvhCTeTbRsQNar9ZiiQyxpcx65bvMjWhcWvCWbGoycPIR2+nShl6Cdh5ENLgRdNonqYK9CL4LGzHvBMnZ35gmRtaP5p7Ov1Ubt2IdjQjgVnJaW2UVbb/0Namcc7VaJlRLGmo0Ca3g9VnkwQ5HL0cO8xF6JEF4dGlOHSRs8qrepeZo5Klteu5bS9P7evPyLkptEwxy5XvlXPwu/CHWsCP7bC/PysryLVmzebWeEJNhNq2QpJ4Xu9qy7GbdMCGu0Fz8FgadSYY14PE3flAdRA5cmYXxUPDv6ccwiSC7dD8hujo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lzg2MStDRmxpL3JPdCtBa0RqVW1ocENXYlQ1OS93QnF1V05leWFmOWQ1U1Jh?=
 =?utf-8?B?RmFuWGJSRzluTWNuN0tRRjR2eHVPMkFLL2RrMFpBZ3NnNEtDcFVuZTVpdnU2?=
 =?utf-8?B?ZDZrRGIrRE5UUmZqaFA1a2YwRXcxazEwOVpGUlZoVUFacE1aSkNveVRpZDd4?=
 =?utf-8?B?K3NERGVadDA0MEdzbXBKWHVId25tRTRRb3VHVEdPT2xVZW5xd2FHMVNrdjlZ?=
 =?utf-8?B?WGFIcVliZzc5SjlKMTlvbjFkMzdhelV5VTRnSEJsNEhZZGtTVm9sS09pdDZu?=
 =?utf-8?B?cFBtM1FrTTVLUDZFbFNPRnpHY3Q3QUdZWHFKVzhzQ2t4dlZTdW9UL2lTWnBj?=
 =?utf-8?B?cG9aL0hmL1pVU0NuRnlLbUdnZy9wMDJGd0Z2MlkycmpTUWwzWnE5ZFZyZUFG?=
 =?utf-8?B?KzNPTlFieDIwSmVyeDNjWGpKbGc0bHNVMTRCTCtDQitjaTdxMThyNjBjaXhj?=
 =?utf-8?B?bFptU2NuSFlpOXJ2SWFzM2Vnd3d4WjVCY0dWL09VRlpBZW5haDVKeXJmT3pY?=
 =?utf-8?B?YUF2RTZSYkcwVkJuU2lzUHNxcHZzTmxQckdaSE90V3RtVUgxdGdXNURqU0FC?=
 =?utf-8?B?MWFHTTdaTmlHc3NkMFZSWlFNanlydzM5KzVrMGVhSkhLNWlIOCszYm5YR1NV?=
 =?utf-8?B?VVFoUTI2V202VmhBb2oydlVZc3VlRnBIajliRlVVSE15VWZnT1JhelZRazNO?=
 =?utf-8?B?TktyL21EQmI3d0JWVG84bU1ENEdnYlNIRnhDSENmVXdTejVmMDdoeE5iRGIr?=
 =?utf-8?B?MnFaazJ1MEJtcFRDWTY3cHBSRHRKVmFIQjdhQnlDdjgwckdkZ2FmUUo0ZXdn?=
 =?utf-8?B?UEkrRHJueGtrd25YQmpNU1RlSE4vWVQzUFh1dWRkczR5MzcrcGRLeHRZb3JT?=
 =?utf-8?B?RW15amNWcXU4V3ZzNjhQcGdtMjNoSFhmanpEdWpoOGdxaHZzL3FJQkoyaTdP?=
 =?utf-8?B?YTMrb0ZQR3J4QlZ4d0tJcmJQMkxBUW50a2UvRTBWOGVqREJFOGNPckM4QkQv?=
 =?utf-8?B?VnBkYjFNak85amR0VmVObFo4YmkyNXVPcDhkQlBER05kNTVXOEovSStjb3Js?=
 =?utf-8?B?NjY3cGFnaitzQnNwbGJBNTJSemplTTRnc012QUJSWDRrckNKZm1zdmIwaHY0?=
 =?utf-8?B?NFdOcW45WVN6d0tBQWRvZE9iWmtyQ28rTGNOSHBDZ01zcGl3MjhIL3c2K2hG?=
 =?utf-8?B?TnJBV3dLMDNDeThHK3ZueVhvSjNLazBZVTFjVWVFVUxGODYySEltVWw3VVBj?=
 =?utf-8?B?QUw4R21aaWFwM1ZHZWxXZVg1MGlZaVluUHp4WDJDcVdnSGlydWdTM2I3K2Vk?=
 =?utf-8?B?blZUeXA2eGQzMFlLWlVLY3BJRGh3bDNFbVlwZ1VldUtqL0ZydnNQVDcweVo3?=
 =?utf-8?B?eWtEZ0FTWFlEYXBST3Z2UnpENnVqRjFoTVBySlFodytNVjE0NFlXTlJ0bzB1?=
 =?utf-8?B?ckFUd2ZBYWtqakpVcXEvTEJTd25OZnBIL2lpdk1zQzg2T1UvWEFBTFk3eldq?=
 =?utf-8?B?cU5jRTlhOGJkN3pRSkxJekxNcHV1T1lIaWdSQjA1ZFBYUnZSMVlidm5FeXBp?=
 =?utf-8?B?RUM0RkpYbGlQSURXT0R3eWRjMkxiMUhCb1ZwS2JCRVRnYURJRk85QnB6RDly?=
 =?utf-8?B?OWh4Y3JmbHJrQUladmJDem04MHBLY1V3c3pBUW12RVk1MVpOSDBzMDJ1S0lp?=
 =?utf-8?B?NlV4SzB6bWhjMUsvR3FPaEhNdkNYT0x3cG5NNGtRVFJRbzhkdXVKQUJSYmVi?=
 =?utf-8?B?TVZkYk9QVm5kNk5lVzVVbm5vVTY5a2l2bnl5cmRmNzk4YUdiNi9YVGM5U3Bh?=
 =?utf-8?B?bTRTd0xCQklYSDJwOE9hNTBwaUtua3V6UXljaTcxa1FIbTNDa3RreGdEUGxH?=
 =?utf-8?B?Y3FOaVkyZVh1d3JFajBhbzRsYm85TzZDV294TDhqYnhRVDdKdjVCR1BMNHRx?=
 =?utf-8?B?NjU1Rlg2ZFhoWTZmcnJEMCtINk9lMkJHNHV2OTdpbm9Fd3FXQ0NOUkEvVHdR?=
 =?utf-8?B?b0d3alJWSXVhZmdNTDdCQUxlSzVaWTNWR216SWdPa2k2MEM2c0szTVQvcnZQ?=
 =?utf-8?B?R1E3L2ZVM3RvU0VWVmZYbHZlWWZ0UlNibVYraVFtMUN6aHRFRXZvREpLOCtL?=
 =?utf-8?B?SHZzQ0c3Ky9ybmR0amxRdEdSZ2xPbzg4b0hNWVhRRGFaQWdac1orbm1JYmpF?=
 =?utf-8?B?eERyUzRBUS9WOVZxaUV6S3dndW9nMVVueFU3WmhGUmliUEdCMFVIZ3hwT2sw?=
 =?utf-8?B?QTRkamN6OE1iTXVDaVJQQ0FLVy94a3BOMklvSVF6WlNPN004cDRjT0JxRS90?=
 =?utf-8?B?eXRZRVJvdS9XOEU2M1R2STFhRU5QazEvT1MxRlIrb0Y3dXkyN2c4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba2d382-cf7a-4bec-09c1-08de96616aaa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:57:08.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGr1OLLDry8FbOTq9SW+eRfELf22VExSd7whn7se8uCT6JC1OZ1WzFs6QfVmM+GEXpvtuPVUJcqRbfgdxfYk6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19179-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7EFD43CE5DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Representor reload during LAG/MPESW transitions has to be repeated in
> several flows, and each open‑coded loop was easy to get out of sync
> when adding new flags or tweaking error handling. Move the sequencing
> into a single helper so that all call sites share the same ordering
> and checks
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 44 +++++++++++--------
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
>  .../ethernet/mellanox/mlx5/core/lag/mpesw.c   | 12 ++---
>  3 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 449e4bd86c06..c402a8463081 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1093,6 +1093,27 @@ void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
>  	}
>  }
>  
> +int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags)
> +{
> +	struct lag_func *pf;
> +	int ret;
> +	int i;
> +
> +	mlx5_ldev_for_each(i, 0, ldev) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		if (!(pf->dev->priv.flags & flags)) {
> +			struct mlx5_eswitch *esw;
> +
> +			esw = pf->dev->priv.eswitch;
> +			ret = mlx5_eswitch_reload_ib_reps(esw);
> +			if (ret)
> +				return ret;

Sashiko says:
"Does this early return break best-effort teardown and error recovery paths?
The new helper aborts on the first error, but the open-coded loops it
replaces used to run unconditionally."

Aware of this behavioral change, it is intentional.

In practice, if reloading the reps fails on one device,
continuing the loop does not result in a functional system.
The remaining devices will not operate correctly, and attempting
to proceed may further destabilize the driver state.

By aborting early, we avoid partially reinitializing the system
and instead leave it in a consistent (albeit degraded) state. In
this case, IB devices are not (re)created, which prevents user
access to a driver that is already in a broken state.

Mark

> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  void mlx5_disable_lag(struct mlx5_lag *ldev)
>  {
>  	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
> @@ -1130,9 +1151,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
>  		mlx5_lag_add_devices(ldev);
>  
>  	if (shared_fdb)
> -		mlx5_ldev_for_each(i, 0, ldev)
> -			if (!(mlx5_lag_pf(ldev, i)->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
> -				mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
> +		mlx5_lag_reload_ib_reps(ldev, MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV);
>  }
>  
>  bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
> @@ -1388,10 +1407,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  		if (err) {
>  			if (shared_fdb || roce_lag)
>  				mlx5_lag_add_devices(ldev);
> -			if (shared_fdb) {
> -				mlx5_ldev_for_each(i, 0, ldev)
> -					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
> -			}
> +			if (shared_fdb)
> +				mlx5_lag_reload_ib_reps(ldev, 0);
>  
>  			return;
>  		}
> @@ -1409,24 +1426,15 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  					mlx5_nic_vport_enable_roce(dev);
>  			}
>  		} else if (shared_fdb) {
> -			int i;
> -
>  			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>  			mlx5_rescan_drivers_locked(dev0);
> -
> -			mlx5_ldev_for_each(i, 0, ldev) {
> -				err = mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
> -				if (err)
> -					break;
> -			}
> -
> +			err = mlx5_lag_reload_ib_reps(ldev, 0);
>  			if (err) {
>  				dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>  				mlx5_rescan_drivers_locked(dev0);
>  				mlx5_deactivate_lag(ldev);
>  				mlx5_lag_add_devices(ldev);
> -				mlx5_ldev_for_each(i, 0, ldev)
> -					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
> +				mlx5_lag_reload_ib_reps(ldev, 0);
>  				mlx5_core_err(dev0, "Failed to enable lag\n");
>  				return;
>  			}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index 6c911374f409..db561e306fc7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -199,4 +199,5 @@ int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
>  int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
>  int mlx5_lag_num_devs(struct mlx5_lag *ldev);
>  int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
> +int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags);
>  #endif /* __MLX5_LAG_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> index 5eea12a6887a..4d68e3092a56 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> @@ -70,7 +70,6 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>  	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
>  	struct mlx5_core_dev *dev0;
>  	int err;
> -	int i;
>  
>  	if (ldev->mode == MLX5_LAG_MODE_MPESW)
>  		return 0;
> @@ -103,11 +102,9 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>  
>  	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>  	mlx5_rescan_drivers_locked(dev0);
> -	mlx5_ldev_for_each(i, 0, ldev) {
> -		err = mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
> -		if (err)
> -			goto err_rescan_drivers;
> -	}
> +	err = mlx5_lag_reload_ib_reps(ldev, 0);
> +	if (err)
> +		goto err_rescan_drivers;
>  
>  	mlx5_lag_set_vports_agg_speed(ldev);
>  
> @@ -119,8 +116,7 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
>  	mlx5_deactivate_lag(ldev);
>  err_add_devices:
>  	mlx5_lag_add_devices(ldev);
> -	mlx5_ldev_for_each(i, 0, ldev)
> -		mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
> +	mlx5_lag_reload_ib_reps(ldev, 0);
>  	mlx5_mpesw_metadata_cleanup(ldev);
>  	return err;
>  }


