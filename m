Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D94165404
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 02:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBTBEu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 20:04:50 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:56450
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbgBTBEu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 20:04:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI1J3Yd6xOfolARr7R2bBTD06sFcdnCqJy1ThXO4hgY/znY0Uof3xlTuBqmHnAM8kawdCsZXH//jtRPUQU2YA37h5L0mMkm+Z6VZBh+mO3klJ5ar5J9gtwhukn66pA3d2BWsY4gYqxzzFSxWCWmM4xskvUGR474k1w/TfGF1pD5DLYRYSuT45J+HHCxz0N5tsNVe7NvWNRZQZmWsX1jj0dWNY9e5tBjvmFcrYNpwhjEmAvjDt2xaKCS3n6Kp6asRUmcxBZf4J4Ax0j3S3w9/1nuQkYA0OJ1p/Qw5InSGT4cQ4m6ctakQb0dp/kEcyYpXDMsw2tmx4dFPkRjPNV958w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvG+3kTEHjEm7qgP5MUeJbWHgboHiTJqhSB5RRcr1SE=;
 b=M7GVZDjKiCUe+lcPfdj6kp6RLVL1wyR3MTO7SzSyQtfCtUXK1jiDyE0c2fUn0KB4jqsT0gVYKUiGYs66lew3DeAJonwMJDjEbnv0SBPj/n4TTGTKEU4IbukuIx+eOXGY39z8BJsK1CHM9jFyQ1eAAWAhoIKy3gORwvFdNN/n756icJ86ey/SbE6PzRa8GeZB+dhEr+1JQqLSt5kxDeZ9o0DEFu4z+Wo+4ieD2tlboCX/z/heg1Pqvp2MmYNCWcGaFzYsVj5vf4iNdyOJcPipk4RCOfw4QCTTJvdxi/ilpoCU2TUyU0ivXYEqQwRu9FGdPOQQeAtRKDXYl82lOegdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvG+3kTEHjEm7qgP5MUeJbWHgboHiTJqhSB5RRcr1SE=;
 b=Xqvd5/6k6rwfHMBVLwKWu42nfH2eR13UzxHliCZowKXN3GymTVZekV+QT+dgTfYLHvWxGAGcXXEyUjdHavqztP1/qhm57w6fVPykZSmElvSS+fcCFkwkmAozq6pUCxo+VvUTnY1azditiTp/4+rzSjDCphbX5iYVvP1nlsXLreU=
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB4264.eurprd05.prod.outlook.com (52.135.161.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 01:04:47 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::11fc:7536:f265:7920]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::11fc:7536:f265:7920%3]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 01:04:47 +0000
Received: from [192.168.0.144] (115.198.49.252) by SG2PR06CA0094.apcprd06.prod.outlook.com (2603:1096:3:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 01:04:44 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Thread-Topic: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Thread-Index: AQHVxi+sI3U58iyGGkK67hYzlpOeV6gOZEYAgAAF34CAAAsFgIACyyEAgAaq6ICAAULnAIAASVuAgAAEMgCAAXyxgIABDUSAgAU6DYCAADlJgIAAiNCAgAAC+ICAAAE8AIAAuGOAgABNBYCAAHuzgA==
Date:   Thu, 20 Feb 2020 01:04:47 +0000
Message-ID: <c4fc4449-94ed-805e-76d1-6ce856a4fc05@mellanox.com>
References: <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
 <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
 <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com>
 <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
 <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
 <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com>
 <20200219130613.GM31668@ziepe.ca>
 <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com>
In-Reply-To: <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0094.apcprd06.prod.outlook.com
 (2603:1096:3:14::20) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.198.49.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 538bfa23-7ab8-4a1e-a3ce-08d7b5a0e0c8
x-ms-traffictypediagnostic: AM6PR05MB4264:|AM6PR05MB4264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB4264A1F0282AB4C271033D24CA130@AM6PR05MB4264.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(8936002)(2906002)(26005)(16526019)(186003)(956004)(66946007)(478600001)(71200400001)(2616005)(53546011)(6486002)(4326008)(5660300002)(110136005)(16576012)(54906003)(31686004)(8676002)(316002)(81166006)(86362001)(66446008)(31696002)(64756008)(66556008)(52116002)(66476007)(107886003)(36756003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4264;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQ4vxZmVHVP0Gf8YDWy9ch8YDE1U69cTo9qrPyFftKH6yXvaQjNB2XUkwE6NZtX8Nclt8bV3YOjjxTNOnm3dQhVbLu5e5VTKTCPUXFMxi84RUHYOi2D92ZPYg9F33qTfLnWZoUuxZ3K2RI64uf+l9+fbpLdRK/cBiLy/isj7ytLQVPmf3rEmSRsLsE21JU+iOtGvU5PQAt/7Ts3WnZ76WHGrcEVUZjuQ5uF2DNqSSIxChdRXlLHrjO9OfyQS7zxcBhTVYwMAgLRKLXfoVVufoRcHCRGvE9Ky5qVXQvMn8nxdc6cuhi07BQ3a+UzQ5QaC5NsvldHrywAblj11sFGNENePtmTUKXMTZ+sjT626D4YMGNS2tnR0Q9iyBNuKkPhpCHc/mSbA7GTlVVx0Hlizb5ziNziSNS4WuHU0Fa1bfZADUKps/xJz56f7V4nF6WLa
x-ms-exchange-antispam-messagedata: 4+vCsQ4L2DbyozKf0y6ZQUoQY2JZZ994T7iYcXjveb8xP8eE6R8a77KpQ7CfOuFYM6cRL1Zvh532kXkysHHjbSDEjxu1qdBWQ1iXPkpjn6iWHi6UE6o7zzfhQoQcl7gsoRYCCWyn+mdDeAZF3h5iRw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A8E95DE9BBFDD419CCFC28E48201BA0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538bfa23-7ab8-4a1e-a3ce-08d7b5a0e0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 01:04:47.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ju2VsxrvJ57Y+duVb4+pbG5vVyH+3/U4/sWEkm1CnEXTEepqsALTg7lH1u4TQxld+zqHgvFIN8nB3mOwFDjB+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4264
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8yMC8yMDIwIDE6NDEgQU0sIFRvbSBUYWxwZXkgd3JvdGU6DQo+IE9uIDIvMTkvMjAyMCA4
OjA2IEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBPbiBXZWQsIEZlYiAxOSwgMjAyMCBh
dCAwMjowNjoyOEFNICswMDAwLCBNYXJrIFpoYW5nIHdyb3RlOg0KPj4+IFRoZSBzeW1tZXRyeSBp
cyBpbXBvcnRhbnQgd2hlbiBjYWxjdWxhdGUgZmxvd19sYWJlbCB3aXRoIERzdFFQbi9TcmNRUG4N
Cj4+PiBmb3Igbm9uLVJETUEgQ00gU2VydmljZSBJRCAoY2hlY2sgdGhlIGZpcnN0IG1haWwpLCBz
byB0aGF0IHRoZSBzZXJ2ZXINCj4+PiBhbmQgY2xpZW50IHdpbGwgaGF2ZSBzYW1lIGZsb3dfbGFi
ZWwgYW5kIHVkcF9zcG9ydC4gQnV0IGxvb2tzIGxpa2UgaXQgaXMNCj4+PiBub3QgaW1wb3J0YW50
IGluIHRoaXMgY2FzZS4NCj4+DQo+PiBJZiB0aGUgYXBwbGljYXRpb24gbmVlZHMgYSBjZXJ0YWlu
IGZsb3cgbGFiZWwgaXQgc2hvdWxkIG5vdCByZWx5IG9uDQo+PiBhdXRvLWdlbmVyYXRpb24sIElN
SE8uDQo+Pg0KPj4gSSBleHBlY3QgbW9zdCBuZXR3b3JrcyB3aWxsIG5vdCBiZSByZXZlcnNpYmxl
IGFueWhvdywgZXZlbiB3aXRoIHRoZQ0KPj4gc2FtZSBmbG93IGxhYmVsPw0KPiANCj4gVGhlc2Ug
YXJlIG5ldHdvcmsgZmxvdyBsYWJlbHMsIG5vdCB1bmRlciBhcHBsaWNhdGlvbiBjb250cm9sLiBJ
ZiB0aGV5DQo+IGFyZSB1bmRlciBhcHBsaWNhdGlvbiBjb250cm9sLCB0aGF0J3MgYSBzZWN1cml0
eSBpc3N1ZS4NCj4gDQoNCkFzIEphc29uIHNhaWQgYXBwbGljYXRpb24gaXMgYWJsZSB0byBjb250
cm9sIGl0IGluIGlwdjYuIEJlc2lkZXMgDQphcHBsaWNhdGlvbiBpcyBhbHNvIGFibGUgdG8gY29u
dHJvbCBpdCBmb3Igbm9uLVJETUEgQ00gU2VydmljZSBJRCBpbiBpcHY0Lg0KDQpIaSBKYXNvbiwg
c2FtZSBmbG93IGxhYmVsIGdldCBzYW1lIFVEUCBzb3VyY2UgcG9ydCwgd2l0aCBzYW1lIFVEUCBz
b3VyY2UgDQpwb3J0IChhbG9uZyB3aXRoIHNhbWUgc0lQL2RJUC9zUG9ydCksIGFyZSBuZXR3b3Jr
cyByZXZlcnNpYmxlPw0KDQo+IEJ1dCBJIGFncmVlLCBpZiB0aGUgc3ltbWV0cmljIGJlaGF2aW9y
IGlzIG5vdCBuZWVkZWQsIGl0IHNob3VsZCBiZQ0KPiBpZ25vcmVkIGFuZCBhIGJldHRlciAobW9y
ZSB1bmlmb3JtbHkgZGlzdHJpYnV0ZWQpIGhhc2ggc2hvdWxkIGJlIGNob3Nlbi4NCj4gDQo+IEkg
ZGVmaW5pdGVseSBsaWtlIHRoZSBzaW1wbGljaXR5IGFuZCBwZXJmZWN0IGZsYXRuZXNzIG9mIHRo
ZSBuZXdseQ0KPiBwcm9wb3NlZCAoc3JjICogMzEpICsgZHN0LiBCdXQgdGhhdCAiMzEiIGNhdXNl
cyBvdmVyZmxvdyBpbnRvIGJpdCAyMSwNCj4gZG9lc24ndCBpdD8gKDMxICogMHhmZmZmID09IDB4
MWYwMDAwKSA+DQoNCkkgdGhpbmsgb3ZlcmZsb3cgZG9lc24ndCBtYXR0ZXI/IFdlIGhhdmUgb3Zl
cmZsb3cgYW55d2F5IGlmIA0KbXVsdGlwbGljYXRpdmUgaXMgdXNlZC4NCg0KPiBUb20uDQoNCg==
