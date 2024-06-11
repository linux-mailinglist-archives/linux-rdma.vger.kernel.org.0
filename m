Return-Path: <linux-rdma+bounces-3053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC87903DF2
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C48C1F24DF7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E717D36E;
	Tue, 11 Jun 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLFT6ZOk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07D1E4AF;
	Tue, 11 Jun 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113872; cv=fail; b=dUrFq7O6klUmZDH2b+Y0N+CnhsxSQl1ejrAOZhc7ksOxnJlDKoRbYCXLcqGm0TGGBjCseOI3cWSAR14xoelK7qCyQr+87/yHria+C/Xp0jcMejkJBavJ0dclshgIhIJgh3iiG50IVpNhlzQ9rGX3LWz1+AoAWS2X6ZosiqsUaM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113872; c=relaxed/simple;
	bh=R4JUIEh8szBUXl8egQIgheTIAdUbbLwbl3TtqF12ZDQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BB0FtG/lor6ZBQDgCq4B08WoZcMBfoq83pYEM0VhVT8tFWeBfeB9i4q1prIobeN3mQvmFqzrnStPTduhPiTCt1tODkXGA3AXn6xIeBh+Gh6S/S3J7LgoZ4cV1KTmED5VaZ20JXWyvC1zpf+sZNNVV13mTe01srOtbkJRdytgf+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLFT6ZOk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718113871; x=1749649871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R4JUIEh8szBUXl8egQIgheTIAdUbbLwbl3TtqF12ZDQ=;
  b=CLFT6ZOkjpznKCeZaVc/2DFlNNQU3cb1YGwWB8Pfy2Afwwf5K8yWSCPh
   yFyLIYdmfubqodOH22a/0I2b1XzcoXLDgs1D5PvtfwDdKXgJ2DG+TqD+w
   EGkNHxJkQkgbS0ryy+FkX/Kh70b+vm/TyhI3xUR+MTAUcUsqnFPnOXOrj
   9yE+KPZmu1+JqTFXhMYyPhRLZ8pyT04VBTufp6RNh8yBqljZcPamNk+2h
   3pGaOcGhb8zTUKGuk8peJXQYOyg9APbac06N9saru4a01vz3xc6zRm0P8
   4cLNeMlPeR4RLnOF1dduiAUjQEZxqR+qjSS4HSwbkjBsBdUYsfEyhYVff
   w==;
X-CSE-ConnectionGUID: aYu7L1iJRUi0VHsKk9tARQ==
X-CSE-MsgGUID: wdhLB5HNRYuqo0LKmKucbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14993790"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14993790"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:51:09 -0700
X-CSE-ConnectionGUID: XtY0PmjuTvipxZeJR50FEw==
X-CSE-MsgGUID: KMsAwqQPRwqbHRwrnwvEtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40153024"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 06:51:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 06:51:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 06:51:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 06:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjZFyLMCVS/m8qbvH9ubfa3pICslcsYWU1C1Ksfv2D18g6qyx7jMvP9rfof6RAlvHBBBYtN3QYcakL9colWzv5ZwO0HtBynbqNYEguQF29xBvYKAeIh9WeQDh257Fz/REgvyBWO3w5IdRiKUmakj69zuqWoR5W+NKzfR7gOFhrZhYyYSI4ufNK0DnjFBsqQbJ1ADfpqVRUjpPPJoB8YUZsDsHzHYrVxn88gxpUkD/KmvcyliXGKzV5k77ZN2e1xqA5m0oE9F+T2ArzV8ej1BcloBzedJFsZwW+/g+N61LEhm/K9qkXjm8Jy3vDhpJNfAjA9pV2qpprRwqZI4CUcyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1uGq2+wfieuYXcZeRJnK4aDZSCGzaGqhYSzVcgw/io=;
 b=WKkVrkPwesg1K14XuB57f4lmOU3NPsLe+pEbGiSj8Skiy7Hp4KVE8TP8Za6/l6njnEj2rvj0pa77gJ04jIVrE/RzR0eO1065C+/bXVkV5nkKPx8M9jdnInv9WLkr4PMpX26m+2+J0XyYL8EK1r/fmRpRTr1Jn53rvrS8c/0jiIbhiivU1pKi+O1rvoWYCslZfmXlxvR0j1zMFaaNP9eMaIbl3FP6pnVdshuJNdUTcTUxCzZgIQA50NKB93dhc5INUQGtPGi13YVQ5JG+CcnNk4pxIcSGDzVqf4KUG/qz4p+8Nea4t2VHOec0YpVfuM0XW8yQSq+M/g/IrMLvFjM+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 13:50:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:50:59 +0000
Message-ID: <d2ffbc2d-0966-4210-a5d0-719c27d9adb1@intel.com>
Date: Tue, 11 Jun 2024 15:50:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] auxbus: make to_auxiliary_drv accept and return a
 constant pointer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, "Tianshu
 Qiu" <tian.shu.qiu@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Saeed Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	<linux-sound@vger.kernel.org>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::37) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: db824e18-8139-4bee-d473-08dc8a1d8657
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWk1QjF3YWxZYUV0M1dOTGRuTjBlSDJkV0lNV3ZnbWRKMG9GcWpaTnVXNTFO?=
 =?utf-8?B?eXZjdEprOWEyeUdMaHY2QnNhY2JPTFdobHIrOGFDUXZUY3NyUnlzZi9tTVdz?=
 =?utf-8?B?bXJsL2NiQXVBSXJwMlJQeFZONnp3emNzbWo5TytxdjVGNEcvNmovd2l6dHRi?=
 =?utf-8?B?VDlkWG9sNUthd2pkbjZDNlpuYTl3bWducFBrNnJGYzdLeFIyclNPKzhOZjZn?=
 =?utf-8?B?eU83MnQzU25vS3IrZC9NSVlxenpub2RiMEUrMVFGemZidy9pTUtjaEtoWUFE?=
 =?utf-8?B?VU1WVkVzYVpDYmhhSkFlcDVaQktYOVNHSjluMDJvcWh5a3VDWVJnR3VwYlFv?=
 =?utf-8?B?aWFyTlhrL2svdUVKUi9SVTBTaVIxcVlleURRQTlvWmhIY1ZtL2UrMWJGS08v?=
 =?utf-8?B?dlNJaWg0b0RnQ3piNWdkblBWVlVzeWF1UlFuZXo4MVJ6U05GbXBYeEhXZ2ox?=
 =?utf-8?B?MitnVWlPTUtnQ3BrRkIrS3lYZHlUYlpDV0orL2RnV3RiRktZbS9tS1NXbktM?=
 =?utf-8?B?UmlndW9KYzVHRXFlK3FvQmNwbTFKY3BmL1NUQ244ZDdyNzVqUEJlcStpZlJG?=
 =?utf-8?B?RG80SGJpbkNxV3BpbVY1L0RkL2tjb3V1M1Y1TzBiNXEwU2l1MkZCMUhFMGV1?=
 =?utf-8?B?R3JJY1ZZdlBPdzRmWUJtclNXN3RFZUEvNFprbVRSemYxYXlETG5BOVl6SXVE?=
 =?utf-8?B?RmhzUXBIaEVxTTA1Q2Z2MnZGeVdTT2N6em05Mk92TEdPcFUrRjBXLy9xdlNH?=
 =?utf-8?B?WHVZbmRUNTF5bkN6QmVyQVcrN0tBUTRhRllUQzhnb0pIM0d1ejc3SW5uUjQ4?=
 =?utf-8?B?Qm5yYmJsOUlMc0UzejdNeVdGNml2ZE03NTI4SzM2SEUyMUtQanRhMWNzS1o4?=
 =?utf-8?B?S3k0WURVN0xGWWJyQlVlSlFBNXdmbXVmWUNsL2pLRWh3VFFjeEQ4VjdKOCtI?=
 =?utf-8?B?ZEZUWER3b1FJUEdZeXFMWWxWK1JLQWxQREdqbEdGV3BZQTRycTRvRnE3RFcz?=
 =?utf-8?B?NERPT3p5VVlYQ3JnMGdjZ0lxZWVTMTBmMkhsNHZNY3p1ZDJSZnJqblFGK1pZ?=
 =?utf-8?B?aURKalBVTW5qV3Q4U3NtZzZLK3c1ZnNaNHlONGdMRGozK2RzNGNpQkp1dm9i?=
 =?utf-8?B?SXgvZ3Q0RTV3RU5vWlBPdmdiMVhvWEFNVnBNVXcycSsvNWk1NENER2Q0b0I0?=
 =?utf-8?B?ZDdPSjY5K1JrSUJyejQ0R2RvakxGL2FXMU5NREh5SDZXS1lpTlpXb09rZFJ2?=
 =?utf-8?B?N2ZHemVIei9WckdzWGF0V0ZkRGJqUzlGTlhXYUQxK09XRmc5YnI2c01NSWR6?=
 =?utf-8?B?UXdrYTdPb0xJbTJxYjUyLzFmUzdnWWVNeitQS2JaQWxRSEZzV2F0N3E1Y2lX?=
 =?utf-8?B?K0R4WU1TM08wT3phOHh1N2Z3Tld4V3hhNEVPZFM0VzA4MGcxL1RmU3BNVXRw?=
 =?utf-8?B?bnVUeUgwdmxnMWRkRTFpN1liWkJpb04ydlVERHFxUE9ubGxzRm9hekVwWkJ3?=
 =?utf-8?B?RVVFWHM3N0pGWDcvU2xOL2FvZXoyN0lmTmZOV1VVc2RuK2ZGdU55WWFtYVJ0?=
 =?utf-8?B?WkRuelhCM1MvUmc3SnJ4aGVoZU5MUnhsMkI0UllWK3RIYmZqMmppaC8zZlJ2?=
 =?utf-8?B?ekJOMCtHRC9GclN6MFBZQUNGSkNDYUtEWHlJck82UmthcGQyKy9zb20yYVFG?=
 =?utf-8?B?RkNWbFpUYXNyNStYQzU3VTg5clNwYUZldURoVko0TDZpd0lpMklMNzZDNVhG?=
 =?utf-8?Q?KpAk2Lxep2/wBqfSX/Mx8LmmFBkgT4QFNIPkX7f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BrWFNKRUtORjlxKzZpbGFmWkZSUXdVb1N5U0cxNUh1QVExNVhva0NVNjUr?=
 =?utf-8?B?ZDd2OUtoVHJVcWdFQWVsaWJhZjFudUhiMDlxb2pHVFM1c0dkRjdMZkFScGtl?=
 =?utf-8?B?VlFURFErSS9FZy9tM0JmSVMwRjBVMS9iMDBWeTFBTGRtMElicDdZQ21KTzRI?=
 =?utf-8?B?NmJmRytFRzFZRkVnOXllZHorVHFxbHhSQ1czYnp0ZkpRSit4Kzl1R2MrNzEv?=
 =?utf-8?B?R1dPUlZHRE52WFM5R0oxSStISnRzTHVHclI1NGNTWE9QWGpOSEFhTkhNbG8v?=
 =?utf-8?B?cGhXZ2JPUnpiMGFKeUNuTU94R0lIN3h1TDBGa295R0FEQVpLdXR0TXI1cXlP?=
 =?utf-8?B?Wi9yL1ZYTWdTR0toMExuTXpodk9xYm9ZTXp1cjhVZnM5dENQVThQZWxFNG43?=
 =?utf-8?B?S1lOVEVJalowd2lvMkNmZFlKay9hMXphcXJsOG9wS1drMkJrRlNMd3FoVXJF?=
 =?utf-8?B?RnhSSXJMNkFmUnJuakJFbFJadUNXd1h1ZjRUbERhZlZvTnRoYThKSFIzWk9K?=
 =?utf-8?B?VTJYSXh3K0xrbC9XRmRuV1dpVEE5aXZRZk9YcmJ1MEhweTRYUll0L1ZacHg1?=
 =?utf-8?B?azJaS09rZC9DQ0J5dE5zbGxMZmljQWExYnA2YVppTVpjVEJlSnNtUEx5VzNy?=
 =?utf-8?B?MVFBcnFLVkttbUJrVjRGK2FKWFlNQk1pdHUrdE5YT3o1ZVRxTUcrY3B5Umdn?=
 =?utf-8?B?QytjSXJBVHF3L0VzenNyNHFCSlpldTBSM2J2YVNvZmRyY0lhTDZEMWdDQll6?=
 =?utf-8?B?Z3pRcCtuRzJjbmhTU2VsckorcitjQUJQTGpjamdWa3c2aWR0djRUSmh1QWpO?=
 =?utf-8?B?SEd4S0dESHBrU0xyNC8vSFNDTWl1VDhBRkpiRHYweGRVWDc3TER5dzFobjV3?=
 =?utf-8?B?N1hzendpdWRHTzJFR251ZzhtQjZTek81a2hMMzdwMWd0bmpWYmFrNFM4bWJs?=
 =?utf-8?B?STUwUjU3ZGU0YXc1bWFvZXpPL1oxZ3dpVlBSR2xzYlZoM2phK1RKdkZzZjI4?=
 =?utf-8?B?KzJGR3I3bnNrU3dNKzFsN0FlcjgyMHlpTEc2K0lhVXBJK3l4WTJQT3NQOEpN?=
 =?utf-8?B?aGZMOG96S01lVUh6SFVwTE1jbmkxTGducVpibHQ1OXRuaEFZcDgrRTBsdkZx?=
 =?utf-8?B?MzRlSGJkM2VCZ2ZnRm50ck1LUnc1V0kvb2ZCMS9yVGttLzBWSmM3NTcvclZX?=
 =?utf-8?B?TEtFNU5pejIycXpsejYxanNqU2QrK094dVdyRnk1MGVkT1VERzhZeStUaldZ?=
 =?utf-8?B?dUQ4eWlJdXBSZ2xxUndIaFVEUiswbWloTFdHOUVFVE80eU1LS1VRdTZHc28v?=
 =?utf-8?B?NldFL2ZvMEdNQXB0Rmg5OTAybnQ1M1lrdnFpdGpCN3hjdHJ4OWxwZkhJYjZI?=
 =?utf-8?B?RzEvNUtVU0RJU3MrVmJDcjdoWVl1ZGo3MG9VakkwMi9rUzM3aFZRUnFyVFRJ?=
 =?utf-8?B?dzJrQWhUb3BKNXhLUEFjaGpCLy9wZWVNMzdnbjFUck1jM1BOdGl2c1cyc3o2?=
 =?utf-8?B?ZmpnVkZ0dVZnbTdWcmV3aWZyYkxIZm5INGRhdk85STJXbUprRk8rUis0d2NB?=
 =?utf-8?B?MStYODhlK29oMDAzZHFkelJyY2FRalhQNVlyU0hWc0QreGRVNnBySDZ4WXlp?=
 =?utf-8?B?YlFPcFBPaEV2N0I3eVc2bGIwQ0IzK0UzZXhlUWZpcmlQVWxtVWhZTCtGZVZW?=
 =?utf-8?B?WjVma2pjRkZSNTJyOU1jU0h6UitpUndOMGdKbXliUTRzSEZmYnZ2OUNBQ01w?=
 =?utf-8?B?M3hmUU9wL095VklZMXBYbW96SVRxbWJuL25XOUdkY0lITEtadnZKS0JPU3RH?=
 =?utf-8?B?dmRoRTNHZ2FCYVJDeWcvKzk0R1g5ajhRUFlxMC80Y3J1aUNlYytYVURuM2dC?=
 =?utf-8?B?NDVQMmNNUVhyc3JlN2tjZ0FPVmN4eUlMcFE2SDc2R1Q4V2RqZmNGWHZ6R2d0?=
 =?utf-8?B?eUVZWHNyaEtZR2I2V2lYRFdrWjIyTmJGT1dIdG1venV1NXhaNjBpUlNxL0Ey?=
 =?utf-8?B?RGV2bEZBNTVYZmhTOVZQT21rVS9kRitPMU4wNElGbklHZEw3UVpVUXVoWkJr?=
 =?utf-8?B?VmxBZi9wcGlYU1NiMWNMQ3dyN2ozUmJwdTlINHRnZzJ6dG1zWlgzUG5KTzA4?=
 =?utf-8?B?cUI3WlRQc2NUQjNCL1grU3RKM3A0MnhoUFpHZEpCVmtrOFN4RStzTDhJakx2?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db824e18-8139-4bee-d473-08dc8a1d8657
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:50:59.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3kS7QXuFL1bco07ujzs/mHyxWYRAOBGG8px8UaSFmkCgowlPoYqyFg7HBp4RRUXSMeE2KHIMPAsIo562qsSIq4MyqDt2HsXwlJHU4JYJs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
X-OriginatorOrg: intel.com

On 6/11/24 15:01, Greg Kroah-Hartman wrote:
> In the quest to make struct device constant, start by making

just curious, how far it will go? eg. do you plan to convert
get/put_device() to accept const? or convert devlink API to accept
consts?

> to_auziliary_drv() return a constant pointer so that drivers that call

typo: s/auz/aux/

> this can be fixed up before the driver core changes.
> 
> As the return type previously was not constant, also fix up all callers
> that were assuming that the pointer was not going to be a constant one
> in order to not break the build.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


[...]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 0f17fc1181d2..7341e7c4ef24 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2784,7 +2784,7 @@ static struct ice_pf *
>   ice_ptp_aux_dev_to_owner_pf(struct auxiliary_device *aux_dev)
>   {
>   	struct ice_ptp_port_owner *ports_owner;
> -	struct auxiliary_driver *aux_drv;
> +	const struct auxiliary_driver *aux_drv;
>   	struct ice_ptp *owner_ptp;
>   
>   	if (!aux_dev->dev.driver)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> index 47e7c2639774..9a79674d27f1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> @@ -349,7 +349,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_priv *priv = &dev->priv;
>   	struct auxiliary_device *adev;
> -	struct auxiliary_driver *adrv;
> +	const struct auxiliary_driver *adrv;

nit: in netdev we do maintain RCT order of initialization

>   	int ret = 0, i;
>   
>   	devl_assert_locked(priv_to_devlink(dev));
> @@ -406,7 +406,7 @@ void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend)
>   {
>   	struct mlx5_priv *priv = &dev->priv;
>   	struct auxiliary_device *adev;
> -	struct auxiliary_driver *adrv;
> +	const struct auxiliary_driver *adrv;
>   	pm_message_t pm = {};
>   	int i;
>   

[...]

