Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2747139DFAB
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFGO4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 10:56:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:16307 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhFGOz4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 10:55:56 -0400
IronPort-SDR: aANCVRNkvEzQxQqWN6Dp3zwS8G40AR/1qOIZi138Pm1Z9VZeOcRCtmZGwzj1/EpmhVSOXLGMil
 E4p5PjE/ISuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="225970581"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="225970581"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:53:59 -0700
IronPort-SDR: rESX0qh2f3FwoP3KUZNHspOUbN6dmTHnyp/Bn36J+ePzu8fkZBRzA/nDAzUugsZFBctskkCKMJ
 lgXSBFsafCeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="481550650"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2021 07:53:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:53:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:53:58 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 7 Jun 2021 07:53:58 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] RDMA/irdma: remove redundant initialization of
 variable val
Thread-Topic: [PATCH][next] RDMA/irdma: remove redundant initialization of
 variable val
Thread-Index: AQHXWgyjSr5u0/j66kWtCSOcRAlE5asHG4Qw
Date:   Mon, 7 Jun 2021 14:53:58 +0000
Message-ID: <002eafeb137b42a8ae6782e6394c2170@intel.com>
References: <20210605131347.26293-1-colin.king@canonical.com>
In-Reply-To: <20210605131347.26293-1-colin.king@canonical.com>
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

PiBTdWJqZWN0OiBbUEFUQ0hdW25leHRdIFJETUEvaXJkbWE6IHJlbW92ZSByZWR1bmRhbnQgaW5p
dGlhbGl6YXRpb24gb2YgdmFyaWFibGUgdmFsDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8
Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhlIHZhcmlhYmxlIHZhbCBpcyBiZWlu
ZyBpbml0aWFsaXplZCB3aXRoIGEgdmFsdWUgdGhhdCBpcyBuZXZlciByZWFkLCBpdCBpcyBiZWlu
Zw0KPiB1cGRhdGVkIGxhdGVyIG9uLiBUaGUgYXNzaWdubWVudCBpcyByZWR1bmRhbnQgYW5kIGNh
biBiZSByZW1vdmVkLg0KPiANCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2YWx1ZSIp
DQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL2N0cmwuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9jdHJsLmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvaHcvaXJkbWEvY3RybC5jDQo+IGluZGV4IDhiZDNhZWNhZGFmNi4uYjEwMjNh
N2QwYmQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY3RybC5j
DQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9jdHJsLmMNCj4gQEAgLTMzMjMs
NyArMzMyMyw3IEBAIF9fbGU2NCAqaXJkbWFfc2NfY3FwX2dldF9uZXh0X3NlbmRfd3FlX2lkeChz
dHJ1Y3QNCj4gaXJkbWFfc2NfY3FwICpjcXAsIHU2NCBzY3JhdGNoDQo+ICAgKi8NCj4gIGVudW0g
aXJkbWFfc3RhdHVzX2NvZGUgaXJkbWFfc2NfY3FwX2Rlc3Ryb3koc3RydWN0IGlyZG1hX3NjX2Nx
cCAqY3FwKSAgew0KPiAtCXUzMiBjbnQgPSAwLCB2YWwgPSAxOw0KPiArCXUzMiBjbnQgPSAwLCB2
YWw7DQoNCkFja2VkLWJ5OiBTaGlyYXogU2FsZWVtIDxzaGlyYXouc2FsZWVtQGludGVsLmNvbT4N
Cg==
