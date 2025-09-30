Return-Path: <linux-rdma+bounces-13745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED797BAE5DD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 20:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DBE1945642
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824EF266581;
	Tue, 30 Sep 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARDG0xM3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D572B9B9
	for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258458; cv=fail; b=XRaKjG9/lPRrF8+j28E3enYGn6gVaNq3X9pVP/d2q8rQBRy9EUf0ZMjiEz1nVCdUBJ6SGr0YrtGqUTTeh2dYlEf/ntGHlzDgdtlKinTd+3tSxMhT4wvmq/vP2/en36CSKMcZJLi0zhHalUjAh6d3RSj7GQ7LuFGsvOXtAtmRzFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258458; c=relaxed/simple;
	bh=q/60RhHOJUaFHEyudp7aQ8wSna0xk+G2IXPrhCVX4FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AVh6D50mg2XfVSOY/nlKvoaTGPqeUZcfkcGoOzNMSdbtKBONBb1le4kjB8+mtKVmFiZg2ZHyLxjQ7uDyzFeuwxqZTGIz9iHBn2UK7wZvRFgleQjhtcx4BsHh8c9uRVzWLkQkeaGW2WoYI35aGrzVdkk0pnopP9T1bX0T5ihL1F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARDG0xM3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759258455; x=1790794455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q/60RhHOJUaFHEyudp7aQ8wSna0xk+G2IXPrhCVX4FY=;
  b=ARDG0xM3nHIfUQCnont24BQ/GclNHtnQ69l1JW+CIwVP7aQPhrtHL5Yn
   aLGp1oNl4ZWAnPI+x/f0ju4wVwiNxIQNIwboI2bXhKSSpPzC+gfL2/jeM
   I5erfeOQmGUuoEasI7Lp8X4e1GRLMSnIH/EmqAi2qKcKoqjankoB0KOHh
   YtC5SoiY9K2qv2LB3THyfppbw5oO2QfJ6klFbPYwmHBIth8AmYg+z2y2A
   oK3XL6TmVkTTxZjaYQSmbz1bBhYqN1PAvvZQbBDTL7UMv5RH6LN0xGjXl
   GXvhlW/o3+btIp61q0IXY3rGuYDL1DVWtLGH0im0ijfHDyKKQfAH1FOj0
   Q==;
X-CSE-ConnectionGUID: l1XhyUeORUqbIpbU5nv1pQ==
X-CSE-MsgGUID: I9tdGJiaS7m6WNgUr02bWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="72950522"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="72950522"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 11:54:07 -0700
X-CSE-ConnectionGUID: q/TgDuvHSAOn7d+YkZSKoA==
X-CSE-MsgGUID: FcXxeO7JS6OetjFlDaI9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178183871"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 11:54:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 11:54:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 11:54:06 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 11:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM5WXwRD8Ct5+OuRjWiBPGmvDByx4WPcQBhY6vSO+a+jVFtN0eFPzXnnNHSTykcaCkM2lTlwnswX/MvGUXPXNfOzQ2Lx8huXIwWLcAx4ihdzUNViGxyUV5KjZIPRu5PdftyF67uJYIqTaladNrbol+tqEOCYtkUJY7GBU/kz2/m1lFXq90BUirAGPBROso1DkxKkXur1xHT9UH7Nu/D824xequ0wXqYXkxfrPW/oPKbflTRN+nDdVMIC5fra68zbz8Dyc8myVawceMfLydeNyDVVq9y3XYzmGOSIPi9PL3c3am2apC9L24GB3Oj7+G0gQdEm7Pj8s3Fgena1OZC74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/60RhHOJUaFHEyudp7aQ8wSna0xk+G2IXPrhCVX4FY=;
 b=s5phKgqWYUbS8maT2hdB6G0claVFn/gK6MqQZcy5YYCDAbJty8qzC/8/wUZEIdx8cYowRcIY7F3+ZAdZ+9XMFzQWd25YKLgsUDIj53Q2cdB7LCJTkjKh0LZ+WId+Mu1luWyl3h770hwyqotF76CyzbHlPYszXsG/WIlXmz9h1vvMLRynP9Re2mpdKZnWAgWLTNIQakUZcF8j6+s7rg+dV++lWZrMsCg2m/VhQr+kSsh97x2Mifm/QyLid/2N/GaJVvbamTIvdoy0BwMbsVCRW7wpYRFIRFXeicPGN/1jkx/ySx8KhvxhJCYuhQUvtLP6AxG2sbTqHLwL9j4RjUOJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 30 Sep
 2025 18:54:04 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 18:54:04 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Jacob Moroni <jmoroni@google.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/irdma: Fix SD index calculation
Thread-Topic: [PATCH rdma-next] RDMA/irdma: Fix SD index calculation
Thread-Index: AQHcLL2P0C4op/z/tEWO1vyBNgnN8bSsHThA
Date: Tue, 30 Sep 2025 18:54:04 +0000
Message-ID: <IA1PR11MB77271920C843402FC7BC5CD9CB1AA@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20250923190850.1022773-1-jmoroni@google.com>
In-Reply-To: <20250923190850.1022773-1-jmoroni@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: 600b70bb-3669-411b-d455-08de0052ba60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y0ltV2kvT25iUmgyQk96b09GZG1rcnZ5OUt2WW5KYWZOenhxcU9taWxoZ1dn?=
 =?utf-8?B?MlFiUHlwSGY4SWNwNmRSMVI0MzBFWGR1b3lIaEJsZDJwOXNzSkZuRFlha25T?=
 =?utf-8?B?cWlpTEVrQlhYN0RxK2RpaHltdzJQRlhmNHFmL1RFSWUwVzU0R2R0c2NVVTIx?=
 =?utf-8?B?dlZTOEYxVGpZSjY4NWJWcUpVbk5Rb0djREwxcWJ2WjB4am1oQ3dkM2NIM1lF?=
 =?utf-8?B?M1BCbWZTa3Fid2VqblZVelhqMnU5WlJ4ZUFyVSs4ZDNpbEFRVDRnY0tWbndN?=
 =?utf-8?B?Q1Z3eW1LZW40S240TE9nRW8xbzQ0bmhDeG5TUnY1L1ZmcHpGQUpVUDBqcndU?=
 =?utf-8?B?T0pPVnpKeEhpV0dWNmpCVjduWFo0blMxWFNqVWtEQ3FhRktOZmhhbG8rVXBW?=
 =?utf-8?B?V2VqY1ZJV1VXUkZwcDRiZTVBOHkrMzd2R3AwQmw4WWcweVFUSmFFUnZGTG1J?=
 =?utf-8?B?TFV3VFZtMzcraXpoT09SUGVqZDhtY3lQbDdiQThhd2loRFdMM0ZTb2x5WjFY?=
 =?utf-8?B?TjVhNW5qYmlqbUxPY2tzU0NIcXNDbUdza0JLKzJaOUFnNEJWWll5UkpFdGcy?=
 =?utf-8?B?YUgveWJKbE93d1FXL0tPRFNGMWRkRGIrdFpvRkQ2Tlgra2Y2am1KbEZ2MnNH?=
 =?utf-8?B?KytMVFdjWEphaU0ybDNPZ3BEekE5SGh6c1kzRUlwOUVTb1BjQ0NnSkw0eVdM?=
 =?utf-8?B?eWVLbGU4RzJxbVNaNFdSOGQxVmJ5a2NaSUFOUEpuWmV3dm1NdFQrRVhVV0ZP?=
 =?utf-8?B?ajF5TUV4R1p6L2ducGtZNXFZTDNrQ1h2WXFiZTNJU0RMUGhySkk0cXlkNlZY?=
 =?utf-8?B?Y3ZOOFJRaDFIdVZHblJLMEEybFVVSmRuOHlEWVNyQ3VYR0RYNVU5dDJlb0Zp?=
 =?utf-8?B?ekFSem1ReWRTT3p2eGk2Ykg2L0pacVFhL2xjTFUveGhCRHdQRDJyR0FhOHZL?=
 =?utf-8?B?Z1RtMnZ5dUdBK21VYlE4RW9WRE16bWVJOVpISEFKS2lVK1JHY1VEb3hqT2R4?=
 =?utf-8?B?YVAzZEd4eGxqMXNvd1EyWlRWY2tFV3VLbVYwejNsQ1BGc2JiRzkrbUsrOGhr?=
 =?utf-8?B?VXkwejJlaExTT0pyYW1idUtBQWF6eFpJaDJiWGR2S1JYbFZGaVZjVEVnUkRN?=
 =?utf-8?B?Y2R0UUxVUXhBY2FMa3oycGVmcmZUT0k5QStKMkp0NXVvbEtRVkorVHpndXVR?=
 =?utf-8?B?NmR2ZG42ZWd4L2F1M2R3TVVvbnM1cjZHSXdHZHpWSHFoVjFGTXhlblF3cmNJ?=
 =?utf-8?B?UlMvTjFMOGZkcExQalUxcUk4SVUxNXkzQmwvU21Ib3NxNzZDOUxWWmYwU1RB?=
 =?utf-8?B?M0RQQ1ltRzQxZEFpSE5UZkVZeHVSQS8vL281Z2ZJUXBKUzJ3ZmhENmFaSjVN?=
 =?utf-8?B?ZURpUFV4VWNuSDdWK0FZUS9iWG42dmFWMnlPVnZIalk3aThYakkyMXBKNGJ3?=
 =?utf-8?B?dWtaY0U3QnBqVWJzaFdLZUhxUGVQK21rWm1pa2JPcmhIRWZ0dGc3SmRDdzdD?=
 =?utf-8?B?RGRTWDN4bU9laStvek9KVDl3SFdXQ2x6bXlLaUVyeDBUZUJ2K2NuRjdOcWU0?=
 =?utf-8?B?V1QxSXlvQnpwSUZMK3hZdlNnbE01ZXl4eFR6UHVTMzNYRUY5TjhySWt1Rm1z?=
 =?utf-8?B?RTBmb3lEOGJlMHB0S1ZGTElUOEM5cnBWNE9Vb25kZ2hicGRpM0U4UmFuSG1U?=
 =?utf-8?B?alhxR3hiZS9xQ2tOeUU0SDdCRnk0NFdDOGpnRXdvb1pONmxxSVNicE93Y1VJ?=
 =?utf-8?B?RFRncVQ1Ly9CU0t2OW1vTkZocG56N2kxWjZPSWZJa21kSXcvSWo4WWhnYUtV?=
 =?utf-8?B?eCtYaEdDa0s2Q1JaRmsxUUE2RUhpU3UxZUxpQ0V1d25CSTM1TmcwYUIyUUN1?=
 =?utf-8?B?d3k3RXY3UFlqeTVNYTVNM0c1NjRVRE5qY1RjT3VTc3VZWkNYdXBSVGZVSW1L?=
 =?utf-8?B?bWJjWWRWUEVYdmVUTjd0bFg0djdHM2dYYlNXUFVmdCszUmhqZ0hZVkExYklD?=
 =?utf-8?B?NVQxTjRUMlVSV1lqMjdjY0Zqc0Y2TXUzTHllR3c1aEIxWUxMWHNtQzRObjJ5?=
 =?utf-8?Q?gZbJWu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWFLWk1lckRYRnZsZi9QeWJnbWdTMDZ0Um5kU3FSc1NLN2djVjlWQjdjRWQ2?=
 =?utf-8?B?Q3BkaGxVajg4SUxBSDFXU3l1VFB1bzFCdmNpTDlJNnpYdjc2MWpLaU10L1ZS?=
 =?utf-8?B?VEZyRVhDY1JFT2ViR2J2RDhHMkU0eFVQWG9KRm0vWWdBUlQrZFpRbzV1M1Zh?=
 =?utf-8?B?ZFlzYWR0YlhIQXRxMThkaWRzQ0lJdjVGelhtUUdPY2hCSnNTcGM5UFJQSmVU?=
 =?utf-8?B?NitncjBRb3prNTBkcGR4Z2FRQ2JHa1FqZjF2cDhkVXNac3RmK3lQTStwU1NB?=
 =?utf-8?B?eGFuVk85SUxBZmFFbnFhV1JxQmIrWER3RnJvMll3L2pYQ0FtR1J0SUs4KzBp?=
 =?utf-8?B?Sm45MjJ1S3JXVFBINFRaVU5ZNis1aEh3Nkt2RGx4eUVQakVRQmNaZDdaY1Bj?=
 =?utf-8?B?U1JtRFNvR1BMNFBCL3lMMDFYNm5OQm5DUWd3YkhhQjVEb05Md2Q5SSsrMlds?=
 =?utf-8?B?b3liV0JNRzV5SHVaMWxvRk5DWGswdnJCRFVLWFpKUHcyTEdVbmpIT3YvK3FN?=
 =?utf-8?B?cTlmZzRuUkdUajZDSW0rSGlYdjRwQXpBMWlHSGNtMFUyZnp4cU1VRnVKRk1U?=
 =?utf-8?B?QmN4R0dLcGMwTy9Pc0RQTlkwMUdrcFErZE5EK3VSK29CdHpiMlhvSUJrQ1lr?=
 =?utf-8?B?S0Z3QXlqQWZrQm5Pc253MVZUNzluZzVpYk1taG9ZM0VuM0xvVWZvSlNmSDla?=
 =?utf-8?B?cDBQOHJsNUlzMWthK1dwRzh1ZEo2SGhEdWdhbGt2MTVZdVUwbWtqZlViVlJh?=
 =?utf-8?B?bmExMWxUcnRoWEdobUw5aEJkRXlhSlhYQVJQYU41dG91Z1FheDB4YVlid3hu?=
 =?utf-8?B?TVJPUEZzMXQrNnZVL2pqbDBESXJqd1JRZnZHM1l2M0IwbXZFR3Fqcm5XMHhz?=
 =?utf-8?B?d1RQSnFTQ0l3NUoydVZnNmNqb2xPQThsNDkvRHVkYURPREJDbFk2V2tNQWgy?=
 =?utf-8?B?YmhBRVFHR042NzVwNzhvaU8rRCtXTEZhT2JKUlFoUENqL2RFT1JOcGxFYjh2?=
 =?utf-8?B?QUhCTEZwemp3aTlwRmthUUxZTWhDeG1ZUE5KbTdjYXRhMWM4YVliamxpdFVO?=
 =?utf-8?B?b1Q5dEQ1YjFoV3dyRHpNMXZhTTUxd0w5ZnNUVklnZzk5aFpzTVVmMUpKcjVW?=
 =?utf-8?B?enV4MUR1ckNRZG04aTFDaEcyMGlhQ2FZTXU2NXl4bEdDRGxGd1diRFRGR3Jz?=
 =?utf-8?B?YTQ1dmlVNXhQMHhhWUlWeGJlQjZ5MnpHMUt2RHJOcENOVmt0cUtpUzV6NS8w?=
 =?utf-8?B?N24wR2M0Um5HTW1Vci9VR1pnQkRNUWwzUFkraTRkeStzaHMvQXpXaHcvaC9D?=
 =?utf-8?B?VTJPbW94UFNLZng2UHJHVkxqTVd6ZVpsNTFFc0JrQkVSYkcrRGVXcGJ1M1VB?=
 =?utf-8?B?Ty8ydGNLeVlDM1lBamtjN0doSWw1QkpKajVvQnNCUHFhZEVZUjUzcmtTU3Mr?=
 =?utf-8?B?b1JJeHdSdUVWR2dEcXNmZ0lVNHZ6VWllTDBBYUlyQnRyOWc0Wnl3QnlHZnFK?=
 =?utf-8?B?TFdkdWV3eGNmVm91bXlGdHpLSDNXK3UzNkR2ckVqWTl0NnBONDQzb3haQm96?=
 =?utf-8?B?bkl0dzhVY1hWT1VSeGhGQUFGdzVERE1LdDdnako2TVBIbE1qVFlJNmtZTG5G?=
 =?utf-8?B?aEk5cHhzMzR6Q3dMaDJrUGdQdUpZMU9CVUl1c3pzdHBESGJpaTU0MGI5cEhx?=
 =?utf-8?B?ZEsxRGhIR3pBMFp2eXlLdU0rT05LdjdneENxbXlVRE5ROHdtM3ByK1FndHEw?=
 =?utf-8?B?N2lsb2tNRGtIQzVpbENFbTdLaGo1VWdtTkhuQXRESk85bkxhN1htZU9rVk9I?=
 =?utf-8?B?YW12QXV0aWppbzQ1NUFsLzVjTkE1SE1oM1ExSmtjR1RFeFJTZGFnNWFHL0Nv?=
 =?utf-8?B?RnRxTlRhUS8vUnhHZmY1MjBuaFlEeW11c0QyNUlUcDhtb3NXZ3JBdDVJbXBR?=
 =?utf-8?B?amVyYTJ0SzBSbUozU1lTU1MxRlFjR0lBVTViSnRhYmoyTmx2cjl4eDJtckxJ?=
 =?utf-8?B?UDJ3SXkyenBWUzhZdWx0QWRRS1A2Q1VDWDJMNkgrVHdreHpRNExPNy9tK0lZ?=
 =?utf-8?B?OEt5ZUZBV2p2TVlMNUYyUXVqSUVibEVDMDVFb1JQTW1PbVR0RW1hMytGeVZG?=
 =?utf-8?B?b3Q3VTlUdE1IN2tRZDhLOWQvbGx1Ri9aSm16N1B3WDdoVTQ5ak5KVktCWmlV?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600b70bb-3669-411b-d455-08de0052ba60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 18:54:04.7324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ylnm0hbKCIHylTSmymysX8DvhDefj0m9VjzP4c4Ec1CfQ9BU6NFBI2OfIjIQfheWbi9wG6bwt/iSVSFbxQU/hsoWEIduHvwyUicWfnuvvKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgTW9yb25pIDxq
bW9yb25pQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMywgMjAyNSAy
OjA5IFBNDQo+IFRvOiBOaWtvbG92YSwgVGF0eWFuYSBFIDx0YXR5YW5hLmUubmlrb2xvdmFAaW50
ZWwuY29tPg0KPiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFA
dmdlci5rZXJuZWwub3JnOyBKYWNvYiBNb3JvbmkNCj4gPGptb3JvbmlAZ29vZ2xlLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIHJkbWEtbmV4dF0gUkRNQS9pcmRtYTogRml4IFNEIGluZGV4IGNhbGN1
bGF0aW9uDQo+IA0KPiBJbiBzb21lIGNhc2VzLCBpdCBpcyBwb3NzaWJsZSBmb3IgcGJsZV9yc3Jj
LT5uZXh0X2ZwbV9hZGRyIHRvIGJlIGxhcmdlciB0aGFuDQo+IHUzMiwgc28gcmVtb3ZlIHRoZSB1
MzIgY2FzdCB0byBhdm9pZCB1bmludGVudGlvbmFsIHRydW5jYXRpb24uDQo+IA0KPiBUaGlzIGZp
eGVzIHRoZSBmb2xsb3dpbmcgZXJyb3IgdGhhdCBjYW4gYmUgb2JzZXJ2ZWQgd2hlbiByZWdpc3Rl
cmluZyBtYXNzaXZlDQo+IG1lbW9yeSByZWdpb25zOg0KPiANCj4gWyAgNDQ3LjIyNzQ5NF0gKE5V
TEwgaWJfZGV2aWNlKTogY3FwIG9wY29kZSA9IDB4MWYgbWFqX2Vycl9jb2RlID0gMHhmZmZmDQo+
IG1pbl9lcnJfY29kZSA9IDB4ODAwYyBbICA0NDcuMjI3NTA1XSAoTlVMTCBpYl9kZXZpY2UpOiBb
VXBkYXRlIFBFIFNEcyBDbWQNCj4gRXJyb3JdW29wX2NvZGU9MjFdIHN0YXR1cz0tNSB3YWl0aW5n
PTEgY29tcGxldGlvbl9lcnI9MSBtYWo9MHhmZmZmDQo+IG1pbj0weDgwMGMNCj4gDQo+IEZpeGVz
OiBlOGM0ZGJjMmZjYWMgKCJSRE1BL2lyZG1hOiBBZGQgUEJMRSByZXNvdXJjZSBtYW5hZ2VyIikN
Cj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgTW9yb25pIDxqbW9yb25pQGdvb2dsZS5jb20+DQo+IC0t
LQ0KDQpBY2tlZC1ieTogVGF0eWFuYSBOaWtvbG92YSA8dGF0eWFuYS5lLm5pa29sb3ZhQGludGVs
LmNvbT4NCg0KVGhhbmsgeW91DQoNCg0K

