Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478E42BBC51
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Nov 2020 03:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKUCpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 21:45:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:35075 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgKUCpL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 21:45:11 -0500
IronPort-SDR: Y0b6K1YHya5eoj9OCPmVq/DqsH2+FfJ2pFVIDSGzocp348+ViOT/y/zeBKrZ8KtgB/nHc/mWLh
 lt1232DVTjeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168060014"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="168060014"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 18:45:10 -0800
IronPort-SDR: DwD+vF9esuUsZGTb7I8QremMrHc768xPpTQ6QWFBjn50a80x27H9ZSd3MH3msl281y+EIwpGjK
 BqIkAHsLLbnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="535405446"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2020 18:45:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 18:45:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 18:45:10 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Fri, 20 Nov 2020 18:45:09 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     zhudi <zhudi21@huawei.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rose.chen@huawei.com" <rose.chen@huawei.com>
Subject: RE: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Thread-Topic: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Thread-Index: AQHWvldctEnc/TWp0kmNUaS0awe+t6nQO9wAgAD8xSCAAQhYAP//olDA
Date:   Sat, 21 Nov 2020 02:45:09 +0000
Message-ID: <e18001609d5d4169892ee42af2f7effb@intel.com>
References: <20201119093523.7588-1-zhudi21@huawei.com>
 <20201119172712.GA1973356@nvidia.com>
 <9edd382c89c64c988b8833f22fe027ba@intel.com>
 <20201121001802.GL917484@nvidia.com>
In-Reply-To: <20201121001802.GL917484@nvidia.com>
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
bG9pdGF0aW9uDQo+IA0KPiBPbiBGcmksIE5vdiAyMCwgMjAyMCBhdCAxMTo1NjozNlBNICswMDAw
LCBTYWxlZW0sIFNoaXJheiB3cm90ZToNCj4gDQo+ID4gV2VsbCwgdGhlIHB1c2ggZmVhdHVyZSBp
cyBkaXNhYmxlZCBieSBkZWZhdWx0IGFuZCB0b2RheSB0aGVyZSB3aWxsIGJlDQo+ID4gbm8gcHVz
aCBwYWdlIG1tYXAgZnJvbSB1c2VyLXNwYWNlIHNpbmNlIHVyZXNwLnB1c2hfaWR4IGlzIGFuIGlu
dmFsaWQNCj4gPiBvbmUuIEl0cyBkaXNhYmxlZCBmb3IgZ29vZCByZWFzb24gYXMgaXRzIG5vdCB3
b3JraW5nIGFzIGV4cGVjdGVkLg0KPiA+IFRoZXJlIGlzIGFuIG9wdGlvbiB0byB0dXJuIGl0IG9u
IHZpYSBtb2R1bGUgcGFyYW0gYnV0IHRoYXQgZG9lcyBub3QNCj4gPiB3b3JrIGFzIGV4cGVjdGVk
IHN0aWxsIHJlc3VsdGluZyBpbiBhbiBpbnZhbGlkIHVyZXNwLnB1c2hfaWR4IHBhc3NlZA0KPiA+
IHRvIHVzZXItc3BhY2UgYW5kIG5vIG1tYXAuDQo+ID4NCj4gPiBTbyBpc27igJl0IGl0IGJldHRl
ciB0byBqdXN0IHJlbW92ZSB0aGUgcHVzaCByZWxhdGVkIGNvZGUgaW4gdGhlIGRyaXZlcj8NCj4g
PiB3aGljaCBzaG91bGQgYWxzbyByZW1vdmUgdGhlIG1hbmlwdWxhdGlvbiBvbiB0aGUgdm1fcGdv
ZmYgSSBiZWxpZXZlLg0KPiANCj4gWWVzLCBkZWxldGUgYWxsIHRoZSBwdXNoIGNvZGUsIG1vZHVs
ZSBwYXJhbSwgZXRjLiBTZXQgdGhlIGludmFsaWQgcHVzaF9pZHgsIHZlcmlmeQ0KPiB2bV9wZ29m
ZiA9PSAwIGFuZCBoYXJkd2lyZSB0aGUgcGZuIHRvIGJlIGEgc2luZ2xlIEJBUiBwYWdlLg0KPiAN
Cj4gQ2FuIHlvdSBzZW5kIGEgcGF0Y2ggc29vbj8NCg0KWWVzLg0K
