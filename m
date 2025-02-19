Return-Path: <linux-rdma+bounces-7825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E633A3BC07
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C82E3B512F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC01DB546;
	Wed, 19 Feb 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FwI4Jn+0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C08146593;
	Wed, 19 Feb 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962186; cv=fail; b=ThqSidH2L4jiODZmdPNOZfpfz/iAYruApHdhLDaoUn70okS2TH/3iOAbrgUVqZtneYansQBqgpuBM9Q4gucOsBuCP4lgBpQ4iFwpKBhxCJRKV8WHpKR20JChopRQ+L2fTJzvHFxzORvnE0+M76p+WE4FJYSBBL/Tz6n9/3uPAUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962186; c=relaxed/simple;
	bh=0eJF1/2az+ObgqjcCwMcy0J7DvV9bLVp/EZxTZfVgPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GyAEEGLuZK1zKzZdJn627thR8Tvjv1L3S/hHpQRWQqU+XeLKTS2gdTbapH1h4etYsILgdK6bOVN0WFS3/QiYEYyC9KNLsExGdcObXXDNj3ssDCF3pTe7hkxGGJLRSQR+rZUfQvsIjbbCQKhie04w6PY7dt0yGJMONv7FBHVgWHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FwI4Jn+0; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1739962184; x=1771498184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0eJF1/2az+ObgqjcCwMcy0J7DvV9bLVp/EZxTZfVgPI=;
  b=FwI4Jn+02JxVmLLVlcE2pTQp7DiIL/3/B4UJtNoGwLfY+Vz72YsgOgHM
   TxEmTnJ9tAePIu5uorGToxwhXm9w5HySlsC+8Yn5a3/SD+gLUortaHOm/
   UsGfXqGeAYg6/hJxq4sGXCseZw3EzAPt7yMTmjk9JDE2+7lkb6aHk8Nua
   w+75ZPb6G5JGrZ8TVEALAoEprAR+2SF/JySJmK/UqPuVZZ2L7aqEzrLLz
   69GexNVY4SFYwvpKMVkPPzQ0wm4UhBUBKRJRDfsy/k4M+4W2VYeD9/jkD
   mj0eEIeR4GUA0vc58aSk2c/P/E5js10H6aIWqjGmLtMoIy7cHdKiyYqsw
   Q==;
X-CSE-ConnectionGUID: ICX2KqLJQfiAmmyxxdF8UQ==
X-CSE-MsgGUID: m3k1bfI6S02mwSdPfMAPZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57918031"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; 
   d="scan'208";a="57918031"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:48:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrpy9oFsGo6+9rJuDyeL3DeSBNeOadcOwh+98702J8RP6b+ZwsfNMfhsYLVUPJ3M4g2pWGXO1GzqYWd+6B99h3HzdnTwhLfVjuMurX8cHuiAl9gZDi6XXfW187axFZN2MGoRKZF401WwlYMmGvsCnlu87npMg7FYt1RXrVQFI5yhYQYqwcM+kBpzfm4RuMgKL1lgHcy2eF+O12PifbAR5qCPXnTaSDSDnaKoumCq7h/f83pQJgh/ztZxagzISP1VRoyeB/xMBTnOh2kILyd1jZQbv76/AK4lLAdEZvnAFwMhNdrIO6toYqw4nrpe98ytdh4dX4NddxZ0BVLqXTn4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eJF1/2az+ObgqjcCwMcy0J7DvV9bLVp/EZxTZfVgPI=;
 b=ggAAzpZtobQLhDwE4K9Ahd4AkHRHLbIldi7gSjglUzMNEwrVV25/E3HiqHXwj9oioll7uoOdzAlK00fydFlwfXax3/07y1BcTdKMb7uY427GgnWreDENa5Hr8siD2mX+nOjxXNvyT2O9U3lNOoSzSPXyXlvGXeqYg2DfWnvwklRbV8R6u9xOE+MCW3mpPDU5nw8AcR2liT033He3NxopmStbYEsfS3NPHiAzjI+/htUilhurZSOTERsWqWMw2GV64oIIw2UF4KBN/BmtsahFm/9wZAm/Oj2IS/mwkxMIVDOAJrO0oVR0s5d2XZ0vtAFZPeg/aZbNanFOKRs/WV9kdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TY7PR01MB13655.jpnprd01.prod.outlook.com (2603:1096:405:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 10:48:25 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 10:48:25 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Jason Gunthorpe' <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Joe
 Klein <joe.klein812@gmail.com>
Subject: RE: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Thread-Index:
 AQHbUsdVttNAApocPUWbNvG68fDe4rLyh0MAgACNdPCAAfaMUIAQMRwAgAArUQCAD20tgIAAdY2AgBoBB3CAH30MYA==
Date: Wed, 19 Feb 2025 10:48:25 +0000
Message-ID:
 <OS3PR01MB98651D06FEFF22AD1CFBABF8E5C52@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250103150546.GD26854@ziepe.ca>
 <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
 <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>
 <20250113201611.GI26854@ziepe.ca>
 <OS3PR01MB98659E07C0DAA1838FFBC70DE5E92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OS3PR01MB98659E07C0DAA1838FFBC70DE5E92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OWYyODZkZWEtMjAyYS00NmQyLWI4MGUtNGY4ODBmMzNj?=
 =?utf-8?B?ZGQ1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDEtMzBUMDk6MjI6MzZaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TY7PR01MB13655:EE_
x-ms-office365-filtering-correlation-id: e1d2d673-165c-4f65-e421-08dd50d2efd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkYwQmJHTEc5dzcyS0I4eXNka0JST3czaGVmbUI0clN2TVI3QyszSnFnYllD?=
 =?utf-8?B?cy9IVFJOSWRBc2JtQzNMb2lkRjVRaEhEckxXQ084Zmo2dVJvWHhDYXF0NEFW?=
 =?utf-8?B?WGZmZVNuTm5PNTd0cklJa2FRTTVydWRpSk5DMy9Ld2ErVzB1a3lMVng3RFlZ?=
 =?utf-8?B?cDdWS0NEZGdLTlRUbTZFT2JnMmJDSXdoTU5GbVQ3SzFrNVB2cHpxa0tEQ09G?=
 =?utf-8?B?eXRJYiszUXFPbFpUeHE3OVNtbUJpbzVvK1lJVDdzMXdOekdMYm1tTzNnWEZS?=
 =?utf-8?B?SE5UN1RGK3UxcFA3ajNIZFYvV01BSWdSQVRWZ0NIaUZIcDl3VnlMV0tzNGIv?=
 =?utf-8?B?cWIyR0JrdkxxaWE3UkUwN2RvYkRYY0pXc1RWdGdCZ1hyQUFiWDdWaFRmeUJk?=
 =?utf-8?B?Y2tlU2V4NmN3OHVhSkIzclV2QjBqMWpha09zOGVZT2VlbXl3S1ZCdzZNeGhr?=
 =?utf-8?B?NmtqdHRXVFhqNWJ0QkZkOGFTWEJWb1ZJRHJGcFFXK2llbUZRZ2xUa2FxWXYr?=
 =?utf-8?B?eDBVTHB4L1VBZTl4NHZtUFR5Wmp3SkxhVlNkcEoxNGxLWW52djNoaUxNeFZL?=
 =?utf-8?B?OG1CWmFyUlNzVEpITTJhWHMyNmVITEVybFlWU21jODRCNG5kUEo3dWdwdUF3?=
 =?utf-8?B?djNZMGFSZnBOMEtWcU40SG8vVXhvSVltaytIV05JUWdOZDZkUUd4ckh4VzdJ?=
 =?utf-8?B?aHdMMGhwQlJnSDhyNkI2ZmI0eUZUeWwyWFZuUDU2NHMxOGRmck40SFROcU81?=
 =?utf-8?B?TFBVcmNVQ1NJbzl5Y096WjRuSkZlQk1Ua1Y1YnVqK3hySzArQmxXaGVxbC9t?=
 =?utf-8?B?bTlIVXhnSVEyWHcwbVZORkM4K05YOUovTWE5YURlYXpqbE10NHEySWUvZG92?=
 =?utf-8?B?S3pSbFR1eFVMMXFrS0NZS3ZScjlHMGcyWk52OUhUZWV4VDBNNGtpMVQ3dlI3?=
 =?utf-8?B?ZTQzWDJ3QnRVTXRBYjZWa2JiejF1RFVyUEJLSklJZFVSWWgra2JBd0pXdk1m?=
 =?utf-8?B?Slo1NjE5UjFVKzZXQnZUemtEWFgvVjdnejJBanBlOGl5M2hsaS8wYVQ2SkMz?=
 =?utf-8?B?Tm1QMjk1eTdrKzRwdVhla3ZFVEd1cHdTVVF1d1J5bEhUMlNYV1F4b1d1NURa?=
 =?utf-8?B?ZUhuYmFHVTRWaFZqNG1rMWpSVTVOWVVoTlFFZlBja0JFcm5VSXQ2YUVZcWht?=
 =?utf-8?B?NkdHU3ZvOFNzaWU4SzFEckRqOEdYMnJLcHR5WXI3WXJQcWpaYTVhVi9aZ29O?=
 =?utf-8?B?NDNHdXN3eGlvalZQdlVoNWV6bWVIblNBQVpQUkh2eTNaSXEzOE1vRUJjajh1?=
 =?utf-8?B?T3o4VUsvaDlKSWduNE5tOHAzejJNYmRmZkZEOVpWbTc5Sytxcy9QVnp4V2FJ?=
 =?utf-8?B?eGZMK1VaSEhFdStwTEd0cTREZUpvK2Rvd3I5Yks1Wk94MGhTUzQvcnNwVHJx?=
 =?utf-8?B?ZGphSW9rQnVZK3FqazBJWWpoYmdSZWI4NHJxejAwSUQ2bDNQTjR1MFhnc0NF?=
 =?utf-8?B?bVR5eDlRQVY4aVZQOFlmcXgyR3Y5TXdnQU1HT3FoL0NDbHVYeGw4ZkpCQmto?=
 =?utf-8?B?bFZZVkVac3NENTVIeE9UMVg3WkJ6aWRoVDVOT3JxaC9nVGJpWUxnWWl6emoy?=
 =?utf-8?B?TzIvUWxrUk96MFc5Nk9STlBKSnJMTjJXZnJjRkNqNWNzcDllMzhidFp3SExU?=
 =?utf-8?B?ZVZjdzZyOFNicWplQXcySHFVdC8wTFFGR05tVUFUOW8vN1ZTK0pUTmdiSHJJ?=
 =?utf-8?B?WWVuN1lvMlNnTS8xZXRPN2RIMm5vVUZNL2tFQjBzdE1XUVgvLy9vV1RZNUZV?=
 =?utf-8?B?cHhGdFlOSFlIa2puK0RWZ3lIYXVFelNMdUV1VHNmUXBKakxra251dUZPZUFK?=
 =?utf-8?B?T0x2Q0R3Q0pES0QyVk5KdHZobjJjOHhlTlFXSTV2NzdOYjFJYk5QbmlEUC9T?=
 =?utf-8?B?ZjVlUE1PUVBBemwyT0NnSjdsY3hqT3ZvcVA4Wm5wdENVTkhndUJJZkhzNnJD?=
 =?utf-8?B?UUFzYmtxOFl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3RhWEpZQmZOQmFZSDJSYmYvVlhiemZ5bnVSWWRnUmFSN2RQdXcycmFYUUVz?=
 =?utf-8?B?OU4zR3lwMmMyZVBJVDltdmx5SFNWSnhWUjRXaFlNU2tRMFh5RXJEVGdLVlVx?=
 =?utf-8?B?emhzbk1yNHkrNGg0ZVhFdDk0Unhva0Z0dm4xNG5yN3UrSmxQNWZwQ1FMSmdY?=
 =?utf-8?B?MGJ2TGFia2pMSW15OHh0VkRoT0VuY3lOWitXTjk1OUpxRmxRMWI2cHpvM1d2?=
 =?utf-8?B?anEwSzJubW1mcHFHV3A5NWhwZ2pTRTRndjlodC9BNnlJK3BMQVpZRTRacWlw?=
 =?utf-8?B?U2dCOEFCYktoN1phUlFRaEtDWERjNDNaeHlnZDFNR2NBWTkyQTZvN0xXbjF4?=
 =?utf-8?B?Q0EzWjY4VXkzR0MvLzFyTWtCMU4xUWFmM1pic0xLUm1Bb3JOeTVRMzVTeTBm?=
 =?utf-8?B?dkJVWDBoV01uUG1pVDh2MjF1MUZZR0hmSmtmT2lRejZqcmFTMm1yNWVZeXd4?=
 =?utf-8?B?eFZjaVlLdVV2NWZOdFJHRlFXUjdBa1F0bmpZdUY5Uyt6YlVDcXZoT3JRZ1J1?=
 =?utf-8?B?L3dIcGRaeVZaS3lNd0M3d214MkdDSGIra3lpbzRJOXhyOUJjdlJlUDB5RWtS?=
 =?utf-8?B?eDhQSVJzOXZCM0haKzdsSCswWVlYaHhIMmJuSDNkUVFNZmhRK2I0eHNtdS9i?=
 =?utf-8?B?UmRac1NEdC9ic1dqUm5kTlQrWFNtN0xrekpBejBZSWgya2oxQThTUWV4VGVZ?=
 =?utf-8?B?OTlaYzQ3U1VKUDdKalBXVEVUM0hNNUpQUWpJbC9UZFlUUlpSOW4rQ1ZaWUxw?=
 =?utf-8?B?SzlsUnBiV29NT3lJeEFPTE51SnJEZlRYbnBiblhjcWZ6V0kyNCtPYUhaSVNx?=
 =?utf-8?B?ZXBVVkc5N2cyRlBoOXJxcWtoQXdOd2paeHJ1UGtsM1E0b0swYmZ3SUhXOUpW?=
 =?utf-8?B?RkxHVzIzREt6Rk5xWFZNSFlCdG1XTlByWVVsWS85TzJTTEhheXJuY1BJTDdw?=
 =?utf-8?B?ajB5aWJMckFIK2Q3M1JZa1lVKzR2QkhzeElRNFB5azdhRXcxUjlKRkx4Qndv?=
 =?utf-8?B?WHlPdGhWYmpFL2hkZkFEa0pIeU8xNGEyS1kyYU1NMUc0S3pUd1NzTVh1YjBR?=
 =?utf-8?B?anJJUFBDVis1Ylp3VW5IYTlVOW11MG43WjBoeDU3bGxNRW9kQlJWL1ZmSXhU?=
 =?utf-8?B?ZHplNnl4VkVGZmVsN0ZiVmo3OXB6WUwxY1hudHhZNUc1OXVkL3ptQ05nT21r?=
 =?utf-8?B?S0dNQ2dnbWRkRnlpYi8xdXpEWmFnalMzRUpTY05BeW03MVdwQi8wL1hvWDEx?=
 =?utf-8?B?WG4wcGdqVmVudHVaQVBTQ0ZoZjlwb2xHejlmNmhqSllFTHRpV3UxRUtoWWlU?=
 =?utf-8?B?VUQrbmtLa0lLcXRLSTJ3a25NSTR5eVYzNklmS3NYdjg2V2gwL3F2Y09uS1l3?=
 =?utf-8?B?L1ZianFwc1RrMUpRS1hkTnl6VGRPV2tuVG0rUjJPOXA0NlU1b2hIMW1LWWZ1?=
 =?utf-8?B?WWMrUHA4anhMTTdmSVJjM3VpYVhLNnlCVERiVXpsQzVsb2pFT25DdWVLNkVL?=
 =?utf-8?B?Y1lNQnVhdkdOME14bStzbHdqSzJJaGhtUWRwc21DRVVsclpjTXdxLzZiNlZX?=
 =?utf-8?B?Skt6MmpCeHkvczUvNTVaOGNuZ1NnSW9pSmxGaDlIaFNhZlVldkgyaVVTNXRQ?=
 =?utf-8?B?OEEvaGR3ZWZqNVBhcll6dGhQbFFxV0ozQldDQUVmUDBiT3IzRUpzZ0J5cFVR?=
 =?utf-8?B?L3FRV3M1R2FpOXl5eWViQlhkdFJoemJMSVFEaEoyNnFlKzFwTVp3LzZGdFJ6?=
 =?utf-8?B?OG1QNlN4cjlVY1ViNnI3SG1xbGNTRXBQYjBha0pmSXZYSDJjelNkejFpQS9I?=
 =?utf-8?B?c0hNSmI3VjR4L2xnWitZZi9ST2RrMGVKNlZMTHlpTDJ6SjlTUjB4RUR4eWxi?=
 =?utf-8?B?TlRvcEJSZmQ5MjZ1b3o1YS9CUmpNSW9EVFJ3Y2lFMFN1Q3k3YUY2SVdIVlZT?=
 =?utf-8?B?dmZ5UmVTa2t6VFAvcStRcEFSTXExOWNWclgyUWtIU3BCZ0pvQ1dRdlhsMDdn?=
 =?utf-8?B?M1VLME5pR2pRRU5JUlJCYlBBSVpDQXVFV0k2Vm9iUTlkVmRuM2Z1TEhVTVZO?=
 =?utf-8?B?dU4zL0t0Qm5YTWY1aTlaeCtQUXhSNVpOSzJOQ0RVY1c3TkhnWWoyVnNtWlM4?=
 =?utf-8?B?aWRlQUJnUFQxWGtRU0dlRC85eEs5ekI4clZFMTQ5NW1BY3JtOFV4V0lsL2ZB?=
 =?utf-8?B?MXc9PQ==?=
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
	o7GS+yP25wMvKpAZix1+xt6A33UGOLTnX4YB3lhmv9mAEdmK563iNZa6Kgg+JQG1CMrLimpMmL0l7qndkWBehYbpFe2HDs9sH1iLZV/VjK9xlWWZRS2TB/LjPyC7HB9+H2DrCzTOJuw9hrLZy+VXK8s/3aaZEMubWu9pPau1OKe92jwPp4+ff3moAuFg3rAgI9ua/32fF/Z1z5KXvHuqZRB3iLttjOR6dANpfSuV6jKHzfWkhA9EokrCnqH2jMfbm8GYSTohrZ8BDaYLYyOOPLScdKkS4DtB/x1hsBTLPEPnkvLBpw3inntxXe+00wGRzb0FPMGSE823tU5/u9qjVrcvJ+sDi6d8F0R3af5VjnTgLgvBesa7JJKHObBiWi0Pp6Ppt0DXDPnMpmHKDlAbCycfU0SCna8DCnghbvIGQhNNkM3EKcmpIZaP8XqxPss24Ou3tz1jCFvPElcwMS8SZ43vZY2bHHSiNW2WBLEjiA8PXDZDo6hgyy5DvSzyJAlu7uAvPxODWYkyZBTiI0AcFJFMLdmQ+8CmggPJwlez3UmxV87rWsgxOlzMeb96sZQSrAHQlCr5POhAbLHc5amUGerWXcPZjMsvgcoe7OVAbKGQAiyauitj/DMYaYgYmo/q
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d2d673-165c-4f65-e421-08dd50d2efd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 10:48:25.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3Q6Z4JHJi5qcYI2MkEmSWLn9EiqCMIPT5cqV4y5B5k44XGmguo3+bkOGX/uFSftJnh+XAlalDq3rkC/XhVJ0/9SguvMy+NN3NWNZdtvwRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13655

T24gVGh1LCBKYW4gMzAsIDIwMjUgNzo1MiBQTSBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3UpOg0K
PiBPbiBUdWUsIEphbiAxNCwgMjAyNSA1OjE2IEFNIEphc29uIEd1bnRob3JwZToNCj4gPiBPbiBN
b24sIEphbiAxMywgMjAyNSBhdCAwMjoxNToyN1BNICswMTAwLCBKb2UgS2xlaW4gd3JvdGU6DQo+
ID4NCj4gPiA+ID4gPiA+IFBvc3NpYmx5LCB0aGVyZSB3YXMgYSByZWdyZXNzaW9uIGluIGxpYmli
dmVyYnMgYmV0d2VlbiB2MzkuMC0xIGFuZCB2NTAuMC0yYnVpbGQyLg0KPiA+ID4gPiA+ID4gV2Ug
bmVlZCB0byB0YWtlIGEgY2xvc2VyIGxvb2sgdG8gcmVzb2x2ZSB0aGUgbWFsZnVuY3Rpb24gb2Yg
cnhlIG9uIFVidW50dSAyNC4wNC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYXQncyBkaXN0cmVz
c2luZy4NCj4gDQo+IEkgYW0gZ29pbmcgdG8gc3RhcnQgYmlzZWN0aW5nIHRoZSByb290IGNhdXNl
IHRvIGZpeCBpdC4NCj4gSXQgbWF5IHRha2UgYSB3aGlsZSwgc28gcGxlYXNlIHN0YXkgcGF0aWVu
dC4NCg0KT24gVWJ1bnR1IDIyLjA0LjUsIGJvdGggdjUwLjAgYnJhbmNoIGFuZCBtYXN0ZXIgYnJh
bmNoIHBhc3MgdGhlIHB5dmVyYnMgdGVzdGNhc2VzLA0Kc28gaXQgaXMgbm90IGEgcmVncmVzc2lv
biBvZiBsaWJpYnZlcmJzLiBIb3dldmVyLCBvbiBVYnVudHUgMjQuMDQuMSwgdGhlIHRlc3QgY2F1
c2VzDQpzZWdtZW50YXRpb24gZmF1bHQgd2l0aCBib3RoIGJyYW5jaGVzLiBUaGUgaXNzdWUgbG9v
a3Mgc3BlY2lmaWMgdG8gVWJ1bnR1IDI0LjA0Lg0KDQpDb3VsZCBpdCBiZSBwb3NzaWJsZSB0aGUg
dXBkYXRlIG9mIHB5dGhvbiB2ZXJzaW9uIGxlYWRzIHRvIHRoZSBmYWlsdXJlPyBJIHNhdyBzdHJh
bmdlDQp3YXJuaW5ncyB3aGlsZSBydW5uaW5nIGJ1aWxkLnNoLCB3aGljaCBkaWQgbm90IGFwcGVh
ciBvbiBVYnVudHUgMjIuMDQuNS4gSSB3b3VsZCBsaWtlDQp0byBoZWFyIGZyb20gdGhvc2Ugd2hv
IGhhdmUgdHJpZWQgYnVpbGRpbmcgcmRtYS1jb3JlIG9uIFVidW50dSAyNC4wNC4xIG9yIHdpdGgg
UHl0aG9uIDMuMTIuMy4NCg0KWzQyMi82MDddIEN5dGhvbml6aW5nIC9ob21lL3VidW50dS9yZG1h
LWNvcmUvcHl2ZXJicy9wZC5weXgNCndhcm5pbmc6IC9ob21lL3VidW50dS9yZG1hLWNvcmUvcHl2
ZXJicy9wZC5weXg6MTAyOjIxOiBJbXBsaWNpdCBub2V4Y2VwdCBkZWNsYXJhdGlvbiBpcyBkZXBy
ZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlvbiBzaG91bGQgY29udGFpbiAnbm9leGNlcHQnIGtl
eXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVudHUvcmRtYS1jb3JlL3B5dmVyYnMvcGQucHl4OjEy
NDoyNzogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rp
b24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2Fybmlu
ZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL3BkLnB5eDoxNDI6MzA6IEltcGxpY2l0
IG5vZXhjZXB0IGRlY2xhcmF0aW9uIGlzIGRlcHJlY2F0ZWQuIEZ1bmN0aW9uIGRlY2xhcmF0aW9u
IHNob3VsZCBjb250YWluICdub2V4Y2VwdCcga2V5d29yZC4NCndhcm5pbmc6IC9ob21lL3VidW50
dS9yZG1hLWNvcmUvcHl2ZXJicy9wZC5weXg6MTU4OjYxOiBJbXBsaWNpdCBub2V4Y2VwdCBkZWNs
YXJhdGlvbiBpcyBkZXByZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlvbiBzaG91bGQgY29udGFp
biAnbm9leGNlcHQnIGtleXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVudHUvcmRtYS1jb3JlL3B5
dmVyYnMvcGQucHl4OjE4MDo0NjogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVw
cmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBr
ZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL3BkLnB5eDoy
NzI6MjE6IEltcGxpY2l0IG5vZXhjZXB0IGRlY2xhcmF0aW9uIGlzIGRlcHJlY2F0ZWQuIEZ1bmN0
aW9uIGRlY2xhcmF0aW9uIHNob3VsZCBjb250YWluICdub2V4Y2VwdCcga2V5d29yZC4NCndhcm5p
bmc6IC9ob21lL3VidW50dS9yZG1hLWNvcmUvcHl2ZXJicy9wZC5weXg6Mjc5OjI3OiBJbXBsaWNp
dCBub2V4Y2VwdCBkZWNsYXJhdGlvbiBpcyBkZXByZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlv
biBzaG91bGQgY29udGFpbiAnbm9leGNlcHQnIGtleXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVu
dHUvcmRtYS1jb3JlL3B5dmVyYnMvd3IucHhkOjEyOjM2OiBJbXBsaWNpdCBub2V4Y2VwdCBkZWNs
YXJhdGlvbiBpcyBkZXByZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlvbiBzaG91bGQgY29udGFp
biAnbm9leGNlcHQnIGtleXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVudHUvcmRtYS1jb3JlL3B5
dmVyYnMvd3IucHhkOjIxOjQ3OiBJbXBsaWNpdCBub2V4Y2VwdCBkZWNsYXJhdGlvbiBpcyBkZXBy
ZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlvbiBzaG91bGQgY29udGFpbiAnbm9leGNlcHQnIGtl
eXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVudHUvcmRtYS1jb3JlL3B5dmVyYnMvY21pZC5weGQ6
MTY6Mjc6IEltcGxpY2l0IG5vZXhjZXB0IGRlY2xhcmF0aW9uIGlzIGRlcHJlY2F0ZWQuIEZ1bmN0
aW9uIGRlY2xhcmF0aW9uIHNob3VsZCBjb250YWluICdub2V4Y2VwdCcga2V5d29yZC4NCndhcm5p
bmc6IC9ob21lL3VidW50dS9yZG1hLWNvcmUvcHl2ZXJicy9jbWlkLnB4ZDoxNzoyMTogSW1wbGlj
aXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRp
b24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1
bnR1L3JkbWEtY29yZS9weXZlcmJzL2NtaWQucHhkOjIyOjIxOiBJbXBsaWNpdCBub2V4Y2VwdCBk
ZWNsYXJhdGlvbiBpcyBkZXByZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlvbiBzaG91bGQgY29u
dGFpbiAnbm9leGNlcHQnIGtleXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVudHUvcmRtYS1jb3Jl
L3B5dmVyYnMvY21pZC5weGQ6Mjc6MjE6IEltcGxpY2l0IG5vZXhjZXB0IGRlY2xhcmF0aW9uIGlz
IGRlcHJlY2F0ZWQuIEZ1bmN0aW9uIGRlY2xhcmF0aW9uIHNob3VsZCBjb250YWluICdub2V4Y2Vw
dCcga2V5d29yZC4NCndhcm5pbmc6IC9ob21lL3VidW50dS9yZG1hLWNvcmUvcHl2ZXJicy9jbWlk
LnB4ZDozMjoyMTogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4g
RnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0K
d2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL21yLnB4ZDoyMTozNjogSW1w
bGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFy
YXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUv
dWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL3NycS5weGQ6Mjg6Mjc6IEltcGxpY2l0IG5vZXhjZXB0
IGRlY2xhcmF0aW9uIGlzIGRlcHJlY2F0ZWQuIEZ1bmN0aW9uIGRlY2xhcmF0aW9uIHNob3VsZCBj
b250YWluICdub2V4Y2VwdCcga2V5d29yZC4NCndhcm5pbmc6IC9ob21lL3VidW50dS9yZG1hLWNv
cmUvcHl2ZXJicy9zcnEucHhkOjI5OjIxOiBJbXBsaWNpdCBub2V4Y2VwdCBkZWNsYXJhdGlvbiBp
cyBkZXByZWNhdGVkLiBGdW5jdGlvbiBkZWNsYXJhdGlvbiBzaG91bGQgY29udGFpbiAnbm9leGNl
cHQnIGtleXdvcmQuDQp3YXJuaW5nOiAvaG9tZS91YnVudHUvcmRtYS1jb3JlL3B5dmVyYnMvYWRk
ci5weGQ6MjI6NTA6IEltcGxpY2l0IG5vZXhjZXB0IGRlY2xhcmF0aW9uIGlzIGRlcHJlY2F0ZWQu
IEZ1bmN0aW9uIGRlY2xhcmF0aW9uIHNob3VsZCBjb250YWluICdub2V4Y2VwdCcga2V5d29yZC4N
Cndhcm5pbmc6IC9ob21lL3VidW50dS9yZG1hLWNvcmUvcHl2ZXJicy9hZGRyLnB4ZDoyNzoyMTog
SW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVj
bGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hv
bWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL2NxLnB4ZDoxMToyMTogSW1wbGljaXQgbm9leGNl
cHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxk
IGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEt
Y29yZS9weXZlcmJzL2NxLnB4ZDoxMzoyNzogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24g
aXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhj
ZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL2Nx
LnB4ZDoxODoyMTogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4g
RnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0K
d2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL2NxLnB4ZDoyMDoyNzogSW1w
bGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFy
YXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUv
dWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL2NxLnB4ZDozNToyMTogSW1wbGljaXQgbm9leGNlcHQg
ZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNv
bnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29y
ZS9weXZlcmJzL2NxLnB4ZDozNzoyNzogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMg
ZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0
JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL3FwLnB4
ZDozNzoyMTogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVu
Y3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2Fy
bmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL3FwLnB4ZDozODozNjogSW1wbGlj
aXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRp
b24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1
bnR1L3JkbWEtY29yZS9weXZlcmJzL3FwLnB4ZDo0NToyNzogSW1wbGljaXQgbm9leGNlcHQgZGVj
bGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRh
aW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9w
eXZlcmJzL3dxLnB4ZDoyNzoyODogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVw
cmVjYXRlZC4gRnVuY3Rpb24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBr
ZXl3b3JkLg0Kd2FybmluZzogL2hvbWUvdWJ1bnR1L3JkbWEtY29yZS9weXZlcmJzL3dxLnB4ZDoz
ODoyODogSW1wbGljaXQgbm9leGNlcHQgZGVjbGFyYXRpb24gaXMgZGVwcmVjYXRlZC4gRnVuY3Rp
b24gZGVjbGFyYXRpb24gc2hvdWxkIGNvbnRhaW4gJ25vZXhjZXB0JyBrZXl3b3JkLg0KWzYwNy82
MDddIExpbmtpbmcgQyBzaGFyZWQgbGlicmFyeSBweXRob24vcHl2ZXJicy9wcm92aWRlcnMvbWx4
NS9tbHg1ZHYuY3B5dGhvbi0zMTIteDg2XzY0LWxpbnV4LWdudS5zbw0KDQpEYWlzdWtlDQoNCg==

