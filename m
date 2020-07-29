Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8E2325DF
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2UIF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 16:08:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:10144 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgG2UIE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jul 2020 16:08:04 -0400
IronPort-SDR: GPip9xsf0hPT3oPdf7isfCSL2wtS25eYXFh8fsZxgyHHMc9MmjiKGWzgHvP9+Fdcnfxa/iybdF
 uX62gyZ9aeuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139498399"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="139498399"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:07:59 -0700
IronPort-SDR: VEkKSi7YHpHQJlHbeXmqz+RxRzypBtnzmh8OUVMTj5pmIuPPVhrxf61eQdmlv+SVKmj2qbz1UI
 Z9migdSznqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="434798608"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 13:07:57 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jul 2020 13:07:56 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.54]) by
 FMSMSX155.amr.corp.intel.com ([169.254.5.149]) with mapi id 14.03.0439.000;
 Wed, 29 Jul 2020 13:07:56 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Anubhav Guleria <anubhav.nitsri.it@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Issue with i40iw
Thread-Topic: Issue with i40iw
Thread-Index: AQHWZeIm6pAu1sdeKUeg0pbAcpS5A6ke+Lkw
Date:   Wed, 29 Jul 2020 20:07:56 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A70106600A99@fmsmsx124.amr.corp.intel.com>
References: <CAFsMY+gFTh_hUDGexx3duLD_anZkar+SNj3S9UhMYH+ciYU-rA@mail.gmail.com>
In-Reply-To: <CAFsMY+gFTh_hUDGexx3duLD_anZkar+SNj3S9UhMYH+ciYU-rA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBJc3N1ZSB3aXRoIGk0MGl3DQo+IA0KPiBIaSwNCj4gQm90aCBvZiBteSBzZXJ2
ZXJzIGFyZSBydW5uaW5nIHdpdGgga2VybmVsIDQuMTQuMTc4IGFuZCBoYXZlIEludGVsIEV0aGVy
bmV0DQo+IE5ldHdvcmsgQWRhcHRlciBYNzIyLiBBbHNvIHRoZSBJT01NVSBpcyBkaXNhYmxlZC4g
SSB3YXMgdHJ5aW5nIHRvIHJ1biBxcGVyZiBhbmQNCj4gcmFuIGludG8gY291cGxlIG9mIGlzc3Vl
czoNCj4gDQo+IDEpIFdoaWxlIHJ1bm5pbmcgYW55IGJ3IHRlc3QsIGVnLiByY19idyBvciByY19i
aV9idywgSSBzZWUgZm9sbG93aW5nIG1lc3NhZ2VzIGluDQo+IGRtZXNnOg0KPiBpNDBpd19jcXBf
Y2VfaGFuZGxlcjogb3Bjb2RlID0gMHgxIG1hal9lcnJfY29kZSA9IDB4ZmZmZiBtaW5fZXJyX2Nv
ZGUgPQ0KPiAweDgwMDcNCj4gaTQwaXdfd2FpdF9ldmVudDogZXJyb3IgY3FwIGNvbW1hbmQgMHhi
IGNvbXBsZXRpb24gbWFqID0gMHhmZmZmIG1pbj0weDgwMDcNCj4gDQo+IDIpIEZvbGxvd2luZyBy
YyBiZW5jaG1hcmtzIGZhaWw6IHJjX3JkbWFfd3JpdGVfYncsIHJjX3JkbWFfd3JpdGVfbGF0LA0K
PiByY19jb21wYXJlX3N3YXBfbXIsIHJjX2ZldGNoX2FkZF9tciwgdmVyX3JjX2NvbXBhcmVfc3dh
cCBhbmQNCj4gdmVyX3JjX2ZldGNoX2FkZC4gRm9yIHRoZXNlIEkgZ2V0IGVycm9yIG9mIGZhaWxl
ZCB0byBwb3N0ICJiZW5jaG1hcmsgbmFtZSINCj4gDQo+IEFtIEkgbWlzc2luZyBzb21ldGhpbmcg
aGVyZT8gQW55IHN1Z2dlc3Rpb25zPw0KQXJlIHRoZXNlICJyY19jb21wYXJlX3N3YXBfbXIsIHJj
X2ZldGNoX2FkZF9tciwgdmVyX3JjX2NvbXBhcmVfc3dhcCBhbmQNCnZlcl9yY19mZXRjaF9hZGQi
IHJlcG9ydGluZyBhbiBpbnZhbGlkIG9wIGNvZGU/IFRob3NlIGFyZSB1bnN1cHBvcnRlZCBpbiBp
NDBpdy4NCg0KcXBlcmYgSSB0aGluayB1c2VzIHdyaXRlIHdpdGggaW1tZWRpYXRlIHdoaWNoIGlz
IGFsc28gdW5zdXBwb3J0ZWQgaW4gaTQwaXcNCmFuZCBjb3VsZCBleHBsYWluIHRoZSByZG1hX3dy
aXRlXyogZmFpbHMuDQoNCkZvciBwZXJmb3JtYW5jZSBiZW5jaG1hcmtpbmcgb24geDcyMiwgd2Ug
YXJlIHR5cGljYWxseSB1c2luZyBwZXJmdGVzdHMgKGliXyogdGVzdHMpDQoNClNoaXJheg0KDQo=
