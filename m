Return-Path: <linux-rdma+bounces-2307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6771F8BDCFC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 10:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECEE2857DE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E13713C8F7;
	Tue,  7 May 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQQ/jd+f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7713C8EC;
	Tue,  7 May 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069590; cv=fail; b=KAZnMSzX3q6qXAc2xswK31/5Z0IOFPgm2FniW5YJpQg88D17A+JKQcHE33UvYOCgq/exqnoFhPT4Hjx1G627lBruQHhqfhmUXfI1W6+1OVam6e0jyYzq3/CcN9lM+jp4vyjwDPYq/JHjDjrCnPxz6qRgvwk7c6EX53ZaX0Dlono=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069590; c=relaxed/simple;
	bh=f3mZQlJTqHcnhVpVAmxssSrkfwZ9rNeR8ONvFlGkEUM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k2rOIOrqC7zzQIeKMn2j0VyIIqvT6TPMpM6CuwM9en0CmE0RLhBnBWfe+8kZMqdWc5z+NnW5rEetEMJIJgddzGP1hraFpzOvOT1H61hOsuigd5zNlu9gIZ+5kj/KkwFOt32SWSCVt9rUMYyxAiGvKRhnGdOFgc+duWb1lLyDcxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQQ/jd+f; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715069588; x=1746605588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f3mZQlJTqHcnhVpVAmxssSrkfwZ9rNeR8ONvFlGkEUM=;
  b=dQQ/jd+ffRzhnVDRA3PCajRAeh1QKxdGsCZwmX6lj0pQFJxzD3q24tAu
   vi/pIwpkn5yBkpXtyod4EnuY0szMAb4E5Nt33PwrCy5UTzKkar2K3sLHj
   Tt3i7f4MMzBHpmLj7M9az9KwPpH7g6Vwi4axeFdP3s+tzRKMSAJSXuMAw
   CaMQsYJFNJFTgLaNzqr9kvOouMbs+8pbbR0dAqht9uXVEX3H3m4S2BUHr
   mzENAb2RYgcnNY8cEr50iywKygXy3v8vuo7LnDQc6vZACuTdgGGHB0+cH
   kbufC6GxudRxqV5UyddV2em1c8WLBmhNzaUkxWKwV5kQApNFBTYQYUQQE
   A==;
X-CSE-ConnectionGUID: qXYDh5rtQQmizeF6QJ9h+g==
X-CSE-MsgGUID: TOiY13/YRHqSIrak4ARjVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10731655"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10731655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 01:13:07 -0700
X-CSE-ConnectionGUID: HxHihhD4R8WLXSPmeC9xZw==
X-CSE-MsgGUID: zbYXG4GNTOuTGrtKqWTlBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28539142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 01:13:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 01:13:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 01:13:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 01:13:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 01:13:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvKlCmdF5pzqG76NG4NRMGu7ii40nu1lNqVUB9aCIYt1U5iO+mXxkzx4gbMLXtQc06sGVqVhca0iTr6ZUJS/UXajNhG1e99H9lEWGJ3YGhGcCrlGiV24/OzWezrKEnlUzCQdyGwpq3JhTPjuupt9mBWCM/dYdBJMQY4qJntIB38iih3QWYIDzMlB/utiWiOXgtZxeg+qG+NwjcXn9maoWJJYa3mqY1zXG0cI664zoTaXuwbfW1USau86YsU3fRLAp8EDPFIrL0kzDRe4s+qZNcZ0pQcyrMra1lkPHc5qIhevEgOTeKNeWNU2PcCjmeRugOPrQ+NiXhV8G/s1m1ixVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evbYuO6jqbk6+g4Gbuqd/PJvObWyWqonfrLBlXxF5Sc=;
 b=NNgOOyyikER/PqJb4vZPnbJH06LYjXNETwGjK91qPPLArnCgU9bxs66nOBWR6sozrIJyLXAtdZTZLwq/lxZWWqV66qrgsjgxUD5lItkxUw0serT32JyYDZjvgK4ZWTrfSpLwCVzET5q9oN5VeZGFKCxmIyPdjmDXCRJptZtpQfFUypiYeSYsps8ZAOLsFC1EJp7jXc0tqxjLh4UQCm97aCtzYkN6DG5yXSYnjLlzzbBrzcvld/3wY7w7Avl5Zi3hP1b87KY6eAI+qxFViUTYMaCfjIsifx1XST+fj+WxxAe98C8DpkDMXUB5GiJCgn3XOn2DcoIWolAnsW/Uy3Avbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 08:13:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 08:13:04 +0000
Message-ID: <14f913ce-d041-4960-9379-886a0c7fc106@intel.com>
Date: Tue, 7 May 2024 10:12:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Content-Language: en-US
To: Shay Drory <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240505145318.398135-1-shayd@nvidia.com>
 <20240505145318.398135-2-shayd@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240505145318.398135-2-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: af11abf3-58a7-4b94-f26d-08dc6e6d84d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0dTdkQzdUkzbzdrNHR4Um1sZEtqY0orY1plUU8rWTJBQ0xKMG03UWpmVDlp?=
 =?utf-8?B?akdZSjRtTXVDMzR3dzJhSE9za1pKSzhXem9zaURYelBSbmZ5ODZpemoyNHJE?=
 =?utf-8?B?bDdOM0xUdXo0Tm53THhoUUFsN1JzQ0hodVgzMnpqTnRybkg1Rmtnbk9Hb2Jk?=
 =?utf-8?B?NTNoTm5hSElURXQ0UCs3NEhZb1JEZlFERVh0dy90ZVF3R3F1R2RRNGtzSGwv?=
 =?utf-8?B?NkxUWkpEaUFOd1NheW9zZE9VMGVNRXRFcCtGS3VVUUw2eXRTeFlxMEt0T0Er?=
 =?utf-8?B?S0ZYcW9Hc3h5bjFaUGdDcnUxRE5GY3ZuZW42cUFmaVRWSEFkZVlmSkpiYmZu?=
 =?utf-8?B?UmROZUVOS2FaRzAyRUg1ZmR4MWFJUWlzdTh1T05qOE4yRGhudDFTelRja21H?=
 =?utf-8?B?c3NzZmE0R25yZloySkpHQVg1a1VkeXZhZFYvMVFNWEJaSUh6RzNIbEZ6dGNU?=
 =?utf-8?B?RmZuck5oSUZvNks2Z05sOUlvYnYrUlgxY2hwM0cvTmx1R2x4SjhZZGNsYWEz?=
 =?utf-8?B?VDYyMnpiWHNuVkRRcDZ3ZE1Dcm5BZUZ0ank5RFpReGI3UDVpczVBYUNTOXJj?=
 =?utf-8?B?dmNNZmJpVUxVcTMyRW9USXE4ZmE3SllaQWJlMmlrK1V2dDhtYWlxZGNMQWZu?=
 =?utf-8?B?TThhbTZQWnIxVGZWRUoyaitWZlZxb2pFVFc2SFVJS09ua3kwczJoVzhBSm82?=
 =?utf-8?B?aEJ3Q25ueFJSb2hUa28xUFE5RmZKVFVCdWFKbmxWNmgyVUlzVHpjK3VDS0J5?=
 =?utf-8?B?QmZTeklMM0FqRlpLVmFHM29sU1E3Y1JXQ2l4ZXdEQmNZRmhyRDVKZ3B5T3Jz?=
 =?utf-8?B?WmIwWXlQZ0ZZUjZzeFZVR0lXeFBPUVIwVE1tWWI1b0ZiWHVYdDRRL3RVSDhv?=
 =?utf-8?B?ZXp1Z24vaFZXa284VXovcmZTM3owVlJSZENsWEZXL2tpZytPZlVGMlJVcGRj?=
 =?utf-8?B?WmlDaHlxL3FQaVg0OXNiTFdKLzBBZFVSRzFrMkx0T2VSVWNQamVuT1NPYkdL?=
 =?utf-8?B?L0NLdFB2Y09id1lLamFDM05TYURCRHNLVTdoUDZMbGtpaFh0QzNlU0xKY1Nr?=
 =?utf-8?B?Q0QrYUFWL0V5MS84ajc3Qlk0QXgxYXVpZzNvWTlvZnp5eFRVSDhqS3B3V1JZ?=
 =?utf-8?B?ekh6cElyWmpOUUJtMjBzRnpjakUvM2VNeHU0RlJhRjVnajhyc3lCcjVKb3pV?=
 =?utf-8?B?dEZQdTFPeEUyeTNlVjhrUU1LSHI4VzNBeGRBV0g5c25FQ3ltejNUcWhCMkJE?=
 =?utf-8?B?dXJlZHpSa2cyRTJmNFpua3hHUWRGYUdqdGxhcXFQRmRDSGJ1cFpoWkt4dW9v?=
 =?utf-8?B?U2Q4b2dTa3VKMmpma28yekhGRGQwUWw4M2F4bExsNk1wNzRzQlM2VTd2RXBD?=
 =?utf-8?B?THAvUTdoWTVOOGQrSzRTMEJrMjRXRzNHei8vR2x2Tmo1NnltMlI4UTJTMTkv?=
 =?utf-8?B?eG9nekZ4aFpJOHNSVFRaNko2cWMvcXR1UnZPK0RvcEwrOVRzc1pWaVVLK3Er?=
 =?utf-8?B?c2ZjZ2pPRlYyV25Vd1ZxZUpRbkhnWUxVSXVCTnhRaGRKS2VqaTVWRm5qcTNo?=
 =?utf-8?B?b3d6akdsOCtiMFdLNklkelJNcG5vLzM4WUNZazZCRmpuOHp1ejRObTZWNi9H?=
 =?utf-8?B?TVVleUlMWlVpcUsyN2hTblFESVAxQnZIV01JVnRLVWJWR3NXOE0vWDlWQnF2?=
 =?utf-8?B?ZlVKQWN3b05IZFhtZEJVb1NjR0tpQ2RIWCtlU2JVSXRqbjlFcDZvN1NRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjVSdlJhUWZNdGRLK2czQTFoVWtKQ29ZZkJGZjJHU0ZySy9wQnJ5ZmZwTGps?=
 =?utf-8?B?ZGtJUWFZWEcyQUxVWHk3ZUVzTzg3MmxHZS9mM291OUpGdWtpUWtiT2UxV2NM?=
 =?utf-8?B?MFpJa3FISlZReDZURFpYNlhWdHZoZmZxenI1eGhsSzBETjIzNTV6Z2FUaVpk?=
 =?utf-8?B?cm9QTU81NU5xTnE4YkxJTzZCSkl6bGQ2cm1XTFR3emRBbDhHTnVPZkcvaGpP?=
 =?utf-8?B?RDFRc3FsYWVHQVlWUlJab3p0c0JUSG5MUWxrdXVqTVdITnFFOU9qY0VTMG5h?=
 =?utf-8?B?aTQ2cjhlMzhhOFY4bGFvS1pOdXVPellYbXNlYk9LeGJpMTZlR08xSllubW4r?=
 =?utf-8?B?YWsvQjNqQmZsNVJJMDlBRGRFRUo0cVNHWFFHNXR0Q0o3blFwNFhvd2pQWnVR?=
 =?utf-8?B?c0hqSlMxTE1QdW9ONGNYS25lTk14d0hWZjkyeU5qS0RoU0pIMkNQS1NCL2Er?=
 =?utf-8?B?SGhIVzhOeEcvVGtabEhTbCtsWnpLdzZWZngzZFVmYmh1NnBuc3lQaFVCK3pZ?=
 =?utf-8?B?ZHlSRGRibHpUaHVIUVphNzRDNjRWcW1FY0d6YkdLOVozOFhhZ0t1eDRYSWhi?=
 =?utf-8?B?QmUwN2tRK2NrQmRsc1lEYUtqL2ZvMWJYVytUNjI2dkd2OW9VTmM4TS9PUEgr?=
 =?utf-8?B?ait1WEVVN1N6WTUwOEpwWnlseXdLd20rU1k5SjdzUEgxaWwraXFmRk1mWkFX?=
 =?utf-8?B?RGV5NXl6OWtsUXFLUStFcUJSK1ZUR3A3a0hTZHBtU3FpWE9QQWxxMGNJZTJs?=
 =?utf-8?B?a3FpelFaZm14d3Z5akpybXJuelArazFrVlRYaHo4NFRwMHlHVTJ5UEhVYW9o?=
 =?utf-8?B?RFVWaUpHSkhkcWpBSndsUjNLN2pDS0VxVS9MY0lSTVMwc2NtUk1yMmhrT3pC?=
 =?utf-8?B?cXNjQUpYM0hLZ2lCamR0T2dMYlFBUS81NXAweFhpcFl5R1RNSEJpV2twamhL?=
 =?utf-8?B?ajMybXZPUnI1cDVHNEFhRzJ4aFVXMUpqdXFMN2h2MlFMRlJZYlk1cXhRSTVI?=
 =?utf-8?B?c0FRT1pTZ1ZVcHlaOHUwQ3FmaFZjRlArTWl1ekV2Wm11WlczWnBnVUkxcWtz?=
 =?utf-8?B?c1owdGd2VVNhY1Q4NUM4eEpWSC93b2J0MFU0bXF4KzRQUHRJRFJzK2JKa0d1?=
 =?utf-8?B?SStpMnhXc3YybVVWYytxOTZuM1JrdEVTMEo5TDlaWW1NNW8yanZSaFRTTXky?=
 =?utf-8?B?WE53RG85U0Y3OWI1a3VIWW9oMVRGYncwZ25XSll1M3kwR0NNajdXdEVrU3hT?=
 =?utf-8?B?MTRXUDEwUmFOY3lyUDBPZHcvMDN0Y1gzeFdKZ3V2bFh0QTlEcW5RQk8vbG5C?=
 =?utf-8?B?a0lrSUd2VHJHN1RXTFR6Z0hvRllWMFBLTCtyK3o3Z1RzVHJ6OENOQzZaN1k0?=
 =?utf-8?B?bGEvQ3NtcXR0VTZ1WU5pY0RsN0gxUkliRUh6NVhVMG43eGlyUkp2MDRqbVBN?=
 =?utf-8?B?eDl2ZWdJRlFGY2w5aExWbXViTUtiUjFLaTc3MEF4d3hIRklIeWhjSG5tU2sr?=
 =?utf-8?B?SmxLUC9Oc28wQlJERzJ2Q0VzSEJjTVFMTkhwVFJSZHM0c3oxdFQyS0tMRW0v?=
 =?utf-8?B?VkhtU2VRVEpBL1VyZ2NMeWRNKzgxb1B5TXVLSDNZMnd1ejk2RkFOVWVWbHB3?=
 =?utf-8?B?TDlvZUwxVFVXcXY4NDk5NjREYmNsVmdsVW9ISENVMEY0WVU4WkpNTkxpc3hE?=
 =?utf-8?B?M3phRy80amNQVlZDS09Ba2hiMlU5UkJ6SEs2dndlaDduY2FhN3VjNkx4UG5h?=
 =?utf-8?B?MzlHZHpjQWJuMUR6d2lhYTJpdWJtcTQ5M0JId3o0K2ZERC9PVHlkeWpJU0Vv?=
 =?utf-8?B?Z0tBVWpaRFhiVGN2NWVKWUl0RzdTWXJ2eVd5MHhiSm5sbGwvY1AveHQvSVBl?=
 =?utf-8?B?WjhXY2EvdWtFcmk4YWFGR3R0UU4zYmFOL2FiajdFV2tTd2t5UllKY1YzOUJu?=
 =?utf-8?B?b2ZNY2t1eVlDcm9mRVc5TCt0Rlhjck1vc0pabmtkbzVtbHUwZElpT2JjQ0Jy?=
 =?utf-8?B?Y1dYME81MWhrV09aK0xZTjNtNDR3eTBvY2FZcU1SOCtZMjFuN0I0MitNQVp1?=
 =?utf-8?B?TFZvUmRXaEV5VHJBZlFidXNBenJDWE14TTh5R0RuNWcwSndaSld6YndhcTJa?=
 =?utf-8?B?cHQyb29aK05GQTlDQ21yUGNpU3NHVGVmck1BaWUwRUIxRS9DZUNFanJzS0la?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af11abf3-58a7-4b94-f26d-08dc6e6d84d4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 08:13:04.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdvvHB4btrE2BiYv92yZO2lLIG2XC2zbHqP0zcZ97iZYmvieUo+fc/SFnnXtn086jjprhlVrRWJ5fOyZQ+mRdYAQ1JCn/9hTP+Fzjkx8TH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
X-OriginatorOrg: intel.com

On 5/5/24 16:53, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus;  the irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing file for each irq entry. However, for PCI SFs such information
> is unavailable. Due to this users have no visibility on IRQs used by the
> SFs.
> Secondly, an SF is a multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
> information is also not available to the users. To overcome this
> limitation, each irq sysfs entry shows if irq is exclusive or shared.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
> exclusive
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v1->v2:
> - move #ifdefs from drivers/base/auxiliary.c to
>    include/linux/auxiliary_bus.h (Greg)
> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
> - Fix auxiliary_irq_mode_show doc (kernel test boot)
> ---
>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>   drivers/base/auxiliary.c                      | 167 +++++++++++++++++-
>   include/linux/auxiliary_bus.h                 |  20 ++-
>   3 files changed, 198 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
> new file mode 100644
> index 000000000000..3b8299d49d9e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
> @@ -0,0 +1,14 @@
> +What:		/sys/bus/auxiliary/devices/.../irqs/
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		The /sys/devices/.../irqs directory contains a variable set of
> +		files, with each file is named as irq number similar to PCI PF
> +		or VF's irq number located in msi_irqs directory.
> +
> +What:		/sys/bus/auxiliary/devices/.../irqs/<N>
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		auxiliary devices can share IRQs. This attribute indicates if
> +		the irq is shared with other SFs or exclusively used by the SF.
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..43d12a147f1f 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -158,6 +158,164 @@
>    *	};
>    */
>   
> +#ifdef CONFIG_SYSFS
> +/* Xarray of irqs to determine if irq is exclusive or shared. */
> +static DEFINE_XARRAY(irqs);
> +/* Protects insertions into the irtqs xarray. */
> +static DEFINE_MUTEX(irqs_lock);
> +
> +struct auxiliary_irq_info {
> +	struct device_attribute sysfs_attr;
> +	int irq;
> +};
> +
> +static struct attribute *auxiliary_irq_attrs[] = {
> +	NULL
> +};
> +
> +static const struct attribute_group auxiliary_irqs_group = {
> +	.name = "irqs",
> +	.attrs = auxiliary_irq_attrs,
> +};
> +
> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
> + * shared or exclusive.
> + */
> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct auxiliary_irq_info *info =
> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> +
> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> +		return sysfs_emit(buf, "%s\n", "shared");
> +	else
> +		return sysfs_emit(buf, "%s\n", "exclusive");
> +}
> +
> +static void auxiliary_irq_destroy(int irq)
> +{
> +	refcount_t *ref;
> +
> +	xa_lock(&irqs);
> +	ref = xa_load(&irqs, irq);
> +	if (refcount_dec_and_test(ref)) {
> +		__xa_erase(&irqs, irq);
> +		kfree(ref);
> +	}
> +	xa_unlock(&irqs);
> +}
> +
> +static int auxiliary_irq_create(int irq)
> +{
> +	refcount_t *ref;
> +	int ret = 0;
> +
> +	mutex_lock(&irqs_lock);
> +	ref = xa_load(&irqs, irq);
> +	if (ref && refcount_inc_not_zero(ref))
> +		goto out;
> +
> +	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> +	if (!ref) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	refcount_set(ref, 1);
> +	ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
> +	if (ret)
> +		kfree(ref);
> +
> +out:
> +	mutex_unlock(&irqs_lock);
> +	return ret;
> +}
> +
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated Linux interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.

s/received/registered/?

> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct auxiliary_irq_info *info;
> +	int ret;
> +
> +	ret = auxiliary_irq_create(irq);
> +	if (ret)
> +		return ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto info_err;
> +	}
> +
> +	sysfs_attr_init(&info->sysfs_attr.attr);
> +	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
> +	if (!info->sysfs_attr.attr.name) {
> +		ret = -ENOMEM;
> +		goto name_err;
> +	}
> +	info->irq = irq;
> +	info->sysfs_attr.attr.mode = 0444;
> +	info->sysfs_attr.show = auxiliary_irq_mode_show;
> +
> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> +	if (ret)
> +		goto auxdev_xa_err;
> +
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);
> +	if (ret)
> +		goto sysfs_add_err;
> +
> +	return 0;
> +
> +sysfs_add_err:
> +	xa_erase(&auxdev->irqs, irq);
> +auxdev_xa_err:
> +	kfree(info->sysfs_attr.attr.name);
> +name_err:
> +	kfree(info);
> +info_err:
> +	auxiliary_irq_destroy(irq);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
> +
> +/**
> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: the IRQ to remove.
> + *
> + * This function should be called to remove an IRQ sysfs entry.
> + */
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)

(not an issue, just a question)
do you need to select IRQ to remove? ...

> +{
> +	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
> +	struct device *dev = &auxdev->dev;
> +
> +	if (WARN_ON(!info))
> +		return;
> +
> +	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
> +				     auxiliary_irqs_group.name);

... because there is an option to remove whole group at once

> +	xa_erase(&auxdev->irqs, irq);
> +	kfree(info->sysfs_attr.attr.name);
> +	kfree(info);
> +	auxiliary_irq_destroy(irq);
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
> +#endif
> +
>   static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>   							    const struct auxiliary_device *auxdev)
>   {
> @@ -295,6 +453,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>    * __auxiliary_device_add - add an auxiliary bus device
>    * @auxdev: auxiliary bus device to add to the bus
>    * @modname: name of the parent device's driver module
> + * @irqs_sysfs_enable: whether to enable IRQs sysfs
>    *
>    * This is the third step in the three-step process to register an
>    * auxiliary_device.
> @@ -310,7 +469,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>    * parameter.  Only if a user requires a custom name would this version be
>    * called directly.
>    */
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable)
>   {
>   	struct device *dev = &auxdev->dev;
>   	int ret;
> @@ -325,6 +485,11 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
>   		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
>   		return ret;
>   	}
> +	if (irqs_sysfs_enable) {
> +		auxdev->groups[0] = &auxiliary_irqs_group;

I would remove this array ...

> +		xa_init(&auxdev->irqs);
> +		dev->groups = auxdev->groups;

... and use &auxiliary_irqs_group directly here
(you will need to change it to 2 elem array though)

> +	}
>   
>   	ret = device_add(dev);
>   	if (ret)
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index de21d9d24a95..fe2c438c0217 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,9 @@
>    *       in
>    * @name: Match name found by the auxiliary device driver,
>    * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,
> + * @groups: first group is for irqs sysfs directory; it is a NULL terminated
> + *          array,
>    *
>    * An auxiliary_device represents a part of its parent device's functionality.
>    * It is given a name that, combined with the registering drivers
> @@ -138,6 +141,8 @@
>   struct auxiliary_device {
>   	struct device dev;
>   	const char *name;
> +	struct xarray irqs;
> +	const struct attribute_group *groups[2];
>   	u32 id;
>   };
>   
> @@ -209,8 +214,19 @@ static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *dr
>   }
>   
>   int auxiliary_device_init(struct auxiliary_device *auxdev);
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable);
> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME, false)
> +#define auxiliary_device_add_with_irqs(auxdev) \
> +	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
> +
> +#ifdef CONFIG_SYSFS
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq);
> +#else /* CONFIG_SYSFS */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq) {return 0; }
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
> +#endif
>   
>   static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
>   {


