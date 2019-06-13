Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B343CA9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfFMPhM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:37:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfFMKO0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 06:14:26 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id AF4E5D208A0F198970CA;
        Thu, 13 Jun 2019 18:14:23 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Jun 2019 18:14:23 +0800
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 13 Jun 2019 18:14:21 +0800
Received: from lhreml702-chm.china.huawei.com ([10.201.68.197]) by
 lhreml702-chm.china.huawei.com ([10.201.68.197]) with mapi id 15.01.1713.004;
 Thu, 13 Jun 2019 11:14:18 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     John Garry <john.garry@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        "wangxi (M)" <wangxi11@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Thread-Topic: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Thread-Index: AQHVHVDZZTzLZeXBDkqmbcycKUyIGqaQ9yOAgAPd6ACAANzgAIAAN2UAgAHDe4CAADJrAIAAPXFAgAAOCwCAAThSwA==
Date:   Thu, 13 Jun 2019 10:14:18 +0000
Message-ID: <80d4fcee49624b5cba2fcda77f03e74a@huawei.com>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
 <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
 <20190612115226.GC3876@ziepe.ca>
 <443656b7965a4b319e83eb6b9557676e@huawei.com>
 <20190612162236.GL3876@ziepe.ca>
In-Reply-To: <20190612162236.GL3876@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.41]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4
LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgSmFzb24gR3VudGhvcnBl
DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMiwgMjAxOSA1OjIzIFBNDQo+IFRvOiBTYWxpbCBN
ZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gDQo+IE9uIFdlZCwgSnVuIDEyLCAyMDE5
IGF0IDAzOjEyOjI0UE0gKzAwMDAsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiA+ID4gRnJvbTogbGlu
dXgtcmRtYS1vd25lckB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFttYWlsdG86bGludXgtcmRtYS1v
d25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBKYXNvbiBHdW50aG9ycGUNCj4gPiA+
IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMiwgMjAxOSAxMjo1MiBQTQ0KPiA+ID4gVG86IEpvaG4g
R2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gPiA+IENjOiBMZW9uIFJvbWFub3Zza3kg
PGxlb25Aa2VybmVsLm9yZz47IHdhbmd4aSAoTSkgPHdhbmd4aTExQGh1YXdlaS5jb20+Ow0KPiA+
ID4gbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGRsZWRmb3JkQHJlZGhhdC5jb207IExpbnV4
YXJtDQo+ID4gPiA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjQgZm9yLW5leHQgMS8zXSBSRE1BL2huczogQWRkIG10ciBzdXBwb3J0IGZvciBtaXhlZA0K
PiA+ID4gbXVsdGlob3AgYWRkcmVzc2luZw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgSnVuIDEyLCAy
MDE5IGF0IDA5OjUxOjU5QU0gKzAxMDAsIEpvaG4gR2Fycnkgd3JvdGU6DQo+ID4gPiA+IE9uIDEx
LzA2LzIwMTkgMDY6NTYsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUs
IEp1biAxMSwgMjAxOSBhdCAxMDozNzo0OEFNICswODAwLCB3YW5neGkgd3JvdGU6DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IOWcqCAyMDE5LzYvMTAgMjE6MjcsIEphc29u
IEd1bnRob3JwZSDlhpnpgZM6DQo+ID4gPiA+ID4gPiA+IE9uIFNhdCwgSnVuIDA4LCAyMDE5IGF0
IDEwOjI0OjE1QU0gKzA4MDAsIHdhbmd4aSB3cm90ZToNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gPiA+IFdoeSBpcyB0aGVyZSBhbiBFWFBST1RfU1lNQk9MIGluIGEgSUIgZHJpdmVyPyBJ
IHNlZSBtYW55IGluDQo+ID4gPiA+ID4gPiA+ID4gPiBobnMuIFBsZWFzZSBzZW5kIGEgcGF0Y2gg
dG8gcmVtb3ZlIGFsbCBvZiB0aGVtIGFuZCByZXNwaW4gdGhpcy4NCj4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gVGhlcmUgYXJlIDIgbW9kdWxlcyBpbiBvdXIgaWIgZHJpdmVyLCBv
bmUgaXMgaG5zX3JvY2Uua28sIGFub3RoZXINCj4gPiA+ID4gPiA+ID4gPiBpcyBobnNfcm9jZV9o
d192Mi5rby4gYWxsIGV4dGVybiBzeW1ib2xzIGFyZSBuYW1lZCBsaWtlIGhuc19yb2NlX3h4eCwN
Cj4gPiA+ID4gPiA+ID4gPiB0aGlzIGZ1bmN0aW9uIGRlZmluZWQgaW4gaG5zX3JvY2Uua28sIGFu
ZCBpbnZva2VkIGluDQo+ID4gPiA+ID4gPiA+ID4gaG5zX3JvY2VfaHdfdjIua28uDQo+ID4NCj4g
PiBbLi4uXQ0KPiA+DQo+ID4gPiA+IEluIGFkZGl0aW9uIHRvIHRoaXMsIHYxIGh3IGlzIGEgcGxh
dGZvcm0gZGV2aWNlIGRyaXZlciBhbmQgZGVwZW5kcyBvbiBITlMsDQo+ID4gPiA+IHdoaWxlIHYy
IGh3IGlzIGZvciBhIFBDSSBkZXZpY2UgYW5kIGRlcGVuZHMgb24gUENJICYmIEhOUzMuIEF0dGVt
cHRzIHRvDQo+ID4gPiA+IGNvbWJpbmUgaW50byBhIHNpbmdsZSBrbyB3b3VsZCBpbnRyb2R1Y2Ug
bWVzc3kgZGVwZW5kZW5jaWVzIGFuZCBpZmRlZnMuDQo+ID4gPg0KPiA+ID4gSSBzdXNwZWN0IGl0
IHdvdWxkIG5vdCBiZSBhbnkgZGlmZmVyZW50IGZyb20gaG93IGl0IGlzIHRvZGF5LiBEbw0KPiA+
ID4gZXZlcnl0aGluZyB0aGUgc2FtZSwganVzdCBoYXZlIG9uZSBtb2R1bGUgbm90IHRocmVlLiBt
b2R1bGVfaW5pdC9ldGMNCj4gPiA+IGFscmVhZHkgdGFrZSBjYXJlIG9mIGNvbmRpdGlvbmFsIGNv
bXBpbGF0aW9uIG9mIHRoZSBlbnRpcmUgLmMgZmlsZSB2aWENCj4gPiA+IE1ha2VmaWxlDQo+ID4N
Cj4gPiBPa2F5LiBJIHNlZSB5b3VyIHBvaW50Lg0KPiA+DQo+ID4gQXMgSSB1bmRlcnN0YW5kLCB0
aGUgY29kZSB3aXRoaW4gdjEgYW5kIHYyIHdpbGwgYWxtb3N0IG5ldmVyIGJlIHJlcXVpcmVkIG9u
DQo+ID4gdGhlIHNhbWUgc3lzdGVtIHNpbmNlIHRoZXkgYmVsb25nIHRvIGRpZmZlcmVudCB0eXBl
cyBvZiBoYXJkd2FyZSAocGxhdGZvcm0vUENJKS4NCj4gPiBEZXBlbmRlbmN5IGJldHdlZW4gVjEs
IFYyIGFuZCBjb21tb24gY29kZSBpcyBzb21ldGhpbmcgbGlrZSBiZWxvdw0KPiANCj4gcGxhdGZv
cm0gYW5kIFBDSSBjYW4gY28tZXhpc3QgaW4gdGhlIGtlcm5lbCwgdGhlcmUgaXMgbm8gcmVhc29u
IHRvDQo+IHdvcnJ5IGFib3V0IHRoZW0gY28tZXhpc3RpbmcgaW4gdGhlIHNhbWUgZHJpdmVyIG90
aGVyIHRoYW4gbG9hZGVkIGNvZGUNCj4gc2l6ZSwgd2hpY2ggZG9lc24ndCBzZWVtIGxpa2UgYSBi
aWcgZGVhbCBoZXJlLg0KDQoNCk9rLiBJIHRha2UgeW91ciBwb2ludC4gSWYgd2UgaGF2ZSBhbiBv
cHRpb25zIHRoZW4gd2Ugd291bGQgcmF0aGVyIHByZWZlciB0bw0KcmVkdWNlIHRoZSBzaXplIGFz
IHdlbGwgb3RoZXIgdGhhbiBjb252ZXJ0aW5nIGl0IHRvIGEgc2luZ2xlIC5rby4NCg0KDQo+IEFi
b3V0IHRoZSBvbmx5IHRoaW5nIHRoYXQgbWlnaHQgZ2l2ZSBtZSBwYXVzZSBpcyB0aGF0IHYyIGRl
cGVuZHMgb24gYQ0KPiBkaWZmZXJlbnQgZXRoZXJuZXQgbW9kdWxlIHRoYW4gdjEuLiBCdXQgdGhh
dCBkZXBlbmRzIGFsb3Qgb24gc2l6ZSB0b28sDQo+IHRoZXJlIGlzIG5vIGhhcm0gdG8gbG9hZCBh
IHVzZWxlc3MgZXRoZXJuZXQgbW9kdWxlIGlmIGl0IGlzIG5vdCBsYXJnZS4NCg0KWWVzLCB5b3Ug
YXJlIHJpZ2h0LiBUaGF0IGlzIGFub3RoZXIgY29uY2Vybi4gSXQgd291bGQgYmUgdmVyeSBtZXNz
eQ0KdG8gbG9hZCBITlMgJiBITlMzIEV0aGVybmV0IGRyaXZlciB0b2dldGhlciB3aGVuIHdlIGtu
b3cgdGhleSB3aWxsIG5vdA0KYmUgdXNlZCBhbmQgaGF2ZSBiaWcgZGlmZmVyZW5jZXMgaW4gdGhl
aXIgaGFyZHdhcmUuIEFsc28sIEhOUzMgRXRoZXJuZXQNCmRyaXZlciBpcyBiaWcgaW4gc2l6ZS4N
Cg0KQXMgc3VjaCwNCiAgICAgICAgICAgVjEgUm9DRSAtLS0+IEhOUyBFdGhlcm5ldCBEcml2ZXIN
CiAgICAgICAgICAgVjIgUm9DRSAtLS0+IEhOUzMgRXRoZXJuZXQgRHJpdmVyDQoNCg0KU2FsaWwu
DQo=
