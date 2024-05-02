Return-Path: <linux-rdma+bounces-2214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D38BA009
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0FC1C21D69
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA7171E66;
	Thu,  2 May 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVslog0L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6E154457;
	Thu,  2 May 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673414; cv=fail; b=Ot7mFjj0uhSqsUtidSKvPmMu7yDSSYM+yXaVlbO143rpL8XkJb15dkl0Ef1AKwe75PbLt2xvPCu8XHkFZhPG99vHfU8wN0cW4bPSxsd00P8IbAIxTxIQAOYprd+qKgn7Z8BHi6vuQbpeo6aWnzf87MdSXhVwWq/78xHn+ZS6bWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673414; c=relaxed/simple;
	bh=5QtRTQ0scGxqEhIO+PSdmZrQAFwzwPsLP1B4Yjkz07I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NxyPwV5e4zkFI+VRpEKhNdftmy9782JaT/s+cO1QTV76Iw6qqpzTowPHOgHMgyAyujOGyIWRQQzpl7Yt6PunaRoMTHCqC+sh5hVB4EdXNa05rSFjaOR0btebMBNZyXR0TDaQ6O6KoAQ9WBnDkcnGDUjt8uVB6z1o1T47mgb9xnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVslog0L; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5Jlvd16ATVE2IogmpWovKZyy+LDk8cyLOi3ZmxUN4BrRRkYtzefUXusO00Ac/Qo9nRhhAg7isnR00qK5RTXOir/DXRz4kDE2YTnitbt9y3Y/W6AoWD2RkO/YKwuyqPnIEDtOYPSAExgp/q/F+Kng/PXtBttxZLFcj4Aa7s/6oEUrDrL6PjRu5MKAGg2vHxyaVXJ/6AVdwlVguXyRmwKDOaDmRAUGbW7x61FBRHRy/BS+JCGvWnXg/qgcx66w7+7WpwpAVuXgkiB0KSSE+yFwe0VFD9kzS9D0IVdzIoeCOkw7rlviZKIGNXmZiz775Fej48FZpT8txWmBec7tdkM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eirA0iNMGhwyVtxUETrgNyLgDZDhEPGp2ccY/n9rFg=;
 b=EOFGqTD+Ol00qKLgID664nGzOIoFeuZlexcq41+SGPIlNdgaXzNWbAX1eGqANyFyYOQnvRrjeUhH0KJ8sGIcdM5uGWrvv1JpBaEwO/fiXfbp6c1f120W6k4LUzmxr9rLQReG70WX/Q2DOMgxkQhlxfqT0iTzLlwjqVvtfaDxol+6eYNeIaTXBjPhMg1CtmCWLkmsGhsDwVn0J8JsRkPu8mYXFYJrdPbPO+aoADH65xSRo5Wxq9RzGglHvZfyqw36W1PLkx+UDgjyT4e6GF9iLDAXB0QzXXmp/ARydOq4MR3TA3ebsoK4oXTQfAOHBeKVwZ9849S8b9le6WSakXfxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eirA0iNMGhwyVtxUETrgNyLgDZDhEPGp2ccY/n9rFg=;
 b=CVslog0LXMPi3Wgvk5m3Ebz23xeqCaWBBq7EovhytRDd+JOTNDUdUxgBipTryU2ziwAGGJa/9Z5mGFk2E7fQKoo8pzemy8nv9zUpDF582ixylCPX3TsKF9TAFG61v/GdWhXad/XjrHsSBrfcuAdFA56kxw+Zt44pX3Fs380dsBDesLdLwWySEdRl7NRrTsANsRHfNouISigm3zkiiEnUOO1iSkWVyV4T5f7Tf7yp98kf5F4Im5ZwvOTsj4zV+QvquPrXIp34ig73lHkqzm/ry44/7QzCzbfv2fjkQ+mcexjbjb5K//pGJYQS/jCHovEnvUeuwivrZ/tPjVPWf2D3Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 18:10:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 18:10:08 +0000
Message-ID: <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
Date: Thu, 2 May 2024 11:10:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
To: David Hildenbrand <david@redhat.com>, Alistair Popple
 <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Pak Markthub <pmarkthub@nvidia.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
 <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf5450e-62a5-4206-1ac9-08dc6ad319e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZiVFBpTytRY3dYUnVzVjVkSk9RUE43cHVBQVcyRUowODk5czRGRERacXVH?=
 =?utf-8?B?b2ZJUHhVMy9Yd3JOYVJiTUNvSllvY3htckxObnNFR1VRTU5EUWpCdW5BdlVx?=
 =?utf-8?B?dC9PajZjTWQ4Q3NiM0ZTbnJqQ0VGRzYxdXVhdkI5cy8razdKOUQwS1pYOTNU?=
 =?utf-8?B?RjFSYkdDQkR3SVZqK1V0QlFTbWVBam16cEF0MGNZUm5ob2hSbVQ2c3FTMmVD?=
 =?utf-8?B?VWp4SmJrS2VjV1ZiaGsvSlRjQXcxalN5N0xRbFpGVG45SWZJcUMxaFVlaVQ1?=
 =?utf-8?B?YWo5eTZZY0Jsa1RvZm1XT3g1c3k1ZE9pM2xmNDlmaElXcjlKM0pITHlvdDdI?=
 =?utf-8?B?L2VjRnBKSkRnYTFUQWM2WDA4WXRReEVpMk9JY25pTkRObnlYVmQ0OG1LWjdD?=
 =?utf-8?B?dHMxU1Fuc29TT3RkTGNxWkptRERjeWVUeFJPRGdNRFlPZnBEWG1IQUZ3OVp3?=
 =?utf-8?B?TWhBdFE2emRCOHM2cWdpaTdSdWdKOW9XQndiVDFITmZZQXR5UkFvV0RzTkJC?=
 =?utf-8?B?WFhyZFdNWHlYQ2JqUkJCLytWbDV1eXhBb2J0RjZwaHNRY0VzV3VoR3VWUElX?=
 =?utf-8?B?Y2o1UUM4cFgxZWNwbUtPRWZ6R2pTMGp2VVhQeU9yd205cm0xN2doM2dPeS9F?=
 =?utf-8?B?K0ZRWTFPNEhFVytKblJYZC9tdVpadzY1VzNsekc0Z2tDWTFTc0M5cGJiTzh2?=
 =?utf-8?B?aXpMOVlIb2w2SlpYQ0swV3VMVjVvcHlZOS9RL280eFVtUTNqN2ZuZGpvN2Z6?=
 =?utf-8?B?bjBUUk9oNDZGbEt2azhLTDJ1Rll4TGRoUkx3MzdCeEtBbDdZdFFhUmFnYXVt?=
 =?utf-8?B?YytKSWhSVmpIZVVBRmJ6RzA1YUxYM3BMQ0ZwaC9xUis1OWRUZ3ZoL0hCV2My?=
 =?utf-8?B?VHBoRk10azZvdmVPcWl3T0JPd0Y3cUdWZkUxZEIzZEdyRU1QZnpyWnR5NGJK?=
 =?utf-8?B?Q1dDTThpY3haNCtJRjJMcFNib3cvcHN1QjRSVzlSNVV3ZWtLQXI5NkxsVG4x?=
 =?utf-8?B?OXhlSmVzSHl2VWRPRytzSXpDNHBoVEFrUXNzZWdMYjhseThnZGJhdEgzQno0?=
 =?utf-8?B?U3l5YjNSczhKYVBheHN3azJTVU9uaWEwRk16QUY5SCt6aG92QVAwK2pJNG1E?=
 =?utf-8?B?REo3YmRWMXBWQk9hU1hLRXVWVWRjYm43MWlUR1hYbXBiVW9KdHpkUXRaaU1K?=
 =?utf-8?B?OGpGRFB3UkJCSitvSDVSSmlEZEZrU0dZYkJHRVA5MHZqelNzYWsxbHJNZDhW?=
 =?utf-8?B?OFhVNFRLcUxnWE1tS3VqMTRMRkZldmtibVNyZGZncGRSbHpXMzdQN1prSEhz?=
 =?utf-8?B?RTFqdHVzbjU3M2k5MngveXFVaXZncEliRnhzTTl6YkxSRm5wWWtxME1OQW1G?=
 =?utf-8?B?d0VMS25yLzdxcS9nSDhMc0lpUkIyb0lmdUZpZXB2a1lMRkNoQTV4bGxxeWNa?=
 =?utf-8?B?eTdPajdWWVZRckpuZFVJK044U0o1T1dEYUVieGIvYStaMDVmZ1FOazhPWEQr?=
 =?utf-8?B?ZzFMeXhmV1A0VGQ2eDFtRGdPUXMrUHFLNlh4a29hQmg3Mnczd0pmY2RZQUJF?=
 =?utf-8?B?MER2OER4QnFQVzVEUFNwWEM4a0pjQkg4MmRtdDlucHMwT3RST0tPTVFVSXlW?=
 =?utf-8?B?T0oyc01OMTE0WXZnamx0SVNoUGNUMjZJcG14U3ZobmNLQkZ4TnVHM3VNaEMy?=
 =?utf-8?B?WUpoZnlML25aaEdpU2JpZVJvUHpCT0lOWHNFK2lnLzhtZzRyM01JNE9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3ZmL1ExQk5NWXpVMFpGWXFYWkZoZE8wMTRWZDhmNW0wMEtBUU16L2x6QTRu?=
 =?utf-8?B?VVQrZVhxMGorQldHYi82dlBWY1Nwc0prZE1peVFETlpJazl5QUQxUzZzajZS?=
 =?utf-8?B?QkhwcDVWVHJjcmdMenhlSVVwYjloSjJpdWsxeXRvRTJjTVZob1dlYUFCcTRE?=
 =?utf-8?B?RUdyTzZiVzY0enRpZmVMZ2FDMXY5MEs2NVZTVW1GdzZaU2xJSzVkN1ZJNThP?=
 =?utf-8?B?OWtjVDhLTVVWTDU5ak5CdXNQVnVTbm5LY3BNa2hOQ1lob2FUQ2R3bjg1MitS?=
 =?utf-8?B?bG5HaU9wL0JoSGl6ejZqQ1FnUVJmMWh2SDh4ZU1TTHpRd2dTb25UT1hCTGxD?=
 =?utf-8?B?TDBCb0tZQ0w4MUszVFNvSGU1eGc0Q3FXcy9EdzhITDRsQnJKa3ZWY2pZVkFv?=
 =?utf-8?B?MU5CanB0NFdON3hta0tTRStqdXcxUTczeDdEcmp4M0l4UjlRV1dkTGl5TS9D?=
 =?utf-8?B?ekd2UWdKMWx5WHVmbFhzQXZVd05ONDVHNStjUW1kTzRoSXVqZ1FLUG1xWW41?=
 =?utf-8?B?MEliN25oNU9qRXhwK0dUVHpEcklFZDRSUGVHeGNnWm0zWng1SnQ3d1NRNFMx?=
 =?utf-8?B?UXJlZGJ1cXRqYjJXWTRocHBXbW02Y0E5Yy92NTRtUXZKWWUxU3BsYk9RVWhT?=
 =?utf-8?B?b3hpbFlkd0V5Y3lNTUIwRjM2aXZXVDRiczdNeUJab0RnOWZFcGgrVjNpdktC?=
 =?utf-8?B?bGZQRXlwMkU5SjRRcFc4cnBEcEo4Q3RucnN4N2xETy81WEJvbmZmK1N1VUVu?=
 =?utf-8?B?L0E1M0F3ZFFsK0NZRmp5YitqaWhKKzBLUTFhTUpnb3BpaXFiVVJabVpHK3Rl?=
 =?utf-8?B?M2svYy9rck1BcURsWHNycnlLTmN3NmREQ29USmZYKzdMM2Y3U2ZjSm5nK2N6?=
 =?utf-8?B?Z3Uxb2ZQWFh2akcyelpmMGpWeUx3cDVrdnkwT1RRQ1Y1MGsxV0I0d3FITlUx?=
 =?utf-8?B?S1ZYckxuSEVpVGVuRjhaejBUSlluUUh1WGFYeXg2UUp0MkJLc1kyc2NzRWFs?=
 =?utf-8?B?bWpHSE91bzBVTzh5SCtLREc0NDBaYzBVaUI4Z3ZuVEQzUVk5VUo2VDV1eFhZ?=
 =?utf-8?B?cE8vNFdQbUcvZmkrR0VrT1F0K1dqelJyOG93MXhEdy8zZC93bjl4ZzE5bGFO?=
 =?utf-8?B?RDMxaGdnZzlUOFJXVy82UEdDUm9sUWRBZVR2OVduOWRKOWpkKzFMZWpoSmhr?=
 =?utf-8?B?TVc4Y3hpMzJmdXRJa1A4dWgvMHNkeDdWaldLcVVGZ2VxR0NKQnk0QS8xMThj?=
 =?utf-8?B?UlNQWDl4cnBCajd5TG1sbW5DVFhIeVorRjNsbXIrT3c4dnNxRitpYUpvMUpI?=
 =?utf-8?B?Nzc3Y2VrdEpvYmlMaU9wUmdDN2ZPdWZBLzRkSk1YYWpmYTcrQytQMzJ0Lzlp?=
 =?utf-8?B?a3dXL0N5YUtieThZVmpIbnptUzZpb25JRG5vbCt4ZUV1YXFJaEhyMExLdERW?=
 =?utf-8?B?VnZZM0dyQTIzWWx3Wmd4YzV5SGJtUnF2Y3pZYWVQYWpNTU5KMm1IY1BHTjBv?=
 =?utf-8?B?Z29Wa09vMFpoTy9uOE5UZGt3eksycENHcmJTYnBwODV6TFVJU2g5K3hBWFBs?=
 =?utf-8?B?UmVZUDJESjB3bThNYkVjU3A5aFpRU2g3a1lZK1M3U1VhSWFoaE5OcnI1OU04?=
 =?utf-8?B?WWdEOXFZSjg2NDFzclhxaStpMjZuZ0RpdnlQQWlSSzA1MlBHVFJWQTcyMFhz?=
 =?utf-8?B?UllwTkFoaXJaZ3dEeTNmS2ZKN2RwUk1LRFczYVh5UXRCcExCZ2xEdC8vZEQr?=
 =?utf-8?B?WVRZbmlNTUM0cGpmNWIwT1RGaVRSYkxCZk1sNkNkdEJUTDZRcUlPQUFDbWtH?=
 =?utf-8?B?TDVIanJScUpWblozUmd6MXl1ek9lam8rWXRHQ2hBOFNZSFpWQUhjaUFzUUY1?=
 =?utf-8?B?c1hCWllTT2F0ajAyY2lWeFBTNXV1ZXp3RUN3aFdoYXN6SW5CcFQ2Sks0SWJ6?=
 =?utf-8?B?SEdTL1pYd09FaXdpWC9LVnJNV1A2SFFEbS8raVBESWRyRmpWRjhnUUd5RHg4?=
 =?utf-8?B?aEErUnlmckFZayt1dFk4SFJySURvZzRyUE9ISFczTGhETHBIQUtja2w2L2oz?=
 =?utf-8?B?eDhtVnY5VHUyZlZ6SUtoWE5ER1R1U1BQSmVCL3U0a2wrOW1yN3FIZnhCOG9R?=
 =?utf-8?Q?JANIjSs7Ga/49AWOOzx5UHmx9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf5450e-62a5-4206-1ac9-08dc6ad319e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:10:08.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIIMVVrHEzq/04dW4qVcDsCI8yTmkoIwbB/6LnmX7TUIm82TvfHHw73cP4fCkbI7pUdlg5tG69qabDnhClDLcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 5/1/24 11:56 PM, David Hildenbrand wrote:
> On 02.05.24 03:05, Alistair Popple wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
...
>>>> This doesn't make sense.  IFF a blind retry is all that is needed it
>>>> should be done in the core functionality.  I fear it's not that easy,
>>>> though.
>>>
>>> +1
>>>
>>> This migration retry weirdness is a GUP issue, it needs to be solved
>>> in the mm not exposed to every pin_user_pages caller.
>>>
>>> If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
>>> then it is pretty broken..
>>
>> I wonder if we should remove the arbitrary retry limit in
>> migrate_pages() entirely for ZONE_MOVEABLE pages and just loop until
>> they migrate? By definition there should only be transient references on
>> these pages so why do we need to limit the number of retries in the
>> first place?
> 
> There are some weird things that still needs fixing: vmsplice() is the 
> example that doesn't use FOLL_LONGTERM.
> 

Hi David!

Do you have any other call sites in mind? It sounds like one way forward
is to fix each call site...

This is an unhappy story right now: the pin_user_pages*() APIs are
significantly worse than before the "migrate pages away automatically"
upgrade, from a user point of view. Because now, the APIs fail
intermittently for callers who follow the rules--because
pin_user_pages() is not fully working yet, basically.

Other ideas, large or small, about how to approach a fix?

thanks,

-- 
John Hubbard
NVIDIA

