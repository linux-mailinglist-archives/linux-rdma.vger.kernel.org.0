Return-Path: <linux-rdma+bounces-4427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA04957B18
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 03:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD0B1C21BBE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 01:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6931B949;
	Tue, 20 Aug 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXWirl4i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC7364D6;
	Tue, 20 Aug 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118144; cv=fail; b=IUPGiWll8tV3GluJ/ag4xPoeNcgMWhs+a6ZTgL06I1uU3N0wxI5ogNCYqQDECmqEAUETAyVoG18Z5kb8L3LzFr5yiy0rfhR3JuWHdjv1VGUfegoNrsOSFc3gURdKqd2TbEQHUvKe2e1BQX7b7aILbTUrghIPmfn1tTbRyP1iC8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118144; c=relaxed/simple;
	bh=tdjUAmFiAt7rFX8qH9zVajybaiAn1+lRwJ7Z/FAdPZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TRoCIfctik+DqiZBGx5FIRSoIUPeaZzShL3lHFAMxP+OaWhqf24Era+aTNf683Z3+XyUMUcGJCDa4z5cARc8rBZM1AIeJMhpf+CcxuXJ/c/2KDQhZ93TdhylnraU3xiCKAKEeb+X5F8F0goHVm3ZDOlTbjrpHNFBm7UpCy6FO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXWirl4i; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724118143; x=1755654143;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tdjUAmFiAt7rFX8qH9zVajybaiAn1+lRwJ7Z/FAdPZk=;
  b=UXWirl4is0lgpxco0PPKFsDkRGLe045c8IpWmDIaOoLV6QYYwDpCjn1L
   SOHaUGntxAjznGRCOog4uBmHf5hPBrLA8GJntC0+Ext7KJ7JIY1kBXHsh
   PcOTcaR+sDVGT3ASl+QX3io+FEqOzCjbudNnaOA1Kgv9mkB/N8mVMkYD8
   4WZpnSyME5zbo17OwllhLFrdmscSdx8fQo6ecPY2Y5HGyif44XIauLGUP
   f7kbKIxw4fbJXwCkx0gvrD2BNmwJ67S3QirKQG6hAsod1p4ZNLezQB7Tc
   CiPcF1A/PkpN4a5sbj+TNTpUJNImgR9QSKiW+jC7qL6oNq0MGPP3xpKiR
   g==;
X-CSE-ConnectionGUID: hbhxxJzsTGSxH6b+i9UCuw==
X-CSE-MsgGUID: 4Lr/dkfIQXSRfDqB4T3p2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21935264"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="21935264"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:42:22 -0700
X-CSE-ConnectionGUID: 0Vugn/4jS3WmkxtG+JujZA==
X-CSE-MsgGUID: FUONVXMWQwmxTZlDpatb6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="65429215"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 18:42:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 18:42:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 18:42:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 18:42:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 18:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvccienMNMbLc4I8ThdqwfEPfA3TwpufBTaNMCCMgz8xGJRRGS8yLNWMvedycJ2xH0aFKjSwFwdT50rkeM3BKZE7oS5FInDnjQmkLMxjC9BxshU6o3SI4nZ5O+w9lOvb+Ev7oxAbbjt86Sy1yIaDM1aKz+tSjPjeic6t61ZxDAwgv2gPeuKVecK/yXVNS60ua48pvZFw5Irgpa5k18uAvijJSoPhmXBx1Ouz8RaYfpLnZjcGV9ta8zXsO77Ro3I2sRQWtAbWcdWV1+e1UHh/ON745X2c1HpjcOM/3X3n4hSKAguVvbYqHML6IEIxwLqEVtRjNxWLt2Jgabrr3lZOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwdnwFAGzi2YiInuLq6K+2pi55M1uESqEU6qAGsqMpc=;
 b=oBBq8BfNNUXsLhbkgMRtUrQjIFQYvchzZzDZ9KvBdX4GOTuoowgycJTOP3WZsnylIWxFRQPti6frHcyA1iQHWuGmCM6ztAOZaYF0+yNxmI25D0y1zKG9zkxkVALuPZG2zfv2wTMLTeK0K0EYg0CWqbrgVObZMfUwZmoY3dnCuEc4FP4XLvE0M8m0SUpmdyfrXAzaIKJFXYlnOsqykFJQHarReaALNpxEY1vbjK2U3j7keVEv2A1AOQG40N0Rp++JXX/11QlTfw/uvyjzK8y1rblGmaTpEy3Xps2xPNuImphT0rzJ+1ynr8K9jIPAl8BjG+O5yqwZXFpB8wLLULOmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 20 Aug
 2024 01:42:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 01:42:11 +0000
Date: Tue, 20 Aug 2024 09:42:01 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Bart Van Assche <bvanassche@acm.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	<linux-rdma@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
Message-ID: <ZsP0ae1Y5ztsqFj1@xsang-OptiPlex-9020>
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
 <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
 <5377e3e7-9644-4e71-8d2f-b34b2b5ae676@linux.dev>
 <ZsGTtLzYjawssOs9@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsGTtLzYjawssOs9@xsang-OptiPlex-9020>
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 8705542b-2691-4f1c-a448-08dcc0b94f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGUyOVhVZ09weWpXa2tkSkZWcGpwUkhabFVaSGt2ckxJTFg1TldhWGxDd0Jz?=
 =?utf-8?B?VEFvclB4SlFBK1R6TksyYmdzODR1S2x6UWFCQ1BFcTc3UVFEbTFxMDdLamJ2?=
 =?utf-8?B?Nmxmam9VSHR6citiaXN1bytRYW1QcTNXcDQxbU5QMmI5V25vVzRjdStRZk94?=
 =?utf-8?B?anhEbktLZ2xDWkJxQTJObldUVmhrWkVnbHFBQ1pjOUR5VXVtdWVVU2xIQ0NE?=
 =?utf-8?B?YzRsaGVHZW5LL2JBUWVCM3R5WlBxaW90WDlnVkMxcDNMck1KZDFVVFRpNFdu?=
 =?utf-8?B?UG5ncmNGUXRId2NDdXcxRkVIeEY1bXZBemNMc3ZHS1V3Q2lVbkQwNnNjNmE4?=
 =?utf-8?B?dEhsOEpRcmk5cDJsQk5HREUrNlQrTmZjUWljUHU4amROY3dKbTdpdHp6VjNj?=
 =?utf-8?B?UWNic1BGTmVoSFVTOGtIL0RveXZxdXo0ZnhrVkpJSEhnZElqcnJtZ05rRnlp?=
 =?utf-8?B?Z1I1MnRIbUtNeUZ3b0swRGxQNDlqWmw2eGlJTmJaS0lpNTU1dkl0UVNGT3JF?=
 =?utf-8?B?aVU2d0JSUGtZMEFmZ2FDSWlQZlVYTXNUZnBsNWN1alZLQzFPYlJvZzVRM0xZ?=
 =?utf-8?B?S1lYUU12YituRHk3QjFqVW81bjZSSHcxS0dnN2h0amo0YjU3andJcFcyWDJz?=
 =?utf-8?B?bjBVNUV5Z3J0Q3o2QVN0QWJxa1djNmlIdHBDUXExeS9RRmw5Uk4xdWx3dWRH?=
 =?utf-8?B?dEFoZzBXS0VLKzF6UStSZHRHYXFQNnRJY2F2aHVaUitlT2dCckY2MFg2aUxk?=
 =?utf-8?B?b21SaGFiSjU3eTVpZ2p3RW8zVzlwTlFoWGJib2xGMGJ5aUFTQ3BydFlCRjQz?=
 =?utf-8?B?OXBTNy9adFgrV0xVNm4zUDFjOW5CdHQ2VDJRVUVIWlpMeDJMUzhlSEg2eGpF?=
 =?utf-8?B?dHZrWVZKb21YbmJaSWs3Rlo1dW9DUGZjczFsRTkwUnh2V1NQenBzQVkrUmJw?=
 =?utf-8?B?SjdFcHV1QzNMeDVjUjhVUXJSQnBzdlpETTlzc2xiNU91ZWwvcFBTY0hIVzkv?=
 =?utf-8?B?SDkvaUtjdjhuZVJPOEw3dTVjZVREMWhwdGNpZmFRWUNQbUFhQUlGZ2NvN0xT?=
 =?utf-8?B?MlNmV29lWFgxSVJ2ZGdnYVdwWE1DZjdCeWloYU9EMjk4OVJCblJXMTFrOEZt?=
 =?utf-8?B?bjFhdm5wZW9OSGYzZDJ0ekxvSC90dHhEcUlXT25WNFA2TUtoYVNDbnhZbDFx?=
 =?utf-8?B?TnNpZkhIZ1BzRlByQ0IvRmVxMWNJWllnYnVzdk1mYi81cENKY1BBaFQwQk4y?=
 =?utf-8?B?Um91M2ovQnJwWk9WU2pyMFdzTUFwWmlFemljY0VSaE9uN0p6NHkvWmYwSkFr?=
 =?utf-8?B?Wk9iUHFQY3lBQ3g5OXJRNXJnR2liekhYc04rS0VHcy9Vd0l1Y1ZaQTI4Z1N2?=
 =?utf-8?B?d0Zya2RQWTFjZTlSdWJuT09ZZ1FJd1c0VUZXcy82UHRMOTJGT2lRcSs3ZXhP?=
 =?utf-8?B?bnJ5eXl0d2U2THAwYWtYSk1Vb1paLzc3T2ZteWRkUnVBT2ZKMDh0OGtkMS9i?=
 =?utf-8?B?aHZhNUFzWm5KTEFFK29YRWRERXMrTjVYbjVVbGR5TGZrODRXeVM3dFFqckJC?=
 =?utf-8?B?US9ZcG1GQ1N6U3lKcTI3ZGtua1NlcjBqZnB5SXVlbHZDYmtXNUU2RmlGVkNI?=
 =?utf-8?B?cGE3bEc1QTdTV0lZendHRFhFRGJJS1Urb1RFNExwMTQ4b2hIb0VQTTRsbmdl?=
 =?utf-8?B?d1hRYmE1dys0VlJrSGtVRFpxRXllekVBVDB2VVFRMG5UZlZYcHhwKzRjNGxz?=
 =?utf-8?B?UzNlQmhTM3lVekZDQUVpMTRBY25IRlQ2ZmlTKyswbFpRbkc2SzBWeVJNVEll?=
 =?utf-8?B?ZmEwTnBnL0cycitOa0IyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZYVmJQTGxkcjZ2ZkpuZVFqbU1zU3VieHRPR2crL05BZ2ZXSzlkWjVDV1FP?=
 =?utf-8?B?NW9RcXhGcnV3R0RqNFovVG5aMGllcjlibnk1d2hzeFRTd1NHTnN0cUVoRjhp?=
 =?utf-8?B?Q01TTjBiL1cyd1E2cENDYU9VOHJCZlo0SldhalhkQnRpVzZMUE53RWU5QlpO?=
 =?utf-8?B?ZkdFd1piaTdrelN5T3VKRlM1VTI2RGp2OHpPZyt4bzlESnpnWkN0VVgzRUEv?=
 =?utf-8?B?dHpmZDFvV3FxSThta0dMcmVaQm1tNWVmVnlNR2VkV2sxaEJKY3pxRitSN2N1?=
 =?utf-8?B?S21ydGo4bGpkSlpHOGNqK3lTU082bmVEdlBFYmVyZlJ4bC9Jc3RVNEpQd00r?=
 =?utf-8?B?bG5GYXhpTEVJZmRWOFQ2dWlsRkU3TWlYUDhMVEh4bFRHeXR3M25CQjE4WnAw?=
 =?utf-8?B?NVRoTENZUXpEQU5vUk9wczhDQkNSQ2tjUGovaVVONHV3QVJwOXRyMmNpZU9B?=
 =?utf-8?B?bzNhN2hVeGJ4Rlh4ejU0ZnFpdnBqbFNyc3RZbUVZdTVsM2NNRUxFS3RMcnhj?=
 =?utf-8?B?cUhpNUNmN2pLWnZGUDY1OHhnaVBiRG52VEl0QmUwQ0szakw0aXVGTFNyNDRM?=
 =?utf-8?B?a0pmWU9PY1FiUElLb2YvVnNqU3F1V215UXpWeW5JamdxNHl0cjN2YzUzQW1m?=
 =?utf-8?B?NXNUbUpOVUVJbktHYW9EWEZrQ0RnZ3k0UUt6R2d4T3NtT0IvcUlrY01MbjV0?=
 =?utf-8?B?bm1zR3JDSUtreTloMDM4R3N2M0JuL1VhQU9HZmc4c01HS0h4SVBrMnVwdkNJ?=
 =?utf-8?B?ZjZVYW92VWtseXJJQ0xWWUdjeUNMM2wyY3RCaXFEaE43QW1pZWpzOHRmQVZr?=
 =?utf-8?B?VmwzTjdRY2UyUjdlckx4YVBTRE9SbFlXdGt6aUZzVlpXbmszY3RWNUExUHZJ?=
 =?utf-8?B?NDIvcGhHY3BnU04veW92Y2s1OHlzRlBJZzJyemdGVjYvSHBxRWxSVmdjd1lP?=
 =?utf-8?B?ejFHY0pZbnhaRkZHU0VmSTNLNFdYamhjMDN1TC9mdVErK1k0YWx0QU1Ca2U1?=
 =?utf-8?B?bW14QlZmTjlsV2NpYzRqS1Rsc3FvZHJhckV4SEJPWmt6MU1aR2J6dlJ5cE8w?=
 =?utf-8?B?UDEyZXBqTm1IUWp2eVNvUlJLZWR5bWpmRjZneTlsVXIzajJpZkZlTWx2Yjd0?=
 =?utf-8?B?d1hZTmZYaDE4S0E0OVBCQ2hZcS91WmlPUXhTNGpUczh3c29LV25HNm9IZC9G?=
 =?utf-8?B?RUFETlBMRENsSFRNR2J2WTVkRVQrMTdLRmpObnNkSmY1eVBvMm5DZ2VFY29G?=
 =?utf-8?B?WS9yYU93eGRMbjRQRndmWUQvWjk1Q0dmZ1J0RkllVmc1Z21IMm9ZaFhYazVI?=
 =?utf-8?B?ak9TYkMwMk53SUdRTGt4TnpqRDIwNDdOeW1NWTU1U1Z6S0NQbmFLMmM0TXNK?=
 =?utf-8?B?ci81KzBuV2NyWnJmZDluZm13eXgwTHJBSE1wcXlaNE1neWRuYjhSR2YzVWQ2?=
 =?utf-8?B?anQvUTVFWVV5SGNGU3JyZG9wdWR5TlFZeHQ4QmZZNzJhbXdSUStXRngxRmR0?=
 =?utf-8?B?Rkc2M1pNZ2hic1VQY25YaWdvaHlFMHFXSlV1dWlWQWdncmRLemk1bWgvdDNz?=
 =?utf-8?B?QmNRT002VWhvb2xxRTZvNHVFZmRBZko4TStBa3dtVEsrMU5taXpzakFiNzhr?=
 =?utf-8?B?akNONG8vd2dKY0xzc003WVN0ZEpwM1k3VUtzb0o5eGVPdm1yZGY2b2JGaEor?=
 =?utf-8?B?RnI3clh4RFBSMit3SVZxT0Iva2ZHamNmaHNWSDhtems1c29sSmNXK25JVENn?=
 =?utf-8?B?dkdMaHI2TStKOGVQVzdyM2ZrdDUwSEVrUkFKSXJHWXUxWHcvZUxVWkFJU2I0?=
 =?utf-8?B?dFBqeWZIVTNiaHUwbFQzeExLWHl2MWlFalN3ZHhhcDl3R3Q2ai80bGpodUxI?=
 =?utf-8?B?Q1NFRVk4aW9IMC9xZU52MkpsT0JiWnZqNjl2Zjk1SXE3M0dMUkNkc05mUVZr?=
 =?utf-8?B?cWJjZWR0RnBnbEg1WW5qWnJreS9kQUhZZG5rOEtiQ1JyKzZFcm9QL01HU3Qy?=
 =?utf-8?B?bndVdzRKVzg0aE1OM05IMDVZYVR2d3BCVjkva2xyb1BjdnE4WEQ1c2EyWERU?=
 =?utf-8?B?L3NWQXZsL3laZXM2d0l2ZThCMGNIbGMycG1aMHlQQ3ZTbXZjTno0Ym5lMHBp?=
 =?utf-8?B?K2RpWWhVcG1ibzFFOFlkQ1hzQy9NbGh1Zk5RRXprSTVvK2RJK0U2WURwR3Q1?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8705542b-2691-4f1c-a448-08dcc0b94f3d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 01:42:11.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsYdH06L7eCXhtCi1uwPZSVUGQEPpDYUordMNhvYZYpCzs3pfz+6PkgohgDKLIy61e7r/FHgMlFPBCgIlYttkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com

hi, Zhu Yanjun,

On Sun, Aug 18, 2024 at 02:24:52PM +0800, Oliver Sang wrote:
> hi, Yanjun.Zhu,
> 
> On Sat, Aug 17, 2024 at 04:46:23PM +0800, Zhu Yanjun wrote:
> > 
> > 在 2024/8/17 1:10, Bart Van Assche 写道:
> > > On 8/16/24 5:49 AM, Zhu Yanjun wrote:
> > > > Hi, kernel test robot
> > > > 
> > > > Please help to make tests with the following commits.
> > > > 
> > > > Please let us know the result.
> > > I don't think that the kernel test robot understands the above request.
> > 
> > Got it. I do not know how to let test robot make tests with this patch.^_^
> 
> we can test the patch for you. just cannot test quickly due to resource
> constraint. will let you know the results in one or two days. thanks

the WARNING is random in our tests. for aee2424246, it shows up 6 times in 20
runs as below table.

the "e0cc1e2cd74a66b5252ea674a26" is just your fix patch.

we run it to 100 times, and the issue doesn't show.

Tested-by: kernel test robot <oliver.sang@intel.com>

a1babdb5b615751e aee2424246f9f1dadc33faa7899 e0cc1e2cd74a66b5252ea674a26
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :20          30%           6:20           0%            :100   dmesg.RIP:check_flush_dependency
           :20          30%           6:20           0%            :100   dmesg.WARNING:at_kernel/workqueue.c:#check_flush_dependency


> 
> > 
> > Follow your advice, I have sent out a patch to rdma maillist. Please review.
> > 
> > Best Regards,
> > 
> > Zhu Yanjun
> > 
> > > 
> > > Thanks,
> > > 
> > > Bart.
> > 
> > -- 
> > Best Regards,
> > Yanjun.Zhu
> > 

