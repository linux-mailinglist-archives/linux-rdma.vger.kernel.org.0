Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB3CBFEE
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbfJDQAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 12:00:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:51953 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389773AbfJDQAO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 12:00:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 09:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="182753352"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga007.jf.intel.com with ESMTP; 04 Oct 2019 09:00:13 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.170]) by
 FMSMSX108.amr.corp.intel.com ([169.254.9.205]) with mapi id 14.03.0439.000;
 Fri, 4 Oct 2019 09:00:13 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-5.4] RDMA/i40iw: Associate ibdev to netdev before IB
 device registration
Thread-Topic: [PATCH for-5.4] RDMA/i40iw: Associate ibdev to netdev before
 IB device registration
Thread-Index: AQHVc8DAMcYJLi+csEWFzsiIDPEjuqc9MgkAgA1+HtA=
Date:   Fri, 4 Oct 2019 16:00:13 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7B5CD869B@fmsmsx124.amr.corp.intel.com>
References: <20190925164524.856-1-shiraz.saleem@intel.com>
 <327441aa-3991-b55b-aa71-7deff4ad6ed2@gmail.com>
In-Reply-To: <327441aa-3991-b55b-aa71-7deff4ad6ed2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTA2NjBkOWYtNzkzMy00NjBjLWIxYmYtZGJiNjVhZmU0NDAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiREpBQ3ZWNlNCelhLNmlZOEYxOExaK3FcL3hNYys5dXhMdGt1UVBcL0k5YXQ5enVLbG9BamRweHd0dTg0dzFXKzBJIn0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIGZvci01LjRdIFJETUEvaTQwaXc6IEFzc29jaWF0ZSBpYmRl
diB0byBuZXRkZXYgYmVmb3JlIElCDQo+IGRldmljZSByZWdpc3RyYXRpb24NCj4gDQo+IA0KPiAN
Cj4gT24gOS8yNS8xOSA3OjQ1IFBNLCBTaGlyYXogU2FsZWVtIHdyb3RlOg0KPiA+IEZyb206ICJT
aGlyYXosIFNhbGVlbSIgPHNoaXJhei5zYWxlZW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gaTQwaXcg
SUIgZGV2aWNlIHJlZ2lzdHJhdGlvbiBmYWlscyB3aXRoIEVOT0RFVi4NCj4gPg0KPiA+IGliX3Jl
Z2lzdGVyX2RldmljZQ0KPiA+ICBzZXR1cF9kZXZpY2Uvc2V0dXBfcG9ydF9kYXRhDQo+ID4gICBp
NDBpd19wb3J0X2ltbXV0YWJsZQ0KPiA+ICAgIGliX3F1ZXJ5X3BvcnQNCj4gPiAgICAgIGl3X3F1
ZXJ5X3BvcnQNCj4gPiAgICAgICBpYl9kZXZpY2VfZ2V0X25ldGRldihFTk9ERVYpDQo+ID4NCj4g
PiBpYl9kZXZpY2VfZ2V0X25ldGRldigpIGRvZXMgbm90IGhhdmUgYSBuZXRkZXYgYXNzb2NpYXRl
ZCB3aXRoIHRoZQ0KPiA+IGliZGV2IGFuZCB0aHVzIGZhaWxzLg0KPiA+IFVzZSBpYl9kZXZpY2Vf
c2V0X25ldGRldigpIHRvIGFzc29jaWF0ZSBuZXRkZXYgdG8gaWJkZXYgaW4gaTQwaXcNCj4gPiBi
ZWZvcmUgSUIgZGV2aWNlIHJlZ2lzdHJhdGlvbi4NCj4gPg0KPiA+IEZpeGVzOiA0OTI5MTE2YmRm
NzIgKCJSRE1BL2NvcmU6IEFkZCBjb21tb24gaVdBUlAgcXVlcnkgcG9ydCIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hpcmF6LCBTYWxlZW0gPHNoaXJhei5zYWxlZW1AaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvaTQwaXcvaTQwaXdfdmVyYnMuYyB8IDQgKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2k0MGl3L2k0MGl3X3ZlcmJzLmMNCj4gPiBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9pNDBpdy9pNDBpd192ZXJicy5jDQo+ID4gaW5kZXggODA1Njkz
MC4uY2Q5ZWUxNjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2k0MGl3
L2k0MGl3X3ZlcmJzLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaTQwaXcvaTQw
aXdfdmVyYnMuYw0KPiA+IEBAIC0yNzczLDYgKzI3NzMsMTAgQEAgaW50IGk0MGl3X3JlZ2lzdGVy
X3JkbWFfZGV2aWNlKHN0cnVjdCBpNDBpd19kZXZpY2UNCj4gKml3ZGV2KQ0KPiA+ICAJCXJldHVy
biAtRU5PTUVNOw0KPiA+ICAJaXdpYmRldiA9IGl3ZGV2LT5pd2liZGV2Ow0KPiA+ICAJcmRtYV9z
ZXRfZGV2aWNlX3N5c2ZzX2dyb3VwKCZpd2liZGV2LT5pYmRldiwgJmk0MGl3X2F0dHJfZ3JvdXAp
Ow0KPiA+ICsJcmV0ID0gaWJfZGV2aWNlX3NldF9uZXRkZXYoJml3aWJkZXYtPmliZGV2LCBpd2Rl
di0+bmV0ZGV2LCAxKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZ290byBlcnJvcjsNCj4gPiAr
DQo+ID4gIAlyZXQgPSBpYl9yZWdpc3Rlcl9kZXZpY2UoJml3aWJkZXYtPmliZGV2LCAiaTQwaXcl
ZCIpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlnb3RvIGVycm9yOw0KPiA+DQo+IA0KPiBUaGFu
a3MhDQo+IA0KPiBSZXZpZXdlZC1ieTogS2FtYWwgSGVpYiA8a2FtYWxoZWliMUBnbWFpbC5jb20+
DQoNCkhpIEphc29uIG9yIERvdWcgLSBUaGlzIHdhcyBhIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBp
biA1LjQgd2hpY2ggYnJlYWtzIGk0MGl3LiBDYW4geW91IHBpY2sgdGhpcyB1cCBmb3IgNS40LXJj
Pw0KDQpTaGlyYXoNCg==
