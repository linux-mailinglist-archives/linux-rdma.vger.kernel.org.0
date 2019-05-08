Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFF17EE3
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfEHRJZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 13:09:25 -0400
Received: from mail-eopbgr800077.outbound.protection.outlook.com ([40.107.80.77]:38249
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfEHRJZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 13:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzHj6yAm/9SUAeWs+VIvWmfwbaAbJpT7PM9F+oiTGKs=;
 b=H561y2QIAguCaEt/ibtwXTav5ZqeLPfxvnWaQnRp5bCysifTfmOoumHKE9IS4pzzMFi1oxoHQI4huKhWWw86PAQ2jf9rTL63yTyxwIVdEcQ7KWR+u1/6de7FyM09WAM0jhL3F/odowJq8gPvYErRqtLsgjto96KmhVCZEi+wcMQ=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5302.namprd05.prod.outlook.com (20.177.127.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.19; Wed, 8 May 2019 17:09:21 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5%7]) with mapi id 15.20.1878.019; Wed, 8 May 2019
 17:09:21 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Majd Dibbiny <majd@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Topic: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Index: AQHVBa8P7sT7OcWZz0ayaa05hY/AV6ZhdiUA
Date:   Wed, 8 May 2019 17:09:21 +0000
Message-ID: <3f761b35-586f-91ca-eafe-e2aefa33df58@vmware.com>
References: <20190507051537.2161-1-aditr@vmware.com>
 <20190507125259.GT6186@mellanox.com>
 <266697af-bf5e-07a1-489e-fed7cf8c695a@vmware.com>
 <20190508143133.GG32297@mellanox.com>
 <ED61DBC4-5762-47C8-89D5-89FAE763F915@mellanox.com>
In-Reply-To: <ED61DBC4-5762-47C8-89D5-89FAE763F915@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::21) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1afd3dce-86bf-4f3e-7dfa-08d6d3d7e9b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5302;
x-ms-traffictypediagnostic: BYAPR05MB5302:
x-microsoft-antispam-prvs: <BYAPR05MB5302DC83F2C695F8635DB237C5320@BYAPR05MB5302.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(316002)(71190400001)(31686004)(71200400001)(478600001)(8676002)(256004)(81166006)(14454004)(5660300002)(229853002)(3846002)(6116002)(4326008)(102836004)(66446008)(186003)(68736007)(6246003)(26005)(66066001)(476003)(2616005)(36756003)(81156014)(11346002)(53936002)(99286004)(305945005)(486006)(8936002)(446003)(7736002)(110136005)(31696002)(54906003)(76176011)(6436002)(6486002)(25786009)(66476007)(66946007)(2906002)(66556008)(73956011)(52116002)(6512007)(386003)(6506007)(53546011)(64756008)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5302;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CD5wQlji2IgktWnBCjM28XnMTG2gpl1wsBiDmDlaZJF70DQACzBcHcQPeXcqpDOmvU/u/qIBx+eUDcJbeQF+E8pUyzmmNqVm9YDoKCZPC8rZLLopOUmys14STGoAaKHumLtWHBnFDy6snGYc9saymblEMqNPYMWZnuAl816ceR8lKszxG77q4gR5nVHBEAHqbhsSRSY/ePFHlctZvZvv5Jh0js2KSvvh/bC+SDae4p0XWGl9rHI8rl6G1wpXcBhKdsBUGIQNdhCtcdJfIXhuEF3x3/VCDefLU8urR9UcVFibRSBRhjk0pfkZl2PLrOYYMmJs5ZTBAguPjNNw7a25JZoR+7XfWzEJRba+Izt3X34rDPK8+Eqinu6QRFUt34aH+nUg0xaE9eh9av/WElLoajog2Z0I8JE1bdmAolpnwDU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81F3ED98154B1F4697956C5A7C9F044A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afd3dce-86bf-4f3e-7dfa-08d6d3d7e9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 17:09:21.4141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5302
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNS84LzE5IDg6MDIgQU0sIE1hamQgRGliYmlueSB3cm90ZToNCj4gDQo+PiBPbiBNYXkgOCwg
MjAxOSwgYXQgNTozMSBQTSwgSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPiB3cm90
ZToNCj4+DQo+PiBPbiBUdWUsIE1heSAwNywgMjAxOSBhdCAwNTo1NToyNVBNICswMDAwLCBBZGl0
IFJhbmFkaXZlIHdyb3RlOg0KPj4+Pj4gLy8gQ29uZmlndXJhdGlvbiBkZWZhdWx0cw0KPj4+Pj4N
Cj4+Pj4+ICNkZWZpbmUgSUJBQ01fU0VSVkVSX01PREVfVU5JWCAwDQo+Pj4+PiBkaWZmIC0tZ2l0
IGEvbGliaWJ2ZXJicy92ZXJicy5jIGIvbGliaWJ2ZXJicy92ZXJicy5jDQo+Pj4+PiBpbmRleCAx
NzY2YjlmNTJkMzEuLjJjYWI4NjE4NGUzMiAxMDA2NDQNCj4+Pj4+ICsrKyBiL2xpYmlidmVyYnMv
dmVyYnMuYw0KPj4+Pj4gQEAgLTk2Nyw3ICs5NjcsNiBAQCBzdGF0aWMgaW5saW5lIGludCBjcmVh
dGVfcGVlcl9mcm9tX2dpZChpbnQgZmFtaWx5LCB2b2lkICpyYXdfZ2lkLA0KPj4+Pj4gICAgcmV0
dXJuIDA7DQo+Pj4+PiB9DQo+Pj4+Pg0KPj4+Pj4gLSNkZWZpbmUgTkVJR0hfR0VUX0RFRkFVTFRf
VElNRU9VVF9NUyAzMDAwDQo+Pj4+PiBpbnQgaWJ2X3Jlc29sdmVfZXRoX2wyX2Zyb21fZ2lkKHN0
cnVjdCBpYnZfY29udGV4dCAqY29udGV4dCwNCj4+Pj4+ICAgICAgICAgICAgICAgIHN0cnVjdCBp
YnZfYWhfYXR0ciAqYXR0ciwNCj4+Pj4+ICAgICAgICAgICAgICAgIHVpbnQ4X3QgZXRoX21hY1tF
VEhFUk5FVF9MTF9TSVpFXSwNCj4+Pj4NCj4+Pj4gUmVhbGx5IGNvbXBpbGUgdGltZSBjb25maWd1
cmF0aW9ucyBhcmUgbm90IHNvIHVzZWZ1bCwgd2hhdCBpcyB0aGUgdXNlDQo+Pj4+IGNhc2UgaGVy
ZT8gDQo+Pj4+DQo+Pj4NCj4+PiBJbiB0aGUgZ2VuZXJhbCBzZW5zZSBJIGFncmVlIHdpdGggeW91
LiBQcmUtYnVpbHQgUlBNcyBtYXkgbm90IGhhdmUgdGhpcw0KPj4+IHNldCB0byBhbnl0aGluZyBv
dGhlciB0aGFuIHRoZSBkZWZhdWx0IHZhbHVlLiANCj4+PiBIb3dldmVyLCBpbiBvdXIgaW50ZXJu
YWwgdGVzdGluZyB3ZSd2ZSBzZWVuIHRpbWVvdXRzIHdoZW4gdHJ5aW5nIHRvDQo+Pj4gcmVzb2x2
ZSB0aGUgRE1BQyB3aGVuIGNyZWF0aW5nIGFuIEFILg0KPiBZb3UgY2FuIGRvIHRoaXMgdXNpbmcg
dXZlcmJzIGluc3RlYWQgb2YgbmV0bGluayBieSBjaGFuZ2luZyB0aGUgY3JlYXRlX2FoIHByb3Zp
ZGVy4oCZcyBpbXBsZW1lbnRhdGlvbi4uIGFuZCBBRkFJUiBpdOKAmXMgbW9yZSBzY2FsYWJsZSB0
aGFuIG5ldGxpbmsuLg0KDQpUaGFua3MgTWFqaWQhIFdlIHdpbGwgbW9zdGx5IGdvIGRvd24gdGhh
dCByb3V0ZSBsYXRlciBidXQgaW4gdGhlIGZhbGxiYWNrDQpjYXNlIHdlIHdpbGwgc3RpbGwgbmVl
ZCB0byB0aGUgTDIgbG9va3VwIGZ1bmN0aW9uLi4uDQoNCj4+PiBJbnN0ZWFkLCBvZiBzaW1wbHkg
aW5jcmVhc2luZw0KPj4+IHRoZSAjZGVmaW5lIHZhbHVlIGhlcmUgSSB0aG91Z2h0IGl0IHdvdWxk
IGJlIG1pbGRseSBoZWxwZnVsIHRvIGV4cG9zZSANCj4+PiB0aGlzIG91dC4NCj4+Pg0KPj4+IElm
IHRoaXMgaXMgbm90IGdvaW5nIHRvIGJlIHVzZWZ1bCBJIGNhbiBkcm9wIGl0IGJ1dCBJIHRob3Vn
aHQgaXQgd291bGQgDQo+Pj4gYXRsZWFzdCBtYWtlIHJkbWEtY29yZSBhIGJpdCBtb3JlIGNvbmZp
Z3VyYWJsZS4uDQo+Pg0KPj4gU3R1ZmYgbGlrZSB0aGlzIHNob3VsZCBub3QgYmUgY29uZmlndXJl
ZC4uIGlmIHlvdSBhcmUgaGl0dGluZyB0aW1lb3V0DQo+PiBpdCBzb3VuZHMgbGlrZSBhIGJ1ZyBv
ZiBzb21lIHNvcnQgdG8gbWUuDQo+Pg0KPj4gSmFzb24NCg0K
