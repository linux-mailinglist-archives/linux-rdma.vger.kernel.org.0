Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6D255191
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 01:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgH0XbB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 19:31:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:15841 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0XbB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 19:31:01 -0400
IronPort-SDR: /cylXaCzb5lwvF2BomeiH6isckexKyIO5jCdgb1Z+wOSXTnPOoFcHr/haGZbuEMhbukkmVmk9T
 oJhdzr0dxqOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218133072"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="218133072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 16:31:00 -0700
IronPort-SDR: +ZRtlyRnOvU8TO1jQ7t8C42u0h4JPR4449JPc+A/jaDi6ltzxODko3Uq/Cepv/qWEWIdt9+vFq
 jK4BUQhyzsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="280783652"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2020 16:30:59 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 16:30:01 -0700
Received: from orsmsx106.amr.corp.intel.com (10.22.225.133) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 16:30:01 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.122]) with mapi id 14.03.0439.000;
 Thu, 27 Aug 2020 16:30:00 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Christian Benvenuti" <benve@cisco.com>,
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
Thread-Index: AQHWegH0XKmutqff+UKxzS7b3hqhGKlI8IqAgAA9SQCAAAVogIAAD4EAgAAHFYCAAAM4AIAABYUAgAAq+NCAAT9EgIAANDbwgAEOxoCAAJiGkA==
Date:   Thu, 27 Aug 2020 23:30:00 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7010712DBF7@ORSMSX101.amr.corp.intel.com>
References: <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
 <20200826114043.GY1152540@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
 <20200827065643.GP1362631@unreal>
In-Reply-To: <20200827065643.GP1362631@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHJkbWEtbmV4dCAwMS8xMF0gUkRNQTogUmVzdG9yZSBhYmls
aXR5IHRvIGZhaWwgb24gUEQNCj4gZGVhbGxvY2F0ZQ0KPiANCj4gT24gVGh1LCBBdWcgMjcsIDIw
MjAgYXQgMDI6MDY6MDNBTSArMDAwMCwgU2FsZWVtLCBTaGlyYXogd3JvdGU6DQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHJkbWEtbmV4dCAwMS8xMF0gUkRNQTogUmVzdG9yZSBhYmlsaXR5IHRv
IGZhaWwNCj4gPiA+IG9uIFBEIGRlYWxsb2NhdGUNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEF1ZyAy
NiwgMjAyMCBhdCAxMjo0OTowM0FNICswMDAwLCBTYWxlZW0sIFNoaXJheiB3cm90ZToNCj4gPiA+
DQo+ID4gPiA+IFRoZSBBUEkgaXMgcXVpdGUgY29uZnVzaW5nIG5vdy4gSWYgZHJpdmVycyBhcmUg
bm90IGV4cGVjdGVkIHRvDQo+ID4gPiA+IGZhaWwgdGhlIGRlc3Ryb3kgYW5kIHRoZXJlIGlzIG5v
IHdheSB0byBwcm9wYWdhdGUgdGhlIGRldmljZQ0KPiA+ID4gPiBmYWlsdXJlcywgdGhlbiB0aGUg
cmV0dXJuIHR5cGUgc2hvdWxkIGJlIGEgdm9pZC4NCj4gPiA+DQo+ID4gPiBNb3JlIG9yIGxlc3Ms
IGRyaXZlcnMgY2FuIG9ubHkgcmV0dXJuIC1FQUdBSU4gd2l0aCB0aGUgaWRlYSB0aGF0IGENCj4g
PiA+IGZ1dHVyZSBjYWxsIGR1cmluZyB0aGUgY2xvc2UgcHJvY2VzcyB3aWxsIGV2ZW50dWFsbHkg
c3VjY2VlZC4NCj4gPiA+DQo+ID4gPiBBbnkgcGVybWFuZW50IGZhaWx1cmUgd2lsbCB0cmlnZ2Vy
IFdBUk5fT04gYW5kIGEgbWVtb3J5IGxlYWsNCj4gPiA+DQo+ID4gPiBNYXliZSB3ZSBzaG91bGQg
c3dpdGNoIHRoZSByZXR1cm4gY29kZSB0byBib29sIG9yIHNvbWV0aGluZyB0byBiZSBhDQo+ID4g
PiBsaXR0bGUgY2xlYXJlciB0aGF0IGl0IGlzIHJlcXVlc3QgdG8gcmV0cnksIG5vdCBhIGZhaWx1
cmU/DQo+ID4gPg0KPiA+IFRoZXJlIGlzIG5vIHJldHJ5IGZvciBrZXJuZWwgb2JqZWN0IGRlc3Ry
b3kgcmlnaHQ/IFNvIG5vdCBzdXJlIGJvb2wgaXMgbWFraW5nIEl0DQo+IGNsZWFyZXIuDQo+IA0K
PiBSaWdodCwga2VybmVsIHZlcmJzIHVzZXJzIGRvbid0IGtub3cgaG93IHRvIGRlYWwgd2l0aCBk
ZXN0cm95IGZhaWx1cmUgYW5kIGRlc2lnbmVkDQo+IHRvIGVuc3VyZSB0aGF0IGRlc3Ryb3kgYWx3
YXlzIHN1Y2Nlc3MuDQo+IA0KPiA+DQo+ID4gSSBhbSBub3QgdmVyeSBmYW1pbGlhciB3aXRoIGRl
dnggZmxvd3MgYnV0IGRvZXNu4oCZdCBpdCBieXBhc3MgdGhlIGliIHZlcmJzIGxheWVyDQo+IGFs
dG9nZXRoZXI/DQo+ID4gaS5lLiBtbHg1X2liX2RlYWxsb2NfcGQgaXNu4oCZdCBkaXJlY3RseSBj
YWxsZWQgaW4gdGhlIGRldnggZmxvd3Mgbm8/IFNvDQo+ID4gd2h5IGNoYW5nZXMgaXRzIHJldHVy
biB0eXBlIGFuZCBvdGhlciBwcm92aWRlciBkZXN0cm95IGNhbGxiYWNrcz8NCj4gDQo+IERldlgg
aXRzZWxmIGluZGVlZCBieXBhc3NlcyBpYl9jb3JlIGFuZCBhcyBhIHN0YW5kYWxvbmUgZmVhdHVy
ZSBkb2Vzbid0IG5lZWQNCj4gYW55IGNoYW5nZXMgaW4gZGVzdHJveXMuIFRoZSBwcm9ibGVtIGFy
aXNlcyB3aGVuIGliX2NvcmUgb2JqZWN0IGlzIGNyZWF0ZWQgd2l0aA0KPiBpYnZfY3JlYXRlX1hY
WCgpIGFuZCBmb3J3YXJkZWQgbGF0ZXIgdG8gRGV2WCBjb250ZXh0Lg0KPiANCj4gRlcgY291bnRz
IERldlggYWNjZXNzZXMgYW5kIGVsZXZhdGVzIGludGVybmFsIHJlZmVyZW5jZSBjb3VudGVycyB0
byBlbnN1cmUgdGhhdA0KPiB1c2VyIHdpbGwgZ2V0IHByb3BlciBlcnJvciBpZiBoZSB0cmllcyB0
byBkZXN0cm95IGluLXVzZSByZXNvdXJjZXMuDQo+IA0KPiBUaGlzIGVycm9yIGlzIHJldHVybmVk
IHRvIG1seDVfaWJfZGVhbGxvY19wZCgpIHRvbyBpZiBEZXZYIGlzIG5vdCBjbGVhbmVkLiBUaGlz
IGNhbGwNCj4gY2FuIGJlIGV4ZWN1dGVkIGJ5IHVzZXIgYW55dGltZSwgZm9yIGV4YW1wbGUgaWYg
aGUgZGVjaWRlZCB0byBza2lwIERldlggY2xlYW51cA0KPiBhbmQgdGhlIGliX2NvcmUvbWx4NV9p
YiBjYW4ndCBwcmV2ZW50IGNhbGwgdG8gbWx4NV9pYl9kZWFsbG9jX3BkKCkgYXQgdGhpcyBzdGFn
ZS4NCj4gDQo+IFRoZSBkaWZmZXJlbmNlIGJldHdlZW4gbWx4NSBkZXZpY2UgZnJvbSBvdGhlciBw
cm92aWRlcnMgdGhhdCBIVy9GVyBndWFyYW50ZWVzDQo+IGZ1bGwgY2xlYW51cCBkdXJpbmcgZmls
ZSBjbG9zZS4NCj4gDQo+ID4NCj4gPiBCdXQgbGV0cyBnbyBkb3duIHRoZSBwYXRoIHRoYXQgd2Ug
cmVhbGx5IG5lZWQgYSByZXR1cm4gY29kZSBpbiB0aGUgZGVzdHJveSBBUElzDQo+IHRvIHNvbHZl
IHRoaXMgcHJvYmxlbS4NCj4gPiBGb3Igb25lIEkgZG9u4oCZdCBzZWUgaG93IHdlIGNhbiBzYXkg
aXRzIG1lYW50IGV4Y2x1c2l2ZWx5IGZvciBkZXZ4IGRyaXZlcnMgdG8gdXNlDQo+IGZvciBhIGZh
aWwuDQo+ID4gQWxzbyBjYW4gd2UgcmVhbGx5IGNsYWltIHRoZSBBUEkgY29udHJhY3QgaXMgdGhh
dCBkcml2ZXIgY2FuIGZhaWwgYSBkZXN0cm95IGdpdmVuIGENCj4gZnV0dXJlIGRlc3Ryb3kgd2ls
bCBzdWNjZWVkPw0KPiA+IFNpbmNlIHRoZSBrZXJuZWwgZGVzdHJveSBoYXMgbm8gcmV0cnkuDQo+
IA0KPiBUaGlzIGlzIHdoeSB3ZSBoYXZlIHNwZWNpYWwgY2FsbHMgZm9yIGtlcm5lbCB1c2VycyB3
aXRoIFdBUk5fT04oKSBhbmQgZm9yY2VkDQo+IGNsZWFudXAgb2YgaWJfY29yZSByZXNvdXJjZXMu
DQo+IA0KPiA+DQo+ID4gV2hpY2ggdGhlbiBib2lscyBkb3duIGRvIHdlIGp1c3Qga2VlcCBhIHNp
bXBsZXIgZGVmaW5pdGlvbiBvZiB0aGUgQVBJIGNvbnRyYWN0IC0tDQo+IGRyaXZlciBjYW4ganVz
dCByZXR1cm4gd2hhdGV2ZXIgdGhlIHRydWUgZXJyb3IgY29kZSBpcz8NCj4gPiBpLmUuIGlmIGl0
IHdhbnRzIGEgcmV0cnksIHVzZSBFQUdBSU4uIElmIGl0IGhhcyBhIG5vbiByZWNvdmVyYWJsZSBk
ZXZpY2UgZXJyb3IsIHRoZW4NCj4gcmVzZXQgdGhlIGRldmljZSwgY2xlYW4gdXAgdGhlIHJlc291
cmNlcyBidXQgcmV0dXJuIEVOT1RSRUNPVkVSQUJMRS4NCj4gPiBpYl9jb3JlIGNhbiBlbmFibGUg
dGhlIHJldHJ5IGxvZ2ljIGZvciBFQUdBSU4gX29ubHlfLiAgRm9yIG90aGVyIGVycm9yIGNvZGVz
LA0KPiBJYl9jb3JlIGNhbiB0cmlnZ2VyIGEgd2Fybl9vbiBvciBzb21ldGhpbmcgdG8gaW5kaWNh
dGUgcGVybWFuZW50IGZhaWx1cmUuDQo+IA0KPiBXZSBjYW4sIGJ1dCBkcml2ZXJzIHNob3VsZCBp
bXBsZW1lbnQgdGhpcyBFQUdBSU4vRU5PVFJFQ09WRVJBQkxFIGxvZ2ljLA0KPiB0aGlzIGlzIHdo
eSBpbiBpbml0aWFsIHBoYXNlIHdlIGFyZSByZXR1cm5pbmcgYWx3YXlzIHN1Y2Nlc3MuDQo+IA0K
SSBkb27igJl0IHRoaW5rIEphc29uIGlzIGVudGVydGFpbmluZyB0aGlzLiBTby4uLg0K
