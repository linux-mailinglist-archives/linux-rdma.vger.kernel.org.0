Return-Path: <linux-rdma+bounces-3562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E591BF80
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749CC1F23993
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF41BE845;
	Fri, 28 Jun 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QO5j1wTy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186B154434;
	Fri, 28 Jun 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581342; cv=fail; b=XVimTbmuHKQAbGwT7Tsfa5y2HLtZvhZ9hC80s3uF8FqF1I5ce3MSBOtgnJ/CKErhvAhkDh6KJOWxL2Lma2zp6Ts7D0FaDrhEiECmOqSld21UISkuNUiYSNHyUmcnxqt5hpDTubi2DHiVARZFjExP6cniOmNd3k6usbb1e9dGsrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581342; c=relaxed/simple;
	bh=im8XudaYaWpY1lpUfU3oBSFNlfrTx5dKtNqMCze/UJU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jr7oaMxaceFHX0RfNio6o99X1zCNq6TjfolrYa/JDNJSZrXsYIQH0AXcANzpj8LIZ65xOHAUvCJv3QdISHlplDSuK5Jt2aPJzutmcXTZVGNkGBkI1gWeUXoiwkNRN8Z5PWV6M6JnZtRZ6rvtBLX1D9ktQQM0vAuqypupLZ1e1pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QO5j1wTy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719581341; x=1751117341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=im8XudaYaWpY1lpUfU3oBSFNlfrTx5dKtNqMCze/UJU=;
  b=QO5j1wTy0MgQuGUJ6YRzT5nl8eXGX7m2h7OnyqJT+9unbZ6AKCeiZQg+
   GXSzaMUYPnkOdZeMhb6TVJWEbhAKrsJYAdeCaTCb02SPYezs2U+5QMSuI
   Spbm3roOqzHIbfMPrcPIdInE7RDGL0dkrLK7ZK/MBvwVX2TF6mGcLgpWa
   pp81ouimp5YNw04JkYtps+Se4Aizx1ypRdr9NrLmMtUouI6osojW2XSjx
   OkguCsUcOUeU31xTHdmHz4JUqQm1fcqSuVo1DnaHUMnWUtiF6UAF0HWJQ
   k6YSLCRyq1z8780HFtBLj6xgoD0sQ7YVwpYHzOnWt9EVad0JimS+nfMkm
   g==;
X-CSE-ConnectionGUID: FHJSCcaaTR+KfMEQPty4KQ==
X-CSE-MsgGUID: NvoKosVUQG+srTKminl1qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16502125"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16502125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 06:28:59 -0700
X-CSE-ConnectionGUID: 5wganImqS1mjKaN/VuSyGg==
X-CSE-MsgGUID: hq7fWJAtSyuRi8lHuMSn+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49083173"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 06:29:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 06:28:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 06:28:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 06:28:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 06:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmN1pebUagr2dZlOL7+fbBcDbomCyy6RFY2xS2GS6IENKo42FQwqnq3/9qEI/TuodXY7Ju0qPOTLEJ2aYZZZE9oHrhA6YcQFQfVB+Y2AJnkmvOv/jvirgW3HbImUMNubKL0aPOlMlfHp+AC/0bGBqaUqLS1CJEgH7Z3PWzj6JoCpAMxTuu4cvJadJVlnWWikCy/ArGy/YXRw8IxSg10fjObxSuPSjSvwy2I7qYyW6Si9td0wGStS4MsSZX0jzxUrmtfF+IRwEfaCXlTzZUF6yjiAAxkY6HEznwqryRC4snWe9m1ePVutGY2ZQVfT7fFnH3LN7va2d2VpQzTaDvettA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr9fysjCnWKhN3s12tv4KjhgHbquYODsK2RIh1WczVM=;
 b=h/m4RopfIz7O+POljl+mmwvuZwJW7IYNkEC2OrPimo+PwX29Fgl3gMQrlRSI3UUowok30tQs3FVPMqCH/lBkQT1hF5dKVXIlQc3Z/zyRJTpatFNSHMBXuFhraA6Bqrh+zoUatlLPp8sYFI/PljLBUDzFilgi7uik5BPxnD/zsy8P1xkaGfoRGxPoFiPxdxGbkyRfoL6LiTXQ3alJtJp4MaUCLdXNn7jBLFdSdLzYR/mNs56DlaFbF8TM1xaLq0J1j5AgMXuQbXu4U+3uiveAXMooaRNN7tH6MnlFJNUTXL4bc7OmzWGrCBbACKGhSQPYsnGdjBT4uRK+vy/WINXZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Fri, 28 Jun
 2024 13:28:49 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 13:28:48 +0000
Message-ID: <3b4c5adf-6b03-4c49-9130-83bee25d2cd0@intel.com>
Date: Fri, 28 Jun 2024 15:28:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] COVER LETTER: Introduce auxiliary bus
 IRQs sysfs
To: Shay Drory <shayd@nvidia.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
References: <20240627143810.805224-1-shayd@nvidia.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240627143810.805224-1-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: bd88c8e7-e38f-447d-90b1-08dc97763e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEhJTE9PM2pKa1RwRk5Sc2R3VU54eW9hdEZDNWNQeXBBWEpnUjhobHRnQ3Y5?=
 =?utf-8?B?SER4VTBESkJLcktaVXZRWkJSRGhpOHFBQWo5ZWpQZXIrdmNjQTlVaFJnQjgw?=
 =?utf-8?B?QVlBRlRFUXBpU2hrR3BYenJXa21FR0tzZlUvUTNwLy9ROFhGbS9XNFA4TEdS?=
 =?utf-8?B?eW5XQWc1MEY5ZEJPMGZnMm5rdUY5QlhiSVh0bGtnYXJNUUo0VzZvV0t3SzNp?=
 =?utf-8?B?NFhyR0FNN1Zpd3J5ejI2Z2NvREtrRmlYanE4U2RsbWU4UGdESmZOUGUwMjE3?=
 =?utf-8?B?aGhBVEJ0Q0ZqRS8wSStQSithV09CRXlSTW5wYlNuTXdoOStzZVdGYzNHMVBr?=
 =?utf-8?B?RXFlVkFvRkpvZWxiTDhRd20yeGhBRmo5dkdnY3hrSUVxMktRNGg1eXhWM2RP?=
 =?utf-8?B?WnVpTFRrOFlHNGV2M2xaUUV3V1lmMmkxSDVibFBzL2dFWi9VL1pXeElqWGRJ?=
 =?utf-8?B?bWRON2dmL0paK2hXWTRUTko0Ky9XR0dqOWRTWTU0UkRNdVVteGNLLytiZ1lk?=
 =?utf-8?B?d0xSaElaRHB3Z216Z3VYK3ZodklZSVdHZnNvV292UkhCek5RbW91bHp1aktp?=
 =?utf-8?B?enI2STg3UnhwZ0doMmNrSm5oWGQ1WG92S0RtdEk3bzdNa2ErK25aTDIwSzNa?=
 =?utf-8?B?Q2RzRkkrcStncDJ0eDlkMSt4cW9PWmRaejFPdndCajF1aUdYS3duWVVxN0tv?=
 =?utf-8?B?b3lOcmRlQjd5WngxajdETDhFdEUvWDJBVHFkaHZoVGJYT1ZCaDFmSGo1RzRX?=
 =?utf-8?B?RFlHblVGSDRZTFJvVFRvZlBHS25vWmNiandaQko4MmJ5YzE2OXJudDQ2c2lS?=
 =?utf-8?B?d0tSNmZhYmo4R2w4MXQ5Vjd6T0dOM3k4ZXpjc0RjNHR6WVF3T3ZZZGQ3cU9N?=
 =?utf-8?B?NFNQVWtReFBxdWxLempycG5BU3lzWU9EY3F1YWtMcW03a1hBL0dGaitYeHps?=
 =?utf-8?B?VnROL05hbytKWk9zTGpvaDFYTUJic3U0NHVqOHZCSllTamttT3NWbFhjTHBm?=
 =?utf-8?B?VWd1T09GRC8vc21QZ25iUEsvTU9PbXpXWG5hN0JTTWM5cXhtS0hXT2VTdU8y?=
 =?utf-8?B?RGdwVURzZ1ppekZJUURSeXd5YmxQVEZseXhoZWU0ODZMZ1p6REtzbHJHaVFC?=
 =?utf-8?B?MXkvdS93bjg4eDBvQU04RXlDc29BSS9hY2s4Q0pYRjRiZy9qZ3ZwNUxDN2lE?=
 =?utf-8?B?VWVtNWk0aVY5Zm5TVGVhanpLV2hUU1RMSXNnT09td1lQSkRpU01NOXVkamhR?=
 =?utf-8?B?aUZUY0k2Qm1iaC9hNENOU1NCMEJGcGpJeFJxMzhYNTJENE93TXdUUkJEcWxW?=
 =?utf-8?B?SFh4NzN6N1RqRldIbDlhaVh1eENkSmZyM1BSS21yOGNOdTdsZkZxK0w0RVRz?=
 =?utf-8?B?aXpuVlQ1WWIyUFRwN0pSaDhYS2RSQUt1MDNjVlFSWm9QNFcxaDQwOHovaUJL?=
 =?utf-8?B?eEFoWlpGVCtBaVMvc1ZzZkEwZkk1YmpoeWpLckVuL1MwaXp5aW1uUDdFNytu?=
 =?utf-8?B?RGdNRXpDc1pOVFdIZ1g3RW82SE1RTDJ4UFJyaFJzS2xiTW50YlVNUUpaWTN2?=
 =?utf-8?B?d0ZyYmtxQmtOWGtxS1B0bkNMWXVkOVJxVUJubnRTTEJFcDR1cmxGdS8vazF6?=
 =?utf-8?B?Z3ZsYzQ5em9zMm9iclVHQjVrQ2dYc2dXUFA2UHlHVllKVDhuMmhRam1RenJm?=
 =?utf-8?B?WHMwQnd6UjdtVURpZWNETjFQL2krRHFSZmk0ZFdDSjBjbmJ2VkMyRE9EaG4y?=
 =?utf-8?B?dTlXeG85WVJwS3B5ekRYT3N3ODMzQ2xaZ3pFL0d4ak9vQ2dBNEUzZzJaR1d3?=
 =?utf-8?B?a2VvNHZWbGRmN2szd1k3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRyOEJBK3l6aXRoYjkrYk9OSm9XUVVaQ2M2aDZ3ZkRMSGNWd2xlaDg0Wnl1?=
 =?utf-8?B?S0ZFS0FLNTArdEdPaXpGNjVjZkwvUEQwNE9uaDJRT1hFVGIraWF1VnJMRHFW?=
 =?utf-8?B?alM0dUdJamJvOW5OSWp1emM2QzM5OGEzb3QzbURHb2JUcDZQV3NVSWJZOWpx?=
 =?utf-8?B?dzFPcklLVVRNc1dyL1FFYXh3cE9yMnhBSmJNd3Zkdk41NUpyWFUvYWs3dTNw?=
 =?utf-8?B?SDVieElTWDA4UW85UGYzM1RtTHFxU1VBV2h5UFpJY05pQitxT3lnSk91UUdq?=
 =?utf-8?B?ZDA2ZXd0Ymg4S09YeDV2RnZqQnRiR2h0U0t4SVVQVlJ5aENwV0lvbDFOWVBy?=
 =?utf-8?B?c3l3VWRyNXpJNGthRXp3bW5EOWgyMjlnOE5KUW9yUzd4VytVSWVHN1lCMXdW?=
 =?utf-8?B?UTJSS3BlYmF6RkhjZnV4ejhoa1ErU0hmTU05NituQ3UyMmV0N3M4SzhNVVE0?=
 =?utf-8?B?a2N1aHNKditGdGd4OEVuOXhtSjdWVThjNEp2NDkxNEhabGQ1YWxKUVJ6OUY1?=
 =?utf-8?B?dStIZG5iZGdqdXZyTlJiNWd6ZXNvTDR2bXQ3VVZHbGZab2txZEJid1ZldHpo?=
 =?utf-8?B?OG5qZXJpdzZiSlY3OGtwMUJxL29PeTNZcHdzcndNRzVibmFjbll0NW1kdWtU?=
 =?utf-8?B?V1NZQkw2VUhwRVpnRThDaGRKdzNkNzNvNU5xRzBPcmhnUmpxZ0FPUkJVbHFr?=
 =?utf-8?B?UGo0VFFHQTA0T21wdXUyWGxERnRjbDR6SWpscFhoaXdIWitWUTAwdEs2VDlu?=
 =?utf-8?B?UEhmcVdQNkF2K05lT1VmRGRVSFovV1NnT3M5Q2Y1bmxlaTdUbC96VExydjh0?=
 =?utf-8?B?L29FU0lobnVWR3V3S3NGMXIvOE5scndRMmxVUnA2TWpkcS9OUG5qSUdzc01u?=
 =?utf-8?B?OUhaUHpLUVMrQ0M4SjF4ZUhiV0RPSUtJWnNqV3VFSjl3YlBaTWFlZE91NUVW?=
 =?utf-8?B?TzlIYTlrTVJWQWF1N1JRQklzUWVCT2pTaUVPUUNzTzhqUE9DM3JOTkhvOUpC?=
 =?utf-8?B?ZWM3c0M4QXh4dDAvNTJReVFaTG5Ick1jQTRJTTJhRGNaQ0krNklaaXVvMWRp?=
 =?utf-8?B?MlBYcDMvUXdLV2dzYkppa241bE5LVllobVhKWkRjRnoxRjRNUTFneXJLVURx?=
 =?utf-8?B?MUdhbzZWVXNqeTRLQWZXbTE3NDhmNE1IUTN1WjNORFJPeHhIN3YySjN3dVgy?=
 =?utf-8?B?cDlua05qbHRUTzVkVE1KKytBTVRWOXlTUVNZN2NDQ21kZzI1K3k5UVZyNmFh?=
 =?utf-8?B?aDZEanVpQUZQekRTZGpML3dnYmlacHJ6SUVWczl3MUtLYnc5MTFRMWJFT1N0?=
 =?utf-8?B?SmU5YmRwVm5Xb2NUMDhaNmJZb3IydTFoMlhjdTlDUWhXNEJsUGU0VzdRdlZP?=
 =?utf-8?B?SFhvcDhnWmxiV3RCT1VIZ1RIMzRpYXNZditQV3JIWXN3TmFmTlJBVkFyL2lC?=
 =?utf-8?B?eGxScDErWXNTY0VSbk1HZno3QnduM0dHb01RLzF0Y3BjcnVqNzdVMGZJOHdP?=
 =?utf-8?B?d1ZuS2o4WEU3c1NRcHpDRUhqN1N5dWNzb25VNDBIdDhnTUY4c2RPMnBsdUlz?=
 =?utf-8?B?WG1OS2NqWG54OExiODgzWXhNZlNWeFJCUVlTeHNuUyt6QXJ0WUd6cElkMzZH?=
 =?utf-8?B?UGpGM2dkQWlhY0w5NzhJNlFyNUpYY1hoOXhiUnhNY2REZDAzaWxSM2VDQWJy?=
 =?utf-8?B?M04vYTM5OGN1ekZpK1Z4Lytzam1uQ2hrcHdZa1FaV1dLR2dqeWFmRGRuYjY3?=
 =?utf-8?B?MWlBSGhvZ1g0RE1pcFZDQ3dwMEJ6Y082MW9EUElwa2ZudEY2cWFsdU5sQmFH?=
 =?utf-8?B?ditzTWpiNzgrejlvbEs5eThscGZUT1I1Rk91OEdteHZQOERkRVpxOG43U2xy?=
 =?utf-8?B?T1UxdGJydmlhcXg5UEU5R0krZDN2TFVKd1VWMkRyb0hQNWFDaVBMOXNUZ2FE?=
 =?utf-8?B?djc2Y05CV2NXaTFHL0FnSGF2Yjl2T2xrVmNGTHZpajNIOVB6d3Fqa0J4QzFI?=
 =?utf-8?B?eUhEdk5DUFRzdUlBTVFnN3VGNXYxemxkNEFVQUVtaDRHRGl0RGFQc0JsWUhj?=
 =?utf-8?B?RDJ4RWxKUS9BNEU1ckwwWThST0FoN2tQV0lwYkxBWDBkZHJidEdoNWdvakhq?=
 =?utf-8?B?VUdHOXZ4bkY5ZDJkMVc5WmRpK2o5T3l4YllGWDI5YSt0NHZGdjhIbTE2WGN5?=
 =?utf-8?Q?nmW3kNf1gf//bffnxm+eiPM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd88c8e7-e38f-447d-90b1-08dc97763e30
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 13:28:48.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HcPo7h5ku2W7eotVKUUECJU9y/fM/0qWih8yz6l6FhyPjoXlPB6qdtAleLr39tG8jTU5ECFyj2A4yNRwZsFsNYGeQ7Or8qubMcxuYSNqRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

On 6/27/24 16:38, Shay Drory wrote:
> Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
> IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files.  PCI
> subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
> on the auxiliary bus. However, these PCI SFs lack such IRQ information
> on the auxiliary bus, leaving users without visibility into which IRQs
> are used by the SFs. This absence makes it impossible to debug
> situations and to understand the source of interrupts/SFs for
> performance tuning and debug.
> 
> Additionally, the SFs are multifunctional devices supporting RDMA,
> network devices, clocks, and more, similar to their peer PCI PFs and
> VFs. Therefore, it is desirable to have SFs' IRQ information available
> at the bus/device level.
> 
> To overcome the above limitations, this short series extends the
> auxiliary bus to display IRQ information in sysfs, similar to that of
> PFs and VFs.
> 
> It adds an 'irqs' directory under the auxiliary device and includes an
> <irq_num> sysfs file within it.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> Patch summary:
> ==============
> patch-1 adds auxiliary bus to support irqs used by auxiliary device
> patch-2 mlx5 driver using exposing irqs for PCI SF devices via auxiliary
>          bus
> 

For the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> v7-v8:
> - use cleanup.h for info and name fields (Greg)
> - correct error flow in auxiliary_irq_dir_prepare (Przemek)
> - add documentation for new fields of auxiliary_device (Simon)
> v6->v7:
> - dynamically creating irqs directory when first irq file created, patch #1 (Greg).
> - removed irqs flag and simplified the dev_add() API, patch #1 (Greg).
> - move sysfs related new code to a new auxiliary_sysfs.c file, patch #1 (Greg).
> v5->v6:
> - fix error flow in patch #2 (Przemek and Parav).
> - remove concept of shared and exclusive and hence global xarray in patch #1 (Greg).
> v4->v5:
> - addressed comments from Greg in patch #1.
> v3->4:
> - addressed comments from Przemek in patch #1.
> v2->v3:
> - addressed comments from Parav and Przemek in patch #1.
> - fixed a bug in patch #2.
> v1->v2:
> - addressed comments from Greg, Simon H and kernel test boot in patch #1.
> 
> Shay Drory (2):
>    driver core: auxiliary bus: show auxiliary device IRQs
>    net/mlx5: Expose SFs IRQs
> 
>   Documentation/ABI/testing/sysfs-bus-auxiliary |   9 ++
>   drivers/base/Makefile                         |   1 +
>   drivers/base/auxiliary.c                      |   1 +
>   drivers/base/auxiliary_sysfs.c                | 113 ++++++++++++++++++
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
>   .../mellanox/mlx5/core/irq_affinity.c         |  18 ++-
>   .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
>   .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
>   include/linux/auxiliary_bus.h                 |  22 ++++
>   10 files changed, 189 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>   create mode 100644 drivers/base/auxiliary_sysfs.c
> 


