Return-Path: <linux-rdma+bounces-14313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27CC41B73
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 22:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8921352706
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB834BA40;
	Fri,  7 Nov 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBlZHJ2F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72934B662;
	Fri,  7 Nov 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549585; cv=fail; b=uiV3pALv5lPd29l/gGnlSvhQ/3nsYEGRpCBOpaRFWVC1DMJWvIcrabcCoFa5gLVwQr4krKdTAsQED7iW+kL2mJ4AdPhSYnl9p7H8J4W75ACr4KxXZoNo0HvkKcG9O6BbNXC9rK1MdPuJOTrUx5bhc7qGtcfF+5H7vt4keT0+mFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549585; c=relaxed/simple;
	bh=iz0EKegUrDgTSvPtitgHIuRa78dmDv0iP7uyyAYD7cU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JUdx5JN1+2VOEejlWPk+Hkl1v+zGnFiRC9hxzjkfsX5cGilKSdLDgQa+iJ9+32L2SvFnwxfdd7Xy0M99uaC7gU6gzEXT0VA/Yt//mL03HRmeTRTLcOuzM7H6tllthQUDLNQ/3NFsp3txquyw/CKyJKv49smrDCicQ0JF2b++Cac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBlZHJ2F; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3pAowx/2w8B1Ds2DkL0f2i9lT2KvYd6Hp4I7FV/4nOre87W+3891MXqcQliWQdHpzjDLwwOVp0qBgEahTvSr9XrnBF3YNuCNukVQKpnfgB1R1nPWOCV26FvfrM1SbTXjV1XVffGDkSuYkuOBbL5znfCroyltVIbG9gjSLy9o8DfgjasU505FU9kta0XnUe1bGiNUf3DdVO+MF02soQKR89QQLC3uwsSSe+TAmqewoprvqYOyHH9MmLsXjmEvpMOejcgRxbwKX+9uvz4VMEmgH8JCaI13KNcSwHQHVjZzx3ei6AE3GXEiGC4zWExSX0NH6Po5++afDz1tXpjTFgRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz0EKegUrDgTSvPtitgHIuRa78dmDv0iP7uyyAYD7cU=;
 b=gLK1XwsWiHOz9mVQvxgsmsRJx2tU4yCUTf6jgR1H/hSkgYRO53i74++BjQythCaXA/ZxzsmiUkgnXndhOadG4zR/65IkXk4twlb+QC5D+ggq7gocQqSfEwvhviri9wYglOGTEGAk7b0vo95NVGasl8oblIY96T8ZHExOE6OKs4T22WEuYA3GVsC+ol1GK+WUncdAHD84PGrkyJ/zF2MA+j4cHuvxoBONJ08+L5gZKBNa9WecXODYTqIIR5/pnNXg6D1zb4kNObh87oUZklb8dREnkLj46eZGYuyD1WqLocbbGoQ1CruTCn2ZWdnaiAK3GJabwgmswUHJDs1MPzb1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz0EKegUrDgTSvPtitgHIuRa78dmDv0iP7uyyAYD7cU=;
 b=tBlZHJ2Fnx2Rrjy90bquLWUzFK3bTikteLbtPS97j1GbizQNkNccpLlxJ3rl2IjFWel2BRhXWQoKtWo8vYKmIOkXIQEEwONqlwit8y95ZIE0lRHZo1CT5Ikdpl4BtPDrEPwEjNw2WNX2l8BzKXSMiDCPddVEskUhyRo6PrDtIELe+OUNGfdUmUVCFeDwEea2gzEA8YV1WH5s82Atw24aHtYRDk/kucOy+91PpiUJJqHRySjHUJkgW085fdJtQDcCcaXZoSYCfblPW/Cd9G4vJHxEkPuemc2hYrYD07q7Gh0wIPRyIv9GT1t6fa7z3tx3ODVveKfkjfZUw8cSvQQgWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 21:06:21 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 21:06:21 +0000
Message-ID: <1b9b26a0-ebc1-44d6-ab6e-ac49126bd6a9@nvidia.com>
Date: Fri, 7 Nov 2025 13:06:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in
 ib_nl_process_good_ip_rsep()
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca>
 <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
 <20251107191736.GC1859178@ziepe.ca>
 <CAL4kbRO+p0f6cKLONf=qqTU32G2YCEtkgQpu6shX=zBeAa1vFA@mail.gmail.com>
Content-Language: en-US
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
In-Reply-To: <CAL4kbRO+p0f6cKLONf=qqTU32G2YCEtkgQpu6shX=zBeAa1vFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: a6adb70d-b91b-41e3-a2ec-08de1e418035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmcwS2FlOFBOS3RRaGpYREdJQWNaWFhzQ1hvZ1FaZXRvZ3ZvOEcvS0ZjRnFC?=
 =?utf-8?B?TzJYL0lOZ0JWNEZPUlk3OG1DNktUUkFZVSs2YjhkM1l6YkQ0K1gyY3VIVi9j?=
 =?utf-8?B?c1RJWW1MR1RweUZUdVBhTit1MHNhRUw1QTVrRDR3ZndTb21BbUh0K2RmeHg2?=
 =?utf-8?B?bmxwK0FBZlRlSmpmNDJuYWdINFAxalEvZ1dxclA1QXUvSTBTUWFvU0tEUHRZ?=
 =?utf-8?B?WVVKVndYaUhmOUZRR1JpSmVTQ2taSVAvd0Jka0tCa1VwU05ZZlZZYzk0OUR5?=
 =?utf-8?B?ZXgza09qeTQrempOdUs1RVZjOVpjNXB5MFgvUVpjTDlzQ25KM1J3enNyZmNX?=
 =?utf-8?B?NklEU05kWUxBdEZKOUxDeTNYcXN0UXI1b01UMTFScHJHMExKWkIrQkY5RDli?=
 =?utf-8?B?L1RydXFsWlZxNEViRVZxTHBUZWRrVEZRcyt6c3VwSitILyszZ2VPdmVEaUFJ?=
 =?utf-8?B?RnlreVh1VWpCVXdYaEowYVBsZng4dmQ3QVVlNWpZbm9MWFlES1JlajhLbS9t?=
 =?utf-8?B?US83K1ZMa2xZSlhiYk1KVHRGc3NFQXBzZ3QrSmM4VlA0dXJZdFRLa3dXQjBL?=
 =?utf-8?B?OVdYMEZmaUtQV1dXbDlaNllkeWcrSVRmaWdHbmQvZThxUm1KbEVWWDRFZ3hM?=
 =?utf-8?B?RWJKZ3RVbjR2K29QQytlTVJ6aGY4eXh4U2FmOFBMdFRzZ25uaEg0dkxiL3hN?=
 =?utf-8?B?aUZ2c1hvOE1hUkJzRW4rRGdVZlRKSnY4VzlCZDJiRHZCbGp3U0pTb21HS0h4?=
 =?utf-8?B?OURyN09tNUFBS1doRmdidTV4UXRENCtCc28xbXA1U21yRW9keFZBdzRnQ1Qx?=
 =?utf-8?B?SkI0NGQzNzRXRWM3ZFJvcXQ1NGlSZ3BSTW5HMXJVU1ZPa2hHbFJzTlF0NVlo?=
 =?utf-8?B?L0wxN3IzQVRaSEM5N29Ienl2V2lhdU8zeTZJL2QweEFvZVBvb2hvdUptMDl2?=
 =?utf-8?B?Z0VIREJNbU51eGdiZDFWOEwwaUM2UFIvYnRGQ01sdFFGTEl6WmtnRFVTN2sz?=
 =?utf-8?B?RU5nSERYTnhNUC8yU3V1WjYwNzdwdWRHVGFCbTV5aTZ5TXY2TEdSQkpCeElW?=
 =?utf-8?B?VlBCMDFIdXVNSmc2U3JMTm1WdEl2Y1crN2p1eFdYK1VPamp2QXR0MFdMODc0?=
 =?utf-8?B?TlRiczM3TmZ1a0RuWG8za1hxcS90cnR1Wm1IUDNyUTl4ZG5hK3lDTjBVSFJM?=
 =?utf-8?B?NVVsa1lmWFkySWxIY1BWQ2hZcGVVUml4azNGOE9NWms2OHU1MFpLaUNyWHFU?=
 =?utf-8?B?YXBuT2JMeXdLQ05aZXZiLzlQOFpTRys0Lzd6UmhnNUNKdEJKYy9LNzdrbE1w?=
 =?utf-8?B?SmtCek9iV01EMzdRd29QUlRpUkQySytoRVNwM0tWQlRCNnBYQ2Fqc2hVTzhK?=
 =?utf-8?B?S1gzRVhYRFdPOWRSdUV3LzVJQitwV09QTTZwR2FsdysvOWxHMTR1amdaMHg3?=
 =?utf-8?B?QnJRY0dQNXg5dE90ODN3R2VuTzMvK3FrLzNiVkU0U0NVK1F4WXEvaFplbHNw?=
 =?utf-8?B?QXZEUGp2UWs3eUs4clVJa3hKMTZGYm0xalJXVFpTcXJuVzZpQ3hEd2xWMzVB?=
 =?utf-8?B?VDJDdlM5eTNxUWJ1SjBkamY1TGk4U1lraGNzMWtJZHc2M1NmeUJybk93UlN4?=
 =?utf-8?B?bTBJSnQrSnQydm1ndUgrM2ljVG9OYUsvU1pRWWNiRjBQTDRVdmNoeU5uSjZM?=
 =?utf-8?B?eXhwVHJuN2QyUlRYVk85OFUrNEd6NU9xU0g3NUhmZ0VNWjJOZlAydHhHdE9M?=
 =?utf-8?B?ZGI2Q2xLRjREajFhUGRubWRvTFk1UXJHNDF3cnYrZjI5Z2Rab2hZYjZzUkRE?=
 =?utf-8?B?MklBd0toZzVwZjhvaFR5TFNJSDVjMk1DSkJUaTc0WDcwNEhTVzVLTFphZ1o4?=
 =?utf-8?B?RjlLMS9UaHlGN2FpWFlpR3d0aWh5LzZLdkc0UnVEdDNQbGpRKythQzlVaGxO?=
 =?utf-8?Q?NdTu9v+Z1gSdodBqq31WCURqK8+546Js?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXlIK01ub1h6VzM5M0VNdmFZemZLcUNtbzc3OG5IY3hlbDl6VDVmaDFLRGdS?=
 =?utf-8?B?SzdFK01tdlFaemlLY2R0OGQ3NjVYUEQ2Vmp6QVVCTFlrdFNEVU5La0Y3bGxu?=
 =?utf-8?B?UDVMME8xZlBiblRjWWxlaDY2VU1hYTZXOXFteS9jREREMmhvakJLZXIxME9T?=
 =?utf-8?B?SU85MnJwL0xCeHBLeDRQZUNCN2RrREVSZ2xMMXFwTXN2VVllb3JBQmt4ZlBt?=
 =?utf-8?B?RVNjdzNjb0c5MXg4S3V0NndHMURIL0lPYVo2YlFGWnl3SVJpRHMxRGNhS0ps?=
 =?utf-8?B?M1p3Wk9FY250NjgrNE8zMVdwZTNBQ1dkazBIMzc5T2RaQnc3U3lGZUN6b1VT?=
 =?utf-8?B?V29GdWlCOWUrMkJBVEpicHcxa2J0WkEzNHVVS1ozRkw4cUU2WGVRZWtEemxz?=
 =?utf-8?B?V201cnlFRldNQlJEMEd4MnZYdXIrZmlEQjdwRzJFcUZJS2hJY0FqSy9sdEtF?=
 =?utf-8?B?TmVkeUhQeDVyODNXcDlBVEt0aGV6K0QveXZkL0U1SVRtamhycnlGdndrZUpa?=
 =?utf-8?B?b0k4L2hDcUMyMlllSGgzV21wMjgwQWNLeWNSV1YvbERseC9qdHZId1hTcFgv?=
 =?utf-8?B?MER4a0NxeWdnQXIvc2JmYk03ZkptYVNYUGljSXdYdkNMNHY5cmlKTnk4dmhk?=
 =?utf-8?B?OCtiNVFlVjg5K1gzalJackZPZDZxVWNOT3NnZHJqVjlsR0hVQk44ZzNxbmk2?=
 =?utf-8?B?SWpDMlR5SEVFbGRnVlFwUWNWUndDbzd5WC8yWDIybmw2c1hwSjdsamp1UmVN?=
 =?utf-8?B?T3BIYTNOa29zVEpxZjQ4cHphazBKa2pzZUdLZlR5NnlCTEdDektVdUNWZjJB?=
 =?utf-8?B?M3BoRXFnU1NlNHpaS3A5U1MyVTloK2dwd3loekFXZ0JuajJrdjBhQW1LVTNF?=
 =?utf-8?B?a0FNcWMrNWJGeGlMQlVYM2kwa1IyaW53bHl5UlZ2M3RGZ2o1dFdGUXZOUEFq?=
 =?utf-8?B?QloxZGtyaEZZRXBXUFc4NktBblZzekYvd1ltTVJRRVJ6QWtjYzdBL2ZaQ1R5?=
 =?utf-8?B?c1FjdTdMbzVmOHk1VDFVRDhpbFZVOXBZeHpyYjBwZ2k3OTJTVTY0Wkd5ZSt3?=
 =?utf-8?B?WVBlYjRiYmhJZHh0VDRsckRvZXZPSzNKZC9wNlc0UlB0ZXkyZDBuelBmS0tn?=
 =?utf-8?B?WTlTOUlaSS8xYnY3a2t1N20zdGo0d2o3ZzYvVmJsUUJyVXBQdVdaZGg5NGpk?=
 =?utf-8?B?bUFlcEgxRWNsQXM0SWZPczQ5M3M1YkJaNG5ZUkhxbEQ4akhySllENmxzRUR1?=
 =?utf-8?B?dFBBVWdDM0JMbDR6NVNvcVhmSEs0dUxMbXVWcldhQ05YSXZVSU5pV1J3Y1ZW?=
 =?utf-8?B?KzhCajdxbWgyMXh5Yk5OSmQ5S0NPZjZXbkh6S3RuVzhJQjNVaGFvaWtHRnFI?=
 =?utf-8?B?R1A5aGd5blV5S0JhNklSWFJTTHNpWXRoZDRRSFpkQzRRaXNYZHV3Z0V2a3pX?=
 =?utf-8?B?VGRSY1M2N1NXNVVSOTh0YjBLZHJ0M0Q1bFJ6emN1QUo4amgzM1BIQi9TRUYr?=
 =?utf-8?B?ZkFKWi84cEdpZTZjL1pNdkVDTVE0ZW16bk4zOFA2Nnp5cllXdGViVlpVMFYw?=
 =?utf-8?B?OTNNZmh0cWxpMkZZZVJwVFV0SGlEdlhkSFByOFJxZDNTd2RKVEovZ2pNblR1?=
 =?utf-8?B?Z3N2OE1Ja2JPY2FSeWIvMFhlcVAyU05UMTRVakl2OW91eFNMVHRjMW5YSlpB?=
 =?utf-8?B?SkFGdWcySmlsUzdzZVhXOGwxT1FHUVJtNXNLcGpmaFFpZXl6U3NEUkNQOGFS?=
 =?utf-8?B?WUc5TFFmUnVIaHZqTU00am80UGhtRnAvTEZVYTdySCtjemJOYWEyekwrVU0z?=
 =?utf-8?B?MjlYM3BqbXFDU2JMWWhCdmNCQ0FqYnA1NkltdnRaakpqNDg5T3V0dHNOcmhH?=
 =?utf-8?B?Z0c5elFMSUQ1WXRiRnFEbHZSbXR2OUsvSFBVL3hLVllmOVBxaFh1L1JFajc0?=
 =?utf-8?B?VDRYYmtzMjhOZko4dlYxVEhib1h0YWZtTi9UOHo0cnpLNG1Pc2JJbkIwY0Js?=
 =?utf-8?B?VkdUckNwODdDeGlKbkk5M3lwRGpzUTJtYlVDWFhPNU9QdFlEQXNHTDd0a291?=
 =?utf-8?B?MnJTblpzNWtDNXRpNy9naklKbTVHdFhhc2hKVDV5bEZwa0JoWFQ0bEpEUjd2?=
 =?utf-8?B?NWcyYVoxaUZLSUZzUzhLNzB2ZmFiSzRzMGhZamg4alQzenc4Q2tyV1cwNmpG?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6adb70d-b91b-41e3-a2ec-08de1e418035
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 21:06:20.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJQ9NvkQTvpjbchWA3VHEsuf+sImOjBVbDnHDANvdUSfWDR4uEuMvdZvkKHN7toWF3uLjALH1dVTti5YrBfuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494

On 11/7/25 11:58, Kriish Sharma wrote:
> Should I prepare and send a patch that adds the suggested check in
> ib_nl_is_good_ip_resp() as Vlad mentioned?

From my p.o.v., feel free to send it.

Can we have syzkaller test it?

Thanks!


