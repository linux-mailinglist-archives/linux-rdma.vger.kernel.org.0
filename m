Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6246E15318
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEFRxW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 13:53:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:64330 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEFRxV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 13:53:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="322090774"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2019 10:53:08 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 10:52:49 -0700
Received: from fmsmsx120.amr.corp.intel.com ([169.254.15.34]) by
 FMSMSX155.amr.corp.intel.com ([169.254.5.71]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 10:52:49 -0700
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: RE: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Thread-Topic: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Thread-Index: AQHU3atkXxJ320IBn0GjhIL6jh/a0qYTzaCAgAqgl2CAAa5bgIAAHvyAgAAfDgCAAAovgIAAHEoAgDaRsoCABz8ggIAApDMA//+xZTA=
Date:   Mon, 6 May 2019 17:52:48 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
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
         <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
In-Reply-To: <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTYyZjcxOTEtMjgxYy00NTgwLWEyNjgtNzVlYmFiNDA4ZWFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUWJPTmQ5MmYyUU5XMm1VRXQ1RmR0WVJJOGh5VXdVRVdlR3c0Z1p6a1RMcDMzNXZGSTU0VzlOWFVaVTg4THVSUCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gTXkgbWlzdGFrZS4gIEl0J3MgYmVlbiBhIGxvbmcgd2hpbGUgc2luY2UgSSBjb2RlZCB0
aGUgc3R1ZmYgSSBkaWQgZm9yDQo+IG1lbW9yeSByZWNsYWltIHByZXNzdXJlIGFuZCBJIGhhZCBt
eSBmbGFnIHVzYWdlIHdyb25nIGluIG15IG1lbW9yeS4NCj4gRnJvbSB0aGUgZGVzY3JpcHRpb24g
eW91IGp1c3QgZ2F2ZSwgdGhlIG9yaWdpbmFsIHBhdGNoIHRvIGFkZA0KPiBXUV9NRU1fUkVDTEFJ
TSBpcyBvay4gIEkgcHJvYmFibHkgc3RpbGwgbmVlZCB0byBhdWRpdCB0aGUgaXBvaWIgdXNhZ2UN
Cj4gdGhvdWdoLg0KPiANCj4gLS0NCj4gRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29t
Pg0KPiAgICAgR1BHIEtleUlEOiBCODI2QTMzMzBFNTcyRkREDQo+ICAgICBLZXkgZmluZ2VycHJp
bnQgPSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2NUIgIDEyNzQgQjgyNiBBMzMzIDBFNTcgMkZERA0K
DQpEb24ndCBsb3NlIHNpZ2h0IG9mIHRoZSBmYWN0IHRoYXQgdGhlIGFkZGl0aW9uYWwgb2YgdGhl
IFdRX01FTV9SRUNMQUlNIGlzIHRvIHNpbGVuY2UNCmEgd2FybmluZyBCRUNBVVNFIGlwb2liJ3Mg
d29ya3F1ZXVlIGlzIFdRX01FTV9SRUNMQUlNLiAgVGhpcyBoYXBwZW5zIHdoaWxlDQpyZG1hdnQv
aGZpMSBpcyBkb2luZyBhIGNhbmNlbF93b3JrX3N5bmMoKSBmb3IgdGhlIHdvcmsgaXRlbSB1c2Vk
IGJ5IHRoZSBRUCdzIHNlbmQgZW5naW5lDQoNClRoZSBpcG9pYiB3cSBuZWVkcyB0byBiZSBhdWRp
dGVkIHRvIHNlZSBpZiBpdCBpcyBpbiB0aGUgZGF0YSBwYXRoIGZvciBWTSBJL08uDQoNCk1pa2UN
Cg0KDQo=
