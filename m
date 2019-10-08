Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73382CF534
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 10:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfJHInN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 04:43:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2429 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729767AbfJHInN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 04:43:13 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id BF1B2B152279FE775659;
        Tue,  8 Oct 2019 16:43:10 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 8 Oct 2019 16:43:10 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.8]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0439.000;
 Tue, 8 Oct 2019 16:43:03 +0800
From:   liweihang <liweihang@hisilicon.com>
To:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: RE: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
        when hw err
Thread-Topic: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
        when hw err
Thread-Index: AQHVUSLjL8u375XtlUemFDafjnojDKb5o2qAgACXgQCAAD4ugIAHyKoAgE6DVBA=
Date:   Tue, 8 Oct 2019 08:43:02 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A020DA8C3@DGGEML522-MBX.china.huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
        <1565343666-73193-4-git-send-email-oulijun@huawei.com>
        <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
        <0d325f78-a929-f088-cc29-e2c7af98fd40@huawei.com>
        <f1609a31d9b0d1cdc3b2db38dda1543126755007.camel@redhat.com>
        <20190814184737.GB5893@mtr-leonro.mtl.com>
 <3d51b645485b861ff7b20108c638de37e29b4c0f.camel@redhat.com>
In-Reply-To: <3d51b645485b861ff7b20108c638de37e29b4c0f.camel@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXhhcm0gW21haWx0
bzpsaW51eGFybS1ib3VuY2VzQGh1YXdlaS5jb21dIE9uIEJlaGFsZiBPZiBEb3VnDQo+IExlZGZv
cmQNCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIwLCAyMDE5IDE6NDAgQU0NCj4gVG86IExlb24g
Um9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5l
bC5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gamdnQHppZXBlLmNhDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggZm9yLW5leHQgMy85XSBSRE1BL2huczogQ29tcGxldGVseSBy
ZWxlYXNlIHFwDQo+IHJlc291cmNlcyB3aGVuIGh3IGVycg0KPiANCj4gT24gV2VkLCAyMDE5LTA4
LTE0IGF0IDIxOjQ3ICswMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gT24gV2VkLCBB
dWcgMTQsIDIwMTkgYXQgMTE6MDU6MDRBTSAtMDQwMCwgRG91ZyBMZWRmb3JkIHdyb3RlOg0KPiA+
ID4gT24gV2VkLCAyMDE5LTA4LTE0IGF0IDE0OjAyICswODAwLCBZYW5neWFuZyBMaSB3cm90ZToN
Cj4gPiA+ID4gPiBJIGRvbid0IGtub3cgeW91ciBoYXJkd2FyZSwgYnV0IHRoaXMgcGF0Y2ggc291
bmRzDQo+ID4gPiA+ID4gd3JvbmcvZGFuZ2Vyb3VzIHRvIG1lLg0KPiA+ID4gPiA+IEFzIGxvbmcg
YXMgdGhlIHJlc291cmNlcyB0aGlzIGNhcmQgbWlnaHQgYWNjZXNzIGFyZSBhbGxvY2F0ZWQgYnkN
Cj4gPiA+ID4gPiB0aGUga2VybmVsLCB5b3UgY2FuJ3QgZ2V0IHJhbmRvbSBkYXRhIGNvcnJ1cHRp
b24gYnkgdGhlIGNhcmQNCj4gPiA+ID4gPiB3cml0aW5nIHRvIG1lbW9yeSB1c2VkIGVsc2V3aGVy
ZSBpbiB0aGUga2VybmVsLiAgU28gaWYgeW91ciBjYXJkDQo+ID4gPiA+ID4gaXMgbm90IHJlc3Bv
bmRpbmcgdG8geW91ciByZXF1ZXN0cyB0byBmcmVlIHRoZSByZXNvdXJjZXMsIGl0DQo+ID4gPiA+
ID4gd291bGQgc2VlbSBzYWZlciB0byBsZWFrIHRob3NlIHJlc291cmNlcyBwZXJtYW5lbnRseSB0
aGFuIHRvDQo+ID4gPiA+ID4gZnJlZSB0aGVtIGFuZCByaXNrIHRoZSBjYXJkIGNvbWluZyBiYWNr
IHRvIGxpZmUgbG9uZyBlbm91Z2ggdG8NCj4gPiA+ID4gPiBjb3JydXB0IG1lbW9yeSByZWFsbG9j
YXRlZCB0byBzb21lIG90aGVyIHRhc2suDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbmx5IGlmIHlv
dSBjYW4gZ3VhcmFudGVlIG1lIHRoYXQgdGhlcmUgaXMgbm8gd2F5IHlvdXIgY29tbWFuZHMNCj4g
PiA+ID4gPiB0byB0aGUgY2FyZCB3aWxsIGZhaWwgYW5kIHRoZW4gdGhlIGNhcmQgc3RhcnQgd29y
a2luZyBhZ2Fpbg0KPiA+ID4gPiA+IGxhdGVyIHdvdWxkIEkgY29uc2lkZXIgdGhpcyBwYXRjaCBz
YWZlLiAgQW5kIGlmIGl0J3MgcG9zc2libGUNCj4gPiA+ID4gPiBmb3IgdGhlIGNhcmQgdG8gaGFu
ZyBsaWtlIHRoaXMsIHNob3VsZCB0aGF0IGJlIHRyaWdnZXJpbmcgYQ0KPiA+ID4gPiA+IHJlc2V0
IG9mIHRoZSBkZXZpY2U/DQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB5
b3VyIHN1Z2dlc3Rpb24sIEkgYWdyZWUgd2l0aCB5b3UsIGl0IHdvdWxkIHNlZW0gc2FmZXINCj4g
PiA+ID4gdG8gbGVhayB0aG9zZSByZXNvdXJjZXMgcGVybWFuZW50bHkgdGhhbiB0byBmcmVlIHRo
ZW0uIEkgd2lsbA0KPiA+ID4gPiBhYmFuZG9uIHRoaXMgY2hhbmdlIGFuZCBjb25zaWRlciBjbGVh
bmluZyB1cCB0aGVzZSBsZWFrZWQNCj4gPiA+ID4gcmVzb3VyY2VzIGR1cmluZyB1bmluc3RhbGxh
dGlvbiBvciByZXNldC4NCj4gPiA+DQo+ID4gPiBPaywgcGF0Y2ggZHJvcHBlZCBmcm9tIHBhdGNo
d29ya3MsIHRoYW5rcy4NCj4gPg0KPiA+IFNvcnJ5IGZvciBiZWluZyBsYXRlLCBidXQgSSBkb24n
dCBsaWtlIHRoZSBpZGVhIG9mIGhhdmluZyBsZWFrZWQNCj4gPiBtZW1vcnkuDQo+ID4NCj4gPiBB
bGwgbXkgYWxsb2NhdGlvbiBwYXRjaGVzIGFyZSBhY3R1YWxseSB0cnlpbmcgdG8gYXZvaWQgc3Vj
aCBzaXR1YXRpb24NCj4gPiBieSBlbnN1cmluZyB0aGF0IG5vIGRyaXZlciBkb2VzIGNyYXp5IHN0
dWZmIGxpa2UgdGhpcy4gSXQgbWVhbnMgdGhhdA0KPiA+IG9uY2UgSSdsbCBoYXZlIHRpbWUgdG8g
d29yayBvbiBRUCBhbGxvY2F0aW9ucywgSSdsbCBlbnN1cmUgdGhhdCBtZW1vcnkNCj4gPiBpcyBm
cmVlZCwgc28gaXQgaXMgYmV0dGVyIHRvIGZyZWUgc3VjaCBtZW1vcnkgbm93Lg0KPiANCj4gWW91
IGNhbid0IGZyZWUgc29tZXRoaW5nIGlmIHRoZSBjYXJkIG1pZ2h0IHN0aWxsIGFjY2VzcyBpdC4g
IEEgbGVhayBpcyBhbHdheXMNCj4gcHJlZmVyYWJsZSB0byBkYXRhIGNvcnJ1cHRpb24uDQo+IA0K
DQpIaSBEb3VnLA0KDQpXZSBjYW4gY29uZmlybSB0aGF0IGhpcDA4IGhhcmR3YXJlIHdvbid0IHN0
YXJ0IHdvcmtpbmcgYWdhaW4gd2hlbiBmYWlsZWQNCnRvIGRlc3Ryb3kgYWZ0ZXIgY29uc2lkZXJp
bmcgYWxsIHBvc3NpYmxlIHNpdHVhdGlvbnMuIFNvIGl0IGlzIHNhZmUgdG8gZnJlZSBxcA0KcmVz
b3VyY2VzICBldmVuIGlmIHRoZSBkZXN0cm95IGNvbW1hbmQgZmFpbGVkIGV4ZWN1dGVkLiBJIHdp
bGwgcmVzZW5kIHRoaXMNCnBhdGNoIHRvIGF2b2lkIG1lbW9yeSBsZWFrcyBhcyBKYXNvbiBhc2tl
ZC4NCg0KVGhhbmtzLA0KV2VpaGFuZw0KDQo+IC0tDQo+IERvdWcgTGVkZm9yZCA8ZGxlZGZvcmRA
cmVkaGF0LmNvbT4NCj4gICAgIEdQRyBLZXlJRDogQjgyNkEzMzMwRTU3MkZERA0KPiAgICAgRmlu
Z2VycHJpbnQgPSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2NUIgIDEyNzQgQjgyNiBBMzMzIDBFNTcg
MkZERA0K
