Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC239DFAD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFGO4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 10:56:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:46190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFGO4L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 10:56:11 -0400
IronPort-SDR: Px0RyTEH7/Cu/wtNQw/KXsuc7aKknyT2XanxFCbcFCwgW8EAoe6Fe8Yv0di7dDiwe9kWCAYy1Z
 fdHCT05OpnbA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204450314"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="204450314"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:54:06 -0700
IronPort-SDR: XsXILqK2xoxGTa/QIq/b9+Mzp2gbkhjTDRkM6lCXByZJ4pJFU8hy4skRMrguXk4Vi62Zl41ME6
 YkEeXbpyznkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="481550692"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2021 07:54:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:05 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 7 Jun 2021 07:54:05 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: remove extraneous indentation on a statement
Thread-Topic: [PATCH] RDMA/irdma: remove extraneous indentation on a statement
Thread-Index: AQHXWgtGvJD0i0ET9EiHqo3F0okn0asHGx6g
Date:   Mon, 7 Jun 2021 14:54:05 +0000
Message-ID: <986baab933324970a3d8500576eda339@intel.com>
References: <20210605130400.25987-1-colin.king@canonical.com>
In-Reply-To: <20210605130400.25987-1-colin.king@canonical.com>
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

PiBTdWJqZWN0OiBbUEFUQ0hdIFJETUEvaXJkbWE6IHJlbW92ZSBleHRyYW5lb3VzIGluZGVudGF0
aW9uIG9uIGEgc3RhdGVtZW50DQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPg0KPiANCj4gQSBzaW5nbGUgc3RhdGVtZW50IGlzIGluZGVudGVkIG9u
ZSBsZXZlbCB0b28gZGVlcGx5LCBjbGVhbiB1cCB0aGUgY29kZSBieQ0KPiByZW1vdmluZyB0aGUg
ZXh0cmFuZW91cyB0YWIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9p
cmRtYS92ZXJicy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2ly
ZG1hL3ZlcmJzLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvdmVyYnMuYw0KPiBpbmRl
eCAyOTQxNTUyOTMyNDMuLjY1Y2I1OGNiMzJlMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZp
bmliYW5kL2h3L2lyZG1hL3ZlcmJzLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2ly
ZG1hL3ZlcmJzLmMNCj4gQEAgLTM0NDIsNyArMzQ0Miw3IEBAIHN0YXRpYyB2b2lkIGlyZG1hX3By
b2Nlc3NfY3FlKHN0cnVjdCBpYl93YyAqZW50cnksDQo+ICAJCWVudHJ5LT5zcmNfcXAgPSBjcV9w
b2xsX2luZm8tPnFwX2lkOw0KPiAgCX0NCj4gDQo+IC0JCWVudHJ5LT5ieXRlX2xlbiA9IGNxX3Bv
bGxfaW5mby0+Ynl0ZXNfeGZlcmVkOw0KPiArCWVudHJ5LT5ieXRlX2xlbiA9IGNxX3BvbGxfaW5m
by0+Ynl0ZXNfeGZlcmVkOw0KDQpBY2tlZC1ieTogU2hpcmF6IFNhbGVlbSA8c2hpcmF6LnNhbGVl
bUBpbnRlbC5jb20+DQo=
