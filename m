Return-Path: <linux-rdma+bounces-1821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D689B65A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 05:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BD11F2204D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108991877;
	Mon,  8 Apr 2024 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXvmSqE9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2093.outbound.protection.outlook.com [40.107.236.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3463AE;
	Mon,  8 Apr 2024 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546438; cv=fail; b=i8yD4aEK3Og6TpX1YQdZg879/sMQ3YMKRlHfhGN00Wkxc/BG4UPurNTs6vtid/4DJ/5LEpuAHwmZB7a981hvaL1qyTySrWhYxcaWux80vz5lS78HiQmzuI1KZvG+Rx3UcsdjUi2hTW6oturSvWQ5i9Aqg5QFtkv0NQqHcso1/Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546438; c=relaxed/simple;
	bh=t5qbeiSRHZUT2eX42t+RubfKEugT+gykOfufKBlpzXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2iOfUAj/tiTlY66uyPPFS9ITfDcmlj+ppTxToYueWS1H9VuDRQOqMGsKgjg3+7WtfFfD4+LujjjwKRb6ScmDfMzCVJ6ELPqww7CMZLGuAPexIT2qHu13971GqGH1wPEboyDkqBGBOH23/g8Jp5aSYMnXDkHq9kLu7A9faAW5uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXvmSqE9; arc=fail smtp.client-ip=40.107.236.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itVpeiRiNA0WlJ5RXhvw56cOqpAaPoQkki65ftUPXawQvqxCArLd8JAeg1r+qjnReFqU4XE7hzu+BNVlpGBRlzbKQRaCVzVPuksbkWAgYTP6XAjcTdXlB/FTWr5JKxL1YyPF8Gd7OLEpQtVzNkGC2xk7Kc1dM+KH6Nulf014iZOp6qPDgO1iz+TUyiqfd+nVDhJxvyQUtU0HD89tRHTMs62byOzD2G0repO9wl/iYCbLEv5AEySqNat3H02di09lvCToOzqMa2oMptYAn+dWryXRRP6szjrHQQGH1crHg8q7O7QJADA1n1uAQUCvjjOWWg4Asc2OsCv9awQZaV4kJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5qbeiSRHZUT2eX42t+RubfKEugT+gykOfufKBlpzXE=;
 b=mFybvpSdyXy5cMlhrkgAMurD4DV8ljb0FpXxlA5gcJcAQNebOrE0qcnDB3cC0o21iP9+YVCnnjJMPsGEZlLuk1JpPj+Z+YW0e6ESpCHQCYrqcUYJPzZ+qsjcYBxT9PiTxtgkddRoQ+MLXCOtAiEpGOn/m2tgFCgIxHt/469AtarMAvxVoCZIDx8XZdvuyoPNNHnDqv24RPm2wK5S1posEI/cEGXRe797L69vQkzk2MOPb2VEy2wSYhB8vboHoQRuhUZcIn+k/zV0NmRsTKwfKxppxZ+hnj9i00DNmf3GHpK50KaGa5+1SwC2y+csz8xGBR7drLfLsVDPPGB+nQstIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5qbeiSRHZUT2eX42t+RubfKEugT+gykOfufKBlpzXE=;
 b=YXvmSqE9l43N1s5YPoi3bjqnmvDEw9ArhgHFdRFWg5NiPINwCzQMrdgcSkK7s/3TVk9PUWTLSYnizvBBQRYuChtswlsliOST+sH/tZEsgWzQGFRac1TG0g5XVvxK1rhJFpp+31oZyQ2rggqvbjhdpO5C+5HvnNaYzXeH9xA5y0K4c8nklTvjHKeQvkjHX1Hw2BslOtEzkQp1zLcRt8+zmRKNt8x8KCvoFCV0Ec9JOr4HHsf0QjU50VqOcZKxWSMM150fjVC4g95TJ3xv/qOOMAojX2hiN8e/IyPnV9bzVwKURC37XM1iLm1u7pSu/Zhjz1NnNENwpdkR/i1wQw1DyQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:20:34 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Mon, 8 Apr 2024
 03:20:33 +0000
From: Parav Pandit <parav@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "dw@davidwei.uk" <dw@davidwei.uk>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Shay Drori <shayd@nvidia.com>, Dan
 Jurgens <danielj@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [net-next v4 0/2] devlink: Add port function attribute for IO EQs
Thread-Topic: [net-next v4 0/2] devlink: Add port function attribute for IO
 EQs
Thread-Index: AQHah76ebCxtr289AEm4Z8yYgHYmfbFa87WAgALD56A=
Date: Mon, 8 Apr 2024 03:20:33 +0000
Message-ID:
 <PH0PR12MB548176922B72653321F1D42ADC002@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240406010538.220167-1-parav@nvidia.com>
 <5c47f5de-c3cf-4921-9e8c-efc8b55f1d7f@linux.dev>
In-Reply-To: <5c47f5de-c3cf-4921-9e8c-efc8b55f1d7f@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB9050:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ps5eX+TTsH5uw9uhQ5/cpVEkwAGoDN+uc66zKMJoAiyabKe6fWC7fQo2jSfpHk33f1zDrjG9b75zdx5RTFh83bKBPy8BKYRfkS8JPPlHzpi5rD/GmIfh7GcxlZFhPNbELke4ePt3dlXE/WOb4bDSXql0hWzclVgFqyqsrGB4JqCs6cLnFigqGt4Q1Zy6UIs2UkqX4AVczN3n5HUapCMYtogJ1uDlXrfVV38kJnoMP24YkazX1C2BuXq0NTflaxorPCboxbl5ZJNgKB0Fmf+s+fIZVrru7maQxYao9DjdfuoVu4WTpQup6qw0gMH0sL1vOFUn3fAA93UMS8Fj2S0mYrubD2K3i1YOvB39mZmmxDQbtLQ4BZUhgs0xkQTCTRG7jg4B9Z5l9utjWd2yfzNIDvCJ3TeC8U/U6s6UkMJmX/J+J8W3gBO715QafNFrs1g74lfuuwoSMw00wEde6KuiQKKWULliBogKUSRCeIzYmblIz14MMglv/J2Jr42LdTyfAUaukmEsC88GNGWS/kwyH2vTO/ir/dcG7OK2AVkd6xqdI6vOenddSnbgs2mNsoBNk6elov8yyD3jyZIPivQQTzieUB0bCPVt+XKpKVbce2bREz5NI7AcOjWgddyemoMTO+SGCyqoonyc3/359JCeTs/yPjXwEzyN5sLojXK4QNM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alo0OWtrMWpqT1VKMXJFM3VUZ2M4MzZDNmVBd1RIRFU4ZVVsa2tZTDFaYmJI?=
 =?utf-8?B?dkRaK0RFdjBacDVZSmRtYnE1SFBuV255SEFKTnladThTSUFhSlkydjRnTW1P?=
 =?utf-8?B?V3NFNld6L29OR1BmZDg5TjdHY200dVlrdEVoMVd4RzFqcUluMjVxaHZEczFT?=
 =?utf-8?B?dFFtbTA2dVJLaU0zeWhJQWJxYlc4SmQvMmswM1lrUVpVUWlvcFNuRjQ3eVk0?=
 =?utf-8?B?c0NBMnNhRmtSQzd4QTVrTGo3T3dBQ25iOXpUN3NLcEd1RHRhLzlwcjc1SzI2?=
 =?utf-8?B?SGErRGtUY1pZZzFnMkNCd2UvbEJPa2VCRWF6dTg4U09hOUthc3BwQW1rTzlp?=
 =?utf-8?B?YU5zczk1TjNMaGIyQ2xibDdTdllzNnAzamdSTlZGMnNrWGpzakV0UXY5RmhE?=
 =?utf-8?B?QUpJeGxJYkJXUjVlNlNMTFk0ZFBJejlzVGc3Y3RWeDZYYitSRzJzZkduemFi?=
 =?utf-8?B?NmhKdUdrLzZEQWlaRWg3bWVPUi9VNWNJRGFjKzBzU1JRcEpqeFo5R0dwQisv?=
 =?utf-8?B?NkNrT0cvWGJNWmRQWWFSZWNEczlMYU8weGNzYXR5ZHYyYmQwbThPbkFicnVH?=
 =?utf-8?B?N3p6V3RvMVBLZTVuY2xSMEhpaFJ5NWhZbUZ1STdGTDNSayt1dXV6eHhFSUlt?=
 =?utf-8?B?TUpyUzlQeWppK1dKcUJ2R1I5WWMraWp2MEwzMkc4K0g1YlBGa2x3TndpU2xP?=
 =?utf-8?B?UG85NUIyN25hMHRxUDd6WjN3QUtTZy9CMTRMaytjdmFwS1FxbTJ6VUpSN1R1?=
 =?utf-8?B?MHBKSW10aTFjVTQxZW9tbFpDMHhGT0dpWm81ZUFqVmh3TVZWMktaWjZ3ckVy?=
 =?utf-8?B?TC8vRXp5eFRySFdWMzIzenY1eTJBam01SHgyUWZaeFMzaElKelJFUnNjZjBM?=
 =?utf-8?B?dmZIWmhwdS9aLzlmbzF1d0ZnNlYzWThqUU9vWVYwTCt0K21KbjhoZ1dDVTZ5?=
 =?utf-8?B?eTdHYk91cUhKNGhLRTJNV1FSWm0xYWdmSVJhVyswYVF6czdwbHBid25BdFF3?=
 =?utf-8?B?NUJaSnFTSUZLTi9KTDZiQUF0T0RVVXhuZlhiNXM1TjFmVnQzV2VnRGpBQTNT?=
 =?utf-8?B?UzhyckF4VmlmRkRaUzg2VnJIbU4wRlJ1aFVBenl1MzN3MHN6QVlaSU9GYldu?=
 =?utf-8?B?NzFjZFNIRkdURjY4aEJNUTE3YWMvM3NyRWp6Q3U0a21XWDFGYlRlbWJGRG9S?=
 =?utf-8?B?WEZwRThJVVM1NnZWMzNYbWxwUU4wU3hQYjljZUlyOGdWM1ROc3YyUENBcE1h?=
 =?utf-8?B?L3gxY3VwR3lYN0dGL2FSSldqUlZNTWx3eDE4cDJwbk1sWms2Z1JLbU10ZHBQ?=
 =?utf-8?B?WE05eGxEdzhjL3dBOE4rWnZQNDhsem1vTFAyTzJtaFVZMDh0VnhseXBMMldB?=
 =?utf-8?B?NHpiNXB4MUdhRFVjb3ZlNlZwSmJ0YkVsY3FyaytxUmRINTBWeFJ3TEJDbU9M?=
 =?utf-8?B?QVlITGp6S1dCcFFZSDBBbVFtbzZUY0l6T0FadXlJQXRkdTBtL0VrMEplWW9z?=
 =?utf-8?B?aWlkWnJJbzFESTdVU2MxVDdtZUF6ZS94c1JHeE5INlZSZWhZdEsxWFVxRk1V?=
 =?utf-8?B?eUlVV0pkSGh2TXVQR2JuSnhYVHJsQjRubkExMS8rdHN4WlVKeTRVWkRYSjZJ?=
 =?utf-8?B?ZkpKYm1YcUpkL05YcTRxelo3aGhmRVUrRVlBSFJJT0RTeTlRNDJwdkQ0dWRN?=
 =?utf-8?B?M1VEbzZSa3RCazRqMlFxWDhmTWJ5K3k5ZEJRWFkweUVGazltMXhCVld1VHBt?=
 =?utf-8?B?ckdHbHNQMGdLNExSRVN5NS9TUDF0U3laWUU1YmJnTGppVEF6TStrVmV0eDhJ?=
 =?utf-8?B?dXBaTHdoMUYzSHBKalhsTXFzRFJHUnA4ZmtTZWN5U3dya1FSaVptbTV6bFZm?=
 =?utf-8?B?Sk1hbUd2WXJTYm9VUndobGZSVElwS1RtS0RPdWZ0d25CS2VTVzY3M29zMU5C?=
 =?utf-8?B?MlVtYUxyc01EVmFGZ00rSFFVS0h3SHZRUTNOOElZdDcwRy81WVFvUFBhK09k?=
 =?utf-8?B?b0hhLy9NbTljZWg5WXMyZlg0djFSb2c3YmRKT0RLR3RYbW95dU5LOFhvMGdZ?=
 =?utf-8?B?czYzcldteTdueTI1dStUeEtUdWYyUHc5V2R5ZGNjN0NFdDBqTnRKKy9YZEta?=
 =?utf-8?Q?E0iU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0824b434-4d6c-4021-10f4-08dc577ada06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 03:20:33.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ie067oDZT1VPkDnpE4SFZggeEbbPYD/YMot8wB3//oJyY0ie/vi7OC+nqVJvH60StZnS98oJOekzX6VJNrRrAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050

DQo+IEZyb206IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPiBTZW50OiBTYXR1
cmRheSwgQXByaWwgNiwgMjAyNCAyOjM2IFBNDQo+IA0KPiDlnKggMjAyNC80LzYgMzowNSwgUGFy
YXYgUGFuZGl0IOWGmemBkzoNCj4gPiBDdXJyZW50bHksIFBDSSBTRnMgYW5kIFZGcyB1c2UgSU8g
ZXZlbnQgcXVldWVzIHRvIGRlbGl2ZXIgbmV0ZGV2IHBlcg0KPiA+IGNoYW5uZWwgZXZlbnRzLiBU
aGUgbnVtYmVyIG9mIG5ldGRldiBjaGFubmVscyBpcyBhIGZ1bmN0aW9uIG9mIElPDQo+ID4gZXZl
bnQgcXVldWVzLiBJbiB0aGUgc2Vjb25kIHNjZW5hcmlvIG9mIGFuIFJETUEgZGV2aWNlLCB0aGUg
Y29tcGxldGlvbg0KPiA+IHZlY3RvcnMgYXJlIGFsc28gYSBmdW5jdGlvbiBvZiBJTyBldmVudCBx
dWV1ZXMuIEN1cnJlbnRseSwgYW4NCj4gPiBhZG1pbmlzdHJhdG9yIG9uIHRoZSBoeXBlcnZpc29y
IGhhcyBubyBtZWFucyB0byBwcm92aXNpb24gdGhlIG51bWJlcg0KPiA+IG9mIElPIGV2ZW50IHF1
ZXVlcyBmb3IgdGhlIFNGIGRldmljZSBvciB0aGUgVkYgZGV2aWNlLiBEZXZpY2UvZmlybXdhcmUN
Cj4gPiBkZXRlcm1pbmVzIHNvbWUgYXJiaXRyYXJ5IHZhbHVlIGZvciB0aGVzZSBJTyBldmVudCBx
dWV1ZXMuIER1ZSB0bw0KPiA+IHRoaXMsIHRoZSBTRiBuZXRkZXYgY2hhbm5lbHMgYXJlIHVucHJl
ZGljdGFibGUsIGFuZCBjb25zZXF1ZW50bHksIHRoZQ0KPiA+IHBlcmZvcm1hbmNlIGlzIHRvby4N
Cj4gPg0KPiA+IFRoaXMgc2hvcnQgc2VyaWVzIGludHJvZHVjZXMgYSBuZXcgcG9ydCBmdW5jdGlv
biBhdHRyaWJ1dGU6IG1heF9pb19lcXMuDQo+ID4gVGhlIGdvYWwgaXMgdG8gcHJvdmlkZSBhZG1p
bmlzdHJhdG9ycyBhdCB0aGUgaHlwZXJ2aXNvciBsZXZlbCB3aXRoIHRoZQ0KPiA+IGFiaWxpdHkg
dG8gcHJvdmlzaW9uIHRoZSBtYXhpbXVtIG51bWJlciBvZiBJTyBldmVudCBxdWV1ZXMgZm9yIGEN
Cj4gPiBmdW5jdGlvbi4gVGhpcyBnaXZlcyB0aGUgY29udHJvbCB0byB0aGUgYWRtaW5pc3RyYXRv
ciB0byBwcm92aXNpb24NCj4gPiByaWdodCBudW1iZXIgb2YgSU8gZXZlbnQgcXVldWVzIGFuZCBo
YXZlIHByZWRpY3RhYmxlIHBlcmZvcm1hbmNlLg0KPiA+DQo+ID4gRXhhbXBsZXMgb2Ygd2hlbiBh
biBhZG1pbmlzdHJhdG9yIHByb3Zpc2lvbnMgKHNldCkgbWF4aW11bSBudW1iZXIgb2YNCj4gPiBJ
TyBldmVudCBxdWV1ZXMgd2hlbiB1c2luZyBzd2l0Y2hkZXYgbW9kZToNCj4gPg0KPiA+ICAgICQg
ZGV2bGluayBwb3J0IHNob3cgcGNpLzAwMDA6MDY6MDAuMC8xDQo+ID4gICAgICAgIHBjaS8wMDAw
OjA2OjAwLjAvMTogdHlwZSBldGggbmV0ZGV2IGVucDZzMHBmMHZmMCBmbGF2b3VyIHBjaXZmIHBm
bnVtDQo+IDAgdmZudW0gMA0KPiA+ICAgICAgICAgICAgZnVuY3Rpb246DQo+ID4gICAgICAgICAg
ICBod19hZGRyIDAwOjAwOjAwOjAwOjAwOjAwIHJvY2UgZW5hYmxlIG1heF9pb19lcXMgMTANCj4g
Pg0KPiA+ICAgICQgZGV2bGluayBwb3J0IGZ1bmN0aW9uIHNldCBwY2kvMDAwMDowNjowMC4wLzEg
bWF4X2lvX2VxcyAyMA0KPiA+DQo+ID4gICAgJCBkZXZsaW5rIHBvcnQgc2hvdyBwY2kvMDAwMDow
NjowMC4wLzENCj4gPiAgICAgICAgcGNpLzAwMDA6MDY6MDAuMC8xOiB0eXBlIGV0aCBuZXRkZXYg
ZW5wNnMwcGYwdmYwIGZsYXZvdXIgcGNpdmYgcGZudW0NCj4gMCB2Zm51bSAwDQo+ID4gICAgICAg
ICAgICBmdW5jdGlvbjoNCj4gPiAgICAgICAgICAgIGh3X2FkZHIgMDA6MDA6MDA6MDA6MDA6MDAg
cm9jZSBlbmFibGUgbWF4X2lvX2VxcyAyMA0KPiA+DQo+ID4gVGhpcyBzZXRzIHRoZSBjb3JyZXNw
b25kaW5nIG1heGltdW0gSU8gZXZlbnQgcXVldWVzIG9mIHRoZSBmdW5jdGlvbg0KPiA+IGJlZm9y
ZSBpdCBpcyBlbnVtZXJhdGVkLiBUaHVzLCB3aGVuIHRoZSBWRi9TRiBkcml2ZXIgcmVhZHMgdGhl
DQo+ID4gY2FwYWJpbGl0eSBmcm9tIHRoZSBkZXZpY2UsIGl0IHNlZXMgdGhlIHZhbHVlIHByb3Zp
c2lvbmVkIGJ5IHRoZQ0KPiA+IGh5cGVydmlzb3IuIFRoZSBkcml2ZXIgaXMgdGhlbiBhYmxlIHRv
IGNvbmZpZ3VyZSB0aGUgbnVtYmVyIG9mDQo+ID4gY2hhbm5lbHMgZm9yIHRoZSBuZXQgZGV2aWNl
LCBhcyB3ZWxsIGFzIHRoZSBudW1iZXIgb2YgY29tcGxldGlvbg0KPiA+IHZlY3RvcnMgZm9yIHRo
ZSBSRE1BIGRldmljZS4gVGhlIGRldmljZS9maXJtd2FyZSBhbHNvIGhvbm9ycyB0aGUNCj4gPiBw
cm92aXNpb25lZCB2YWx1ZSwgaGVuY2UgYW55IFZGL1NGIGRyaXZlciBhdHRlbXB0aW5nIHRvIGNy
ZWF0ZSBJTyBFUXMNCj4gPiBiZXlvbmQgcHJvdmlzaW9uZWQgdmFsdWUgcmVzdWx0cyBpbiBhbiBl
cnJvci4NCj4gPg0KPiA+IFdpdGggYWJvdmUgc2V0dGluZyBub3csIHRoZSBhZG1pbmlzdHJhdG9y
IGlzIGFibGUgdG8gYWNoaWV2ZSB0aGUgMngNCj4gPiBwZXJmb3JtYW5jZSBvbiBTRnMgd2l0aCAy
MCBjaGFubmVscy4gSW4gc2Vjb25kIGV4YW1wbGUgd2hlbiBTRiB3YXMNCj4gPiBwcm92aXNpb25l
ZCBmb3IgYSBjb250YWluZXIgd2l0aCAyIGNwdXMsIHRoZSBhZG1pbmlzdHJhdG9yIHByb3Zpc2lv
bmVkDQo+ID4gb25seQ0KPiA+IDIgSU8gZXZlbnQgcXVldWVzLCB0aGVyZWJ5IHNhdmluZyBkZXZp
Y2UgcmVzb3VyY2VzLg0KPiA+DQo+IA0KPiBUaGUgZm9sbG93aW5nIHBhcmFncmFwaCBpcyB0aGUg
c2FtZSB3aXRoIHRoZSBhYm92ZSBwYXJhZ3JhcGg/DQo+DQpBaCwgeWVzLiBJIGZvcmdvdCB0byBy
ZW1vdmUgb25lIG9mIHRoZW0gd2hpbGUgZG9pbmcgbWlub3IgZ3JhbW1hciBjaGFuZ2VzLg0KDQog
DQo+ID4gV2l0aCB0aGUgYWJvdmUgc2V0dGluZ3Mgbm93IGluIHBsYWNlLCB0aGUgYWRtaW5pc3Ry
YXRvciBhY2hpZXZlZCAyeA0KPiA+IHBlcmZvcm1hbmNlIHdpdGggdGhlIFNGIGRldmljZSB3aXRo
IDIwIGNoYW5uZWxzLiBJbiB0aGUgc2Vjb25kDQo+ID4gZXhhbXBsZSwgd2hlbiB0aGUgU0Ygd2Fz
IHByb3Zpc2lvbmVkIGZvciBhIGNvbnRhaW5lciB3aXRoIDIgQ1BVcywgdGhlDQo+ID4gYWRtaW5p
c3RyYXRvciBwcm92aXNpb25lZCBvbmx5IDIgSU8gZXZlbnQgcXVldWVzLCB0aGVyZWJ5IHNhdmlu
ZyBkZXZpY2UNCj4gcmVzb3VyY2VzLg0KPiA+DQo+ID4gY2hhbmdlbG9nOg0KPiA+IHYyLT52MzoN
Cj4gPiAtIGxpbWl0ZWQgdG8gODAgY2hhcnMgcGVyIGxpbmUgaW4gZGV2bGluaw0KPiA+IC0gZml4
ZWQgY29tbWVudHMgZnJvbSBKYWt1YiBpbiBtbHg1IGRyaXZlciB0byBmaXggbWlzc2luZyBtdXRl
eCB1bmxvY2sNCj4gPiAgICBvbiBlcnJvciBwYXRoDQo+ID4gdjEtPnYyOg0KPiA+IC0gbGltaXRl
ZCBjb21tZW50IHRvIDgwIGNoYXJzIHBlciBsaW5lIGluIGhlYWRlciBmaWxlDQo+ID4gLSBmaXhl
ZCBzZXQgZnVuY3Rpb24gdmFyaWFibGVzIGZvciByZXZlcnNlIGNocmlzdG1hcyB0cmVlDQo+ID4g
LSBmaXhlZCBjb21tZW50cyBmcm9tIEthbGVzaA0KPiA+IC0gZml4ZWQgbWlzc2luZyBrZnJlZSBp
biBnZXQgY2FsbA0KPiA+IC0gcmV0dXJuaW5nIGVycm9yIGNvZGUgZm9yIGdldCBjbWQgZmFpbHVy
ZQ0KPiA+IC0gZml4ZWQgZXJyb3IgbXNnIGNvcHkgcGFzdGUgZXJyb3IgaW4gc2V0IG9uIGNtZCBm
YWlsdXJlDQo+ID4NCj4gPiBQYXJhdiBQYW5kaXQgKDIpOg0KPiA+ICAgIGRldmxpbms6IFN1cHBv
cnQgc2V0dGluZyBtYXhfaW9fZXFzDQo+ID4gICAgbWx4NS9jb3JlOiBTdXBwb3J0IG1heF9pb19l
cXMgZm9yIGEgZnVuY3Rpb24NCj4gPg0KPiA+ICAgLi4uL25ldHdvcmtpbmcvZGV2bGluay9kZXZs
aW5rLXBvcnQucnN0ICAgICAgIHwgMzMgKysrKysrKw0KPiA+ICAgLi4uL21lbGxhbm94L21seDUv
Y29yZS9lc3cvZGV2bGlua19wb3J0LmMgICAgIHwgIDQgKw0KPiA+ICAgLi4uL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3aXRjaC5oIHwgIDcgKysNCj4gPiAgIC4uLi9tZWxsYW5v
eC9tbHg1L2NvcmUvZXN3aXRjaF9vZmZsb2Fkcy5jICAgICB8IDk3ICsrKysrKysrKysrKysrKysr
KysNCj4gPiAgIGluY2x1ZGUvbmV0L2RldmxpbmsuaCAgICAgICAgICAgICAgICAgICAgICAgICB8
IDE0ICsrKw0KPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2RldmxpbmsuaCAgICAgICAgICAgICAg
ICAgIHwgIDEgKw0KPiA+ICAgbmV0L2RldmxpbmsvcG9ydC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgNTMgKysrKysrKysrKw0KPiA+ICAgNyBmaWxlcyBjaGFuZ2VkLCAyMDkgaW5zZXJ0
aW9ucygrKQ0KPiA+DQoNCg==

