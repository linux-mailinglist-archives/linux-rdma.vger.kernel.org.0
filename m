Return-Path: <linux-rdma+bounces-2215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844F8BA092
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 20:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3658FB2157A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2D17334F;
	Thu,  2 May 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwGssRVP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62D155350;
	Thu,  2 May 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674854; cv=fail; b=L/zgA0tEC69t5qb/gxME5g2muYz1vvB36pH7V/MRYfznSQFozNx7E/jF9W3iXI1Y8VcJvn/B0SUqYH4e3qRN1TpodaXQsNIJPyFwrtlllMtE6Z+s2oX3mETfojL5h1V5dxWnkj5UalRQOzoH7GJMKR30z58lnZc9q20y8ipwJDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674854; c=relaxed/simple;
	bh=T5ClOHOZhnF2xo7RbkQm04KxY0F3lj8xa4dDJgFI5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HWurCjupBX68G3kGG80wafYxAoqle9tkXqALRDAAx+qci8XTPJ1rDJ0BrEp3YSUQ1EWEoUn7xnYRGr3D1b3Z2L/PSWKukxEZ0i22L0QS+5RyyD9ODy4bu/jXk8aCInuxTK67e+TCNsxfIRMGAngHnwz4Mh/tjkwUX28YPUc5r3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwGssRVP; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVFD6aJ6qr69LOWs3+kAVouaXSLD+waakmGQlJdmtnz16xIPuVcB8g1eqva7DwNC/D2ppRUsukZnTBmQocPwdagvP24X7ad4c2nnzJqzkN1+h5HSYq9s/4X27b0+LfV3tk60VFuWX0NHz4MiAsp8xe89nVn+tmP110IAGL+Hh/w28ni2GaX4QulV7GwIbP1GZRMBJBBU1ei/27ZKUWXSQpWOFiEr/Xro3wrWPOQY988bTzZDi9KyGPUrMTtCrC1ATnK/GEN05IaWRG8Bacdu/die5a6VItn9051yrtIGbzY+x0pJhvHobqzBRC0s7YoCSuYsPjk4FWQnQv0gQAUnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bje5plHAT3rHOaIZ3liM2PEjlSo/LqDbsm1WdLY+os=;
 b=U6bW5pxEri0JypK9mpg2P3x41lOnQjuKzWgB0iglq7NAx/AF3GUSPTGKmnfPHAsnWegAXaxobF1GD6gy6hqnahmq07ug2NnHx+7v1kW+b5IAftaDXb2vPGKw2LocN7bUC6IIMhxikMYQn/HKqEUDmvspjQmdD0fKE4bTp4i0thQOuwwTMf2hi8aLwtidWFvxeRg6LR0YJvGV58UxdqQ5/tiyos+DjlOBLCArIxSz3tMZA+qEsGk3yclq2hC566melxBApyAwBGTAyRvkBPnCA/pqJOnaYxlOVePPcD/gXjpRitBUA92b6XyUVpamIyg9csLGLNui3RulxmP4N1P0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bje5plHAT3rHOaIZ3liM2PEjlSo/LqDbsm1WdLY+os=;
 b=VwGssRVPlONBvZQIL4JXXkxvbA5bsvQy6BebgMFMm3QecYB2SdPJFkwrY6cGso9hGzyrOR7uK6dBnZhC2LoU+pQd1fbEHb45Br3K2lyR1Zo1+k34nXSiDtg26sBv4VXVHVk/0PSol0iBjgcAyoFodt5VpKwnzGkzRCMlKq/LPdkvwQQjCqtjC9OrzUsVvoNsODPvp/ZMGkGuWZWPAhDbXY15ehs+8jCCmu6n9P4wz05OCzxQYHTQ2OZRjAKN1hc1vnkQA6T6Wyy309Tl4QDVvtLa5ekbgT4EBdAiZlzaoDcjJ71KRO9KAjdNnczZA1cCpPMWGr5xtPiFephA0FbCCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 18:34:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 18:34:10 +0000
Date: Thu, 2 May 2024 15:34:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Pak Markthub <pmarkthub@nvidia.com>
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Message-ID: <20240502183408.GC3341011@nvidia.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org>
 <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
 <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
 <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 334eaeee-fcaf-4429-535d-08dc6ad67531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVFFUkFnMGxYY29yeHhkaEFPUFg4YnFrTDYyS01oRXJGTFV4SzdqUjRDcVhG?=
 =?utf-8?B?TkJRU2xUT3lSM3o4cE9aN210RjVyUm84QzkzajRDd2h1ajd0Y1F3WHc2WGdk?=
 =?utf-8?B?endXOXZubEd4YTgvTGd6cmRRdWRPTDdUZTVwS2IwRHdjZWJIUlBkanVYTE1Y?=
 =?utf-8?B?bUM0UTFENDRMaVRsQXpNbVdubVZ3Sk9NSzNGUzRuTVluOWxMZmZCT0h2OE1L?=
 =?utf-8?B?MTg0Nm1oYzkybjVGM1JGb05zTTV5SExpTkdFejBMQVBMcHlyajFhTEI4Tmgz?=
 =?utf-8?B?T0ttUEZ3U1FtMm1jbUJONUVzcDk4ZmlyOUlQWjYrNGcwa0lBbytkbGVYVmg5?=
 =?utf-8?B?Wkx2VjIwLzhRRkNwLzk4WDcrSWU4Vis0dDBxbEJGSUxmYmNMTWFWS2diZFlx?=
 =?utf-8?B?SFpxRitsNnZwdVVMM2diOGFCeUNQQUZ3K0RyOWNOME5qN2FGR0tUQllvZVhh?=
 =?utf-8?B?dE1UREpPbXVnbDl5MGdVRzV1SUExbVY2bitqTG94bWdPdVBvckJyelBMdUN4?=
 =?utf-8?B?NnBzc1l5M1Z1b2pZWlQrajcvK0hURkprVVpiY2M2dFE2QUY3cDBSekVtaU9U?=
 =?utf-8?B?bjNTLy9TQVZ0L1RjbGxFdXpHZTcwY2Rkb2c5VWFGcGoreW9QZytibW1yVHVK?=
 =?utf-8?B?UkZ2Nm1oQktBR2drc3NwTXRSRVo3S3JyZWoycENZTENxZnBzWFVTOW5pTVR6?=
 =?utf-8?B?ZFZSUEl2K3BNQUVSeTRJenIyZjUyUGZrVXpzMEsyY1hpV0dNUWdHaHpqY0tW?=
 =?utf-8?B?UXpLdWxnMDhkWDZPcklBazdSTWNYVmo2M3hwdkRlbEhUTTY2MUxYTUN5ejNs?=
 =?utf-8?B?bUFJY1hVV0NtNHhqTkwwVnoybzBPNy84VDVaRFBDbnVOUU55MldsNDZiV21R?=
 =?utf-8?B?aDVmSWZnakJqbXhVTGYrMDY4YUV5OGN1WGJMWHh4UWpuMGZQbkN6dGJ1RWZh?=
 =?utf-8?B?VzArZHA0QmJnRGJMSHVKME9IKzBIRWRDYzN4bTlmcUhabEh1b1ZxeE9HQ1B5?=
 =?utf-8?B?c3NCNlVUU1hkUlZzNXZ2RFJrVkZ5VTNWTkdldU80Z2xnWkFPOFRMbG5INDBw?=
 =?utf-8?B?UFpEakdKdG5ZSVJPcTRwOXNKaFpOcElpelpGQmdZTnFxUVNUU3dsN0gvclF0?=
 =?utf-8?B?WjVPcTV5NWtKSFArL3pUSEtnOEc0bTUyZzBHUlBvcm1POUtIVlRjUDgrS0Y0?=
 =?utf-8?B?Q1UxdmFvWE5wbkJUZTdFUE0xam5zQTFmYng1aTVNMU5kU1VRR2ZiMkxxUGpB?=
 =?utf-8?B?Mm1kQzNDR2tsZDdtZVF5a3pvWXZjSVV4WGt2VEZPdzNLSERqVDJXbmFqVkVk?=
 =?utf-8?B?VmVYTWszU2RvbHZSNU0zczJuUTR1TUdhbVE0NVdNQ3BkRTFkOHRwVlFPczVr?=
 =?utf-8?B?Q3NjbVJoa0tNQlF3VEJLTWlCcGV6QjNsVDd3RFdyRkRnRnJpN1BnMEJrclJ1?=
 =?utf-8?B?VjRzWEtleDM0M0c3TGJ4VnJsRDVZV1J6ckdqWWJ5NWp3M1o1TEsyRS9kN1B2?=
 =?utf-8?B?ZDVtNDhhdmRwN2dxNDhmSWFqNHdMNTFhSHovWEk3SlpiZTJOS2RDRlZDYnpO?=
 =?utf-8?B?bXFMSXh3NndkMzZrQWVmRWlYMlN3Wld5STc2Mk9OU1RXRllnWkpEckhJNnNV?=
 =?utf-8?B?YlhsdEhFRHR2bGZTRDQvQ2pQWGhrNEFyK3EzdWZUTDV0TEpJWURWUTkzekx6?=
 =?utf-8?B?TngyUkF4Y0dnTEo1dHBQU0dEUWliaUV5Rlk4emNrZUNEY2NiOTB3VHJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHA3YjBzcHRxS3pGcmZxZUduVGE0QUt4SUV5RXJza3Y1NjVveGwxaDluMzZp?=
 =?utf-8?B?ZDk0QWx1c01Pam52MDBJVVk3Y2VYa2dJRmxJUzJ6U1IxQmdabTNqcnVzcDNa?=
 =?utf-8?B?OFdWc1hNRk1jYnlUZTYzNVBXcm5VcExPb29ZcHhDK1hjM3FianZVbFNyV25s?=
 =?utf-8?B?Y1JFaTdNSDVnM1IrdUhpK2ZJbEVwNmdWNWFNQnFBVEJEdWNhMEZYZU01SlB3?=
 =?utf-8?B?cDFONkFNV0ZKS1dvNFU1NVp5VmVDaHM5WHd0VTFRY0FhVis4T25xMDVKOGlm?=
 =?utf-8?B?NWNSeG41QzczcjRCcnhVeVlGekxkempXQWkxTDZrQnZQaWFPK3Bhd3E5U2s5?=
 =?utf-8?B?bXo5RGl1RjR3RjJLNnVueVhTTG5EUkZkc1pxd1ZJWkQ0TUFsQTN4cHJoYW1X?=
 =?utf-8?B?WlhuSnZxNDRxUlYwSXlBWGNsZnEvT0RxZEZJSmp6Y2JzSnMxajU4RWVSd09E?=
 =?utf-8?B?cWp6ZXdFM0Y2UDU1OG8rZTNsYU9GRVd5eFlKdTJrOFFpWU9GSzR4WXd3Tlpx?=
 =?utf-8?B?d0JPazJCaEVzdnNReDZDdDhiRDlOMEtCbzVudTVGcXg0ZURKS3FZTjlNbFcx?=
 =?utf-8?B?K0ZaVjNDMDhKUmRtUXh1cEdnVll1ekttWXQvZXBTRW4wNjdRWHRGRU9MR1Rk?=
 =?utf-8?B?NGJVTVM3ZEJPTlU2Q2Y3WlBzOUpvSWdlSC9HL3FwQ3dSaVl3R1dFcW5YUXJW?=
 =?utf-8?B?cloyYmJRSldnT3hTaStaSkRkM0NhQ1NtcWkrcFVGY1RKNWxIaytLbTNxYjJx?=
 =?utf-8?B?MFkvbUpYOWhyRk9MTHoxTWtlS2g2YTRCY0xKdmI2QlRjbUpML1ZzMUlVazZD?=
 =?utf-8?B?TWR1WThucTVpZnpyTW5uY3oxRlUwYzFENlQ0NW56UVRuQjBHeEVDRGpDK2V1?=
 =?utf-8?B?eXVNNkoxTlk2U2lqRnpZQ1dteEsyRXhwcEhNNDkrRU50Njh6TGlXYXAya1FS?=
 =?utf-8?B?RUJYNTlvMXRvT3F2UzFkL0lydmRuWGxrZXI5aGxvaEk4Vm4rbXUreUxsb29L?=
 =?utf-8?B?c0lQaGlCUGtja1R6WlQzdmJSZWpGVHFRUWQyaWdCUnIrNnBFcTBLTUo2WFRs?=
 =?utf-8?B?bHZpcDNUNllqaWowK2dOUUhsczdXbXh3bG5BVVpHeHFQRlkxNUxpWkxRUFRI?=
 =?utf-8?B?eTNIeDBRcnFYRWFsbjNuaVNYS2VnZThZV2gvQWdvSVlVM1RWdnNnSWdoV25S?=
 =?utf-8?B?M2lkOHQ2MDl6WC9CSjFpOFNxd1ZwWFlsVG9JVzRycWJVN0hVTnBUbFJvRy9s?=
 =?utf-8?B?REh1Y3lTMVlrUDV6V3JlVVlmRjFnZno0QloxRGZMOWVFdHdpRFlNeWdpTEFF?=
 =?utf-8?B?SmlXS2VFT0NZbm1la2tQdm9PU1MrS2tuTlNQUzkxa2txRmplR1BJSEhvVTl2?=
 =?utf-8?B?WlpkbENmQlp0VU43WmFuVXJZWE9Samg0MUQwZnM0WVhheG1QVEpUR2hwOUo5?=
 =?utf-8?B?Rm1BRzVGeVY5UWN1bFY4TmhDWEFkMVRpU2h3OUwxL3hwOEhsVkpVclRUOTJW?=
 =?utf-8?B?OVRpK3pocnBmYy9NeXg3alVEU0ZEK1ZvZnBsdU1ZalZvdlYxN2lJOXVQRFNU?=
 =?utf-8?B?bldYSnByVERvdHRQWEJUNG96ZlIvc2pSWnRtaGhXTkU1S2MyYllScmlWYW9O?=
 =?utf-8?B?NXhEeGZIK21iOS9pQkdmQzFWL0hxYkFMS3Zza3Z0V1VhY1UrVW83S2lGdzU3?=
 =?utf-8?B?M2dSQzdRblZOdjJ4cFZXRnFnaFp3MENNY2twUllLcUFJcG02Qk5GTjRmMkM5?=
 =?utf-8?B?UU1QMi9LVGFQbWpsUS96b1ZmaEp4MkU2MmxQaDNGM0g1S1VybnNMaFJvdDJq?=
 =?utf-8?B?dVIwN3Q3TDVHdTA1REpidVhzR2tRZmxFWTd4dHFabTIvc0NHUzB2SDFUbjY5?=
 =?utf-8?B?cDgzWk1jNGdBbndUMzRNd2Y1RTdrMEVVWnY0L1dHV3B5ZW1QV1BjWXVuR2h3?=
 =?utf-8?B?RnM2NkQveW9VbW9CcVM3RGFROWhhMzNxYm42S3pXWjZtV0lybUpZZ3B5aWJ0?=
 =?utf-8?B?SUFKYnQ4aEx1MkgzRjM3dVc0N0lmdXA0Vk9OQmc3ZlVod3Q4MDBnd3FleWkz?=
 =?utf-8?B?cDJERWdJZHd5U0xZQUEvd1dWR1E5RVBjSExxRVQ2cEJpY2tjWTNxTVRuY3FK?=
 =?utf-8?Q?vv3e3ybi354yKFa/s7lOR9gZo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334eaeee-fcaf-4429-535d-08dc6ad67531
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:34:10.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLgVHIuqE0r2hSsaudxF3m1CNxEi4e8H5SPJLCvFbAcKUlFBAevRfYXw2EpQs0ke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091

On Thu, May 02, 2024 at 11:10:05AM -0700, John Hubbard wrote:
> On 5/1/24 11:56 PM, David Hildenbrand wrote:
> > On 02.05.24 03:05, Alistair Popple wrote:
> > > Jason Gunthorpe <jgg@nvidia.com> writes:
> ...
> > > > > This doesn't make sense.  IFF a blind retry is all that is needed it
> > > > > should be done in the core functionality.  I fear it's not that easy,
> > > > > though.
> > > > 
> > > > +1
> > > > 
> > > > This migration retry weirdness is a GUP issue, it needs to be solved
> > > > in the mm not exposed to every pin_user_pages caller.
> > > > 
> > > > If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
> > > > then it is pretty broken..
> > > 
> > > I wonder if we should remove the arbitrary retry limit in
> > > migrate_pages() entirely for ZONE_MOVEABLE pages and just loop until
> > > they migrate? By definition there should only be transient references on
> > > these pages so why do we need to limit the number of retries in the
> > > first place?
> > 
> > There are some weird things that still needs fixing: vmsplice() is the
> > example that doesn't use FOLL_LONGTERM.
> > 
> 
> Hi David!
> 
> Do you have any other call sites in mind? It sounds like one way forward
> is to fix each call site...
> 
> This is an unhappy story right now: the pin_user_pages*() APIs are
> significantly worse than before the "migrate pages away automatically"
> upgrade, from a user point of view. Because now, the APIs fail
> intermittently for callers who follow the rules--because
> pin_user_pages() is not fully working yet, basically.
>
> Other ideas, large or small, about how to approach a fix?

IMHO pin_user_pages() should sleep and spin in an interruptable sleep
until we get all the migrations done. Not sure how hard it would be to
add some kind of proper waiting event sleep?

If userspace has got itself into knots then pin_user_pages() will
block in the kernel and ctrl-c will rescue it.

Even the temporary pins for something like O_DIRECT are long enough
that we wouldn't want to just spin the CPU.

Jason

