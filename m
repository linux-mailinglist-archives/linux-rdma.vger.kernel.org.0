Return-Path: <linux-rdma+bounces-21321-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC4KBDOyFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21321-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:46:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E75D7DD5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E45A73011EB3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC793FF8B5;
	Tue, 26 May 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8QNnvWu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A313FFAB6;
	Tue, 26 May 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806761; cv=fail; b=Hi3JEI7mzd9Ah+254jwxpdsM9fIMT1KPlBpyiO4tXr5kGpxKAJMk/QPT98KqSjX1UZzA+5QI2QjkAyfIbeab6BecB1i1W9tWE8Rcln3tv18mzW4iw2qvpUqZ3ZqEyfP5wX9G8I0WFXZuY/+yMm2CewGxjDtfgr8pnpNUCMScgog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806761; c=relaxed/simple;
	bh=EYys2JoVMEn3J0tXAYNgMfkgNp3gxV9N6LdAXcAqGjw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mgzoVtqZKhHDaCxmNX4092WjFfeutR3ixW88d1igBH092ymlB6hvKbqdyO9bSo+Ucctl5OKSMiHWkRYafnrLlJFKkctXd00QInDiLrrfoFRPWGDNdBYRouNIAqQmtG9ygdZYbtlkU9vXNAWzNAqizHl5aIHSKBitdyYpCy1IXP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8QNnvWu; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779806759; x=1811342759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EYys2JoVMEn3J0tXAYNgMfkgNp3gxV9N6LdAXcAqGjw=;
  b=Q8QNnvWukhFvqBFdmiFOOglLcZfS9Kk3wjYhlS5Fe4lgOwCghuowqefY
   ppvFU+bjG/+EL8x21qdDJrBJdfljsnQorCnrDfGEKOtxOvWBmGFNIvrOE
   UZjnHy31HYJ06tuJGqSLR9FU94D2YqAjTyXwp6iLELxWoemYYO+T6rPMi
   rHM+DZnP8dhh2ABOUqd3UHir5BxMtI18XBgSU/uq4I6ryBONZyYY7CWtP
   HRydRI4pGjlbeCWqt/zlmpAftNnpZHMz66tf5UWdOz5UH9SUPO+mPYbra
   Ms3RmKy93gG8NfB+8TFihpNcGuK5V2/syI8v3xoTpvVCwDZK2uH3I03x2
   w==;
X-CSE-ConnectionGUID: 2Sf/QDMdRlulgQ4ehOTQnQ==
X-CSE-MsgGUID: Qbv5RkLARf+IghjO5ETeEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80653549"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80653549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:45:57 -0700
X-CSE-ConnectionGUID: rEae4kpyRrGF9J4dhrElVw==
X-CSE-MsgGUID: ZgjdiWyLTCSAJ6a/OyqWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="237523648"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:45:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 07:45:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 07:45:56 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 07:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU9bL4SFfmpAJUwKwfAA6QSFjy/gwZSemjZkh36Y4dnGmIzG3FkYO4IQ0xbJmYMOkvqd9fZoLbqAgZcv7jXuySQoewUb5MwD2CIRLxTuaUQqoGPefnFczWzJ+RerE1Xvmsa1o02EmXeLaD96M6eZ+7BH4N7cpgAAtPpIlj/lwvVTnRMtAKlfqtju4m2s5n3leKjxQmY9vKnFpDH8h1sZU+WDsoBtQrAuVOi3Vm51M7Zght+YhgZhG7PoY3iiVCGiIxjoIabccfmVSgWAaRyZnwBaWvW1LpyNzZbY7qz4YpotGudrwCklS0zu2wzRoAc/W+8zrmsB5h/S3bkOm/iZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCiJAtWN2nCEfHwW5wLNKmxGahO5ZELHtcXWqP/BoEA=;
 b=ZGIz+WT6DIONItcZ66W59JDExVIjFO/E80nbw5W7xfruLz8KZWyiCH5lzZ6KTUzBHKbs1sPIBgedLL3lsQQuAtAZqRfWroW3TR4rhFoMZJJMOnrHtG0bPRLYHWWW26+25kP9szmjnDCqR9ZEpoEDkIMc/wgNFC/ccRWCIJcl0+eO/fPg+tKilGW/6Frv2W1ICA8SrrFarvL+Tw4GHVcvtQ5WeYOnbeRAfnt5M1xnYm11SMs8ExSJt6CeRuW5CvGziJYDaG9gS25lVZW4+lDoIqpAAJIsAi9M4LZOIDuEacrbUc7NcAmdRHhwV2UWY2NunVgyEKUgC5+WJb6a4zA5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 14:45:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 14:45:54 +0000
Message-ID: <d3191a29-0ce8-4338-80b8-a49c53c1a472@intel.com>
Date: Tue, 26 May 2026 16:45:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create 'include/linux/intel'
 and move necessary header files
To: Jakub Kicinski <kuba@kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<tatyana.e.nikolova@intel.com>, <krzysztof.czurylo@intel.com>,
	<jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-2-anthony.l.nguyen@intel.com>
 <20260520175201.72f83c4a@kernel.org>
 <ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
 <20260521065609.248c7009@kernel.org>
 <5426379b-1201-4707-8d18-21dca3d1424e@intel.com>
 <20260522084050.5ba31f38@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260522084050.5ba31f38@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF000001C7.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::848) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 1990f75c-03de-4a44-880e-08debb357d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799006|5023799004|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KgfG/bgI7+DDBpTzRKyvwyCQMsCkxKNjo0fUQHtmWOZuOU+p2bUJ0CWol31WMkZG6fEpbghXEEsz/qCp6OXqQytZwXR76IlpzOVTIAwSUdck5dicPoXS7scU0cP1LQ3qjsMdmvRvyUdqwt6B/AkkkohOsy1RnDxs6EEptw8os8W+SSeVT93ozOqvtDFVyfm9/xYx4qCRkaFmwtn9PHXm8O70FEfeSiAW+WAtVmnCoHndWhRyKxI9O3kzeo74hffecVxJVuasBjqHphoIwxTAzzZCSQlrWHRTUThvK7Mo43T3L9mmMuBbRc7czMdFXThc2+WUMM6/cSjFDgrDaOYMtDKSm8TcjW5353qb+2dG1ZqhxpwjP4K+hH7yPBTkmYS2nzl7czBGqOvj0T8jSW64vIro8YFbFAHNc9QVRixLncRYp4DxUEbXb/qJB6NyeiM7LV2Xws5RXTfhRk+LcYnapNs8iT0tUgXaoYhBIgojIb1Ou+FTgYVXCGg2Q+muCXS6buyUFD9hDkbpemfYzH8Ua1He5lFxeVe4WlX4eIPAtlLT8Js06ZmOZnn3Q5U6xkFIpxJCzTqXVjeKsHePFW1GW9FXMqRQj+oI40plaD1T4G5P3m8cImQ2+k6z3ZLNQxXulLDPzqfQEMT60UTEk+1fAVNnFz6YcArnof/hjRYLXp10jr6sKHod1wrnBuoIGirS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZCY0VBVTEvdUVVbExUcGhMMVhFTzJFaWxWUk5Wb0w5eTVmYWJ4d1ZOKzNn?=
 =?utf-8?B?Z2dLMXA2MllqVVppbmZ0OXdkL0RLSHZwMmVYMHRVWUc0SEhVemRDMFd0YUpu?=
 =?utf-8?B?Z05abzczYXlEN3hPWENYdUlxY0N0TmFGY212Z2VCcjVBSmxITG5IcUppdDJG?=
 =?utf-8?B?L1pkQ3NxWEFQa2xmS1pFNlNxbUdWanVUTWs1QVBYS3dBS3NhYlZnK3g2ZmtY?=
 =?utf-8?B?bFJmYUJIK3NPRTNYTXVzcFlVUUxIcHNXb2EyUkh0RnVrQXp2dWIxbTRmRXNX?=
 =?utf-8?B?c1pLcmhSQmJja2dSZE5wL0hrcnJtNDRRMTJYZDAvU0wrcXBmaWJ2bWFtSmIy?=
 =?utf-8?B?V2kwOTlNSTFWbllDVFRhWSs3dEN0VW9MTzJueFVGL3VONmVZMUE2aURKcHUr?=
 =?utf-8?B?aUZrRXlPTmlUa2F5MTYwYXE5OEdMbUEzakNkRldHSmJMbk5aZlJpeEhNdkhh?=
 =?utf-8?B?elM2dFgvNkNDNWZYalRVRDFpSUQvdW5Ua3NDS2N4ODFkMVlvRUQ2VHZRRGU3?=
 =?utf-8?B?SEREc0tuNU5Kd0ZDZ1NmOThQOVI1T09qRHM5K0lkWHcrNmQzejJtdU9obVlW?=
 =?utf-8?B?L0RLcFoyOHd2RUVSb3BrbEcyK3pWWnNjaFd0MWVZQkhKeEgxYlRhNEpTemZw?=
 =?utf-8?B?N1FOV1QzMU1jN1JNQ2t4d2gyb1JPRjBNbm1FS1FkN2FkYjZvcXBFUHIxYXk2?=
 =?utf-8?B?Z2lVTlUzOVp3aFBkSUs5N3BROWkyT01vV2N4ZnJ4VG1tU2VxQnd4RTdwUElk?=
 =?utf-8?B?ZzYwNEtpMGkyMWhvemwwTStFeVRBa2p6a3FMRExKN2ljVU8wVEM2dXhLK2Fl?=
 =?utf-8?B?QVhCaVRDVE5QQWVIeUtxdWM0cTdyNFNYS3Z5TC9nMjFmaVhUc2N6ZjFNMHpX?=
 =?utf-8?B?QWJJY0J5TW8xSzJNME91SUJMa1RrQkl1V2x5Sm9IeWx0b1BneWRXRHV0TTBq?=
 =?utf-8?B?bnYyQlRLdStQNXNIT29UbnZkcW5ubU9ZR1ZFcXAxOElYWk1YZnFwRzFXVnpH?=
 =?utf-8?B?UHdzS3AxcWV0SU9IcWUwQUc2Y1F1WXFyZEZ2MmRvY1lURjhQWGt4MkZCUzJv?=
 =?utf-8?B?QWJnS08rRE9vYWZnclc2S2p5ZXQ5VTMrMEtoREFMZGJyZ05aSjhiR1pjNnNC?=
 =?utf-8?B?dUxOMWhobktMMEVRaEthMkcxdURWV0VpdkJET0hsL05KeFpoRFdEdFMvYkYy?=
 =?utf-8?B?NHZNK0IzSjdtYTNqcU4zY2gvclV0M2NCVGs0TDlENXZWdGViVU5sNFRaSGFD?=
 =?utf-8?B?SVozYW51RE1idUhwTXZqL3VKdURzUXdDUjFTcWJNeTlDTHE1MVhuaUJPaGUx?=
 =?utf-8?B?UDI3aDFVSkhxbU9BbExXTkNKeldVMnp4eldOcHA0Z2x4TE5xYjhZZ1gyaDR1?=
 =?utf-8?B?bzlEdDE4MkUrYVNFQVA0b2VZS091SVhFaTNsTUI3SFFPMnVONG10TjZtbkFw?=
 =?utf-8?B?N0tIOFRBa2Q0LzcvcGhCZlFRME45S1Z2RVZSMWwvU0piUDFGYkZRYkZFVTh1?=
 =?utf-8?B?M044ZTJTSThWNzRJQkcwUmJ4Y2Jya3Ryd2pWYXdFYUh0T1gxUmlRNm92cUVm?=
 =?utf-8?B?MDErTmpVcUQvdEFnRlRDZm9UK21HaW1wVW0xcnB2NWNLdDh2L2VtNTJ2eTEy?=
 =?utf-8?B?N2RGT3VOTjZvRWRzOFB4eGNhcVdidmVRNlZEMG9QSkdKS0g3Wk9mazdMMXJz?=
 =?utf-8?B?YytmQmJoTU1HK0JPZW5PYlQzVUppanZWdWR4V3JYYno1WnZhaXpzT2lUU2lI?=
 =?utf-8?B?WGZ5aU9MUS9uVGd4MVNTYnB0bTJXQzE0MG4zRkh1QzdUc01XRzhIWTMrNURv?=
 =?utf-8?B?blNGd1V3NXV4QlJBOFVsWnY4cU50YXJUMU52K1I4c2FTNW1qeElEZG5xaG9v?=
 =?utf-8?B?ZlB2azRreS9RZzZYQnZjYVFjN3ZHSEdOQStCbS9iK0w1cGlHa0g1VDd0T1I0?=
 =?utf-8?B?Y2xhUVR2L0tZeERkc0tVRDVvcGVMUnQ2ZHBPdWNvWm4wek5WT2FxQStiNml1?=
 =?utf-8?B?b2V2SXl1a010Sk0ya0xqNmlIQTFqRWplNmRGUm9vZzlncmZiNk9pcTRCNDh1?=
 =?utf-8?B?UysxQndkTzl1cGlreThKT0hsWjJNMitLL3ZNVWZYS051aWc4NDhEZVBTSWVu?=
 =?utf-8?B?SVI4VzdjckJNRUo5OVA2SmQvQWhaT3R3eVFtclZwQWdaL0tWTXhObWdtSTR5?=
 =?utf-8?B?ZHY4YTFyRnF0aE8xekVnd3hicGhXZVVKWk1YMGQvOGViNFE2a1Btck9yNjVz?=
 =?utf-8?B?Q0hndGQ2WisxS1NUWTVsZjE1Rzc4NmtSclZuTXFYNkY3cVRLVDNPZHY5MGR5?=
 =?utf-8?B?Z0VFMkdCYlI5WndJM1ZlSXM3RGJJbUU3SFppTXFyN1JiaTMzRmw0R0dPWDJH?=
 =?utf-8?Q?vBwDcheJFGlD8bmU=3D?=
X-Exchange-RoutingPolicyChecked: VLbhGFH5M/3a+76+7hBYDqp9kkTwhwKmllKhn8WqYiiqSOo18+CIsU9VoaZFuYtCZWvby3vgJnK3ixy9TTNQwLDSIpBQ93xOm7TIBIBL1MelqZTqjWZuSPWX6I3DotmenlfRZDivtGO27ecN9HnMt67d3T06wJdBGpmAdIeth1ase6fX4heIIIAjqyul2N3b72KxF0LIiHy85R5hvkN4fdZpcCv3pC0JS188LqZp5V+yordFVIcV0ZnuWnlUOmelBpaegou2HY6hHpF+NSi0TI/W6GmGYMMkisbP+yZ9RX6WPlWQS+aUHODEUanTzLRwvj0+AO5RSNjo2mt6Vsqmnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1990f75c-03de-4a44-880e-08debb357d0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:45:54.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTa6KbtbrsxTmEEnJjawZ7YX2UiTRti/QGAzLK1XDw8EYkK9k7SZWFTkK57zdeFZHX3CA8D/k1ZO7M+9GrT49J89NjDnnhe8O4/AyybAYF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9727
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21321-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 986E75D7DD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 22 May 2026 08:40:50 -0700

> On Fri, 22 May 2026 13:08:08 +0200 Alexander Lobakin wrote:
>>>> There are at least
>>>>
>>>> include/linux/mlx4, include/linux/mlx5 and include/linux/bnxt.
>>>>
>>>> Those are per-driver and not per-vendor, but intel ethernet has too many drivers 
>>>> to have separate folders for them.
>>>>
>>>> I just do not think this creates a precedent neccessarily.  
>>>
>>> You just said the other ones are for specific drivers.  
>>
>> Right, but according to your earlier suggestion they belong to
>> include/net, not include/linux.
>>
>> My understanding is that they're under include/linux, not include/net as
>> mlx5 is not only about Ethernet, but also RDMA etc. The same applies to
>> Intel's headers.
>>
>> What's your position after all this? Still include/net/intel? This
>> commit is about stopping scattering Intel headers all over include/linux
>> and set one place for them.
> 
> I strongly dislike the idea there are "intel" headers. Header files
> are not sorted by vendors. That gives off way too much "Intel's corner
> of the kernel" vibe. "net+Intel" is fine, but Intel by itself is too
> broad.
> 
> So IDK. include/net/intel is fine. So is the current layout. Or stick 
> to driver / module by module like other vendors.

We'll stick to the current include/linux/net/intel, a bit different
reasons than yours, but I agree with you in general.

> 
>>>> Folder structure is for you to decide as a maintainer, but it would be nice to 
>>>> have known about such doubts earlier.  
>>>
>>> I'd love to know if you any suggestions for improving the process.
>>> Otherwise please keep your venting off list.  
>>
>> I think Larysa just wanted to say that you disliked this commit after
>> the series went through several iterations on IWL and 3 iterations here,
>> nothing more. It's not about the overall process.
> 
> Intel has a strongly negative reviewer score right now.
> IMHO it's not appropriate for y'all to complain about upstream
> reviews, or how long it takes to get your patches merged...

We don't complain, apologies if this sounded like that.

Re review score -- I noticed that as well and have been focusing on
reviews more than sending patches, *but*:

To Aleksandr:

Please *stop* spamming IWL/netdev with patches. This doesn't help at all.
Or at least do minimum 1 review per each patch you send.

The imbalance you (not only, but mostly) create will only lead to that
we won't be able to send anything at all.

To you and sorta everyone from Intel:

Please focus more on reviews and wait with sending stuff until Intel is
back to the top 10 reviewers and has at least +/- neutral score.

Most of stuff coming from Intel right now is not critical for customers
and users, by doing that you paralyze really important series.

Thanks,
Olek

