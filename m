Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3B28B61C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgJLNZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:25:38 -0400
Received: from smtp.h3c.com ([60.191.123.50]:10972 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgJLNZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 09:25:37 -0400
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam02-ex.h3c.com with ESMTPS id 09CDOrAF015813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 21:24:53 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 21:24:57 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Mon, 12 Oct 2020 21:24:57 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] IB/hfi1: Avoid allocing memory on memoryless numa node
Thread-Topic: [PATCH] IB/hfi1: Avoid allocing memory on memoryless numa node
Thread-Index: AQHWnuS/GGzJ/pEib0+lVn06jP77D6mTZNmAgACTMhA=
Date:   Mon, 12 Oct 2020 13:24:56 +0000
Message-ID: <3a00a3dced1c400bbe369348e441f7ef@h3c.com>
References: <20201010085732.20708-1-tian.xianting@h3c.com>
 <9ba33073-044c-9da6-a90d-4626e6441793@cornelisnetworks.com>
In-Reply-To: <9ba33073-044c-9da6-a90d-4626e6441793@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09CDOrAF015813
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgRGVubmlzDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cw0KSWYgaXQgZGVwZW5kcyBvbiB4ODZf
NjQsIEkgdGhpbmsgdGhpcyBpc3N1ZSBkb2Vzbid0IGV4aXN0Lg0KU29ycnkgdG8gZGlzdHVyYiB5
b3UuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEZW5uaXMgRGFsZXNzYW5k
cm8gW21haWx0bzpkZW5uaXMuZGFsZXNzYW5kcm9AY29ybmVsaXNuZXR3b3Jrcy5jb21dIA0KU2Vu
dDogTW9uZGF5LCBPY3RvYmVyIDEyLCAyMDIwIDg6MzcgUE0NClRvOiB0aWFueGlhbnRpbmcgKFJE
KSA8dGlhbi54aWFudGluZ0BoM2MuY29tPjsgbWlrZS5tYXJjaW5pc3p5bkBpbnRlbC5jb207IGRl
bm5pcy5kYWxlc3NhbmRyb0BpbnRlbC5jb207IGRsZWRmb3JkQHJlZGhhdC5jb207IGpnZ0B6aWVw
ZS5jYQ0KQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBJQi9oZmkxOiBBdm9pZCBhbGxvY2luZyBt
ZW1vcnkgb24gbWVtb3J5bGVzcyBudW1hIG5vZGUNCg0KT24gMTAvMTAvMjAyMCA0OjU3IEFNLCBY
aWFudGluZyBUaWFuIHdyb3RlOg0KPiBJbiBhcmNoaXRlY3R1cmUgbGlrZSBwb3dlcnBjLCB3ZSBj
YW4gaGF2ZSBjcHVzIHdpdGhvdXQgYW55IGxvY2FsIA0KPiBtZW1vcnkgYXR0YWNoZWQgdG8gaXQu
IEluIHN1Y2ggY2FzZXMgdGhlIG5vZGUgZG9lcyBub3QgaGF2ZSByZWFsIG1lbW9yeS4NCj4gDQo+
IFVzZSBsb2NhbF9tZW1vcnlfbm9kZSgpLCB3aGljaCBpcyBndWFyYW50ZWVkIHRvIGhhdmUgbWVt
b3J5Lg0KPiBsb2NhbF9tZW1vcnlfbm9kZSBpcyBhIG5vb3AgaW4gb3RoZXIgYXJjaGl0ZWN0dXJl
cyB0aGF0IGRvZXMgbm90IA0KPiBzdXBwb3J0IG1lbW9yeWxlc3Mgbm9kZXMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx0aWFuLnhpYW50aW5nQGgzYy5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9oZmkxL2ZpbGVfb3BzLmMgfCAyICstDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2hmaTEvZmlsZV9vcHMuYyANCj4gYi9kcml2ZXJz
L2luZmluaWJhbmQvaHcvaGZpMS9maWxlX29wcy5jDQo+IGluZGV4IDhjYTUxZTQzYy4uNzlmYTIy
Y2M3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaGZpMS9maWxlX29wcy5j
DQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9oZmkxL2ZpbGVfb3BzLmMNCj4gQEAgLTk2
NSw3ICs5NjUsNyBAQCBzdGF0aWMgaW50IGFsbG9jYXRlX2N0eHQoc3RydWN0IGhmaTFfZmlsZWRh
dGEgKmZkLCBzdHJ1Y3QgaGZpMV9kZXZkYXRhICpkZCwNCj4gICAJICovDQo+ICAgCWZkLT5yZWNf
Y3B1X251bSA9IGhmaTFfZ2V0X3Byb2NfYWZmaW5pdHkoZGQtPm5vZGUpOw0KPiAgIAlpZiAoZmQt
PnJlY19jcHVfbnVtICE9IC0xKQ0KPiAtCQludW1hID0gY3B1X3RvX25vZGUoZmQtPnJlY19jcHVf
bnVtKTsNCj4gKwkJbnVtYSA9IGxvY2FsX21lbW9yeV9ub2RlKGNwdV90b19ub2RlKGZkLT5yZWNf
Y3B1X251bSkpOw0KPiAgIAllbHNlDQo+ICAgCQludW1hID0gbnVtYV9ub2RlX2lkKCk7DQo+ICAg
CXJldCA9IGhmaTFfY3JlYXRlX2N0eHRkYXRhKGRkLT5wcG9ydCwgbnVtYSwgJnVjdHh0KTsNCj4g
DQoNClRoZSBoZmkxIGRyaXZlciBkZXBlbmRzIG9uIFg4Nl82NC4gSSdtIG5vdCBzdXJlIHdoYXQg
dGhpcyBwYXRjaCBidXlzLCBjYW4geW91IGV4cGFuZCBhIGJpdD8NCg0KLURlbm55DQo=
