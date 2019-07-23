Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5B71CC4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfGWQUt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 12:20:49 -0400
Received: from mail-eopbgr740058.outbound.protection.outlook.com ([40.107.74.58]:15668
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGWQUt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 12:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5Zfxxb/OSZlmF42paJxqxcE2aweYUsdquMe5NwlFWVfMpcG9DgAOjeNfwLtc45W68DrZ/6KwtuPq6SDKPuyKjFPc2H6a2qFgYY5m/HFqFRmdw6YdpK9NQvk9hXO5U+t/9zAbYa83XMjFm1Ap8y1NH02OtNVq8MCQokZRYeZiD84fjJoo6zLA/j1oO2NLTypPw7Y5cz3ZmG/MMwFaO5Ib9Ezrse2ttceVEfl1kK0/ujvZo2FjzA5gEm9XvC9BpU1qZi+/pRNCDTNBvCQXwdwcI4DFuyANmK1UHMkF22ct2l7iQellE1G7j6MVi0en6aemNgGVsFs3JbG8PxSG9Ik3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfURRqdsL//HPHg2IxSOXZ5OmZT6D3u24hsQJwAGqak=;
 b=bHy+pqX0MlFZ4yCghb8ehRtxylqh/sE1kVSHPbqWb+mJekAbYiQ6iMGF8WbV319WHa4JHCOs9D/6Hk+0z8a7/XL03xfxtyU2jPrGyWrYh8KNo1IczROIA4gdQdBbFtauB8CmyBFZkVcbWxCoKbO0k2qW1/LZ6PG2/yo6Wq15Idqsw98g/phyA5dRnXCTJ9pmvRTyynQuzShI12ht2oZ1iDXXtfayR70inWhvE0a2Luy35sdADpb07hm+F30ep/YCZI2BJXFpr0yps2RxkSvfJWzLtfmgY5YSKsCvjN2HXJZ/i7MXyNWik5GhxJl3qwvxTVH4seBph1CrL8mgoEOOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfURRqdsL//HPHg2IxSOXZ5OmZT6D3u24hsQJwAGqak=;
 b=Oia5JZ4tw7uWzYrzZtebxax3xba6Wj20sGAjxUc3D/JDWekbKsV7THFAn/270DxIDzg80NSJpS0loSCIrn7c+XImqahkt8/yVAo6lYCzs1BxySQE4OEUsmHjoyz0JXh5wwkL58R3jPtEW37uodncYFNvb6TkeliRQKnHJA5aLIQ=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2391.namprd12.prod.outlook.com (52.132.141.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 23 Jul 2019 16:20:44 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7%10]) with mapi id 15.20.2094.013; Tue, 23 Jul
 2019 16:20:43 +0000
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
Subject: Re: [PATCH 01/14] PCI/P2PDMA: Add constants for not-supported result
 upstream_bridge_distance()
Thread-Topic: [PATCH 01/14] PCI/P2PDMA: Add constants for not-supported result
 upstream_bridge_distance()
Thread-Index: AQHVQOKCKJFX2v2odUmFqpFnf3TCT6bYY1kA
Date:   Tue, 23 Jul 2019 16:20:43 +0000
Message-ID: <b158e5e7-4884-fa4d-19a0-326ea71c621b@amd.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-2-logang@deltatee.com>
In-Reply-To: <20190722230859.5436-2-logang@deltatee.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR2P264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::31) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 179537a9-c568-41cb-97b8-08d70f89b60a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2391;
x-ms-traffictypediagnostic: DM5PR12MB2391:
x-microsoft-antispam-prvs: <DM5PR12MB2391CEB25CCC563E207AEE2F83C70@DM5PR12MB2391.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(65956001)(65806001)(476003)(2616005)(6436002)(446003)(76176011)(386003)(11346002)(64126003)(6506007)(52116002)(31686004)(486006)(102836004)(186003)(46003)(6486002)(7416002)(14454004)(2906002)(256004)(316002)(478600001)(2501003)(36756003)(4326008)(229853002)(58126008)(5660300002)(66574012)(7736002)(99286004)(25786009)(6116002)(81166006)(305945005)(71190400001)(8936002)(66476007)(71200400001)(66556008)(54906003)(64756008)(6246003)(66946007)(8676002)(31696002)(86362001)(110136005)(81156014)(66446008)(2201001)(6512007)(68736007)(53936002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2391;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YYfiVo92B4dvk+Or/8Vdmz51yw9xuf8FrJLCVQEzxLd1qUuhWQWW849Dg+RIMlwxoN3O3a/voN2IFKtL5SU6mfHSSNPs6CU47e2RPyihVZUiy3JtyDyUTQXmIZOJndHYkEr6XtKf54ARete4HLkB1P09EEPyKwtbg5OkFUdKRZwVx+SGt6WLKu+gvs7xuBQOJpcygrxJ/kRhZZf12EgtePO1eYJMl9qHxktYdzAhw3tjt9JK9Og/5W4IF5K4GWzP/mBJ55occMhqf1ZDi3+u9JPYnqn6cDO2yKctjIYJPjgN+NKDF8XtmYkdrPYEoYV8BVo8EEs1jwJsIFY37Hqt+XNmAmzsJsYWzC7jbLlCuLRltxtp5AhQSPVUm04uZrf8JRhLllBwydakh3XoWzwpABMN+9q94MrcUvtskrtgaL4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65D0F63628C47C4AB022D806DB5D36D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179537a9-c568-41cb-97b8-08d70f89b60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 16:20:43.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QW0gMjMuMDcuMTkgdW0gMDE6MDggc2NocmllYiBMb2dhbiBHdW50aG9ycGU6DQo+IEFkZCBjb25z
dGFudCBmbGFncyB0byBpbmRpY2F0ZSB0d28gZGV2aWNlcyBhcmUgbm90IHN1cHBvcnRlZCBvciB3
aGV0aGVyDQo+IHRoZSBkYXRhIHBhdGggZ29lcyB0aHJvdWdoIHRoZSBob3N0IGJyaWRnZSBpbnN0
ZWFkIG9mIHVzaW5nIHRoZSBuZWdhdGl2ZQ0KPiB2YWx1ZXMgLTEgYW5kIC0yLg0KPg0KPiBUaGlz
IGhlbHBzIGFubm90YXRlIHRoZSBjb2RlIGJldHRlciwgYnV0IHRoZSBtYWluIHJlYXNvbiBpcyBz
byB3ZQ0KPiBjYW4gY2FjaGUgdGhlIHJlc3VsdCBpbiBhbiB4YXJyYXkgd2hpY2ggZG9lcyBub3Qg
YWxsb3cgdXMgdG8gc3RvcmUNCj4gbmVnYXRpdmUgdmFsdWVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQoNClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy9wY2kvcDJwZG1hLmMgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyMSBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3AycGRtYS5jIGIvZHJp
dmVycy9wY2kvcDJwZG1hLmMNCj4gaW5kZXggMjM0NDc2MjI2NTI5Li5lOGVjODZlMWRkMDAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL3AycGRtYS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3Ay
cGRtYS5jDQo+IEBAIC0yNzMsNiArMjczLDIwIEBAIHN0YXRpYyBib29sIHJvb3RfY29tcGxleF93
aGl0ZWxpc3Qoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gICAJcmV0dXJuIGZhbHNlOw0KPiAgIH0N
Cj4gICANCj4gK2VudW0gew0KPiArCS8qDQo+ICsJICogVGhlcyBhcmJpdHJhcnkgb2Zmc2V0IGFy
ZSBvcidkIG9udG8gdGhlIHVwc3RyZWFtIGRpc3RhbmNlDQo+ICsJICogY2FsY3VsYXRpb24gZm9y
IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCj4gKwkgKi8NCj4gKw0KPiArCS8qIFRoZSBkYXRh
IHBhdGggaW5jbHVkZXMgdGhlIGhvc3QtYnJpZGdlICovDQo+ICsJUDJQRE1BX1RIUlVfSE9TVF9C
UklER0UJCT0gMHgwMjAwMDAwMCwNCj4gKwkvKiBUaGUgZGF0YSBwYXRoIGlzIGZvcmNlZCB0aHJv
dWdoIHRoZSBob3N0LWJyaWRnZSBkdWUgdG8gQUNTICovDQo+ICsJUDJQRE1BX0FDU19GT1JDRVNf
VVBTVFJFQU0JPSAweDA0MDAwMDAwLA0KPiArCS8qIFRoZSBkYXRhIHBhdGggaXMgbm90IHN1cHBv
cnRlZCBieSBQMlBETUEgKi8NCj4gKwlQMlBETUFfTk9UX1NVUFBPUlRFRAkJPSAweDA4MDAwMDAw
LA0KPiArfTsNCj4gKw0KPiAgIC8qDQo+ICAgICogRmluZCB0aGUgZGlzdGFuY2UgdGhyb3VnaCB0
aGUgbmVhcmVzdCBjb21tb24gdXBzdHJlYW0gYnJpZGdlIGJldHdlZW4NCj4gICAgKiB0d28gUENJ
IGRldmljZXMuDQo+IEBAIC0yOTcsMjIgKzMxMSwxNyBAQCBzdGF0aWMgYm9vbCByb290X2NvbXBs
ZXhfd2hpdGVsaXN0KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICAgICogcG9ydCBvZiB0aGUgc3dp
dGNoLCB0byB0aGUgY29tbW9uIHVwc3RyZWFtIHBvcnQsIGJhY2sgdXAgdG8gdGhlIHNlY29uZA0K
PiAgICAqIGRvd25zdHJlYW0gcG9ydCBhbmQgdGhlbiB0byBEZXZpY2UgQi4NCj4gICAgKg0KPiAt
ICogQW55IHR3byBkZXZpY2VzIHRoYXQgZG9uJ3QgaGF2ZSBhIGNvbW1vbiB1cHN0cmVhbSBicmlk
Z2Ugd2lsbCByZXR1cm4gLTEuDQo+IC0gKiBJbiB0aGlzIHdheSBkZXZpY2VzIG9uIHNlcGFyYXRl
IFBDSWUgcm9vdCBwb3J0cyB3aWxsIGJlIHJlamVjdGVkLCB3aGljaA0KPiAtICogaXMgd2hhdCB3
ZSB3YW50IGZvciBwZWVyLXRvLXBlZXIgc2VlaW5nIGVhY2ggUENJZSByb290IHBvcnQgZGVmaW5l
cyBhDQo+IC0gKiBzZXBhcmF0ZSBoaWVyYXJjaHkgZG9tYWluIGFuZCB0aGVyZSdzIG5vIHdheSB0
byBkZXRlcm1pbmUgd2hldGhlciB0aGUgcm9vdA0KPiAtICogY29tcGxleCBzdXBwb3J0cyBmb3J3
YXJkaW5nIGJldHdlZW4gdGhlbS4NCj4gKyAqIEFueSB0d28gZGV2aWNlcyB0aGF0IGNhbm5vdCBj
b21tdW5pY2F0ZSB1c2luZyBwMnBkbWEgd2lsbCByZXR1cm4gdGhlIGRpc3RhbmNlDQo+ICsgKiB3
aXRoIHRoZSBmbGFnIFAyUERNQV9OT1RfU1VQUE9SVEVELg0KPiAgICAqDQo+IC0gKiBJbiB0aGUg
Y2FzZSB3aGVyZSB0d28gZGV2aWNlcyBhcmUgY29ubmVjdGVkIHRvIGRpZmZlcmVudCBQQ0llIHN3
aXRjaGVzLA0KPiAtICogdGhpcyBmdW5jdGlvbiB3aWxsIHN0aWxsIHJldHVybiBhIHBvc2l0aXZl
IGRpc3RhbmNlIGFzIGxvbmcgYXMgYm90aA0KPiAtICogc3dpdGNoZXMgZXZlbnR1YWxseSBoYXZl
IGEgY29tbW9uIHVwc3RyZWFtIGJyaWRnZS4gTm90ZSB0aGlzIGNvdmVycw0KPiAtICogdGhlIGNh
c2Ugb2YgdXNpbmcgbXVsdGlwbGUgUENJZSBzd2l0Y2hlcyB0byBhY2hpZXZlIGEgZGVzaXJlZCBs
ZXZlbCBvZg0KPiAtICogZmFuLW91dCBmcm9tIGEgcm9vdCBwb3J0LiBUaGUgZXhhY3QgZGlzdGFu
Y2Ugd2lsbCBiZSBhIGZ1bmN0aW9uIG9mIHRoZQ0KPiAtICogbnVtYmVyIG9mIHN3aXRjaGVzIGJl
dHdlZW4gRGV2aWNlIEEgYW5kIERldmljZSBCLg0KPiArICogQW55IHR3byBkZXZpY2VzIHRoYXQg
aGF2ZSBhIGRhdGEgcGF0aCB0aGF0IGdvZXMgdGhyb3VnaCB0aGUgaG9zdCBicmlkZ2UNCj4gKyAq
IHdpbGwgY29uc3VsdCBhIHdoaXRlbGlzdC4gSWYgdGhlIGhvc3QgYnJpZGdlcyBhcmUgb24gdGhl
IHdoaXRlbGlzdCwNCj4gKyAqIHRoZW4gdGhlIGRpc3RhbmNlIHdpbGwgYmUgcmV0dXJuZWQgd2l0
aCB0aGUgZmxhZyBQMlBETUFfVEhSVV9IT1NUX0JSSURHRSBzZXQuDQo+ICsgKiBJZiBlaXRoZXIg
YnJpZGdlIGlzIG5vdCBvbiB0aGUgd2hpdGVsaXN0LCB0aGUgZmxhZyBQMlBETUFfTk9UX1NVUFBP
UlRFRCB3aWxsDQo+ICsgKiBiZSBzZXQuDQo+ICAgICoNCj4gICAgKiBJZiBhIGJyaWRnZSB3aGlj
aCBoYXMgYW55IEFDUyByZWRpcmVjdGlvbiBiaXRzIHNldCBpcyBpbiB0aGUgcGF0aA0KPiAtICog
dGhlbiB0aGlzIGZ1bmN0aW9ucyB3aWxsIHJldHVybiAtMi4gVGhpcyBpcyBzbyB3ZSByZWplY3Qg
YW55DQo+IC0gKiBjYXNlcyB3aGVyZSB0aGUgVExQcyBhcmUgZm9yd2FyZGVkIHVwIGludG8gdGhl
IHJvb3QgY29tcGxleC4NCj4gKyAqIHRoZW4gdGhpcyBmdW5jdGlvbnMgd2lsbCBmbGFnIHRoZSBy
ZXN1bHQgd2l0aCBQMlBETUFfQUNTX0ZPUkNFU19VUFNUUkVBTS4NCj4gICAgKiBJbiB0aGlzIGNh
c2UsIGEgbGlzdCBvZiBhbGwgaW5mcmluZ2luZyBicmlkZ2UgYWRkcmVzc2VzIHdpbGwgYmUNCj4g
ICAgKiBwb3B1bGF0ZWQgaW4gYWNzX2xpc3QgKGFzc3VtaW5nIGl0J3Mgbm9uLW51bGwpIGZvciBw
cmludGsgcHVycG9zZXMuDQo+ICAgICovDQo+IEBAIC0zNTksOSArMzY4LDkgQEAgc3RhdGljIGlu
dCB1cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2Uoc3RydWN0IHBjaV9kZXYgKnByb3ZpZGVyLA0KPiAg
IAkgKi8NCj4gICAJaWYgKHJvb3RfY29tcGxleF93aGl0ZWxpc3QocHJvdmlkZXIpICYmDQo+ICAg
CSAgICByb290X2NvbXBsZXhfd2hpdGVsaXN0KGNsaWVudCkpDQo+IC0JCXJldHVybiAweDEwMDAg
KyBkaXN0X2EgKyBkaXN0X2I7DQo+ICsJCXJldHVybiAoZGlzdF9hICsgZGlzdF9iKSB8IFAyUERN
QV9USFJVX0hPU1RfQlJJREdFOw0KPiAgIA0KPiAtCXJldHVybiAtMTsNCj4gKwlyZXR1cm4gKGRp
c3RfYSArIGRpc3RfYikgfCBQMlBETUFfTk9UX1NVUFBPUlRFRDsNCj4gICANCj4gICBjaGVja19i
X3BhdGhfYWNzOg0KPiAgIAliYiA9IGI7DQo+IEBAIC0zNzksNyArMzg4LDcgQEAgc3RhdGljIGlu
dCB1cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2Uoc3RydWN0IHBjaV9kZXYgKnByb3ZpZGVyLA0KPiAg
IAl9DQo+ICAgDQo+ICAgCWlmIChhY3NfY250KQ0KPiAtCQlyZXR1cm4gLTI7DQo+ICsJCXJldHVy
biBQMlBETUFfTk9UX1NVUFBPUlRFRCB8IFAyUERNQV9BQ1NfRk9SQ0VTX1VQU1RSRUFNOw0KPiAg
IA0KPiAgIAlyZXR1cm4gZGlzdF9hICsgZGlzdF9iOw0KPiAgIH0NCj4gQEAgLTM5NSwxNiArNDA0
LDE3IEBAIHN0YXRpYyBpbnQgdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNlX3dhcm4oc3RydWN0IHBj
aV9kZXYgKnByb3ZpZGVyLA0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+ICAgCXJldCA9
IHVwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZShwcm92aWRlciwgY2xpZW50LCAmYWNzX2xpc3QpOw0K
PiAtCWlmIChyZXQgPT0gLTIpIHsNCj4gLQkJcGNpX3dhcm4oY2xpZW50LCAiY2Fubm90IGJlIHVz
ZWQgZm9yIHBlZXItdG8tcGVlciBETUEgYXMgQUNTIHJlZGlyZWN0IGlzIHNldCBiZXR3ZWVuIHRo
ZSBjbGllbnQgYW5kIHByb3ZpZGVyICglcylcbiIsDQo+ICsJaWYgKHJldCAmIFAyUERNQV9BQ1Nf
Rk9SQ0VTX1VQU1RSRUFNKSB7DQo+ICsJCXBjaV93YXJuKGNsaWVudCwgIkFDUyByZWRpcmVjdCBp
cyBzZXQgYmV0d2VlbiB0aGUgY2xpZW50IGFuZCBwcm92aWRlciAoJXMpXG4iLA0KPiAgIAkJCSBw
Y2lfbmFtZShwcm92aWRlcikpOw0KPiAgIAkJLyogRHJvcCBmaW5hbCBzZW1pY29sb24gKi8NCj4g
ICAJCWFjc19saXN0LmJ1ZmZlclthY3NfbGlzdC5sZW4tMV0gPSAwOw0KPiAgIAkJcGNpX3dhcm4o
Y2xpZW50LCAidG8gZGlzYWJsZSBBQ1MgcmVkaXJlY3QgZm9yIHRoaXMgcGF0aCwgYWRkIHRoZSBr
ZXJuZWwgcGFyYW1ldGVyOiBwY2k9ZGlzYWJsZV9hY3NfcmVkaXI9JXNcbiIsDQo+ICAgCQkJIGFj
c19saXN0LmJ1ZmZlcik7DQo+ICsJfQ0KPiAgIA0KPiAtCX0gZWxzZSBpZiAocmV0IDwgMCkgew0K
PiAtCQlwY2lfd2FybihjbGllbnQsICJjYW5ub3QgYmUgdXNlZCBmb3IgcGVlci10by1wZWVyIERN
QSBhcyB0aGUgY2xpZW50IGFuZCBwcm92aWRlciAoJXMpIGRvIG5vdCBzaGFyZSBhbiB1cHN0cmVh
bSBicmlkZ2VcbiIsDQo+ICsJaWYgKHJldCAmIFAyUERNQV9OT1RfU1VQUE9SVEVEKSB7DQo+ICsJ
CXBjaV93YXJuKGNsaWVudCwgImNhbm5vdCBiZSB1c2VkIGZvciBwZWVyLXRvLXBlZXIgRE1BIGFz
IHRoZSBjbGllbnQgYW5kIHByb3ZpZGVyICglcykgZG8gbm90IHNoYXJlIGFuIHVwc3RyZWFtIGJy
aWRnZSBvciB3aGl0ZWxpc3RlZCBob3N0IGJyaWRnZVxuIiwNCj4gICAJCQkgcGNpX25hbWUocHJv
dmlkZXIpKTsNCj4gICAJfQ0KPiAgIA0KPiBAQCAtNDY4LDcgKzQ3OCw3IEBAIGludCBwY2lfcDJw
ZG1hX2Rpc3RhbmNlX21hbnkoc3RydWN0IHBjaV9kZXYgKnByb3ZpZGVyLCBzdHJ1Y3QgZGV2aWNl
ICoqY2xpZW50cywNCj4gICANCj4gICAJCXBjaV9kZXZfcHV0KHBjaV9jbGllbnQpOw0KPiAgIA0K
PiAtCQlpZiAocmV0IDwgMCkNCj4gKwkJaWYgKHJldCAmIFAyUERNQV9OT1RfU1VQUE9SVEVEKQ0K
PiAgIAkJCW5vdF9zdXBwb3J0ZWQgPSB0cnVlOw0KPiAgIA0KPiAgIAkJaWYgKG5vdF9zdXBwb3J0
ZWQgJiYgIXZlcmJvc2UpDQoNCg==
