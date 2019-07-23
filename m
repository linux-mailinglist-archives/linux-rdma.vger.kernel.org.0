Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDEB71CE8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfGWQ2a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 12:28:30 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:35236
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732643AbfGWQ2a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 12:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzzIr6EkTQL3MPkeiJfN0uMzKPJzl/fmC+Xz0b8ohtX8COGtA2Og/peAkauQZLZrQh66cbd5WU8TFI26IJI33lqBaDqaCFjRnII0m4+xaF+btBWKE/FTd+TAVRF4+fzWykd2zYFHxmLbmJmjUbjtq8I7nvgHd/t6THM4nFB6c1WXlmwHVDGiHX9+kP26HfHM8CoybGPpuyGQEHhpZ16FcIgClEoBrE8dOwiBMou9rsaAei1oupl+VUoMQBNntd+Ubk63zxiz2KIUqTQTkuxcArOr9RzkGoRukceILo5CJ+8EVqPiI9yLGYsDTZp7VK8b2md+Mrq8CVUPiq/Jr7jCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weiaOTipayziyMIuSvc2d+DtGZwwx+ZgTi4aiBFZ8Ys=;
 b=eagz+tvpmUZz9mqn1l8zPuTja2+ZjQL/IcS+Y/BwCpTZwlvlaV/uE5T/cBw+nwCi7Cpe7MzwepdYU617zOXjhNmLtjrbocm4m6JWti5yQkuFryIKqjVkp8e64pOB1FkRiybjUUd+NT0rJpDSZ5CMTafO9G4dtw1vtY96CxmDz/j7BEM4WYL2p8q5pxoP1ZVRaBc8IAm5JPc1yiE2t/BXAYdXBgK+I1OY5YTKfeuKIuScgYqV17IN2JLBjcHdSV4zMK4KT3cJqVpEDGKuohhhOFrd7PO6Vm9Wx5tNLnXBIvTossUOhNbw1q6owy2wqzZurfMe+dbEtn7DxA0Xmfqz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weiaOTipayziyMIuSvc2d+DtGZwwx+ZgTi4aiBFZ8Ys=;
 b=f5L+8towWBun9VUuZVHpSCZ6o+UWNGxK4OAtsme3RIoq9xdYgnGiJ1gDhYIJL/qo7Zn8Z8NNZAyVAA6NXP47BJ2voWai/eWnykz1QBdphY+nI8/eQFGHrxVwUTpVc1E5OZKCvd9Fiv6DwyBC+kM18DfBjuTNBdnrcZggix5T9wc=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1178.namprd12.prod.outlook.com (10.168.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 23 Jul 2019 16:28:25 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7%10]) with mapi id 15.20.2094.013; Tue, 23 Jul
 2019 16:28:25 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
Thread-Topic: [PATCH 14/14] PCI/P2PDMA: Introduce
 pci_p2pdma_[un]map_resource()
Thread-Index: AQHVQOJ/exvjIUnPzky3IlGvzOcOEqbYZX6A
Date:   Tue, 23 Jul 2019 16:28:25 +0000
Message-ID: <d5e20223-04b9-dcb4-7c96-57d84eb010ae@amd.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-15-logang@deltatee.com>
In-Reply-To: <20190722230859.5436-15-logang@deltatee.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P193CA0095.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::36) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e24585d-aa71-4a35-3bb1-08d70f8ac928
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1178;
x-ms-traffictypediagnostic: DM5PR12MB1178:
x-microsoft-antispam-prvs: <DM5PR12MB1178D729D27AD461EB7BDE4983C70@DM5PR12MB1178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(65806001)(66574012)(81166006)(65956001)(6246003)(7736002)(64756008)(305945005)(66556008)(4326008)(8936002)(6512007)(8676002)(71190400001)(64126003)(66476007)(68736007)(110136005)(58126008)(71200400001)(54906003)(478600001)(66946007)(6486002)(53936002)(316002)(6436002)(31686004)(99286004)(186003)(14444005)(11346002)(14454004)(2201001)(6116002)(2501003)(476003)(229853002)(31696002)(25786009)(36756003)(256004)(46003)(86362001)(5660300002)(6506007)(7416002)(66446008)(2906002)(486006)(386003)(102836004)(65826007)(52116002)(446003)(2616005)(81156014)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1178;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PXnSqcv70hKyBwwBBcgYnbRu7siYJJrx7fivb02dYUkcySXvRP/j1OQlzzHCIDZ96wjWgROCtwn1hmEwFKNaPgj/b98muJNxKMUoKeYihUjnySGAB9c5axHecEGVfugbp49gNzwniSC1kHnqKget9rPJn2BqjysWIbd5BAzzak+UIqjAdSnLmC+UQXHVfWCEQuuQEusSEJDyFE3u2PLG3oxsb7NGVPupYbvie+/DgSlT4q1bRF2DtIMix0fKgFwm1yFwQAcrsNqCn/JFUMo2Ze4nF+PU5ylnBPLbj9oBF3DSDcnf3dJkfxOv4wSTUVBFkl4j1S9jFBDg6BwYqsWi2Q7Wgi0PAXaBsKjL6+qgJ78BIo0B7JpxKBvhBuA1ZYZgkw9L5wN8MZu1Yf44LWETUa+eZryj1PNlIB/xKHL162g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01095C4A73AFF4ABF6ADB40B1DD056A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e24585d-aa71-4a35-3bb1-08d70f8ac928
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 16:28:25.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1178
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QW0gMjMuMDcuMTkgdW0gMDE6MDggc2NocmllYiBMb2dhbiBHdW50aG9ycGU6DQo+IHBjaV9wMnBk
bWFfW3VuXW1hcF9yZXNvdXJjZSgpIGNhbiBiZSB1c2VkIHRvIG1hcCBhIHJlc291cmNlIGdpdmVu
DQo+IGl0J3MgcGh5c2ljYWwgYWRkcmVzcyBhbmQgdGhlIGJhY2tpbmcgcGNpX2Rldi4gVGhlIGZ1
bmN0aW9ucyB3aWxsIGNhbGwNCj4gZG1hX1t1bl1tYXBfcmVzb3VyY2UoKSB3aGVuIGFwcHJvcHJp
YXRlLg0KPg0KPiBUaGlzIGlzIGZvciBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzIG9ubHkgYXMgdGhl
cmUgYXJlIG5vIHVzZXJzIG9mIHRoaXMNCj4gZnVuY3Rpb24gYXQgdGhpcyB0aW1lLiBUaHVzLCB0
aGlzIHBhdGNoIHNob3VsZCBub3QgYmUgbWVyZ2VkIGF0DQo+IHRoaXMgdGltZS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KDQpOb3Qg
c3VyZSBpZiBwY2lfcDJwZG1hX3BoeXNfdG9fYnVzIGFjdHVhbGx5IG5lZWRzIHRvIGJlIGV4cG9y
dGVkLiBCdXQgDQphcGFydCBmcm9tIHRoYXQgbG9va3MgZmluZSB0byBtZS4NCg0KUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KQ2hyaXN0
aWFuLg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvcGNpL3AycGRtYS5jIHwgODUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgODUg
aW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcDJwZG1hLmMgYi9k
cml2ZXJzL3BjaS9wMnBkbWEuYw0KPiBpbmRleCBiYWY0NzYwMzkzOTYuLjIwYzgzNGNmZDJkMyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvcDJwZG1hLmMNCj4gKysrIGIvZHJpdmVycy9wY2kv
cDJwZG1hLmMNCj4gQEAgLTg3NCw2ICs4NzQsOTEgQEAgdm9pZCBwY2lfcDJwZG1hX3VubWFwX3Nn
X2F0dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywNCj4gICB9
DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwocGNpX3AycGRtYV91bm1hcF9zZ19hdHRycyk7DQo+ICAg
DQo+ICtzdGF0aWMgcGNpX2J1c19hZGRyX3QgcGNpX3AycGRtYV9waHlzX3RvX2J1cyhzdHJ1Y3Qg
cGNpX2RldiAqZGV2LA0KPiArCQlwaHlzX2FkZHJfdCBzdGFydCwgc2l6ZV90IHNpemUpDQo+ICt7
DQo+ICsJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlID0gcGNpX2ZpbmRfaG9zdF9icmlk
Z2UoZGV2LT5idXMpOw0KPiArCXBoeXNfYWRkcl90IGVuZCA9IHN0YXJ0ICsgc2l6ZTsNCj4gKwlz
dHJ1Y3QgcmVzb3VyY2VfZW50cnkgKndpbmRvdzsNCj4gKw0KPiArCXJlc291cmNlX2xpc3RfZm9y
X2VhY2hfZW50cnkod2luZG93LCAmYnJpZGdlLT53aW5kb3dzKSB7DQo+ICsJCWlmICh3aW5kb3ct
PnJlcy0+c3RhcnQgPD0gc3RhcnQgJiYgd2luZG93LT5yZXMtPmVuZCA+PSBlbmQpDQo+ICsJCQly
ZXR1cm4gc3RhcnQgLSB3aW5kb3ctPm9mZnNldDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gRE1B
X01BUFBJTkdfRVJST1I7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChwY2lfcDJwZG1hX3Bo
eXNfdG9fYnVzKTsNCj4gKw0KPiArLyoqDQo+ICsgKiBwY2lfcDJwZG1hX21hcF9yZXNvdXJjZSAt
IG1hcCBhIFBDSSBwZWVyLXRvLXBlZXIgcGh5c2ljYWwgYWRkcmVzcyBmb3IgRE1BDQo+ICsgKiBA
cHJvdmlkZXI6IHBjaSBkZXZpY2UgdGhhdCBwcm92aWRlcyB0aGUgbWVtb3J5IGJhY2tlZCBieSBw
aHlzX2FkZHINCj4gKyAqIEBkbWFfZGV2OiBkZXZpY2UgZG9pbmcgdGhlIERNQSByZXF1ZXN0DQo+
ICsgKiBAcGh5c19hZGRyOiBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBtZW1vcnkgdG8gbWFwDQo+
ICsgKiBAc2l6ZTogc2l6ZSBvZiB0aGUgbWVtb3J5IHRvIG1hcA0KPiArICogQGRpcjogRE1BIGRp
cmVjdGlvbg0KPiArICogQGF0dHJzOiBkbWEgYXR0cmlidXRlcyBwYXNzZWQgdG8gZG1hX21hcF9y
ZXNvdXJjZSgpIChpZiBjYWxsZWQpDQo+ICsgKg0KPiArICogTWFwcyBhIEJBUiBwaHlzaWNhbCBh
ZGRyZXNzIGZvciBwcm9ncmFtbWluZyBhIERNQSBlbmdpbmUuDQo+ICsgKg0KPiArICogUmV0dXJu
cyB0aGUgZG1hX2FkZHJfdCB0byBtYXAgb3IgRE1BX01BUFBJTkdfRVJST1Igb24gZmFpbHVyZQ0K
PiArICovDQo+ICtkbWFfYWRkcl90IHBjaV9wMnBkbWFfbWFwX3Jlc291cmNlKHN0cnVjdCBwY2lf
ZGV2ICpwcm92aWRlciwNCj4gKwkJc3RydWN0IGRldmljZSAqZG1hX2RldiwgcGh5c19hZGRyX3Qg
cGh5c19hZGRyLCBzaXplX3Qgc2l6ZSwNCj4gKwkJZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGly
LCB1bnNpZ25lZCBsb25nIGF0dHJzKQ0KPiArew0KPiArCXN0cnVjdCBwY2lfZGV2ICpjbGllbnQ7
DQo+ICsJaW50IGRpc3Q7DQo+ICsNCj4gKwljbGllbnQgPSBmaW5kX3BhcmVudF9wY2lfZGV2KGRt
YV9kZXYpOw0KPiArCWlmICghY2xpZW50KQ0KPiArCQlyZXR1cm4gRE1BX01BUFBJTkdfRVJST1I7
DQo+ICsNCj4gKwlkaXN0ID0gdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNlKHByb3ZpZGVyLCBjbGll
bnQsIE5VTEwpOw0KPiArCWlmIChkaXN0ICYgUDJQRE1BX05PVF9TVVBQT1JURUQpDQo+ICsJCXJl
dHVybiBETUFfTUFQUElOR19FUlJPUjsNCj4gKw0KPiArCWlmIChkaXN0ICYgUDJQRE1BX1RIUlVf
SE9TVF9CUklER0UpDQo+ICsJCXJldHVybiBkbWFfbWFwX3Jlc291cmNlKGRtYV9kZXYsIHBoeXNf
YWRkciwgc2l6ZSwgZGlyLCBhdHRycyk7DQo+ICsJZWxzZQ0KPiArCQlyZXR1cm4gcGNpX3AycGRt
YV9waHlzX3RvX2J1cyhwcm92aWRlciwgcGh5c19hZGRyLCBzaXplKTsNCj4gK30NCj4gK0VYUE9S
VF9TWU1CT0xfR1BMKHBjaV9wMnBkbWFfbWFwX3Jlc291cmNlKTsNCj4gKw0KPiArLyoqDQo+ICsg
KiBwY2lfcDJwZG1hX3VubWFwX3Jlc291cmNlIC0gdW5tYXAgYSByZXNvdXJjZSBtYXBwZWQgd2l0
aA0KPiArICoJCXBjaV9wMnBkbWFfbWFwX3Jlc291cmNlKCkNCj4gKyAqIEBwcm92aWRlcjogcGNp
IGRldmljZSB0aGF0IHByb3ZpZGVzIHRoZSBtZW1vcnkgYmFja2VkIGJ5IHBoeXNfYWRkcg0KPiAr
ICogQGRtYV9kZXY6IGRldmljZSBkb2luZyB0aGUgRE1BIHJlcXVlc3QNCj4gKyAqIEBhZGRyOiBk
bWEgYWRkcmVzcyByZXR1cm5lZCBieSBwY2lfcDJwZG1hX3VubWFwX3Jlc291cmNlKCkNCj4gKyAq
IEBzaXplOiBzaXplIG9mIHRoZSBtZW1vcnkgdG8gbWFwDQo+ICsgKiBAZGlyOiBETUEgZGlyZWN0
aW9uDQo+ICsgKiBAYXR0cnM6IGRtYSBhdHRyaWJ1dGVzIHBhc3NlZCB0byBkbWFfdW5tYXBfcmVz
b3VyY2UoKSAoaWYgY2FsbGVkKQ0KPiArICoNCj4gKyAqIE1hcHMgYSBCQVIgcGh5c2ljYWwgYWRk
cmVzcyBmb3IgcHJvZ3JhbW1pbmcgYSBETUEgZW5naW5lLg0KPiArICoNCj4gKyAqIFJldHVybnMg
dGhlIGRtYV9hZGRyX3QgdG8gbWFwIG9yIERNQV9NQVBQSU5HX0VSUk9SIG9uIGZhaWx1cmUNCj4g
KyAqLw0KPiArdm9pZCBwY2lfcDJwZG1hX3VubWFwX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpw
cm92aWRlciwNCj4gKwkJc3RydWN0IGRldmljZSAqZG1hX2RldiwgZG1hX2FkZHJfdCBhZGRyLCBz
aXplX3Qgc2l6ZSwNCj4gKwkJZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLCB1bnNpZ25lZCBs
b25nIGF0dHJzKQ0KPiArew0KPiArCXN0cnVjdCBwY2lfZGV2ICpjbGllbnQ7DQo+ICsJaW50IGRp
c3Q7DQo+ICsNCj4gKwljbGllbnQgPSBmaW5kX3BhcmVudF9wY2lfZGV2KGRtYV9kZXYpOw0KPiAr
CWlmICghY2xpZW50KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlkaXN0ID0gdXBzdHJlYW1fYnJp
ZGdlX2Rpc3RhbmNlKHByb3ZpZGVyLCBjbGllbnQsIE5VTEwpOw0KPiArCWlmIChkaXN0ICYgUDJQ
RE1BX05PVF9TVVBQT1JURUQpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmIChkaXN0ICYgUDJQ
RE1BX1RIUlVfSE9TVF9CUklER0UpDQo+ICsJCWRtYV91bm1hcF9yZXNvdXJjZShkbWFfZGV2LCBh
ZGRyLCBzaXplLCBkaXIsIGF0dHJzKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBjaV9w
MnBkbWFfdW5tYXBfcmVzb3VyY2UpOw0KPiArDQo+ICAgLyoqDQo+ICAgICogcGNpX3AycGRtYV9l
bmFibGVfc3RvcmUgLSBwYXJzZSBhIGNvbmZpZ2ZzL3N5c2ZzIGF0dHJpYnV0ZSBzdG9yZQ0KPiAg
ICAqCQl0byBlbmFibGUgcDJwZG1hDQoNCg==
