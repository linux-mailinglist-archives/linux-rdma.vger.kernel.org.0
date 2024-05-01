Return-Path: <linux-rdma+bounces-2201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF918B8F12
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BEE2813D0
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452641B7F4;
	Wed,  1 May 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKxPAh4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2318EB0;
	Wed,  1 May 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584773; cv=fail; b=Yd/y7aoIxCXFlCD1ArdciBfgwALhUt+63Clz60teJ7tcQsC6kYWtknsHvRA5mrnGxNwIxFRCv3l3fSru0Zy8vYDTOQyFNH+D7zGe136nLpvY1LYOhXmcQe4iM88QdEGGtUsOT5IS5CxqeDA+Ux+Q3lxq1GLpyUUpvDqsI5EH1i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584773; c=relaxed/simple;
	bh=ogBeI8BHisn9p31EvVVikEQkdZ2cbh449JDQOd+iqBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fxmww4txIm1rGJPiGdOuDiAQ33LVH0rtgr1O5IJoesf/RE9YGO4xRi+gV7GUXuREMbaxuJNJy4NKBcrLv56EggGCYsJwd4r8QFnmRIlCDQHa1z0VUunLlKBr5YIdsp7QB7GFfv6ldJlOYjpuIifCElSr8whY7RwUG4PC5msChoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OKxPAh4v; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMzPj/n3q0dnwyG/ZKehG3jSHKoJci4dUvZz4DchmNpSwAnS7zTqxxzk/8UMlDpblCcHZQ+XL2RmcqF8Ki3Xsltr+fLPyJEyR/RgTvLZb4kHmcIDyFaXiQ0VrLdYPYvVcg1TElzHwQ6YASqK0S6vCc8zSOKPux4S4/HZcZ9+c21IKeR3rjCSZuTTopQlGPdcDZni2zEX6Ne2GNIgEbCVu2darDHNqKIczg+XDhA5XFdIXk78DKyauMJD/t5Jcx8Ycuz2q4x3a/UcUcJ/9c0roJ1f2sFwI5VkM++DDyTUWcnzGDoa5QX/+WciPmVJFpSYQiCBJ0gztURJ4tEkoJ9eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLH0+w6XBgHOGlshWZQJuVLE5OWeyEQndOtsrWjs2r4=;
 b=fSda/RxMETfbO1Ra2fc6WpCkp7zw5qQ6201m7EmHNB9PR0+e+G3q2je13DO98yJvlbXlrgxgqXGEeMMdf4U1wz33+htiU8jYCy+U5/TLbFeHmdFJFlAUqYz2/Q4FxHq71iJxBIFdHMdvgTELKTQAdfFQfsOUMo2IaHZyGRl8SDLhp79s5nzsBUQWAWXOFRlYPicNPji/vkReivHz00WyKVg7lAi7UDWXFopGIzgUI1Ixq0mMPCYImMSgTb8mAHy0F8PNLG5BY3y7ux4fVgPEl9HOjaBnYj0LRRZvK15wsK7TO+F6OtnuJpqjZwErA7i0YL+9U9ljGieTo1hQqkW/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLH0+w6XBgHOGlshWZQJuVLE5OWeyEQndOtsrWjs2r4=;
 b=OKxPAh4vtcNp4kU9p9PXZ2wiiQxMz2UTsPFg51xXMhvUqLi0MxHrqLmwa9eQnkb0RhL60ZxDrvsvDTwj2pXK0DqJLICxd2CyjVcjVBJ9Hb953sSX5OtX/azKeG2f1rWTCorOcntb9Y7ClTd0Zf9Gsqjrn4lm/bALn4Plccrb4NyVQtqnVHqjijDXtbFGp5+vj0zVWXxagBGJWDpJG1TH+7OUbuTKCojUMiz/7fIFTzM8yRpyr+RFJrNhS/7AEGPAOUPf7mptaw4y7o5cPPc1gSP6ww4zERAWwnpM3nWHScyH7iXZ+IukD5ci4xopSXfCIYHZDch+AlfGVfzfoFEX+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 17:32:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 17:32:48 +0000
Message-ID: <8767cde0-0ae5-4532-9460-90960bc40eef@nvidia.com>
Date: Wed, 1 May 2024 10:32:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Pak Markthub <pmarkthub@nvidia.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240501121032.GA941030@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: bc68c3d0-d28c-40ab-a211-08dc6a04b827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEdpTUVGYXdEZXJsL0laZGdSU09nRkk3OW9TVkpZeStXb3RmWFQ5WUxjUDBz?=
 =?utf-8?B?cm9zditGSUl6S2FwOG5acnRiS08wTVE1RTg2bWlZNGNZVUpmaGU4WjBNTFZV?=
 =?utf-8?B?SHFoY1N3bk1CcndDcTg1dG8rcFkrc3lCVXcyTlBEckdmWmVMV0kwL1MybUVj?=
 =?utf-8?B?Umh2SWloSXUrL21lYjh5UmJ5TTVTVlQ5cEJRcEpUQ3NYYldWZ01lY0d6Uldr?=
 =?utf-8?B?Z29MdGFKc3hjaDMyKys1Z1g1c2xCcnY0TWc2M2REMnhuaS9ScGVCM0VrTEds?=
 =?utf-8?B?Q3c4MVBJbjhZV2dkZVgzb2RNdHhyN3dvZWVVT2Iycm04SjBQMFo2T1FINlBY?=
 =?utf-8?B?TmYrUFNacVllWjVGZUt3ak96ZzFadFg3VkhtZUNjSVdycVNJUCt2enlDTVFQ?=
 =?utf-8?B?QWllMmZpRGo3dDdlLytTSEJFUGd2dUl5NVhrUkhFM0VYOHM4SjQ2bGNseTJE?=
 =?utf-8?B?VERSVkdNSmlEQ3dKS1JDOWhJSnVlU2txalhSQm9sOHFUL1VDbGRzWk1hWVpz?=
 =?utf-8?B?SXJTa2pCR3RaNWtvWFRBTVlMdEkxSFJuVVRTbDFYdGx4UDYzTVR3SFhLdDhm?=
 =?utf-8?B?MnF0NVp4YkwwcFBiOTZHeVlsUlk2VHVYQXlZQUZBUUNLSjRMV3ZyYVNaUDdG?=
 =?utf-8?B?V1lPZXZ5VmJUZlNkRi82L2lKVTRTbTc2MFlRRmhHWFJPcGdhcmE4Wlluc1Mr?=
 =?utf-8?B?L3BwcFQ3SUZVVUQzNW1TYVQyUVhnSFNqNVNqcWxrd3FCUTZGeE1MOW5aemJX?=
 =?utf-8?B?U0FCRFJzaHZ4UmdFaXNWSE85SWd1QitPY2RHcktZeU0xUEpzVGc0MVYrZ3Vx?=
 =?utf-8?B?ZDFWZGNabFlETlNTdXBhQ0puTFdPRE1USFVRZTVlUzRDbURocEN5eVhxc0o2?=
 =?utf-8?B?VkxzT044NkZQdDQ3WS9KRUtxajNIWjN6M2g0d3ZDbmRSL3piR1FLWEtwcTJO?=
 =?utf-8?B?SCtYNitqdFJyVzhvN2NtQWIvbHRsRzZBaGxjdmZRU2dsZGdQNWhVeFlHaXdQ?=
 =?utf-8?B?STVIczhGRlpGaWJDME1mU0R1VXNQeUkxbGxpTCtUTVNlNzR0Y3l3SEliRlVE?=
 =?utf-8?B?K0E4aEFoS1hSWEcya25YMms4dzJFVzNwWjRZeUVEaGtQWjNaaHNYZi9yTG5W?=
 =?utf-8?B?NllDd2pZeWFJSG9DVUx0NmNSZEtDSThwYzhWeERkR1M4VUZHZTFwbGpxTHE0?=
 =?utf-8?B?bEYwSGk0WCtoM0RFZXgvU3laT1JKeUNkdytZOU56UHhweDZMNDJDYXM0L3Rk?=
 =?utf-8?B?ZkVwVzhQSDRUU0EzM3FkbGI3M1UxL1RMRFVZMUsvR0xSWnNnUVdPaGU5Ujh3?=
 =?utf-8?B?Mm5MVHJ2c2R1bCtKdHpTTkg5M1hCa213bnJKZ3JML1l1bkZjMnhsR1EzWC8x?=
 =?utf-8?B?MjRQdkVzM21rTklueWFvSDF6S0t4Y2lzTVFXZmhLQzdrczhSZDBkYXFLRk9Q?=
 =?utf-8?B?UFV5MThTVVhzYWVwUDdHTGVyMTV6ektUZGtSbVlsc2hiZGZjUllDV3lNdVVE?=
 =?utf-8?B?TDZMRWkwbUZLTzhOZTNPZGxaUWpoMFBPMWdpTTFEQUg1VDRLZmhDVTM0a2pS?=
 =?utf-8?B?eDRpRmRWVk5yOFNnTHYyc2FTdEwvTmF5REdzdkh6eGp0RGwyYU96b1UxcGNK?=
 =?utf-8?B?dnlsOWpzQ2N3QWZuRnVObWphamV2ek1hUFd6SytGWWtYVnVFNnkza2hjdW1R?=
 =?utf-8?B?dmNBMXdUM0tSelhDVDd1eE03RGJ6UnQrbzUxUWMrRGRJdHQ4am4vdGVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUd2aENsUFQ1YXVPNkhyeGVPeHR4aEVGZnNCQzRTTk1uMm9VS1h0bDM1MDk2?=
 =?utf-8?B?S1l1RTBDSXNlUDJSbU9SUzloZ2pzMDExd2tPRWIrSE90SEhXUHhYS0FwWXRq?=
 =?utf-8?B?eklaU3I5eVR1V0oyLzRWQU13dE85YzlGbUhCSWlRMXhsUFhZcFNQeDZ2S0g3?=
 =?utf-8?B?UXdHK3hnUlFXODRmNDRzSHNGMitjaGhmTXA1ZytERTZkVlNjTHBlUFVDRFlJ?=
 =?utf-8?B?RXhiMkdsUEwyZkhUbFhLMVhSMGlQOE5YVXRkc2grTUxVK0JQUjR6ckI3cTVI?=
 =?utf-8?B?NTdIanFaUHpsRjI1d2VPQ053YTRJb0JhUW9TRG8yMlZxaDJ3ci9ZSmJBSFlj?=
 =?utf-8?B?MEFNaXM3bVR3azBNdkdZdXdjb00yVVFyR1NEajNRaGs2VHNtdmJhaERteXJC?=
 =?utf-8?B?eGJQTE1GanNGRWxWb01VenVHWUFvUzAyQ0dreVJhZmltdWlkdUt3dll0d2cy?=
 =?utf-8?B?WnBNbUR6ek0vOVlGdTE4bHlsN3ErejBHM3ozWFhYY1lvaXQ4c203UURKemkv?=
 =?utf-8?B?UGNTd2RLbnBYYXpXR3dOZnBueVdzb2VId0ZscitwcEFJaGErc1VneHJGQjJr?=
 =?utf-8?B?YnNUaFZoY2hsRVM0NXN5amlPVHE4UzNzbjBHL2JOUllwL0EzQVo1dEZaRkNQ?=
 =?utf-8?B?WmQ4ZTc1TGsydndVM0pJNUQ1SnFqQklTeDZCUTUxUVd0VWovSXUrNm84aVd5?=
 =?utf-8?B?bzNrQ25UWkhBUUZXVEhHZ285WW9oTlR1SkY2TGx6WmdNOHdnSjZiYUExWkxy?=
 =?utf-8?B?OE8xaTNnWFMrZGdoai9yaG8xYk1NTXZ6dkN1alBLdGtVVXVlNDNmREJNdGU5?=
 =?utf-8?B?MVk4T1NkbFhCU0srNEJRUUlIc25KZWt3NHdyaE4xMzJXWVhQYXlJdlRhMHVM?=
 =?utf-8?B?UjkvYmZpOGJpWHkybG4wdTdaTVBWcFkwS3JzUTBHalhxVzFqaEZBSC94Y1VF?=
 =?utf-8?B?Q3c5VjV2dUZRSTJSSzVQWmllNUpaMlMxeG1Eb2xNcGdCbDNuU1dEeXUxYmJI?=
 =?utf-8?B?L2RuM1h2MnhMOW5ieGRYVzN5MjNqMmtBQW9Fb28zbHg0U3plR1VYdzY5VWpv?=
 =?utf-8?B?TVdySW40cjN0V3NJSmxQY0tud21MWnBpbmtkZjJHNWZIR1kzcVJ6UGRVMGZO?=
 =?utf-8?B?V1pEU3QzK21kZk5vRlhRdVFnRkU1bUZDVGh5Z3VMS2Rwa2tpcnBzVDZRQU5N?=
 =?utf-8?B?V3d1cFhRTUo1dkdEMGlOMXN1dUt2bkdhUzhJWVA4Y3ljSUltam0zZ1JySTJO?=
 =?utf-8?B?KzlOZW1YMmQ1K2VvWXR3azRwSDdYT052ZmZMdmpuZnVZbDZHMjJGQUpHTTlT?=
 =?utf-8?B?QTh1WHJaRkJsVzJvUXJqUXpjb3JmZ1pRS2sxbVhrbTRZQkNLcDdNUzhGQ0RW?=
 =?utf-8?B?aWhiSnoyMTYvNzBCWmEzU2E4aFZ4OXI0cFNTVm1pL2JZb2xFQXV4ejVTOXZS?=
 =?utf-8?B?b0FOaTI0R1cyY25sV0hxZ255aVQ5Y1lDVWF3NkMvc1B4eVF2a09sMjZUUDFj?=
 =?utf-8?B?S29uUWp1UzRmbStLZGZ3N0ZxQlRRSmJEZHBkRUVPUUdGdnhTY002Vk5DanBD?=
 =?utf-8?B?amcrRzFJTHNqK1ZiOUVQbEhEYXNKWjM4dXZnRDhsOUxCK0pyckFxMDErbk5t?=
 =?utf-8?B?dDJpUXZLUVRjTnZsUkljS3ZmM05GSkV3bEd4L1FJcVdCYmJ2T00zYytlTnZZ?=
 =?utf-8?B?aUlpVzZPc2RLay9PM05tMmZIZXVOVnZVV2w3TzVsU2hnejY1aC9yd2xDKzNl?=
 =?utf-8?B?NE9EMXh4NVdlYmtPaUM5Y3prQVg2bytuRHlxUHdJaWtnNHlKNnZsWTlMa25K?=
 =?utf-8?B?emR6dHFTczdGY04vMjFiQ2JMQzVNc05BWXdUUnRUajk2SjZzRXhDRitvVHVh?=
 =?utf-8?B?REFsaUI1NTlmTUhTR1pZOFVLOUYvYkpNV3dqMmhsSFJiTWpDREJCQjhzRVM4?=
 =?utf-8?B?VDV1ZlphMGE2S3ZDUGg0aWJZSlpidE85UG1JR2dQZVpPREdNR01oWS9mSmFO?=
 =?utf-8?B?TzNEQWI3cWVsaWFmU3RzWjFERnc3NHRYTG1LYWVwWUR1OWtBVHFCOC9maVFD?=
 =?utf-8?B?UTAvOUpJL29jaXVrYUlFMWR0aVhzT1F4RWFxYUUrbWNQYngrdzZmcmMvRHlP?=
 =?utf-8?B?K0ZpUElWejNEWW5GTXNVQnFtc0Nqdlk2eFVjOElLaFlicDdpMi8wT2dlVUYy?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc68c3d0-d28c-40ab-a211-08dc6a04b827
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:32:48.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: douVMrheh0JzJRG/ECEorighNK4CQsrIMsd7QSyhtazYqAUpIr60CHj2Fmks/wJH3+SwaYRQWndxZKiEuPRvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569

On 5/1/24 5:10 AM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:10:43PM -0700, Christoph Hellwig wrote:
...
>> This doesn't make sense.  IFF a blind retry is all that is needed it
>> should be done in the core functionality.  I fear it's not that easy,
>> though.

So do I. :)

> 
> +1
> 
> This migration retry weirdness is a GUP issue, it needs to be solved
> in the mm not exposed to every pin_user_pages caller.
> 
> If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
> then it is pretty broken..
> 

OK, I'll work on finding out what is temporarily elevating the refcount
and preventing the migration. And see where that leads.


thanks,
-- 
John Hubbard
NVIDIA


