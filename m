Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00610210E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 10:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKSJnT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 04:43:19 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSJnS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 04:43:18 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 01A489654C272EF95E42;
        Tue, 19 Nov 2019 17:43:17 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.127]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Tue, 19 Nov 2019 17:43:08 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Thread-Topic: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Thread-Index: AQHVm/iOT4TypEFayEufjCNHcx+zt6eQcDMAgAA1q4CAAPrDAIAAopVg
Date:   Tue, 19 Nov 2019 09:43:08 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED300C5791@dggemm526-mbx.china.huawei.com>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
 <20191115210621.GE4055@ziepe.ca>
 <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
 <20191118170229.GC2149@ziepe.ca>
 <ace6095b-f8ba-80ca-7466-fcbf0c848a33@huawei.com>
In-Reply-To: <ace6095b-f8ba-80ca-7466-fcbf0c848a33@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZn
ZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3Jn
XSBPbiBCZWhhbGYgT2YgTGl1eWl4aWFuIChFYXNvbikNCj4gU2VudDogVHVlc2RheSwgTm92ZW1i
ZXIgMTksIDIwMTkgNDowMCBQTQ0KPiBUbzogSmFzb24gR3VudGhvcnBlDQo+IENjOiBkbGVkZm9y
ZEByZWRoYXQuY29tOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3Jn
Ow0KPiBMaW51eGFybQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIGZvci1uZXh0IDEvMl0gUkRN
QS9obnM6IEFkZCB0aGUgd29ya3F1ZXVlDQo+IGZyYW1ld29yayBmb3IgZmx1c2ggY3FlIGhhbmRs
ZXINCj4gDQo+IA0KPiANCj4gT24gMjAxOS8xMS8xOSAxOjAyLCBKYXNvbiBHdW50aG9ycGUgd3Jv
dGU6DQo+ID4gT24gTW9uLCBOb3YgMTgsIDIwMTkgYXQgMDk6NTA6MjRQTSArMDgwMCwgTGl1eWl4
aWFuIChFYXNvbikgd3JvdGU6DQo+ID4+PiBJdCBraW5kIG9mIGxvb2tzIGxpa2UgdGhpcyBjYW4g
YmUgY2FsbGVkIG11bHRpcGxlIHRpbWVzPyBJdCB3b24ndCB3b3JrDQo+ID4+PiByaWdodCB1bmxl
c3MgaXQgaXMgY2FsbGVkIGV4YWN0bHkgb25jZQ0KPiA+Pj4NCj4gPj4+IEphc29uDQo+ID4+DQo+
ID4+IFllcywgeW91IGFyZSByaWdodC4NCj4gPj4NCj4gPj4gU28gSSB0aGluayB0aGUgcmVhc29u
YWJsZSBzb2x1dGlvbiBpcyB0byBhbGxvY2F0ZSBpdCBkeW5hbWljYWxseSwgYW5kIEkgdGhpbmsN
Cj4gPj4gaXQgaXMgYSB2ZXJ5IHZlcnkgbGl0dGxlIGNoYW5jZSB0aGF0IHRoZSBhbGxvY2F0aW9u
IHdpbGwgYmUgZmFpbGVkLiBJZiB0aGlzDQo+IGhhcHBlbmVkLA0KPiA+PiBJIHRoaW5rIHRoZSBh
cHBsaWNhdGlvbiBhbHNvIG5lZWRzIHRvIGJlIG92ZXIuDQo+ID4NCj4gPiBXaHkgZG8geW91IG5l
ZWQgbW9yZSB0aGFuIG9uZSB3b3JrIGluIHBhcmFsbGVsIGZvciB0aGlzPyBPbmNlIHlvdQ0KPiA+
IHN0YXJ0IHRvIG1vdmUgdGhlIEhXIHRvIGVycm9yIHRoYXQgb25seSBoYXMgdG8gaGFwcGVuIG9u
Y2UsIHN1cmVseT8NCj4gPg0KPiA+IEphc29uDQo+ID4NCj4gVGhlIGZsdXNoIG9wZXJhdGlvbiBt
b3ZlcyBRUCwgbm90IHRoZSBIVyB0byBlcnJvci4NCj4gDQo+IEZvciB0aGUgUVAsIG1heWJlIHRo
ZSBwcm9jZXNzIEEgaXMgcG9zdGluZyBzZW5kIHdoaWxlIHRoZSBvdGhlcg0KPiBwcm9jZXNzIEIg
aXMgbW9kaWZ5aW5nIHFwIHRvIGVycm9yLCBib3RoIG9mIHRoZXNlIHR3byBvcGVyYXRpb24NCj4g
bmVlZHMgdG8gaW5pdGlhbGl6ZSBvbmUgZmx1c2ggd29yay4gVGhhdCdzIHdoeSBpdCBjb3VsZCBi
ZSBjYWxsZWQNCj4gbXVsdGlwbGUgdGltZXMuDQo+IA0KPiBGdXJ0aGVybW9yZSwgYWNjb3JkaW5n
IHRvIElCIHByb3RvY29sIDkuOS4yLjQuMiwgaXQgbWF5IGNhbid0IHN0b3ANCj4gcG9zdGluZyB3
ciBpbnRvIHRoZSBxcCBldmVuIGl0IGFscmVhZHkgdHJhbnNpdGlvbnMgdG8gZXJyb3Igc3RhdGUu
DQo+IFRoYXQncyB3aHkgaXQgYWxzbyBuZWVkcyB0byBiZSBjYWxsZWQgbXVsdGlwbGUgdGltZXMu
DQo+IA0KPiBPbmNlIHRoZSB3b3JrIGlzIGltcGxlbWVudGVkIHN1Y2Nlc3NmdWxseSwgd2Ugd2ls
bCBmcmVlIHRoZSB3b3JrLA0KPiBpdCBpcyBub3QgYSBiaWcgcHJvYmxlbSB0byBhbGxvY2F0ZSBp
dCBkeW5hbWljYWxseSBhZ2FpbiBhbmQgYWdhaW4uDQo+IA0KDQpTbyBjYW4gaSB1bmRlcnN0YW5k
IHRoYXQgdGhpcyBmdW5jdGlvbiBpcyBkZXNpZ25lZCB0byBiZSByZWVudHJhbnQ/DQpJZiBzbywg
SSBzdWdnZXN0IHRvIGludHJvZHVjZSBhIHBlciBkZXYvcXAgbG9jayB0byBwcm90ZWN0Lg0KDQo+
IFRoYW5rcy4NCj4gDQo+IA0KDQo=
