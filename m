Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14ED2524D5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHZAtG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 20:49:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:17804 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgHZAtF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 20:49:05 -0400
IronPort-SDR: L1RNuVjzNGjCbUmOt4PlfbK0q906zEl7LcoMPQ+Nw0gcgt7BEtCPLuNgREq+HM5CXXCEu49JDT
 Bhh4lkERGuyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="153791438"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="153791438"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 17:49:04 -0700
IronPort-SDR: yBFwR5U41meY2wa/l3YlMTkWARSyiZQh3Nv348uxmMDzus07IEbF/LXx5qayX7lAi7k7Q72olU
 nc523hVOrEQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="331607072"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
  by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2020 17:49:04 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Aug 2020 17:49:04 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Aug 2020 17:49:04 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.157]) by
 FMSMSX152.amr.corp.intel.com ([169.254.6.37]) with mapi id 14.03.0439.000;
 Tue, 25 Aug 2020 17:49:03 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
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
Thread-Index: AQHWegH0XKmutqff+UKxzS7b3hqhGKlI8IqAgAA9SQCAAAVogIAAD4EAgAAHFYCAAAM4AIAABYUAgAAq+NA=
Date:   Wed, 26 Aug 2020 00:49:03 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
In-Reply-To: <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHJkbWEtbmV4dCAwMS8xMF0gUkRNQTogUmVzdG9yZSBhYmls
aXR5IHRvIGZhaWwgb24gUEQNCj4gZGVhbGxvY2F0ZQ0KPiANCj4gT24gMjUvMDgvMjAyMCAxNjo0
NCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXVnIDI1LCAyMDIwIGF0IDA0
OjMyOjU3UE0gKzAzMDAsIEdhbCBQcmVzc21hbiB3cm90ZToNCj4gPj4+IEZvciB1dmVyYnMgaXQg
d2lsbCBnbyBpbnRvIGFuIGluZmluaXRlIGxvb3AgaW4NCj4gPj4+IHV2ZXJic19kZXN0cm95X3Vm
aWxlX2h3KCkgaWYgZGVzdHJveSBkb2Vzbid0IGV2ZW50dWFsbHkgc3VjY2VlZC4NCj4gPj4NCj4g
Pj4gVGhlIGNvZGUgYnJlYWtzIHRoZSBsb29wIGluIHN1Y2ggY2FzZXMsIHdoeSBpbmZpbml0ZSBs
b29wPw0KPiA+DQo+ID4gT2gsIHRoYXQgaXMgYSBidWcsIGl0IHNob3VsZCBXQVJOX09OIHdoZW4g
dGhhdCBoYXBwZW5zLCBiZWNhdXNlIHRoZQ0KPiA+IGRyaXZlciBoYXMgdHJpZ2dlcmVkIGEgcGVy
bWFuZW50IG1lbW9yeSBsZWFrLg0KPiANCj4gV2VsbCwgYSBXQVJOX09OIHdvbid0IGRvIG11Y2gg
Z29vZCBpZiB5b3UncmUgc3R1Y2sgaW4gYW4gaW5maW5pdGUgbG9vcCA6KSwgdGhlDQo+IGJyZWFr
IGlzIGRlZmluaXRlbHkgbmVlZGVkIHRoZXJlLg0KPiANCj4gPj4+IEZvciBrZXJuZWwgaXQgd2ls
bCB0cmlnZ2VyIFdBUk5fT04ncyBhbmQgdGhlbiBhIHBlcm1hbmVudCBtZW1vcnkgbGVhay4NCj4g
Pj4+DQo+ID4+Pj4gSSBhZ3JlZSB0aGF0IGRyaXZlcnMgc2hvdWxkbid0IGZhaWwgZGVzdHJveSBj
b21tYW5kcywgYnV0IHlvdQ0KPiA+Pj4+IGtub3cuLiBidWdzL2Vycm9ycyBoYXBwZW4gKGVzcGVj
aWFsbHkgd2hlbiBkZWFsaW5nIHdpdGggaGFyZHdhcmUpLA0KPiA+Pj4+IGFuZCB3ZSBoYXZlIGEg
d2F5IHRvIHByb3BhZ2F0ZSB0aGVtLCB3aHkgZG8gaXQgZm9yIG9ubHkgc29tZSBvZiB0aGUNCj4g
ZHJpdmVycz8NCj4gPj4+DQo+ID4+PiBUaGVyZSBpcyBubyB3YXkgdG8gcHJvcG9nYXRlIHRoZW0u
DQo+ID4+Pg0KPiA+Pj4gQWxsIGRlc3Ryb3kgbXVzdCBldmVudHVhbGx5IHN1Y2NlZWQuDQo+ID4+
DQo+ID4+IFRoZXJlIGlzIG5vIHdheSB0byBwcm9wYWdhdGUgdGhlbSBvbiBwcm9jZXNzIGNsZWFu
dXAsIGJ1dCB0aGUgZGVzdHJveQ0KPiA+PiB2ZXJicyBoYXZlIGEgcmV0dXJuIGNvZGUgYWxsIHRo
ZSB3YXkgYmFjayB0byBsaWJpYnZlcmJzLCB3aGljaCB3ZSBjYW4NCj4gPj4gdXNlIGZvciBlcnJv
ciBwcm9wYWdhdGlvbi4NCj4gPg0KPiA+IEl0IGlzIHNvcnQgb2YgT0sgZm9yIGEgZHJpdmVyIHRv
IGZhaWwgZHVyaW5nIFJETUFfUkVNT1ZFX0RFU1RST1kuDQo+ID4NCj4gPiBBbGwgb3RoZXIgcmVh
c29uIGNvZGVzIG11c3QgZXZlbnR1YWxseSBzdWNjZWVkLg0KPiA+DQo+ID4+IFRoZSBjbGVhbnVw
IGZsb3cgY2FuIGVpdGhlciBpZ25vcmUgdGhlIHJldHVybiB2YWx1ZSwgb3Igd2UgY2FuIGFkZA0K
PiA+PiBhbm90aGVyIHBhcmFtZXRlciB0aGF0IGV4cGxpY2l0bHkgbWVhbnMgdGhlIGNhbGwgc2hv
dWxkbid0IGZhaWwgYW5kDQo+ID4+IGFsbCBhbGxvY2F0ZWQgbWVtb3J5L3N0YXRlIHNob3VsZCBi
ZSBmcmVlZC4NCj4gPg0KPiA+IEkgZG9uJ3QgcmVhbGx5IHNlZSB0aGUgdmFsdWUgdG8gcmV0dXJu
IHRoZSBlcnJvciBjb2RlIHRvIHVzZXJzcGFjZSwgaXQNCj4gPiB3b3VsZCByZXF1aXJlIGNodXJu
aW5nIGFsbCB0aGUgZHJpdmVycyBhbmQgYWxsIHRoZSBkZXN0cm95IGZ1bmN0aW9ucw0KPiA+IHRv
IHBhc3MgdGhlIGV4aXN0aW5nIHJlYXNvbiBpbi4NCj4gPg0KPiA+IFNpbmNlIGFsbCB0aGUgZGV0
YWlscyBvZiB0aGUgRlcgZmFpbHVyZSByZWFzb24gYXJlIGxvc3QgdG8gc29tZSBFSU5WQUwNCj4g
PiAob3IgYWxyZWFkeSBsb2dnZWQgdG8gZG1lc2cpIEkgZG9uJ3Qgc2VlIG11Y2ggcG9pbnQuDQo+
IA0KPiBSaWdodCwgYXMgYWx3YXlzLCB0aGUgZXJyb3IgY29kZSB3b3VsZCBwcm9iYWJseSBub3Qg
Y29udGFpbiBtdWNoIGluZm9ybWF0aW9uLCBidXQNCj4gdGhlcmUncyBhIGJpZyBkaWZmZXJlbmNl
IGJldHdlZW4gcmV0dXJuaW5nIGVycm9yIGNvZGUgWC9ZIHZzIHJldHVybmluZyBzdWNjZXNzDQo+
IGluc3RlYWQgb2YgYW4gZXJyb3IuIFRvIG1lIHRoYXQganVzdCBmZWVscyB3cm9uZywgYXQgbGVh
c3QgaW4gY2FzZXMgd2hlcmUgd2UgY2FuDQo+IHByZXZlbnQgdGhhdC4NCj4gDQoNClRoZSBBUEkg
aXMgcXVpdGUgY29uZnVzaW5nIG5vdy4gSWYgZHJpdmVycyBhcmUgbm90IGV4cGVjdGVkIHRvIGZh
aWwgdGhlIGRlc3Ryb3kNCmFuZCB0aGVyZSBpcyBubyB3YXkgdG8gcHJvcGFnYXRlIHRoZSBkZXZp
Y2UgZmFpbHVyZXMsIHRoZW4gdGhlIHJldHVybiB0eXBlIHNob3VsZCBiZSBhIHZvaWQuDQoNCkRv
IHdlIHJlYWxseSB3YW50IHRvIGhhdmUgbWl4ZWQvYW1iaWd1b3VzIGRlZmluaXRpb24gb2YgdGhl
IEFQSSB0byBzdXBwb3J0IHRoZSBxdWlya3Mgb2Ygb25lIHR5cGUgb2YgZGV2aWNlPw0KDQpTaGly
YXoNCg0K
