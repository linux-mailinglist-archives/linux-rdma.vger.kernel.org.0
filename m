Return-Path: <linux-rdma+bounces-3655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE203927E50
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B421C22D74
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CC13C69C;
	Thu,  4 Jul 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="Uloeq2k1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5613791C;
	Thu,  4 Jul 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720125793; cv=fail; b=jU0TU1yAeAb3AHJetVF6Bn3k/0zi+SFeUt4UXkRyeB+zXat73XHFCqpahHmx21uDMFH80YxUkzPPrReJIQ75j0raSVQxRnEEnfrNV6SAAmcwo7SKs00JrbUF5RX2lf6ytlZWfczSEg3eMmYh1wC3xolHCqUsaoj3ezmcP1mtLdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720125793; c=relaxed/simple;
	bh=a+PHhePP9C97fe3zvR6UG2cgk6ePSfGxRFFQUx4y5fQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tOimakSvUFqaoSDYBMwpwjhZ7WJegX8MJuvtGan2RLvceAexhA1z9osIY7jsxSSBpbe5a3w3gTu0wWTuJEOA8LlrD8brT74fqXn5633kYHuyouDjZKjA5uacHlkfTz7YN4QSi/KqQ1HJtaO+mpvMLoSpw8xCrjgQRo8bB8pbZGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=Uloeq2k1; arc=fail smtp.client-ip=40.107.237.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1FMt/85cETLs1RKeqhB3OM9ZXirSbyjLnlxouQbM+GukMMi2ixtIYQBqA7tIUG6UUqiKdXJDnqRSccLw+9+nsgk+iV2Bwf1Tj9U4FNmnPnQaXKcqaIObQq/DYnklHFXu0524QITCzBKkh61G1vMS0piY77e7VEROvpoADVkPgWsm7uxJirSbUxifLT8o7VPRcRZz/F5JYxBbG2PHyvPR1LsZAOwN9FBAEZ+phc1cHvmAknuf9fKOVkBOXaIcX75a4XonlzFciEH0NWgjJ7E/6zbK68eNBEQrKdDmgL8I6U+b9+cQJKptQ0TIfevQItfC2xrH+FLTX9hX1gO9UbNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaZLiTDavsOEgJv00Pn3mvhKNTCdC403OyEP4fZxg6s=;
 b=nKLBF4MjhGvMncNyccpC4mlHjcLoZG+8fv+qACcjyP0ynVYWfKlFmMbCoM6kC9HnEgN0VeQd8IzyAm5j0flJcim1GlSoIq/ZXd2GI3ppQGnp0/PGbGM0f3IwzGyP8OJnXiV2okXZsNeoVaw0ffjpkg0byqX5jzqtSfN/8pQ0A3SiOB0eEl19tbGW1tusKknKofKaCzFaSIDtXlBFe0lGNlS7gU850VFApBg6OAxiYn1+d8tb1cT5jHvyFLHl7toL5CnTeyTOJ9JVuSWEud0TLpRunMSTPnTaPXo1Tv5HURR7SDD6lk4xSgGt9XbklHwMqTKGUXxpDjyo5+rDQSYLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaZLiTDavsOEgJv00Pn3mvhKNTCdC403OyEP4fZxg6s=;
 b=Uloeq2k1PsBuMWCl+kAy3esDtqRDBwDWwfawqaI1yZx9GXuw3DvXRr99M2PS5Qe7S5t9fz22zQaUcDUZzRFI4J1k8m0nseiyc6E1znxONywz8+SeXasix/rUZFgQT+jv8kClKR6F7YiAKz7s/VPh/Ayt7Xda3ktTudc4oN3LuHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by SA3PR19MB7544.namprd19.prod.outlook.com (2603:10b6:806:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Thu, 4 Jul
 2024 20:43:07 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%5]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 20:43:07 +0000
Message-ID: <310071c8-04b7-4996-a496-614c2bdb8163@eideticom.com>
Date: Thu, 4 Jul 2024 14:43:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rdma@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Artemy Kovalyov <artemyko@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>, Tejun Heo <tj@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 David Sloan <david.sloan@eideticom.com>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
 <20240704163724.2462161-2-martin.oliveira@eideticom.com>
 <ZobVol_trCwtwjK4@casper.infradead.org>
Content-Language: en-US
From: Martin Oliveira <martin.oliveira@eideticom.com>
In-Reply-To: <ZobVol_trCwtwjK4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::9) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|SA3PR19MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f516178-41f9-4173-b7af-08dc9c69e8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3dHSWM5K2hyQWQzemFiNUF3RWQ1aG9DZDBOWnZMbTQxQjllK05HVW83ZmNU?=
 =?utf-8?B?Q2lNNDNnTlVoRFlIZzR1aEl6NzBKenNZMk5qQzc2cys3U2Q3d0kzb2k4bk9Z?=
 =?utf-8?B?M3dvdzE4alBkMGgvZVRVRmtqcVY4TERWMHJJeS9CNHRyWjYydmhKVnlibmM3?=
 =?utf-8?B?RmN1aTFEMWtJSlRSTXJ5V29sRWQxR3paak1VNmE1ZUwzSmJLRlA5QVhIaFFI?=
 =?utf-8?B?MnNUZHFmZ3pkZXhqaTdiQnc0dFh0aTkzZDR4NkJVS0RyY2hPNDdqeUxJWVc0?=
 =?utf-8?B?eFhCYlBSSm0vUTFQZ1c1a05Hc2M1NGI3bzhmQjRTMVFhRTloaSt4dm04blc5?=
 =?utf-8?B?Tit6UXhsLzJzOWxJZDBiRWtZM0NLOXlTT0pRME5nclIvNkpkWkRGNDFxenlX?=
 =?utf-8?B?bGhrNVBWNkZMNmdJRWl2NGZzcUtJRUQ1RXVJellYeEczT0VSWGtRUW5laTBH?=
 =?utf-8?B?eTEyYVZzNGFpRlFvNEh1emVyWlhqVi8zam85UHE3Q1RyT0pZM1hCa3lNK20z?=
 =?utf-8?B?d2hDYmZWQ2d0Mk00OXBMWjl4Z3U0QmFJbG5kdURRaGFlR0FtQ01tLzRYeHF4?=
 =?utf-8?B?NEpidXZtT3N5WjlTbXZtUXViVVhFdW1rWmJpNzlFYTBaVFFxcWhGeFd0Wkkw?=
 =?utf-8?B?amhtMTZ1Snp4TUdTZTBzZlYzcGFBUGpPQ2dZNGdubUxLVnFhRFdIRU5RSkV0?=
 =?utf-8?B?MmdCMTUzVkI2UC9ob0R2UkRpaFZTNzlacWRtaHl2VURpR2NBb2E2ZXBMTXhK?=
 =?utf-8?B?VmhFU0g2Z2xCRjM2dk1hM2xHa01TdEQ1ZlZYamp1RGlYNk01SlBWNVFsa3Na?=
 =?utf-8?B?QTB4bVQzZ1ZNKy9BNVJYZGoyblRJTzBNZEpIdGRIbllJSVRpRHhIeElvWjZq?=
 =?utf-8?B?SDNqSWsyc1RjN1o2VmZwaVlkdzl6Z3k1RHlSMmN0d095ZkpsTWJXMWxpdlg1?=
 =?utf-8?B?Z0dlRFB3aUJhRDR6eGZXUnBzQUhIU1R5M2M2dUpmczdtcnVzTHo2eXlwQnVN?=
 =?utf-8?B?RG9TSFhYajh3YzR3WXpuYUQ1TnI4NGwwczJ2Ni9NM1c3VWxELzNmZXpJWjZ2?=
 =?utf-8?B?WXZCS3g0SGZWU2F2T1RzWG5WQW5MQXZrdzB2cURxRElRQ1lucHllTkt1NW5o?=
 =?utf-8?B?cit1WmJibVYrVkd4SVNvQmc3QVl3SDhYYW5kaVBxUThRMC9CN2c0Q0VUdHdY?=
 =?utf-8?B?SURmbHNqa213c2xzMEluWGprNk9FUTVKeG9HdnBESEpzUEc1VVZKMldPS1E4?=
 =?utf-8?B?NzRiNTEwMUgxcEs4dFRQcFRzNUp3TnJ5ZnRSS043VytkbDBMNVJqTkFSclh3?=
 =?utf-8?B?S2VlbTQ0RElHbDFGV1NHTzdyUnJxQnNORVNtVWJlMHNrK3oveE9FV29rcGdK?=
 =?utf-8?B?SmNYWnlUdi95WmxCVFk2cTNBdlRTTmlmbWJ0aUR1c0xETXR5bFNWdStWZzJW?=
 =?utf-8?B?bEtNZkZMS0NkWWd4T1hPRG1ESkNQaVY5clBqbGkrRlRHcUpZczJwT3Qvbi9m?=
 =?utf-8?B?S2dRWmIrN2RiaFlaVE5TTFpFQjd1ZHk2aHp6Lysyc1k4N3MvZDBsU1YwdldM?=
 =?utf-8?B?djlXUUVadjB4dld3MFZOUEc0MmNKYWZxRWNPYmJHeFpsZy9aOUY1akFGc21n?=
 =?utf-8?B?UmdscmZJS2lwUjJDalB6U1RlMTVqTVo3ZUNoWWZsSlNUSmcrV3c5QWZVY0ZK?=
 =?utf-8?B?Y2oyUXA0SUhBS3lZc2ViN0NOZ0VXNk9DVkNZeU1TRXhzbDU4T1NqMXhJYWxX?=
 =?utf-8?B?YTVDamFaV0tsZnVrby9sWUE2WVBGbytiM1JCbHA2aGt0cmY0aHRXOS9qUlJr?=
 =?utf-8?B?d3ZNbW9BajBvS1Z5TDRHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alFmUjA1NklWSnJBblBIVGRyeUtCcGpKU0dVZWJzNHg3U3lBK0FHQzFFc1JU?=
 =?utf-8?B?MDRldmFwQlBOclhsa3o4SERIVWRzUGsraWRFUzcyRlgzdThtV0UzbHN5c0gz?=
 =?utf-8?B?RGJWSHc3c2dmNm5tU21pMjIwcnQ5Q0E4Z0hXOEZjZUtvUmRxa3lpbCtaQ2U1?=
 =?utf-8?B?NUhmTGtldmZWRzhpcUhiTFpQalk4RFpWL2JZRGpaRHlycDdMeDQzT3BFeUxt?=
 =?utf-8?B?WlhDNWJweVZhbW9RVXRZT0hsbldTWUFrZjl5SG4wOTkza1R2UFZGSWcreTJv?=
 =?utf-8?B?WWdtY0ZuWUlIMk85NTR5OWpBelUwYUd5RHVNcHVsdDkwdkltTzJYUGxFUVNN?=
 =?utf-8?B?cllYTHBva0pJRFIwMTlianQyNGowMkhMd1pNWGVub24wUHY5aFAvT29yNzNl?=
 =?utf-8?B?ei9BdVFIQnVBYnNzTEhwbG9KNThZYjRyUDM4UXlKOCtoZFlnNUUydFpiZEhV?=
 =?utf-8?B?NXBSZ01tTzBtdmJWS25hczZMTWcyZGhiaTlxRW9PTTdQMEpRaTMxTnJVVzRF?=
 =?utf-8?B?K3ZSMnRoRHNzZDgrSHgwR0FsMjlyYlIrbldVL01xQk1jZlNzQmdYbHEwU2d2?=
 =?utf-8?B?OVc3TzNTZGkwbzExL2w2c2FtTjZQV2FsQ1BvWVNMSnZOV0tSd2dHdjZJUWtL?=
 =?utf-8?B?UzJwTjduQ1gvQ0VTM0VlWDVhNU1nZ0lPRXVaTE12bGJXL0dDV1VIdjAyWlhL?=
 =?utf-8?B?clhOaEJtRzRlbDdaU3IyQnNkcmw5M1VhWTRTQ0xnZlBZUjIvOVBYN0FWM1Vi?=
 =?utf-8?B?cUhUbUc2Rkx0Nm1wd2pTSHdDdFBxK2ZvbEU0cm4rOW9PaW9LS1FiajZPUEdP?=
 =?utf-8?B?bHZ2TlJyTUdqSFlQYllueCt4UFBBV2ljZm11Z0xRdHZsRFJUYWhaNyt3T1Z3?=
 =?utf-8?B?a0NXSGs5SHdJeHVYM3RTamlpdUlRR24vVDcwMmdlb3kydmlNRUxESlREbE4r?=
 =?utf-8?B?dDc5R0hqQ2VmTlBUTGU0VGZpNEI0Mk5BZGVKbzdKNlZzeUJTOXdyTzJCamVD?=
 =?utf-8?B?cXBzTThvVE1ZRHAxZlRrUUlyeWwxRlhyS3V6QkFraUxFOVdKYXdyYktxazNu?=
 =?utf-8?B?VUpCVktiYVZiRGh0c3FKc1J5b1ZQaUE0MytTdUQzckZjc1ZlT3ZPLzFjUjdK?=
 =?utf-8?B?NWhZU2UrSmZ4Nk9xS3dxb2tLY1VzdHkrR0ZXQlF5RWg1WEo1aEM1UlJOZk03?=
 =?utf-8?B?STdLTk16U3Zob3BFai9qa1JqL0l1cEIzWktHYVZsaEo0QllmK25hYjhtZnRW?=
 =?utf-8?B?OWZUN25TTm43di8rTkZDNXRNSmZMTDZVOUxCNGtncWNsSVRGOXJMcitaU1Vr?=
 =?utf-8?B?VWNvWWhheEtjZUhBOXNpZUNRc1FhUVE2QkcwaXl2ME5wblJsV1JJYy9GQnY3?=
 =?utf-8?B?UkcySXdxNStaZGtNbjFNdUYyTk9YMGtDUzJmRUFoY3QrRVF6K2RaMmVLcGI5?=
 =?utf-8?B?S1VFUFQ3Z2hmWEE2d0g4Sjd1cG5EekxqelR2RkFzMENOVzNhMGExT1cyUmJD?=
 =?utf-8?B?aXlEclZldTVybUtwRlpVS1lBM0dRSW1xM2NJVHN0U2tYa0YvUHg0WW5HVEF6?=
 =?utf-8?B?SXBkQ1FoYU93SkxrVkk2cEtWQjh0RTlDREF4TzFxMnFSb29YcDFsNHJ2R1lC?=
 =?utf-8?B?MFRnNUwyZHhiUU5uTDNZQUwzK2FoUnQrbGlBKytMUlMzTkQ2K3l0RHRDTmdX?=
 =?utf-8?B?alhkc2FCL2hSUlNkdE43TElMTnRjQlFkMTNvUGJhTkVOL1lqeE9iZXV2VEhZ?=
 =?utf-8?B?MUFRaWFpaGtKeHF4MHF2aXM2cldhSDZKQThySUxyU1dIaHR4cmRWdWFtc3NJ?=
 =?utf-8?B?RkV0SjhrV1JxYjV5UmVzOXAzVlZ0QWRoUURIMkJ3Ylg4QjNHTXNhVXRqTHFz?=
 =?utf-8?B?eVQ3SEJLeTIrWXN0eTgvQ1RLeU13eGxGVDE5d1JRK04wUU1ocG1IMmRSc013?=
 =?utf-8?B?VGVOZGFOK0swMGl4dU9ZRVhjZkNVZHBrTjAvNjhSWnd2bFdEbWpzS2kwNG9F?=
 =?utf-8?B?QzNyYkovQlhrWGJXd1hmS0Rtdk9DUTRGeUt2KzIxU2orMTQzWHVTemNSeEFm?=
 =?utf-8?B?S05vd2o1K2tRMkVqQTltVTBLV3JSUXZIL3lRSXRXT0l4Szg0TXIydVNQSHda?=
 =?utf-8?B?alIrLzVjRjdwNExQYWN0NmdJSEhSWGxXciswM3ZMVXp1d2NORmVHLzgydjBR?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f516178-41f9-4173-b7af-08dc9c69e8fa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 20:43:07.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8zpcorvBR10iHV2DBGzpo6YmZIKWrWpt43qhtGunQcqHv78P93+SmNh7Rm8g37mGe1lXHh/FSgeCCoReRqtIrM/hHpqkJO9phNJmUM4DM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7544

On 2024-07-04 11:02, Matthew Wilcox wrote:> Seems to me we should actually _handle_ that, not do something wrong.
> eg:
> 
>         if (vma->vm_ops) {
>                 if (vma->vm_ops->close)
>                         goto out_put;
>                 if (WARN_ON(vma->vm_ops->page_mkwrite))
>                         goto out_put;
>         }

Good point.

> or maybe this doesn't need to be a WARN at all?  After all, there
> isn't one for having a ->close method, so why is page_mkwrite special?

Hmm yeah, they should probably be treated the same.

Maybe ->close should be converted to WARN as well? It would be easier to
catch an error this way than chasing the EINVAL, but I'm OK either way.

Thanks,
Martin

