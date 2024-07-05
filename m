Return-Path: <linux-rdma+bounces-3661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AF928213
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 08:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EBF2867DD
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 06:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705F143754;
	Fri,  5 Jul 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEQrHi4D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617413C8FB;
	Fri,  5 Jul 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160896; cv=fail; b=jj3pklDo+Q3+GZkWBgmq7rlmQpzYJ+3ovOx00ylTl+uW6ZIcRnYb4d7QCNqFhDbZSoBS48U6rBgodOtqULGv8NdIhFYhFSP9Qxq4wKit5X/urUpvDZAKhzW5IzyZLWg7N6uthZgSlYAA3tJqIHeF2X2TpJlMy69QgZXx3lWtKCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160896; c=relaxed/simple;
	bh=gZ5UX80t7wTRSv9uxCu1FVPR2YNw/3J9rqqCZ6vvrPs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ahDfPxZmRCGOVS42y/1lUEFiAxCd6fqByqt4mFByVZCFaH1v25BbZzivGQh7OPcBkKZ2N2Hc0Tpg4V6/5guErZ21zds1mhb25f/nZ9wXvWsK4Dfkropm/p8xoPDjHRkouLO8mDwcqdVxGHdfwe6H0k03pkHWioZyRBEyAgqj8N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEQrHi4D; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720160895; x=1751696895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gZ5UX80t7wTRSv9uxCu1FVPR2YNw/3J9rqqCZ6vvrPs=;
  b=cEQrHi4DrHbDiHR+QHa83byorUCtmSvkAmxKVBmb7ID2K/FxvaLZ1w1N
   xnEPjiYgAijC1X7nHSBwPlW2sqJteP3kT09HG/zHRHB3HFlQSu7/5HqDC
   +K0FKlciG0JRYBnfOXhAM2R+Bsj5C0S+Ydsey3++j0Q40zkAxoiPuNyMb
   xZd11lPbZFfk+TV7HtoEx/5v2cJpX9LAFPwRzbGJ2UC81Xo/ddFrJ2wna
   ejGd5k7+09Hb2xjLZ9GehNXTD1sFGMN3jTinUmLtrXGlPyKW/JdEqy+1d
   2Zr1a1GB+1QG34pZfaY9mJd4cW+mh8O/UGMr5fRaHqXUVSm/AjPBsZOm5
   Q==;
X-CSE-ConnectionGUID: I03yQQl3RCaNDDEMMoVvwQ==
X-CSE-MsgGUID: RagaZCCiQXKgwkCGw2ajiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17575294"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17575294"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 23:28:15 -0700
X-CSE-ConnectionGUID: ItZ//gk0SdCiQmoNk5RwuQ==
X-CSE-MsgGUID: WeXy1i5uQjqQchQOY59F6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46572120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 23:28:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:28:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:28:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 23:28:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 23:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEyJ7C5ikWOcNvnxtKkud/2NAt4JdxlWuy6eJGb+1iW+F3Ee0CS4Y04DjBZ29HNTWhHMBQgMHXNbV0dAJzoAZWcuorE6Ztqd/9mC4LjjkEeMyXvqoLtyU0WaLntGUVsE6DJnYuzJSOsnOFO119EwS1jMnkADDraDVLPf+6Qp4B6XM6Kr7N0bDLU4GWvrL9wqQQUOrLvssUJ5hvYHnqj0ySjLP02gk4Ge0FpeloJvKUE3v/yC28RFrnu6/4sr86K5MU3o0ilMn66gI1DfT7J7IBEhXvM2lLrAyTANi9b133rJ6qyU8W8Mu5AMMf+PV3GAL2qu1VHZ2IE7OLS6EWcSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdGZbYUlyVyvAPYyf73KRWyeUhYKQdp5dYVmsuBrzWk=;
 b=JK+SiNmo8D933h9T5qvSKYsaxFKKyg5Rmvs4rq5cckCgjN5p8zOPsScGSzkPv+klgKj4SoCj21sGsBrPrhok3cKoU1eZOsXvRMvHRKvu8qok6ouJ2RN9DB7Bry72s/D7p4ASL6RGnAuxOKEIhvsYGtrS6rO8Bq3iIk7g8PgvJ03T2Uj04Cka5OBF1hASMgGdP9H3gF5VzkmdqHsJM8ulPisbXv7IS9fI82W50XSzyHS1gqSlLyX9QZHuJelQm/HXpGhrmnUDRcdx9RSf8wkg8IvG9zuyqkVkNNIzb4A57E4aNWN58lUgcfH31xOZomr4JMqCfXMKmwuBeW7iUlXl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN6PR11MB8243.namprd11.prod.outlook.com (2603:10b6:208:46e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 06:28:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 06:28:05 +0000
Message-ID: <84e0195b-598e-4e7c-bd0b-82abb36ecb51@intel.com>
Date: Fri, 5 Jul 2024 08:27:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Shay Drori <shayd@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
	Parav Pandit <parav@nvidia.com>
References: <20240703073858.932299-1-shayd@nvidia.com>
 <20240703073858.932299-2-shayd@nvidia.com>
 <2024070457-creatable-heroics-94cb@gregkh>
 <c2f4a607-2840-4468-9c16-2edaca7844be@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <c2f4a607-2840-4468-9c16-2edaca7844be@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN6PR11MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 894898c9-3fb7-437e-b06f-08dc9cbba0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVlkTnk4SzZ4Z2VQcEN3U2Y0WDdGVmFJUUtWeXRCang3dC9EWWt2cmRacjZZ?=
 =?utf-8?B?R3ZFNTBXYm81MTZKYkVqWWJxcmw2eHMvZ0J4SStvS21GNFVCL0NHajNHSDhy?=
 =?utf-8?B?cG55bjByTEhNM2M5UklQTHZKMmZkdWpaOVZyVFlwM3oycVlBbmNnSUVYeFo2?=
 =?utf-8?B?Ui9lNWlTSUxNbkY3U29QVnU4Z3FFcEJVdmh6QmV2dWVLMlZxR2pWckdJbU5Q?=
 =?utf-8?B?cW00UXZ0M3RCNTl6ZzFWYUloNk9QQVg0WVB5KzIzb0pUZjAwbXJFVy83V1J3?=
 =?utf-8?B?bkxKcWZwVUdXelFLVGgxVUoxa0FqekQ3Tnc1YzRya0JTWUdjbXM5UkE0RzB2?=
 =?utf-8?B?c1RjNmdpbkpIdm9jMTUyL1l0dmRhbFFVL2M0dEwwdWkyZXMrb2tFN2FsZzlm?=
 =?utf-8?B?R0xkdmRndzFyNkxhK1VnY1k0UUNkK1Y2QTNjeTk5NjFBSWE3RWRsa2U4RVpK?=
 =?utf-8?B?Y2NrczJtUzhhQ2ZLUkNVRzl4aVVDd3lhZnYwdXNtdlhnK09kSFdmWHkyMUcv?=
 =?utf-8?B?a0NoRG9LdjRzbEVGNWNrNGZUY2R0RnROUmJiUkx1U2FUVkQ5Q0hPVFhxV2pp?=
 =?utf-8?B?S0dxM202ZWY0djFTTW51L0lhYUtVeWV4d1pJSFoyVDdGNmE2ZlhBN3h5a1ZH?=
 =?utf-8?B?Z21oTEk0MW5YWE9iOTdrREpqUjM0MUhpSDU5VHZmbXJKTGs4dzh4dXB3cVZ3?=
 =?utf-8?B?TXpheFE4YnhZK3pac0VodGhhb21iNEpsKy9GS2RpNElLZ21tYlBoS3dhRGxu?=
 =?utf-8?B?a2ROd2luSFVFYW53aFhmbjVvRmxtY1hwT01sNXpzeFA1Ukx3TTEvanRTN1Rk?=
 =?utf-8?B?aEgzSWJBUEhra01SdXlueEs5bGVROGxNazdqeW1lME05Sko1d1RzcHIwWXMr?=
 =?utf-8?B?YkZwR3hNVDQ2N3lBdGpNNzNIZkRob2VYMGJWc0oyT0hNL1h0Um9oVnpvZzBv?=
 =?utf-8?B?cFhZYzZ2UmEyZXA4R1N5SnF4bnRuMmZtcGtpM0VObGxBZDVuY0ZUWWFrcnU1?=
 =?utf-8?B?cExjbFJxankyTmdkU2lZWHhVY1J0bzhrZFdCR2liYUFWdHNURFF2OXRRcjJ5?=
 =?utf-8?B?OVBBVVltRW5nMXRiZ3hOTkV0RkNoSWRVQzB1Y3l6Q1diNXBTNlQ0ZmpkZStY?=
 =?utf-8?B?N0VEZW9NaFRtV3g3V3BuUmZ4SWZKT0NzMjljaXI5NHAyYjhHaGQ4TGVoSUZu?=
 =?utf-8?B?aitXY1cvcG5EUnFzM3owVVpCTnByWEZuWFdhdVhwMkdTeUJvOTZiL0phbjJN?=
 =?utf-8?B?ZGlEUnlQYUllemhSQk1jOC9ZQlVaMFpybWtFWmtJRldjR2luV3Mvb0xObXpq?=
 =?utf-8?B?djdXNWNWc1o4NkJJRStDT3k5RitnclBXQXFPUzZMenFyNnRpeFg1cVRYYlBN?=
 =?utf-8?B?UGNIYUcxSWVzOFIxMlRmdjRjeG0zL29iUFJsb2FsUjFXbWpWOG8yZjdwWGNR?=
 =?utf-8?B?WFRsallqaHNSNnBsVkFKTWhtckVLeW1tamo1bmRWb3F1L3dFdHk3NlRraU9j?=
 =?utf-8?B?clFpTHpEeGltald5b0NyRnhycUQ2ditiL3hCMDVyL3MycFFhcEtzNnlwRW96?=
 =?utf-8?B?d25ibk8wc2RtU25DUk5ORlQrUG1nRERORnlMaDQ1dFV3T2FMc3dsc3BqY1lP?=
 =?utf-8?B?RHVTS09CdVlnTjlIM25LM3ArT0Rib2VSOFE4akR2ZU8vRWlMNGRnWUVKbHBn?=
 =?utf-8?B?NExpV3hBNDNnUC80cHpjSVpTdUMrTERvMDNld1gzejBXVTRaRjhyUyswMFdU?=
 =?utf-8?B?YVVIMFlROUhvU21yaVVSeWZ1TnAwejJVc0tJQWk1MzNWc3RvazdkcjdRUTV0?=
 =?utf-8?B?ZjgzZXhnbit5clozS055QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJNdDNLTitoTmtOOGx4cGZ0eDcvbkFWS1B1dEd2cUpZMjBjYmZleXgybDVF?=
 =?utf-8?B?SlRaYmdLbnhNNkNXR05odVduMGd3NXN5OUI2bXhFYWk5a09mUTFRanlSM1I1?=
 =?utf-8?B?aWFITVZuY09uWTlSbVpyOVh4QytXL01rc0ZidEN1YmhnRW84dGFleUUwbkhZ?=
 =?utf-8?B?SFdjajVBWkhwOUxMUzVadXBpbnhENnNEQ052NlBsdWxablBEMW1yR3F3Wk1k?=
 =?utf-8?B?VXZkRXNEUDZFVm53UUkyTy9vRXpFMzdoNzk0Q1RXbm1oOGx5WGZVN2hFK2tZ?=
 =?utf-8?B?V1pWMlZqYkdFeHVSbnVvT1k5NE50TkNhZVo0V1V5UFFFVzFOWHMyTEtOOHg5?=
 =?utf-8?B?ODBablNOcEZGTXJ2RUtsbDhWTjhlV09iM0p2b0lwUjhpNU9mNnVZTFpraVh6?=
 =?utf-8?B?aTBlMklZRW9vZzJRRHROaTlVKy9kcXlCNWVBaTkyNENaN0NVZENuQVl4YTN1?=
 =?utf-8?B?di9wcDZWVmR5SlFUVHFSL1RyWWM2SzVreXExcksyc01vbnNJc2k2amZucVIv?=
 =?utf-8?B?VkFRbHJ5RzBXMWVzUThrazIvY0dtbFloYU9aUmIrbEtPRnJFK3gxaG9ncnFn?=
 =?utf-8?B?NUpEbVFhNUhOUEF3MlNEbXRYTnNLc1ZVdndhK082Sm5IVUJTMXllUlZCK1dC?=
 =?utf-8?B?QWNaV3puTU5BTFpOdHhxb2liSG5GaytNb20zakRrTEFiYUJjVFZaYWlkdnFF?=
 =?utf-8?B?S0dvVUYzeTgzaVJPZmdhSFErWTJHUFo1MkFmS2JtNkQ1dUNoRlU4NjFLbnd1?=
 =?utf-8?B?VlpUZ0h0dEN1QWwxbVorYStwVTNLTmFKdkJwU1ZObVI0ZHVxYUg5allVYmN3?=
 =?utf-8?B?Ti8vQ2VMeUxYYldOajdCYnZGaUtFVmY4K2o3R3BWcVE4S1B1dUczMUNQY29T?=
 =?utf-8?B?SFFSUXM3emxZTGdEVDl1OU9mSlgyamxBZzZGNnQ5NzNmNnFjU2w2WFRSUFVu?=
 =?utf-8?B?MWprL2o3NGovZzBwRkJhRWF5b21ZREtCR2J1S3ZEcXUwekdpeVJWRUhKTk5r?=
 =?utf-8?B?SGt6WlNmR2FNUkh5dkpNV3N6bXg1U001bWVIa0ZvZHVUN1NqZ1ZBL1h0cHJo?=
 =?utf-8?B?RVNHWVNhbEc5UXZTbFNlQlhoTUE4d1VoZkkxZVIvbmVPYnR4eEtXQldyRmd1?=
 =?utf-8?B?MkZCUDdyeFZBdkFtUlhyd0VxQTNUMkdvZFZSRzIrcm92Z1JPMXVJdFNNVElW?=
 =?utf-8?B?bkJXZjJxNk1LUWsrOWZRT0dybDhzdmU2SnJVNUpVQnVvUDFHZWgyUHdyZzY0?=
 =?utf-8?B?c29kY3FXRXJncVRGUi9yTC9rMUdCVHFqZHlUdXMzalZaMzJDZlFvLzFxUDA1?=
 =?utf-8?B?L0RyY21OMldyRzF6MEY3QVc0bXZsZXg0ZEJ5Nlo2YzZwSmY1dEgzRGJ3QmtB?=
 =?utf-8?B?Nk8xZk13SXVjYmswT254WndDTWRVemJrVFUvcnpycGprWVpqZXFrRkx2WThn?=
 =?utf-8?B?YjUyZVQ4a21MZnBMclNINXBienJnbnFOSkY0d0hGRk9jUXdGTlN0MW5rMWN0?=
 =?utf-8?B?RkRNdjBKRisyZXYwdU1yRWF2cEJLREJyRU9DbEdNTld4NWhYdjZObFZmN3I5?=
 =?utf-8?B?eXFiY2diYUNrbzh6SXZhTUk0M1hDajZPQm5naGhlSFZtTDgwbVNydE1LTDdj?=
 =?utf-8?B?RXlTVzExVHg0T2c1ZTFTMXd0SGRRK1ovWHJKcjNGeTIwUTFHUkhLbk5WWU52?=
 =?utf-8?B?ZkQrSVlOaUpWZ2NCU1pGT2EvczZuYTk1M3pqd3gxL3pqWXkvbE9qSW5mWDJG?=
 =?utf-8?B?ZHNKUDMvVWFDUFlQbGZtVG5nN1lQb0pUU3F3WHozeitWK3V2YXhSYnFqQk1Y?=
 =?utf-8?B?QitLOGNXZG5nNEtHNW55MWNkUUhWNnJFMVR2WHFYeWZiK3JPN2JXOVVaZkxm?=
 =?utf-8?B?U2oxdlFOcFV4V2ttZVR6TVNXeitXVFNjNkFJOVlMMXliSExtcHM0dUprMWEw?=
 =?utf-8?B?Q3VVK3RoSzQ1bTZCeGdGNVBucjJOdmZGbGdEZmwwVHBzdVYyTlRqcjhrWVhy?=
 =?utf-8?B?QlA1b01ITytnWTY0SUJxbndqek9pSW83K3BhTEJBVXBDdG8zMHJkeUFXSWdK?=
 =?utf-8?B?Um4xZWdqcnJEQkpuRDMvdVF1VlRLVXQvQVp4ZHp1aXhhMVdQTUVFTzdxV01q?=
 =?utf-8?B?Nmx2dU05ZjhKU0RocmEzczRVcDBtSnE5Y3g1YW4rSytRT2tUTzZWdGJKeUIv?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 894898c9-3fb7-437e-b06f-08dc9cbba0f7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 06:28:05.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b6OJZQD34g9vw+cuxCxI8LLal3pXx1bw+9u54ETJbcRd6OBRiG6YK9L4SbhDQLG41AcKA1Iy0KKhDZPpelhkt8jpoPXPYufjNTf08BvmG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8243
X-OriginatorOrg: intel.com

On 7/5/24 07:35, Shay Drori wrote:
> 
> 
> On 04/07/2024 13:41, Greg KH wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Jul 03, 2024 at 10:38:57AM +0300, Shay Drory wrote:
>>> +/**
>>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>> + * @irq: The associated interrupt number.
>>> + *
>>> + * This function should be called after auxiliary device have 
>>> successfully
>>> + * received the irq.
>>> + * The driver is responsible to add a unique irq for the auxiliary 
>>> device. The
>>> + * driver can invoke this function from multiple thread context 
>>> safely for
>>> + * unique irqs of the auxiliary devices. The driver must not invoke 
>>> this API
>>> + * multiple times if the irq is already added previously.
>>> + *
>>> + * Return: zero on success or an error code on failure.
>>> + */
>>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, 
>>> int irq)
>>> +{
>>> +     struct auxiliary_irq_info *info __free(kfree) = NULL;
>>> +     struct device *dev = &auxdev->dev;
>>> +     char *name __free(kfree) = NULL;
>>> +     int ret;
>>> +
>>> +     ret = auxiliary_irq_dir_prepare(auxdev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>> +     if (!info)
>>> +             return -ENOMEM;
>>> +
>>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>>> +     name = kasprintf(GFP_KERNEL, "%d", irq);
>>> +     if (!name)
>>> +             return -ENOMEM;
>>> +
>>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     info->sysfs_attr.attr.name = name;
>>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>>> +                                   auxiliary_irqs_group.name);
>>> +     if (ret)
>>> +             goto sysfs_add_err;
>>> +
>>> +     info->sysfs_attr.attr.name = no_free_ptr(name);
>>
>> This assignment of a name AFTER it has been created is odd.  I think I
>> know why you are doing this, but please make it obvious and perhaps
>> solve it in a cleaner way. 
> 
> I am doing it since I want the name memory to be freed in case of
> sysfs_add_file_to_group() fails.
> I don’t see a cleaner way available with cleanup.h.
> 
>> Assigning this "deep" in a sysfs structure is not ok.
> 
> when creating sysfs dynamically, there isn't a cleaner way to assign the
> name memory.
> The closest and exact same use case for pci irq sysfs which uses dynamic
> sysfs is msi_sysfs_populate_desc().
> It does not use cleanup.h but still has to assign.
> I Don’t have any other ideas on how to implement it any more elegantly
> with cleanup.h.
> Do you prefer to assign it before sysfs_add_file_to_group() similar to
> msi_sysfs_populate_desc() and avoid cleanup.h for now?

I've overlooked it earlier, sorry.

easiest solution for "general" case would be:
	info->sysfs_attr.attr.name = no_free_ptr(name);
	ret = sysfs_add_file_to_group(&dev->kobj,
			&info->sysfs_attr.attr,
			auxiliary_irqs_group.name);
	if (ret) {
		/* freeing manualy since auto cleanup was
		 * disabled by no_free_ptr() */
		kfree(info->sysfs_attr.attr.name);
		goto sysfs_add_err;
	}

but in your case it will be cleaner to alloc the space for name
together with struct auxiliary_irq_info, by placing a char array
there, either with static size or a flex one (if such case would
be generic)

going one step further would be be to reorder struct device_attribute
and struct attribute fields to have @name as the last one and make it
a flex array - but it is perhaps for another series ;)

>>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
>>> +{
>>> +     struct auxiliary_irq_info *info __free(kfree) = xa_load(&auxdev->irqs, irq);
>>
>> No verification that this is an actual entry before you dereferenced it?
>> Bold move...
> 
> Driver must do this for allocated irq. So xa_load cannot fail.
> In previous versions we had WARN_ON to catch driver bugs, but you didn’t
> like it.
> I think this is fine the way it is in v9.
> 
>>
>> greg k-h 

Perhaps this is more about trust boundaries?,
I would like to learn something from this case :)

