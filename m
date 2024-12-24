Return-Path: <linux-rdma+bounces-6714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B109FBA13
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 08:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260717A1606
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C0717D355;
	Tue, 24 Dec 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="k1xs7Dlm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5D161320;
	Tue, 24 Dec 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735023994; cv=fail; b=Z1SZxD7MMgEepLAhcB6r7RegIj8mpeDKNhaGaGxa9dS+XyHy7Tq7MXwz1KF1TSm+ge4Tjqtv9bffZ1gVDdMUuy3iEjmML3auUXKNSrQN3jf9AFg4BbHkLQuffc6W+B1Exb3OkkGFyI7ABgNGapvAGtt0rn9DOh5VrMFOwwYuBkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735023994; c=relaxed/simple;
	bh=hn4ouJtvYIMYR4Hd23LAnjgvewwhk06fWcuSzN3cvlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRTF8/02Kzg8q1zngk8bPnLsdxdVx+/CDZ0GcpOIRPvPpVk6rFiJWcr1L7AKp4keYgh5hc21HFAeqX+isT9Hj2FOuZkqastTKxpoQk5Abvv7E0+LXNA3l0Dmlfyvepsrj1gFv3p1KAiWSAHdJlMHmkPTLWk2JzeiNnFFwoQvTng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=k1xs7Dlm; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1735023993; x=1766559993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hn4ouJtvYIMYR4Hd23LAnjgvewwhk06fWcuSzN3cvlc=;
  b=k1xs7DlmDKcJyYndHD4wfiJeJuE9ohHcjBejLccxebgCtK5yx6cik/0d
   SgHUTY6d5Ma1hFPClW9WufcPZ9h2cIJ/T+hgPJMRKtedhp95HZzdrUnpZ
   X5qKbHBTsqVVRO20KWZWQgXeL2MWBy1qixFrXR6nA9nsqtz9yk62SfNOd
   9yQy4Js7Mxp45Y6irF95H46tNX0CpprBkg1uzHfrX28D2JiunhT1sDU2Y
   RiZk3HqJ0zQyZkw2r/DyP6XsLhaAeenIiIx4dnaimjfTznl5BZ0VLPRzO
   4d9X7IwddK8MVf3fIFdp0yoR96iXlZx1C7dCKrNca9OP7mLZWLOwy+ko7
   A==;
X-CSE-ConnectionGUID: nwR7j/NnTSqPfE/LsIFp5g==
X-CSE-MsgGUID: Sf3QCn17Q1qqpRL7B+ryEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="141155607"
X-IronPort-AV: E=Sophos;i="6.12,259,1728918000"; 
   d="scan'208";a="141155607"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 16:05:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH+r69DqJdCgDoGIu8Ahbq+Agoi37k2tI7mJPNjqiBNNDCm6eCuQGuQ1rmizOjU4742Q1pTBgKYAe6+XzSs4DKLVf8KwDb3wB+/TbJ5m2notblM7LvLjdiMTpNYZJjDZe3bMMIh4sY5FN9vx4X7kT9+qDxHHevTnoi59i/DoyPFZkWvOPtXl3mD/MHW+W4D1M6Oy8eraeHfftV7gAsF+1WF4eUPPNV+rsBoQqBdFHamItWIO8I/yHQHa9sc+SxsdgTe15sSTB9KYDOnrZrkW2g8yhzU70EdlLwLD5UML30USiM7rMSWVW0wZGccRfbtmgLPOV8E87EqoFsg5zi4RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn4ouJtvYIMYR4Hd23LAnjgvewwhk06fWcuSzN3cvlc=;
 b=YU4p5dSVghib6RS+ZDhCFfAVzDeQhI4KA80VsARQerrFF9IN+W0lNgPt8grzy+9LQqsGlQHobfpBruy71eR6cy5bHe5g8JOw908ch9An2G/L56m9Cdpvjr8gcA0ehRIIzuL7M5WgLflqS4tsSMZ242GZlEnMQZ8cqnlos0/MhBsV1VxbHAnx8XCbzE2XyWuk75EskjeuHe86/v67HzsbcVIuJSQz74S37fC2dJ6nz/o31Vm6qilYrop52Vox08MqJ0uxcf1SgpJfAM8PL4PO0/tiQjaTkKospOXCdW/4N4J4Y3SonWRftq8VKlFJKL0ZlcIJEJQuRtFltDd4HuGf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYBPR01MB5406.jpnprd01.prod.outlook.com (2603:1096:404:801e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 07:05:16 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 07:05:16 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ulp: Add missing deinit() call
Thread-Topic: [PATCH] RDMA/ulp: Add missing deinit() call
Thread-Index: AQHbVOZd0FKAzOSIGUKPVREyWNNbsLL0+pCA
Date: Tue, 24 Dec 2024 07:05:16 +0000
Message-ID: <eabd8945-cd07-4ee4-b6e1-a6f251d157c0@fujitsu.com>
References: <20241223025700.292536-1-lizhijian@fujitsu.com>
In-Reply-To: <20241223025700.292536-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYBPR01MB5406:EE_
x-ms-office365-filtering-correlation-id: 27d20804-b58e-4073-e234-08dd23e95219
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2J4akZqU25MQUFXb1U1dDh3enhaOTJJR3FnVE1nZWhBdSs2NGloVUVxN2V0?=
 =?utf-8?B?c1ZLUWJyL1p3alpWSUZ0d0NtK3FxeWhFcnZyeGx2dW9RenNQSXBGT0p1c0Zz?=
 =?utf-8?B?bi9yb3hLMFg1VWF1UUVLNmpQaVJybExjeXlabXdnRlI4ckRNVXpzWWlMY0tG?=
 =?utf-8?B?OXYwNTdpWm81ek5aS1piWG16a05LSUFmV0R4bndqWVdlNGxyZFhWZ2FiSFNR?=
 =?utf-8?B?YTdPaHRub0d2a0hLa2luUTc4V2VaT0FGRS8xSUVaRS9wZ04wNVl5K3BPeWor?=
 =?utf-8?B?bldtbmNrVy9iN2RRa0NBY0NYK0V2REE0SlFIdjJmY21YampqNEVRUW80NVp0?=
 =?utf-8?B?N0RSVi9xNGlsaGg1U2hEdVdQN1V3ZitQNUlYVnQ3TEFlMHBwYlhxZmZxVnJH?=
 =?utf-8?B?VjVzd3JQcW1VSFloeXJuSURIUEpuY1ZwSFp1OUFNTkNGL1I2M3ZEQVRuVHFr?=
 =?utf-8?B?U1lVdENtcTNjLzgrY2xiekllUnNvdXpONlVxS3g3aTBZTEtGWHkwQUFESGxG?=
 =?utf-8?B?VlhQRkh0bVV0Ym5WbHlFWDFhcVI5Znp2eEw3MWJzOEJZNWU1cit0TllOSzZw?=
 =?utf-8?B?MkxMNG9yalZmRXVuQ2lTQ2QwRmJGM2ZUUGZXaHFOaFUxRWFPS3VOem5NdFZr?=
 =?utf-8?B?TUt0Q09La2Z0UHVxNUFWRDR5UXBBaWczZDM4a214Z2J2QmRpcmNzbmp6SzE3?=
 =?utf-8?B?WmlFem94aXRPbFZKUHVrYUZUWkxxTmVhQ0JxSzV1Nnp5Y1FnMWl0R2lKUk5K?=
 =?utf-8?B?TW50M28ybDA5Njc4UTJCaHpQblVMREJWNkdQMFJERmp6dUo2UC9uVXlhdmhL?=
 =?utf-8?B?RFlXKzBzYUdUYjM4S2NJYlhTMGY3ZkZwS3RJNXgrSjU0ZFd2UGV4SDlzZ3Bv?=
 =?utf-8?B?WmRldGNCSDdNNlc0b3EyMXR4SlBsR1hCVlVXMWJrdDJUS1EyOHlZeHgxeDM0?=
 =?utf-8?B?ZDhFeUdkcnlGdG9rYlpRMVh0SnVaR0hRME5VUnlWdTZadWlLZ3FMa3p5c1BW?=
 =?utf-8?B?QXk2REpqYS9Ea1RJSVNJcUJpUWlTcGFtWHY0cTlWeWlIWUpqWG1RSHdkR3JM?=
 =?utf-8?B?VitYTXllQXNHZkdFNWk2UUFBb2tVZXdvQ1lBVDNpRkx3VHJlN2ZENXB4SFNC?=
 =?utf-8?B?Y1RMVW1SaUNDK1ltM3EzVEFuRTd6bXRIM2sydlZCd09rU1Vvc1orNUxsSTRi?=
 =?utf-8?B?SU9Jd2w4ZEhxVGg1S0VOY3VRcXNKUEpaRi9NU251TnZzeHdXL1l4aTdkS1ZY?=
 =?utf-8?B?M2JhbDI1S0swQ2didUMreStDWDNVZW55N2JWVzJicVRqR2hjNUN1ald0LzU5?=
 =?utf-8?B?akcxMGdlMXRXREwvZVBJSnpoejJYdmJ3Zm9Gcm0vK1hnbU9KTjE5OHVaN1A0?=
 =?utf-8?B?YWQ0dWI5SEZMM0VXdWZ2d01nUVJZVlVOb1UzS05rc2FwSml4RlZvWkYzcjdx?=
 =?utf-8?B?UXNLZmc1VHNWK0M4dFgreTJ2NWtvVUt4Y1dvM3EyZVNERFpWUGN5T0Fub3dF?=
 =?utf-8?B?UnFuM2p6dy9UampIWCs4VUJLSGUvSWFCdkhaYTIvQXlHQzEwbXVKam5sTy8y?=
 =?utf-8?B?YWFmSXlIZkdSZVFvUTJROFdvdkJZTmdvN0h1bFF2dVZpKzl6V0xVQ1dRSGEz?=
 =?utf-8?B?cms2WXlZUHR2UTRHdUljMjRsbHh6R0lvS3Z0ZGFUQkJEQ1FXK1ZJalBJSFpw?=
 =?utf-8?B?UW8wbFlVUFJKcy9qcHlaQkp4aG10WGZISktCcW9ZRDBXcStGdVN0NTNjZTBV?=
 =?utf-8?B?R1ZzbGRWeXQvNWJYQ1gvSmM0MFh3Q016cFM5YXVvTUNUd3VYNG54aW5udFdZ?=
 =?utf-8?B?V1dYNDFhblUrN0pkYWVoSTh2RnRpMTJERmkxTnVRc2ZLT25KMDltdEtpSk5C?=
 =?utf-8?B?ZlFka255T2g0QkI4dkpOLzBtL2QwV2FLamtHRHlQdHhhekVRWnZHK2dDckU4?=
 =?utf-8?B?T3AxYk5GK0UxRFBZa3lNQk0yQmpvUXJ6TkwyWmc4MGNHdFM3bzJNTitBN0xS?=
 =?utf-8?B?SUlud0tBVUZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEZ6aVFEREVzSmdNcGEzWTdqMElCNlRiZFVFZ0xTNUlRK3h6eXJvK2hxK2xX?=
 =?utf-8?B?R2FZeXI4eFdFV1JlRlVLVHNFdFNiVGlkK2cxVFNZbXVqM1QyR2FNdU9mdThQ?=
 =?utf-8?B?Y2Zod1NrV01Eem9RdFFqT240TXlIOHJVZmV6Y0tnb3BjUU81aFZ0dUh5QUR1?=
 =?utf-8?B?RHpXNElKOHp3MTIxUHJzbkRKSGRoeGxOQWFwTlRMU2JodlJma0o1RW1LbEZB?=
 =?utf-8?B?a3pwVWFmU2x3TC9wT09hV1hlL2dnZE1XK1BueXlRUTVZeFo3MGJsQjlJb25R?=
 =?utf-8?B?N29qNFV2d0JOY0tqS0l0QWNHTW5VMUZTQW1LRS81YnNJWkxrK1JCak81R2RT?=
 =?utf-8?B?SW5MUTFQWDFmQzJYNVJzZzRnLzcyeHFoMFUxMEp2SmhSS0lKMXA2TjB4YjFT?=
 =?utf-8?B?QzRETlVtL0pLSVk5cFhwOE4wTW1xUFRtR3h6dEJMSTc5dTI4bDd0VENiYW9Z?=
 =?utf-8?B?V2pEeml2K3ZxQ3U1YkRON2xFcmREUXpiZVh6aTJLaWJFdXlYdEd5STZUUzZV?=
 =?utf-8?B?TnR0QWFFMERKQXZPek0zK0RDU0lvQWdtSVE3VVplNE5OK2NKME0vTkwvZlJh?=
 =?utf-8?B?Wlc1SXVGZisvenJobnMwYk1QS2R5b01XanEvUlkra2FhdmdqeGNtK24xbTR3?=
 =?utf-8?B?ekk3L1RVSm8xakM4K0J6SEdwOWhERVNuNHFwMjRjNmNmamx0KzZKN3ZVbHdJ?=
 =?utf-8?B?L25qSVpPNDlGUTEyZ0ZjeEV2aHYyYVVpSm8yOFVaaWswcXRYRE1scWQ2WGxy?=
 =?utf-8?B?T0lnemszakFMS0RkRVJpcGo4VktTdjJDS1hFQnNZUjVCT243WXRvNEJBc1ht?=
 =?utf-8?B?bnZaNXVQMXF0cGd5eTRpQWFkVndML2JCRDRKNUl4U29rWG5xUEFKYnloS1lW?=
 =?utf-8?B?YURFUXlKNkhuMUpEMXdMVXo3VFBqR3Bud3pkUHFTdHVTeTgvS2ZBRERzY3I2?=
 =?utf-8?B?d3pzNnlpRTBEcDBTQUVCMUQyT3E5dGQ2UjZVSXpKMzRuSk9XSXlwMHlkWGNo?=
 =?utf-8?B?OFZoakdTQWpTaGZwNWdKR3FWclFMcGx3YU43dTZFaW5lWnhoRzE0Myt6QU9R?=
 =?utf-8?B?QytnMGhOU3VUQnFFNE45emxFSVBsRDcwWUlIdnpaaDJCSGZGekl0cGo0akox?=
 =?utf-8?B?Y1Q5V0czZEQrRFRMdkE4VlU2d3UwSFpJdS9zKzV5cEQwT1hCREh3OFNMYStv?=
 =?utf-8?B?NG41cE40b3JaaW1mZFp3Nk11V2ZCTXpkWGZzVU15WWc4MmNpSi9VSTNQSEto?=
 =?utf-8?B?eTJ5cTZWME5pc1lYQ0Y5SFZuOGNwa1BCYkNZWEJLT2tQTHBsZnU2bjd1cncx?=
 =?utf-8?B?M2NzVEJENC9HNnNuRWFTNitndGZ5QUpCT3hwSnRjY3hGQ1ozVEdLOTJuc0c2?=
 =?utf-8?B?L0lmVVQ4RkdUb2JlcDhpY3RRSlpHUFY1UGpxcmJlYTVldnoyVmtpbVZuQ2xU?=
 =?utf-8?B?SkhiOFU2ckhTeGN6TDU1WlVJL05CajRQMU84ZHdqUndYQTdmMkRhbmtiOEFB?=
 =?utf-8?B?QXdxdWxCR1IxRWdpSFBUOUc0djg5aVBmRUg2aGZ2ZENvckJnWDFqeEFwajln?=
 =?utf-8?B?N2lwMEM1MlF5dmY0a2JnYUQvSDRLRWt4dS9uTFNIM216aHBJWlozdi9TMFl1?=
 =?utf-8?B?b0Rud002MjZuWmlQVmJLQzZJY25Yc2p6NFgxZnFCaGM3VHVSZWdlS3IvQUNo?=
 =?utf-8?B?RTFkcnZkeVpBN0lySGs0Zk1JenRtSU5rV3RXUnk1RnBUWVN3OElNRnZZQUgv?=
 =?utf-8?B?eHFRbjM0YnhrUm1xa1RYakxaMXZYYW5iMGxuZEFWMy9OQmJjR0lsbEM5M0Nt?=
 =?utf-8?B?Q2FaSG0zSTYyT2FxZFZhUjBxM1p4NUtRNmh3bGp4OVJXTUdqQlNIRHg2YVd0?=
 =?utf-8?B?UDFDV05zcG94SHNQRUtjdy9IcjdBUmtZd3FqeW5FZ2NvWlRPUWU3cUhDakY0?=
 =?utf-8?B?MjFSZFNRNkR0a3d3RjdWWld6MVRHK0VQV3drdThsblpQL25xNTVUUkduQ1c2?=
 =?utf-8?B?WW56MlpwWmZveXhsU1dtb0U5TXlzS3YzK3k3b3dyc2MxM0diczN0d3c1TmRK?=
 =?utf-8?B?dEIrUjc3NGFHZklzald2QTd3cXFhRnZtekxlM2diZVZiQmhkb2ppQ2grdUxa?=
 =?utf-8?B?VGVKUjBCdkJjOE5seVdFNm9sbU9ya0VBbElkMDJCRVd1UnZYcTdVeDhjakR4?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD776428A7E3EA47991A847858282DB5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kI0w5WLnKBLKyZurEKYFMHCRYD7NeX4HWuSIzjNspuCYi3ls2sqtU8qrCjzkI0jUka53R3HGkoIAzd8yP0fmkhSBCm0uB3LhnGrSVPfMTxppWSwJ4hgpP3KoyevVUWGeRCYk4u17diZMgnKKN6TFjs6ib7VH+6npvRRjxUv2lhsc5kwbUweneV7rqQZyq1vVlrkeVLuyNnq3KZ0hQ4wVXSEied8r+ZaWC22a4Nf8mSRzd0YfZqgs5A49RGLJcJfRh6dQO/jfcyrio+AzBVLdv0skrP1StSuJr4u4UndZ6cFw6lRU+HUZAxVk3IgxyCodxMDUxI3NuMv4cgoyc0PDGr4fG113VnSC6opv7V+rTkysLtWKpPqyPDyuM/xbh13xTCr3IbU+RXeu8JJ2WVq3V5OQmj1qwcq8s/MEurCqCJKlh0laK/5fjRXeUqTKlrtYVBHqEaPzx+fVUroevN4c/J6n0EzbArOzbe/ZxZganYgTbxP98q+GaTCrpThWy8mynykzNLe103oS1s9BpMMNNe39WMxCtUycNLa/tRWIrEqWgXB8hYq8PmbA+xJg5V4uELD8oNSBx0oN0xr80hJFk3UZLeEEqurWbXXsJc/65mrD92iuDW9nFeDTeicL06Ki
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d20804-b58e-4073-e234-08dd23e95219
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 07:05:16.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO+BjdmIrAPgPA7N7TPf0718nm4fDUyOaF9LLiuf4x9S1aPAja9zFeiOImq8UKC2Nj5ckIqV6/0D/NzZL7O9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5406

VGhlIHN1YmplY3Qgc2hvdWxkIGJlOg0KDQpSRE1BL3VscCAtPiBSRE1BL3J0cnMNCg0KQWRkaXRp
b25hbGx5LCB0aGUgcmVsYXRlZCByZXByb2R1Y2VyIGlzIGF2YWlsYWJsZSBhdCB0aGUgZm9sbG93
aW5nIGxpbmsNCiAgDQpUaGFua3MNCg0KT24gMjMvMTIvMjAyNCAxMDo1NywgTGkgWmhpamlhbiB3
cm90ZToNCj4gQSB3YXJuaW5nIGlzIHRyaWdnZXJlZCB3aGVuIHJlcGVhdGVkbHkgY29ubmVjdGlu
ZyBhbmQgZGlzY29ubmVjdGluZyB0aGUNCj4gcm5iZDoNCj4gICBsaXN0X2FkZCBjb3JydXB0aW9u
LiBwcmV2LT5uZXh0IHNob3VsZCBiZSBuZXh0IChmZmZmODg4MDBiMTNlNDgwKSwgYnV0IHdhcyBm
ZmZmODg4MDFlY2QxMzM4LiAocHJldj1mZmZmODg4MDFlY2QxMzQwKS4NCj4gICBXQVJOSU5HOiBD
UFU6IDEgUElEOiAzNjU2MiBhdCBsaWIvbGlzdF9kZWJ1Zy5jOjMyIF9fbGlzdF9hZGRfdmFsaWRf
b3JfcmVwb3J0KzB4N2YvMHhhMA0KPiAgIFdvcmtxdWV1ZTogaWJfY20gY21fd29ya19oYW5kbGVy
IFtpYl9jbV0NCj4gICBSSVA6IDAwMTA6X19saXN0X2FkZF92YWxpZF9vcl9yZXBvcnQrMHg3Zi8w
eGEwDQo+ICAgID8gX19saXN0X2FkZF92YWxpZF9vcl9yZXBvcnQrMHg3Zi8weGEwDQo+ICAgIGli
X3JlZ2lzdGVyX2V2ZW50X2hhbmRsZXIrMHg2NS8weDkzIFtpYl9jb3JlXQ0KPiAgICBydHJzX3Ny
dl9pYl9kZXZfaW5pdCsweDI5LzB4MzAgW3J0cnNfc2VydmVyXQ0KPiAgICBydHJzX2liX2Rldl9m
aW5kX29yX2FkZCsweDEyNC8weDFkMCBbcnRyc19jb3JlXQ0KPiAgICBfX2FsbG9jX3BhdGgrMHg0
NmMvMHg2ODAgW3J0cnNfc2VydmVyXQ0KPiAgICA/IHJ0cnNfcmRtYV9jb25uZWN0KzB4YTYvMHgy
ZDAgW3J0cnNfc2VydmVyXQ0KPiAgICA/IHJjdV9pc193YXRjaGluZysweGQvMHg0MA0KPiAgICA/
IF9fbXV0ZXhfbG9jaysweDMxMi8weGNmMA0KPiAgICA/IGdldF9vcl9jcmVhdGVfc3J2KzB4YWQv
MHgzMTAgW3J0cnNfc2VydmVyXQ0KPiAgICA/IHJ0cnNfcmRtYV9jb25uZWN0KzB4YTYvMHgyZDAg
W3J0cnNfc2VydmVyXQ0KPiAgICBydHJzX3JkbWFfY29ubmVjdCsweDIzYy8weDJkMCBbcnRyc19z
ZXJ2ZXJdDQo+ICAgID8gX19sb2NrX3JlbGVhc2UrMHgxYjEvMHgyZDANCj4gICAgY21hX2NtX2V2
ZW50X2hhbmRsZXIrMHg0YS8weDFhMCBbcmRtYV9jbV0NCj4gICAgY21hX2liX3JlcV9oYW5kbGVy
KzB4M2EwLzB4N2UwIFtyZG1hX2NtXQ0KPiAgICBjbV9wcm9jZXNzX3dvcmsrMHgyOC8weDFhMCBb
aWJfY21dDQo+ICAgID8gX3Jhd19zcGluX3VubG9ja19pcnErMHgyZi8weDUwDQo+ICAgIGNtX3Jl
cV9oYW5kbGVyKzB4NjE4LzB4YTYwIFtpYl9jbV0NCj4gICAgY21fd29ya19oYW5kbGVyKzB4NzEv
MHg1MjAgW2liX2NtXQ0KPiANCj4gRml4IGl0IGJ5IGludm9raW5nIHRoZSBgZGVpbml0KClgIHRv
IGFwcHJvcHJpYXRlbHkgdW5yZWdpc3RlciB0aGUgSUIgZXZlbnQNCj4gaGFuZGxlci4NCj4gDQo+
IEZpeGVzOiA2NjdkYjg2YmNiZTggKCJSRE1BL3J0cnM6IFJlZ2lzdGVyIGliIGV2ZW50IGhhbmRs
ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLmMgfCAzICsrKw0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3Vs
cC9ydHJzL3J0cnMuYw0KPiBpbmRleCA0ZTE3ZDU0NmQ0Y2MuLjNiM2VmZWNkMDgxNyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMuYw0KPiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy5jDQo+IEBAIC01ODAsNiArNTgwLDkgQEAgc3Rh
dGljIHZvaWQgZGV2X2ZyZWUoc3RydWN0IGtyZWYgKnJlZikNCj4gICAJZGV2ID0gY29udGFpbmVy
X29mKHJlZiwgdHlwZW9mKCpkZXYpLCByZWYpOw0KPiAgIAlwb29sID0gZGV2LT5wb29sOw0KPiAg
IA0KPiArCWlmIChwb29sLT5vcHMgJiYgcG9vbC0+b3BzLT5kZWluaXQpDQo+ICsJCXBvb2wtPm9w
cy0+ZGVpbml0KGRldik7DQo+ICsNCj4gICAJbXV0ZXhfbG9jaygmcG9vbC0+bXV0ZXgpOw0KPiAg
IAlsaXN0X2RlbCgmZGV2LT5lbnRyeSk7DQo+ICAgCW11dGV4X3VubG9jaygmcG9vbC0+bXV0ZXgp
Ow==

