Return-Path: <linux-rdma+bounces-22626-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TpuTMxnPRGro1AoAu9opvQ
	(envelope-from <linux-rdma+bounces-22626-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 10:26:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C16EB128
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 10:26:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=GQoGDLmC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22626-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22626-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E292303129B
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34B3E5EF3;
	Wed,  1 Jul 2026 08:25:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42043E0C57;
	Wed,  1 Jul 2026 08:25:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894354; cv=fail; b=fDElzT7vUSAdlGFqA2LA18CHFJlAYmXWwMJBDeCD67g2Xii++iVOIAPKtSCpLF5zF64+nqUuOIQULNjg0u132YOyivsubaOVqUhtgj1F5WCccyeXYAOL09RXjSvy54TEl6tz+r+Oh0JNa3lvz3EIFU81ItsMFypo/nZIuq9EZMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894354; c=relaxed/simple;
	bh=xSTEywQGMpIJr+ajtaXdLJJIcf8NKa41LyV4hEPyzhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l4RJ/XoAZmFYJYesa79GsEFnbAsA1cfJ/vPLyk0CJqiIPEe8/Q8UPQgIz2yyjqf0TnduVnRq0z2m8zvvV2LRvl6n+XKJMx8jw0dkrVPeGebUm+Ppnp4MkffXCvlZ8oYkpZ/9LV1XFzsZ3UM1BgXUxI1KgVhbBOX1VBlWvIMHZMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GQoGDLmC; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azbMyLF51uzlyLjkQzHa6wGCz5yPc2mbvojwkZeUNNOZrvztyefUUh2Pbn/2zG9p/NEh1+P3fiF/OPsOupb4m9ZTWPs8f/ZnuX4ZMMCrT3gN4bgRsE8p6nyWd8skDWQM88jXGO89ZW691ZZvsjkPTiPsKmybCCX4PlX5ExeK/EatTScG5X0SVqAIn8Ll3DKq1TBd9UqRfRdiSRgepQMk4BATDZCQ6eRSEeVYqHJjRcH+mI1PgkCCVJzrJbGjLpwc4bMY+SYr4zuLmkzFTwQmU45WfoSdTOqxnZ8RrE506VUQwD/1eeUOxpdCocKPLb1lYhkfUbOWYU3ldYEOcocmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZWYg95CS3JmMphTfjHJXDa3klH27N6KybtROr5FkCE=;
 b=ni+8mUyyhNfCK6e+7TnJjoS3xaC8UwOTMdSVemlzWZ/VxKM061lCf6O6pnxgouryRXE1neCaWC4v0V8zBefnAl8yz8+bjxsKoUBX4/qRDIeM3lcDz4ajPsFI3//2uWrOP0cdoCh+BRw3rwCxjwVI57GN0BkvNfjeREchtEMAV48VCoD/uP+BEu+D7YhwWFUfLjvW/BZuFiuYI02R4C05RjvsVw9FlkCrejhzfEoVOTAOBYY+m8gnmIWE27nXM2O6dgJPUEnxsQQfOOdDj0P0Owcv3RYtXCLoSJkFI9WKAEmRaYmkivckQGT6dsvfMjNUJaH7tplxhzu3gBXQIPN55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZWYg95CS3JmMphTfjHJXDa3klH27N6KybtROr5FkCE=;
 b=GQoGDLmCPjgBQAeTIMN6NztbowATxQwvngC6z4j5XUWkjgSUgyUT99pLZ6a75lUnCJbsKVg197Vj8YIpsW+DKWYZwGmXmCPGtTBiepI5BjzXzlLaVqCEYqTJraYG2Ii33myrS8j0B1GohqUn6NlAjNw8rb00MWpmTMBeqxUA7gs=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 08:25:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 08:25:46 +0000
Message-ID: <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
Date: Wed, 1 Jul 2026 10:25:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
To: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-3-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260630224328.3218796-3-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: bf865c8a-e46e-4e81-5c32-08ded74a5994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	WrWv53ZKQumZp2YK1jFgwayi+P9/QkFtW42fgbFOA7TZ7ttXFL/c3MjQZZFsGgYtHqvLQFdYBpVX/55hzo4TGbJc2QxXP3EY2zfq54P8YpYtOxS0k2Ix2SWnKrkdNACRNrCxIy1HPnd7aMNGLUc7brNdhkSzEoyYSV+iK7ysFGOa5HFpqnzH+GFZqAy8sKWZwnI7/CnIxcnNW2CH7vxNnz49SwWN2b/GxriXook8+82M4I2XLKftntAzX0yZkKsJ3iflbIm6HrvmH+h+Q9U0TImxbk95Hm25ECAhOcifOcfUPGoJMLENYvbkx7hjTmCZdKboIXxmiWUVe6J+ePALHcdYjjQTCccMr+5KILRFIz3AecD1/XLy/rSJOwIUZci4qn9Ru8/LRCTiU+xyjHoXBRFpIA/niYYj/bK2w4AvFivlGYpEzAf6/PByabgaDkX+aHtj+rzaDmoWY+T3eKmMAqT7eTDZOdU/ZlebtKm0geSUNNVR//Vgi9tLVKgf5GM7gmrsKsz8xVi0yDqkMG/mQDIfaYSJVk/IDKQw+IfbDq1IFOyfNtYMrjUWm1CPDmg/HU4LaSKLMFk8WgA8TKr5JeO1P8Hb0H38H5d5HudYzB2hidOjYJHRZ4NoIWmDFc5xlE5P66wQ4PdUrKNKqxkp8Ibh1CBdJCRhJF2SlZSqiPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXlvY1BoaUJsRVVHYTEza3hEZEROM2diU2xzK08zNUdYaHBBaHJCNlpZaEZH?=
 =?utf-8?B?a1R2dmd3Ym1oS2wwWmdVbEhGV1Q2bU55QWtPdUF3d3lVamsvUW9wUEZERXhS?=
 =?utf-8?B?MnJ6RUZ1SDd1N21LQ0ZXYXFjVlZRT0hqb2lGaW0zTll1MU1uRENlMVFrcDJY?=
 =?utf-8?B?U25kYWhNc3IySGgzdGR4aXR2aUllTVhXd0ZFN0dtb1dnSms2bmVBaUFRbGZ5?=
 =?utf-8?B?czZwZTZ4UjZncTZ6SFNSYXl3SmIwakZRVXFObjV6UjZENTNzaUtzakFIVG41?=
 =?utf-8?B?d0Z4RXVrUU92c0xPdExvOFdRYzduYUJUT0RyRDMyaHhSblZEL1I0RXZyV3Ba?=
 =?utf-8?B?RndoenhHaSsrNDZROGxwc3BnN0dHbm1DVDF4R3E0WUpIempkWDE1Wlcwb3hl?=
 =?utf-8?B?TXZmTkVjeFBTa0g0Y1dLRHUrcmhpUXEwaEc0VUloMHdYNDJ4cldOQ002NCtF?=
 =?utf-8?B?V3NCeVFCNHBrK0lPS0VDR0poNyt5N0tWK1Z2SEZmYjAwb0VqUml2K1FuWi80?=
 =?utf-8?B?eENjSExEZ3o5T3g2MTlodVRiQ0NZbWcxZ2J2OWlJN2Z2d3QwZDNROSs3UlUr?=
 =?utf-8?B?czh2KzRWbW55Y28zc1F3b0w0bitVUVZza3BoVmF0Zm1jc2U4Q09BWEE4Mk54?=
 =?utf-8?B?VFZBZndiNUd4RkNiQ3Y4U21GVWFRTHRrZ2pORFBUVGZCRGlVWFIrNTdNNktu?=
 =?utf-8?B?Zk5FWEl6MjNaSUZrVzFQVFFnL3lqbURFUlVLcURaZTdac1M1ZEc4Q2k1UUln?=
 =?utf-8?B?TnovNGRSRWxXMDE4UnFHdzJIMVB2c21jMm9UOG5qa2JxWDNHUG1xdGx4SHhC?=
 =?utf-8?B?V1BEVURUc0h1REF4STNRUnpUUlNtSHo4SnFhL2ppaFNnUy9PNGFoODhHMHUy?=
 =?utf-8?B?STgrQnBqNVpFM25aTUVUR0FCUGFmWDVac3hjcnNCS3dQS2ZibUxEVnZWcGF2?=
 =?utf-8?B?VVQvNXlnakJubnhrY3RIeEJvQ1c2RGV3MGNSVUVkNE9JVEdTMHpQeW9taTlj?=
 =?utf-8?B?RGJaUXFhaGowQ0pDL2pYY1pVSHpFRG96REFqZUFjR1VybE9UNlJNYXFlZVRx?=
 =?utf-8?B?aEZWanhFcm9PSU5NYkQvZGJWaGtaVkwrK3RxWFpMNjRpUlhPbm1oOUg3andH?=
 =?utf-8?B?N2NnMURteWowY3ZXZDVXWHkxNWt6L1VGWVJkKzB4YTY0MzUxS0VaaFhWcWF3?=
 =?utf-8?B?dzRqSlpBN3RwU2dTTzNtKzQvZko5Umo4WmpaVFQwTFN5K1FmVEFNY29VTTVv?=
 =?utf-8?B?UHErMlJSSlY1MC8yV3dQZTQ5UG4vOGVVejFBNDlERXRJU001K0t1L3dLKzhw?=
 =?utf-8?B?VU5XWTEremFvK2dJLzNOenlrZlhMWGJ3ZEJlQXNSeTk4WnZ6TFdKaFpFTUdO?=
 =?utf-8?B?QldPZ2E3QkI3Rmt2YlV3eTBwU2pQUWp4bktoNHl2NVlGMzk0OTV5TlZua0ZJ?=
 =?utf-8?B?dnN5SWdZK0wwNkxJV2cxL2VMWnVpSVdUQmJXOGpyNUVTVi9jcFpMQ0FyZXo3?=
 =?utf-8?B?dklzK1pGMUtRS29lUXpJY1d1bkE4NEV0bmM0M0ZlVUViS0duWlBrTXlPbDJj?=
 =?utf-8?B?RG53bHpicHJkcHJnQWtYVFJBR3NCeC9vd1FOY2JTVE80WTJ5UkdlZDZkYkNo?=
 =?utf-8?B?akp2aU1sbHVQNWR0cVk0YUp2Mkp3Y2hTYTllMTI1cENTZHpCVWZNWHlLVWxa?=
 =?utf-8?B?SElpUjY1YjFxOSt5YlIyeGJ1SkoyWDZTQUJDYndtaHhxc29DSmE1a2ZIWUVQ?=
 =?utf-8?B?NjJoRXNwT1YwS3FwL3JCWHhkakJQWjF2dDV3Ym9GSmtLc2cyTFk0azVXUkRz?=
 =?utf-8?B?dU9Ram9RSTQxQmlXUjRYaDlMTElZNWJQODRnb0hiZ1F2eE9aSkJLYkhuY0xw?=
 =?utf-8?B?cXJMWC9JN3JEU3VGUXd4dDhRYUlsMkxYQUt6cU9wZHNCQmw0T0FuMDVJVHZG?=
 =?utf-8?B?R1Bad2psOFk0T1l1TGZRZUUwUXFicTNZRE85NEs2c1MyVU9SSGRQVThDY2RJ?=
 =?utf-8?B?Q09NcW9kL0xmRHEvY1JQR1IwalkzR3R0S0o5N0pFL1BXSFBHem0yK2VGUGx4?=
 =?utf-8?B?enNLWGhiTm9jWGZsYzZOV2tBT0laYmRKWFpLR3h5TW4wLzNFWHRaMmx0MWUv?=
 =?utf-8?B?S25mZHRJMzh6bmhKbzZCaysvSURVdGdsY2w1dHpWV0FGbld6RzViZ091a0x3?=
 =?utf-8?B?R1ZqSHNPK3dtNXF6eS9zMHpmb1hBZThYNEZMcVcwM1IvZkhxQit5RytOK01o?=
 =?utf-8?B?UmN3MjB3eHJreTdqR00rN0JTSE1KSWxacmovYnZhSzBYT0JobTF4VjlFeFNP?=
 =?utf-8?Q?AHO3w4aX6SwAG2Vp4H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf865c8a-e46e-4e81-5c32-08ded74a5994
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:25:46.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZIivxfv06jVkznQhPMvWJizJuPhBGtHi11YKMrDoixeqPm5Ns8Kl7Jd8AHLXOS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22626-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,amd.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 488C16EB128

On 7/1/26 00:42, Zhiping Zhang wrote:
> Add an optional dma_buf_ops.get_pci_tph callback and a
> DMA-buf importer wrapper, dma_buf_get_pci_tph().
> 
> TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> distinct PCIe TPH namespaces, so the importer requests the namespace it
> can emit and the exporter returns the matching ST/PH tuple or
> -EOPNOTSUPP.
> 
> dma_buf_get_pci_tph() is the importer entry point. It requires
> &dmabuf->resv to be held while the callback runs and returns
> -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
> 
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 22 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..7a4c9b0d5dab 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
>  
> +/**
> + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadata
> + * @dmabuf: DMA buffer to query
> + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> + * @steering_tag: returns the raw steering tag for the requested namespace
> + * @ph: returns the TPH processing hint
> + *
> + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> + *
> + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> + * exporter does not implement the callback or has no metadata for the
> + * requested namespace.

Please add something like this:

* The returned information is only valid till the next invalidate_mappings() callback from the exporter and should be re-queried when a new mapping is created after invalidation.

Apart from that it looks good to me, but I still think we need some kind of example that this works for other DMA-buf users as well.

Just demonstrating that this also works with some simple FPGA or similar PCIe endpoint should be sufficient.

Regards,
Christian.

> + */
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph)
> +{
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	if (!dmabuf->ops->get_pci_tph)
> +		return -EOPNOTSUPP;
> +
> +	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
> +
>  /**
>   * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
>   * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..53b2686ad8fc 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,26 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
>  
> +	/**
> +	 * @get_pci_tph:
> +	 *
> +	 * Retrieve PCIe TLP Processing Hint (TPH) steering metadata for
> +	 * this buffer so an importer can program a matching ST/PH hint on
> +	 * outbound TLPs targeting the exporter for peer-to-peer DMA.
> +	 *
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
> +	 * @steering_tag: Returns the raw TPH steering tag for the requested
> +	 *                namespace
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 *
> +	 * Optional callback for dma_buf_get_pci_tph(). Called with
> +	 * &dma_buf.resv held. Returns 0 on success or -EOPNOTSUPP when
> +	 * the exporter has no metadata for the requested namespace.
> +	 */
> +	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
> +			   u16 *steering_tag, u8 *ph);
> +
>  	/**
>  	 * @map_dma_buf:
>  	 *
> @@ -563,6 +583,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
>  		    struct dma_buf_attachment *attach);
>  int dma_buf_pin(struct dma_buf_attachment *attach);
>  void dma_buf_unpin(struct dma_buf_attachment *attach);
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph);
>  
>  struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
>  


