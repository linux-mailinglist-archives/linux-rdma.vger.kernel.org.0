Return-Path: <linux-rdma+bounces-6855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B5A036D2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 05:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362B93A1B42
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599B13D638;
	Tue,  7 Jan 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UXIlGcZ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3586349;
	Tue,  7 Jan 2025 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222687; cv=fail; b=ECduDZvI36dMVnEXQ/J4Az4hap8jF0joNJ/yRXQ3RhGJn7gcQrGmK/sD0VQhJMnC8D/bdfP+e7n+3YXa1T9aeEmCAaeTzAYC92dtw7DyuzZbqBLHpD1FO9bipwNgXNlg6MCmgxxhwf1jlGOTQ5RUqrHoyE6xPVmBEN+K6kqyWMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222687; c=relaxed/simple;
	bh=MffsqS7K2q3GHR31nSZDSdvQPKjeH2DCW93k1TsvOQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NdWxuQ07BbtZvPDpHXaHw0G7frl37zr8G83N8k6P7NvZgz2WagSIGakOs1wLQnvd7bntRs63PxheQ59T9BY/WhmwyD9TrxLm8sZj82adKcJGM7jWDO9Y7NSNFL8Ia0YSJyXfs3k5p11OJHtWtTla+mltwUsFsNOtROKlTXLMTss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UXIlGcZ4; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736222684; x=1767758684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MffsqS7K2q3GHR31nSZDSdvQPKjeH2DCW93k1TsvOQo=;
  b=UXIlGcZ4BB8ETJUxWAktv/ZwW0RIeGLcQ72c+woVXDcmOcO1Hq7oeDLK
   v7cfg4u2bE+u10pLZFiUsnOez60DKZg3nTIu8Qu7qCZCBe1FtyNEMtzBW
   5pb7vus0FqBzHUHyrshadcjrEa6JoFtIunZpJ1RuL9wiaMbM8KTs6CAOE
   Ujh7nPhTcIHonfecKofWA05YkISe6sTUJGvFQe1+IZmzfQ7Lk4mpP3ojF
   9De643S19hBbjoKZCnRF1VU2w7vkJkeo0CXsV0lGht6v99pvJrtxMQz68
   0q5Ui/0HxikaRODvjqCj+Tkrb7aT/U+J2qNFs3uAvKdcCjY9Eo3lc2+hG
   A==;
X-CSE-ConnectionGUID: PxU6w9eyS4ONxYCU7Dn5QQ==
X-CSE-MsgGUID: KF0G3rjJTHeNVPQMApkgyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="142555161"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="142555161"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 13:03:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4KlgjNvb/BgvdIhLwmDGqaF9xhv6Y15YIGAUkle4IPaKfrU9ef9E/Opj8RD7nQwsNo8hXR9cFDkEk9WyNYVKXg28dQSMDPpWHFOGaZqentAgMJsn+XGPDvrPWyRa1Uc5gQwYtQjzTjJ24FaPwW9PQse3pGm2O0DJ2KDUPk7IXpwkZTreD/uQI3zLwHsecAaV8szPMC1sxIdYFxjIHw1IxXEyg9APRSNsOc9C4CzzStxJ+mfMNbp2gYfmaz7r3a8mvVj6SykiUCMRMMi6RaDUG97rgr6BDqwnT0Km86m2CjD2GmBmiJD6+DQTXuoZ7wastPghVuLfkUnC239sEUU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MffsqS7K2q3GHR31nSZDSdvQPKjeH2DCW93k1TsvOQo=;
 b=tAC6in4G7W9dcGicjMcVVQId3VxcHmp8cKAY0XL420i3Jic+QdG/49tSpsGTjCaAzDDi/7rXCzuv66Y5rGV9/flD4Gb47b2jHvBv/wAsd1qzJC9FwECifj10T8NcIUOs83aX9JEfr2y5Ojm1Cp88qhpZZgIS3rXA9c1MYcBCEZFc9Lestl//Zzv7eaefBvwQSZGJCX6oXfIHNZSMv0rdKWVMiVnNE3XtpClBA5WIIn8t9RvoGfDrz3zxJeFfUMs2uORRcxmXvOn5aZMuwNjx3ulQKhaL9kqWLuugtzuwxAUTj5NRe1LKsJcoAkqb7wi93RSXCgAKO8TrYMeSEKpcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB15021.jpnprd01.prod.outlook.com (2603:1096:405:25f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 04:03:29 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 04:03:29 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests v3 1/2] tests/rnbd: Add a basic RNBD test
Thread-Topic: [PATCH blktests v3 1/2] tests/rnbd: Add a basic RNBD test
Thread-Index: AQHbXY5Stc7IpFpvp0StlkkKupBbhLMKlckAgAAhUAA=
Date: Tue, 7 Jan 2025 04:03:29 +0000
Message-ID: <070d22b9-8367-4b30-a88b-8bc1dd441303@fujitsu.com>
References: <20250103031920.2868-1-lizhijian@fujitsu.com>
 <bdla4xc6cza4a3nzcr2vwbj33kuxmqgv5o4rzoxp3sj3cbnzsd@vcpz2z5lkvtg>
In-Reply-To: <bdla4xc6cza4a3nzcr2vwbj33kuxmqgv5o4rzoxp3sj3cbnzsd@vcpz2z5lkvtg>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB15021:EE_
x-ms-office365-filtering-correlation-id: b509bb70-c3a8-4bfc-686c-08dd2ed03e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?U24ySnFWYkFaYktGbzdGNWJuR0hacnpZOGpWQUdLRHd3dGxELzhvVDdYVmpM?=
 =?utf-8?B?TmpoRVY4eE1KR2JGR2xXOHhFNUpvelBZa0g3YTFrc3BvdGVwSmJhdUhoRzhT?=
 =?utf-8?B?WTZldDBhTk9JR1JUKytQTmFpVW9MRzBmMlVrbS9jbGFoZnROZk94dXM1Ynoy?=
 =?utf-8?B?VE9ZTHl3ZHZNbTZSc3hvSVM3b2pjQXd5OUY5VVFXRTlIWGt2bzlRY0lTdEd3?=
 =?utf-8?B?WHJxQlJKK09ybExGM0w3azB0U29XV2pYUWNFNkYvYzFFTkQxSWRqdGl2N1lh?=
 =?utf-8?B?ZW1kTFBPTHJZNlFZSTdYNEkrbFg3TEhBL1YvbkxvTFhoK2cxTElka1RoMGZV?=
 =?utf-8?B?ZFoyVzdHOEM1ZjljRUhWMlIzcExzRmF2TEt2TWJrRTU3andlS2UyalFHY05N?=
 =?utf-8?B?TDJKTWlISWdTRGpDSFJjSE9mRUh6dHR3TUJwcGhjcGVOSTROQmtzckhyRmVJ?=
 =?utf-8?B?bHQzT3RFcVNoQ2RCVnBIT2k3Q3hwcXhDdHBOL3V4bC9XNUV0WE5Yb3k1OGpT?=
 =?utf-8?B?TDZzanBmelhGSmxORDNFMWl6L2pXV0xQOTB4S3JmZHNQN2lsdXZwT3EwaGZq?=
 =?utf-8?B?aXc3MmpnUG04d2FnUDFxeFU4VWM1eUNnQmtRRFBVK3lSQmJiNE5kYkVtTlFR?=
 =?utf-8?B?N2cwN3FZWFh1bVdEd1dTYnQ2V3BSV0RWbFZ3RjFHUWkxK3F5SGVvMmpEQXk4?=
 =?utf-8?B?TzEzczB3eDhZZjVySjR2S2M4N1h0YVZLUnpnU0Q1amdWK1o4SVA2UEtzZExJ?=
 =?utf-8?B?UWVnUk1GNUtmMVMzNVVZRUVVQnlIczNuQWQyUzk4dVBidVRFTkwyS3NSMi85?=
 =?utf-8?B?YUpnTlBOM0N1U0lac00relJLbEpGeXlDL3dwRUFGelgxblhaSGtBd2lNNWtQ?=
 =?utf-8?B?YWI1TmI3Z04rQU5Kb3NyQkFNakh6SWxUQTVlem5OZ2l6WVZEQmRDSEE5MFhB?=
 =?utf-8?B?RzZ6eWZwa1JEejRUVzRaM0Y4VC9SdTZUaEd2T29BSjdEVEYwRGlIRzJCcURM?=
 =?utf-8?B?L2xUdWIzUmNEZFg5dG5jbmdqRWU3dTREMkZWQmtyVmhXanNzTjgvd09pZG9l?=
 =?utf-8?B?dUx0R3NlelluVVVNVG1UZGpBb0Y4NWpBSFdrUmVWK0h1Z1lBdGZKUmlrSEE1?=
 =?utf-8?B?T0JPYlFTMCtVY0dkOHMzNStRZDJCZmdDTHZld0tTaVRRRTd6L1htNExRV2J1?=
 =?utf-8?B?ZVFtWFlxRWdiUUN2VE1Ydm1vbEhaeDRvRE5kVzhaSWVnMXpOY3pHTHRlRHln?=
 =?utf-8?B?NHQ3L2JDbUVISFZ0MDJkcU9kZzNoU3IreGpBWDQrU3hkRlRYcFpvRUd4N0xa?=
 =?utf-8?B?c3ZLUDdLM0tqMm0xUjYrc0J2YUxySndTRVZqajFIblVjYVppOVJxbldFS1RI?=
 =?utf-8?B?endrZWtDYUZQZ1NoYmI2TUU5cDh2SE1jZTJDMW1VWWRseFlMamdpRm5sYkFL?=
 =?utf-8?B?WFgxV2RScmNhM0NGbWdiREtaUFVmMW91UE1DNDVMV0MzVjBadElEMldwRTVE?=
 =?utf-8?B?WWdLZWFlYlU5QjFRaHhHRExiT21PQUF4VWk4d0RBV21KN2VpVVVZYVAvT1N1?=
 =?utf-8?B?ZGxCS2R0d254aDV1S3d4Y01PdDVlZnRUQ2ZwUXc2Wk5jSkhYQ3k1eEpaZUpm?=
 =?utf-8?B?UTUvajViL202emNoRzFaWmljeUNHdmtWbTlTc3RGVFFYNko4Ly96aTJYZ1FQ?=
 =?utf-8?B?cXZyNy8zU3hiSDJTRzJQVWFLMXI5ZmcvWkZiZ0xLd0QzNG45V3R5WXE5aXVT?=
 =?utf-8?B?V1FaOE10aDlVYVZMV2s5Qy8zYWJ5VnQ1RlgvNXNROGtmQm4xU24rN2RZd3hq?=
 =?utf-8?B?V1FUbzFyN3hhWXJEYnpKeFhSdUtuY2FhZTZNNHZkY0NzeGIwckQxTFJQOFVu?=
 =?utf-8?B?V0paZnNTWllRM2VMdlMrUk5hTkwzVncxU3I4QWgxc1k1YmtaVkZraXZIUE4v?=
 =?utf-8?B?NHluaHIvMEVPN1FRU21TMmZvaGhFUkVmcWtZVTRseUlXZUpDSk5TOXJvNCts?=
 =?utf-8?B?NEZwaURJKzRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bi9uT1V6cEw0NnhtRHJTZDFUTEdSNzhDdnRPYktpZmo3ZVV2T1l6MWt2cUg3?=
 =?utf-8?B?ZmFPUmJzRllYek9Pa0JDMUVuVkRFWHFvZlFLT252UllsbzVpU2NxUzhuVnVn?=
 =?utf-8?B?bjE2WUI0aG85eEdJRktNZXE3ejVyRWhMeTJtZUc4dzAzNVdFb2pvaGlnQ3g4?=
 =?utf-8?B?Rkp3cVBsQ2VBaTRsQmtBaCtXL2FzRjV4S2xXWkFPSFF6OWRBaHFIQWF5amNs?=
 =?utf-8?B?cEtyUkVNa0JkN205TnE3bmJ3UWY3cCt3TnNwY0ZVbmMwVTN6KzVTVlhGbVRw?=
 =?utf-8?B?QjM5M3U0UVduRFV5a09pYld0U1BzVlo0VFF6dlVRelFnbk9VenRRdGlveTEx?=
 =?utf-8?B?emV6b2trbDBTU0hMYzUzUlR1QWhWZTlXUGZ5YXdMS3RMSmU2Y3FVODlOWDRS?=
 =?utf-8?B?bEVVc1ZzTVlmMkpMU0xzMiswNzh0SG14NHZiblExK0dZZ0J4RGpFSzljVTAw?=
 =?utf-8?B?N1RTVWhqTmo5NGdYQmJmbjZKdm8wdjJhQ3l1eHhwZGFLNXYvUUtJUTFDenJn?=
 =?utf-8?B?R3U4UUlVcysrUUNBdGVucnR2Zy8wTnZHT05WQm51ZE1LOFhOZ2F6M1owQW9W?=
 =?utf-8?B?QUlIeGgwM1UwZmp2cUd6K091UDR6OHdzalh0Wkp1RitRNHEybGRjRXBIV21a?=
 =?utf-8?B?ekdKQjJ4R21tUmt5NU04V05LUk9QOTEwa3RVRWpVd3IvTTYvd0k0b1Z0MEZK?=
 =?utf-8?B?ZUpuZWx5ZmdscmZwUFlNUFpEalFXdWZDdllueFoxdVNGQ01YYmt3YlZEQUdo?=
 =?utf-8?B?WUFzc3J2NnVKOGFBVW95K2Yvb1JRZFZPYjFVWU8reVpsMDZaZytSc3lSdDdn?=
 =?utf-8?B?aXhMaWZxVGEraWNqVm15dFR4MEVVRHF2V0NOemVtb2QxdWU2SkxMVmNMblR5?=
 =?utf-8?B?b0l2SjVWQjNKc0FnZXFnM0EreXpOUWMzOFN3aEo2YTI0MXJjcS80aG5Ib0Qz?=
 =?utf-8?B?K01ody94NFFFZGoxa3NYRWRFamdhWlhSOEJrUmVhUEhTYk1jUm1YZzJCbmp3?=
 =?utf-8?B?R215TXhLS2xtZGQ4c3VVd2gwZGxCWFE0WWtmOUdNS0ZEK003endXQlZoVXVK?=
 =?utf-8?B?d09QOGF6UjcxLzdOMnNXV1d4bmM4b3ZqaDJHU3JNWUVRZTdnTXVQRVBHdXlB?=
 =?utf-8?B?bm1vby9MNUtIcXRRd2FyUFh3ZFZsRUlvaDUvTURHMGwrWXJoYlRBWmdrbUxV?=
 =?utf-8?B?b0VnU2I2emc3L3ZSWlN6TTg3YTdMSTNMejlHbWQraC83N1VpYXlrU0hCU29N?=
 =?utf-8?B?OVpkdWNxUzVuUU9Ic1hYVGtaRzR1NERuNmpQT1d1YThRdDVzR2I3NkM2cGRU?=
 =?utf-8?B?TXdYdFk1Q0hYeWJQblFMcGM2cHBvcmVxQ0tMNnpLbytoZHlHM05KZ3ZLL2xG?=
 =?utf-8?B?VkhIMUNVdk5xbDBXN1RVTVBybWpCU3A3U0JsZ3FydGFyUGY4TTF5RGxRamZz?=
 =?utf-8?B?M2daKzErK00wU3oybm0zVm1hYUcxM0ZqczFTa3pNcXR6WjlTNWZURjRZdHJZ?=
 =?utf-8?B?MmlrdCtHZWlSMDBxVmo5cEltTHVUa24zRVZsTC9uYlFEcWQ1NCtSOFNGdDFk?=
 =?utf-8?B?UjNCSEw2bHBYdy83TStWQ0ZiYWtsV3dZNysrOWFaNGtsVDloL1FnRnJSMGVn?=
 =?utf-8?B?SnBqeDBJRTJTREpxMVNtUVhqaEw3Z0FyTDgwNlJrdncxR1BnQXh5Smg5ZTFW?=
 =?utf-8?B?eHk4cDZtOGxFVWI5MUlOK1c3dGhPakpHVDE4L1ZRQmc4ZXk0Kzg5amlNWitw?=
 =?utf-8?B?d2hzZDgxZHBmaGFBYW53bFlYN3JqRHhxTEhCU3NJV1BNSXlBRTlFQVdPc1Fk?=
 =?utf-8?B?aCs4WnZIUW1zVURtSVBVbDl1eGpBRlJlRUtvS2VLM3VFdkFYVjZGZWpZbkk3?=
 =?utf-8?B?eDU0c25weW1maVZBNzdwN0JRcUgxdDdSa2JjVy9PY1lmYVRacDBPMkpIbzJN?=
 =?utf-8?B?anJNMEEvVjJjVnUvTHRDTU9INXhLUVBqZzMzRWwwSFppc1NrUmw4WXBOVW9P?=
 =?utf-8?B?ZmNNTW5hSStrcWtPbGhlYWgzSDFBWkQzSWhIUHlsQVF5bTBBMGJWNEQwV21m?=
 =?utf-8?B?Ry9MeEZjVEtwL0dDMHNQcjlxdXgxSmdMZ083Z2QvS2Q4VHVDSzBkOGhYVkw4?=
 =?utf-8?B?SzdiZ2NIRTM1dXN0RXhDZnAvUTZjWFRlQitGa1l1S2U4ZnNnWkUvZGUzUlZy?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EA4051896C7464D845BF459BA624F5E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qbyuQG2nC9Gs0RZ6tz3pjLmksqNJnREI65gMi7rrXTYq8FzR8l+tS/1VS1X6xqp6EKbq7RZwSZrRJyeQYM9g63RHUd2NNx6LDZ1xppl+hdmFXd/pNtgNOx4ql6ozolBPICpD5J6HLBPasxzFKHqxXkW44rdH3kEIJR2rUrGfbNnZqh166q4TKoUjgnWtb2V9atHCXfBOUMp96ExgFV4CDLwyyG6I3mWSh7ZnEPLmSZSS2fn6qMgN/XKY/TtThVOo4jONRbTRCXewuAsHk2kfd+HtkDYHV/2r6+OsW9q8eQRBtGabjAiXySJNb0nFTUBoHO8Wp/v1k23MAIhb23dcYoFj3c+7DMPMgVIzXJmKbKoCinUibrruW+XYzG82ib7Zs3F8WKRWEVm1zrAXGIsU+gyhdKwRPevfM7ehV0LOnJru4VKpW7Jo9Im0V/lM+OkhdXZ6wpQKCCnBsYIDF3V8yt6tXYBsY6pQL29RuaQCWXKo2BS6Z91saHZP6weN52j+X9JhFQafVvAGKWaMnsxL32NlRuJGqq2d8xTuxwHliD3pkon2KulluMAKGU9+cylYKlVRRr0cbYZD7zxQ6ZdbCpgy62ZYL83xJsVQD7UY0O8H+leIwA5dXEZrxyILweE2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b509bb70-c3a8-4bfc-686c-08dd2ed03e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 04:03:29.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20EVOXOhNrztw4mbdTwZIxjVtPbBcBzN+k+c72/plqOlWNuyNUYijTGDBUwmGQk/0ksxhjmpjxbv2f4dz1lLLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15021

DQoNCk9uIDA3LzAxLzIwMjUgMTA6MDQsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9u
IEphbiAwMywgMjAyNSAvIDExOjE5LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gSXQgYXR0ZW1wdHMg
dG8gY29ubmVjdCBhbmQgZGlzY29ubmVjdCB0aGUgcm5iZCBzZXJ2aWNlIG9uIGxvY2FsaG9zdC4N
Cj4+IEFjdHVhbGx5LCBJdCBhbHNvIHJldmVhbHMgYSByZWFsIGtlcm5lbCBpc3N1ZVswXS4NCj4g
DQo+IEdvb2QgdG8gZmluZCBhbm90aGVyIGJ1ZyBhbmQgYW5vdGhlciB0ZXN0IGNhc2UsIHRoYW5r
cyA6KQ0KPiBQbGVhc2UgZmluZCBhIG5pdCBjb21tZW50IGJlbG93Lg0KPiANCj4gWy4uLl0NCj4g
DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcm5iZC8wMDEub3V0IGIvdGVzdHMvcm5iZC8wMDEub3V0
DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5jMWY5OTgw
ZDBmN2INCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RzL3JuYmQvMDAxLm91dA0KPj4g
QEAgLTAsMCArMSwyIEBADQo+PiArUnVubmluZyBybmJkLzAwMQ0KPj4gK1Rlc3QgY29tcGxldGUN
Cj4+IGRpZmYgLS1naXQgYS90ZXN0cy9ybmJkL3JjIGIvdGVzdHMvcm5iZC9yYw0KPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMWNmOThhZDVjNDk4DQo+PiAt
LS0gL2Rldi9udWxsDQo+PiArKysgYi90ZXN0cy9ybmJkL3JjDQo+PiBAQCAtMCwwICsxLDUxIEBA
DQo+PiArIyEvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4w
Kw0KPj4gKyMgQ29weXJpZ2h0IChjKSAyMDI0IEZVSklUU1UgTElNSVRFRC4gQWxsIFJpZ2h0cyBS
ZXNlcnZlZC4NCj4+ICsjDQo+PiArIyBSTkJEIHRlc3RzLg0KPj4gKw0KPj4gKy4gY29tbW9uL3Jj
DQo+PiArLiBjb21tb24vbXVsdGlwYXRoLW92ZXItcmRtYQ0KPj4gKw0KPj4gK19oYXZlX3JuYmQo
KSB7DQo+PiArCWlmIFtbICIkVVNFX1JYRSIgIT0gMSBdXTsgdGhlbg0KPj4gKwkJU0tJUF9SRUFT
T05TKz0oIk9ubHkgVVNFX1JYRT0xIGlzIHN1cHBvcnRlZCIpDQo+PiArCWZpDQo+PiArCV9oYXZl
X2RyaXZlciByZG1hX3J4ZQ0KPj4gKwlfaGF2ZV9kcml2ZXIgcm5iZF9zZXJ2ZXINCj4+ICsJX2hh
dmVfZHJpdmVyIHJuYmRfY2xpZW50DQo+PiArfQ0KPj4gKw0KPj4gK19zZXR1cF9ybmJkKCkgew0K
Pj4gKwlzdGFydF9zb2Z0X3JkbWENCj4gDQo+IFRoZSBhZGRlZCB0ZXN0IGNhc2VzIGNoZWNrIGV4
aXQgc3RhdHVzIG9mIHRoaXMgX3NldHVwX3JuYmQoKSBmdW5jdGlvbiwgYnV0DQo+IHRoaXMgZnVu
Y3Rpb24gaXMgbm90IGxpa2VseSByZXR1cm4gbm9uLXplcm8gZXhpc3Qgc3RhdHVzLiBJIHRoaW5r
IHRoZSBsaW5lDQo+IGJlbG93IGluc3RlYWQgb2YgdGhlIGxpbmUgYWJvdmUgd2lsbCBtYWtlIHRo
ZSBleGl0IHN0YXR1cyBjaGVja3MgbW9yZQ0KPiB2YWx1YWJsZS4NCj4gDQo+ICAgICAgICAgIHN0
YXJ0X3NvZnRfcmRtYSB8fCByZXR1cm4gJD8NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0Lg0K

