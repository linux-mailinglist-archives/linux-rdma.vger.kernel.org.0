Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D99169A8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEGR4J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 13:56:09 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:30816
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfEGR4I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 13:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhcyZNZf2B/jGDyJLEhWi8HcOgZPU6ru/D1FPyudhQA=;
 b=R7PHfwVjAdXWtDivkdUDoXfoMFLU03OTyipXiUAW1+oBAedaE2zogUovAp+wn8NCNF+JKjaUmkMEeklluTn5OYCjjOMl2MAnnLy5xp8l/2fUqMAGccl6JRee7FES6cfSiRHBJHSGii61DYaFR45/C/VrHJ9I/jpHqhu+Lr/olQ8=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB6487.namprd05.prod.outlook.com (20.178.233.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.19; Tue, 7 May 2019 17:55:25 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5%7]) with mapi id 15.20.1878.019; Tue, 7 May 2019
 17:55:25 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Topic: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Index: AQHVBJQ03rON3H5UMUmK3O/KPKwCrqZfnnCAgABUfYA=
Date:   Tue, 7 May 2019 17:55:25 +0000
Message-ID: <266697af-bf5e-07a1-489e-fed7cf8c695a@vmware.com>
References: <20190507051537.2161-1-aditr@vmware.com>
 <20190507125259.GT6186@mellanox.com>
In-Reply-To: <20190507125259.GT6186@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:a03:100::18) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeda93b9-e4c2-4552-bb3f-08d6d3152ed6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6487;
x-ms-traffictypediagnostic: BYAPR05MB6487:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB64878C2B8DD1B9E6BABBFBA7C5310@BYAPR05MB6487.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(86362001)(486006)(11346002)(446003)(14454004)(31696002)(966005)(316002)(66066001)(66446008)(71190400001)(71200400001)(476003)(2616005)(8936002)(73956011)(66946007)(66476007)(64756008)(66556008)(229853002)(54906003)(31686004)(36756003)(6306002)(6486002)(6512007)(76176011)(99286004)(52116002)(6436002)(256004)(14444005)(68736007)(53546011)(6506007)(102836004)(25786009)(2906002)(4326008)(386003)(26005)(8676002)(81156014)(81166006)(186003)(6916009)(305945005)(7736002)(3846002)(6116002)(478600001)(6246003)(5660300002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6487;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AhCxwkpWot5YlDOqcpm5ddVTCdSzyu692x+u3rsA7R41uHKKgCkZnVZrCFhCjclZcJaOKBzZZsrZVqOi+HrFkdgs0bo5Fk0al4rUkl5nH7E6oub2E0Z/+feIfeRm49HA5hzgg+ORKzqMkKoUN75BqDjS/MqHMmCXwEgIJuEzku7mYgD7IjwMThS81bHUfcanK2nwVqBlcE3+P0rlU9ov3NtsKdMRCjidwlbjGt8fFNQMBsOACZr6MDZXbwqVoh7/HO4ccMUiqZ62SdcVZ/q9qrs44EHNSiEszRGtuzCE7aipT9z8+Jpv17Cju4WoZMyejTp9mx0zJKu4g16GUn9jdMongNNz3sRkXSoFyM2Otsodb4iLvm/oQgSJbZATx6eKhqoTtshulT0ERm6h00rv8G33Sj2t264J3cJc39zBHlI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AFE46E624CF7840A11289C8D3183E4B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeda93b9-e4c2-4552-bb3f-08d6d3152ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 17:55:25.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6487
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNS83LzE5IDU6NTMgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVlLCBNYXkg
MDcsIDIwMTkgYXQgMDU6MTc6NDVBTSArMDAwMCwgQWRpdCBSYW5hZGl2ZSB3cm90ZToNCj4+IFRo
aXMgYWxsb3dzIHRoZSBuZWlnaGJvciB0aW1lb3V0IHRvIGJlIGNvbmZpZ3VyZWQgd2hpbGUgYnVp
bGRpbmcNCj4+IHJkbWEtY29yZSB1c2luZyB0aGUgZXh0cmEgY21ha2UgZmxhZ3MuDQo+Pg0KPj4g
UmV2aWV3ZWQtYnk6IEpvcmdlbiBIYW5zZW4gPGpoYW5zZW5Adm13YXJlLmNvbT4NCj4+IFJldmll
d2VkLWJ5OiBWaXNobnUgRGFzYSA8dmRhc2FAdm13YXJlLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IEFkaXQgUmFuYWRpdmUgPGFkaXRyQHZtd2FyZS5jb20+DQo+PiAtLS0NCj4+ICBDTWFrZUxpc3Rz
LnR4dCAgICAgICB8IDYgKysrKysrDQo+PiAgYnVpbGRsaWIvY29uZmlnLmguaW4gfCAyICsrDQo+
PiAgbGliaWJ2ZXJicy92ZXJicy5jICAgfCAxIC0NCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gLS0tDQo+Pg0KPj4gSGVyZSBpcyB0aGUgUFI6
DQo+PiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvcHVsbC81MjQNCj4+
DQo+PiAtLS0NCj4+IGRpZmYgLS1naXQgYS9DTWFrZUxpc3RzLnR4dCBiL0NNYWtlTGlzdHMudHh0
DQo+PiBpbmRleCBiZWI4ZjRlYzEyMzguLjhkYmRkMmI4MDdmNCAxMDA2NDQNCj4+IC0tLSBhL0NN
YWtlTGlzdHMudHh0DQo+PiArKysgYi9DTWFrZUxpc3RzLnR4dA0KPj4gQEAgLTQ1LDYgKzQ1LDgg
QEANCj4+ICAjICAgLUROT19QWVZFUkJTPTEgKGRlZmF1bHQsIGJ1aWxkIHB5dmVyYnMpDQo+PiAg
IyAgICAgIEludm9rZSBjeXRob24gdG8gYnVpbGQgcHl2ZXJicy4gVXN1YWxseSB5b3Ugd2lsbCBy
dW4gd2l0aCB0aGlzIG9wdGlvbg0KPj4gICMgICAgICBpcyBzZXQsIGJ1dCBpdCB3aWxsIGJlIGRp
c2FibGVkIGZvciB0cmF2aXMgcnVucy4NCj4+ICsjICAgLURORUlHSF9HRVRfREVGQVVMVF9USU1F
T1VUX01TPTMwMDAgKGRlZmF1bHQpDQo+PiArIyAgICAgIFNldCB0aGUgZGVmYXVsdCB0aW1lb3V0
IGZvciBsb29rdXAgb2YgbmVpZ2hib3IgZm9yIG1hYyBhZGRyZXNzLg0KPj4gIA0KPj4gIGNtYWtl
X21pbmltdW1fcmVxdWlyZWQoVkVSU0lPTiAyLjguMTEgRkFUQUxfRVJST1IpDQo+PiAgcHJvamVj
dChyZG1hLWNvcmUgQykNCj4+IEBAIC04NCw2ICs4NiwxMCBAQCBpZiAoSU5fUExBQ0UpDQo+PiAg
ICBzZXQoQ01BS0VfSU5TVEFMTF9JTkNMVURFRElSICJpbmNsdWRlIikNCj4+ICBlbmRpZigpDQo+
PiAgDQo+PiAraWYgKCIke05FSUdIX0dFVF9ERUZBVUxUX1RJTUVPVVRfTVN9IiBTVFJFUVVBTCAi
IikNCj4+ICsgIHNldChORUlHSF9HRVRfREVGQVVMVF9USU1FT1VUX01TIDMwMDApDQo+PiArZW5k
aWYoKQ0KPj4gKw0KPj4gIGluY2x1ZGUoR05VSW5zdGFsbERpcnMpDQo+PiAgIyBDIGluY2x1ZGUg
cm9vdA0KPj4gIHNldChCVUlMRF9JTkNMVURFICR7Q01BS0VfQklOQVJZX0RJUn0vaW5jbHVkZSkN
Cj4+IGRpZmYgLS1naXQgYS9idWlsZGxpYi9jb25maWcuaC5pbiBiL2J1aWxkbGliL2NvbmZpZy5o
LmluDQo+PiBpbmRleCAwNzU0ZDI0OTQyMzQuLjU5MGU3MDE2MmQxZSAxMDA2NDQNCj4+IC0tLSBh
L2J1aWxkbGliL2NvbmZpZy5oLmluDQo+PiArKysgYi9idWlsZGxpYi9jb25maWcuaC5pbg0KPj4g
QEAgLTYxLDYgKzYxLDggQEANCj4+ICAjIGRlZmluZSBWRVJCU19XUklURV9PTkxZIDANCj4+ICAj
ZW5kaWYNCj4+ICANCj4+ICsjIGRlZmluZSBORUlHSF9HRVRfREVGQVVMVF9USU1FT1VUX01TIEBO
RUlHSF9HRVRfREVGQVVMVF9USU1FT1VUX01TQA0KPiANCj4gRXh0cmEgc3BhY2UuLg0KPiANCk9r
Lg0KDQo+PiArDQo+PiAgLy8gQ29uZmlndXJhdGlvbiBkZWZhdWx0cw0KPj4gIA0KPj4gICNkZWZp
bmUgSUJBQ01fU0VSVkVSX01PREVfVU5JWCAwDQo+PiBkaWZmIC0tZ2l0IGEvbGliaWJ2ZXJicy92
ZXJicy5jIGIvbGliaWJ2ZXJicy92ZXJicy5jDQo+PiBpbmRleCAxNzY2YjlmNTJkMzEuLjJjYWI4
NjE4NGUzMiAxMDA2NDQNCj4+IC0tLSBhL2xpYmlidmVyYnMvdmVyYnMuYw0KPj4gKysrIGIvbGli
aWJ2ZXJicy92ZXJicy5jDQo+PiBAQCAtOTY3LDcgKzk2Nyw2IEBAIHN0YXRpYyBpbmxpbmUgaW50
IGNyZWF0ZV9wZWVyX2Zyb21fZ2lkKGludCBmYW1pbHksIHZvaWQgKnJhd19naWQsDQo+PiAgCXJl
dHVybiAwOw0KPj4gIH0NCj4+ICANCj4+IC0jZGVmaW5lIE5FSUdIX0dFVF9ERUZBVUxUX1RJTUVP
VVRfTVMgMzAwMA0KPj4gIGludCBpYnZfcmVzb2x2ZV9ldGhfbDJfZnJvbV9naWQoc3RydWN0IGli
dl9jb250ZXh0ICpjb250ZXh0LA0KPj4gIAkJCQlzdHJ1Y3QgaWJ2X2FoX2F0dHIgKmF0dHIsDQo+
PiAgCQkJCXVpbnQ4X3QgZXRoX21hY1tFVEhFUk5FVF9MTF9TSVpFXSwNCj4gDQo+IFJlYWxseSBj
b21waWxlIHRpbWUgY29uZmlndXJhdGlvbnMgYXJlIG5vdCBzbyB1c2VmdWwsIHdoYXQgaXMgdGhl
IHVzZQ0KPiBjYXNlIGhlcmU/IA0KPiANCg0KSW4gdGhlIGdlbmVyYWwgc2Vuc2UgSSBhZ3JlZSB3
aXRoIHlvdS4gUHJlLWJ1aWx0IFJQTXMgbWF5IG5vdCBoYXZlIHRoaXMNCnNldCB0byBhbnl0aGlu
ZyBvdGhlciB0aGFuIHRoZSBkZWZhdWx0IHZhbHVlLiANCkhvd2V2ZXIsIGluIG91ciBpbnRlcm5h
bCB0ZXN0aW5nIHdlJ3ZlIHNlZW4gdGltZW91dHMgd2hlbiB0cnlpbmcgdG8NCnJlc29sdmUgdGhl
IERNQUMgd2hlbiBjcmVhdGluZyBhbiBBSC4gSW5zdGVhZCwgb2Ygc2ltcGx5IGluY3JlYXNpbmcN
CnRoZSAjZGVmaW5lIHZhbHVlIGhlcmUgSSB0aG91Z2h0IGl0IHdvdWxkIGJlIG1pbGRseSBoZWxw
ZnVsIHRvIGV4cG9zZSANCnRoaXMgb3V0Lg0KDQpJZiB0aGlzIGlzIG5vdCBnb2luZyB0byBiZSB1
c2VmdWwgSSBjYW4gZHJvcCBpdCBidXQgSSB0aG91Z2h0IGl0IHdvdWxkIA0KYXRsZWFzdCBtYWtl
IHJkbWEtY29yZSBhIGJpdCBtb3JlIGNvbmZpZ3VyYWJsZS4uDQoNCj4gV2h5IGRvZXMgdGhpcyB0
aW1lb3V0IGV2ZW4gZXhpc3Q/DQo+IA0KSXQgZ2V0cyB1c2VkIHNvbWV3aGVyZSBpbiB0aGUgbmVp
Z2hib3IgbG9va3VwIHByb2Nlc3MgYnV0IEknbSBub3QgdGhhdA0KZmFtaWxpYXIgYWJvdXQgaG93
IHRoZSBuZXRsaW5rIGxpYnJhcnkgd29ya3MgaGVyZS4gTWF5YmUgc29tZW9uZSBlbHNlDQpjb3Vs
ZCBjaGltZSBpbiBvbiB0aGF0LiBCdXQgaXQgbG9va3MgdGhlIG5ldGxpbmsgcGFja2V0cyBhcmUg
Z2V0dGluZw0KZHJvcHBlZCBzb21ld2hlcmUgaW4gdGhlIE9TIHN0YWNrLiBJdCBjb3VsZCBzb21l
IG9kZCB0aW1pbmcgaXNzdWUgc2luY2UNCmV2ZXJ5dGhpbmcgd29ya2VkIGZpbmUgd2hlbiBJIGVu
YWJsZWQgdGhlIGxpYm5sIGRlYnVnIG9wdGlvbi4NCg0KPiBKYXNvbg0KPg0K
