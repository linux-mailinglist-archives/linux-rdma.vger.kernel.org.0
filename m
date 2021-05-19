Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034FB38843D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhESBLY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 21:11:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:46152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhESBLX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 21:11:23 -0400
IronPort-SDR: ems6vOlabZUBZRYmcHxIMtw7cTDL3RUKcdGfjjXkl/rhNjvUqFplYeqzrSEQiz4uNOfr7CPI6k
 Vmh8Lu1/2bzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200909662"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200909662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 18:10:04 -0700
IronPort-SDR: wyMIWuVdNCN+sfsqjj+YnD66GnVtzzf2Onv9PN/qvmQSNAKAfqAznVYlKWeHJ4F9nia1nG8ioK
 Wc0k/PuCvbkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="395085431"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2021 18:10:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 18:10:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 18:10:02 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Tue, 18 May 2021 18:10:02 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Mark Zhang <markzhang@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Thread-Topic: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Thread-Index: AQHXSzxfKpiSrsBJnEi7XaP3x/HUP6rpEJyAgADuOBA=
Date:   Wed, 19 May 2021 01:10:01 +0000
Message-ID: <9daebd70ef554f8ab44e265e7bda3320@intel.com>
References: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b39b0550-6602-be80-7343-349a6f6f30a9@nvidia.com>
In-Reply-To: <b39b0550-6602-be80-7343-349a6f6f30a9@nvidia.com>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzEzXSBSRE1BOiBTcGxpdCB0aGUgYWxsb2NfaHdfc3Rh
dHMoKSBvcHMgdG8gcG9ydCBhbmQNCj4gZGV2aWNlIHZhcmlhbnRzDQo+IA0KPiBPbiA1LzE4LzIw
MjEgMTI6NDcgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+DQo+ID4NCj4gPiBU
aGlzIGlzIGJlaW5nIHVzZWQgdG8gaW1wbGVtZW50IGJvdGggdGhlIHBvcnQgYW5kIGRldmljZSBn
bG9iYWwgc3RhdHMsDQo+ID4gd2hpY2ggaXMgY2F1c2luZyBzb21lIGNvbmZ1c2lvbiBpbiB0aGUg
ZHJpdmVycy4gRm9yIGluc3RhbmNlIEVGQSBhbmQNCj4gPiBpNDBpdyBib3RoIHNlZW0gdG8gYmUg
bWlzdXNpbmcgdGhlIGRldmljZSBzdGF0cy4NCj4gPg0KPiA+IFNwbGl0IGl0IGludG8gdHdvIG9w
cyBzbyBkcml2ZXJzIHRoYXQgZG9uJ3Qgc3VwcG9ydCBvbmUgb3IgdGhlIG90aGVyDQo+ID4gY2Fu
IGxlYXZlIHRoZSBvcCBOVUxMJ2QsIG1ha2luZyB0aGUgY2FsbGluZyBjb2RlIGEgbGl0dGxlIHNp
bXBsZXIgdG8NCj4gPiB1bmRlcnN0YW5kLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCg0KWy4uLl0NCg0KPiA+IC1zdGF0
aWMgc3RydWN0IHJkbWFfaHdfc3RhdHMgKmM0aXdfYWxsb2Nfc3RhdHMoc3RydWN0IGliX2Rldmlj
ZSAqaWJkZXYsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHUzMiBwb3J0X251bSkNCj4gPiArc3RhdGljIHN0cnVjdCByZG1hX2h3X3N0YXRzICpjNGl3
X2FsbG9jX3BvcnRfc3RhdHMoc3RydWN0IGliX2RldmljZSAqaWJkZXYsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyIHBvcnRfbnVtKQ0K
PiA+ICAgew0KPiA+ICAgICAgICAgIEJVSUxEX0JVR19PTihBUlJBWV9TSVpFKG5hbWVzKSAhPSBO
Ul9DT1VOVEVSUyk7DQo+ID4NCj4gPiAtICAgICAgIGlmIChwb3J0X251bSAhPSAwKQ0KPiA+IC0g
ICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAtDQo+IA0KPiBJJ20gbm90IGZhbWlsaWFy
IHdpdGggdGhpcyBkcml2ZXIsIGJ1dCBpZiBwb3J0X251bSBtdXN0IGJlIDAgaGVyZSwgZG9lcyBp
dCBtZWFuIHRoaXMgaXMNCj4gcGVyLWRldmljZSBub3QgcGVyLXBvcnQ/DQoNClllYWgsIGFkZGl0
aW9uYWxseSBwZXItZGV2aWNlIHNlZW1zIHRvIGNvaW5jaWRlIHdpdGggdGhlIGJlaGF2aW9yIGlu
IGdldF9od19zdGF0cyBjYWxsYmFjayBmb3IgY3hnYjQuDQoNClNoaXJheg0KDQoNCg==
