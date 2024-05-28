Return-Path: <linux-rdma+bounces-2635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AFE8D1F3B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7699C1C209AD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938616F8FD;
	Tue, 28 May 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntoVgzX/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6D107A0;
	Tue, 28 May 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907691; cv=fail; b=BZoeZUNG+f5+lkwYrtLqEAqzzJ08G6rN6zyAAXKSUfEVpbDuIJE/m4mTppreSjut9BUsytPdRFVCNFT/GeZC9tB+si7UOkXAJcOhNtDIuVgX2/NFbNS0lwKenaSYyNArlxvfNyMEkzkCDY3QpaWt3xj0My1nbmy/42PLxzA370Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907691; c=relaxed/simple;
	bh=LVTySbcDA1mmGpvvE4JAgw6CVthj1Z2cMTToFFzREhU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Em2QYj8Ys/pCMoas8VPvKBP3DwLOQe9m6tQ12WDL36NGGMj9quujwdHLCEZtFzjpiNAOqczkuGe9pgJTb4CbwcakvEPkq0+H6ue/OSqfsHkj6KTyhRdPA3YdylW8gVC7hTktoAnAuPoqCwFnlGMbkOYFpTGW79qDVJfks4pYhLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntoVgzX/; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716907690; x=1748443690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LVTySbcDA1mmGpvvE4JAgw6CVthj1Z2cMTToFFzREhU=;
  b=ntoVgzX/6I1EfSeUQ2v/qU9tnjVEy+53QLuwdT75XpMj0Q5bYfx9naLW
   RaHeBg/Y6hop93jF/riTlYcELk/NfSnDYwGgENM4ZjNfXz0+28KRKmFKN
   oRdhsafQgby9IzyOea++OGa7JQt4nGUkyTSVl2YaIc7Ja1jmM/fZN4Xi8
   QoL5NO2bEFxDC5x8Ltsi7HsSZbdxIexYfHVeiva0mRAZNH0etFay9B579
   D9ue6FdY3iPgriWt7JUE5i89XuCDEszMWHXFdcLJzIs5+ChZfIDzCgMbC
   JhUoGH7+ExKGxbrbVGo02pSTWjWs8tp1pawr0264rbEhRZduuuV6h4DHo
   A==;
X-CSE-ConnectionGUID: XKFAVfxdRzGCMNkmWfxsDA==
X-CSE-MsgGUID: Nlz6AbGJR0adaVRb+7ISoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13098963"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13098963"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:48:09 -0700
X-CSE-ConnectionGUID: zudUWsQxTwqDgjw86mANvw==
X-CSE-MsgGUID: nMquBLaLSWOCW1KXoexOOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="40058294"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 07:48:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 07:48:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 07:48:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 07:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHsvQTxizStNj9ZvvTz49YK8Nd8X2L5zuhMfpkNsfRwQk+Sg5W/Z/mD+AnTDyCDKBdK3viCF5RMq9rLL9iKYG3Mq4KdSuOUsokuZlXLqwx0y23Sz6+mXxG3DfvpFBTwuSTvOrOc/ipnOq495TzccB7tP1ogRWDdVeq/FFm37e7+j6vLIzpRdwRtCV2EgXKW0WipG+9LiwogR+cUhe01roqjMU8EjFoaPoCMW6Y5tF/ES59MSM0MQGgvlvCrINR1DBut6mkCtk4LS+P6gAX++2UKEupbvB5aLxcjFk4dBKY22/oLCYAKa4IJZpaTo7/ZmPGhBOzRbDupf8mmSqxWlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWuiqkWTxJLohERTjRBTD1GbvZe+hbGDYpyut1H9xYI=;
 b=gJBw7WFhrulK8221jmvdFSnH38s5uR8XQTnyLOtj0Ad9m870+LwKZ9upiJbiQgyKhzcVNwsNsQnGw289lSzXAv9D8HMfnNT1Y3OPSq7jQQQWbOzSB3SwfEyoVoJfjBtTHg9SZWmk1J7T2f2u64v7VGWxnZSOAVaBdbjrvcrfT3kKQ00rvi/b+1tkm/rmDOLEehpmzbLZh70RpqV5KF+mC8k23lqkpwuUYAURv76T5dtDSxjIV58988rf2lUpBuRy01ezATwce0fsuBtkOY8ry1fcm0v0ZNdi7f1rwRzYvKImdp1vxzsKL3/CW8OsCKkSVYTGbpgUW/nAnJREnd0NCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:48:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 14:48:06 +0000
Message-ID: <fb037803-0002-4d91-9c9f-bbb233490acb@intel.com>
Date: Tue, 28 May 2024 16:48:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Expose SFs IRQs
To: Shay Drory <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-3-shayd@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240528091144.112829-3-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:803:50::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 82681d2b-7f1f-47c4-ac04-08dc7f252eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3A1VTZ5bHI2eThzTmpqZ0hHeDhTYWVzd3ZDM2RwTXVtczFKbUF4TnFFMnEy?=
 =?utf-8?B?TEFBajgwUjJlVUFMcE42Y2daWTU4dElGVmpleVpVWHFiQjREQTE4eVRHOTJT?=
 =?utf-8?B?bFRzdmdhS3NkOE1SOUhUZmZnaldFeU1TdVAwWStIKzJOMmJWTmRsY2dkSjJl?=
 =?utf-8?B?YzJFT2hsZTliczE5Tm5lb3BGempua1dSRkJyT0dFYWFjMGZZc1dIbFdZbURq?=
 =?utf-8?B?NGkvcTZhNk45WG04cjI2b1JkNUcxaWxYaEhiOUZkczFXSWtsRktKdVNmS0Vn?=
 =?utf-8?B?dVg1MmJPbkhkdXQ5TTZSK25HckpMUW1DbHdKUzA1empUTmxjN3NxVW1iT0dz?=
 =?utf-8?B?MjhhaFZIUkJqS25ycndEN0JENmR6WUFvOGpSYUgzOUdtYmVlUTZqYmRzMDVr?=
 =?utf-8?B?enB6anV0SHR6QWxtMWhqSDROUFU4cURUeHRGOUxhZFhiRWthcnBWeTdHdXdW?=
 =?utf-8?B?WHNQN1Q2dDhRMXUzZE84QXNRTkp2d3RZZ1dZRk9xZnhQQUdOdyt5OTJtTm9h?=
 =?utf-8?B?RmVjeWF0VjErczcwemFsUGZNOW1zVEo2NHVPT1M3M0tGVGVadlJNbHIrWVdS?=
 =?utf-8?B?blFYVDlNOWxqdFhuRDRXdW1ZQ2t3RWhEQ3ArYkwrL0FqSlB5ZFVKZnBjejVn?=
 =?utf-8?B?MmJLNFJIVmFVY2JOYlFrSnBDcUVJZGVSMXdZT0tPQTE4V213ejY1WkJ5K29y?=
 =?utf-8?B?TTNweVhEWWMvM0tDaU5qNnNtMks0ZHErTE9sbk56TnIwYTd1Ui9QaUF5K29r?=
 =?utf-8?B?SWdBVVI1Wklrenl0RXJRWTJKaU5BMlYwWGZkcEFEa2xMdWc5bzlSakJ2ODds?=
 =?utf-8?B?cllGYkU1Z0pxS2c2SXJiZzMyNFl3Um81VDdNVmpCZXZNcE5RTHJXRkJJcmR6?=
 =?utf-8?B?Vkp0QWFQc1d4RDN2dm5EU1M4VTZUTGF2VU9iZkU2NkFQVWNla2lWL3dLREht?=
 =?utf-8?B?dU9mWGNMQVZmNnkxdDJjbzVkWXdyUmhOdG9BZUc2RGo1RmdXeS9YSTUzRVhQ?=
 =?utf-8?B?ckVuY0pLTWlrUEpEMmxQVm9iVGlRKy93clYvUzFrdk4xT3JVREtoalBZVWtr?=
 =?utf-8?B?RTNKWXJJN2VLajR3V1dpMC8zam1DUlZScmVzeFFJbTZSSkhBOGh6a3AxNWxC?=
 =?utf-8?B?QTFTSDY1b3J6RWNjUnBnWlYzc012c1h5aERnTTZqMVVhY3pqZGhUcS8zOWlK?=
 =?utf-8?B?bHMyQnUrdnpQNW1kRnhsT21pMzFrMEt1VHBlQ05WbkdCRWR1dXdIMVN5WkNQ?=
 =?utf-8?B?ek9BVG1uQXBPWUtsT2JqNmllS0hpcU5pY3BybFNVbzV4SFVobXR0RDNZMDc5?=
 =?utf-8?B?R1NLMkZkRGhDeGRsZXdNeUlGU3NtNmkvdmlnN1c4aVR2V3RxNUhVMkFqSVBY?=
 =?utf-8?B?SHdxQlZQUC9qY3AvM2JwdnVmR00wR2pGY2ZaTmRnVUwzTitRSDdHOU1uKy9i?=
 =?utf-8?B?aXVqeHh5Snhva2djZDE5aUR5b0VrVnN5MHBzZmNqc3UvVWhIZEw5c1R5Yith?=
 =?utf-8?B?NEdwbG83T2hpb0tXZmNEdkhBMFhBOVFQVERKVjlVUk9JVFBKSjlMRmRrczgy?=
 =?utf-8?B?YnFKU3JCQXJpb3FHZS9VVEVNbDNpbjNISis3M0hPWm9DazRLeXZ4VzNxOE1C?=
 =?utf-8?B?TzVqQWpSNG00UG44RUFiZ1JnT25XV3NmYVF6c2pwZmYrYk5EN2k4b3ZRbEpL?=
 =?utf-8?B?NVJSaG5hVklOeUdFSFM1REY2K21qZloxblRKaWVERG54QVVEdWlJYW1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dOeGxQZUx1Nzk4RVdyRlNhTmpQRnc4Snc1blMydllWLzY2NkIvdjR5aXcw?=
 =?utf-8?B?T2F6YkRSdHQ1dTZ5NDdwbDl0Ung3UXV4anBPejBJYkdmS0xEbEFvRVNGUVlD?=
 =?utf-8?B?OFk3bjErT0RDVXdyM1grMVJBa0J4YkhWSEQ0OEkrNW5kMkxGZ25Qa2RGcW1S?=
 =?utf-8?B?Z21Yd21MTGZMRlpKRE5ZWkkwL1lHY2tmN0pGWjVJV1ZlV2pJejJBeTZGQi96?=
 =?utf-8?B?T1NoUldacG9DSHR2dnBhRWhtQmhZRWhhU1NZZDI4NEZIREZxMUl4ZHM1Si8v?=
 =?utf-8?B?dStPR3RXcGJFTERPWkovQThFNk9ZbzQvdW1LV0tMYk9CUTUvQ213ZmR1MmZ1?=
 =?utf-8?B?UzlLUy9ob2xqRFh4S2lVZTV1TjFsU3dTaGJGSTVUTzlFdEpOTG5jcVM1WURE?=
 =?utf-8?B?VWJycng1dzMyVjRhNU5kaThVc3Fzd01hTURWUmYrT1pPbDFSRWE5eFJ4UVpp?=
 =?utf-8?B?QzR3eUNicHdqSW5LdjVlUnlkSjRkQW11MVNlNk42MUdXd0UvR2xlbVNkVlp6?=
 =?utf-8?B?RGc4dWVzUWVMc2RnYXlYT25CU2dyYWNJKzB6VXpKeGxURnpMNCsyRjgxWWdR?=
 =?utf-8?B?R0Z3Z2I1YmpZM05RVWFqdWg5cXVVa0xVRmlTR09iV0UwZVB6ZTI3YU1lcEhi?=
 =?utf-8?B?QTNyNmtTdGtobms5bmlPNFVIcEMzSkVpUTh5NTNTRmVMZFdtNWo0VW12SVBu?=
 =?utf-8?B?RDU5UzJnZ2hCVGRBZ2NHenpncWpjMTdCWUpuU0ZiWDI1cTRvWVM2ajlBRjgz?=
 =?utf-8?B?QXN1UFlxcDk5U285SzcrNEZsZklxaE85L0J1QkVEMStqK1JvN29ndjhpZ09j?=
 =?utf-8?B?ZGRWNWxDcWM1T2FpSkhQQjBVRytSNGhhQUlOelg4Y0ZJV0twaFBDaHlrcE11?=
 =?utf-8?B?SlE5Z1ZnZnREc0lNR2RESTdSSDNyOGYrU0JyelJhRll5bTVzRmJ4WXpHV2Zs?=
 =?utf-8?B?dTJEbWFyRVd6VldpQk9mR3prNnhrWWR3VmFveHBHNDRNbC8vQlc3dlFyOTFz?=
 =?utf-8?B?bjdDMWRDbDlUNTFaL09kak9TL2pZUHI4RFFyaTNwUlZ6OEg3YlZTbHZ3Z1Q2?=
 =?utf-8?B?aHFuSHBvOHhTbmM0d3hQcUtWY2hxM1EzV0xUNkFXc1ZxS1dONHlZa3JET0xC?=
 =?utf-8?B?OE14TVBzMGQyQk11VzJkaVMyNDdVU2ZCelo1WGNtUlVmWHlvbkJVM0hmcVM2?=
 =?utf-8?B?WGpFb05UbXdyRHN3N3hOeVBwaHVUYmRWQmxzdmxJR2hmbVVhMTVOOTNHZTl0?=
 =?utf-8?B?M0Vabk1vWWViMEN2QWdObWY2dG5SdFZQaEt3dlVJbjZjTHFTREhnL1AzVjh3?=
 =?utf-8?B?OFkzY3dEcHBEMkc5cE50bVJRTVlscGJHbFB4Y1EzOXZxbHc2OWdhUHcyMi9y?=
 =?utf-8?B?STdYMzdyUEl1ZjhpaG5iQllaQzkwczFuMTg3dEFXSDNYVUlEMSsybGg0Qmox?=
 =?utf-8?B?N1JZd2c5dmVId3ZVS0wyUWF2R0J1TXBXd21QMjMwWGtYTkQxTkI5c20vazJU?=
 =?utf-8?B?cFBsUzdaaWxYSS9KWUx5VDkxOFRSekZpVkt4Tm5yZEcvUXZnRWttVTlTVHJl?=
 =?utf-8?B?NmlWeGZGZnh5ZEFaYllDUS9iQkNKOVlOM2s5dUFoc3I4UzZ1ZUxUenEzNjdD?=
 =?utf-8?B?dnVFOGZ0WVR5K3lyTHhIb0hDUC9HY2tiRHV1R3BlRFRKUFdHSFdMNERtZFpz?=
 =?utf-8?B?aHUwemtnb2lLK2d3WkhncVZ3N1UvVTlhaU1udXp1WE5vcWpmaG5NZWVCVE9E?=
 =?utf-8?B?ejFRanhMYjVLUnNVY1dJbmVIaXV0RnhvRmJaSS83b0xTTERXeVA0WGUvSmNO?=
 =?utf-8?B?OTYrYVlEbGxMZEZXcXRXNmd3cWN5VnFnbjBIUFBhdndXN3VXem5VcjFVU09Y?=
 =?utf-8?B?dURrK2N2TTk0L0xwM2EwcTlndUh0bnd0L09vNEdTd1g2RTAzbjdWZDhNMFZu?=
 =?utf-8?B?L0t0Njg5aW1XOWVOeVZ4TWwwNGI0T2xtd2VQa0tmZkZYZzY3Z2hLYU9Sb1Vw?=
 =?utf-8?B?bVFNSVd5S3kyamZxcVZjbmJMWXVmc2JXcnNXYmRTN0t2ZER0aFVuOUExSWZX?=
 =?utf-8?B?SVUyRE1Vd012K3JkclZ5Q3VCcUFOVy9FMFV6YlJ5R0J0aXBRN3VpQkZKenE1?=
 =?utf-8?B?TVpWTkxTWE9yZ25BOVE2S2tTZkM4L2I2MWRwTE91UUh4SVdlWmdybUc2T2NO?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82681d2b-7f1f-47c4-ac04-08dc7f252eff
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:48:05.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyMiYOVQrblBIenlF2tfCVf5QLpDmpI5oKTmGR3QHVx1cIYBTm0ctR820fhcbi7BI3AIfcS6BT4Gm9v2lKdwJ6fJmo1UxqYFAyYaGa81k/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
X-OriginatorOrg: intel.com

On 5/28/24 11:11, Shay Drory wrote:
> Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
> These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v2->v3:
> - fix mlx5 sfnum SF sysfs
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c     |  6 +++---
>   .../ethernet/mellanox/mlx5/core/irq_affinity.c   | 15 ++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  6 ++++++
>   .../net/ethernet/mellanox/mlx5/core/mlx5_irq.h   | 12 ++++++++----
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c    | 12 +++++++++---
>   .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 16 +++++++---------
>   6 files changed, 47 insertions(+), 20 deletions(-)
> 

[...]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 612e666ec263..5c36aa3c57e0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -112,15 +112,18 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
>   
>   /**
>    * mlx5_irq_affinity_request - request an IRQ according to the given mask.
> + * @dev: mlx5 core device which is requesting the IRQ.
>    * @pool: IRQ pool to request from.
>    * @af_desc: affinity descriptor for this IRQ.
>    *
>    * This function returns a pointer to IRQ, or ERR_PTR in case of error.
>    */
>   struct mlx5_irq *
> -mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
> +mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
> +			  struct irq_affinity_desc *af_desc)
>   {
>   	struct mlx5_irq *least_loaded_irq, *new_irq;
> +	int ret;
>   
>   	mutex_lock(&pool->lock);
>   	least_loaded_irq = irq_pool_find_least_loaded(pool, &af_desc->mask);
> @@ -152,6 +155,13 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
>   					     mlx5_irq_get_index(least_loaded_irq)), pool->name,
>   			      mlx5_irq_read_locked(least_loaded_irq) / MLX5_EQ_REFS_PER_IRQ);
>   unlock:
> +	if (mlx5_irq_pool_is_sf_pool(pool)) {
> +		ret = auxiliary_device_sysfs_irq_add(mlx5_sf_coredev_to_adev(dev),
> +						     mlx5_irq_get_irq(least_loaded_irq));
> +		if (ret)
> +			mlx5_core_err(dev, "Failed to create sysfs entry for irq %d, ret = %d\n",
> +				      mlx5_irq_get_irq(least_loaded_irq), ret);

you are handling the error by logging a message, then ignoring it
this is clearly not an ERROR, just a WARN or INFO.

> +	}
>   	mutex_unlock(&pool->lock);
>   	return least_loaded_irq;
>   }

[...]

