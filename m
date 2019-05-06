Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5F14995
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfEFMbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 08:31:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:13652 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfEFMbI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 08:31:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 05:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="141772418"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 06 May 2019 05:31:07 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 05:31:07 -0700
Received: from fmsmsx120.amr.corp.intel.com ([169.254.15.34]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.228]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 05:31:07 -0700
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: RE: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Thread-Topic: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Thread-Index: AQHU3atkXxJ320IBn0GjhIL6jh/a0qYTzaCAgAqgl2CAAa5bgIAAHvyAgAAfDgCAAAovgIAAHEoAgDaRsoCABz8ggA==
Date:   Mon, 6 May 2019 12:31:06 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
         <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
         <20190319192737.GB3773@ziepe.ca>
         <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
         <20190327152517.GD69236@devbig004.ftw2.facebook.com>
         <20190327171611.GF21008@ziepe.ca>
         <20190327190720.GE69236@devbig004.ftw2.facebook.com>
         <20190327194347.GH21008@ziepe.ca>
         <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
In-Reply-To: <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGViN2NhYzgtMmMxYi00MTA0LWJmN2MtZWU0OGJjNDU4ODNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN0VKYW9wQ1VzQUk4b0xtSmgwaHB4NXVxOTlBQktxU1wvQlwvQVwvRU9DRUVweUhSZEptemVXejd5K2pIdUQzOHFmdyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBDb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBUZWp1biwgYnV0IHRoZSBrZXkgaXNzdWVzIGFyZToN
Cj4gDQo+IEFsbCBXUV9NRU1fUkVDTEFJTSB3b3JrIHF1ZXVlcyBhcmUgZWxpZ2libGUgdG8gYmUg
cnVuIHdoZW4gdGhlDQo+IG1hY2hpbmUNCj4gaXMgdW5kZXIgZXh0cmVtZSBtZW1vcnkgcHJlc3N1
cmUgYW5kIGF0dGVtcHRpbmcgdG8gcmVjbGFpbSBtZW1vcnkuICBUaGF0DQo+IG1lYW5zIHRoYXQg
dGhlIHdvcmtxdWV1ZToNCj4gDQo+IDEpIE1VU1Qgbm90IHBlcmZvcm0gYW55IEdGUF9BVE9NSUMg
YWxsb2NhdGlvbnMgYXMgdGhpcyBjb3VsZCBkZWFkbG9jaw0KDQpUaGUgc2VuZCBlbmdpbmUgY29k
ZSBXSUxMIGRvIGEgR0ZQX0FUT01JQyBhbGxvY2F0aW9uIGJ1dCB0aGUgY29kZSBoYW5kbGVzIGZh
aWx1cmUgYXMNCndpbGwgYW55IG90aGVyIHJlc291cmNlIHNob3J0YWdlLg0KDQo+IDIpIFNIT1VM
RCBub3QgcmVseSBvbiBhbnkgR0ZQX0tFUk5FTCBhbGxvY2F0aW9ucyBhcyB0aGVzZSBtYXkgZmFp
bA0KDQpUaGVyZSBhcmUgbm8gR0ZQX0tFUk5FTCBhbGxvY2F0aW9ucyBpbiB0aGUgc2VuZCBlbmdp
bmUgY29kZS4NCg0KPiAzKSBNVVNUIGNvbXBsZXRlIHdpdGhvdXQgYmxvY2tpbmcNCg0KQWxsIHJl
c291cmNlIGJsb2NrYWdlcyBhcmUgaGFuZGxlZCBieSBxdWV1aW5nIHRoZSBjdXJyZW50IFFQIGJl
aW5nIHNlcnZpY2VkIGJ5DQp0aGUgc2VuZCBlbmdpbmUgZm9yIGFuZCBpbnRlcnJ1cHQgdG8gd2Fr
ZSB0aGF0IFFQIHVwIHZpYSB0aGUgc2VuZCBlbmdpbmUuDQoNCj4gNCkgU0hPVUxEIGlkZWFsbHkg
YWx3YXlzIG1ha2Ugc29tZSBzb3J0IG9mIGZvcndhcmQgcHJvZ3Jlc3MgaWYgYXQgYWxsDQo+IHBv
c3NpYmxlIHdpdGhvdXQgbmVlZGluZyBtZW1vcnkgYWxsb2NhdGlvbnMgdG8gZG8gc28NCj4gDQoN
CkFzIG5vdGVkIGFib3ZlLg0KDQo+IE1pa2UsIGRvZXMgaGZpMV9kb19zZW5kKCkgbWVldCB0aGVz
ZSByZXF1aXJlbWVudHM/ICBJZiBub3QsIHdlIHNob3VsZA0KPiBub3QgYmUgcHV0dGluZyBXUV9N
RU1fUkVDTEFJTSBvbiBpdCwgYW5kIGluc3RlYWQgc2hvdWxkIGZpbmQgYW5vdGhlcg0KPiBzb2x1
dGlvbiB0byB0aGUgY3VycmVudCB0cmFjZSBpc3N1ZS4NCj4gDQoNCkknbSBub3Qgc3VyZSBJIHVu
ZGVyc3RhbmQgdGhlIDEpIGFib3ZlLg0KDQpUZWp1biwgY2FuIHlvdSBlbGFib3JhdGU/DQoNCk1p
a2UNCg==
