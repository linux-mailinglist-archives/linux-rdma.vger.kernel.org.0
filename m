Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346B1339ABD
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Mar 2021 02:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCMBMX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 20:12:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:65381 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCMBLo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 20:11:44 -0500
IronPort-SDR: SLQ2Cy+O+OklBzieis2EPOEG8Itwno8ZUflYMZyKVMMiK8iQIse5/qiYHWvAHVyyWvkdM+AbxK
 IN6/BRbFUEzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168827949"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="168827949"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 17:11:44 -0800
IronPort-SDR: bZDopp5QSiwmzl14HiXGazeBP95hvZGyecn/3xybc+4LUf3V8ZqziUG872GFAPi/sHMasPai8G
 RNqaHBPM0URA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="448792677"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2021 17:11:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 17:11:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 17:11:42 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2106.013;
 Fri, 12 Mar 2021 17:11:42 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "lyl2019@mail.ustc.edu.cn" <lyl2019@mail.ustc.edu.cn>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH] infiniband/i40iw: Fix a use after free in
 i40iw_cm_event_handler
Thread-Topic: RE: [PATCH] infiniband/i40iw: Fix a use after free in
 i40iw_cm_event_handler
Thread-Index: AQHXFiSqLozaSAmrJEO2QxUkby8zNKp/oHYA//+kHnCAANtHAIAAUP6Q
Date:   Sat, 13 Mar 2021 01:11:42 +0000
Message-ID: <eba3dbe9bf734dc0b65b2e65aa8d5bd9@intel.com>
References: <20210311031414.5011-1-lyl2019@mail.ustc.edu.cn>
 <20210311182114.GA2733907@nvidia.com>
 <1fc386d78c044d3da723fe38446edb75@intel.com>
 <43271428.d966.1782426e7a3.Coremail.lyl2019@mail.ustc.edu.cn>
In-Reply-To: <43271428.d966.1782426e7a3.Coremail.lyl2019@mail.ustc.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogUkU6IFtQQVRDSF0gaW5maW5pYmFuZC9pNDBpdzogRml4IGEgdXNlIGFm
dGVyIGZyZWUgaW4NCj4gaTQwaXdfY21fZXZlbnRfaGFuZGxlcg0KPiANCj4gDQo+IA0KPiANCj4g
PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+ID4g5Y+R5Lu25Lq6OiAiU2FsZWVtLCBTaGlyYXoi
IDxzaGlyYXouc2FsZWVtQGludGVsLmNvbT4NCj4gPiDlj5HpgIHml7bpl7Q6IDIwMjEtMDMtMTIg
MDk6MTM6MzkgKOaYn+acn+S6lCkNCj4gPiDmlLbku7bkuro6ICJKYXNvbiBHdW50aG9ycGUiIDxq
Z2dAbnZpZGlhLmNvbT4sICJMdiBZdW5sb25nIg0KPiA+IDxseWwyMDE5QG1haWwudXN0Yy5lZHUu
Y24+DQo+ID4g5oqE6YCBOiAiTGF0aWYsIEZhaXNhbCIgPGZhaXNhbC5sYXRpZkBpbnRlbC5jb20+
LCAiZGxlZGZvcmRAcmVkaGF0LmNvbSINCj4gPiA8ZGxlZGZvcmRAcmVkaGF0LmNvbT4sICJsaW51
eC1yZG1hQHZnZXIua2VybmVsLm9yZyINCj4gPiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+
LCAibGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyINCj4gPiA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz4NCj4gPiDkuLvpopg6IFJFOiBbUEFUQ0hdIGluZmluaWJhbmQvaTQwaXc6IEZp
eCBhIHVzZSBhZnRlciBmcmVlIGluDQo+ID4gaTQwaXdfY21fZXZlbnRfaGFuZGxlcg0KPiA+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbmZpbmliYW5kL2k0MGl3OiBGaXggYSB1c2UgYWZ0
ZXIgZnJlZSBpbg0KPiA+ID4gaTQwaXdfY21fZXZlbnRfaGFuZGxlcg0KPiA+ID4NCj4gPiA+IE9u
IFdlZCwgTWFyIDEwLCAyMDIxIGF0IDA3OjE0OjE0UE0gLTA4MDAsIEx2IFl1bmxvbmcgd3JvdGU6
DQo+ID4gPiA+IEluIHRoZSBjYXNlIG9mIEk0MElXX0NNX0VWRU5UX0FCT1JURUQsIGk0MGl3X2V2
ZW50X2Nvbm5lY3RfZXJyb3IoKQ0KPiA+ID4gPiBjb3VsZCBiZSBjYWxsZWQgdG8gZnJlZSB0aGUg
ZXZlbnQtPmNtX25vZGUuIEhvd2V2ZXIsDQo+ID4gPiA+IGV2ZW50LT5jbV9ub2RlIHdpbGwgYmUg
dXNlZCBhZnRlciBhbmQgY2F1c2UgdXNlIGFmdGVyIGZyZWUuIEl0DQo+ID4gPiA+IG5lZWRzIHRv
IGFkZCBmbGFncyB0byBpbmZvcm0gdGhhdCBldmVudC0+Y21fbm9kZSBoYXMgYmVlbiBmcmVlZC4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTHYgWXVubG9uZyA8bHlsMjAxOUBtYWls
LnVzdGMuZWR1LmNuPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9o
dy9pNDBpdy9pNDBpd19jbS5jIHwgNSArKysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IFRoaXMgbWlnaHQgYmUg
T0sgKHRob3VnaCBJIGRvbid0IGxpa2UgdGhlIGZyZWUgdmFyaWFibGUpLCBTaGlyYXo/Pw0KPiA+
ID4NCj4gPg0KPiA+IEhvdyB3YXMgdGhpcyByZXByb2R1Y2VkPyBEbyB5b3UgaGF2ZSBzb21lIGNh
bGwgdHJhY2UgbGVhZGluZyB1cCB0byB1c2UgYWZ0ZXINCj4gZnJlZT8NCj4gPg0KPiA+IFRoZSBj
bV9ub2RlIHJlZmNudCBpcyBidW1wZWQgYXQgY3JlYXRpb24gdGltZSBhbmQgb25jZSBpbiBpNDBp
d19yZWNlaXZlX2lscQ0KPiBiZWZvcmUgcGFja2V0IGlzIHByb2Nlc3NlZC4NCj4gPiBUaGF0IHNo
b3VsZCBwcm90ZWN0IHRoZSBjbV9ub2RlIGZyb20gZGlzYXBwZWFyaW5nIGluIHRoZSBldmVudCBo
YW5kbGVyIGluIHRoZQ0KPiBhYm9ydCBldmVudCBjYXNlLg0KPiA+IFRoZSBkZWMgYXQgZW5kIG9m
IGk0MGl3X3JlY2VpdmUgaWxxIHNob3VsZCBiZSBwb2ludCB3aGVyZSB0aGUgY21fbm9kZSBpcyBm
cmVlZA0KPiBzcGVjaWZpY2FsbHkgaW4gdGhlIGFib3J0IGNhc2UuDQo+ID4NCj4gPiBTaGlyYXoN
Cj4gPg0KPiANCj4gVGhpcyBwcm9ibGVtIHdhcyByZXBvcnRlZCBieSBhIHBhdGgtc2Vuc2l0aXZl
IGFuYWx5emVyIGRldmVsb3BlZCBieSBvdXIgU2VjdXJpdHkNCj4gTGFiKExvY2NzKS4NCj4gVGhl
IGFuYWx5emVyIHJlcG9ydGVkIHRoYXQgdGhlcmUgaXMgYSBmZWFzaWJsZSBwYXRoIHRvIGZyZWUg
ZXZlbnQtPmNtX25vZGUgYW5kIHVzZQ0KPiBpdCBhZnRlciwgYW5kIHRoYXQgaXMgd2hhdCBpIGRl
c2NyaWJlZCBpbiB0aGUgZmlyc3QgY29tbWl0Lg0KPiANCg0KT0suIEkgZG9u4oCZdCB0aGluayB0
aGF0IGFuIGV4dHJhIGRlYyByZWZjbnQgaW4gaXRzZWxmIGZvciB0aGUgYWJvcnQgY2FzZSBpcyBl
bm91Z2ggZXZpZGVuY2UgdG8NCnNheSB0aGF0IHRoZSBjbV9ub2RlIGlzIGZyZWVkIGluIGk0MGl3
X2V2ZW50X2Nvbm5lY3RfZXJyb3IuDQoNClNoaXJheg0KDQo=
