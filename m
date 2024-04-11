Return-Path: <linux-rdma+bounces-1900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EA8A0BFC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD2868AD
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F213FD92;
	Thu, 11 Apr 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xrum7xMK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFA6FB5
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826692; cv=fail; b=ryz/9Cub9CDsQaXnXwSs6nVa7C54WEUlbC6dKSIEgrWvJBhjos11fXC7tG7ZFZpyW600YNiaRyQa6r3JGGXatbpT49opmMQ0vlpBHCCi5/9FFu271IpmX0fdxQnW4h+xjTRn+rX1LNzAQwVEQo21rJL3/opXa9aRQzLTnM7iX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826692; c=relaxed/simple;
	bh=24kkANAuKMfEK7jrYohH0tLZgqx3vf5epfePFY1E5RE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRqnferIWK0zNXJ1zYZH7GMTqMuWznL381I/2rUyN1TM47G26xA+0Qsi11jMp0CaSWK2s6t/F6v8Vdp1lFRySqEBz7zEZjp8UCvJ7gX+VazDIY5T/EXAz/oc01pz4sPXlJ+jQn6cAbmmhR8QsPWkKcitldpbrXCblG3A81s2d0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xrum7xMK; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712826688; x=1744362688;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=24kkANAuKMfEK7jrYohH0tLZgqx3vf5epfePFY1E5RE=;
  b=xrum7xMKlCJw8yRL24w0cI29aXSEveT2gNzQm1VGW3eeZ004Ic5W6XoM
   58F92XWh2AuqhBw7boanpFckEuBrligxg5RJL8/6fWn3SNGkX5PmAIxX9
   GoMYcWNTHpXwgRFfuesPOxm5rU7qRHSJ2mY3C61nddX9kE4yqfp6EYsJq
   YEI6vW22JLNTYLpc1yiTpYmrsf/iU4wicMOv3fhz34XzgYKSqckXrU1/G
   xMRqBdfGXAvGlszVvjDkRn+7ht4m5iYtozC/Z0DlnSYg6T/ucXGsUANWB
   bgr3M8ZvQeGc6vfWx+/3sz3AkutJC5RXycFsCNy5wlzSpjXKqs+RcIGVP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="29563494"
X-IronPort-AV: E=Sophos;i="6.07,193,1708354800"; 
   d="scan'208";a="29563494"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 18:11:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UATS6xBzDbQs8SiEK9qniVlwGaB9Ch+KbRjrB3Ac6h/+Dm7MgFHjqsWcUdkft7rA/SHZTPglKlh9Z6zSEMBn3ZrT42Lc5u6tXzHaP5LKDjC9MtcAMW6SnnnY0i0QYFKdtyp09+5utXR1LE3knoupDSpCksvG13E0jWnk/lzWSIXM+UkF8A5JOAQCDvO6jey0+fJ/sSwk8RvhGAiLAco4uS6MJjv8RFsFte9PrFhtufUqcuYHT6UbEL934EmQf4kRgrZi5TxP06bRmG3zVi5VdH4WltCDtxDg3aRcC2/p2zqdEgpaOr3Bw1659+9a7DlnWq/qwfWvUwpJkxo7/jF9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24kkANAuKMfEK7jrYohH0tLZgqx3vf5epfePFY1E5RE=;
 b=Hzc2bCR3mlOd6kQ2T8knJqFE23uSLzr6vj/2v7CpCp6FxpuZYvoLbn9wQhEiNzeK6xGITOJv4czOareFdgSgsBaoYHifs28HJjNQAObzAl45cq82vFMrGSNTTYkk9yic6zaE+5RgzgUQVFxaTz6oobppEMmbYdsl7QIM+l3l9TGgiMBuTlC9PfENK7XbEuBz7oZZjrqxWIkx1JtKnapKcfTtIMLkq8GMrEk0ktmzgPneGde/ZLiG7WxYb4xLeSN7sv00qu3t224xIDdmce9y0wKLE4laCy+UnVP9ySdMope5VteXEIF7qzzUuK4mV0xkblBZBG3mTeVU1gsZmjLaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OS7PR01MB11870.jpnprd01.prod.outlook.com
 (2603:1096:604:239::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 09:11:16 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 09:11:16 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Return the correct errno
Thread-Topic: [PATCH 1/1] RDMA/rxe: Return the correct errno
Thread-Index: AQHaicAmATCrPGz7aUG8WFRFZsnjYLFizOcA
Date: Thu, 11 Apr 2024 09:11:16 +0000
Message-ID: <402329bf-b959-4210-a3a0-7a3847dd8811@fujitsu.com>
References: <20240408142142.792413-1-yanjun.zhu@linux.dev>
In-Reply-To: <20240408142142.792413-1-yanjun.zhu@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OS7PR01MB11870:EE_
x-ms-office365-filtering-correlation-id: e1a3833c-902e-41cd-afab-08dc5a0757ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NifpSB3Kqvoz1FP+q1r/vov1e+26YWAmmb3ANRsXZ5tQCBi3nO3bvgjgXodOEogC7Xm8hU96gk6RbWdJj+nFNl7zqZjc5fbunz4ZLlnJTPyPgirCjt27npnV9OxTzmxVFzUiQ3VvduE4uLBWIbSpJ4l8iF7KUBNmzDo/jx/MefUjypD4qFnkz0X5FrSBBv27696hRq1wz2KKAgKu/EkWT0YGLyl5Kdpu14h/AD65MHsALNQrmmTJYS8G2N/rm7KFQP4ZBwPrmNXsP7W9y2m5LWqGbBUmydDwLd+pehp0k32uDap3cKLQg9PUrRiRisJ3C7o2+8PELsZLvWkYTzKOIauNOV9y+OJn1s5HKVvJsF/bCSegGFf4bwJKuNILJJ+M19fQAx95sHGl/0Jki81Gg77Uw/tkDGVOUshpU3usMw/+S8zPrDRxsd2a2Y7+oDIURQKl/T7ehkGIBK6ObGgPqD5UMw/gKVz3bqnGEE7wzMdjzJVdXigrkPXK3IX/+Xmn8blsYZ+/XIBlMSFYaOXEKGcywqnilImF0WX7vMwFFBlJIbloGYod3V9QRFdIJb/8Vls9XWk/3m1oLZTucxhbYOkFSN8CzJ+BkezT2cRc2YXZDPO+frr6RJc0RoCQvfRO5nyBwg/z4xd5rD5H6gyhm4+2+rG6flUU5NRnteQriNVxZPvKI1qkuMsvfJdS15I5nCLFnoB1UC9kvwK8KioT9w5wvaDRM6c1aPFpp+yyLB0n9137N/3YJJv5AAHwkTFD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXZjQWgzWEt5QXIyU1VzNm4rNmxidjZCeEtTM2x6OTY4bnYzeEJyYkRJNiti?=
 =?utf-8?B?V0k1YjVFeFpwQk95NTdRU29ucTZTblZGb1VKNEpTSWZwRFpqTldYN0JQVkFO?=
 =?utf-8?B?WUJOTkZCK0NoOXhMREM5elI3WXJyZlFLUmlmWlFvSkhOT2xjQThtdVlkS09W?=
 =?utf-8?B?NEZReEdPbkFPOVovTmZJelg5c2libjVQUzhtdXVrS21XeTdTK0gxS1F6Qi9Q?=
 =?utf-8?B?Y1R5VXlHcDVqc2JKQ0ZFdkxsYlNLY3FRQ0NsR0MwWVVvSHMzV2hwYjdMM1c5?=
 =?utf-8?B?bmRORmxUUysraDI1UzVGR3FCVDIvajRSb2hQRzVLS05xaG5UQ1JGMy9ISHZZ?=
 =?utf-8?B?N3lYZTEzR3UrbE4vMm53b3JQaThnSlFwMHFpR1pEOTRUMmRlWkZsQUY5bjUy?=
 =?utf-8?B?MDZuSTFTRXFFdnVGZmZOMENhL1c2d3Q0TlJiSzRHT0ZVY3Fjd2pTQkszK3pJ?=
 =?utf-8?B?YlZ2cjlBMko2anpjU2dXU3lXMTFYcHRacGVyamlsTjBsbVB6UXlWQ0JwUWRC?=
 =?utf-8?B?Yk5ZajlibjFGd08zMk1DbFJtb3lObmxmQ205eVlWcjRtSXdNMnFQV2ZaRGov?=
 =?utf-8?B?WktGai9oSGxjVk1wNDZyc1czNXNCWkVUbGtsVXJmd1p1TjdxMUVRVGt1dlR2?=
 =?utf-8?B?M3lBRkxaZFU5enR5bjRDS2kxRkZiM005QUpQczE2NjdTc3o5bXpnMnZ0dmFZ?=
 =?utf-8?B?V1R5cklWdHN5bkFEVWZsS3BhZTFVQ2JycU5YUlRjWkx1MHQxWUZUZXJJUUxC?=
 =?utf-8?B?aldxYmJVbmZzZFoxZE1VTEd6TUgzZ1c2M0Q1czUzaDZJa1VmUHV6dnpoaXcy?=
 =?utf-8?B?NkdDQ0ZwS2tFbXIrZFFjVzJtd1VMdzNpdWVhMGtyRVlsdmdJTVVqa1FTNUZh?=
 =?utf-8?B?d2g1eTlNSWF1Tm9ITzhMR1dTNFdTK1A0cTdDVTZUSHo3bmhUSEtMbmVFR3dV?=
 =?utf-8?B?RHpYUjljNk5teTVCSHFhQ0g1bk85MUJKY3Avc2MwT3MxUUczWVdrZWk4N0dr?=
 =?utf-8?B?YldTdG92bktMTmdyK2xkdkFNdU4vZHhBamUwOWJDTll1R3hHL1ZKMGFJRE4y?=
 =?utf-8?B?YkJoQkt6NS91UHpSMXFGTURmbXI2L2dLaW9GZDd3Si9CVmI5aFMyMW5JRlJR?=
 =?utf-8?B?UjRhZjNxQk0yNk0wOU5pTVEzR2k2Z3ZVWndKWU9QalFKS3hHWTJvQTl2MElN?=
 =?utf-8?B?MUZYVnVaOXRFcjkzMEpSMW1yek9LVWNQajlPdndaK2Y0djcvNGlyeWxuM05u?=
 =?utf-8?B?eTQvaWxCY1dhbXhkQ0o2ZW9zdHVpUTBxZ0UyaC9tbm00dWR0R2N6TTB2Qkd2?=
 =?utf-8?B?eUl2T0c2QnNYcUZnZTNVSFl3eVBqejk2N3pFTWhnY0NIVm1Sb2FJZXg0VTZH?=
 =?utf-8?B?VXZJNFpIeGVVcGZNVjFDWFJmNWkvN1RPaGJxOEExeVFxT0RwYm1kYUhYeG9m?=
 =?utf-8?B?QXZZRC8yek9HMWIveHBOT0tlQ2lHUzFpUkk3WXlueEIxbmk5aGQxWVFSNXVC?=
 =?utf-8?B?T3ZqaE9vc1hCbFNQaEZkaW5oMWtwQ1MvNnBPVGhrKzhFWXFHbElxZDZCZEZp?=
 =?utf-8?B?ME9GVnU5TUw3eU51bitwdDFCZnpSbUZDWXNxTW1uQ0g1YXRjam1LdHZDTnFN?=
 =?utf-8?B?RXBHMVlaRzlneTBmdElJZ2ZiUDBwcDhwN0JrQnUzbzFZRXA5MVdEUmxGVDh5?=
 =?utf-8?B?TTVwNEJxQUh0MXJ4cHJxTHpiRE1lTG1UeW1YcWJnZVdraDZjUklFSHgxRFZ0?=
 =?utf-8?B?QlV0NWhzWW1iam9MeHRRMmZSZ2lhSEc3TGpJRjB3dFNxUnoyUUNnNnFETHUx?=
 =?utf-8?B?eXlybENlTVpsdjJuNnRyNGlzbTN3VFB6YnJyMnlOaGdudklkSTJabjk4VHpw?=
 =?utf-8?B?Q1JMeTBqS2NYcExXRzFVUEtQOXdvZERwckt1bE00MENNdXpHM3JaUDdIdFh1?=
 =?utf-8?B?NkpZZXVRZ3IwWW1pUFF3d2lIVnk2NzVnQ01ob2IzVDI0bm52YnZia1ZUNity?=
 =?utf-8?B?TGRYZk0rWnlWZStmVW9Uc05nb2dNank1emVLeldtUkpDVHJYTGRHNk1QK2RW?=
 =?utf-8?B?eVZqcUtQMGNLNkswR0hTUHNkMGNodG1zTXl6WTZCcGdXV1FBeWV1UUJIYkdS?=
 =?utf-8?B?eFZUS2J3UjFxSmJPNEFkOS9maTJvR3BZdkk1dHRDemZQMnU0N0pRMTRwWGd2?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <677D08CD40FBE942993640FAFB17606B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gfgEVaqVlCRkln6LLnr57sOv1tWJYELRfdYBK6GPSTxMZLvwfGq43QwAgsGqSi52d2qZUXFqo7/JkFo/GCqdYFVsYmNG3FIlyaHygZILhNqXV0V1Z2f3/5aHWlwJacZv/bFWDPsUTVnYG2fokrcrFpu4GknR8lu5kiZiQh3fmYd/PsAY+zxp0bTOgy/Wxxl9mgPdlLOzWxFLbrDcys+3F1GVfJrFWXG9qPCcrFnSVSG2skrBCXCCNB9LGzdvT+GIja/mRylRgN5jc6Ez1yvSHfMFp+ptwew9RjwRhZ46HPeSHhp2K/MJEju+4StXIHLYgYPdnWpDQX72rE9d2W1MYzuFfFM4TyTQefMAQJLMFHr4A4SwkVpPB9AyDDZpLv1mM1MPsvkvWGneQuOMM4hlMxlEdeyLo2BVmNFtldTLFP3ImakHXxqRv9NkISIYjeISyQf8inpX/Z0wN7wm/E5q+nbW6uflKLWHxyEGHbt6YysNyvSJu7qJQ03mXOavjARuNtQZdu55x0Gau9m2C3Ta0MntjNjbeLvKB5TV5Jer75tQAUmUPg4ZNOwMdCwvCUnRmnrKJpHN4+bn+OpF1h92vUsedZFI9JPdIhs7RKqbT/0CczOOkDvnnx/9HSQz63xd
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a3833c-902e-41cd-afab-08dc5a0757ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 09:11:16.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjU3saCxVW6C7ECm+JLHiHQXEAlu64bggH7EDuEmvWuw6bGAydqW6zVzsH6V0x2BbTzIfLYk1Y/vZQOtaNgXJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11870

DQoNCk9uIDA4LzA0LzIwMjQgMjI6MjEsIFpodSBZYW5qdW4gd3JvdGU6DQo+IEluIHRoZSBmdW5j
dGlvbiBfX3J4ZV9hZGRfdG9fcG9vbCwgdGhlIGZ1bmN0aW9uIHhhX2FsbG9jX2N5Y2xpYyBpcw0K
PiBjYWxsZWQuIFRoZSByZXR1cm4gdmFsdWUgb2YgdGhlIGZ1bmN0aW9uIHhhX2FsbG9jX2N5Y2xp
YyBpcyBhcyBiZWxvdzoNCj4gIg0KPiAgIFJldHVybjogMCBpZiB0aGUgYWxsb2NhdGlvbiBzdWNj
ZWVkZWQgd2l0aG91dCB3cmFwcGluZy4gIDEgaWYgdGhlDQo+ICAgYWxsb2NhdGlvbiBzdWNjZWVk
ZWQgYWZ0ZXIgd3JhcHBpbmcsIC1FTk9NRU0gaWYgbWVtb3J5IGNvdWxkIG5vdCBiZQ0KPiAgIGFs
bG9jYXRlZCBvciAtRUJVU1kgaWYgdGhlcmUgYXJlIG5vIGZyZWUgZW50cmllcyBpbiBAbGltaXQu
DQo+ICINCj4gQnV0IG5vdyB0aGUgZnVuY3Rpb24gX19yeGVfYWRkX3RvX3Bvb2wgb25seSByZXR1
cm5zIC1FSU5WQUwuIEFsbCB0aGUNCj4gcmV0dXJuZWQgZXJyb3IgdmFsdWUgc2hvdWxkIGJlIHJl
dHVybmVkIHRvIHRoZSBjYWxsZXIuDQo+IA0KDQptYWtlIHNlbnNlLg0KDQoNCj4gU2lnbmVkLW9m
Zi1ieTogWmh1IFlhbmp1biA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYyB8IDYgKysrKy0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wb29sLmMgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9wb29sLmMNCj4gaW5kZXggNjIxNWM2ZGUzYTg0Li40M2JhMDI3N2JkN2Ig
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYw0KPiAr
KysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wb29sLmMNCj4gQEAgLTEyMiw4ICsx
MjIsMTAgQEAgaW50IF9fcnhlX2FkZF90b19wb29sKHN0cnVjdCByeGVfcG9vbCAqcG9vbCwgc3Ry
dWN0IHJ4ZV9wb29sX2VsZW0gKmVsZW0sDQo+ICAgCWludCBlcnI7DQoNCkknZCBsaWtlIHRvIGFz
c2lnbiAnZXJyJyBhIGRlZmF1bHQgZXJyb3IgY29kZTogLUVJTlZBTA0KDQoNClRoYW5rcw0KWmhp
amlhbg0KDQoNCg0KPiAgIAlnZnBfdCBnZnBfZmxhZ3M7DQo+ICAgDQo+IC0JaWYgKGF0b21pY19p
bmNfcmV0dXJuKCZwb29sLT5udW1fZWxlbSkgPiBwb29sLT5tYXhfZWxlbSkNCj4gKwlpZiAoYXRv
bWljX2luY19yZXR1cm4oJnBvb2wtPm51bV9lbGVtKSA+IHBvb2wtPm1heF9lbGVtKSB7DQo+ICsJ
CWVyciA9IC1FSU5WQUw7DQo+ICAgCQlnb3RvIGVycl9jbnQ7DQo+ICsJfQ0KPiAgIA0KPiAgIAll
bGVtLT5wb29sID0gcG9vbDsNCj4gICAJZWxlbS0+b2JqID0gKHU4ICopZWxlbSAtIHBvb2wtPmVs
ZW1fb2Zmc2V0Ow0KPiBAQCAtMTQ3LDcgKzE0OSw3IEBAIGludCBfX3J4ZV9hZGRfdG9fcG9vbChz
dHJ1Y3QgcnhlX3Bvb2wgKnBvb2wsIHN0cnVjdCByeGVfcG9vbF9lbGVtICplbGVtLA0KPiAgIA0K
PiAgIGVycl9jbnQ6DQo+ICAgCWF0b21pY19kZWMoJnBvb2wtPm51bV9lbGVtKTsNCj4gLQlyZXR1
cm4gLUVJTlZBTDsNCj4gKwlyZXR1cm4gZXJyOw0KPiAgIH0NCj4gICANCj4gICB2b2lkICpyeGVf
cG9vbF9nZXRfaW5kZXgoc3RydWN0IHJ4ZV9wb29sICpwb29sLCB1MzIgaW5kZXgp

