Return-Path: <linux-rdma+bounces-9417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED9A88868
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B00A7A10BE
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AD288C9C;
	Mon, 14 Apr 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTEjq0Hb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8619D06A;
	Mon, 14 Apr 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647444; cv=fail; b=eBAcMVppSihuh4zEHLvsdJIRIJCQA4S6H0dZpYvk6iCqHGGOvfrZXbliJrzeHPTFRlYl/YgNlhXue4Gnbi87hA8l9KEVzKjFIgL2jEPfFNuE3N/DUpdUQbFCffMr/mzp95vPj4tjOUCRVxnCmqPTvGniamCpZ2uOhYcrZ4vsnFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647444; c=relaxed/simple;
	bh=OSHcua2GO1SQ4E7Nr6IBqsf0VHhNI+4MY+G6d6J34JI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UnJcG/JJQNiOLMhVbl+0n8ibYj0vFegthpUWWzbug4R124zKJ1Usua/C60QRJ7AfNrXV+bOE6esL5fcslgFD5YL96UqVWySPNhc7+KydDyzwB1yEh6llcaE+yncCN++vp9OPVn1hnTxItKf0Ux3mzJVqETKzgBC93TVpiv59J8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTEjq0Hb; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744647443; x=1776183443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OSHcua2GO1SQ4E7Nr6IBqsf0VHhNI+4MY+G6d6J34JI=;
  b=XTEjq0HbRc7xCooHp6E/xe9pTtXwafDiIzRv4fBd8Sf8zVlj1NpFJRja
   D0if/DJzpihIaRyuvdVsvGsT+jRawlllg96HRp8m7Qj/gU7HBKZEO3v9+
   DDGE+Hd3emZCMAC+AohUHKokkRgJ7jnbsQHJW6IpDU8miYeTYFERvdkT/
   HUWk/W8hqUnvFk2gtQqIuWTgiUHY+zxILBh0S8qnCmrcERlU8ypAKd0LT
   xrmMAHY9getj6g6GDMV/XvpHnVQpCNfIiJ7Od5Ab7MIfi9QKwbLhF8CHA
   mluGEuqhJR/WuAvoDPHV76D1eIe7RtWjKH2j/4MRgIT7FAg1xHqSMWesu
   w==;
X-CSE-ConnectionGUID: Bpt1fQjmRiKF/Qq5LxA7KA==
X-CSE-MsgGUID: TGScWmyQQW6FF/il37nY5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="33742712"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="33742712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:17:22 -0700
X-CSE-ConnectionGUID: 4O94GGw2R4G4X4DSzHL5pg==
X-CSE-MsgGUID: ZE4V+I9GTGGVzuGD/Y5nIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130190049"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:17:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 09:17:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 09:17:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 09:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYxuVIo8NTj4apUdsFSIbGk1nXPm2nIzVVN23QI13PH8dz76KN50sXY7W0sFTcveqalVJaEX001HauuLA/kg/uPBzo2Fu1x+EbByaTRS/NjuSwM+mLMg7sBwGwGrDGBDKECV5DJG03ZAmHQbE5KRWq9NHdT/K0sKVt7iZb020qQ2x6YH7usOu9DVgaT+4rHtAoMd3V+AcpSqtQ4+WidKgUMgJrSyFj54G2/EZpu+XuMBqvEJV2MW/f4HRaHtS8C8G4qN5FweLlDdQQN5GX1BbkuEM8H1cj2h0Bi9DOExEpsc9i2LbZRfbZEiG+98XeD269jY/S3Y/v/Kqdvafi2F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSHcua2GO1SQ4E7Nr6IBqsf0VHhNI+4MY+G6d6J34JI=;
 b=Jw/BtbByej5mSB7TmBpxZJm/Ferumw49VqJp7/IZ+2vpoVL2ZddJ6qrXpRJ7w+CaFKKdVfuwsiEh1kEUenT3XcjX8okd7pRG9+p5tJcW69gx7YsaEtdwQY51wt6AB2TO/k/hf7jOjM9LoTlQq0uPQAHHcHjrRPbnZrdWbz9K4Ah0rXHadL89mcfykVNSYkNPdZqlmXARqfB5q6RCz+3/CE7bS0VEwE3tTJ/7H1jmcBfgLqwj+cIyjFWgfbkO2XYHXvOsO158Nvr3XXpeWs4zLvpliT8rJb0yXdUtPA58v9t3GsVPcp92jRYTeTmcpzlJ5nO4WgrXSmdF00TMYXJPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 16:17:04 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:17:04 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>,
	Jeff Johnson <jjohnson@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	<francesco@dolcini.it>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
	"wcn36xx@lists.infradead.org" <wcn36xx@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 0/7] net: Don't use %pK through
 printk
Thread-Topic: [Intel-wired-lan] [PATCH net-next 0/7] net: Don't use %pK
 through printk
Thread-Index: AQHbrVDdxgODR8JZL0+RD7qULj1jv7OjVp9g
Date: Mon, 14 Apr 2025 16:17:04 +0000
Message-ID: <SJ0PR11MB5866CD750C4FE845279F51B2E5B32@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CY8PR11MB7394:EE_
x-ms-office365-filtering-correlation-id: dedd1a1d-d194-4497-4e9c-08dd7b6fcbb1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eldiVDQza05oY2RxSWpBWmRKS0UxOUVCK1lqZCt6cmcvWVpCMHpudFpzeDhS?=
 =?utf-8?B?bmpFeENNS01zRFFZMlhHQ3JHbDhXZzBLS3MyUW05V044bmZNdWRSWWplN2VV?=
 =?utf-8?B?cG5YYnpUTkxUa3FVZ2lCbTAzcDQ4K2tDcTZDaVpCczBVY01ZaUZZUHF4MlhX?=
 =?utf-8?B?NWdseWZFQnFkQXZHK29zTjBVNFF3UWZsZC9RYlExLzQ3RW5yUFZOWUM0TFhR?=
 =?utf-8?B?UmZrMjR4THNvWE9LaXhLZUMvQXUrd095UzBtcDl5N3pZbmNucWkrZXErNlpX?=
 =?utf-8?B?cloyV0RnQit5ckpyYlVHZGNYait4azRJR0s0Y2prUVNMNDFyUGdRZFJiSVBa?=
 =?utf-8?B?RUM3ZXhFNWZ1V295bytLVjlkSnZJZ2FrOEJpNFprSlQvTGt5M0VTUnRoSkth?=
 =?utf-8?B?Q1lyWGNWVGxUSmQ1TTVrUGcwd0NCUTMzV29aYnhhN2FQN1VVaG4vVWZWczF3?=
 =?utf-8?B?ZE1BZlRXMzMrMVBLVkJPQXlDL285cmRGK1VyRzZuemdabEhIczl4QmRkVFVE?=
 =?utf-8?B?ZFNFWGkrSzV4K0JSdDBXa3hRWmdRcmpValVRbFFqN0ZJZ0Mxd0ltNFFzSms2?=
 =?utf-8?B?S0VtNWJPd0FEVlZHd1FrZm1uQkloUXh4RzFKd05HcFlqUk55V3duMytOb0VS?=
 =?utf-8?B?NWc5eER4Q2FGMTdTTkd1OXhudktLamZDeW9TeFQ1MnRvTkFKMnpXcUFTd251?=
 =?utf-8?B?VmxibEQrbFM0eVZIN3hGemFQem90dTB0c2liYVF2SVhYK3I3bGNNdzJOR0ZU?=
 =?utf-8?B?Qnh5RHMzSk5JOEI1WHVFYUtSOU1ZVHdOcVdYcXhSTzZkZHVvMjJmak9rMnBI?=
 =?utf-8?B?YjNFTFowQk1XMUEzMWxmSjlQaUdSRWQyVFBXWWhuMTJTQk5BdzZROE5JZlVt?=
 =?utf-8?B?WlBmQ3RNQUsxRVFIWjRpYVArMnNlMHdOcXRiTDM4TTl0VXo2d0YreGY3WDhL?=
 =?utf-8?B?cFhVZDA5dTZjSlczYzhBS3dIcUxUdGxWS2dQUDlVc1pYUERtQmNrM2E5amVq?=
 =?utf-8?B?VE5VZkpUMmYvdTlyNDBkVUhDNVREeGVzVXRmZ0JrL0kvUGVmTnFPZjk5YlVW?=
 =?utf-8?B?cERxNlFXMldJOFoyZXBpUFhDWmt2UFZGMnNnZTM3U1E4ZjJjRTVnOG9COUtv?=
 =?utf-8?B?aEN4OXFGS2llSWNUdFZOZHZKSlFGUVJUZGJtR0czVjVSUE10MHFHSnZvNHNB?=
 =?utf-8?B?VUd2aUx2cGFWMnpEMzNWKzNldnNObnZHT05JZGNnRlFXV0lISHBJVUpxaVFP?=
 =?utf-8?B?T2NiMHdaVGEvYS9YVTZJOWh4UkhpKzN2ZnE3OERLa1ZSNUNSVTc2M3BSa1Nz?=
 =?utf-8?B?OCtIK0VoTkt1YzAwTVdCM0lzbWlSdm92VjI3K013Y0FCQ0pqY2JTUktZUU92?=
 =?utf-8?B?VkZDdStlYmZMUUFLdm8wcVZ1em1hb1h1d25lcHNhZUhpRlB0eUUvdHpPS3FT?=
 =?utf-8?B?azRTTVRaQzdzTGpMT2FuUkJJUWhZUkVFaGo3SllTNTRCNytsU0ptLzFuVms0?=
 =?utf-8?B?UUZMK0QvNlFSYWgrajBLQVVpdmpOWTMwODk5V3BpOWN0MkdaZW9LbTZSeEVN?=
 =?utf-8?B?VnVlSVJYbzVpUXVhRThKMlptQ2s5TkNBNCsrWkpQZ2tNancvdi9QYkFmZlZJ?=
 =?utf-8?B?dFFYUmttUnA5MU4zaFZNQVdHNDV4U1M1bTkyMjNZNU95VHV6UnE2UklkVmhw?=
 =?utf-8?B?Y1dlU2pxUmlVY0xSRlBNZ0o0Nk1oSEY2Z2hiSHZUNFFJc2tKSTFYQ1RnQ3FK?=
 =?utf-8?B?K3F2ZTc2T21zdjRrc0UxSCtEWEpLYVNMZlVKb3VZZ0VPTmM1N0RGakFEd21C?=
 =?utf-8?B?anAxWFZRZW5SZDkyU3ZZSHB0MlVmbEp2b3ZnY2FmUXRzTmFjbEZwckM3blhz?=
 =?utf-8?B?d0tucWVySHNuaU5VN3l3NVdZdjNMV1lPOHE4NFNwT2MrVDZoeWYwOUt1cTNN?=
 =?utf-8?B?NVd4MHRMYzJSSU9wVmhIUFBDeUJ3b3F0UlloYjhmbVpYMlRPZUdrc3I0OGNF?=
 =?utf-8?Q?JagqH5YCyuFraz0vI6wjO08FpN2+mo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzR4SDdCc0M0WnFPcUZodk1wbGZyNmMvb3lWTzdzckk5bjZlNll6c2p0RitU?=
 =?utf-8?B?TWdEYnJEZmVMTWk4bld2V05oQmlQamxGQlFGbTBKVVgzMGhmUFcxYVhxMUQ5?=
 =?utf-8?B?aSs3RmJGZTdmRFhHS0hWNFdZc1lUczA5eHl6UVMvTGtXdzgvZzUyTDdqRUJ4?=
 =?utf-8?B?M2k5QUQwaUt5Sno4N3dQcnRWNnpkU2FPbzJqeEZpcUxMS3VTejRMRHBnTmJk?=
 =?utf-8?B?Rk9qb3pTRmpEN3l0SGVuSFRJb1Z6ejlIN3ZaYkhVY2FPYmVJN0lGZTloc25l?=
 =?utf-8?B?QWNqZ29FVE9vUmNxZUFaUSt2ZkNTdFo5V2JYaDJmYk1yWFY5WVZ0SVdhK211?=
 =?utf-8?B?Zy96V24rTy96VDhsNUtsUC9PTEtSYXk0ZVhadVFreXV5YnhlTTMwZXRMemZx?=
 =?utf-8?B?TXFLQUk0ZUxHL0tya0ZQUStEcm0rbHZTMm15VmJTV1grZFZSWW5ESFFhWU56?=
 =?utf-8?B?UTFKVFNsc1JPR1d0UExFcXh1bnFEK2d0OXBWOHFMenhDaTN6eEFGY09URVdo?=
 =?utf-8?B?OFVzSm1IVDh5Y1lCUTZocnJMN1czY2hPYmpTcmRJOVU2K0trRHhNRy9KcDEx?=
 =?utf-8?B?SHdPSlFqbm1CWUJnUlByaldBSUlOVmUyQ3pPN2ZkYmF3ZXJFaERLT2JyQWhE?=
 =?utf-8?B?M0lGRUlMbjVFM0xoVGoxTzljUDlYNUR3dER4anFkWDBITEZPa1dsMlBoaGxE?=
 =?utf-8?B?ek1LQ1VuMWNsVkcrWDQ0bzNJUzdnZUh5dEF6Q2Nab0RqVHR2bXFxam5kT3Aw?=
 =?utf-8?B?Umcxb0JqZ1RmSEVaOUFsZVNncUF0S2xiZjJVMzQ4ZFdpQUF1a2dLa09kMWgz?=
 =?utf-8?B?d29hKzYrSm9SaTlEcGdkOFZwVDl4ZzZvMlRIczJlSW5teGE1TDZWVWlFd0tS?=
 =?utf-8?B?dFRZVFpoYVh6NHhBKzFDbG44VDVWeTI1ZDNBcE5jUlRMMmNPNDRabllMSWsv?=
 =?utf-8?B?ZGt0NmxkaXFDU3VXTmtNRk0xbEg3TTdDTUR3VXBEQkEwaUZEMVZkQUdmM3Bj?=
 =?utf-8?B?bTZMVGhaekVCS2pKZ0J3ejczSmdvNDZTeXhkbmVQTFBoYUNSOVdieCs1YkU4?=
 =?utf-8?B?eHo1S1BpT0FZV3pvUXVGeS9FNFAvWkRYYmkvTjdyYStGNENPdVROOFFBRS9h?=
 =?utf-8?B?eDV2RjN4RXJuSStVOW5wODhHamxSczI5a1J4MHh4WXg0encySkpubUhmM3VQ?=
 =?utf-8?B?cVpoZ09oYzljUnBIbWk0VWszOVE2OFBTRmt4OGppOUg0S2pSMzJ6QlM5elVK?=
 =?utf-8?B?WVh5U3E1anJKcUV4WTBhdFJtRmNQWWMyVE9GT25jZG56R1RWWTJNc1ZzMU9P?=
 =?utf-8?B?aHNIajV6YlozMHhuZEpNN0oxVFZWOVluMnp3bkJYVkEyWDduNWpuVVVld05k?=
 =?utf-8?B?RFIzam9jRlJXTU9DMExGOHVsM3BzNk5sT3VDMGs1MTNHNUFjZ1FMUVcrVkEz?=
 =?utf-8?B?SkhCTG1zM3JWMUVnS0MwQklMYks3MTZSRXFDNFZ5QkRHcSsrSUtGYStFbnh0?=
 =?utf-8?B?cG9sd1BXZllCbWQ3dXpOdVYyV0F2L0ZZZUxCTWtxdnVDY1o3c0FsaHV1d1NJ?=
 =?utf-8?B?dEs5NnhuVzlrZUk2bHFpcGpHTlNWdG9RZEUrbXd2MHU1T0dTWkJUZEJQb2M0?=
 =?utf-8?B?VVF5TFhFVmFMZWRrYU1yS1Njdm5iMjE2cTUzZW0zSjUvTXZweHZoTmt5Y1Rz?=
 =?utf-8?B?L0JzUXRPQWFUcml1KzViMmVqaW9FWFpyVjNHVXI2YlBnSFptSFViNzZiM3dn?=
 =?utf-8?B?S2ZqVC9WNDc3V29mN1l1QzNDTjhnVjZxUFJyWFVxVEZKU3h5OVVoNjRrNHYw?=
 =?utf-8?B?QlhQS3RKVzBuZE0xMm41K3FQUWlBR2wvQjJ2dDdMVms4cVkxTWFaUks2Yk5L?=
 =?utf-8?B?S1ZoVFFjMjFWdG9xN25YTGlKaU1WdFRtNDRCZmlLcjA3N3pFbG5Nd3FaNUxJ?=
 =?utf-8?B?dmg5RlRTeVkyUUxiUndWK1cyNnlVR0pqcFcwcTViSVppUGpaam1sNFNGZFhG?=
 =?utf-8?B?YXk2WWlaVVhCd0FhajFKQ3o4U3ZrU2MvUE5la0czTlM3VTFYY0hVZXFrR3I5?=
 =?utf-8?B?Qm51YTRZd0ZqRWF4Ymw2aTByeHZlV21KQ1BqRURCWVpybll0Rm9vblNVT09J?=
 =?utf-8?B?WW83VVN4dTJXM3N4Tk1mKysrQy9zeHMrMmJIVXd4ZG82ZEhmZlp3TlNxb3kv?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedd1a1d-d194-4497-4e9c-08dd7b6fcbb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 16:17:04.5268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+uLADjjiimL8oxwUUMdotvsGAEupwCXOHG4jCNNzOVNFOD74S17JO/X48uZx9bdQjzJM5u41hj1nW0EJiZcCgakFcc1h4KhOmqWEAu/aP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gVGhv
bWFzIFdlacOfc2NodWgNCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNCwgMjAyNSAxMDoyNiBBTQ0K
PiBUbzogSmVmZiBKb2huc29uIDxqam9obnNvbkBrZXJuZWwub3JnPjsgTG9pYyBQb3VsYWluDQo+
IDxsb2ljLnBvdWxhaW5AbGluYXJvLm9yZz47IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hy
b21pdW0ub3JnPjsNCj4gRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3pl
bCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFuZHJldyBM
dW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRh
dmVtbG9mdC5uZXQ+OyBEdW1hemV0LCBFcmljDQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVk
aGF0LmNvbT47IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbnZpZGlhLmNvbT47IExlb24NCj4gUm9t
YW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgVGFyaXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNv
bT4NCj4gQ2M6IGF0aDEwa0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBhdGgxMWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgYXRoMTJrQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IHdjbjM2eHhAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmc7
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0KPiBU
aG9tYXMgV2Vpw59zY2h1aCA8dGhvbWFzLndlaXNzc2NodWhAbGludXRyb25peC5kZT4NCj4gU3Vi
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDAvN10gbmV0OiBEb24ndCB1
c2UgJXBLIHRocm91Z2gNCj4gcHJpbnRrDQo+IA0KPiBJbiB0aGUgcGFzdCAlcEsgd2FzIHByZWZl
cmFibGUgdG8gJXAgYXMgaXQgd291bGQgbm90IGxlYWsgcmF3IHBvaW50ZXIgdmFsdWVzDQo+IGlu
dG8gdGhlIGtlcm5lbCBsb2cuDQo+IFNpbmNlIGNvbW1pdCBhZDY3Yjc0ZDI0NjkgKCJwcmludGs6
IGhhc2ggYWRkcmVzc2VzIHByaW50ZWQgd2l0aCAlcCIpIHRoZQ0KPiByZWd1bGFyICVwIGhhcyBi
ZWVuIGltcHJvdmVkIHRvIGF2b2lkIHRoaXMgaXNzdWUuDQo+IEZ1cnRoZXJtb3JlLCByZXN0cmlj
dGVkIHBvaW50ZXJzICgiJXBLIikgd2VyZSBuZXZlciBtZWFudCB0byBiZSB1c2VkDQo+IHRocm91
Z2ggcHJpbnRrKCkuIFRoZXkgY2FuIHN0aWxsIHVuaW50ZW50aW9uYWxseSBsZWFrIHJhdyBwb2lu
dGVycyBvciBhY3F1aXJlDQo+IHNsZWVwaW5nIGxvb2tzIGluIGF0b21pYyBjb250ZXh0cy4NCj4g
DQo+IFN3aXRjaCB0byB0aGUgcmVndWxhciBwb2ludGVyIGZvcm1hdHRpbmcgd2hpY2ggaXMgc2Fm
ZXIgYW5kIGVhc2llciB0byByZWFzb24NCj4gYWJvdXQuDQo+IFRoZXJlIGFyZSBzdGlsbCBhIGZl
dyB1c2VycyBvZiAlcEsgbGVmdCwgYnV0IHRoZXNlIHVzZSBpdCB0aHJvdWdoIHNlcV9maWxlLCBm
b3INCj4gd2hpY2ggaXRzIHVzYWdlIGlzIHNhZmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9t
YXMgV2Vpw59zY2h1aCA8dGhvbWFzLndlaXNzc2NodWhAbGludXRyb25peC5kZT4NCj4gLS0tDQo+
IFRob21hcyBXZWnDn3NjaHVoICg3KToNCj4gICAgICAgd2lmaTogYXRoMTBrOiBEb24ndCB1c2Ug
JXBLIHRocm91Z2ggcHJpbnRrDQo+ICAgICAgIHdpZmk6IGF0aDExazogRG9uJ3QgdXNlICVwSyB0
aHJvdWdoIHByaW50aw0KPiAgICAgICB3aWZpOiBhdGgxMms6IERvbid0IHVzZSAlcEsgdGhyb3Vn
aCBwcmludGsNCj4gICAgICAgd2lmaTogd2NuMzZ4eDogRG9uJ3QgdXNlICVwSyB0aHJvdWdoIHBy
aW50aw0KPiAgICAgICB3aWZpOiBtd2lmaWV4OiBEb24ndCB1c2UgJXBLIHRocm91Z2ggcHJpbnRr
DQo+ICAgICAgIGljZTogRG9uJ3QgdXNlICVwSyB0aHJvdWdoIHByaW50ayBvciB0cmFjZXBvaW50
cw0KPiAgICAgICBuZXQvbWx4NTogRG9uJ3QgdXNlICVwSyB0aHJvdWdoIHRyYWNlcG9pbnRzDQo+
IA0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9tYWluLmMgICAgICAgICAg
fCAgMiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV90cmFjZS5oICAg
ICAgICAgfCAxMCArKysrKy0tLS0tDQo+ICAuLi4vbWx4NS9jb3JlL3NmL2Rldi9kaWFnL2Rldl90
cmFjZXBvaW50LmggICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgv
YXRoMTBrL2FoYi5jICAgICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9hdGgvYXRoMTBrL2JtaS5jICAgICAgICAgICAgICB8ICA2ICsrKy0tLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvYXRoL2F0aDEway9jZS5jICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+ICBk
cml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL2NvcmUuYyAgICAgICAgICAgICB8ICA0ICsr
LS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvaHRjLmMgICAgICAgICAgICAg
IHwgIDYgKysrLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL2h0dF9yeC5j
ICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL21h
Yy5jICAgICAgICAgICAgICB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvcGNpLmMgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvdGVzdG1vZGUuYyAgICAgICAgIHwgIDQgKyst
LQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway90eHJ4LmMgICAgICAgICAgICAg
fCAgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway91c2IuYyAgICAgICAg
ICAgICAgfCAgNCArKy0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL3dtaS5j
ICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgx
MWsvdGVzdG1vZGUuYyAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0
aC9hdGgxMmsvdGVzdG1vZGUuYyAgICAgICAgIHwgIDQgKystLQ0KPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYXRoL3djbjM2eHgvdGVzdG1vZGUuYyAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L3BjaWUuYyAgICAgICAgfCAgMiArLQ0KPiAgMTkg
ZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQo+IC0tLQ0K
PiBiYXNlLWNvbW1pdDogOGZmZDAxNWRiODVmZWEzZTE1YTc3MDI3ZmRhNmMwMmNlZDRkMjQ0NA0K
PiBjaGFuZ2UtaWQ6IDIwMjUwNDA0LXJlc3RyaWN0ZWQtcG9pbnRlcnMtbmV0LWE4Y2RkZDAzZTVk
MQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBUaG9tYXMgV2Vpw59zY2h1aCA8dGhvbWFz
LndlaXNzc2NodWhAbGludXRyb25peC5kZT4NClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlv
bm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

