Return-Path: <linux-rdma+bounces-4667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F439662A4
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CF01C21178
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACC1AD5EB;
	Fri, 30 Aug 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHtxP1xn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B0152170;
	Fri, 30 Aug 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023384; cv=fail; b=uRCCs1IWqaiLl7lMO4SBNM+9RGsIKbXJvqosV7LDcc71tnby6sRK0kk/dT4tLZe0iAx2Ua13ijMilK2oG+H5a73K701Wf5BGSLdq0xL7GFjpjBljuGe8bt0NBcXOpvXTOAy8hsJqy1vTugl5vFDSJt0LhCZSDHW08Q9PUsUHIBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023384; c=relaxed/simple;
	bh=P1W2rkSc0YrPw4D7KxAbhN14jZNGsGSRFKlDOibKAbk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gona5QNQU71RMvKI2kMtCWS5Rk7KLmLh/r86iUD/3xm3uRQ6i/syemHA4rIVHo9V3hdIg0WjdT8YAzOku6hY64npnZgwVy4C/kNVrSvKhh6gMKRJtXVg2F0hrYIHRHUB5yO0P6kTaQaCzkGpC3IesJXMXP9VJo3PLH8eGFBAAxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHtxP1xn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725023382; x=1756559382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P1W2rkSc0YrPw4D7KxAbhN14jZNGsGSRFKlDOibKAbk=;
  b=AHtxP1xneHVMX050YudCm2ZoMUlXLhZqAv1dTXAjfDrmcOjHwn8u6vCF
   JX9o0Tv12Py/MKPmWVwHQHpnUotz13qfyk3ghsRpfqBTP9t88cVa3GAiZ
   DpJg6golc23hV3nzIDr6JE1uR+vdDb/azGMnlaXiTYhtVX7HlWVmSj1iP
   B+65ywt3eEpe4c520Od6yWQFt1HwV16pXjTIzTAnJuP1t6ycxNyr/8ueP
   LK99NA3jVME/z4/IWGzoLHfVv554/flpKffrRW3WJG7/1kuP0+j5aEHS4
   jMAGKPWmMuiSZZKZA0SBYtLVpDKLzHivgT0CyeS7WmubKQh2BzZ4RsT0O
   Q==;
X-CSE-ConnectionGUID: De1PH28EQAiMVWK5YbWTeQ==
X-CSE-MsgGUID: i3k8lINzT4O9EXAwVZ2A1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26559597"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="26559597"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:09:41 -0700
X-CSE-ConnectionGUID: wp7hs/p2SJykdc0YZNOKdw==
X-CSE-MsgGUID: UH853LRsQ+KASoGlyOD7bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64399331"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 06:09:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:08:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 06:08:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 06:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjU0L7wofaJfW6W41Vy+DppPTK2xfD7Z6L1lQtgKqs45fo4pYI3sjhKjtokEc75ZAUEPHOiWjTJmzinKNwDbaxEBfPcdGgvV91XDc/OLUBNqM4W1rwVy4wJu/WzeZQ2BKYB9rtYOpRg14/gDJ80gvskyM8ctWN0/Arw5g8HeMFrCfyQEk4OkGrE8Fm/5SEKlBQLBJkMyu3v+DDjTY9GH6c8QEs2dFGy8+RJ4uXKCkAqNwP7n3qPFXuNLfuo/aGPyu2lrrrmxJ4KNV4/LsYv6QTrAbo8Cp+M/cMOkPijRjNhwmo9vU9DBvm5PT2SrD2+/dfHbNcdGvU6wviiQMAC0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rx126ChN7M+4XjCb+1Hu4iIGFPVrSO4HC1tgL/D744=;
 b=FBfw/l0I0a3SH+/HKi1KV4oRS/z3Lr2uDpsscZC5DzhzqyVrFgINetHno09qw/3N0zbXo379qOyBaa/I0p+3KzEisQM5GvH018xkRXV80+mcnACHrlo285QAhYw5kOkfoW5mX8rHDTOUQMlDhSeUIrPDiKR7PCtnpPBxeL6pqQxhSd8bYCE23D8xEUkhdHWc1XMWghdoQ5cMhhGcSt4au0M0/yOmvSNuQnH5MjnJxV8xcxBx5+G+g64sZKvB+HzRpqGc3Upp+BjiFECJzhlMxben3oYngT+z4XzMbdR2PzI97TqMmWfIrvrurQ6rUjctdWXNGe9PSpsruBUgJJfmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 13:08:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 13:08:15 +0000
Message-ID: <cbec42b2-6b9f-4957-8f71-46b42df1b35c@intel.com>
Date: Fri, 30 Aug 2024 15:07:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net/mlx5: Added cond_resched() to crdump
 collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<yzhong@purestorage.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <20240829213856.77619-2-mkhalfella@purestorage.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240829213856.77619-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0121.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0da9d4-4bac-4c9b-92ff-08dcc8f4ceea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2ttOVlpQk9PMkZFSkdldmRiSHNyZFBRNGQ5cjBPdDFvLzBwcFNzbU9tS1RC?=
 =?utf-8?B?OWhKSFdhUFdYR2FCeWRLaExYOHNqdXBKNUErSmtCUUZEN20yaDY5MnRPeTZw?=
 =?utf-8?B?YlpHWmRLczFLN29IZ2RVVHZOSzVBVmw0V0NHem5aUDgvUUloT0czL2VSMDlX?=
 =?utf-8?B?QkR3blRGYzJ5U3UrRU5zaUlMbWgxdVFTb05QT3VoMjVaWGRXc0p3YlU5K1B0?=
 =?utf-8?B?cXQ2czIwUnpTb0FTbDdEMzJzNlZtVHFYcW1jM0tpVXJFdUY0NzVzMWpJZDhl?=
 =?utf-8?B?UkJmaHZzQ1pqRVRGRk1wc2FLc0NxcHpVbjRzVzFTei9OWnU4TkVJeHpwNkxR?=
 =?utf-8?B?VTlZd0NSTXIxZmJwNTJUUzBIQVZkNmx4eWNMdE01OFRUOU9KU3dwcWlCU0Vl?=
 =?utf-8?B?c1FScERMMlRiRndRdTV0Y3BCaWJKNUZkbmt6OHcrdm9DMDQvZU05aHhxNUNo?=
 =?utf-8?B?dVBIRXlwQ0JtQTNDd1JsbUR1dnJ6RmVLQzZ2Q25Vd1gvRGZjc21BSWRMeVUv?=
 =?utf-8?B?RGxLUDNKM0NwS2RSSlpZNW5VM2hWWXphdENkSlo3eGlBWlhTZk9DQ0FlMnF4?=
 =?utf-8?B?a0JxNk9yL1hBbk52bWF0Z0I0N3R1VXBWY2Z5aFg4SzN2NjdOTFRuNUVia0hV?=
 =?utf-8?B?Y3EvT2JkTUxlbnRQajB1N0FrODdlS1cwSUhvdDVBenhVWEJVNXpTdzI0SENy?=
 =?utf-8?B?d014c2hMaXRTdVhwQVo5UnFWNnVGVHFpMnFCQzdleG9MMVQ0WWJzck1mblFG?=
 =?utf-8?B?Y05xU2w5K2tYVlJiU0Z2a0djdldYRXNRN2ZDWHpsRmo4ano5ME5jNEdDRnAy?=
 =?utf-8?B?SmY1WjlmTERaeXk3M2ExWlVXVmUrOWRBa0ZVd1AvR2N6N3lna2FuVjR6L0tD?=
 =?utf-8?B?Rk1XSG10UkY1TEh3b3VGWTltL1grOXRiaExEZFBxMnFndkdrRTJvdmU2ZDBP?=
 =?utf-8?B?N0xPdm8vZjJ4d1BLM05HWTBwUjlUeHE4RytUVlJVQ3pVN0loZHVEUHFBSVdO?=
 =?utf-8?B?UmdyV2hZTmd0TnFYWTFGcis2ano2TitoTWNlblVqVlVMSkJ1UFVmSVM1V25s?=
 =?utf-8?B?V1A2NVhjRVZ4YWFJNU5OaTJIc0tUZC91UkdkTG5XcjlUM0FhQVhObVh2Sngx?=
 =?utf-8?B?ZS95STU3Sld3bnc5Mk50cFhlU1l5QmhjcjFnNkFCTmRHcXRKV3VUcklzZ3Av?=
 =?utf-8?B?QWR0WkVZd09XLy80V3FUZ0VIVFhUWkt2MmJkV2dsQzlJT09rNUg5cUVoa21P?=
 =?utf-8?B?STBQbG5sSXdFdkdXeDh1cjRtZjJjZk55ZHA0akRqTUJpWXVWTitPZ2dNY1RV?=
 =?utf-8?B?RmFkVUxCU3FCa1pSa0RmNnA4eVo2bTVCbkdRVVlhNi9vS1UzN2JxNlpQSEZ4?=
 =?utf-8?B?Z2Q0RGQyOTFZREZ6S1RRdWNMRnVTY1MrTnEvaW9wL1JZZkdrNzFiR3Z4WlhJ?=
 =?utf-8?B?bXdBa1RHbXRaeU96TWh2RUJhSTRqL1N6RGFNVEp5Z2NxbEFIaklFeDh0Wlox?=
 =?utf-8?B?NmE2SnBOeHd0WFFDRDZ5T3dGdGIvOGRKZ1p2bzB1TmdoV0x6aGJHYWNSa1VX?=
 =?utf-8?B?OTVoY2tQajg1VlBaWnEzNWJCMzh5S1BoQVdFK2QxUW5YK1psaVVqMmtTOW54?=
 =?utf-8?B?Y2RDQ0FYTjl0OXZ4dEtlY2I2ZGNPY093enQrNVdjNnVYL3Fnc3BBeDEybFlp?=
 =?utf-8?B?czdIUjdmbUxTNGVOSkZBWUNhRWJGeDdtYWJIZ2tnWDY5Uysxcmc5UHNGRzUr?=
 =?utf-8?B?ZWdpRTlBbTJITHNic0FhblpsMVZpZkM4QmJ3Vkd4dUdBMHFia1lBZktJTVl5?=
 =?utf-8?B?R0VrOHlUZmUwcUdoMGUxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJuYnNTdHRsZC9QbFJITHhHMytiSzhDRjFab08zMzJoVGxVVjkxNlVOTGZP?=
 =?utf-8?B?THRtZ1QxdnYrQ2h3YWtIajdhMXNIek9YZnNVWVdwME8zbXBaNWR3Sy9iQm1z?=
 =?utf-8?B?RUhYdmZvZVdnQTVENXkwdnV2N3MwODZxanl0Z3VFZ0Y1enZrUXhvVlBpcWwv?=
 =?utf-8?B?cFUzSExXM2VGQkc0ZDd5ejMrVy8zQWdQTnNUMUp2d0FCNmgrcndBZ2NsQldM?=
 =?utf-8?B?UG9OOFloK1A2V1l6bnVmdndwNW5pTW5VcmNEYzNLM1ZQcWVYUUwvYVZ2eVVj?=
 =?utf-8?B?YllmMmNDT0JJaUN4ekluT2dJbHdFT0NlblgrUmZqZmJBaHI5cFlvZVBYQ3g3?=
 =?utf-8?B?cm1mK3NERXJ1WkNWWkhGeGxYWjhqS1cyN3BXK2t2RXpReWZUVDBHRFlBUE0r?=
 =?utf-8?B?WEkvNmZrT04vNG9pQ3l5RXVSc24wUlEyRzAwQ3dKRlNITUk2QVVnVzdKN0x4?=
 =?utf-8?B?TThjUGVtaERuY0lqcnJ0N1hWZzVFRDVJdHFBWVdEc1c4eGdSMFpuSGZvQ0Zl?=
 =?utf-8?B?eEVtYjZWeFZ5M1hIS2pJczlvMzJoNUZiNHpOSTZaK1pFNDQ1TlNmRzFQNlNs?=
 =?utf-8?B?dGwzOHl2ZytzOWJDSlZiQXBSb1JIUzZ2NzlOdkpZRDR5dXZEelJiME8ySzFS?=
 =?utf-8?B?cFp2VWdTWjE0bVNhdkF0L0xXSGxydnRmSEZkZEdVbjA0UUt2c28wWmdreGVK?=
 =?utf-8?B?MFdWNUpzR3ZUalQwelB1bHp4NTd4WUZiT0R6Qktna3grZmNOUndidnNJMmEy?=
 =?utf-8?B?Z1F2R0dacE9NbXVjeE9yd3FYRUM1STIyZ1FReFR3cUFMN2ZtOEdiZWg3dFpr?=
 =?utf-8?B?VU0rem5tZ0l6a1JwajFQMW41Q01DZ2pORlluZnFseDNQV0R1ZEtEc3pHL0JP?=
 =?utf-8?B?TThMbDRET2VKcTVTUDRiVmdUdVlDTERlYnIxaUN2enMrOWtVRUNULzBNTFI4?=
 =?utf-8?B?L1U2eVp0c0lURkxiZzE5S2pTQVJSckZhOWtqbVhuVDQxRGxoaW1hVUE0L3Rj?=
 =?utf-8?B?TGhuN2R2QStNbGxpMVBtYzBSQW1UTjFSRGhaZzlWL0lPWVgzK21JWHBTajR2?=
 =?utf-8?B?VGw4UTlRMkhENUVGZ3d1cld6Vm5xbzFQeXB1UjRLVEIxVE9iUjR2ajlGMytD?=
 =?utf-8?B?dGZIRUNxeXVZdjExSWhkWnc5a1NTS2YwNEtncXFEZ0x6enFzbmxtclJTUUQw?=
 =?utf-8?B?cEpLeGpYVzUrR24vUnM5SUlOb0RlSWE3d0x5eW93MWFpZ3dQU1JqMm9icjk4?=
 =?utf-8?B?VmtvY0JWQ0tVdFd3ZG5UWVZsRXJiMnVDNWR2YUlxL2lBODY5bGFYWU80L1p0?=
 =?utf-8?B?RE8xeU1GbWpocjQwWkFCRFZWd3AyNGN6dnlBaWRUWGdKR2ZrZjZUUjRGNWdX?=
 =?utf-8?B?b2VSY2JyR1cwbVpuWHgyb1Y1S1dvQ3BxQjRVcm9HdkxEWTVTelhLZ2tjaEor?=
 =?utf-8?B?Y054b3IzaDlPUFdSMUJ0a1AzcDJOeU9yZnhVMVhuSGkvT3FKR3V1dktsK3I2?=
 =?utf-8?B?RGZYWCtqZGk4TG1SRnMrMnVYcWpXZFdSYzhXVkc4RlRZaFFsODkvS1JyRWJx?=
 =?utf-8?B?K2t2b0FlS2hyKy9EOHJvdHNpRjlsTm1EcUc1dlVQTERhWGRHdkRCaDhCSEZt?=
 =?utf-8?B?YjJiMXZnOU5OeDZCZXBVRWgvK29uMlp6c0VRbnFKSHZYcm5PNWdIeCtsQUZF?=
 =?utf-8?B?aTZyVnA4Y1dZWkVJdHdQcnVUc2NMMS9mL05ZaExiZjFQa3BsUDA5MzBRa2NC?=
 =?utf-8?B?KzI3MU5lZ2RxWkJNQ1F3cUF0RExWbC80L1JUWDNGenJYT0lHbWxWdzVZVHg1?=
 =?utf-8?B?cTdIUVV0aDZxeFhEdElDekUzTCtwRnpKdmhtMWI0dTl5RTBhLzdHWi9VdTRK?=
 =?utf-8?B?V2ZqODJZN3dnbHp1dE5GamxRVEZsL1lqYk5tL3V2MDZvNlhBVmZSY3Z4VjJP?=
 =?utf-8?B?Rkh6T25RUVBZNVVPOFVGWStuK3U5S2srTTZ0SktJMnhIMHdPZVluUzdLM25I?=
 =?utf-8?B?N1QxU3JjTkRPTENMRjB1eE1uYk9VQzF0MWNWdWhwZDJqemdXWi9PaTlWWXJ0?=
 =?utf-8?B?TnZSL21YZTZkK0wwOG9ZMlBpQzloZVpzeTBBWUY1VWJIZ01uc2tMQVZvd3Fp?=
 =?utf-8?B?YWw3K1VaQUxHdDFuMEcyc1NId3JLb1ZtaURHeVhPM3BNd1RzSjF3eTN0TFVU?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0da9d4-4bac-4c9b-92ff-08dcc8f4ceea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:08:14.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRCChQN9okl9olrjnzPUxOROI5H8UhzEMYkznCEQR1O9UeShx9jxX8M/YnOHFgze1E5lgZbnvLSsMhMgiGrqlF3aOErvdgryuyhHYWvMStc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

From: Mohamed Khalfella <mkhalfella@purestorage.com>
Date: Thu, 29 Aug 2024 15:38:56 -0600

> Collecting crdump involves reading vsc registers from pci config space
> of mlx device, which can take long time to complete. This might result
> in starving other threads waiting to run on the cpu.
> 
> Numbers I got from testing ConnectX-5 Ex MCX516A-CDAT in the lab:
> 
> - mlx5_vsc_gw_read_block_fast() was called with length = 1310716.
> - mlx5_vsc_gw_read_fast() reads 4 bytes at a time. It was not used to
>   read the entire 1310716 bytes. It was called 53813 times because
>   there are jumps in read_addr.
> - On average mlx5_vsc_gw_read_fast() took 35284.4ns.
> - In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times.
>   The average time for each call was 17548.3ns. In some instances
>   vsc_read() was called more than one time when the flag was not set.
>   As expected the thread released the cpu after 16 iterations in
>   mlx5_vsc_wait_on_flag().
> - Total time to read crdump was 35284.4ns * 53813 ~= 1.898s.
> 
> It was seen in the field that crdump can take more than 5 seconds to
> complete. During that time mlx5_vsc_wait_on_flag() did not release the
> cpu because it did not complete 16 iterations. It is believed that pci
> config reads were slow. This change adds conditional reschedule call
> every 128 register read to release the cpu if needed.
> 
> Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> index 6b774e0c2766..bc6c38a68702 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> @@ -269,6 +269,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
>  {
>  	unsigned int next_read_addr = 0;
>  	unsigned int read_addr = 0;
> +	unsigned int count = 0;
>  
>  	while (read_addr < length) {
>  		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
> @@ -276,6 +277,9 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
>  			return read_addr;
>  
>  		read_addr = next_read_addr;
> +		/* Yield the cpu every 128 register read */
> +		if ((++count & 0x7f) == 0)
> +			cond_resched();

Why & 0x7f, could it be written more clearly?

		if (++count == 128) {
			cond_resched();
			count = 0;
		}

Also, I'd make this open-coded value a #define somewhere at the
beginning of the file with a comment with a short explanation.

BTW, why 128? Not 64, not 256 etc? You just picked it, I don't see any
explanation in the commitmsg or here in the code why exactly 128. Have
you tried different values?

>  	}
>  	return length;
>  }

Thanks,
Olek

