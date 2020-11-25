Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3F2C35E7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 02:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgKYBEp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 20:04:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:58506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgKYBEp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 20:04:45 -0500
IronPort-SDR: D0Fklotj6bk1Q9q9P5qIB0OdJSt7dw9PzB8WJh2NxmzYf+gu6MSsvoLUnzHyefBY3DiLZXVcFt
 Pq/WXVJI0m5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="168534367"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="168534367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 17:04:44 -0800
IronPort-SDR: fo/Uug6qey5wgrm3NIUGKPX4D7mDfSvcl9DbIcDH/LjwlsuUJhB48/EFHMIll3aV7nun6lRz3e
 /kUYCyTe6MNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="343388202"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2020 17:04:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 17:04:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 17:04:43 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 24 Nov 2020 17:04:43 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        Di Zhu <zhudi21@huawei.com>
Subject: RE: [PATCH v1 1/2] RDMA/i40iw: Address an mmap handler exploit in
 i40iw
Thread-Topic: [PATCH v1 1/2] RDMA/i40iw: Address an mmap handler exploit in
 i40iw
Thread-Index: AQHWwrzhhYicmCuT5kWM/DvcWPdmQ6nYfowA//+JmTA=
Date:   Wed, 25 Nov 2020 01:04:43 +0000
Message-ID: <a935ec3699744af6a282e1897ef52565@intel.com>
References: <20201124235102.1745-1-shiraz.saleem@intel.com>
 <20201124235102.1745-2-shiraz.saleem@intel.com>
 <20201125000726.GG4800@nvidia.com>
In-Reply-To: <20201125000726.GG4800@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMl0gUkRNQS9pNDBpdzogQWRkcmVzcyBhbiBtbWFw
IGhhbmRsZXIgZXhwbG9pdCBpbg0KPiBpNDBpdw0KPiANCj4gT24gVHVlLCBOb3YgMjQsIDIwMjAg
YXQgMDU6NTE6MDJQTSAtMDYwMCwgU2hpcmF6IFNhbGVlbSB3cm90ZToNCj4gPiBpNDBpd19tbWFw
IG1hbmlwdWxhdGVzIHRoZSB2bWEtPnZtX3Bnb2ZmIHRvIGRpZmZlcmVudGlhdGUgYSBwdXNoIHBh
Z2UNCj4gPiBtbWFwIHZzIGEgZG9vcmJlbGwgbW1hcCwgYW5kIHVzZXMgaXQgdG8gY29tcHV0ZSB0
aGUgcGZuIGluDQo+ID4gcmVtYXBfcGZuX3JhbmdlIHdpdGhvdXQgYW55IHZhbGlkYXRpb24uIFRo
aXMgaXMgdnVsbmVyYWJsZSB0byBhbiBtbWFwDQo+ID4gZXhwbG9pdCBhcyBkZXNjcmliZWQgaW4g
WzFdLg0KPiA+DQo+ID4gUHVzaCBmZWF0dXJlIGlzIGRpc2FibGVkIGluIHRoZSBkcml2ZXIgY3Vy
cmVudGx5IGFuZCB0aGVyZWZvcmUgbm8gcHVzaA0KPiA+IG1tYXBzIGFyZSBpc3N1ZWQgZnJvbSB1
c2VyLXNwYWNlLiBUaGUgZmVhdHVyZSBkb2VzIG5vdCB3b3JrIGFzDQo+ID4gZXhwZWN0ZWQgaW4g
dGhlIHg3MjIgcHJvZHVjdC4NCj4gPg0KPiA+IFJlbW92ZSB0aGUgcHVzaCBtb2R1bGUgcGFyYW1l
dGVyIGFuZCBhbGwgVk1BIGF0dHJpYnV0ZSBtYW5pcHVsYXRpb25zDQo+ID4gZm9yIHRoaXMgZmVh
dHVyZSBpbiBpNDBpd19tbWFwLiBVcGRhdGUgaTQwaXdfbW1hcCB0byBvbmx5IGFsbG93IERCDQo+
ID4gdXNlciBtbWFwaW5ncyBhdCBvZmZzZXQgPSAwLiBDaGVjayB2bV9wZ29mZiBmb3IgemVybyBh
bmQgaWYgdGhlIG1tYXBzDQo+ID4gYXJlIGJvdW5kIHRvIGEgc2luZ2xlIHBhZ2UuDQo+ID4NCj4g
PiBbMV0NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yZG1hLzIwMjAxMTE5MDkz
NTIzLjc1ODgtMS16aHVkaTIxQGh1YXdlDQo+ID4gaS5jb20vcmF3DQo+ID4NCj4gPiBGaXhlczog
ZDM3NDk4NDE3OTQ3ICgiaTQwaXc6IGFkZCBmaWxlcyBmb3IgaXdhcnAgaW50ZXJmYWNlIikNCj4g
PiBDYzogc3RhYmxlQGtlcm5lbC5vcmcNCj4gPiBSZXBvcnRlZC1ieTogRGkgWmh1IDx6aHVkaTIx
QGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpcmF6IFNhbGVlbSA8c2hpcmF6LnNh
bGVlbUBpbnRlbC5jb20+DQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9pNDBpdy9pNDBpd19t
YWluLmMgIHwgICAgNCAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2k0MGl3L2k0MGl3
X3ZlcmJzLmMgfCAgIDM3ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiANCj4gUGxlYXNl
IGNvbXBpbGUgeW91ciBwYXRjaGVzOg0KPiANCj4gZHJpdmVycy9pbmZpbmliYW5kL2h3L2k0MGl3
L2k0MGl3X21haW4uYzogSW4gZnVuY3Rpb24g4oCYaTQwaXdfc2V0dXBfaW5pdF9zdGF0ZeKAmToN
Cj4gZHJpdmVycy9pbmZpbmliYW5kL2h3L2k0MGl3L2k0MGl3X21haW4uYzoxNTc5OjIxOiBlcnJv
cjog4oCYcHVzaF9tb2Rl4oCZIHVuZGVjbGFyZWQNCj4gKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKTsgZGlkIHlvdSBtZWFuIOKAmHVzZXJfbW9kZeKAmT8NCj4gIDE1NzkgfCAgaXdkZXYtPnB1
c2hfbW9kZSA9IHB1c2hfbW9kZTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fg0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgdXNlcl9tb2RlDQo+IGRyaXZlcnMv
aW5maW5pYmFuZC9ody9pNDBpdy9pNDBpd19tYWluLmM6MTU3OToyMTogbm90ZTogZWFjaCB1bmRl
Y2xhcmVkIGlkZW50aWZpZXIgaXMNCj4gcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0
aW9uIGl0IGFwcGVhcnMgaW4NCj4gDQoNClNvcnJ5ISBHb29mZWQgdXAuIEhhZCBvbmx5IGNvbXBp
bGVkIHRoZSBzZXJpZXMuIFNlbnQgdjIuDQo=
