Return-Path: <linux-rdma+bounces-6818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ADBA01CE0
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 01:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A38162672
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 00:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD26FB9;
	Mon,  6 Jan 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GZV/lBVf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519144A3C;
	Mon,  6 Jan 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736124178; cv=fail; b=et9hws+dDPC9VQDvALBEOIkcvXtwgv3pJSFjHuItspcClYlDSQdn5NBOohSMOlcrCQUF8wLZ6zfsPHKamicmCNV084Zggc+p0hWme71TTDIApSx9zRm7WRo4eIBFqEKr4ACqvwqG6JYiI+zvjzSx7lThMr4s1EJPUebCYVE3ghE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736124178; c=relaxed/simple;
	bh=6HO4JhaOipkTV4anRBlDa/C790NAuq8YgD23oRzbSMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ut3pY8cepmJlBe9UX6Po4nhUgobETs9riwGM6OIwoQxYMO6sNNtyRst/Str5znYskoKNhf2b67+E8Ouih7yN270GdhQj+EBL18OQlFBVFr6eHTuH+Zle5FhgDyJs+mRsUs1Eb0kw6NKErr5TU3Yy947+uxnRkkk6bQut6WCrXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GZV/lBVf; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736124175; x=1767660175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6HO4JhaOipkTV4anRBlDa/C790NAuq8YgD23oRzbSMc=;
  b=GZV/lBVfzi42ZfPLZFI4u8zGkkM6doXD9JOK9OZGp3BXrLSr1MTdqNCx
   nJdyWN9JE3f8WZnYxu3DBHxm3iTyiCT4Uzo1ZhesE+ABw4cVh1ky19xzF
   B0NroUcN+uMa0osxr2k2X+CwdSfQ9eOKSeE6szWH2jdDKLvvLcifq5RA7
   0tB2WFPNiQs6abenLr0GqW6yxQpyZwCD1IW3onnzSFQFqjVU7CkXhVJXT
   m0Lc5jwinJvEaZxJ85T3FnjVL8XBPMweikUnmN9vpo0numPYq3ChnTZ8v
   4Q1PFze2yDCq7cL3tbKO3FnP8AoPKnQOOxhHvrNQFh0XoCKbh6+tgpEAZ
   w==;
X-CSE-ConnectionGUID: wnjdYUxORdKI/hxZBamjxQ==
X-CSE-MsgGUID: 6lD/HVisQQ+rcoT5CZYrBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="142050672"
X-IronPort-AV: E=Sophos;i="6.12,291,1728918000"; 
   d="scan'208";a="142050672"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 09:41:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr46hQsLpEdnY48rf/WkZ0c+g4fjUnB6/+OLVF+0kfbTQ3IbM+ofZML6Lka1dMzeMMyXWINCUMsPxKPzFYmXrkerrgENXR6pxExH/gckNk4qy0doRvBTOR1TZcwAs8UlH0xiDoRgETLyDIL4srbFedUhuCUl/XO+ZSkS+wHs0pTuvJua6iFkPZ/s7QgjcMQ2029WGXsD4xaBonjQLR8fMj4KO6FQPvBC/XOYT+RBLGXS6DGpxAW+IExTT92pkRK8bSLb3E/vgBZzn/aaNtwfleFiF+RMmh7v+P880cbCcBWjd2jrL5OYowvIqTKOHOSsCAc/Saa943LleDU3Rv+ZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HO4JhaOipkTV4anRBlDa/C790NAuq8YgD23oRzbSMc=;
 b=lZ6j7WJ9pFvjqc9OkroCCzWonVlSssN1fzxHLRSb2tUpo8NyXJonCZMVCJam3saBgDumUSktU4Rf34MbZI3Jo75G+RGUBGCq4ZjuMU05C3MnisApukrkwnGa1FiyVP7E584TboymhBi5ahXdOXwNfcPWdtUenlDp/YgltfogF2pjdAuFEt6Z5iG5G8SFfqwiK2W2r9TxTNtqUzFNvNlEVyqO0uVR1zNHcF1WVFtGc2N+9WMixreTmPnuCXc0ba8fwa8LqvRcoKr+ZFzNWDzcJYwFmi7ApiGRWdztfNpVgcp8KKYl/XQyeHCg54bPz6hCtn6wSXDBqyG0UtG/kgRAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB12150.jpnprd01.prod.outlook.com (2603:1096:604:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 00:41:39 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 00:41:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/rtrs: Add missing deinit() call
Thread-Topic: [PATCH v2] RDMA/rtrs: Add missing deinit() call
Thread-Index: AQHbXYzS/0hhfDYhhkK+ZFKXALspb7MFU7EAgAOYqwA=
Date: Mon, 6 Jan 2025 00:41:37 +0000
Message-ID: <1402e36a-176d-4d6b-b986-67739d486ddd@fujitsu.com>
References: <20250103030839.2636-1-lizhijian@fujitsu.com>
 <CAMGffEnWkf7TzBS6=HtqO98b0oh4uRKYDHMghnt=aeJdY+36Xw@mail.gmail.com>
In-Reply-To:
 <CAMGffEnWkf7TzBS6=HtqO98b0oh4uRKYDHMghnt=aeJdY+36Xw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB12150:EE_
x-ms-office365-filtering-correlation-id: 8b064bf2-c0b4-4d34-6a34-08dd2deae103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkZSVFYxYy93aVNJS1M3Wk85KzJvWXl2WHB2Y00rQWphbkR5WGpIWlVtSmlE?=
 =?utf-8?B?RnFodzdWUDVQdm4vc2FxNk5tL2hwbmVSc2pXOEprVzNHVnlmOUZtUTJyUWg0?=
 =?utf-8?B?SGFoekNZN0pPaUJJRGpOT1ZqQS9kSGZmQzFmbENRWTFySjNRK01ocERpcVZR?=
 =?utf-8?B?am5Ya0drODJEY2RxSnE0NTR3Z3pOZUI4RFBRQmNZeEJ2cU9LdjREdlc4Q0pO?=
 =?utf-8?B?YkROeThCYy94aGROcnZTQThLZnk3SmhNN2ZyTysxNG96YUpnYUpQcUNLa3R6?=
 =?utf-8?B?WkNyNnVvS2cvR3BGQnV5ckRNTUR3MG5WVEFRU2k3MHQ5d0xqdHorS002eHox?=
 =?utf-8?B?eGRIdzlrbmRVd3FTZFM5dE5xMUJWZ0lKUGNWTjFLUUM3U0pzQ0lDRFk2QjN0?=
 =?utf-8?B?SElnY3haL1VId0tNLzVJZk9BN2RMMGc4NG4zSzhMS05maElITzdZb1pLOVRJ?=
 =?utf-8?B?MUVTRm5tNnpZRUUxeU9YUkorN2IyWVcvS0hLYlpBNDBNaEhYb1NBd0pMdGdv?=
 =?utf-8?B?TEZlUDZWR2NQb3h3K3NrOE8rTGZYV296R1FIbUN4V0JST2FVL0ZwdytrSDh3?=
 =?utf-8?B?dXpWTlBLMndUMVlDcy9VL0N6dVB2L1Zzdk83WEJTMU9HSllFcEFLMG1YeGFC?=
 =?utf-8?B?V2VpT2MvTmZ4NVBiRG54QkFNQVpDcG1heTVJQmpSRU9RdTRMbSsvaUVFeDli?=
 =?utf-8?B?Q2xJeFdla2x1WDc2aGltcW5ZZ0JMeEpGVG1RbFNXa3hyckZvZkFybGZrSUMy?=
 =?utf-8?B?UExkQ2Z3dVRDNTNjZ0R6SWcrbXFyS3JPV2hOUUNpY3I3RXFIaTQzTVRVQjdx?=
 =?utf-8?B?bFVaR1hKaVAwbkVQYWpPZmFtd2FTS2x0UnFEdnN3RTV6WUtzM1E2aCsrMktF?=
 =?utf-8?B?L0JFVFRqVVpuYnZ1ZlFOUHN6Mlo2eTY2YjNQWUM5TWI3MXJwWit3UUxSWU1N?=
 =?utf-8?B?cXNzTHpGUUxZeDQxT2tXQzI3M0ZUWW94ZXpiczNVcU11aGZHTjBibytqUm0z?=
 =?utf-8?B?UHhTQ0xyRDRjdGhBZ0NaY29NSVVLemhvUFNWZlRTdG85M1MydkI3YTc0alJx?=
 =?utf-8?B?NGpNOFh1SE16MkRWaGcyUDAzVW5VWGV6ZHhjWjJWWllNVkVjNFRad1dod0JV?=
 =?utf-8?B?MkZkK1VnS2o4QnRaNUxQanlZY0hPbXVsWUp4VjJHMEx1UVNLdWJZTkhReFY5?=
 =?utf-8?B?czNrTU1tT3RpT3ZhVE9nYXZ2bFJHQ1BqU0JEOUtyczRFYmdwZkg4UllUSW9J?=
 =?utf-8?B?L09GMUtROVpadmdqaThDM0tBaFNSd1FSaS9VTlJ3QzFiTlZDRWZkY08rY3oz?=
 =?utf-8?B?SktJeU8xcGVMWTgvdDArdFlINGtETkpRWTI3eUNUUWRWcTlYaWRBSXNabWFi?=
 =?utf-8?B?VVB6emJLWk10bXlmMmJUaGVIMWp1cHh5OUpQOXFKVlNTVUhWZTBjVDViKy8r?=
 =?utf-8?B?NHM5SWl5eTdzakxZajVlRDNOTGFkUFNkZzZHMTBTbFBybUMxWFV3NEJTMExU?=
 =?utf-8?B?ZkQzdWs3MEk2THhFNDlJZ0NPZE9ITjVGTTFrdGZVU3dXbTZZNlE3a25VL1Zo?=
 =?utf-8?B?NXVXKytTWFNjbDVmMFNpNThOaGZ5SjVqcE9hRXlOTFlka3UzNzJqanp3bUV6?=
 =?utf-8?B?aVdmekxuajhpNVdyMmVYbmpzbzdqTXFKb0FoMGJvN2pzYUtIeVFjeC9TYTZQ?=
 =?utf-8?B?TG50cCthdnhZTWkySEVNVkkrSUE2ZnF4V1RGUTRMZmlpWVZnakhWbHRrWVFO?=
 =?utf-8?B?aW5PdnQveGI5SFRNMVBPK0x4RHZhU0ZzSmlaM0FEeERrV2VrdVk5UDA1c0lW?=
 =?utf-8?B?SzNUSDh5cjloNmcxa1k0YldFTHFRbmNZb2lMSmI1Sm04Tkt4a3NuUVg1aWlN?=
 =?utf-8?B?UFZsZEREdlVHZXZyc2E2VnJDQnY4VHptenRINEFlclNqUGw0TmVWY3YyQVhs?=
 =?utf-8?B?K01qYWwvcHFlQUxweW1CWmRVWEV1dXlzTUdkYUJadTJBYWxPZC9udnA4QURa?=
 =?utf-8?B?YXU2bmZVSDNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cndCR2t6V0M4NXNPdnY5WG5zUWFudHAzOHhwTWdicUhoNldSM1ZLVEpnVHlu?=
 =?utf-8?B?allpWk5ldVVxZmZ1aW9FZG1qbU55UCtzbXpEaXl2NGxGODFLUFI2YTc3ajZi?=
 =?utf-8?B?WGZmSFZEem5KdHhVU01xZk9IRGtSakovNjd6eGpxNld2SDF2ZVpmd0d1NWto?=
 =?utf-8?B?ZFpTK0JNRkkzU2lla2k0RmMvNzMwVEZjQnBVdGlTb3RZcE1sL0xoQWsyRHVp?=
 =?utf-8?B?S3cyOWtjL0t5NWQvZHhsN0V3VFdSN2lqblg4eHRPQXgxU21haWJkVE9CSFJJ?=
 =?utf-8?B?MlVxRDc5RzZhU3B6M0k0MC9wendQcThOczlwOFZLOFFTeWRiQVcraWx2YU1j?=
 =?utf-8?B?Zm44Z2VqanZtempOSHpoamIrZnFDWk1HRDBjMUx2VmhvNG4yY2FSVnNvN2NY?=
 =?utf-8?B?d2VSVmpWY3hQRnZTY1NsS2JWQ0VlNTdjZElKN2ZSWmgwMEZ2WFdsOXR3bXR3?=
 =?utf-8?B?QnhkckpuSGxvQUtGc0h0bFVlRzJIalF3ODlDNFU2R1doK0liYmM3bnNBLy9l?=
 =?utf-8?B?MzhkaHlISktRbUNyNFBQUDA4Q0NDYlZDUzZ1dFh1a0I2QVFCalhoLzZPeitr?=
 =?utf-8?B?MnhZMkg5VTkyTVFyL1BIN0Y5dWVLOERiSmJvbndLRlE5Ni9mOW45cHBnaHRE?=
 =?utf-8?B?TnJrbm8xZEtuTmdZWkJDQnN3K2VOM2gwazlIaTJLSW5lRCsxVXRTMFo4UjIw?=
 =?utf-8?B?RnQ1YVJEN2lFeW9rd3NXajhweXlPSGFiN0J0VnZIeW56b2g5bTNDZjYzcGZq?=
 =?utf-8?B?UTJzMXk0bCtUQ1I3eGZ0WU13SlJvaXRVNkNjLzJWUWFlT2crTkEwZnFqRjlk?=
 =?utf-8?B?bVNGeHJ3b2t1WmMzbGQwYmFvN1A3U2xzczBwTHRiRFhGS2Y0MlZ4SFZHekVY?=
 =?utf-8?B?aU8rRmdWaGxrMDZ4M3AyMDYrbHZEdlRadFdnVFM4M3l0MjZMKzZGOTRkaGI5?=
 =?utf-8?B?RVhwNTc0SHE1N1dSWE93bDdsdHZWallFbWNyRk1JMGdOblFRUEVnRnBHUVk2?=
 =?utf-8?B?WjVVcm5IMmZEcXBBYUtEN1Q2L0VqTzFZMlM3WmkrUGgzaVhJVUVnbXBoQmZ2?=
 =?utf-8?B?UWJiN2k4VDVpbW9hOCtKZ1ZkSVhjMkQwSXAwZGh5dlc1SXYrczVyZ25lNmV6?=
 =?utf-8?B?YWFqa3o0WlRHUG14eTh4SjlISXFxd0RPTC95TmRjcURTaFA5TE5oQ2hPakR1?=
 =?utf-8?B?ZWdiTmgyejUxZXNHMFN4WnRvWjM5Z1pZdTIrUzg4TTJjWm1mSW5sL0VpTW80?=
 =?utf-8?B?bi81UndUV0p0Q2hValZZSnFyQUQyUTVxMHFSeVhIYy9Kby9QSk9sT3FHc0ZD?=
 =?utf-8?B?UnBsYnpuSTNRY1BFRUl2MSsxdUJVQUVTcndJamZNYmNINlJkTncwVzU5MVJl?=
 =?utf-8?B?WCs5TmNmRVhFY0FiV2lLUUgyRVNxNXV5Z25UczhLVzFsOTRuUFVSRHo5WFFB?=
 =?utf-8?B?Y1d0NkUyaGFqbWsvaDhTeGJyMW5BYi9mTkF0bEtKaFNla2g3Z2RSS2hXR21q?=
 =?utf-8?B?L0FCbmZaRVJFaXJvcjNZaDBONTdRMmtGRUYrWkRZUGNwKytrcmNwTmE5dHp0?=
 =?utf-8?B?ZkxrUjduYnF0M0ozRHVjR0NzM0JHbDVQbjRqY1dGM1ZJb3Rxc0ZHRFFVeUNG?=
 =?utf-8?B?WmlpSWNqZlNGdUs2eWZpSEV4Vk5NaTh0WUFCL1FRMXM5elB1NXoxQ0pRa0Z0?=
 =?utf-8?B?ZmNNQTFQVytST0R4d1pETklBNjZqRk5LSFl1enQxMUhXMGpkR2FKdnlFWjR5?=
 =?utf-8?B?eFZZSUkwOEdtZytoRmFFa3FLWE1hUUpxTVM1bVZWVlRETHh2UFVyMDRGMFRk?=
 =?utf-8?B?Q2dTcEhGMmEwNmVlZVE4Q0NxZWZ6UDFFVlJ6T1laZE8yZU9NaVpnT2c5Q1Iz?=
 =?utf-8?B?eHBWWmFlZTJ4ZGdzN3ZnVHhGTUlIUGJaZFFjT3VwdnE2c1JSTnJJQm0vNlNO?=
 =?utf-8?B?QlBxU1o1K0JwY2wyZmdwRkdudE9hV1paNW5zRVZRR1l1VytKNElXaCt5TXps?=
 =?utf-8?B?dlRhV29OYXBtSXIrSmNlSTR3N2VsbG00c3JSTCtaTzJsWnptQ1lvWUsrVWZZ?=
 =?utf-8?B?Z2J5VjB3YnFZWVFzMnFOVHp5ZHVoVTJlRmQzdWo1VG85WVlyb0lLUDd4SkhF?=
 =?utf-8?B?WTNTMVlBUTBUUG90dk01RFpvVVh4K3lDSU12OXlQblNzQWZtWmp2TnNtWkxm?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <898BCFDD68ACAB48A2FB66A440601F64@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CIsHH0/5cwVs+F6uaQVwyDZBd9kgq24NjjbTnjn5B9QirukRLlkQNFOSwZA0DoK8fK/LoiOKGRSk0JM09obXQy0D3DGvzvI/FFlo4DfbiAVeO1dQKjt3Xp4SlUBAJDtmWKjbHVokgLiznWiWjRScr/THogdZx9LTsBgMGyb0nFSYvjg7shB/pAVkLoXFLMX3pztJUf5eADhJdD0+Y4Agxb7L8VlRhX51TNSSg9UgLvV1L7v4WgVerKHGedoTB8az+eNiyYyq2Lj9gjOWl5dvdvnREzDYY5la4ePdoOmJ+ZT/pk9ZyIeChVog7mPNIF9azgBA3UeORaAK2N5TkCXz+IIlorq7xDidp9qUlGQyS2JVVMpI0h0BgL+jhGwi6Y9xO0OE/Z4o8ym67abV5JwG9FZYXmk1lHmf+cj1jZagOBrHXJF39qoVh0Oy9G8JpHoJbdUxDNF9eb/vohyprf+rt8VOOFTk6EUeQyc6kYXEMu4oHnQbFlyc9sOq9ikPLyHmOxi1hSQ6LW9tSvvH+8riUrwYWTwILT7+L343Oe/mn6/TmT0BVeFq71DRDAOdZKN+1/2eLHuz2smnpwLdPdLhJopGUjXSsEEwJqqddGgwh2IKEnkb1q2qg/SeNRFl1nAG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b064bf2-c0b4-4d34-6a34-08dd2deae103
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 00:41:37.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/0rCc27jS/yvFIuhVoTd8PYbXK7HnZ9mDb2x7gmpS+hVAFhyYooSnGENrMUelp3iCTze4i7yeBno8nZ6PdqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12150

DQoNCk9uIDA0LzAxLzIwMjUgMDE6NDYsIEppbnB1IFdhbmcgd3JvdGU6DQo+IEhpIFpoaWppYW4s
DQo+IA0KPiBPbiBGcmksIEphbiAzLCAyMDI1IGF0IDQ6MDjigK9BTSBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+IHdyb3RlOg0KPj4NCj4+IEEgd2FybmluZyBpcyB0cmlnZ2VyZWQg
d2hlbiByZXBlYXRlZGx5IGNvbm5lY3RpbmcgYW5kIGRpc2Nvbm5lY3RpbmcgdGhlDQo+PiBybmJk
Og0KPj4gICBsaXN0X2FkZCBjb3JydXB0aW9uLiBwcmV2LT5uZXh0IHNob3VsZCBiZSBuZXh0IChm
ZmZmODg4MDBiMTNlNDgwKSwgYnV0IHdhcyBmZmZmODg4MDFlY2QxMzM4LiAocHJldj1mZmZmODg4
MDFlY2QxMzQwKS4NCj4+ICAgV0FSTklORzogQ1BVOiAxIFBJRDogMzY1NjIgYXQgbGliL2xpc3Rf
ZGVidWcuYzozMiBfX2xpc3RfYWRkX3ZhbGlkX29yX3JlcG9ydCsweDdmLzB4YTANCj4+ICAgV29y
a3F1ZXVlOiBpYl9jbSBjbV93b3JrX2hhbmRsZXIgW2liX2NtXQ0KPj4gICBSSVA6IDAwMTA6X19s
aXN0X2FkZF92YWxpZF9vcl9yZXBvcnQrMHg3Zi8weGEwDQo+PiAgICA/IF9fbGlzdF9hZGRfdmFs
aWRfb3JfcmVwb3J0KzB4N2YvMHhhMA0KPj4gICAgaWJfcmVnaXN0ZXJfZXZlbnRfaGFuZGxlcisw
eDY1LzB4OTMgW2liX2NvcmVdDQo+PiAgICBydHJzX3Nydl9pYl9kZXZfaW5pdCsweDI5LzB4MzAg
W3J0cnNfc2VydmVyXQ0KPj4gICAgcnRyc19pYl9kZXZfZmluZF9vcl9hZGQrMHgxMjQvMHgxZDAg
W3J0cnNfY29yZV0NCj4+ICAgIF9fYWxsb2NfcGF0aCsweDQ2Yy8weDY4MCBbcnRyc19zZXJ2ZXJd
DQo+PiAgICA/IHJ0cnNfcmRtYV9jb25uZWN0KzB4YTYvMHgyZDAgW3J0cnNfc2VydmVyXQ0KPj4g
ICAgPyByY3VfaXNfd2F0Y2hpbmcrMHhkLzB4NDANCj4+ICAgID8gX19tdXRleF9sb2NrKzB4MzEy
LzB4Y2YwDQo+PiAgICA/IGdldF9vcl9jcmVhdGVfc3J2KzB4YWQvMHgzMTAgW3J0cnNfc2VydmVy
XQ0KPj4gICAgPyBydHJzX3JkbWFfY29ubmVjdCsweGE2LzB4MmQwIFtydHJzX3NlcnZlcl0NCj4+
ICAgIHJ0cnNfcmRtYV9jb25uZWN0KzB4MjNjLzB4MmQwIFtydHJzX3NlcnZlcl0NCj4+ICAgID8g
X19sb2NrX3JlbGVhc2UrMHgxYjEvMHgyZDANCj4+ICAgIGNtYV9jbV9ldmVudF9oYW5kbGVyKzB4
NGEvMHgxYTAgW3JkbWFfY21dDQo+PiAgICBjbWFfaWJfcmVxX2hhbmRsZXIrMHgzYTAvMHg3ZTAg
W3JkbWFfY21dDQo+PiAgICBjbV9wcm9jZXNzX3dvcmsrMHgyOC8weDFhMCBbaWJfY21dDQo+PiAg
ICA/IF9yYXdfc3Bpbl91bmxvY2tfaXJxKzB4MmYvMHg1MA0KPj4gICAgY21fcmVxX2hhbmRsZXIr
MHg2MTgvMHhhNjAgW2liX2NtXQ0KPj4gICAgY21fd29ya19oYW5kbGVyKzB4NzEvMHg1MjAgW2li
X2NtXQ0KPj4NCj4+IENvbW1pdCA2NjdkYjg2YmNiZTggKCJSRE1BL3J0cnM6IFJlZ2lzdGVyIGli
IGV2ZW50IGhhbmRsZXIiKSBpbnRyb2R1Y2VkIGENCj4+IG5ldyBlbGVtZW50IC5kZWluaXQgYnV0
IG5ldmVyIHVzZWQgaXQgYXQgYWxsLiBGaXggaXQgYnkgaW52b2tpbmcgdGhlDQo+PiBgZGVpbml0
KClgIHRvIGFwcHJvcHJpYXRlbHkgdW5yZWdpc3RlciB0aGUgSUIgZXZlbnQgaGFuZGxlci4NCj4+
DQo+PiBGaXhlczogNjY3ZGI4NmJjYmU4ICgiUkRNQS9ydHJzOiBSZWdpc3RlciBpYiBldmVudCBo
YW5kbGVyIikNCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1
LmNvbT4NCj4+IC0tLQ0KPj4gVjI6IHVwZGF0ZSB0aGUgc3ViamVjdCAnUkRNQS91bHAnIC0+ICdS
RE1BL3J0cnMnDQo+PiAgICAgIHVwZGF0ZSBjb21taXQgbG9nDQo+PiAtLS0NCj4+ICAgZHJpdmVy
cy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMuYyB8IDMgKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3VscC9ydHJzL3J0cnMuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLmMNCj4+
IGluZGV4IDRlMTdkNTQ2ZDRjYy4uM2IzZWZlY2QwODE3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3VscC9ydHJzL3J0cnMuYw0KPj4gQEAgLTU4MCw2ICs1ODAsOSBAQCBzdGF0aWMgdm9pZCBkZXZf
ZnJlZShzdHJ1Y3Qga3JlZiAqcmVmKQ0KPj4gICAgICAgICAgZGV2ID0gY29udGFpbmVyX29mKHJl
ZiwgdHlwZW9mKCpkZXYpLCByZWYpOw0KPj4gICAgICAgICAgcG9vbCA9IGRldi0+cG9vbDsNCj4+
DQo+PiArICAgICAgIGlmIChwb29sLT5vcHMgJiYgcG9vbC0+b3BzLT5kZWluaXQpDQo+PiArICAg
ICAgICAgICAgICAgcG9vbC0+b3BzLT5kZWluaXQoZGV2KTsNCj4+ICsNCj4+ICAgICAgICAgIG11
dGV4X2xvY2soJnBvb2wtPm11dGV4KTsNCj4+ICAgICAgICAgIGxpc3RfZGVsKCZkZXYtPmVudHJ5
KTsNCj4+ICAgICAgICAgIG11dGV4X3VubG9jaygmcG9vbC0+bXV0ZXgpOw0KPiANCj4gVGh4IGZv
ciB0aGUgZml4LCBJIHdvdWxkIHN1Z2dlc3QgdG8gbW92ZSB0aGUgY2hhbmdlIGFmdGVyIGxpc3Rf
ZGVsDQo+IGJsb2NrLCBrZWVwIHRoZSBvcHBvc2l0ZSBvcmRlciBmcm9tIHJ0cnNfaWJfZGV2X2Zp
bmRfb3JfYWRkIHdoaWNoIGRvDQo+IGxpc3RfYWRkIGFzIHRoZSBsYXN0IHN0ZXAsIGFuZCB0aGVu
ICBpZiAocG9vbC0+b3BzICYmIHBvb2wtPm9wcy0+aW5pdA0KPiAmJiBwb29sLT5vcHMtPmluaXQo
ZGV2KSkuDQoNCk1ha2Ugc2Vuc2UuDQp3aWxsIHVwZGF0ZSBpdCBzb29uLg0KDQpUaGFua3MNCg0K
DQo+IA0KPiBSZWdhcmRzIQ0KPiANCj4+IC0tDQo+PiAyLjQ3LjANCj4+

