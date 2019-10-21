Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB7DF6CA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJUUc6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:32:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:59217 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfJUUc6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 16:32:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="222584163"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2019 13:32:57 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 13:32:57 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.139]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 13:32:57 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: RE: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Thread-Topic: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Thread-Index: AQHVh7TCl3yVX+llIEiJz4mtL+DEw6dlmJGAgAAl4ID//5KrUIAAimIA//+ln6A=
Date:   Mon, 21 Oct 2019 20:32:56 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7B6B0DA15@fmsmsx124.amr.corp.intel.com>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org> <20191021141039.GC25178@ziepe.ca>
 <61d89948-de40-5e6b-f368-353476292093@acm.org>
 <9DD61F30A802C4429A01CA4200E302A7B6B0D6EE@fmsmsx124.amr.corp.intel.com>
 <4d1fb001-ead8-81ce-893e-1ff94214c389@acm.org>
In-Reply-To: <4d1fb001-ead8-81ce-893e-1ff94214c389@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmEyOTNhMzgtNWM0Ny00NzQ1LTkzYTEtMjI2Y2U5YzBjYjk0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidUtIU0R6aitZSk5IU2JTdXJkZ2NSTnZKRTBCMmg5VHBNckk2MUsxZk90VHB4ZUNcL21nOVp5bEc3eVJhSmpQU1MifQ==
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gUkRNQS9jb3JlOiBTZXQgRE1BIHBhcmFtZXRlcnMg
Y29ycmVjdGx5DQo+IA0KPiBPbiAxMC8yMS8xOSAxMDo0NCBBTSwgU2FsZWVtLCBTaGlyYXogd3Jv
dGU6DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0K
PiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jDQo+ID4+IGluZGV4IGE2Njc2
MzZmNzRiZi4uYTUyM2Q4NDRhZDlkIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJh
bmQvY29yZS9kZXZpY2UuYw0KPiA+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZp
Y2UuYw0KPiA+PiBAQCAtMTE5OSw5ICsxMTk5LDIxIEBAIHN0YXRpYyB2b2lkIHNldHVwX2RtYV9k
ZXZpY2Uoc3RydWN0IGliX2RldmljZQ0KPiAqZGV2aWNlKQ0KPiA+PiAgICAJCVdBUk5fT05fT05D
RSghcGFyZW50KTsNCj4gPj4gICAgCQlkZXZpY2UtPmRtYV9kZXZpY2UgPSBwYXJlbnQ7DQo+ID4+
ICAgIAl9DQo+ID4+IC0JLyogU2V0dXAgZGVmYXVsdCBtYXggc2VnbWVudCBzaXplIGZvciBhbGwg
SUIgZGV2aWNlcyAqLw0KPiA+PiAtCWRtYV9zZXRfbWF4X3NlZ19zaXplKGRldmljZS0+ZG1hX2Rl
dmljZSwgU1pfMkcpOw0KPiA+Pg0KPiA+PiArCWlmICghZGV2aWNlLT5kZXYuZG1hX3Bhcm1zKSB7
DQo+ID4+ICsJCWlmIChwYXJlbnQpIHsNCj4gPj4gKwkJCS8qDQo+ID4+ICsJCQkgKiBUaGUgY2Fs
bGVyIGRpZCBub3QgcHJvdmlkZSBETUEgcGFyYW1ldGVycywgc28NCj4gPj4gKwkJCSAqICdwYXJl
bnQnIHByb2JhYmx5IHJlcHJlc2VudHMgYSBQQ0kgZGV2aWNlLiBUaGUgUENJDQo+ID4+ICsJCQkg
KiBjb3JlIHNldHMgdGhlIG1heGltdW0gc2VnbWVudCBzaXplIHRvIDY0DQo+ID4+ICsJCQkgKiBL
Qi4gSW5jcmVhc2UgdGhpcyBwYXJhbWV0ZXIgdG8gMkcuDQo+ID4+ICsJCQkgKi8NCj4gPj4gKwkJ
CWRldmljZS0+ZGV2LmRtYV9wYXJtcyA9IHBhcmVudC0+ZG1hX3Bhcm1zOw0KPiA+PiArCQkJZG1h
X3NldF9tYXhfc2VnX3NpemUoZGV2aWNlLT5kbWFfZGV2aWNlLCBTWl8yRyk7DQo+ID4NCj4gPiBE
aWQgeW91IG1lYW4gZG1hX3NldF9tYXhfc2VnX3NpemUoJmRldmljZS0+ZGV2LCBTWl8yRyk/DQo+
IA0KPiBIYXZlIHlvdSByZWFsaXplZCB0aGF0IHRoYXQgY2FsbCBoYXMgdGhlIHNhbWUgZWZmZWN0
IGFzIHdoYXQgSSBwcm9wb3NlZCBzaW5jZSBib3RoDQo+IGRldmljZXMgc2hhcmUgdGhlIGRtYV9w
YXJtcyBwYXJhbWV0ZXI/DQo+IA0KSSBoYWRu4oCZdC4gVGhpcyBtYWtlcyBtb3JlIHNlbnNlIG5v
dy4NCg0KDQo=
