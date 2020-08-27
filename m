Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74448253BD0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 04:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgH0CHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 22:07:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:30757 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgH0CHN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Aug 2020 22:07:13 -0400
IronPort-SDR: 64e3OsBmJ8FXiKw7jcE0eXiabXHRebybg9dP+tKcBsYUuEBK1IT7qb53sxRxmo9CzPXf/5y5aF
 tbmh5XKmDTEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="156414686"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="156414686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 19:07:11 -0700
IronPort-SDR: rRHE6VhShX1hS7pngx9+CELnj+auxS2HUnU/49PBcsKndG/FoktuoLLBydyzzV4J+B2kPJTY2O
 4Qm8GlQO+n6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="339359236"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com) ([10.22.229.85])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2020 19:07:11 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 19:06:04 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Aug 2020 19:06:04 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.250]) with mapi id 14.03.0439.000;
 Wed, 26 Aug 2020 19:06:04 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: RE: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Thread-Topic: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Thread-Index: AQHWegH0XKmutqff+UKxzS7b3hqhGKlI8IqAgAA9SQCAAAVogIAAD4EAgAAHFYCAAAM4AIAABYUAgAAq+NCAAT9EgIAANDbw
Date:   Thu, 27 Aug 2020 02:06:03 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
 <20200826114043.GY1152540@nvidia.com>
In-Reply-To: <20200826114043.GY1152540@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHJkbWEtbmV4dCAwMS8xMF0gUkRNQTogUmVzdG9yZSBhYmls
aXR5IHRvIGZhaWwgb24gUEQNCj4gZGVhbGxvY2F0ZQ0KPiANCj4gT24gV2VkLCBBdWcgMjYsIDIw
MjAgYXQgMTI6NDk6MDNBTSArMDAwMCwgU2FsZWVtLCBTaGlyYXogd3JvdGU6DQo+IA0KPiA+IFRo
ZSBBUEkgaXMgcXVpdGUgY29uZnVzaW5nIG5vdy4gSWYgZHJpdmVycyBhcmUgbm90IGV4cGVjdGVk
IHRvIGZhaWwNCj4gPiB0aGUgZGVzdHJveSBhbmQgdGhlcmUgaXMgbm8gd2F5IHRvIHByb3BhZ2F0
ZSB0aGUgZGV2aWNlIGZhaWx1cmVzLCB0aGVuDQo+ID4gdGhlIHJldHVybiB0eXBlIHNob3VsZCBi
ZSBhIHZvaWQuDQo+IA0KPiBNb3JlIG9yIGxlc3MsIGRyaXZlcnMgY2FuIG9ubHkgcmV0dXJuIC1F
QUdBSU4gd2l0aCB0aGUgaWRlYSB0aGF0IGEgZnV0dXJlIGNhbGwgZHVyaW5nDQo+IHRoZSBjbG9z
ZSBwcm9jZXNzIHdpbGwgZXZlbnR1YWxseSBzdWNjZWVkLg0KPiANCj4gQW55IHBlcm1hbmVudCBm
YWlsdXJlIHdpbGwgdHJpZ2dlciBXQVJOX09OIGFuZCBhIG1lbW9yeSBsZWFrDQo+IA0KPiBNYXli
ZSB3ZSBzaG91bGQgc3dpdGNoIHRoZSByZXR1cm4gY29kZSB0byBib29sIG9yIHNvbWV0aGluZyB0
byBiZSBhIGxpdHRsZSBjbGVhcmVyDQo+IHRoYXQgaXQgaXMgcmVxdWVzdCB0byByZXRyeSwgbm90
IGEgZmFpbHVyZT8NCj4gDQpUaGVyZSBpcyBubyByZXRyeSBmb3Iga2VybmVsIG9iamVjdCBkZXN0
cm95IHJpZ2h0PyBTbyBub3Qgc3VyZSBib29sIGlzIG1ha2luZyBJdCBjbGVhcmVyLg0KDQpJIGFt
IG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggZGV2eCBmbG93cyBidXQgZG9lc27igJl0IGl0IGJ5cGFz
cyB0aGUgaWIgdmVyYnMgbGF5ZXIgYWx0b2dldGhlcj8NCmkuZS4gbWx4NV9pYl9kZWFsbG9jX3Bk
IGlzbuKAmXQgZGlyZWN0bHkgY2FsbGVkIGluIHRoZSBkZXZ4IGZsb3dzIG5vPyBTbyB3aHkgY2hh
bmdlcyBpdHMgcmV0dXJuDQp0eXBlIGFuZCBvdGhlciBwcm92aWRlciBkZXN0cm95IGNhbGxiYWNr
cz8NCg0KQnV0IGxldHMgZ28gZG93biB0aGUgcGF0aCB0aGF0IHdlIHJlYWxseSBuZWVkIGEgcmV0
dXJuIGNvZGUgaW4gdGhlIGRlc3Ryb3kgQVBJcyB0byBzb2x2ZSB0aGlzIHByb2JsZW0uDQpGb3Ig
b25lIEkgZG9u4oCZdCBzZWUgaG93IHdlIGNhbiBzYXkgaXRzIG1lYW50IGV4Y2x1c2l2ZWx5IGZv
ciBkZXZ4IGRyaXZlcnMgdG8gdXNlIGZvciBhIGZhaWwuDQpBbHNvIGNhbiB3ZSByZWFsbHkgY2xh
aW0gdGhlIEFQSSBjb250cmFjdCBpcyB0aGF0IGRyaXZlciBjYW4gZmFpbCBhIGRlc3Ryb3kgZ2l2
ZW4gYSBmdXR1cmUgZGVzdHJveSB3aWxsIHN1Y2NlZWQ/DQpTaW5jZSB0aGUga2VybmVsIGRlc3Ry
b3kgaGFzIG5vIHJldHJ5Lg0KDQpXaGljaCB0aGVuIGJvaWxzIGRvd24gZG8gd2UganVzdCBrZWVw
IGEgc2ltcGxlciBkZWZpbml0aW9uIG9mIHRoZSBBUEkgY29udHJhY3QgLS0gZHJpdmVyIGNhbiBq
dXN0IHJldHVybiB3aGF0ZXZlciB0aGUgdHJ1ZSBlcnJvciBjb2RlIGlzPw0KaS5lLiBpZiBpdCB3
YW50cyBhIHJldHJ5LCB1c2UgRUFHQUlOLiBJZiBpdCBoYXMgYSBub24gcmVjb3ZlcmFibGUgZGV2
aWNlIGVycm9yLCB0aGVuIHJlc2V0IHRoZSBkZXZpY2UsIGNsZWFuIHVwIHRoZSByZXNvdXJjZXMg
YnV0IHJldHVybiBFTk9UUkVDT1ZFUkFCTEUuDQppYl9jb3JlIGNhbiBlbmFibGUgdGhlIHJldHJ5
IGxvZ2ljIGZvciBFQUdBSU4gX29ubHlfLiAgRm9yIG90aGVyIGVycm9yIGNvZGVzLCBJYl9jb3Jl
IGNhbiB0cmlnZ2VyIGEgd2Fybl9vbiBvciBzb21ldGhpbmcgdG8gaW5kaWNhdGUgcGVybWFuZW50
IGZhaWx1cmUuDQpJdCBjYW4gYWxzbyBwYXNzIG9uIHJldF9jb2RlIHRvIHVzZXItc3BhY2UgYXMg
aXRzIGRvaW5nIHRvZGF5Pw0KDQpTaGlyYXoNCg0KDQoNCg0K
