Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C12BBA6A
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Nov 2020 00:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgKTX4j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 18:56:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:44944 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgKTX4j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 18:56:39 -0500
IronPort-SDR: Ah9cBt2+wpGoxtpj+SzQLwvi7HBtTrZTGWfVDfEWPNG2yVHTnXcEPaNKF97VIrLtsNU+wFd8Hz
 zGFh+8Zd7REg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="256268669"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="256268669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 15:56:38 -0800
IronPort-SDR: BkLj09hIScDBszO0gb6IvpY6b9W7IPeyk18DkoRShKqOZPmtX7SdFw8e9UIMItdCTQ1h3Yjx+A
 DoFcbZKqY6dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369381626"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2020 15:56:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 15:56:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 15:56:36 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Fri, 20 Nov 2020 15:56:36 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, zhudi <zhudi21@huawei.com>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rose.chen@huawei.com" <rose.chen@huawei.com>
Subject: RE: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Thread-Topic: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Thread-Index: AQHWvldctEnc/TWp0kmNUaS0awe+t6nQO9wAgAD8xSA=
Date:   Fri, 20 Nov 2020 23:56:36 +0000
Message-ID: <9edd382c89c64c988b8833f22fe027ba@intel.com>
References: <20201119093523.7588-1-zhudi21@huawei.com>
 <20201119172712.GA1973356@nvidia.com>
In-Reply-To: <20201119172712.GA1973356@nvidia.com>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBSRE1BL2k0MGl3OiBGaXggYSBtbWFwIGhhbmRsZXIgZXhw
bG9pdGF0aW9uDQo+IA0KPiBPbiBUaHUsIE5vdiAxOSwgMjAyMCBhdCAwNTozNToyM1BNICswODAw
LCB6aHVkaSB3cm90ZToNCj4gPiBGcm9tOiBEaSBaaHUgPHpodWRpMjFAaHVhd2VpLmNvbT4NCj4g
Pg0KPiA+IE5vdGljZSB0aGF0IGk0MGl3X21tYXAoKSBpcyB1c2VkIGFzIG1tYXAgZm9yIGZpbGUN
Cj4gPiAvZGV2L2luZmluaWJhbmQvdXZlcmJzJWQgYW5kIHRoZXNlIGZpbGVzIGhhdmUgYWNjZXNz
IG1vZGUgd2l0aCAwNjY2DQo+ID4gc3BlY2lmaWVkIGJ5IHV2ZXJic19kZXZub2RlKCkgYW5kIHZt
YS0+dm1fcGdvZmYgaXMgZGlyZWN0bHkgdXNlZCB0bw0KPiA+IGNhbGN1bGF0ZSBwZm4gd2hpY2gg
aXMgcGFzc2VkIGluIHJlbWFwX3Bmbl9yYW5nZSBmdW5jdGlvbiB3aXRob3V0IGFueQ0KPiA+IHZh
bGlkIHZhbGlkYXRpb24uDQo+ID4NCj4gPiBUaGlzIHdvdWxkIHJlc3VsdCBpbiBhIG1hbGljaW91
cyBwcm9jZXNzIGJlaW5nIGFibGUgdG8gcGFzcyBhbg0KPiA+IGFyYml0cmFyeSBwaHlzaWNhbCBh
ZGRyZXNzIHRvIOKAmG1tYXDigJkgd2hpY2ggd291bGQgYWxsb3cgZm9yIGFjY2VzcyB0bw0KPiA+
IGFsbCBvZiBrZXJuZWwgbWVtb3J5IGZyb20gdXNlciBzcGFjZSBhbmQgZXZlbnR1YWxseSBnYWlu
IHJvb3QgcHJpdmlsZWdlcy4NCj4gPg0KPiA+IFNvLCB3ZSBzaG91bGQgY2hlY2sgd2hldGhlciBm
aW5hbCBjYWxjdWxhdGVkIHZhbHVlIG9mIHZtX3Bnb2ZmIGlzIGluDQo+ID4gcmFuZ2Ugb2Ygc3Bl
Y2lmaWVkIHBjaSByZXNvdXJjZSBiZWZvcmUgd2UgdXNlIGl0IHRvIGNhbGN1bGF0ZSBwZm4NCj4g
PiB3aGljaCBpcyBwYXNzZWQgaW4gcmVtYXBfcGZuX3JhbmdlDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEaSBaaHUgPHpodWRpMjFAaHVhd2VpLmNvbT4NCj4gDQo+IG5lZWRzIGEgIGZpeGVzIGxp
bmUNCj4gYW5kIGNjIHN0YWJsZQ0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5k
L2h3L2k0MGl3L2k0MGl3X3ZlcmJzLmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQ0KPiANCg0KWy4uLl0NCg0KPiANCj4gSSBhbSB3aWxsaW5nIHRvIGFwcGx5
IHRoaXMgaWYgU2hpcmF6IGNvbmZpcm1zIGl0IGlzIE9LDQoNCkkgYW0gb2sgd2l0aCBpdC4gQXQg
bGVhc3QgaXQgcmVkdWNlcyB0aGUgc2V2ZXJpdHkgb2YgdGhlIGlzc3VlIOKYuQ0KDQo+IA0KPiBI
b3dldmVyLCBpdCBpcyBub3QgdGhlIHJpZ2h0IGZpeC4gU2hpcmF6IHlvdSBuZWVkIHRvIHNlbmQg
bWUgYSBwYXRjaCB0byBtYWtlIHByb3Blcg0KPiB1c2Ugb2YgdGhlIG5ldyBtbWFwIGNvb2tpZSBm
cmFtZXdvcmsuDQo+IA0KPiBJIHNlZSBpbiB0aGUgdXNlcnNwYWNlIHRoZXJlIGFyZSBvbmx5IDMg
YWNjZXB0YWJsZSB2YWx1ZXMgZm9yIG9mZnNldDoNCj4gDQo+IC0gMA0KPiAtIGk0MGl3X3VjcmVh
dGVfcXBfcmVzcC0+cHVzaF9pZHggKyBJNDBJV19CQVNFX1BVU0hfUEFHRQ0KPiAtIGk0MGl3X3Vj
cmVhdGVfcXBfcmVzcC0+cHVzaF9pZHggKyBJNDBJV19CQVNFX1BVU0hfUEFHRSArIDENCg0KVGhh
dOKAmXMgcmlnaHQuIEJ1dC4uLnNlZSBiZWxvdw0KDQo+IA0KPiBTbyBjcmVhdGUgbW1hcCBjb29r
aWVzIGZvciBvbmx5IHRob3NlIHZhbHVlcyBhbmQgZGVyaXZlIHRoZSBwZm4gb25seSBmcm9tIGVu
dHJ5DQo+IGFmdGVyIGV4dHJhY3RpbmcgaXQgZnJvbSB0aGUgY29va2llLiBUaGlzIHNob3VsZCBh
bHNvIGJlIGJsb2NraW5nIGFjY2VzcyB0byBwYXJ0cyBvZg0KPiB0aGUgQkFSIHRoZSBwcm9jZXNz
IGlzIG5vdCBhbGxvd2VkIHRvIGFjY2Vzcy4NCj4gDQo+IEVGQSBoYXMgYSBwcmV0dHkgZWFzeSB0
byBmb2xsb3cgZXhhbXBsZSBmb3IgdGhlIEFQSSBpbiBfX2VmYV9tbWFwOg0KPiANCj4gCXJkbWFf
ZW50cnkgPSByZG1hX3VzZXJfbW1hcF9lbnRyeV9nZXQoJnVjb250ZXh0LT5pYnVjb250ZXh0LCB2
bWEpOw0KPiBbLi5dDQo+IAlwZm4gPSBlbnRyeS0+YWRkcmVzcyA+PiBQQUdFX1NISUZUOw0KPiBb
Li5dDQo+IAkJZXJyID0gcmRtYV91c2VyX21tYXBfaW8oJnVjb250ZXh0LT5pYnVjb250ZXh0LCB2
bWEsIHBmbiwNCj4gCQkJCQllbnRyeS0+cmRtYV9lbnRyeS5ucGFnZXMgKiBQQUdFX1NJWkUsDQo+
IAkJCQkJcGdwcm90X25vbmNhY2hlZCh2bWEtPnZtX3BhZ2VfcHJvdCksDQo+IAkJCQkJcmRtYV9l
bnRyeSk7DQo+IA0KPiBlZmFfdXNlcl9tbWFwX2VudHJ5X2luc2VydCgpIHNob3dzIGhvdyB0byBn
ZXQgdGhlIGNvb2tpZSB5b3UnZCByZXR1cm4gaW4NCj4gcHVzaF9pZHgsIGZvciBjb21wYXRhYmls
aXR5IHlvdSdkIGhhdmUgdG8gbWFrZSBzb21lIGFkanVzdG1lbnRzIGhlcmUsIGJ1dCB0aGVyZQ0K
PiBhcmUgQVBJcyBmb3IgdGhhdCB0b28sIG1seDUgaGFzIGV4YW1wbGVzLg0KPiANCg0KV2VsbCwg
dGhlIHB1c2ggZmVhdHVyZSBpcyBkaXNhYmxlZCBieSBkZWZhdWx0IGFuZCB0b2RheSB0aGVyZSB3
aWxsIGJlIG5vIHB1c2ggcGFnZSBtbWFwIGZyb20NCnVzZXItc3BhY2Ugc2luY2UgdXJlc3AucHVz
aF9pZHggaXMgYW4gaW52YWxpZCBvbmUuIEl0cyBkaXNhYmxlZCBmb3IgZ29vZCByZWFzb24NCmFz
IGl0cyBub3Qgd29ya2luZyBhcyBleHBlY3RlZC4gVGhlcmUgaXMgYW4gb3B0aW9uIHRvIHR1cm4g
aXQgb24gdmlhIG1vZHVsZSBwYXJhbSBidXQgdGhhdA0KZG9lcyBub3Qgd29yayBhcyBleHBlY3Rl
ZCBzdGlsbCByZXN1bHRpbmcgaW4gYW4gaW52YWxpZCB1cmVzcC5wdXNoX2lkeCBwYXNzZWQgdG8g
dXNlci1zcGFjZQ0KYW5kIG5vIG1tYXAuDQoNClNvIGlzbuKAmXQgaXQgYmV0dGVyIHRvIGp1c3Qg
cmVtb3ZlIHRoZSBwdXNoIHJlbGF0ZWQgY29kZSBpbiB0aGUgZHJpdmVyPyB3aGljaCBzaG91bGQg
YWxzbyByZW1vdmUgdGhlIG1hbmlwdWxhdGlvbiBvbiB0aGUgdm1fcGdvZmYgSSBiZWxpZXZlLg0K
DQpJIHdpbGwgcmV2aWV3IHRoZSBtbWFwIEFQSSBhbmQgc2VlIGhvdyB3ZSBjYW4gdXNlIGl0IGZv
ciBEQiBtbWFwLg0KDQpTaGlyYXoNCg==
