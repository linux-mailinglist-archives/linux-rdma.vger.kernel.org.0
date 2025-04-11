Return-Path: <linux-rdma+bounces-9367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0626A85584
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 09:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DAD18986D1
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3527CB01;
	Fri, 11 Apr 2025 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fusEAfX4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61A1DED56;
	Fri, 11 Apr 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356735; cv=fail; b=MymO83NQcG8ISMu6bncV+n2YVLbknRifX5VY+2NGS6YGwRdkxPww/DOGPchNwSlJGZNW/eZmQpg8IN2Tfc9GTB1aPQEdraKW8jx4dgKHR3htAPmjAFdsFpLvUaErRBeIfr/XDRssOrS5EtawplC7N9q+vI+hQzOw3Qyh3AmH3w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356735; c=relaxed/simple;
	bh=2pekFDjpCFglAMbitSJSbArwnA7eyihAGV1DGXwXoZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mtYAC8qB0YdRhHLkR20xKeMtSjc1C0NBvbC35aKmzFPGYzqOfeyhTP+VEBJAgVBV2b2pkWnIgi37W7FA5b9dgHLkmn+mv+fMsn3wUYo+GW806euRJxJanBOWOE1gy5sj/Unov3SV/JpPgMsE3JBj16tTmSYQKyzD4xcbR9bfi08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fusEAfX4; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744356733; x=1775892733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2pekFDjpCFglAMbitSJSbArwnA7eyihAGV1DGXwXoZ4=;
  b=fusEAfX4MUkRgO188wCo36NaZIGypyHVWrfGTbE+Zn4Z3hxd+93cxd7x
   kswf9+W+6FSSLUMXLBiGDkv6+ZeCn8PEFHumpeoQs5x5DHHNt3qq07v9s
   1QhoPYyHr1uGKjHmhGEtnzCcjmrfyA5cQ2/boFOcsYEshMXAgLGxnLuUi
   qdhbdEjSIT44KBbBd72E4N3rNEqLQGMGZtI/kLGbOp1cfVh5j9kTSpy76
   NWWKQLVl/9CBT1lU1SLujzox6QwEAfigYmc2c/8kMpVnGNegEaHA3qk3i
   rxXyvxhJU9DMdigUBYO7wAZjXd4H80TNpm+yq1Mf1XD5DwhkoZFD0xKdh
   g==;
X-CSE-ConnectionGUID: azLng6bQS7yrEywEnvStTQ==
X-CSE-MsgGUID: TIzQddR5THOt0gG3CH9Xaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63476590"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; 
   d="scan'208";a="63476590"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:32:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXcDcGA/yzM9SKXIRB0FzOvtC4SbkRZ4/6q2zxr7HhyPNT1Dj5Q3Mz7xJhvbYy2IIPnS9/ZjPq/ThI40vymUHEtFHXTpY2rAaReMJQ9GeSCLdWmBDigTsO2oLmbpmP6bcV/xuAAcvdPhZmFOEnD4IppPD+Z4cgDZWCg5g0ZencRAOJ5EcThCoj41c6OEaDmXa9St2MgrKzksqNmj6RXiqXclY0pLZmopX2nBShF1IPx9Qo5xULFvfU9/vpYeutmLzC4SaU3H6i8Zq0qqznA6dAOKghAntieLk1+UUDe6BF1ZA5wSAfS3OFCAcsvJoxA5UURtJL7xKK9mKTYfjoHlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trpYK7xpO3tOSf9Ujob/tT06V5Qk1NSYQHpSLw3TFg0=;
 b=hVbSqUAeRRm1T50PraKzNWWfnuJ1hhnPwsBo2gcThA2X1LoY6i6NtJYgPA9KmzWTSD6UHOBsDZWBV5/UnSoYHCPPn2GHR9ufjl49LZPqNLu5ORDpTxyEL1aMYFUpcgcYN0zaSDH4sMbxMuP8Dkj+wlQ66ZiYWI7r8NpaIbIwJRq0CKnBsg/gMuZGhSIWTQaH71M9hM3xsEB9uZNIuBHbzD+l6SyYlWq/9pQuDaqKMBTYpdb+m8sEThf+kIzgNtu0TP32129BjVSh6m9T9KN/eeA/YBec5ICdhFgppRCgy1hNSXa+zFgzBDMnW4AbHH02ndbbgrP2feIgFYizYVB1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYCPR01MB9878.jpnprd01.prod.outlook.com (2603:1096:400:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 07:31:51 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%6]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 07:31:51 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Honggang LI' <honggangli@163.com>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/rxe: Fix kernel panic for fast registered MR
Thread-Topic: [PATCH] RDMA/rxe: Fix kernel panic for fast registered MR
Thread-Index: AQHbqrEZR95oyvHma0m1mFljSkDxubOeELcA
Date: Fri, 11 Apr 2025 07:31:51 +0000
Message-ID:
 <OS3PR01MB98657E6B788DBC4B11115102E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250411071141.82619-1-honggangli@163.com>
In-Reply-To: <20250411071141.82619-1-honggangli@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a97d69e7-3ef8-4cb7-9aad-c40eeee25347;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-04-11T07:26:32Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYCPR01MB9878:EE_
x-ms-office365-filtering-correlation-id: 0931e71e-a96f-476f-8397-08dd78caed0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZkZmc3dLdHhCSjl1RzNHdHpDTXZyUjh2MU9NbElKeE9xSGY4RzdMSExx?=
 =?iso-2022-jp?B?TXpIY1poeTNRUnRld3F6TlBEaHI4UityQ2ZNNjhnRkVublhLblFkR0lv?=
 =?iso-2022-jp?B?ZlM0Q3hZU01LaGptTEZ5RlpRcE9QRHBZVUdmcWZnZk9BYlFMOVRmYU1q?=
 =?iso-2022-jp?B?TTFYUGMxV2RRWXVIZ28rbjd6T01kUitCUkhtTzJKNzY5L2U0K3dkRkdm?=
 =?iso-2022-jp?B?SEJ0WUJrU1N2K3grSUs4d01CdC9CNE1xYkRtSUZXQVloa3cvdFVIV1Ni?=
 =?iso-2022-jp?B?YThrWVJaU0RuL3k3ckEwQnREdm1oOUVaSWxnUkZQQ29xcXEwbTJ4d0tP?=
 =?iso-2022-jp?B?K21oNVJ4ZzFSNGgzaEdUZEltY3pDWDV0RE82VXRqK0xmT3hmeTA0eUZl?=
 =?iso-2022-jp?B?dnVTRXBHUWt4UEJkM0dGbHdSU3pBZkJsa29QY29iL01mdDMrRzJubUVo?=
 =?iso-2022-jp?B?cHBvRDNRMzIwaWhXZGxzRVljTkxjeWR6dWdhMXpQbTBKWm95S1NpNGhI?=
 =?iso-2022-jp?B?Mk9oOUZ0blJoaWlMY0dhTG00dk5jdFE5TDJ5K1k3dDY4Wm8yWnUxYm5q?=
 =?iso-2022-jp?B?UWY0bFhYM1VtU015eVJIamthaWxMM1VNYWtsK0xlR0dWdGxRbDdKK0k5?=
 =?iso-2022-jp?B?eEFCYlBlSmRUdVFEMWIzSFpBVk1Nci9xRkJ4TGE3ZVdBSm5VUEdRRWxF?=
 =?iso-2022-jp?B?WVZqK2dtSkhwN1phNkd4MmlMT2NXL1ZESVpXc3dPNExNNWYzSzE0azZ5?=
 =?iso-2022-jp?B?S1IzV016MUQxbnlZZ1ZtQ3pqWmRCYm4zZ0tSdXRQUk1KSjBnaktSUWtK?=
 =?iso-2022-jp?B?ZExlRHNhSkZlQ2lkMUlWYm1HcFVxTzJ2b0xkTkFGNGhnMFJZcVljd3lH?=
 =?iso-2022-jp?B?aXo5Y1ZPTC8waGF1TFBmbTVDTGQ3Zmw3cXorZmpJWmh1MWl3b3RXYkgw?=
 =?iso-2022-jp?B?WHhkUjFDc1d1cHE2cWxIdlZibHcrQngzWlVwSjJYeEpjMmdnMEFLQWJj?=
 =?iso-2022-jp?B?VU1rdFgrSFVPcFVNdmRqQjhXRVpqUEdiMlZCckh1Y2h4Z3g3MUtFS1JH?=
 =?iso-2022-jp?B?M2YvZXRIZlZqOCtDMlIrLzhzWGdZc203OHRnNmw0VTF6UlUvcmtud2Rm?=
 =?iso-2022-jp?B?Y3psU1BrMTlIVExPTVV1R2J4UERtanhBWTRHbCtVL0lLaHVGZ3JVUGs3?=
 =?iso-2022-jp?B?bldmMllrL1dmallnb1lGYlpOOXFNcWxYL0puY2N3KzBHUDE0WS9KSnFJ?=
 =?iso-2022-jp?B?NlptK1dyajdqSVJWUVdxQnEwOUpnWHg4VEZmL1lHOXNFVktXRXZzK1M2?=
 =?iso-2022-jp?B?OGJZaHJWWk1pTnU4OXlsVGMrRWFCMlBHT0dVYVRxNG1Fb2p5c2ZZMlRD?=
 =?iso-2022-jp?B?NWVtNUQrMjNzSkp2cGZxTVpNbUEvdEdPM29tSllrRi9GcitVa1R4QzlE?=
 =?iso-2022-jp?B?bE1aUFIzY29TOGY1SUJMY0IwRFJ1c0tTQVZoQk1ydlZIQ1ZtUUhjZ0tq?=
 =?iso-2022-jp?B?akJscWdTdGVwYUZtSExSNzJNTExnUjQ1ZXVGRmxuMGJCWHFIcjcrNkw2?=
 =?iso-2022-jp?B?TlRMSXViWUtONjJMQnJmN3o4bzNZNWlEamFUdHBXUEVLNXR6NG1kYTcv?=
 =?iso-2022-jp?B?SEFKVFZaeWhMRkRVNnlHYWFCTDNYSjh3LzlDaHdNSFJSdyt6YVRzZlBi?=
 =?iso-2022-jp?B?NkFVbkN1bEJBRytkN0tEejk0aEZZTVB4QkUyZm1Mazl2Wm00bUFnU2VP?=
 =?iso-2022-jp?B?TFo4VnRvZWdUYlBlaVNJVEwrM0g1MFFsdldSUis0RW9RSEY5OHRsRmVa?=
 =?iso-2022-jp?B?WVlxNGowTEpwTjAwY1dEclZ2emFha1BOM0dHTEhlVWIzQlRtZTVoT3hp?=
 =?iso-2022-jp?B?OWNVMXY3bDJKbE1idFdRdVhRb2FadEw2ZDZLZjdIaXduYUdEQmVIZFVE?=
 =?iso-2022-jp?B?NG9JSVZXQzBhUjFaYS92SUo4NHBRMERCR0FjNGZNNEt1Mkt2OUxMY3dI?=
 =?iso-2022-jp?B?c2g1RlBjYUhDclFRdW82eW1sRzNjbkNLNitIbG5PWXdybWVuWWRkMVRM?=
 =?iso-2022-jp?B?UG5oYzFLcEtVSVY2eThwOFNiWnc5WGJ2VlVrOFp1eXU0Z095SFF0Zjlw?=
 =?iso-2022-jp?B?R1Y=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NGRTRm5hV0FFcGtJZ1NxOFQ3dDBaaDZLalZiUlVsTDUxZktuSm5vWjRG?=
 =?iso-2022-jp?B?RUIwZmdaWll4d0hCREZlNVhxYWxETk96TThpbE1ERXoyckIvOStKaHlm?=
 =?iso-2022-jp?B?NlM5bDFDeHhMTkVZV3g3VG5LQ3FSMWdJMkZ3NWlxa3ljMzRuUDNTVGEy?=
 =?iso-2022-jp?B?Q2ZpN1Rtdmc5TUZSTjdTZDU4L0dqYkkwdHhNSWlhSjBIQUJCUi9pV1Yv?=
 =?iso-2022-jp?B?ekdUV1BLUkp5b2VDeUdLQXdPRlAyVlEzWnB3MVZMcUJzK1d4ellRZFVm?=
 =?iso-2022-jp?B?bTFlNHI1Tm5na2dCWURCQ3pxS1pqUnB5bCtMdXdFc1hjTFhCaU9tcEZU?=
 =?iso-2022-jp?B?TEk0WEY2cXRzVDZxc1o5VUg3UUR5a0V2NWZVTUkyR21QMzR0RUlNZm5y?=
 =?iso-2022-jp?B?Nml6d0pCUktFOHd4SFFzUTBPSnYyOHRZR3FYR1BJRGpsazM1YUdMMmJh?=
 =?iso-2022-jp?B?MVFPVzhiYTk1dnRwTXExVThibUNIa2dtSDFyMU0xSTkxWXdlczNsRWlI?=
 =?iso-2022-jp?B?cXc5VkpIRUJjNHpUQU5ZeHFpcGFGc2FVbXcxanBpOFNEaVlLS0ZoRS9Q?=
 =?iso-2022-jp?B?Uks5VENubXZiNmtLM1d1RWVzZ2x0UW5UK09lbVR1b29LRlBQcnNab29o?=
 =?iso-2022-jp?B?bUUwNU1qdU9uNzNYQUJDUmdMSUxjR2lXY2FRUUNLcTNkVmdENEN5bnBm?=
 =?iso-2022-jp?B?WXEwdWNJRTZRWkk5bnRrLzRrbzN0cW9GSDgyQmRLa3h6bWZNbk51Y0JP?=
 =?iso-2022-jp?B?VFBJejZUdEFEUnN0NmorcTlSMXRHWjB6QXF0eUZOMFZ6dFBnaHBqYmFj?=
 =?iso-2022-jp?B?ZDY1WTQ4L3RZUzBEYUgzTWFMOUNBOWZTV1ZNODl6Ymd2TzNSRG5LWTVr?=
 =?iso-2022-jp?B?Y09aeVZtTGhDUjVhbVlyZFdkVEQzamd6ODVRT3pxZCtzWnlCKzNkSFU3?=
 =?iso-2022-jp?B?d09UUXV2ODVZaWhEM1JmamNVeWJCRkN4bkhTL2liS1ZrN0RxUW53aTFJ?=
 =?iso-2022-jp?B?RzFiaWdkaXpPd2VuL2tLazhkOE5pNFVwQ21zQlUyUkcybytNWXZPUGhr?=
 =?iso-2022-jp?B?YXVaZ1A2L0kwbFJpaVBnS2J5ZDVmY2djV2JXR3E1L3Z1Skx0a291SVNl?=
 =?iso-2022-jp?B?bXRScy9JMzgxNS94MGNKbWcxWHZVOVRpRXVnL05TL1hGbUhocHpOMkIx?=
 =?iso-2022-jp?B?Ly9wNEJpY1l3ZTNyRHVqSVhOTWo3MWtvaE95dkVWSlpYRXB4b1g4d0U2?=
 =?iso-2022-jp?B?emgwbjhXL0pTYWlXS2pkaXduMXBjZkpvS0NhdGpuakxPbDJEa3R1dS9P?=
 =?iso-2022-jp?B?YzB2OEMyN3RnLy90MHNVdDc4WHI4WGJ3bUs4VnAxZDUzTGYvV2FpQVA2?=
 =?iso-2022-jp?B?VklDWXBFalZEL1hQUGV4NjlIancxaVR6YWRKc3ovTXlVdVJUUktEcTF6?=
 =?iso-2022-jp?B?ZkN4RVBXUE81b3k4Wlo5d3U3Wk5oVGpQdFhDS3hRRk9rVFhZTy82azNk?=
 =?iso-2022-jp?B?c0RNN1AyRkRLVlVDN21GN2VqbEhNV1Z4N0l0a3IrOWFWT3A1QkVUMEta?=
 =?iso-2022-jp?B?U1poY1NRSDFKalduTWc0dVo3enYzRmZsT1RVejFaZkFyK1RtZWc5WjR2?=
 =?iso-2022-jp?B?SkdxK2RmdEUwZW41cGQxMkVMZ3RYSWx6bXFtKzRPREhvQ2xFOGNwN04v?=
 =?iso-2022-jp?B?Z1ZBY2RyRUpZQnRYRnBSbDJqOXhMUTZDcSt4eU5XcndOV24xZW5xWlZi?=
 =?iso-2022-jp?B?ZHpuV0QwQUlzaWhQYVB0MGlzLzF5b1N1L0ErWU5FbERJVnhsaTE3OGp3?=
 =?iso-2022-jp?B?QXJKbmYyZ3hHSHNzKy9FR0dCa0dEQmwzKzMzdytLVDFLeTVYdE5DQldF?=
 =?iso-2022-jp?B?QU83RGFUMEVKdHJTaGs4N1dhWWtSQ0hoN0xlQU81bm9hUUdRS1hpM2o0?=
 =?iso-2022-jp?B?eXVUWDdKL0YrRnVkSFNOWTNRQjlWelpSUCtOUHN0UUVwUnZKQlMyWFBO?=
 =?iso-2022-jp?B?UXZ4VFhVby9xV3hqMnR5V3g1cFcyM2wwR1ZnTW1yUlYvcVNBOElnallr?=
 =?iso-2022-jp?B?TXIzeFlkb1NaMTVpTkpoWTYzOHJ2a1dXVENhUld2SG1kY0xBT2FvcEly?=
 =?iso-2022-jp?B?OC9SQ28vak9RS3lrcDI0V2hYbjF6VCtYV2FkTkJBdjJxRXVGL0F2T0tw?=
 =?iso-2022-jp?B?SWdxRUdhR002ZC9kNFhibUQwY2xxbVR3WlNLZHRsZDZpVnZqbVlCY3hO?=
 =?iso-2022-jp?B?YXJLU2tPbDE2eDREVGFseWx6T1o2bTRUTW5jZUE4MW1pdXp5Q1daMW9G?=
 =?iso-2022-jp?B?NnBORllHaCtZYWI5enFPZ1huYkxIbnp2WEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YFqjcvBlncE7Ibn++dIMLfJnOi0vx2Yc0bgvxCsD6+lh5lA/RMyNssjVYVQ+ymFMBfSCbzhc5DDTMBPLIGtVkh2omFgN9bG2XN+54FQ1hR7ziHvDHJwD2VYZbakcMuiRO34DqYym7o69U4LR2oqZu86+N2y8UqqKKKUdGa9CxyJpXo6t1dd1+opFxENqrsRDAytHsH/739dhMqW27RqwoafdVGSqNd14HPxdPT6SlqdBluy3S4jU44nARM1s0qinsHV77wuUF7wq9nNYQ5lOcIR+GnfxkczXffratz43/c6OjvK0FykxVgoxKYjb4AwvEi7wFE78rsMa+74aauzGeFiifIcEq1+wAHpC6tsytNCbD4dAxg5Q+1Vsi4MgEZWr6i3FU7Iahmfrx3rnZEjBKB8GnBE8Bia6+j8my5ULzF8Jz4N7Tr8PD84g9hUClx758P40TtH3ljBHSdYQctlLBxCu2VJs6vzj0NeoFvMYd/t+PBFSGckoHRrIdk7cHl/K4vrTk/OIAqRqyPtL6kTUum1TXkjteMnXoitjhaombFDY092ukLkpVYIEfOKF+OZi1WjqLn2sWGhClSiMcNzs14hQw5oTcFjOliY5AiTJ162NIxrxw6TjwL2u/A85FHH/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0931e71e-a96f-476f-8397-08dd78caed0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:31:51.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8r3bHhqedOe/SJREdKv/Lm3WNaB0ENgylskf2YDRHosyzqqdprJ6cJs1oX6dASjt9uZzrlQ6ekoaZwVlN/slI6Vyavt3uuGlLBOgXOMB5Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9878

Honggang

Thank you for the fix.
However, this issue is already addressed in the for-rc tree.
Cf. https://lore.kernel.org/linux-rdma/f845e90c-50ff-4e0f-9b73-55a704ba934f=
@linux.dev/T/#t

Thanks,
Daisuke

On Fri, April 11, 2025 4:12 PM Honggang LI wrote:
> `rxe_reg_fast_mr` does not set the `umem` for fast registered MRs.
> Check the `umem` pointer before check `umem->is_odp` flag, otherwise
> we will have kernel panic issue.
>=20
> [ 1475.416503] BUG: kernel NULL pointer dereference, address: 00000000000=
00028
> [ 1475.416560] #PF: supervisor read access in kernel mode
> [ 1475.416583] #PF: error_code(0x0000) - not-present page
> [ 1475.416607] PGD 0 P4D 0
> [ 1475.416625] Oops: Oops: 0000 [#1] SMP PTI
> [ 1475.416649] CPU: 2 UID: 0 PID: 6106 Comm: kworker/u33:0 Kdump: loaded =
Not tainted
> 6.15.0-0.rc0.20250401git08733088b566.8.fc43.x86_64 #1 PREEMPT(lazy)
> [ 1475.416694] Hardware name: Powerleader PR1715R/X9DRD-iF, BIOS 3.3 09/1=
0/2018
> [ 1475.416721] Workqueue: rxe_wq do_work [rdma_rxe]
> [ 1475.416774] RIP: 0010:rxe_mr_copy+0x71/0xf0 [rdma_rxe]
> [ 1475.416819] Code: 3c 24 4c 8b 4c 24 08 85 c0 44 8b 5c 24 18 4c 8b 54 2=
4 10 44 8b 44 24 1c 75 4f 48 8b 87 f0 00 00 00 44
> 89 d9 4c 89 d2 4c 89 ce <f6> 40 28 02 74 09 48 83 c4 20 e9 20 47 00 00 48=
 83 c4 20 e9 57 f7
> [ 1475.416874] RSP: 0018:ffffcbcfc936fd70 EFLAGS: 00010246
> [ 1475.416897] RAX: 0000000000000000 RBX: ffff8a9c48314328 RCX: 000000000=
000003c
> [ 1475.416924] RDX: ffff8a9dc5f7110a RSI: ffff8a9c4ce40024 RDI: ffff8a9c4=
4ae9200
> [ 1475.416949] RBP: ffff8a9c4007f800 R08: 0000000000000000 R09: ffff8a9c4=
ce40024
> [ 1475.416974] R10: ffff8a9dc5f7110a R11: 000000000000003c R12: ffff8a9c4=
5112000
> [ 1475.416999] R13: ffff8a9c4007f800 R14: 0000000000000000 R15: ffff8a9c4=
007fc28
> [ 1475.417024] FS:  0000000000000000(0000) GS:ffff8a9dfb58e000(0000) knlG=
S:0000000000000000
> [ 1475.417052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1475.417075] CR2: 0000000000000028 CR3: 000000040282e006 CR4: 000000000=
01726f0
> [ 1475.417103] Call Trace:
> [ 1475.417119]  <TASK>
> [ 1475.417135]  execute+0x281/0x310 [rdma_rxe]
> [ 1475.417179]  rxe_receiver+0x41f/0xda0 [rdma_rxe]
> [ 1475.417219]  do_task+0x61/0x1d0 [rdma_rxe]
> [ 1475.417256]  process_one_work+0x18e/0x350
> [ 1475.417286]  worker_thread+0x25a/0x3a0
> [ 1475.417309]  ? __pfx_worker_thread+0x10/0x10
> [ 1475.417334]  kthread+0xfc/0x240
> [ 1475.417354]  ? __pfx_kthread+0x10/0x10
> [ 1475.417374]  ret_from_fork+0x34/0x50
> [ 1475.417396]  ? __pfx_kthread+0x10/0x10
> [ 1475.417416]  ret_from_fork_asm+0x1a/0x30
> [ 1475.418046]  </TASK>
> [ 1475.418615] Modules linked in: rnbd_server rtrs_server rtrs_core rdma_=
cm iw_cm ib_cm brd rdma_rxe ib_uverbs
> ip6_udp_tunnel udp_tunnel ib_core rfkill intel_rapl_msr intel_rapl_common=
 sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel sunrpc kvm binfmt_misc rapl intel_cst=
ate iTCO_wdt intel_pmc_bxt
> iTCO_vendor_support ipmi_ssif intel_uncore pcspkr isci acpi_ipmi i2c_i801=
 i2c_smbus mgag200 ipmi_si mei_me lpc_ich
> libsas mei scsi_transport_sas ipmi_devintf ioatdma joydev ipmi_msghandler=
 acpi_pad ip6_tables ip_tables fuse loop
> nfnetlink zram lz4hc_compress lz4_compress igb polyval_clmulni polyval_ge=
neric ghash_clmulni_intel sha512_ssse3
> sha256_ssse3 dca sha1_ssse3 i2c_algo_bit wmi
> [ 1475.422332] CR2: 0000000000000028
>=20
> Fixes: 2fae67ab63db ("RDMA/rxe: Add support for Send/Recv/Write/Read with=
 ODP")
> Fixes: d03fb5c6599e ("RDMA/rxe: Allow registering MRs for On-Demand Pagin=
g")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
>  drivers/infiniband/sw/rxe/rxe_odp.c  | 2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/r=
xe/rxe_mr.c
> index 868d2f0b74e9..7aebb359f69d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -323,7 +323,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *ad=
dr,
>  		return err;
>  	}
>=20
> -	if (mr->umem->is_odp)
> +	if (mr->umem && mr->umem->is_odp)
>  		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
>  	else
>  		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
> @@ -536,7 +536,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iov=
a, u64 value)
>  	u64 *va;
>=20
>  	/* ODP is not supported right now. WIP. */
> -	if (mr->umem->is_odp)
> +	if (mr->umem && mr->umem->is_odp)
>  		return RESPST_ERR_UNSUPPORTED_OPCODE;
>=20
>  	/* See IBA oA19-28 */
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/=
rxe/rxe_odp.c
> index 9f6e2bb2a269..066a50da06f4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -229,7 +229,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void=
 *addr, int length,
>  	if (length =3D=3D 0)
>  		return 0;
>=20
> -	if (unlikely(!mr->umem->is_odp))
> +	if (unlikely(!(mr->umem && mr->umem->is_odp)))
>  		return -EOPNOTSUPP;
>=20
>  	switch (dir) {
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw=
/rxe/rxe_resp.c
> index 54ba9ee1acc5..e27efc93a138 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -650,7 +650,7 @@ static enum resp_states process_flush(struct rxe_qp *=
qp,
>  	struct resp_res *res =3D qp->resp.res;
>=20
>  	/* ODP is not supported right now. WIP. */
> -	if (mr->umem->is_odp)
> +	if (mr->umem && mr->umem->is_odp)
>  		return RESPST_ERR_UNSUPPORTED_OPCODE;
>=20
>  	/* oA19-14, oA19-15 */
> @@ -706,7 +706,7 @@ static enum resp_states atomic_reply(struct rxe_qp *q=
p,
>  	if (!res->replay) {
>  		u64 iova =3D qp->resp.va + qp->resp.offset;
>=20
> -		if (mr->umem->is_odp)
> +		if (mr->umem && mr->umem->is_odp)
>  			err =3D rxe_odp_atomic_op(mr, iova, pkt->opcode,
>  						atmeth_comp(pkt),
>  						atmeth_swap_add(pkt),
> --
> 2.49.0


