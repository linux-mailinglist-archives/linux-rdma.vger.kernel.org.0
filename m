Return-Path: <linux-rdma+bounces-4965-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2671E979E8F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94F12840A9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB814A095;
	Mon, 16 Sep 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewcAFPSL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9114885D;
	Mon, 16 Sep 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479523; cv=fail; b=os9xRxJlQaR/92pEeVPCtXrMPFxnjFe/SLEf577vytl96D+hGh97pH8Sw+fPaDZkxllsLq377zLX+2ImrBZl1MUpdzbllbaRct494jRk0A7W87o8D1BqMoT0VtLtX1XR0rVlgGx8DFibVZUjNRpbcNuwbSi0PxLL37T088TZAD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479523; c=relaxed/simple;
	bh=cc+OJ7MMpbpb1sPgjE/gvGjwSJlV8yTMIFjlZVqvV4U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfURjybtZRgerY1vl96NbXkg0/Jwg+sNcCNy/7GdK8CqAZ8PqPcdCtOqxla+fB8ZBW8wMMKsxzvjCpbQiWKcjG8zuICjvi0/ylmKC2zan6BvcftUMWDOYlezNkaCDmQ/vnr2EE4rYIiO2SavvZY2+s5gneOZ1him0AGHaDpRF/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewcAFPSL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726479521; x=1758015521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cc+OJ7MMpbpb1sPgjE/gvGjwSJlV8yTMIFjlZVqvV4U=;
  b=ewcAFPSL4yyX6kDojvcrOUaI/l422jFUiFD9MgFq05CYZ2yH9DqpYWs3
   6+DeF/MfxZ2UIHMARzoNVvjpWwKQWYa4/nrisx3qDhc2PMO8BIBSkyf6I
   sOpCOvFUDozNrb2hjq87wprortqKcf5TqKtjc5HBhXUObns52tvJm77p+
   5FqS84/sOdEEg4DpyOARXcrJ5N8ebAvBxGw4BvaUA3tdxvPof3nISS15q
   g9LGx8hMtidA7hYkUe+rBelYI0kTTRm8GfsVN1BwA+CrLiDHpCEAvA1fP
   jobq4DtbwImFb/PQYsgjso7hF7lITwi01WY1SR5eb+kNanWVemoAJ8OGb
   w==;
X-CSE-ConnectionGUID: fsIEHKDzQqOVFXeGMfyQWQ==
X-CSE-MsgGUID: M+chfGrgQYO/VGU3dRTwMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="24783611"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="24783611"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:38:40 -0700
X-CSE-ConnectionGUID: Nbp5ftM5S0q5OEWyCvuvCQ==
X-CSE-MsgGUID: 1U4JegFJRDeuFQN/1dRRSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="68432034"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 02:38:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 02:38:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 02:38:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 02:38:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 02:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsmDK0kNm/7vDKePHgr+govC/HARIwk4D1cnNBARFb3W1HD11/dFmqVLxmZlJ4fXy+C97jnIepCadQ4uEmDz/AdmdyDyEmK6CZ1CZsV82kEfdZ7fBAX35YRBM6WFSdO1iPN4Qo9K4+gw2B+xTSAtQhofwsCmAd595U/lboetD9jwPX2Kak0cvaMskvyu54UMg88MYuf7lhCOiQ/ulfpVB4lG/HhC4D0hL56und1x3SgBDdS3miRZPY5z53OFAKpUURJoUcYY+BujgWq0SXbOajZxj3+nG6sChPJezFuO87AtXkfesFxNKEJh9Hmz2A9tKtnlcRSmSVAHNdFzGSMLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88S9Gl7EWt8Nr1QFR7NMgAMZGkNkLRB/AB/smYbBRY8=;
 b=WxBd2nyGjpR46rZUNlBccZHsyZ0mvu+2wd7eZzpgBE4DQBpZOhLFn9kH8d8XrooEZGqVxFvnsCHXrhU4+fd3zU/Mj8/ake4tIm7v95fN+j3ma0PlhHKycf4T+YrD7dR8vSM9FPz1AKd9P2JcH5uTAirQ8z2iRq7+UqhkmeO2P5gBEtPBJnPU/FkdoP3hOeCpqG1K5AkjdU8uCmIH71bEtphlvgmBBnsbUDDAkHspSAsc76xO332P/mIGH4Wau1Xao5g+xr9Icswsj7n3uDAtMfmIQ+XV2+NMKgB2Y4I0lPTrOUYjKRCScMFl4hScDrqzFby5xr5c4K7ZgViYaEZnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 09:38:33 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:38:33 +0000
Message-ID: <7e43fc1e-568b-4572-99b1-703773c0c431@intel.com>
Date: Mon, 16 Sep 2024 11:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
CC: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "Simon
 Horman" <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <20240913135510.1c760f97@kernel.org>
 <6b979753-9f5a-410c-9fe3-d2366976e316@ans.pl>
 <20240913194808.43932def@kernel.org> <20240914082156.GB8319@kernel.org>
 <528f30ca-5434-4f75-9587-c253c934bfc1@ans.pl>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <528f30ca-5434-4f75-9587-c253c934bfc1@ans.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3f2b61-3a01-4a93-2b23-08dcd63354bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUFyTUp2UmQvZ292TnJGWG5PaEpEeEhWbllXaGRJYWNQYmY4dXd4M0VQU0dU?=
 =?utf-8?B?SWZwWkk4QjFqUXFBTXhrdDRhY0N2SVVHcGlYaEE0NXg2Y21aVzdIMThqd05h?=
 =?utf-8?B?dlFYR0szRThkMkU3V04xRkNXZUU0S21EekMwdndpam1ETTZZMEsyMitRQXFT?=
 =?utf-8?B?REE4RWtDWVlTK2pURE85cGZ6M3NYdHVzUk5ycXRHRVdWbm1URFloL09ia28y?=
 =?utf-8?B?K05zcVRQYzF5SEFaQ1RtYkNHRzVuanY4ZnRPQnZNRHpNNGphdGd4cjZKZm9D?=
 =?utf-8?B?S2hlTkQ4akFTRU94VWhjYUpwdkZ4SjczZ0RsYWNnZEg2WnZPMWhwN0hKS2xx?=
 =?utf-8?B?MGRubXFwZFNreGhkVnBTT1I2RnlJb2swL0VVTWNmMGh4K0Z4RVFWd1FCdW9T?=
 =?utf-8?B?QldpWm9IVGFhOEMvNnZTREo1SWhwdDNpc1FkcFVLeUpKaGFCS05NYU51d2o2?=
 =?utf-8?B?MmJoL0Nlb3JodlNrWGVDbHpQSkp4S3dwSHhYM3FpSFhtMFBYYXVaSDBlNDE4?=
 =?utf-8?B?cmpsRmk0VTl2bXRMMng4Y0lLaXVKVU9MMXFQelN5dGhiNDdxcWdLQTBHNi9I?=
 =?utf-8?B?QVZDT2huVUE2MDJOaXBVZ3BweGhIaWxVRnd2eHA5OU04N2h3NTRUT3FlSFVD?=
 =?utf-8?B?OUd4U2pNOWhXN3lSUzZxc2c0b3BxYmIrbW1lVHRJSGdNUmhoT09NQXJzVXdG?=
 =?utf-8?B?azVoKzRtZ3h4NDliNjJHVDZMTXZiTkw5cjBLeElMcDBnaEVzaWZRK2p3WndN?=
 =?utf-8?B?QzhhNXR4ZmJiVWZVM202d0R5WTZPYnNKMWJjUk9UTzlhdDk2NjZiYTc3cDZL?=
 =?utf-8?B?K1NoQ3Q0aVZzb3hEWEd0VGdEZ2o0SDNvRjNacEZGUGJwM0JyTlphSVNJNGlm?=
 =?utf-8?B?cUJjaDFNcTBYNzJVL0k4aWZpSmVPempIdXZVVTJSSHFOZXM5eTJHT1l1M2F3?=
 =?utf-8?B?ZEk5MnJSYjhBdUUvK3hOTzI5bFpPa3QvdW9IR3JWTTF0V2J2TGRhT0NoTCtZ?=
 =?utf-8?B?L0YyQmtiRHQyaFRiN0tET0ZqZTI1V1EwcDBneDh3ZWhYM1FIYjhuaURWcTdz?=
 =?utf-8?B?bnJJQWJpdjRHb3VDdUZnS0ZKeUxNamFIYUVFbTFoeUxLeEwyTUVDQUNJbHdx?=
 =?utf-8?B?Znh1aEFla0hwZnhaemtSeEVHeEFTVGs4RXp0M1VBNGRmZFErZU5LM2o3ZjUw?=
 =?utf-8?B?VTRFVVprdEQwdG5UaFd0TENFNFlGTzRXTEcya0pJYnpIRjA3TzRJWlRnamRF?=
 =?utf-8?B?NGI1a0ZaVTZJYktEa3pTZ05qVEd5cURsa0pUOENBcFdKZE9HdUpaZ2gwYjRt?=
 =?utf-8?B?MFBiRVVMZE95Y0FOVXlQTUJsWFA4bXNTZnp6UUtvcFdIK3YxS1hzMkRXcmw0?=
 =?utf-8?B?R2hFUTd2aFpBMXFWSU5GUUNCK2ZMc1NDL3B0alJuM3ZqZUR2N1hqTmlqM3VR?=
 =?utf-8?B?NzBVRGJ1YVJlWkxoYi80bncxWTN3eStZMDByNDNSc3VVaEE1T2NLaThEeWt2?=
 =?utf-8?B?UWN2NncvR1F6VDBRODR5bmVmTlFqdVltRWxrMDg1dWtsdGNNN2ErQ25zUi80?=
 =?utf-8?B?OTUyUVl5RThxZzUzcS8zMzF6QkppcXlIV1pnWmh4dTlPc2l3ZklWanhRTFoz?=
 =?utf-8?B?L2FqZU9YeHJKTUN2ZCtleTFvM1RYRzdkZjROTThydlI1N244SlpLMG1yUndp?=
 =?utf-8?B?UEZFenBydkJhQkxvbmc2SExEblk4aTBialN6Z0lGMW91dmhaLzRpeW1pWlJx?=
 =?utf-8?B?eC9pa3dtdWJlUlFQa1ZXeEpsYXZGbys5OGplV1J5K2NaVDFpOWcvV1loZ1lq?=
 =?utf-8?Q?KRyGcMECax/P5beg9TtKGHpqZDYMZX21fWqVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlF2cTRUWTRXWU5NU0RhV3U5L1pDNElYTStrZVcrWUxiU0NKcjlaeGdpVzVZ?=
 =?utf-8?B?QlNnZ000MURDSDJheGdtcStuMDNsd3dYTHBqbEFrQWkzcW1jdzR0R3VqNG83?=
 =?utf-8?B?QnNHYk1GUm9OaWZmVlJIa2tMZXZ0cEptbEJTMk9HRFdqR0tDWE9mMThTS0tM?=
 =?utf-8?B?SkNuTkduRmhRZUZyMGNtZ2h0M2hlZlQ0Mk9JWUVacWZPZitwaGdUUW5Gbmlv?=
 =?utf-8?B?TlUxVHVDWFJqUUpmSVhxYVRCdEE4dXhnbTFybWlGVXIxemYzZklsbml2eG1j?=
 =?utf-8?B?TzIrWnJwdFA3d1R2TUN4UWRYblptRjQ1bGJ3bWdUSExGRi9FaFFxanRWNTIz?=
 =?utf-8?B?T09iQ0l3SFd5YTFVVHZkT2VDdDFScU84WVZ0RFVHMFJiUjFrRkowd2tzT3c5?=
 =?utf-8?B?SlovMVFZb1NjS1A1TmdVUzdiQTE0NFJ5dUpYSXB1WEJFYXJ1cmkwZDdLTHlU?=
 =?utf-8?B?TmtqQlZsNHlsMjhpbGMwb1ljcXlrcVFid0NLbHV4M2JlVWxhamNZWXU1UnZM?=
 =?utf-8?B?QUtUbXM5a1dHOFpEVEhReUpZUk5Rak5DaG1Md0hMY05mVEUzd3JqUnNRdVJM?=
 =?utf-8?B?bUNRVFRWOXA3VFMzaFdTWk82R0dxRDkwYzR4S0F3QnU2eGowSEJBQytpLzVz?=
 =?utf-8?B?V3lUOFZRd3JtV1dKbVBMSUNGV01QWDQvdGdtZGFwR0dRTjl5YWdCd1hzWTNI?=
 =?utf-8?B?bnZZMXJpSDNTQWY5Z1FjTmRjUVE3MlcwRjZRWUJqTEYzdlI3UEI4U2h3TkF1?=
 =?utf-8?B?S2hRTHF2L21xTmtyU3lKMWgrdm1yNCtDaU5uYm50TW5UYnROYStyMFk4bHQz?=
 =?utf-8?B?STFDcjdNNUV6bWRVVGFOVkJlK3BjVG1VNFIrRUIvb2h3QkZhUzNSYkEwRkxz?=
 =?utf-8?B?TVI1UUR6M0ZrQlhBMnZncHVCU3VYd1o2YlBTNEphU1dmcUxSeDZ6ay83TGxQ?=
 =?utf-8?B?WmdqNmhQYVFIZEJwUHpKM3VNSnMrcHBsRzFSSEdpUnMvd3FPYVM2cVdWZTJ5?=
 =?utf-8?B?MXUyUS9WSVY2VGtIakozNm1zOHZLOTQxRW9UcVZFNnNHQmRnclljK3ZuNk11?=
 =?utf-8?B?UEgvbUxYZDhnZEdRQ1k2eDk0ZWNOSTdWWnVCYVZhTzhYaHlFMWY3Z044OVky?=
 =?utf-8?B?ZTFiVHEyK3ludiswcEhTS3FaVThPUmRmNEFybVBJM0FMcEMyS0dtakY0Sk1i?=
 =?utf-8?B?MkpVSHhhM3ZnYkU0cHcva081a3BpenBPajQyd3gyWjVDTFZOL254Q1F4M2tO?=
 =?utf-8?B?SFo4c3lRQWVJdnlQcWVKVHpWTW1oSnVndVZaK2ZDRitKY05jYXdrWG5WTjBV?=
 =?utf-8?B?N3hDZ3l1b01RdUxEd2tTN3JLUWtLN2l2WFdVZU9UclBXTTFzYTFZb3RiajFI?=
 =?utf-8?B?K3VxSWFpV0tWSkZCOTlLNTJjdURPSFk3aGVPUzIxTm5KKzhrclVQUmp4UzUx?=
 =?utf-8?B?dTcxeTZCU3EyOGtIUGpGYXlEUk1vOWpEaU1ZYXhoVCtBWk9QQTVhMkdjQVVu?=
 =?utf-8?B?Y05LUnliUC8rZldJdUFmZ1hGY3VnZjNDMmJyYVovZ2FRSVRhMHc3S2JnSmFK?=
 =?utf-8?B?NHRVMFdhM0FGc3hkZTd1RTN3Uk14bVB3WWxOLytDWVJXSUdBVE9ISlNyWDJ0?=
 =?utf-8?B?K21IRmJhbmptV1R2THhaTTVqRkFxRjdHQTFoTVg1ODdQaERNTXpObTJRZjVs?=
 =?utf-8?B?dnJITHpmd3RJMHR5THFHemFGNFdud2pmV2ZidXYwTjNCb1NjYlM3V1dDRjh3?=
 =?utf-8?B?SzJmZzNXb2czZVhPRnJCYXNwRTJTV2huMUNFREREeGQ1V0lFSHRNTGRTUlY3?=
 =?utf-8?B?Qk5pQTRPZEhncE43cTg5dHRDTkZqanE3ZE5MM0s5Sm5vSEJiT3M4OTZmKzhq?=
 =?utf-8?B?RDNyN21sYmRBVXFGRlBhNGltYjZGTGlHckYrbmxLMXlMcVBYbGd5Und3VUlw?=
 =?utf-8?B?LzVXS0V2T09zRElUMFhwZXRheGpOWTJyYXg3TFNmSVQrd0k5bEI5cERmNEpS?=
 =?utf-8?B?c25xRCtQcFF1aXdDWi8vMEZwUnU3WmVKMWJFaUtZbXFvT3J5RHdkQmhBS3ZX?=
 =?utf-8?B?TC8wMDFXa25GVkQ3NFRlazg1eXRuZ0ZPRmNTSTFEcXhWdGZQbUNnaXdkamlj?=
 =?utf-8?B?SFJaWWkrOTltWlFWdkMxWldQb0I4OHBVNzk0SWNJMDJIZjhZdXhHZUNiSkJh?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3f2b61-3a01-4a93-2b23-08dcd63354bd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:38:33.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paEzlSo7eXprzcieiQ9LCusarYuJkZU2F2i7/s8uA5llSg4xvRD9X+0080VHeALUT4Ka7HtCrDWPcRQChC/xPaROiRmu37QfvmgtMiIOrN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com

On 9/15/24 04:21, Krzysztof Olędzki wrote:
> On 14.09.2024 at 01:21, Simon Horman wrote:
>> On Fri, Sep 13, 2024 at 07:48:08PM -0700, Jakub Kicinski wrote:
>>> On Fri, 13 Sep 2024 19:12:01 -0700 Krzysztof Olędzki wrote:
>>>> On 13.09.2024 at 13:55, Jakub Kicinski wrote:
>>>>> On Wed, 11 Sep 2024 23:38:45 -0700 Krzysztof Olędzki wrote:
>>>>>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>>>>>
>>>>>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>>>>>> as close as possible to each other.
>>>>>>
>>>>>> Simplify the logic for selecting SFF_8436 vs SFF_8636.
>>>>>
>>>>> Minor process suggestion, I think you may be sending the patches one by
>>>>> one. It's best to format them into a new directory and send all at once
>>>>> with git send-email. Add a cover letter, too.
>>>>>    
>>>>
>>>> Thanks, yes, will do for v2. I assume this needs to wait for about
>>>> two weeks for net-next to re-open?
>>>
>>> The cleanups - yes, but if patch 3 works you should make it independent
>>> and send as a fix (and trees never close for fixes).
>>
>> Hi Krzysztof,
>>
>> Just to expand on what Jakub wrote a little. In general fixes should have a
>> Fixes tag and be targeted at the net tree.
>>
>> 	Subject: [PATCH net] ...
>>
>> Link: https://docs.kernel.org/process/maintainer-netdev.html
> 
> Yes, thank you Simon for the additional feedback.
> 
> I initially targeted net-next following Ido's request:
>   https://lore.kernel.org/netdev/Ztna8O1ZGUc4kvKJ@shredder.mtl.com/
> 
> If we all believe "net" is the right target, I'm more than happy to update it and re-send that single
> patch now. Should I mark it as "v2" even if no difference because of the tree change?

yes, additionally please provide a changelog, which will say "retarget
to -net" and it's most welcomed if you also provide links to past
discussions

> 
> Also, I did include Fixes in that patch:
>   Fixes: f5826c8c9d57 ("net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure")
>   Fixes: 32a173c7f9e9 ("net/mlx4_core: Introduce mlx4_get_module_info for cable module info reading")

those two fixes tags are correct picks for your two changes, but I think
that it could be combined into one place, I will reply in the current
"patch 3" thread (now you see why it's beneficial to send whole series
together :))

> 
> See: https://lore.kernel.org/netdev/2aa0787e-a148-456e-b1b5-8f1e9785ed04@ans.pl/
> 
> Thanks,
>   Krzysztof
> 


