Return-Path: <linux-rdma+bounces-8804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B9A68361
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 04:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50D5880190
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15124EA85;
	Wed, 19 Mar 2025 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Qw2M4fcP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E2524F
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742353210; cv=fail; b=niTUhEtdXVZ8hzcST7KiUs0fwrsLnQRyiW2zBUbH/NLplz/VzCEhSasNB4d5tDXYcd9LbZ3FRui2vN7bhgoOBZWQTwdUXIVsulfDkddKZzYNlFxSAXxC7xiAyu5XRaQ8CqjnsesGqRtGtYEKxeXr8hD4z9cC2v9i4NfXaBJJ9qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742353210; c=relaxed/simple;
	bh=wPfNy+mLvCP4ZRq73h4Kphs9/0qqwW4n4URNbpHYL3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIjq42HN7WLi0lMUEMOkRq5fMNpwcGSQ3+beisY4JMxlnQWxEZKP9/LlhUFH6AbR8k6PhGnOgOpLXdkDDuhsEIfbZrFyoJQvBequRFIDHE1YiFMXHF7Mnct12F/vQWsr/Rb0HEGASv/3v6GNeyxnQLuNqkk3E5ExuRgf26JgcWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Qw2M4fcP; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742353208; x=1773889208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wPfNy+mLvCP4ZRq73h4Kphs9/0qqwW4n4URNbpHYL3s=;
  b=Qw2M4fcPSiNBsfnOCoQwjF5BBseTJanhKtGM4CTR2apM9reC15HJs04N
   qKlJ4ajsqw7gTjUXJM4HYEg6Z01Ubpmxpm8DtA8Wfu6Dk4d0iB00WpMsd
   1CmQQRewCVqqwLkErU/lJIwyYe2nXbiiODXfrcLXdSJNEYwFuUfLLY1+9
   zvme5Qd1YSgTfOSuPsKzsuc8wU/nvjhrPRfyLiog+esAoMxPtTM5a2IGm
   Hb4QzM1I9baSgc86XXCulWGLrDJHYi7CQkLJQNRvVM64MQgGAhBZ4W2TR
   2H38xhoQa0mHW6NwZal1Qfn4kjEI9uVk6yrjHF2+oJNfVcB+EJFCVplXU
   A==;
X-CSE-ConnectionGUID: K6PVwOa5QjuukdgwiyJGdw==
X-CSE-MsgGUID: d6C1Hw74QsecBXWcrjHtgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="149964256"
X-IronPort-AV: E=Sophos;i="6.14,258,1736780400"; 
   d="scan'208";a="149964256"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:58:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmmJu7m/rM7mHJnseWB/CpcqlB3yBr/flFZ4UOMSO5ZdyQBYU5KjMhb9rqogSmU6g4mvMzq7JIhz/oMfP6wJZj0CpDmJNrJ4i4YCnV20TsoIMU7aYVY+vVPOxg7lUA0YO3T4zcMSxDiYvaUGAoxU5t0gmyIO7qFH1GeJ4xtF2KfqGjGg0r48gePsT/0hZtpY8Fv8YVjqurZCM7kLukislKiTW6kDLG+P4ygOSp43KkJNGXy6T9FReb9h9jtXBV2qGi8eZ9v/i+vEE4MWjCEqTZzU9c0ERDqStHUrB6XbYZYgJ3M9VRchL4vV52CwdA1dPjzwjDHxTf0aY52jLv/mEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPfNy+mLvCP4ZRq73h4Kphs9/0qqwW4n4URNbpHYL3s=;
 b=jwREX84/RSrYXCvC5R7pnbsJcr9WQJ7fDORsWX1u6zF7hZ92aare8mui4oKu3rdNEZWvLcb3jQKsrKGMfTvoGvKxEWKrc6W5lK7jajj1sau4ZTEZtFxJMMJyGpiJBRB80jUAevLKgHcZKcayPgw7q5xVMTUc8YosI38J1C1ZiJwjYxR4JyphM2Ywe0MKUCWJwZbzg/0Wwyzkxi5fUXqs69TUl0yjNWTTd1NOm/SN+v5C5mdAtKfTbv/7a15a16iABsEL+TZnvPiCrfWJ0TfK8FZjUxkYDZWHzDGjEIALX1Bw2pbgiSX4Py3ZS08zSer1ZcaKIfI/YajAIp5ORnfPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYAPR01MB5708.jpnprd01.prod.outlook.com (2603:1096:404:8058::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 02:58:52 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 02:58:51 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "Zhijian Li
 (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
Thread-Topic: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
Thread-Index: AQHbl+saVZM8g+C8M0SMkEkpiP8Bm7N4rAsAgAEJIpA=
Date: Wed, 19 Mar 2025 02:58:51 +0000
Message-ID:
 <OS3PR01MB98651EE8E000B0682056B381E5D92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
 <20250318094932.2643614-3-matsuda-daisuke@fujitsu.com>
 <20250318101014.GA1322339@unreal>
In-Reply-To: <20250318101014.GA1322339@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OWVlMDJmY2QtNzRmYi00MjM2LTgyYmItNzFkM2U4Yzhi?=
 =?utf-8?B?ZGQ3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDMtMTlUMDE6NTk6MTBaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYAPR01MB5708:EE_
x-ms-office365-filtering-correlation-id: c232cdf8-cfe3-4581-65fd-08dd6691fa86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?ak1ISFFGTHBwU3Q2a1lBR1BvK05HZWpiTStLeDM5Y3BKdng1N2J2VlNHZHla?=
 =?utf-8?B?SFlneDlLWGgzemNSS0QxVUIxTEN6cm9LQVdvcVkyUVZJb0ZRU0pLTVhFcnk0?=
 =?utf-8?B?TUxNSkRHaXEzc0hWWS9UamhVMzJscVlmRitadmJsWng1ZkwwNXBSdlNsa2x5?=
 =?utf-8?B?b0krQVJSZnh4NHUxYU1ZalNoNUhVTndibm5mUklQTHg2RHhYRzRtMW1jT01N?=
 =?utf-8?B?Yi9XK0djbHFKbDhQM3U5TUZQeWZkNkpPMnZrTEdkNmtsdlF1R3hwZXo0ZFVO?=
 =?utf-8?B?OUlnd3ZoLzhjeEFpaEtUYVBFT3ozTDNqTFFITCttTFZUWW5nbGN4N3FCWldU?=
 =?utf-8?B?Vk0zaU1maW5EbFdJeGpESnV2VXU0ZzgrWlNIOEVBaXB6dFNYT2l0NnBQbzNQ?=
 =?utf-8?B?YjVwMUtwdHRieVIvUHo2Zk5Fd3JYbEpPK1d4TiszWlBLS1JiS1NwMjFtWVBK?=
 =?utf-8?B?NWlJRlZETjEvbFU4TmdZNElhRUp2WVRFU1o2SXZRZHFhUkw3NTRNeng2WmN6?=
 =?utf-8?B?YU5rV2xZZG9CTGxNc1FPQmUxemJRKzNWMVR5RFA0N2Q0WCtIbEhaWnIwMVZv?=
 =?utf-8?B?emE1M0NITzdJZGdUY0UzQlc5Zy9SeUs5UExRUmNKNWVycUdWTSs2S0hybXd6?=
 =?utf-8?B?c2FBeTFkekJuZE5xZUd4TVM5b1Q4NDl3ZTg4bU5Cc1hHRHhlUE5ZTVV3c2Jh?=
 =?utf-8?B?Vlc5ZlA0TnFaTUQrK2RiNlBzYkpqdUJtRTRIaUZTRFVQbGphU2twdTVOVmFP?=
 =?utf-8?B?Z3ZTekhxdWpuY1lqTDhFVFpNUTk4d3c3UXhwTDFFWE9MczZXNFdFcm51SlBQ?=
 =?utf-8?B?dG9nZnpJZ3hScC9tRHpVWHIxTW9COU5Fd3FiMzdOV0NBdlRaWEtQMlJRNVNy?=
 =?utf-8?B?Q29UYkRCMDIyeER0dy9sTU05b0lwcEpIVmdnRDRYeUJWYUV1VzFOL2RFTmZv?=
 =?utf-8?B?MHdxTkFRZzR3aEpaUmpSeDJpZ1dac1NtYlpOZFFmbEtKK2VPRDliMjh5dVJM?=
 =?utf-8?B?OVRKQmFVMFovZmljNUtWZFJqV3h1RVFmVkwxZkEvZTZYWGMrdnhpWGUwRDBi?=
 =?utf-8?B?eXhaTEpYNnI5QVYwQXh5YXRPcGVHK2ZQeEhHeDBncEI4RGhEOXFoTGhzbm1F?=
 =?utf-8?B?cDgydWdQd1VyN2hPSDRyZXp4RncyTnpkMEVGZjBKVGhSZTlpbUliZ1NqblNR?=
 =?utf-8?B?VzMvVnVoTlVNL2s0KzJ1NmdYZTZhYWNMcFY4Zm5hZDNObWdyVDlPbmFqMGlU?=
 =?utf-8?B?UGlxa3hMZHhmWWdHbnJwNi83cnp2d3VoN3hEbXhUa2phU2h6Vzc2NFV6Y3pV?=
 =?utf-8?B?QzhzOGp1OUNiL21sNW9hWTdPSXdwYmVrK29Yc2dqU3dhaHNEbWlnQmFHSFFl?=
 =?utf-8?B?akNwYmZkSkJaWmxyL3g0OTdvUW9xZ1dMaDAwR0xJR3dBN2NnS1pIUCt1cDVI?=
 =?utf-8?B?QTN1U3g4TVNWVDAxWUcxU0dVWDhtWkNhUEJtTzQ3OEkwNDNYZ0VBN01iVFUy?=
 =?utf-8?B?V0ZwMEd3NkwxdG5iVy9Cb1phdUg3cGZmVDBpUnBjT1JQdktscUV4dWtWWWNR?=
 =?utf-8?B?Q0ROeWZ4Uk83OGIzM09lOWsrUjlNcjBTekJEUExPb1A3K2pGUStTdEoxa1Ba?=
 =?utf-8?B?Q05uNTRpV28vMFQyOGFIVFZRQzFVeW15aVVoWFovYW5kakRaK3BBTThtUWlV?=
 =?utf-8?B?SENEQzd6OGp2Qmd2Q3ZyNGVPY2FWQjNQWXZpR0tGZWxNNEJ0TG1meEZacjZG?=
 =?utf-8?B?N0puQ0dFdXlwWmNrdGYyL1g0cU9XczVyd2dJZ05keTU3RkxXRmc3WXNid3RN?=
 =?utf-8?B?M3BLYm1aeVFzcVYreVdCNlhuWlBmaDMydHFpOU0xVjh2MStVNUFhWTVCZXZy?=
 =?utf-8?B?UE5RMUtpaHNpK2FjL3dkU3B1NmRRbWFqOWhsSnc2a3RCdDVOQWdkUzF3K1Bx?=
 =?utf-8?B?V0Q0ektzaW1EbDlJeldlUzBaZUlNaFcyckx0ODJmMmY3S05mUnRxangwYVli?=
 =?utf-8?B?N3granFiakpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzZoMitLcHJsVVdmd29KQks1RzJ2THMvK29UTWM3eVdaamJxTWhmTUw3QzZl?=
 =?utf-8?B?N2diOUowWktjMXpNbDlFOHJvcGlWSW1SM1IzNHdZUEpaTmttTStlRWNDdmFV?=
 =?utf-8?B?Qms5MnBNVU0xL3ZGaTkrOHEwdUpxUHRLcjJncHRjUFhUZ1ZYV1puY1k1Vk5F?=
 =?utf-8?B?QjgrRWM1aFNHZG5KcE9SK1FBZnpyL0tBeExaOFBrb1BhY1E1bjJrcGdNTGQy?=
 =?utf-8?B?YkZKamhBdEIzRUs4T0VMbUd0REV4OVYvY3ZyUUNxWnUrMW5TODNJVnhaMk1a?=
 =?utf-8?B?VUdTUUQwdU1ZRjBMOXdySDA2RS8vYnRob2E3TVNBZS9EWSthcXE2eno3OStz?=
 =?utf-8?B?b1JVN21udkNsS25PVm8wazVvaGFHckVOUVJpUFN1QWRLWCs3Njg3Nk92dWdQ?=
 =?utf-8?B?bENwOFpSRXlTcWw2QmtmZjFNNXArRkMxNnlVQWNXNmN5VCt4T1ZLY1IwT1VV?=
 =?utf-8?B?dFI1ZjZrS1Zmbkt6cmNaTHBEMkJCR3diUmU1dW5acFRhZ3duZFY3VFpzSWhG?=
 =?utf-8?B?NjBYUHQ1UnNxK0FVd3V3SzhRanBmN1pzRyszWlZIMUk4ajBuKzVXTTI3UWc5?=
 =?utf-8?B?dnJ6dm9TSXdRaHBmNFE3NngxN2FBVzNFSVlrakcyYU92ZnlzY2ZjRGduaGFP?=
 =?utf-8?B?NHgyS3FCOXRMWFhhbGdaZ3ZobGtvTlc3ZEpGMzJMY0pZcUhmcm5HeUYxSVd1?=
 =?utf-8?B?M2RXWVkwck04K0Fpd21POWhPSVNYMzI3YzI0TVpoMjlnb2IrS3kvVDFtbGRh?=
 =?utf-8?B?cmh6eDRmUW1JSTM1VXg0djRyMFVCREd4RCsyaXU0N1J4Q0g4R0RWZysyd0hV?=
 =?utf-8?B?VmFQbEQ0K2E2V2U3Rm05a2xGTDZXMVMyeVo3NkU5NDhGWGtQS3FqeitLck1T?=
 =?utf-8?B?NzZPWGhTRE16U29JNGNZcGtsM3lua3dGZjMwOHc5TEYyMis0SzMwV29KMEI2?=
 =?utf-8?B?WEhxalVML2NiLzlFTGNKMHVodFlweEFoeXJLb3VQSmcveGsvZHYxWXhqdHNN?=
 =?utf-8?B?eVFWczJpSm4xVzVFNXZvQk5mOGFVSEtaK2tSTmlXcUw3cTk0TWpYZUdRZk52?=
 =?utf-8?B?ZWM5cFNpTFNaU3hGSmg0Z0tmZExxUUxaRFZENmxZZmZaTVp4STBOeWduV1BG?=
 =?utf-8?B?Z0tzR3d6eG9XeWVjVXc2UmhlNXZLY2hYbEdLM3VMVitQbG0xRzR0Umc5eWxu?=
 =?utf-8?B?ckVCeExvMXZhWVR4KzdkQ3pLWGlLM0ZYOG9jSE1nQXBWc0xmQ2JyUis0cHZJ?=
 =?utf-8?B?TGordzY3WVVha2VDK3BZR2NaWGZGUDBLN1Yva3FqWVhDMjl2aGxjK1FBc1hC?=
 =?utf-8?B?SXBHcGdKL3BVLzExOTAwUW1TR0ZxMG54OVBhWFYxblNwOW4rRmpMc0xrMWhP?=
 =?utf-8?B?RXZoNDFmeVc4SjBEOXJRRVhLb2lHbTR1WklRTWpJYXJ3VHZuU0ljb2R2VnQz?=
 =?utf-8?B?dzlVWFlBMjI2UTlzNFhzVExwUEYreU5RMHhqam01NkYyNlhSSTdNZWVLbFA3?=
 =?utf-8?B?R040MEhDbUxVSURNblljZnh1eVVVcWdndVBSSmt5M2FnV1I5UHl0S214d0RC?=
 =?utf-8?B?aXJOQzFDQ2FvUWxyZ2J4eFNyQTdocGJPakhEaVF0d3gwZTg4RjJNRzIrMkpk?=
 =?utf-8?B?MVc1UVR0eENIbE5vdytNYnhINmJOaUhQK1d3eDhYOXFGdTg3cW81aDNHQlR6?=
 =?utf-8?B?cUZmQW5uMDg3bVU4M2JabFZaN2U2UktFL1dlbXREbkJidGVFa1I2NkVaaW1T?=
 =?utf-8?B?L1l3Mll4bU0xWnlpVktCMUtObTNkVE4zbGI2SlFpNWRMM2FZVGhLSGRXWjhi?=
 =?utf-8?B?RnNWSlBXekFTVCtEc005dS9PaFJuQXk4cWMyeDlBTUFqOGhxNEZPbnNERmtK?=
 =?utf-8?B?TGRJekkrUTA5dWtTUW9pcmp0a1VXTGlYc3ZOaXBYcW50cXFhOUl6RmlZbTdw?=
 =?utf-8?B?TjhIUjJmSSsyTHFHMzBvK1hvRkVZVUUxeG1US3VqczdIdWxZbUtEZmxaSExO?=
 =?utf-8?B?VXJ3OStLMlRCRTRaK2lva052QUtwQXQyQmhJcFdKZE1mZGdkS1JhWUJlU09V?=
 =?utf-8?B?ZXJyY2xURFNHMGFPNTBuYU5tVjdWM3l2MEZUTWQ2bEo2Z1dRRnR0SjZ1Uko3?=
 =?utf-8?B?a1ZtcTRsenRxS0YzQ1R4bUduWGsyZzdrYzZ1cmMrdzJRcXAvMVVhSHRmWWRy?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eLDJdaRtLwsMIH6QgW6m50msI8x/6095R6/StsLnDKKPWejgHUMSIBdsnIEiG33sxzOjRucYFLTJtld7XjGhMyXo51vl7h5rvNxaAdnYsnxDgsCI1XgbQLyAky71XPXeAVRSZyYUwjV5/O+qdI1iuaSNX0ReGPXo6OkOEQ6xXaZBnhk1wazdu9drEQzljrWb7hHPtBWpGOSv+IGy2nmyKAmFMHOTZr20SgsG0pi0q77pEsUvHKglJ8FVy9KHDwovOYrklakP40JR2CigLlGGtSyD72dhrB6xHHnXorh5r7FHlM2AWUVuPfONXo9jkxEqD6QZoH1t1GeT7sedNOC3oMMZ4GMr4p2W8STNVo7n/BRD3F9GyPmqy+oEV8FZdowhiRMhE4e/0q6M0dbcka+ZCHSxnZnsGaAQlwRP5Hv/2Q6/7PWZME+XFlBqoCk/2LshZKPOGYHfYzYsj/1fJGmnh2vdsINIwD5V9HR2jtaMY0zCcIduJwi35UWqR3JCKnt3TWyiNxXNArcGjCizP4mQrXLicSZ4+l/y0dnhNS8Y1MFtbIUzaEhFSSciIPTo34Scv4ABRRfLBxjv/I+M/dg7jK4wnLDDg/2cs3XZcKMaTBN4ehFn2OTegN7fBCPGyo5n
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c232cdf8-cfe3-4581-65fd-08dd6691fa86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 02:58:51.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdUTWblnXJkk4/ee3wFXlGUdcfEkzHNZh9XAEnciWrhXQW0oetuzougAi/3FlukCE+aCSqdtcTJFtXEz2Ow2tXLemTYIAlsMKXTdcymscS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5708

T24gVHVlLCBNYXIgMTgsIDIwMjUgNzoxMCBQTSBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9u
IFR1ZSwgTWFyIDE4LCAyMDI1IGF0IDA2OjQ5OjMyUE0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3
cm90ZToNCj4gDQo+IDwuLi4+DQo+IA0KPiA+ICtzdGF0aWMgaW5saW5lIGludCByeGVfb2RwX2Rv
X2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHU2NCB2YWx1ZSkNCj4g
PiArew0KPiA+ICsJcmV0dXJuIFJFU1BTVF9FUlJfVU5TVVBQT1JURURfT1BDT0RFOw0KPiA+ICt9
DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfSU5GSU5JQkFORF9PTl9ERU1BTkRfUEFHSU5HICovDQo+
IA0KPiBZb3UgYXJlIHJldHVybmluZyAiZW51bSByZXNwX3N0YXRlcyIsIHdoaWxlIGZ1bmN0aW9u
IGV4cGVjdHMgdG8gcmV0dXJuICJpbnQiLiBZb3Ugc2hvdWxkIHJldHVybiAtRU9QTk9UU1VQUC4N
Cg0KT3RoZXIgdGhhbiBteSBwYXRjaGVzLCB0aGVyZSBhcmUgc29tZSBmdW5jdGlvbnMgdGhhdCBk
byB0aGUgc2FtZSB0aGluZy4NCkkgd291bGQgbGlrZSB0byBwb3N0IGEgcGF0Y2ggdG8gbWFrZSB0
aGVtIGNvbnNpc3RlbnQsIGJ1dCBJIHRoaW5rIHdlIG5lZWQNCnJlYWNoIGFuIGFncmVlbWVudCBv
biB0aGUgZGVzaWduIG9mIHJ4ZSByZXNwb25kZXIgYmVmb3JlIHRha2luZyB1cC4NClBsZWFzZSBz
ZWUgbXkgb3BpbmlvbiBiZWxvdy4NCg0KPiANCj4gPg0KPiA+ICAjZW5kaWYgLyogUlhFX0xPQ19I
ICovDQoNCjwuLi4+DQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfb2RwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vZHAuYw0KPiA+IGlu
ZGV4IDlhOWFhZTk2NzQ4Ni4uZjM0NDNjNjA0YTdmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX29kcC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfb2RwLmMNCj4gPiBAQCAtMzc4LDMgKzM3OCw1NiBAQCBpbnQgcnhlX29kcF9m
bHVzaF9wbWVtX2lvdmEoc3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLA0KPiA+DQo+ID4gIAly
ZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArI2lmIGRlZmluZWQgQ09ORklHXzY0QklUDQo+
ID4gKy8qIG9ubHkgaW1wbGVtZW50ZWQgb3IgY2FsbGVkIGZvciA2NCBiaXQgYXJjaGl0ZWN0dXJl
cyAqLw0KPiA+ICtpbnQgcnhlX29kcF9kb19hdG9taWNfd3JpdGUoc3RydWN0IHJ4ZV9tciAqbXIs
IHU2NCBpb3ZhLCB1NjQgdmFsdWUpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpYl91bWVtX29kcCAq
dW1lbV9vZHAgPSB0b19pYl91bWVtX29kcChtci0+dW1lbSk7DQo+ID4gKwl1bnNpZ25lZCBpbnQg
cGFnZV9vZmZzZXQ7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGluZGV4Ow0KPiA+ICsJc3RydWN0IHBh
Z2UgKnBhZ2U7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsJdTY0ICp2YTsNCj4gPiArDQo+ID4gKwkv
KiBTZWUgSUJBIG9BMTktMjggKi8NCj4gPiArCWVyciA9IG1yX2NoZWNrX3JhbmdlKG1yLCBpb3Zh
LCBzaXplb2YodmFsdWUpKTsNCj4gPiArCWlmICh1bmxpa2VseShlcnIpKSB7DQo+ID4gKwkJcnhl
X2RiZ19tcihtciwgImlvdmEgb3V0IG9mIHJhbmdlXG4iKTsNCj4gPiArCQlyZXR1cm4gUkVTUFNU
X0VSUl9SS0VZX1ZJT0xBVElPTjsNCj4gDQo+IFBsZWFzZSBkb24ndCByZWRlZmluZSByZXR1cm5l
ZCBlcnJvcnMuDQoNCkFzIGEgZ2VuZXJhbCBwcmluY2lwbGUsIEkgdGhpbmsgeW91ciBjb21tZW50
IGlzIHRvdGFsbHkgY29ycmVjdC4NClRoZSBwcm9ibGVtIGlzIHRoYXQgcnhlX3JlY2VpdmVyKCks
IHRoZSByZXNwb25kZXIgb2YgcnhlLCBpcyBvcmlnaW5hbGx5IGRlc2lnbmVkDQphcyBhIHN0YXRl
IG1hY2hpbmUsIGFuZCB0aGUgcmV0dXJuZWQgdmFsdWVzIG9mICJlbnVtIHJlc3Bfc3RhdGVzIiBh
cmUgdXNlZA0KdG8gc3BlY2lmeSB0aGUgbmV4dCBzdGF0ZS4NCg0KT25lIHRoaW5nIHRvIG5vdGUg
aXMgdGhhdCByeGVfcmVjZWl2ZXIoKSBydW4gc29sZWx5IGluIHdvcmtxdWV1ZSwgc28gdGhlIGVy
cm9ycw0KZ2VuZXJhdGVkIGluIHRoZSBib3R0b20gaGFsZiBjb250ZXh0IGFyZSBuZXZlciByZXR1
cm5lZCB0byB1c2Vyc3BhY2UuIEluIHRoYXQgcmVnYXJkLA0KSSB0aGluayByZWRlZmluaW5nIHRo
ZSBlcnJvciBjb2RlcyB3aXRoIGRpZmZlcmVudCBlbnVtIHZhbHVlcyBjYW4gYmUganVzdGlmaWVk
Lg0KDQpUaGUgcmVzcG9uZGVyIHVzaW5nIHRoZSBzdGF0ZSBtYWNoaW5lIGlzIGVhc3kgdG8gdW5k
ZXJzdGFuZCBhbmQgbWFpbnRhaW4uDQpUQkgsIEkgYW0gbm90IGluY2xpbmVkIHRvIGNoYW5nZSB0
aGUgZGVzaWduLCBidXQgd291bGQgbGlrZSB0byBrbm93IHRoZQ0Kb3BpbmlvbnMgb2Ygb3RoZXIg
cGVvcGxlLg0KDQo+IA0KPiA+ICsJfQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4gKyNlbHNlDQo+ID4g
K2ludCByeGVfb2RwX2RvX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEs
IHU2NCB2YWx1ZSkNCj4gPiArew0KPiA+ICsJcmV0dXJuIFJFU1BTVF9FUlJfVU5TVVBQT1JURURf
T1BDT0RFOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiANCj4gWW91IGFscmVhZHkgaGF2ZSBlbXB0
eSBkZWNsYXJhdGlvbiBpbiByeGVfbG9jLmgsIHVzZSBpdC4NCg0KVGhhdCdzIHJpZ2h0LiBJIHdp
bGwgY2hhbmdlIGl0Lg0KDQpUaGFua3MsDQpEYWlzdWtlDQoNCj4gDQo+IFRoYW5rcw0K

