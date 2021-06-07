Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFC39DFB3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGO4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 10:56:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:25357 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhFGO4S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 10:56:18 -0400
IronPort-SDR: 7u5vkF8VvR2IcCmjeoQzHDSGsTCyT6dFPIYJbWf53UGuTQUAj61F8hz/qxzY5DbWdpdZGxaehy
 5pgumhPmIRLw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265790476"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265790476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:54:18 -0700
IronPort-SDR: TdkeCysUSCbRmlMtBkdOPwRCft8hgjf9nmoC5h8C5EXTA4vdcANl4DPiB1e3S0xH/me/QlRFGh
 qEX90OoUZVEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551255647"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2021 07:54:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:17 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 7 Jun 2021 07:54:17 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] RDMA/irdma: Fix issues with u8 left shift operation
Thread-Topic: [PATCH][next] RDMA/irdma: Fix issues with u8 left shift
 operation
Thread-Index: AQHXWgVO6IMJFRhn50eVluBXD9XUGasHHAUQ
Date:   Mon, 7 Jun 2021 14:54:17 +0000
Message-ID: <28c79f11c1524d10b6bbe2c375c7c97e@intel.com>
References: <20210605122059.25105-1-colin.king@canonical.com>
In-Reply-To: <20210605122059.25105-1-colin.king@canonical.com>
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

PiBTdWJqZWN0OiBbUEFUQ0hdW25leHRdIFJETUEvaXJkbWE6IEZpeCBpc3N1ZXMgd2l0aCB1OCBs
ZWZ0IHNoaWZ0IG9wZXJhdGlvbg0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IFRoZSBzaGlmdGluZyBvZiB0aGUgdTggaW50ZWdlciBp
bmZvLT5tYXBbaV0gdGhlIGxlZnQgd2lsbCBiZSBwcm9tb3RlZCB0byBhIDMyIGJpdA0KPiBzaWdu
ZWQgaW50IGFuZCB0aGVuIHNpZ24tZXh0ZW5kZWQgdG8gYSB1NjQuIEluIHRoZSBldmVudCB0aGF0
IHRoZSB0b3AgYml0IG9mIHRoZSB1OCBpcw0KPiBzZXQgdGhlbiBhbGwgdGhlbiBhbGwgdGhlIHVw
cGVyIDMyIGJpdHMgb2YgdGhlIHU2NCBlbmQgdXAgYXMgYWxzbyBiZWluZyBzZXQgYmVjYXVzZQ0K
PiBvZiB0aGUgc2lnbi1leHRlbnNpb24uDQo+IEZpeCB0aGlzIGJ5IGNhc3RpbmcgdGhlIHU4IHZh
bHVlcyB0byBhIHU2NCBiZWZvcmUgdGhlIGxlZnQgc2hpZnQuIFRoaXMNCj4gDQo+IEFkZHJlc3Nl
cy1Db3Zlcml0eTogKCJVbml0ZW50aW9uYWwgaW50ZWdlciBvdmVyZmxvdyAvIGJhZCBzaGlmdCBv
cGVyYXRpb24iKQ0KPiBGaXhlczogM2Y0OWQ2ODQyNTY5ICgiUkRNQS9pcmRtYTogSW1wbGVtZW50
IEhXIEFkbWluIFF1ZXVlIE9QcyIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxj
b2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L2lyZG1hL2N0cmwuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9p
cmRtYS9jdHJsLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY3RybC5jDQo+IGluZGV4
IDVhYTExMjA2N2JjZS4uOGJkM2FlY2FkYWY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvaXJkbWEvY3RybC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRt
YS9jdHJsLmMNCj4gQEAgLTIxNTcsNyArMjE1Nyw3IEBAIHN0YXRpYyBlbnVtIGlyZG1hX3N0YXR1
c19jb2RlDQo+IGlyZG1hX3NjX3NldF91cF9tYXAoc3RydWN0IGlyZG1hX3NjX2NxcCAqY3FwLA0K
PiAgCQlyZXR1cm4gSVJETUFfRVJSX1JJTkdfRlVMTDsNCj4gDQo+ICAJZm9yIChpID0gMDsgaSA8
IElSRE1BX01BWF9VU0VSX1BSSU9SSVRZOyBpKyspDQo+IC0JCXRlbXAgfD0gaW5mby0+bWFwW2ld
IDw8IChpICogOCk7DQo+ICsJCXRlbXAgfD0gKHU2NClpbmZvLT5tYXBbaV0gPDwgKGkgKiA4KTsN
Cj4gDQoNCkFja2VkLWJ5OiBTaGlyYXogU2FsZWVtIDxzaGlyYXouc2FsZWVtQGludGVsLmNvbT4N
Cg==
