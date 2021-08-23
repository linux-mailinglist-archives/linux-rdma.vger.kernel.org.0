Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BE3F4317
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhHWBeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 21:34:12 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:45412 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234692AbhHWBeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Aug 2021 21:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629682410; x=1661218410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7MfImDiAmoollIgfA/T5gcyymSDRkTbCiCmdCYjI/JA=;
  b=N85dbtqDFn4ms71VQvhl4lXUEwzhz+opZdF1fLXssVny3EsNbK7FgsWW
   XeaT88/AT9NrrQBj270fvzEMydtJVRItznQzWFA7SZ6JIj22b/X05TFuk
   I5QtGF8wD0Ld1RPPZy28nUsa5ssT0yRkB3qpchnStE4jFKQ3vOm03bmx+
   P+7ueUSw+n8SfZ2A7bryjzBLDjMLEhByoDdTouJsn/KdFKgx/zVE7l8+4
   XkIHsvNYMEesWE1hNzZSN7Ee9cLMjUjRohL19D697nRavSRsoNtCLH9N2
   D/GXb/qY4sz7WGlr7Ljb2A8gn8sFehmpIzRu2UsmJNB9Z2uekMRM2ViF2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="37321471"
X-IronPort-AV: E=Sophos;i="5.84,343,1620658800"; 
   d="scan'208";a="37321471"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 10:33:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK0JF7e67wpjDJXbvqQiMMn5PjidBqbhcQ6fuc1HvPQUW30+ePkMEy1bTHvX2mPFtoAoi1Y79qNNq8Unr7t8+9Pd0yJWRzArhaWnF663hOxPGrKz8od/06B31kVXSTJfdDy3GqJ/iSoBVthlSHroo9aZyphYvQf8b+KLRfgr3y6sIXdjPU6owYlJFJTceG/0+2KIQaFdnRL/B/Sz270CZcQhvl56SsCLmaP+z7bw0G20r51OhSoiAUQRpTwZqEUrhWe7Kb6blaxI+m4QZkV/p7whqK1w7KSYS+FSlQLav9r5cXM9DDCKmJTOmeLbw+R4SX/J6lZW224UtFV9QCWXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MfImDiAmoollIgfA/T5gcyymSDRkTbCiCmdCYjI/JA=;
 b=WMGCq5OHD21mxB6lOaRLZJ5gJvT+5zkJ2CTE/PniEzJHxJkcz5HCb7XSM0g1Gmv3RTdc4Cx2vSoKQyVFAYDR4Rz5r/2VkN53DffOuHIfoIOF0WoKD4T4bQ2uC3xU7PwtNC9raoMxKUueEWXXPFpF9WfHoUWdK4SO1ofrEzxPU0mDWJQNQcnS6/fUDLyNcF2FfGRyMfhHsYpZJXfxFXowfZMhL+NoGFq8VrU6Bj8jXDGMUr7FA/LwWZhogEcItTsfTreXaM9fBLqiZ5RkEpcVS3X8eeqao06ugnNY1Tjm007GVkBvXIXdI4tKISl99LqcpM3WxG81jaiyLENt3hvSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MfImDiAmoollIgfA/T5gcyymSDRkTbCiCmdCYjI/JA=;
 b=dj2dB3r5MJADGA8TrcRLeHyIUt7+Yxht3RPkvwJ7/6foEpT3tKaNC6PHXLaoxC4cffhkesOvsfTDGVe6/Ehosnw3m+NhWdY4M+2EwTBhIQbMGbXwjH02/202A4ToBWXJTC0V6o7bjyUAhHZEmUt9fcaWG0ZTUNJp9YEzRaA5D/I=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB2917.jpnprd01.prod.outlook.com (2603:1096:604:17::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 01:33:24 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 01:33:24 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Topic: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Index: AQHXjSu/7XTFLNlnDk+JDe1qihCp9qtyBf+AgAOEzwCAAPqWgIAJ3fuA
Date:   Mon, 23 Aug 2021 01:33:24 +0000
Message-ID: <6122FAE1.4080306@fujitsu.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
 <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
In-Reply-To: <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3076f4a1-202d-44fd-b341-08d965d6000f
x-ms-traffictypediagnostic: OSBPR01MB2917:
x-microsoft-antispam-prvs: <OSBPR01MB2917461AD9CAEEEFCA319A8F83C49@OSBPR01MB2917.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4UWIqw34ByEQrVfWWDm+0wZKKe8692QPaIhEKZZey6DUGKP0D3PiPbqMlKzPjKaefhNZwzCEjT7dF1tfPb2uzXxEgHQsv9o3UorgxNXPDGPfWmr2xvri3NZdGwyh9dJ31I+cByl9p/HphohL0CUdKXgL/s7OojbuBwUgho5/ymszlbilH7UBTRMse4Yvs5RcL9uS3F7b5iTpy6DrIzJqeCxR9qy5HK0/oAd+q1xkrzVHyAky0luiUWEcV5svTHRq6Tl43jX577kTKPxKCQH4QxClCBoeDSbWV4KTlHkym8AINtjSWKCqr9omKZ4TyCJwR5FsO29LSX21a13ji4xyIGlocbFj4G/Q8EcJt0f9GeCuLOXFZfsEWfBhbWHrG3CFU0aIHJ7oOroJNsmh3FINPx887WLAAJSqsVXFlZQBCqx4CczljB6C+c4X9aS5V0Sy5Sgp4pBbC501NA6qaQTup1MXFLUp4+xLzddvpDKb8aAipXW5IG1T3FqcHkObvSwW13UCjMitz1L99E7zz8nhxp6GAqHN2V2R6a3qDplj5E762tu62JyWhin7mO09s9ORyvnuI94cOP1Zexu9JQfiKdHY2ydNJRhK+IXmhfQFwYJ35FgetheFsAV5ETSgNIFoDBtuAxkVtqtK40SwwA+pPApo5FRq+EZ2zjffeQr9pdLewxEXu0sRfnEUy+D9M0ZwVAAKvSibTI1/Yf1vZOuAOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(54906003)(66476007)(4326008)(76116006)(66556008)(66446008)(64756008)(316002)(91956017)(53546011)(87266011)(66946007)(508600001)(26005)(86362001)(5660300002)(85182001)(8936002)(6506007)(6512007)(6916009)(2616005)(36756003)(83380400001)(6486002)(33656002)(38070700005)(186003)(8676002)(2906002)(71200400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWxaNjBFdGJUMG5HVmNCKzhQcCtWbHNDd2pUaEkvLzlTUUp1bmVkVVo3RHFt?=
 =?utf-8?B?Rlg5SldnNmdZOXM3WDYrMEJ0NWFEUlpUM2Rza2lpZnVaOG5FaEsyVnNNQ3JS?=
 =?utf-8?B?UENucnd3U2M1eTFZMm9DNk5yNTBwanJIM3RNd3dCdWxZc1UyWm13NnBpRWNL?=
 =?utf-8?B?NklEc0VwcU54UUthNkVrQXpsb1ZjaGxmTyt1VEhyVFFjOEJNdGpWL1V4aFM1?=
 =?utf-8?B?TTBtN3NCRnBDOHVRbnQvNzJadGxLUFFLZS81WjNnTEpvaEdNekVIbzNKUm9D?=
 =?utf-8?B?bHlvMWl2c1ZyR3hXUWZxUTVhZ1o1OWJwdTJoenJud0VWM0VYSkk5NlYvMFhL?=
 =?utf-8?B?OW02OUtYd3h5Y0ljU3oyRTBGKzNWVDV6MXc5VmpTRG5EK3NHT3VoZHg3Z2gv?=
 =?utf-8?B?dW12VUloQ080SkoxZDJSN2FzdFVFeHZ3dG9tbnhZMENsa0NKamRpbCsvM1Jy?=
 =?utf-8?B?eG1zV29hNUpkOVlEdEhaQ3JmZGdFUmJpYVNkS1VDdnRlc1RzcDE1SDZLSFhU?=
 =?utf-8?B?S3RsMCt0ZE8rTk9QNGRjaFQvWWk2U2JXMlp3OUtPSFNPcHo3SFFPbFZibFhW?=
 =?utf-8?B?RU9ELzUyUDI3MFJuQ0lmeG5hRWx4WE1aUFl4YXpaT1pYb3JPU1YrdXJ3bXpz?=
 =?utf-8?B?Unh3bWlGeC8yTTIweGJYR0ZXR29ZL1FlWWdYK29kdHpWLzJTenJjaFlVNER2?=
 =?utf-8?B?WjI2RVY5a3FjYzFOdWt1Q1JSTVlORmJKRHZ5Y2pveXRtc1dISGdDRGdQS3hx?=
 =?utf-8?B?WEllZEZYelFiUERsNTUvK281bzJmNjV3Rm9XcXFYdXZaTFZPOGI2U3Arak9L?=
 =?utf-8?B?VmZYWWtXVzVhY0pJWTdLN0I3UHM5dFF6RjFoejBmdGl1eHkycEY4UHNuTW9z?=
 =?utf-8?B?RHF4VVZSVWZmSkFiZ1NCc2tHQW5rWElOTlFEekI1VTh0N3FKa3dCclV4TE9J?=
 =?utf-8?B?TnhRZU5Rdk5TNVduNFZiV21DOFpFM1N4dU9mTEhWckVIb3F0RS9Bc0JSRGhE?=
 =?utf-8?B?MWlidDhhamtWNExPVzVpQ21JRFo5V0VmZFo2S043Qi9UaS9OVGpZRkxwampF?=
 =?utf-8?B?UXA1UFpxNW53VVUzYUJZN0p3eXVBRDJCSy9aOFhGOWcxV3dOZmJYZmFVTUdn?=
 =?utf-8?B?R1RqRWRpUmMyRGdYNG05VVR5ZjNGSUsyVmkvYzBURDlXd2pUdEdPQmFhUyt6?=
 =?utf-8?B?U0d5V1RCbzhvWExXaklORVYrWVpxbytsOWU5MUF1c2pSQVBVQVNYQWFoWVAr?=
 =?utf-8?B?TTBzUGlZL2psdWpqYlVMY29TcWdaZUU4a0lDczY2NXRlM3VDcHRQMFA5SnRl?=
 =?utf-8?B?WnZLeHlJSEhLTFZ3NUFpWmVpSzZiaVZrL3RaZUZhQ0IyOU0wT1NzbFNrdnI2?=
 =?utf-8?B?enBib0dRMU1QbndqbGFhcGh3S0Q3SmVWcmV1QnI1cnhiK0dxOHFZTUxyVHN1?=
 =?utf-8?B?S1YzdW1PY3Y3VmF4TXdvUVFSK3ZML2xraXFsVUJ2V0ZIL3IzRUFmTzh2SndB?=
 =?utf-8?B?Tk1HeFFkVUo1WFFIZXYzci9oa01VUU13VEUxUWFONCtmU0p3akZaOWVxbEh1?=
 =?utf-8?B?SFZsNWM1bHlROHZuU0xqb3lmcUhwT2JnVFlObEZvVUhucUtINVZZWjcvMEMw?=
 =?utf-8?B?MVdXT09qUXBvM015QmFjSXlLZnREZ3daSHhEYXlLT3N5aG51bUdPeERhZy9L?=
 =?utf-8?B?WFFxUkJPOE9wQmIvM3ZQcHBQcnQwMkZ5UmVvMi90OGI2LzU1aU04RUJpMDZt?=
 =?utf-8?Q?nFY86lLhs0mWA4Yneijc24wrN8pxTroP4lexaFg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BB070E262EC9B40A8548F5C9B846DB1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3076f4a1-202d-44fd-b341-08d965d6000f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 01:33:24.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhS/KEBpai91aLJMdDOoFw74f0C2NMk1iZ++JOF6NjsiPvrVreesoKJ6D36yiSISkYQLBCJFHS0pkDFWOobexA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2917
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgTGVvbiwNCg0KQ291bGQgeW91IHJldmlldyB0aGUgcGF0Y2g/DQoNCkJlc3QgUmVnYXJkcywN
ClhpYW8gWWFuZw0KT24gMjAyMS84LzE3IDI6NTIsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA4
LzE1LzIxIDEwOjU1IFBNLCBaaHUgWWFuanVuIHdyb3RlOg0KPj4gT24gU2F0LCBBdWcgMTQsIDIw
MjEgYXQgNjoxMSBBTSBCb2IgUGVhcnNvbjxycGVhcnNvbmhwZUBnbWFpbC5jb20+ICB3cm90ZToN
Cj4+PiBPbiA4LzkvMjEgMTA6MDcgQU0sIFhpYW8gWWFuZyB3cm90ZToNCj4+Pj4gUmVzaWQgaW5k
aWNhdGVzIHRoZSByZXNpZHVhbCBsZW5ndGggb2YgdHJhbnNtaXR0ZWQgYnl0ZXMgYnV0IGN1cnJl
bnQNCj4+Pj4gcnhlIHNldHMgaXQgdG8gemVybyBmb3IgaW5saW5lIGRhdGEgYXQgdGhlIGJlZ2lu
bmluZy4gIEluIHRoaXMgY2FzZSwNCj4+Pj4gcmVxdWVzdCB3aWxsIHRyYW5zbWl0IHplcm8gYnl0
ZSB0byByZXNwb25kZXIgd3JvbmdseS4NCj4+Pj4NCj4+Pj4gUmVzaWQgc2hvdWxkIGJlIHNldCB0
byB0aGUgdG90YWwgbGVuZ3RoIG9mIHRyYW5zbWl0dGVkIGJ5dGVzIGF0IHRoZQ0KPj4+PiBiZWdp
bm5pbmcuDQo+Pj4+DQo+Pj4+IE5vdGU6DQo+Pj4+IEp1c3QgcmVtb3ZlIHRoZSB1c2VsZXNzIHNl
dHRpbmcgb2YgcmVzaWQgaW4gaW5pdF9zZW5kX3dxZSgpLg0KPj4+Pg0KPj4+PiBGaXhlczogMWE4
OTRjYTEwMTA1ICgiUHJvdmlkZXJzL3J4ZTogSW1wbGVtZW50IGlidl9jcmVhdGVfcXBfZXggdmVy
YiIpDQo+Pj4+IEZpeGVzOiA4MzM3ZGI1ZGYxMjUgKCJQcm92aWRlcnMvcnhlOiBJbXBsZW1lbnQg
bWVtb3J5IHdpbmRvd3MiKQ0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmc8eWFuZ3guanlA
ZnVqaXRzdS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgIHByb3ZpZGVycy9yeGUvcnhlLmMgfCA1ICsr
LS0tDQo+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3Byb3ZpZGVycy9yeGUvcnhlLmMgYi9wcm92aWRl
cnMvcnhlL3J4ZS5jDQo+Pj4+IGluZGV4IDNjM2VhOGJiLi4zNTMzYTMyNSAxMDA2NDQNCj4+Pj4g
LS0tIGEvcHJvdmlkZXJzL3J4ZS9yeGUuYw0KPj4+PiArKysgYi9wcm92aWRlcnMvcnhlL3J4ZS5j
DQo+Pj4+IEBAIC0xMDA0LDcgKzEwMDQsNyBAQCBzdGF0aWMgdm9pZCB3cl9zZXRfaW5saW5lX2Rh
dGEoc3RydWN0IGlidl9xcF9leCAqaWJxcCwgdm9pZCAqYWRkciwNCj4+Pj4NCj4+Pj4gICAgICAg
IG1lbWNweSh3cWUtPmRtYS5pbmxpbmVfZGF0YSwgYWRkciwgbGVuZ3RoKTsNCj4+Pj4gICAgICAg
IHdxZS0+ZG1hLmxlbmd0aCA9IGxlbmd0aDsNCj4+Pj4gLSAgICAgd3FlLT5kbWEucmVzaWQgPSAw
Ow0KPj4+PiArICAgICB3cWUtPmRtYS5yZXNpZCA9IGxlbmd0aDsNCj4+Pj4gICB9DQo+Pj4+DQo+
Pj4+ICAgc3RhdGljIHZvaWQgd3Jfc2V0X2lubGluZV9kYXRhX2xpc3Qoc3RydWN0IGlidl9xcF9l
eCAqaWJxcCwgc2l6ZV90IG51bV9idWYsDQo+Pj4+IEBAIC0xMDM1LDYgKzEwMzUsNyBAQCBzdGF0
aWMgdm9pZCB3cl9zZXRfaW5saW5lX2RhdGFfbGlzdChzdHJ1Y3QgaWJ2X3FwX2V4ICppYnFwLCBz
aXplX3QgbnVtX2J1ZiwNCj4+Pj4gICAgICAgIH0NCj4+Pj4NCj4+Pj4gICAgICAgIHdxZS0+ZG1h
Lmxlbmd0aCA9IHRvdF9sZW5ndGg7DQo+Pj4+ICsgICAgIHdxZS0+ZG1hLnJlc2lkID0gdG90X2xl
bmd0aDsNCj4+Pj4gICB9DQo+Pj4+DQo+Pj4+ICAgc3RhdGljIHZvaWQgd3Jfc2V0X3NnZShzdHJ1
Y3QgaWJ2X3FwX2V4ICppYnFwLCB1aW50MzJfdCBsa2V5LCB1aW50NjRfdCBhZGRyLA0KPj4+PiBA
QCAtMTQ3Myw4ICsxNDc0LDYgQEAgc3RhdGljIGludCBpbml0X3NlbmRfd3FlKHN0cnVjdCByeGVf
cXAgKnFwLCBzdHJ1Y3QgcnhlX3dxICpzcSwNCj4+Pj4gICAgICAgIGlmIChpYndyLT5zZW5kX2Zs
YWdzJiAgSUJWX1NFTkRfSU5MSU5FKSB7DQo+Pj4+ICAgICAgICAgICAgICAgIHVpbnQ4X3QgKmlu
bGluZV9kYXRhID0gd3FlLT5kbWEuaW5saW5lX2RhdGE7DQo+Pj4+DQo+Pj4+IC0gICAgICAgICAg
ICAgd3FlLT5kbWEucmVzaWQgPSAwOw0KPj4+PiAtDQo+Pj4+ICAgICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGk8ICBudW1fc2dlOyBpKyspIHsNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICBt
ZW1jcHkoaW5saW5lX2RhdGEsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1
aW50OF90ICopKGxvbmcpaWJ3ci0+c2dfbGlzdFtpXS5hZGRyLA0KPj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEJvYiBQZWFyc29uPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4+IFRoZSBTaWduZWQt
b2ZmLWJ5OiB0YWcgaW5kaWNhdGVzIHRoYXQgdGhlIHNpZ25lciB3YXMgaW52b2x2ZWQgaW4gdGhl
DQo+PiBkZXZlbG9wbWVudCBvZiB0aGUgcGF0Y2gsIG9yIHRoYXQgaGUvc2hlIHdhcyBpbiB0aGUg
cGF0Y2jigJlzIGRlbGl2ZXJ5DQo+PiBwYXRoLg0KPj4NCj4+IFpodSBZYW5qdW4NCj4+DQo+IFNv
cnJ5LCBteSBtaXN1bmRlcnN0YW5kaW5nLiBUaGVuIEkgd2FudCB0byBzYXkNCj4NCj4gUmV2aWV3
ZWQtYnk6IEJvYiBQZWFyc29uPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4NCj4gVGhlIHBhdGNo
IGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo=
