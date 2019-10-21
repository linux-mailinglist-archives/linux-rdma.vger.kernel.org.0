Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349BDDF47A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfJURoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 13:44:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:39757 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJURoQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 13:44:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="191182913"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2019 10:44:15 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 10:44:09 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.139]) by
 FMSMSX102.amr.corp.intel.com ([169.254.10.231]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 10:44:09 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: RE: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Thread-Topic: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Thread-Index: AQHVh7TCl3yVX+llIEiJz4mtL+DEw6dlmJGAgAAl4ID//5KrUA==
Date:   Mon, 21 Oct 2019 17:44:09 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7B6B0D6EE@fmsmsx124.amr.corp.intel.com>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org> <20191021141039.GC25178@ziepe.ca>
 <61d89948-de40-5e6b-f368-353476292093@acm.org>
In-Reply-To: <61d89948-de40-5e6b-f368-353476292093@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmI1NzNjZmQtMmQ3ZS00NmQzLWJjYWUtYjdiNzZjYTE0OGU3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTjBXWmhxdkJGMHpNcHBiQ2pxeVB5MnFcL3NKS1ZqQ2QyUk01XC9ka1BicHFoKzl3VUNURzZPTU1WQzhSVXZsdEloIn0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gUkRNQS9jb3JlOiBTZXQgRE1BIHBhcmFtZXRlcnMg
Y29ycmVjdGx5DQo+IA0KPiBPbiAxMC8yMS8xOSA3OjEwIEFNLCBKYXNvbiBHdW50aG9ycGUgd3Jv
dGU6DQo+ID4gT24gU3VuLCBPY3QgMjAsIDIwMTkgYXQgMDc6MTA6MjhQTSAtMDcwMCwgQmFydCBW
YW4gQXNzY2hlIHdyb3RlOg0KPiA+PiBUaGUgZWZmZWN0IG9mIHRoZSBkbWFfc2V0X21heF9zZWdf
c2l6ZSgpIGNhbGwgaW4gc2V0dXBfZG1hX2RldmljZSgpDQo+ID4+IGlzIGFzIGZvbGxvd3M6DQo+
ID4+IC0gSWYgZGV2aWNlLT5kZXYuZG1hX3Bhcm1zIGlzIE5VTEwsIHRoYXQgY2FsbCBoYXMgbm8g
ZWZmZWN0IGF0IGFsbC4NCj4gPj4gLSBJZiBkZXZpY2UtPmRldi5kbWFfcGFybXMgaXMgbm90IE5V
TEwsIHNpbmNlIHRoYXQgcG9pbnRlciBwb2ludHMgYXQNCj4gPj4gICAgdGhlIERNQSBwYXJhbWV0
ZXJzIG9mIHRoZSBwYXJlbnQgZGV2aWNlLCBtb2RpZnkgdGhlIERNQSBsaW1pdHMgb2YgdGhlDQo+
ID4+ICAgIHBhcmVudCBkZXZpY2UuDQo+ID4+DQo+ID4+IEJvdGggYWN0aW9ucyBhcmUgd3Jvbmcu
IEluc3RlYWQgb2YgY2hhbmdpbmcgdGhlIERNQSBwYXJhbWV0ZXJzIG9mIHRoZQ0KPiA+PiBwYXJl
bnQgZGV2aWNlLCB1c2UgdGhlIERNQSBwYXJhbWV0ZXJzIG9mIHRoZSBwYXJlbnQgZGV2aWNlIGlm
IHRoZXNlDQo+ID4+IHBhcmFtZXRlcnMgYXJlIGF2YWlsYWJsZS4NCj4gPj4NCj4gPj4gQ29tcGls
ZS10ZXN0ZWQgb25seS4NCj4gPj4NCj4gPj4gQ2M6IE1pY2hhZWwgSi4gUnVobCA8bWljaGFlbC5q
LnJ1aGxAaW50ZWwuY29tPg0KPiA+PiBDYzogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29t
Pg0KPiA+PiBDYzogQWRpdCBSYW5hZGl2ZSA8YWRpdHJAdm13YXJlLmNvbT4NCj4gPj4gQ2M6IFNo
aXJheiBTYWxlZW0gPHNoaXJhei5zYWxlZW1AaW50ZWwuY29tPg0KPiA+PiBDYzogR2FsIFByZXNz
bWFuIDxnYWxwcmVzc0BhbWF6b24uY29tPg0KPiA+PiBDYzogU2VsdmluIFhhdmllciA8c2Vsdmlu
LnhhdmllckBicm9hZGNvbS5jb20+DQo+ID4+IEZpeGVzOiBkMTBiY2Y5NDdhM2UgKCJSRE1BL3Vt
ZW06IENvbWJpbmUgY29udGlndW91cyBQQUdFX1NJWkUgcmVnaW9ucw0KPiA+PiBpbiBTR0VzIikN
Cj4gPj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+
DQo+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmMgfCAxMyArKysrKysrKysr
Ky0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZp
Y2UuYw0KPiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jDQo+ID4+IGluZGV4
IDUzNjMxMGZiNjUxMC4uYjMzZDY4NGEyYTk5IDEwMDY0NA0KPiA+PiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPiA+PiBAQCAtMTE5OSw5ICsxMTk5LDE4IEBAIHN0YXRp
YyB2b2lkIHNldHVwX2RtYV9kZXZpY2Uoc3RydWN0IGliX2RldmljZQ0KPiAqZGV2aWNlKQ0KPiA+
PiAgIAkJV0FSTl9PTl9PTkNFKCFwYXJlbnQpOw0KPiA+PiAgIAkJZGV2aWNlLT5kbWFfZGV2aWNl
ID0gcGFyZW50Ow0KPiA+PiAgIAl9DQo+ID4+IC0JLyogU2V0dXAgZGVmYXVsdCBtYXggc2VnbWVu
dCBzaXplIGZvciBhbGwgSUIgZGV2aWNlcyAqLw0KPiA+PiAtCWRtYV9zZXRfbWF4X3NlZ19zaXpl
KGRldmljZS0+ZG1hX2RldmljZSwgU1pfMkcpOw0KPiA+Pg0KPiA+PiArCWlmICghZGV2aWNlLT5k
ZXYuZG1hX3Bhcm1zKSB7DQo+ID4+ICsJCWlmIChwYXJlbnQpIHsNCj4gPj4gKwkJCS8qDQo+ID4+
ICsJCQkgKiBUaGUgY2FsbGVyIGRpZCBub3QgcHJvdmlkZSBETUEgcGFyYW1ldGVycy4gVXNlIHRo
ZQ0KPiA+PiArCQkJICogRE1BIHBhcmFtZXRlcnMgb2YgdGhlIHBhcmVudCBkZXZpY2UuDQo+ID4+
ICsJCQkgKi8NCj4gPj4gKwkJCWRldmljZS0+ZGV2LmRtYV9wYXJtcyA9IHBhcmVudC0+ZG1hX3Bh
cm1zOw0KPiA+PiArCQl9IGVsc2Ugew0KPiA+PiArCQkJV0FSTl9PTl9PTkNFKHRydWUpOw0KPiA+
PiArCQl9DQo+ID4+ICsJfQ0KPiA+PiAgIH0NCj4gPg0KPiA+IFdlIHJlYWxseSBkbyB3YW50IHRv
LCBieSBkZWZhdWx0LCBpbmNyZWFzZSB0aGUgbWF4X3NlZ19zaXplIGFib3ZlIDY0aw0KPiA+IHRo
b3VnaCwgc28gdGhpcyBhcHByb2FjaCBkb2Vzbid0IHNlZW0gcmlnaHQgZWl0aGVyLg0KPiANCj4g
SG93IGFib3V0IHJlcGxhY2luZyB0aGlzIHBhdGNoIGJ5IHRoZSBwYXRjaCBiZWxvdyBhbmQgYnkg
bW92aW5nIHRoaXMgcGF0Y2ggdG8NCj4gdGhlIGVuZCBvZiB0aGlzIHNlcmllcz8NCj4gDQo+IFRo
YW5rcywNCj4gDQo+IEJhcnQuDQo+IA0KPiANCj4gU3ViamVjdDogW1BBVENIXSBSRE1BL2NvcmU6
IFNldCBETUEgcGFyYW1ldGVycyBjb3JyZWN0bHkNCj4gDQo+IFRoZSBkbWFfc2V0X21heF9zZWdf
c2l6ZSgpIGNhbGwgaW4gc2V0dXBfZG1hX2RldmljZSgpIGRvZXMgbm90IGhhdmUgYW55IGVmZmVj
dA0KPiBzaW5jZSBkZXZpY2UtPmRldi5kbWFfcGFybXMgaXMgTlVMTC4gRml4IHRoaXMgYnkgaW5p
dGlhbGl6aW5nDQo+IGRldmljZS0+ZGV2LmRtYV9wYXJtcyBmaXJzdC4NCj4gDQo+IENjOiBNaWNo
YWVsIEouIFJ1aGwgPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT4NCj4gQ2M6IElyYSBXZWlueSA8
aXJhLndlaW55QGludGVsLmNvbT4NCj4gQ2M6IEFkaXQgUmFuYWRpdmUgPGFkaXRyQHZtd2FyZS5j
b20+DQo+IENjOiBTaGlyYXogU2FsZWVtIDxzaGlyYXouc2FsZWVtQGludGVsLmNvbT4NCj4gQ2M6
IEdhbCBQcmVzc21hbiA8Z2FscHJlc3NAYW1hem9uLmNvbT4NCj4gQ2M6IFNlbHZpbiBYYXZpZXIg
PHNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tPg0KPiBGaXhlczogZDEwYmNmOTQ3YTNlICgiUkRN
QS91bWVtOiBDb21iaW5lIGNvbnRpZ3VvdXMgUEFHRV9TSVpFIHJlZ2lvbnMgaW4NCj4gU0dFcyIp
DQo+IFNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYyB8IDE2ICsrKysrKysr
KysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2Uu
YyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jDQo+IGluZGV4IGE2Njc2MzZmNzRi
Zi4uYTUyM2Q4NDRhZDlkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9k
ZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPiBAQCAt
MTE5OSw5ICsxMTk5LDIxIEBAIHN0YXRpYyB2b2lkIHNldHVwX2RtYV9kZXZpY2Uoc3RydWN0IGli
X2RldmljZSAqZGV2aWNlKQ0KPiAgIAkJV0FSTl9PTl9PTkNFKCFwYXJlbnQpOw0KPiAgIAkJZGV2
aWNlLT5kbWFfZGV2aWNlID0gcGFyZW50Ow0KPiAgIAl9DQo+IC0JLyogU2V0dXAgZGVmYXVsdCBt
YXggc2VnbWVudCBzaXplIGZvciBhbGwgSUIgZGV2aWNlcyAqLw0KPiAtCWRtYV9zZXRfbWF4X3Nl
Z19zaXplKGRldmljZS0+ZG1hX2RldmljZSwgU1pfMkcpOw0KPiANCj4gKwlpZiAoIWRldmljZS0+
ZGV2LmRtYV9wYXJtcykgew0KPiArCQlpZiAocGFyZW50KSB7DQo+ICsJCQkvKg0KPiArCQkJICog
VGhlIGNhbGxlciBkaWQgbm90IHByb3ZpZGUgRE1BIHBhcmFtZXRlcnMsIHNvDQo+ICsJCQkgKiAn
cGFyZW50JyBwcm9iYWJseSByZXByZXNlbnRzIGEgUENJIGRldmljZS4gVGhlIFBDSQ0KPiArCQkJ
ICogY29yZSBzZXRzIHRoZSBtYXhpbXVtIHNlZ21lbnQgc2l6ZSB0byA2NA0KPiArCQkJICogS0Iu
IEluY3JlYXNlIHRoaXMgcGFyYW1ldGVyIHRvIDJHLg0KPiArCQkJICovDQo+ICsJCQlkZXZpY2Ut
PmRldi5kbWFfcGFybXMgPSBwYXJlbnQtPmRtYV9wYXJtczsNCj4gKwkJCWRtYV9zZXRfbWF4X3Nl
Z19zaXplKGRldmljZS0+ZG1hX2RldmljZSwgU1pfMkcpOw0KDQpEaWQgeW91IG1lYW4gZG1hX3Nl
dF9tYXhfc2VnX3NpemUoJmRldmljZS0+ZGV2LCBTWl8yRyk/DQoNCmRldmljZS0+ZG1hX2Rldmlj
ZSBjb3VsZCBiZSBwb2ludGluZyB0byBwYXJlbnQgaWYgdGhlIGNhbGxlcg0KZGlkIG5vdCBwcm92
aWRlIGRtYV9vcHMuIFNvIHdvbnQgdGhpcyB1cGRhdGUgdGhlIHBhcmVudCBkZXZpY2UNCmRtYSBw
YXJhbXM/DQoNCkFsc28gZG8gd2Ugd2FudCB0byBlbnN1cmUgYWxsIGNhbGxlcnMgZGV2aWNlIG1h
eF9zZWdfc3oNCnBhcmFtcyA+PSB0aHJlc2hvbGQgKD0yRyk/IElmIHNvLCBwZXJoYXBzIHdlIGNh
biBkbyBzb21ldGhpbmcNCnNpbWlsYXIgdG8gdmIyX2RtYV9jb250aWdfc2V0X21heF9zZWdfc2l6
ZSgpDQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQtcmMyL3NvdXJjZS9k
cml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1jb250aWcuYyNMNzM0
DQoNCg0KDQo=
