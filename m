Return-Path: <linux-rdma+bounces-23053-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z/7MGlrEUWr/IQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23053-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 06:19:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E07404A8
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 06:19:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jiW1ZmdX;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23053-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23053-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC60302DB5E
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 04:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C623BCF7;
	Sat, 11 Jul 2026 04:16:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4914E2F2;
	Sat, 11 Jul 2026 04:16:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743402; cv=fail; b=ou35GqBgB9qnwb700F66Raoa54b/Lji/m/NzmVbI0Lgu2nZQcjSZDe3E4YT3JW0a0xOBJ6MZnQ7SssFnf1sUeskChUKdulT73PBn3mC5DFjFeMUr+eTQW/QSboxPU/vMotDtIhvTwRjz2tc8AmpPTRxO9b1PHGeNuVkTNKWsJQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743402; c=relaxed/simple;
	bh=PXqaVcOj36uBIlJZ1shLvZd8j7hc4dFuShtdb3aM4/0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EqgnGSmcbKGTr9IC4rlYTezvowIC7/z8iUQFH6Mkqx2Kc6+wbD8TB7+Awqtl8px0tzs0EzXckB46aGZE+/iJAFw2xyXN1BA9PDsOcJ2YgyeZnuJpqhUjYE1wgIgXyXI1wOTtvuZyIZ0Ps3zubkgtOb5fx8LjQfd8AhXLVNm5fP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiW1ZmdX; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783743401; x=1815279401;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PXqaVcOj36uBIlJZ1shLvZd8j7hc4dFuShtdb3aM4/0=;
  b=jiW1ZmdXVhZwu3ZUYxHUYAEakXbWzHzjKe9YwrfPGjlSoUdPf4jX7G2w
   VjsRf/BUdXMqFusDaqlqWzbPXq6MCz+RgfbczBr5eYxYxZDv6LOE6mEQi
   vA+hQBo4IixRPKfm9x6lMSXPDdPSxwrENbMk9idwrFUQ+krbY4/4MJejw
   Yvkyo3hR5fJVKzkj3NAphtmuZf19VHWr+6fUJdHZa1QjQjrqvKefxSvwz
   WXmO7l08ftAg/UZjPmt3OgqrBpnLZbGrhFUQA5tPls/vsCII8+Ev0UlW8
   gW2FKXFVHRq9fB6dFhTTTv25ctXUf/u/cWFYvcgVQzzdBaPBUlKVrgt2L
   w==;
X-CSE-ConnectionGUID: LWz2BNvIS7SPrZGgyPAiXw==
X-CSE-MsgGUID: vBuKdXB+Sq+dWYCAfNOzFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95589400"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95589400"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 21:16:40 -0700
X-CSE-ConnectionGUID: DqikGKsPSsyKjRtMpUdxhw==
X-CSE-MsgGUID: DLOMx09QRomDijz102Q4ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251072401"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 21:16:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 21:16:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 21:16:40 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 21:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqnZaoUiFFFI9O3UixZfYMvAE6QPMdmUi12j4PynMNYEfLsEGlI9/S7mBoQrh3DWlwslX2yT7fTGnadeuhvQhSJp4ppwO75ipp0zVlAcjEs4emHFY083xhmqzTu9aD/OjoZ2uN5tRsQOGbeSbY2/T5AqLbRwxbGIrMvouABkT/dg1vOHPF+tuQNQc/ejsn5XLAAL1QBlF+pgYDKtRFhJWrh/tLZiIjT/gWxq+VACQ+xIOpJkLWrLL0TE3nS/Y+gadjMdyleEULMWKOGS9HYFEX+t1hJAf6Agg822J9r/SOm8ZndKqewxoimrd6N6uAvlXZaW4viObilQSquaV+plGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5VRnN32hcKy/8AkYoF6OpixZjB405H6D4IDCidoJ6w=;
 b=J/riq39OL7NYaxAdyFYx5jk4vZ42KfV6QuHEBkssWSjrs89bxuC4mSWwHaD+PuLsIKfTqTMx+JpTuHPdE10QppbS6Xwe43WjQnV+qUjzhHt9b6ZvmqxmiDSAaKuxU1ABOJLnRUUnxCPYtoIieQnGM0Be6aqlHrj8jSP26I0iQctBq87JSTcg0jYl+Qjaf/fPRgkXNuRonndqcK94mEIViqxd3XU3Urqfb/tkqQQvW/nKgD+Qaenhf8ZbdzGsWlyqIb7iY+uhXg8BtHhmmOaSI7SZkeWuVMhZnVZNWFtp4qzHt+A2uiDJvpXet4dUYq2VnymIXIMTCJ7w5Aq3OyngNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sat, 11 Jul
 2026 04:16:31 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Sat, 11 Jul 2026
 04:16:30 +0000
Message-ID: <73e4895c-4d07-4841-92eb-2bcb61ca4d38@intel.com>
Date: Sat, 11 Jul 2026 06:16:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnge/bng_re: fix ring ID widths
To: Vikas Gupta <vikas.gupta@broadcom.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <jgg@nvidia.com>,
	<bhargava.marreddy@broadcom.com>, <rahul-rg.gupta@broadcom.com>,
	<vsrama-krishna.nemani@broadcom.com>, <rajashekar.hudumula@broadcom.com>,
	<ajit.khaparde@broadcom.com>, Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>, "Yendapally Reddy Dhananjaya
 Reddy" <yendapally.reddy@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
 <c108a5ec-8740-431e-849d-581c136f404d@intel.com>
 <CAHLZf_tTVipQZ_MX-gud5GhqHE7KDV=44N=17mZgsrWoJfa_Gw@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAHLZf_tTVipQZ_MX-gud5GhqHE7KDV=44N=17mZgsrWoJfa_Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0249.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::10) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: a16ded9e-5dc0-4a32-2696-08dedf032f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +fvIeWTKiNhCS2VKFdxZkGswfEDjEb0mC2ZGAqW4sQb8EMhgUNPBlZz8l6jr3ymslUpO/U0WrQBQNyj1okonfb2IetNNbakDHg7dyBMO3wMlSvBpgEJanLV948Enk07A1QzWNoIjZAUU/pPoOueqTZ3P5dFjk0NxQl1gIBhc0IsgWc/7L5Xf+hZsTbPGWe9KjAv31f6SMbElDBiIHVYO6HyH7ixi6JLu6TvgEs0KJG8Bo4krYhL1ycqJq1X0Wi9T5arvXUvOpEaBh75ae3qWPG13FGxt060QX+QaWtA5qqmEno37gFD5taf2Zdq+FYbUgOvbsl5WLzVxN5R1ug1CBBDFbvmwIV3ElMpNSNlH/xYxkUPOKzGSidt4PcHG7k0rkDm5WZa+ktAMeye6q/Q9aFfXLOdmQ42bLdK0sFWCV44nNItXLfqm/VYICNWYHF2iLN5gQZjPSgA7FgAjknmIjnWwdLsH2VTgKAlxORfGeD2RuzIG0Y8bcQWhwaKmV3qHm3ynuwzKZEmIjp3jpKzL/kIzMk3GGwMBUYJnm0X0+gnfdPei5Ubhu3dOQ4HAT4LjGYnxCfExCEf+wDkRwJJTzJthcGZwA5RAkgwy0PuN6jqKSWGhCtDFE3Ljvvet0Mo86w9xLCX1VEUcRcuZ1YBGmwEZyYAUdPreQtB8qPSsxvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2t1YVFkbXFqNk9aYW94aWlGbzlsbHMzNEhuRFRpTWpsSkVSRHdMTmhYNmFF?=
 =?utf-8?B?elNMVVluakw3VzNMNS9rSDEzQjUrQVBnOUVJcVRNM3pSMzZhcVBjTjFHQ2pM?=
 =?utf-8?B?QXFMTWJsTWtDZ2dkYVd1UHQyUjRqcDVReG5lZ0ppWXU4N2VuUXZDdWYrUHRD?=
 =?utf-8?B?SXRmTXZoRElZMlNIeHBPTEFGWjlPdFJOV1Q3WStIK0h6YXV3NGMzRk9jamNW?=
 =?utf-8?B?TzZoeDQ5T3JqbUpOSUZsc2xSZnFNaUNBM3FWZjBMaVNJK1p4dnd0SmFQSnVB?=
 =?utf-8?B?Y3I2eEJqVmhqaWdxSlBFNWxENFc4aUIzNjFFQzdzV1hobW5QRGozMUhRaTM0?=
 =?utf-8?B?c3hxUlo2L1gybVgrM1ZJZ1Q1SHAvNmhkVTZlREY4ZlRmQkgzcmNOZXF1ck5V?=
 =?utf-8?B?WkliMUhRSGx3bzFNZlkvdE9oTEZnOEhTenczd3VOdUFVUzluMnlGN1h3WW9N?=
 =?utf-8?B?cE04SzVBdWE3LzJnREcxWk1JL1dzR3N3TVJFTmlGaUUwdkNBVXBkSXMxcFJq?=
 =?utf-8?B?cGoxbitvL0NmN3hhVzR0VndxU3lhMTFFSkxUajZyUVNNRU1ROGF0dy83WnZJ?=
 =?utf-8?B?SHFIb1pNUFN2TWxHVXZHQ1QweHVLL2U0bHcyWG1aL05FWWZwUFFBckt3Rk9z?=
 =?utf-8?B?czFXa1BUeWg5ZkNLWTVmQlNzQ2N6clVZTGp2eXFUODJBN2s1S1h3d1V6Y1I0?=
 =?utf-8?B?Z0NMRG9Falo0cXdTejdxS1JvdGlKZERicjZ5RHR0TDlGSU1RWEVvQldtcS9a?=
 =?utf-8?B?MHZjVENaeHZNOGVyckxSMGVWWVdMRTd5Y2JzTUJ0RkpyMTdkKzc2Z1FQTE12?=
 =?utf-8?B?MytLYmhYTG1neWZXNjNQNVFHdC8xR0F5ZjNtaDhCVXNpY3hGSkRKaGFkbUw4?=
 =?utf-8?B?dmh6cEI2M1ducC92aTBiQjZZaXI4VmovblJwc3ppZWR5VFN4QVMzcUpVM01r?=
 =?utf-8?B?cWhaZFhIK1RJR3hUUDB4eTJGclBUNW0rKzFRc0xScWFnaWFKNDRnUWxBcjlk?=
 =?utf-8?B?Q3d1TkNnMklJclRwRXluaDFRS0pUWGNLUXRvRENSdkQwMTlxQ1J3ZlZJR2s0?=
 =?utf-8?B?aFRsUEVMRnplYVk4VGk1WHIvQml0eEJQb24wWmF1UmFsWndyc1FsbTBtNTBP?=
 =?utf-8?B?OVU0ckJzZEI2NUlhL2FUekM3dkJDUXliTVhUYUdLRmNLS2hEZFJiUXpYVFc1?=
 =?utf-8?B?Z1o1YWN4cTdsMEpMQ3JUZHM5ZjF0QU9FUjlDSlpjQUx6Q3ZvOHY2V3VTQ0xR?=
 =?utf-8?B?aDBjY1RHMGZ1WmRURUZUWXcrMmhiTDZMSU54S0Fqa1hTcno0VlhyUUpHYi9Y?=
 =?utf-8?B?aXpxWGoyaDZsR0Yxd0R1ODY3RFRkL2hTSW9HRHRRWTgrbk5tTUcvS09xSWxF?=
 =?utf-8?B?QzV3NzIxVUN5c2Q0Y1g2QmMzcStXVWlOV2wwS0hCdTQvb1lieFlsUkZHMUJL?=
 =?utf-8?B?NWxjSHQ3MnZsRW5WVmNNVGQ1cmgreXVCampzejFmVkRNOUtxV2R3aExhTmQz?=
 =?utf-8?B?SzV0SjgvQ01lRlFwSGdSMWs0VDlyclBQbVpaSXJ6QkJhRXByRG14Wm5iUFZM?=
 =?utf-8?B?TU43WGlYNTI0K25QdVp2ajRCNTVicEMxakVoSm1UWE90NVhjODNjNW9BeCtx?=
 =?utf-8?B?SnhNamxVVFBDeHdCRmNaSHh0WnFSNEhGbnRMWERLUVp1dlhGWGFlc2RxSDla?=
 =?utf-8?B?cWtwQVYwd3BqWUxjaG1mdDg2Nnp2VDErZ1hJbWxQTGNseHVJdnI3aDVjcmFi?=
 =?utf-8?B?RTg5RkdNQ0VTc1U4bGJkR0tFMGNLRXUzM2JpNkk2cmFZQnBvRXlMT29aT1BQ?=
 =?utf-8?B?eHpaSXJYMGRuSHVBaHNsamk4MG1Za1FGUkRuOXNtcTFQUzR2S25nNmV4Vnpq?=
 =?utf-8?B?S1JZYXRWT0FiSWJ3bWhhNHFoc1FqQThNQ2lhM2FxY2pDUHpzVnMrZU5yTVpG?=
 =?utf-8?B?OTJ1K0RJS1pvaHdIMEFrSWVkMEpCOGJpUlRSOXlLRXJFT2hHYTEwdlZvV3dr?=
 =?utf-8?B?eTFyMER1T2RHcDRhdzJWOUxWSEk3TUZndFNETVZBbXVRTlhzYzdndHd1WWpi?=
 =?utf-8?B?S2dFQnZtYmZhOFFFSWd0RUJQMFJZT0Rzc2tXdmtseHA2VHBsdnJvemtyVGp2?=
 =?utf-8?B?L1NFS2pXN05xSjNEV2g3cFMwdUlDcWFNU3VOUjFhSjB3dEFEc2t4aWdVMjhT?=
 =?utf-8?B?dnk5Q0MzMi9SZnZLeXlWajRPSGp1SElqQ2dkWFJzU3I1TjY2YmJ0dEk0NHVE?=
 =?utf-8?B?SWFvV0RiZG9IcXBwdyt3RXRsamZHdEFmS1NOdUdYWEVVdGQzUXhUMjd3SCtS?=
 =?utf-8?B?YmlnMDlrTFNISXFLcGlzb0F0KzhrYkxibnk4WUhDVDA4NE9KMjZVNEZOVTlQ?=
 =?utf-8?Q?CAZPvoHKZdjZ7JVc=3D?=
X-Exchange-RoutingPolicyChecked: fecdYJOj9eRNAnTpUnvTUD4jkZ43Rjy14aI3eSmak/CgojYTo4hMdF+g/bZlV1yn3k5OTlRDoMJDQa7zAxSabbBO+9h2eq7EBK98kNyFxRqwtOBye3bh+gS0+uK4z77PN/C0lHdH9YDlfwyAKs1rqUzzgv9ZebGKzqeg6iRB3xaXhxKq4qh3Un5zb6gGpxcTobxzZGIhJrDRU+JfXEgMHSG/8angaz5gx3zl6PqKQgbQgBS+zcf/vVCIqVVDhP11UKSD/Tf514GYguRNBfYkdkqC17iNytjcAASHUbstp/eOsxWRpK7xLkSgKXakodfZNR6GjuQSBHTucqS+7m980g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a16ded9e-5dc0-4a32-2696-08dedf032f38
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 04:16:30.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvziUWFDVlLS8IyNBIBePZwooHDJ3S/1X7HJ9J2LFH7h4n+ltDFE6mG07dArdimhZnYOYvGyIWZkl2RsOPHz3K0J3zhpPPzqJ1mAlm1deho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23053-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vikas.gupta@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A37E07404A8

On 7/10/26 16:25, Vikas Gupta wrote:
> On Fri, Jul 10, 2026 at 3:36 PM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
>>
>> On 7/4/26 18:47, Vikas Gupta wrote:
>>> Firmware requires more than 16 bits to address TX ring IDs for its
>>> internal QP management. Widen the associated HSI ring ID fields to
>>> 32 bits. The values firmware assigns remain within 24 bits, bounded
>>> by the hardware doorbell XID field.
>>>
>>> RX, completion, and NQ ring IDs are unaffected and remain 16-bit.
>>
>> Here you mention Rx is unaffected. But you touch multiple places that
>> are Rx specific (some comments below).
> 
> The fw_ring_id field belongs to bnge_ring_struct, a common struct
> shared by all ring types. Widening it to u32 applies uniformly across
> TX, RX, CP, and NQ rings at the struct level.
> I believe the commit message is incomplete but the intent was that
> firmware assigns values within 16-bit range for all ring types
> except TX, which requires the wider field.
> Please let me know if this clarifies.

Thank you, it does clarify.

Would be nice to extend commit message to include that and also the
info about HW not yet being released. Not sure if it is worth v2 though.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

