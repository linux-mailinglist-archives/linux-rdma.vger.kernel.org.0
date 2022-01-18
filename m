Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECBC4921C9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiARJDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 04:03:04 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:35264 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233192AbiARJDE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 04:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642496581; x=1674032581;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=PxdEqjI+ehEuT84v/+olG3Vl0taPoIwaWIs49ts6bnc=;
  b=JPI0kHJoeJXs8/ICZ3onu9Vc5ZCoslq2Z70/VdM6GRb/qbVLB7+mPjiL
   s3w1ghGfriqP7a1bfEGucZw4vt9B+A8o0cx4/tnlUyBtUL8By6tZJXK2w
   4AlCW5J44aIw3JtuZWWqD1ahDCPXDFYH2rk1eyFFl3FEdvgqAQyRQ5PRE
   qWMzGT2Xfv9CiOuh0Tux4x4RqUMBYPiEaiAVTLPKjQeERqFo4wVOclsP7
   2YRxEo2nHyo/1zaJN6uVzaJzXcAWAdU5U8YuBXCFZ7B64kliViDkWuMYP
   IKNAizmhugNpGnEk+dTAg3OS0M9j95agWGFoi0baUvVsi9NdanxYgiROx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="55933386"
X-IronPort-AV: E=Sophos;i="5.88,297,1635174000"; 
   d="scan'208";a="55933386"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:02:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwPYh1ob+1kuQtzZ/VO5cOmKhOpPPFGUQFEbr/fAP3X6yzG8kD88s9QTG6DDLATr1C5xhjFXNPomMCpaDUUWbEjxJUGVmF7wPShaZ5zA5BjUWgkAG5PpOmC9YRdqMQyoh5XTFCDDR0uXzL1KQvU93NFMVDJWA+oTs0o+XY05KJZofV9Cu8RVG0SSJfyQrrDkBTkks+rq55U4Li4KwhTc7Ar9VoQlFEdoE9EztgeMWEf1vGUpcfgEGzYJ3+DfMw+5smajD1ilZm8DCwf2D178jYpSn6IsQN38Aoy5UyW7ya8aQT34HYpp1WVECdb143dZ8PH37HAggE08wPIPo65+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxdEqjI+ehEuT84v/+olG3Vl0taPoIwaWIs49ts6bnc=;
 b=QICtBo+6+SeFbdtv7O8VK7PqwO/KhilI7ST7V0mnhZxc7vIYAx85HXQOn7icBXm3EMxvUY4YT13b2iUOVXSmL7lNSsXUhs9Jw1b7Cv2xfL7xaoNsm9l7a9PCka3qw7okgot5dTbIhOQ6EgVBVL/ex4vII2II3mKcxJMBOCvAPUXo+K5Y5P3PtRfKFdAGQ/TEaCyc3pGI7fxAT2J4weFWm77ZWbWfxZ68lpfoV0keBvEBf0z9NbmC8M8ubOiOWFedI/VV8EtPgoVbz1RD1Qf8MKZBN6mElaq3soDGFsPN58SfOPxtWq4FskuAxH5MhDN21EguLq5ER93btXdmh+S+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxdEqjI+ehEuT84v/+olG3Vl0taPoIwaWIs49ts6bnc=;
 b=nEv7s/fEdFnqXOpc4wKsMDilpfrWU4whOg3olUsOUOQEGXnnpYtzsV/grbXzy1OLPo8eeCjCMoHgfuv35SDXc8VqfO2Y0nfO+12c+8AOymIzdZVsQdERfrHnhQ/6BOLRuKceLOOqiJKNyLm3VsuVCbuLIBsF9MOzM15HiVahLz4=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYWPR01MB9276.jpnprd01.prod.outlook.com (2603:1096:400:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 09:02:59 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 09:02:59 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Fwd: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYDEow7oX0AnDnYkSZqdV5YEsLFA==
Date:   Tue, 18 Jan 2022 09:02:59 +0000
Message-ID: <61E6823E.9090808@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c3d6c01-586c-4b58-752d-08d9da615332
x-ms-traffictypediagnostic: TYWPR01MB9276:EE_
x-microsoft-antispam-prvs: <TYWPR01MB92765E6BA98E352D50E88CB983589@TYWPR01MB9276.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6YBxQOIDcKf4J7hleYo5AxcpFFLCGFEU7AKslMSYWI8ll+A9fGe92KnnPY6X/u/Ja581ZAVkU5uGBtzqk8tj7LkNHMOLHLoMzcoYv746BL/hTxoqvqo89MZXABiLQYYdf/ZkonRm+iLlK810Ro0o3QvWteC2MJBZFAi5POi0tRBk04WNE+Ue6D4ab10bC/bqniNDp1YsJop6dMAvAOHfsNcChy/zJnRDV2NuuZBFCL15sgiVeszzDaf8l3ueNPgmumU0it+HxUPQbFscX5ILh5judE8hy3+m15gOVhUBxXuYteun6Yv47WQotgimiOJ54QyVl1MsQeYadOW2x/bNzXgXlLCrSFY7xga9al/EDKLPCmMjJqr8X6dyVmAJdKHLHWaV69gC8QVVjvyQX0PBHdVO+Ru6mUL2Hd0NqX4y/PUUslW06hNLRN1sIeLQjKc667CKfFQEmnplyJUsQJ5BUiai8Jdi9jtJeUG02oz2rdXwzYbtcOX9hrp+AmZfZjb/he/nTBtU/T+SOaUK8TwNGH78vyI8ADcrJe+QzjBm+mnNvlujBMlq+SP7NUiqXfGjWCPIyCpI592y40OU6dOkTyVcOE9YSZyq4qUCSGU2plQiQ4AX3PvrfLMDKb9JaEjs+YbFUD5l32Zr+iPyOKmsmiZZlwlsmJY4He8LsHgIR0SIw1IrBeM/HjgYjokeRWOzVkdETXBATKdODGLFHOUfVM/QXTNOxJD7Z9qBU6FM1g8ph2q7PInita0Tt28WVSJZ13eFDTl7BPnR6IW/iscJ94V3ZniPs1ADR7slmaYmQU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(87266011)(86362001)(966005)(26005)(33656002)(53546011)(71200400001)(6916009)(2906002)(316002)(186003)(66556008)(66476007)(66446008)(36756003)(91956017)(64756008)(6512007)(76116006)(5660300002)(8676002)(6486002)(2616005)(6506007)(38100700002)(38070700005)(8936002)(508600001)(83380400001)(66946007)(85182001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlhqcTlrYUw3ZGR6RlRQaVg5VVl1ZzdQSnZWV1RTZzB4MnFXMUV5UXllZk03?=
 =?utf-8?B?QlFtOUJqOXJ2aHducS9LS3MwTjZCTFU5aUU0NWgyY1hXc1d1eXN3U20xb2J2?=
 =?utf-8?B?U0ZYbzYzb3RFV2xjQjdYODNTZzdlMjhvRStQbUdDVUFoTjQ3SURKbDdVSk5n?=
 =?utf-8?B?bVRkRzhrdmJoOXdPakQ5Z3dLV0ZYNXBycHZrd0sxd2pVeDlyQ1c0ajNmNGk5?=
 =?utf-8?B?cUxpc3NIZ0haYXpxNUcrcGJDY0JlYVBUTUVGZGZRL3RWVDZ3cjl2djdodWdQ?=
 =?utf-8?B?dmltQjcwbmtrSTViNndkeGhxWFYzOUttY2FRVG1STnJJQ2RVNXQ5Y2VqSUhr?=
 =?utf-8?B?Mk5EN2pVdU9SK3grYWNwaUVneENVaGRhVmY0L3BnZE00dzY3QUVob0JZUTFx?=
 =?utf-8?B?ejU0SnNZdnhycnhVeTdIM2J0UHplYW13VGJINjNIc0VnZDl3M1MrTUgxZzkx?=
 =?utf-8?B?RFAvMGwrazR2Wk5EZDFNRWgvZzMwN1ZpTGhIY3krQ05tRGtiNitRODh3OGxy?=
 =?utf-8?B?VFVJUUxtbXNIeGw0VGhLdGJpNVNuSjFxRjhjOXp4TXQ0R0JDbTVqSWdQdFJW?=
 =?utf-8?B?VC85RWNzZThDa3NzSlloQ3NFSllUSVQyTEFjU0NnaGtmdklHWmNEM2xZQ1FW?=
 =?utf-8?B?OWRadnpiQmlxVDBmUGpmSXlMc3RxYlVNN0o0cnRCOEk3c3ZQQVNEazlmdEgr?=
 =?utf-8?B?a0l0T25FYWJsOHpHVFQvYWNIblcyWXVXTk51K1hRWTFGQ3JWTVlaVGdXa2RH?=
 =?utf-8?B?QkJ2eTI5T05mMWwvdThLZm1lYWNXamdIdlRnckFQNHpvejByWmZQYWFXUmZ2?=
 =?utf-8?B?UURDNTJQcVhIVkx5WENUZDBuekxremMvWDIwUE1Xak1pZzllTnFJR1dBeVVr?=
 =?utf-8?B?enhHckxGbE9Vc0cvaXdiU3FkSHFTMG1vVEhWaSs3UzBDTUlRZ1hlekZHTmd3?=
 =?utf-8?B?MkozNncwajNkZC9VRGZrWEZacHlCWUk4RmtYNGVEMWdZZlMxcHZoa1JTaHVV?=
 =?utf-8?B?YXg2Ky9FT0RtTDJHS3VNejcvUWdjQjBORWp0Z1N6bG01RkFraDc3NFRlT1Bn?=
 =?utf-8?B?allobjdhS3ozRzRlQnBlb1hhRGZzdUZmWHhXZmw0TTFiUGQzVWFEVmUxc0V1?=
 =?utf-8?B?UjU3VzhHRlRyaXhFNk5wWHFmaWx5VVpsem9CMVVsUE5icTllK1Z2TmN3L1Qz?=
 =?utf-8?B?dFJDalNFZWhOYTlrRmdQT1FYcFdvWnJ5Ylg4SHErVEdsVkd0V0Q3L3Jpb3hD?=
 =?utf-8?B?cFRUTUxLa1ZxcmpMamZKcjhTcmp5eW9aU0Fxejk5dUJucVlBdUpDaE13Q1F4?=
 =?utf-8?B?R3MvRlBheUlkWkNTb1FXR0lRbjVrNUVMRG5yVEpjbUFaSVcva1QvOFpsNGxG?=
 =?utf-8?B?cUF1YWZkdnFFcnVmTFJVSjk1dnAwK2ZEallFaWtVelZDMVJUUUwwSjNyQ0xz?=
 =?utf-8?B?T3h5MEVSZkkzdzBLdUJ2WXNwdTloSkNSZFlpVUdjZlJzUnBGdHJkbm55ZnVH?=
 =?utf-8?B?Q3ZBWDVKTjE4allxTXM1enhNYWFuSUlndU9GZTM2NjE2Vzd5R0p0NVF2WlFX?=
 =?utf-8?B?aWFjMjJlZVg3UlRUMEFoVXpZV3FNKzB0YzUwcDF6c0pNTjJpOHV4NEhSYXNN?=
 =?utf-8?B?TnBsVjlDSjZXNThNQTdFbXNZT2Nkd0tzTnJMK1VCUzY5cUp5K0c4LzMxcnow?=
 =?utf-8?B?Y0tPelNhcnpDUmtIZWN6UENhY3N0cEltOXVSV1NxVHlFd3BhbzBTZVcyQ3J0?=
 =?utf-8?B?bGR6bEYzOFJ3T1VTNEx4YVFtY0NMdzNIUzcxemNSaTJIdUFFenVXYkpwSEVQ?=
 =?utf-8?B?R3VXczlGUVdiNzVmWnBydW5GSDk3YjVzNGdMOUUzSVQxNFlvQUdyVGNrbDFu?=
 =?utf-8?B?ZnBqSk4yQzduSVpISE1rekRqTmQ3aGl6Y3o2clE0V3ZUTlBhSG03S2NmRFhm?=
 =?utf-8?B?QlBBaU1peGRkdEgxUk1Za251NnRTdzNiZjd6eDRCNlJkeW9jVVBwYUQxdU9O?=
 =?utf-8?B?RXFDOVhhR1JPK1p5ZnVPVWtMY0t5c29CSlpDdGRLeFE0QU5vL2htbWdUOFVq?=
 =?utf-8?B?RUZkN1JkN0ZRRFdYTTFKWE9MQk9IWHFwWTV4SGJOcGFZM1Z2MlBWbDVKTWVu?=
 =?utf-8?B?WWlGak9jYkkrVzdUeW1Yd1lIc0NvK0ZUeGFVRkd2SnI1cVhjWmZ5Rkt5Smcx?=
 =?utf-8?Q?UYtdTK26WQKg2n1YnlEZtzhlAX5TL1RmUqSubdFoJCL5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <146D459D7B8D6B47AE1C9F2E7AA66FA4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3d6c01-586c-4b58-752d-08d9da615332
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 09:02:59.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9g6PZc+JlvJuqPIAqe9ZzpOXE7at8DPcxh5liWFwDBLSaxJ8jvPvGSxVUoB3PEL88wBRhwpN+ZTEU0dtUmFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9276
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Q0M6IGxpbnV4LXJkbWEgbWFpbCBsaXN0DQoNCk9uIDIwMjIvMS8xNCA0OjUxLCBCb2IgUGVhcnNv
biB3cm90ZToNCj4gVGhlIHdheSB0aGVzZSBxdWV1ZXMgd29yayB0aGV5IGNhbiBvbmx5IGhvbGQg
Ml5uIC0gMSBlbnRyaWVzLiBUaGUgcmVhc29uIGZvciB0aGlzIGlzDQo+IHRvIGRpc3Rpbmd1aXNo
IGVtcHR5IGFuZCBmdWxsLiBJZiB5b3UgbGV0IHRoZSBsYXN0IGVudHJ5IGJlIHdyaXR0ZW4gdGhl
biBwcm9kdWNlciB3b3VsZCBhZHZhbmNlIHRvIGVxdWFsIGNvbnN1bWVyIHdoaWNoIGlzIHRoZSBp
bml0aWFsIGVtcHR5IGNvbmRpdGlvbi4gU28gYSBxdWV1ZSB3aGljaCBjYW4gaG9sZCAxIGVudHJ5
IGhhcyB0byBoYXZlIHR3byBzbG90cyAobj0xKSBidXQgY2FuIG9ubHkgaG9sZCBvbmUgZW50cnku
IEl0IGJlZ2lucyB3aXRoDQpIaSBCb2IsDQoNClRoYW5rcyBmb3IgeW91ciBkZXRhaWxlZCBleGFt
cGxlLg0KPiBwcm9kID0gY29ucyA9IDAgYW5kIGlzIGVtcHR5IGFuZCBpcypub3QqICBmdWxsDQo+
DQo+IEFkZGluZyBvbmUgZW50cnkgZ2l2ZXMNCj4NCj4gc2xvdFswXSA9IHZhbHVlLCBwcm9kID0g
MSwgY29ucyA9IDAgYW5kIGlzIGZ1bGwgYW5kIG5vdCBlbXB0eQ0KPg0KPiBBZnRlciByZWFkaW5n
IHRoaXMgdmFsdWUNCj4NCj4gc2xvdFswXSA9IG9sZCB2YWx1ZSwgcHJvZCA9IGNvbnMgPSAxIGFu
ZCBxdWV1ZSBpcyBlbXB0eSBhZ2Fpbi4NCj4NCj4gV3JpdGluZyBhIG5ldyB2YWx1ZQ0KPg0KPiBz
bG90WzFdID0gbmV3IHZhbHVlLCBzbG90WzBdID0gb2xkIHZhbHVlLCBwcm9kID0gMCBhbmQgY29u
cyA9IDEgYW5kIHF1ZXVlIGlzIGZ1bGwgYWdhaW4uDQo+DQo+IFRoZSBleHByZXNzaW9uIGZ1bGwg
PSAoY29ucyA9PSAoKHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmluZGV4X21hc2spKSBpcyBjb3Jy
ZWN0Lg0KVGhlIGlzc3VlIGhhcHBlbnMgaGVyZSwgbGV0J3MgbG9vayBhdCB0aGUgIndyaXRpbmcg
YSBuZXcgdmFsdWUiIHN0ZXAuDQpXZSB0aGluayBxdWV1ZSBpcyBmdWxsIGFnYWluIHdoZW4gcHJv
ZCA9IDAgYW5kIGNvbnMgPSAxLCBidXQgdGhpcyANCmV4cHJlc3Npb24gdGhpbmtzIHRoZSBxdWV1
ZSBpcyBub3QgZnVsbC4NCmNvbnMgPT0gKChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9t
YXNrKSkNCjwxPiA9PSA8MCArIDE+ICAgICAlIDwxPg0KDQpJbiBhZGRpdGlvbiwgdGhpcyBleHBy
ZXNzaW9uIHRoaW5rcyB0aGUgcXVldWUgaXMgZnVsbCB3cm9uZ2x5IHdoZW4gd2UgDQpjcmVhdGUg
YW4gZW1wdHkgdHdvLXNsb3RzIHF1ZXVlIChpLmUuIHByb2QgPSAwIGFuZCBjb25zID0gMCkuDQpj
b25zID09ICgocXAtPmN1cl9pbmRleCArIDEpICUgcS0+aW5kZXhfbWFzaykpDQo8MD4gPT0gPDAg
KyAxPiAgICAgJSA8MT4NCg0KVGhlIGZvbGxvd2luZyBzdGVwcyBjYW4gZXhwb3NlIHRoZSBpc3N1
ZToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmF0dHJfZXgu
Y2FwLm1heF9zZW5kX3dyID0gYXR0cl9leC5jYXAubWF4X3JlY3Zfd3IgPSAxOw0KLi4uDQpyZXQg
PSByZG1hX2NyZWF0ZV9xcF9leChpZCwgJmF0dHJfZXgpOw0KLi4uDQppYnZfd3Jfc3RhcnQocXB4
KTsNCmlidl93cl9yZG1hX2F0b21pY193cml0ZShxcHgsLi4uKTsgIC0tPiBjaGVja19xcF9xdWV1
ZV9mdWxsKCkgcmV0dXJucyANCkVOT1NQQyB3cm9uZ2x5Lg0KaWJ2X3dyX2NvbXBsZXRlKHFweCk7
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpQbGVhc2Ugc2Vl
IG15IGV4YW1wbGVbMV0gZm9yIGRldGFpbHMuDQoNClsxXSANCmh0dHBzOi8vZ2l0aHViLmNvbS95
YW5neC1qeS9yZG1hLWNvcmUvY29tbWl0LzI1N2M2NjcyZGMxNDdlMDg4MTUyNWU0NjlhNDlkOTMz
ZjFiYzkxODMNCg0KSSB0aGluayB0aGUgY29tbWl0IG1lc3NhZ2UgbWlzbGVkIHlvdS4NCg0KQmVz
dCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IFBsZWFzZSBkbyBub3QgbWFrZSB0aGlzIGNoYW5nZS4N
Cj4NCj4gQm9iDQo=
