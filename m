Return-Path: <linux-rdma+bounces-20020-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P98HBgT+mkWJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20020-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:56:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8744D0B69
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4110D3041899
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3348A2C3;
	Tue,  5 May 2026 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWcROlGM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40B481FCB;
	Tue,  5 May 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995967; cv=fail; b=buhNgsSyUcBfgDt7EYCJd5PykyULrk8ZRXpZRjYrnJ3yycjIIw6Vr7TdODV6fRbyWQV3qkcbI+VFRM7BRGXiEnbFrXfu+FKQjyhGsWDDfEiBCpCDTVyXIT8DZK01GJQwTZgPGQl3P/t+DyVOm3ZmVj4Z3rYI6uNILLhy9J7eEjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995967; c=relaxed/simple;
	bh=jMQ6wjduCb7RKM/R+UQzX55rlwYfNOB/FHZ8pSA3nAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIOcEaYNpC+bvDzkNtIh9yC66rc9ViRxFk6UptfMCeWXtQSnU5fP6lJ606RY1IZ1cI7aTq3yGpL01ghXgMVkgVsTq3HXlTIxdjCLtgryt1/2jfx5tsGAIYyIVjMTScFAqwAtGuNS/jBwbzcuPJrLjhrgAlIH+bXuCr8G7Vr2qvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWcROlGM; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e67pkbV4WNhShkmAp/ETDaVioS1O/F6uGrfrYKOJpM/1g0kim5aw5MtDQpmI6/7NafE9ieWyHUo7i7bxniS8LCVtYmdfF/l/+2+0W09mQsC74sIRuwZ885w/c+Sz6iK5khImVla1SpeTxpQWZvwBixquHn+nciwgAlMKZGxLISF6xXYk+e9oOLuDEAlYd8z1T/NVtstSRn4fcjE79aeqvaRZKxkMXFBwP/TuschBoGpcC6fCsmudJI4VPdjW2F6LPq5fHF54P6JY2yOXQLt5pJAKNVBcmAXHwD2QAn3nhkOX0Yr6SwFJCxlGefuaztJTeBkdVmqHGq5kWLqrEg1oTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGltG+vbaFlooHxN5nQFagamsycoIhzTmEA/fkUsFPU=;
 b=xN6fO8w81ZqEhxpRinf1wvwujUqvG1sxwSF4fZyjc4P4YA4Q2teY+hsOHS7+i6FIWB5+mbOs49YLEZCnGkKJQofWcw59LMCpbN41ljtw2J+1uA7moH3j2S7qeq86hSVZO/ZKFUae+qpQ27rn78SSCDSAvXBN6DKZqVZGR/nGXkfdicfNE/KhDFR+exzCwVZ9OKSMMEZ1WOtBOoQYStZikKdCij0mjbZxgByGTPF55PUNBe5lwYUOjdG7KdYEKCDzws/ayfAEfGb9N3GwK0y2OxoSlgbFFAPunbp6vXX6YEn+sxYU/0L7M6SrLKEYeTrxj9uxKHY7Q1Ck2mUfEleLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGltG+vbaFlooHxN5nQFagamsycoIhzTmEA/fkUsFPU=;
 b=hWcROlGM1LLR+2oIq4G5pAsLE1m8+mkYXcuk9Cp+dxaZ8yp5EQFQs3qJn/V/wqJwDclbMEAzDnLLr9NhwAAJMjlOBvCev7irdtzDdW8PbBisDFpXX+8wF0NSttTnKLch3F2YEKYStgb1E988jjH5eesy4RJDxmCK1gEsqM6mMWZuUmlVlAiQp/zn/FQwSUUC552j7bXxm/Ni1oZLYu4E3ezP/t/fAk/j20tzztFA8MTmHsNT2JiovIvE0VViXTIy9sNSz4FcGeBP1aFbIOW8yu5/YwY21YMjnLdDW6nUi24/OinqceRQ5h8QnEzeccqHbHLnxRFp4fFNFRle9N/Q4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 15:45:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:45:58 +0000
Date: Tue, 5 May 2026 12:45:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <afoQtL6gEN2wUba7@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkfP-8UHaoyLd5Y@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afkfP-8UHaoyLd5Y@google.com>
X-ClientProxiedBy: VI1PR07CA0133.eurprd07.prod.outlook.com
 (2603:10a6:802:16::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8a8ce7-72a5-4ef1-9d1f-08deaabd66f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bkXZsp1G6Az6Cf/oity2rT0Z8/nhFJzaY6KtOsRJmzFFTK5ejICKTNWiK21l8dkqvQ3D0ShH1zef8D2tgAlpGDTgnjUXSsPkIqMeORfwSU5jtXU6nkWo9fCdoCA2O+0yBkCYHM8GUrRsmOkmriYttp+3mOGQ0AiAj4ikBwSS1JsBlC8y5wo6xz/LQBM2Vie0v+JOa0sKgpZRQRlIiT+p/KSCSNV+M28jVXBhPYMF5P8vLkbFk0HtNy+I/6Q3X5MKKzwi3vxBeu3efeuD8zuWVWIBStfGrMS+iplHIdN3dTscDhw0mWpKPsK9UA0YR1E68Lc8tJzBhYDIwJb2G8bnk7nH60qKQrPbu1yPf2zRmROJ7jdjbrxyupYPSJ1pjeX74pvHYSKWNMWK/wIAOSkir52OPqOJYWADp9dIKWoKQlA1vj6AbsXgAWDJFIEmkpSCZoIxOPMJlojTs44W0N88gGLIRayv2GyvaOvfoki+VlhOYhq4uHTuQhLxAQpghfXa5qFwuoI/ZbRVZIYZvoIE9w2GJWnuYD91VamHzDCjkhoPVAlJmThADeHRrbc4dyFYqyp4Ig9e2ecApm8GEcAijLrv3AZ7QARRhRhZa6i/qunQ6UZgSMbnrenFwfujNggQVrgA014Qj1uxZ/FTlQVOA+RdowMQw2EmmBfMm2ccwgSglkMs3pPj91/GS+hHfrPt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUl0cUtEOWFQMjd2TGNCRUI3L0ZoL2hkZ0ljUFZxR0htZm9zM3E4bDVQRDU2?=
 =?utf-8?B?SkZhYmUvMm9hdlJtNG92eWFiRE5Dd0RIT3ZNZWRKWUh1dFNXS3pCSTdJejh3?=
 =?utf-8?B?Y2Q3emZyU051WWxWeVBnd2p2YXZlc1p5L0d3S2oxRnlmbnVySS9GRURrZm12?=
 =?utf-8?B?UDRPNld0SnROenovNDB2YTY2OXFpMG5nb3ZxWGN5ZzBQYjQ4SFFIc2FhaUhG?=
 =?utf-8?B?QjM2Qi9PQW9waGpDcUVZVStId1VVWVhHcTVTVndURzEzbExPOXRWRzZxdFY0?=
 =?utf-8?B?bzg1S0QwZWd3c1ZnZmRIQ2xyaVZnMEJ0KzAzeCt4MHYzeC9GaDJpMjNscHJT?=
 =?utf-8?B?NkJNbzl6K21pbWRPclRHanZQOERiYStyTEZWR3RqUDJWbDRGQ0o2UEpJcjRr?=
 =?utf-8?B?ZTRoVVBsbExUMnErR1V6M0ltb1kwSm5iTExTVHJvYzA5dml4UzRqUzZTMFdR?=
 =?utf-8?B?KzVLNm5LVkVSUGNCUktyZlk3RXFVSWdNemxzRWQ4TUwxM2NWaUpyb3YyQXk2?=
 =?utf-8?B?NmlGN0l3eUV0MGFucEV5bmRHbEdFVDJDc0x0b1JiV0dSRGhWZnhyd3ZNNHNN?=
 =?utf-8?B?Qi95UWZCY0ZoSmtmc2l1UFdpNUVMY0ZsL01KbDFINnc2bkV5SGR5MElCT2Mw?=
 =?utf-8?B?WDcrOThtcEc5eEpqMFM0eURhOHpGN3JrVHVmNm5pSzhrNkpSK05lUzg4a0gz?=
 =?utf-8?B?QlJoWi9XOHVRY2NRMDZWbEM0YndVNHA3akRrSjBtdXVVU0VHamhsYU1reU16?=
 =?utf-8?B?YkdPMU5IYnMzaFNwQklHTjhrbElCYzZUdmx5SlYzU3pCSTcydlpWbFZDSy9j?=
 =?utf-8?B?bEJROEV5RDVxa2xwR1ZndUN4NHdhMmVQZkptYXVWZ3FwOVBtMzN2cHRsVTVk?=
 =?utf-8?B?aElGYTdUclB4QXNtVXhVcHY2RHVRSGM4V2lQTWxlSWlBOEtnQ0pSbmxGdjgz?=
 =?utf-8?B?T1dRbEtWTnlTR0piRlhINy9KR0tnVHR6eTZGWHFyaHB0dTNCRGxmQTBSbGZy?=
 =?utf-8?B?VUJIZzRxUk85cTdvSnk4SnVZODdoTFJGUnltbVJRNzgvQzROSXVWZjJ0ZnMw?=
 =?utf-8?B?TVdBckRSdlliS0oxb1dJSDZmcWIwc2lyNitKZDJqOFNOVVRsdVBlQ2NzaUI1?=
 =?utf-8?B?eURpamYzcTgvbFNoYlp0Y2dwMXhYK2lDYSt4QWwwVlEyVlgzWGN2aXhXWHlK?=
 =?utf-8?B?cldZQUFmRENsa3F5UitKRE9EdlBMdzZoWk90d2pHS2RIVklTQ0pPN0VjTkVT?=
 =?utf-8?B?SDRhUnJRMGVhR3h3OGJkWWxLbTArUFhKQmMxRFRoRldoc3ZQU3lyTDZLRlRs?=
 =?utf-8?B?enJ1T1VwLzJMd0lYcXZRNDk4V1UxTmRoTjNYVjZpbnJBU2ZrRE4xVG1NV3Bn?=
 =?utf-8?B?K0NuMVo1R0ZkQ1R0K2ZMWU5rbm1nUTVMU0tTNTM0UjFLR0J5ck4rOXZPTExJ?=
 =?utf-8?B?ZHhNOHpTSmRYU3JQM0RMMFF4SHJVeTdsYUhLWm55OWwzaGNwSXROdlcyVlVl?=
 =?utf-8?B?eWcwc1ZaOTl2YWp6UUFhblJRV2Y3eC9yTThnTTJjOUY2SDZBMHE3VUY1a3pF?=
 =?utf-8?B?Z1gzTW9WeC8wVTdCbUZGQlpKQUpQR0VxY01INGEvRFduV3lCM04vMVg2UXRi?=
 =?utf-8?B?elVaUmVGb1ppckpSUS9YOGhJK0lQTGZwd1ZrbHcyUFIrcXJyUDJTQkIzUlJr?=
 =?utf-8?B?SHRLL0pGckJMOVk4aGhaM21kZk1GeTBraVpiWElpemZ6NjZ5RDlrQUgyZjRj?=
 =?utf-8?B?RTNjZ0lGZGlDaCtyVk5UdXZXaXBJendMQ2JPQ3prOWJvdFAwVlM2YXY0NUNk?=
 =?utf-8?B?ZVVhYlphZndKWVpiTVo2UXY3eGxHNUpXL2hYMkIvRlBSWGR5d05keVJ0MzNU?=
 =?utf-8?B?VWRFaHF0VzNDZ2tzVEU1K1l5S3ZOeFRlNEF4eWdFZTZKQ3kvbHN1ZzZoem9j?=
 =?utf-8?B?ZU1iY293SDdiOG50YWdmWmQyenM1NGQvOU5GTmxpTlRFdGNiTHQvYjAvZS9F?=
 =?utf-8?B?Q2xGdFNKU3pzVWhaQmkrOTNMZlRyUVp2RTgwNFExUkhaT1ZtdmY0MmlRQ1Fa?=
 =?utf-8?B?SmdvbXBjUEp0Uit4Y0hEZTk2MG43RFNSMi9QWWhobENMZEN1ditKY3Rxazhi?=
 =?utf-8?B?WkZmWE5Qa2ZPS0lMVW0xVGhKZGoyT1YrS2krTE1ZUzJqYW9RSFROTVEvb2Nh?=
 =?utf-8?B?TS9SdzRqWVdPZmN5VXg0R2xoeldveUxrZlZVRFBwVGpLcERKWkZxUXRTV0h4?=
 =?utf-8?B?NSttTXdFb1crcDMzU2dxMWcxY2NJNDQ3ck4zb2RPQ25iMkt0bmxCVkw5cUFu?=
 =?utf-8?Q?xEVCugdNFNSBGTSrm6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a8ce7-72a5-4ef1-9d1f-08deaabd66f2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:45:58.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPAKFGaHcWBkxw6NODrSZ/hNluihjL0g8DsUdqq+SIaqhUYNHHIYRceqKEYj7yAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-Rspamd-Queue-Id: 6B8744D0B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20020-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

On Mon, May 04, 2026 at 10:35:43PM +0000, David Matlack wrote:
> On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> 
> > +/*
> > + * Driver state — overlaid on device->driver.region.vaddr.
> > + *
> > + * Contains both software-only state and HW-visible DMA buffers. HW buffers need
> > + * strict IOVA alignment.
> > + */
> > +struct mlx5st_device {
> 
> Can we do s/mlx5st/mlx5/ on the series?

No, I don't want to do this. Since it is in tree I want to reserve the
mlx5_ prefix only for the main driver. The driver is huge, I do not
want to harm or confuse grep - that team will get mad.

Jason

