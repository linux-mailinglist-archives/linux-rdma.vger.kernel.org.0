Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2669747B26E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Dec 2021 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhLTR5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 12:57:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:41413 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhLTR5V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 12:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640023041; x=1671559041;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BmnFvzMHnoXb2qQd/0m+6ram7MVF1nTbyZtVkwv3V1s=;
  b=I2XfJAyjfTLuqBt+/B/LI2CMfqq4qUkFawAgLCAxxrwiPmknVg6mzz6I
   A0XJHx/KsOSIWduCRqG4asYLHSRQFtOTlePYQjo5dqx7lXsWi8YMZ2+tN
   EmeMVN3xBe6+SPkKibkB+dl74/NwH5VArbChC/eFln2+DHiZwr4mbcITX
   K+LQh+vCcCA6/oBvxZNH8JVL8bqyhGz7tMV2sX5nvyEuenT6pNdjNpVfr
   hiXofEYfFN1fAtF8XoZRGQvZpSnWsEElxKGdS3t4alsPMWUPvRHnj62WG
   w1RUeRajkdmmjaKl8G8DduKPAmVsKLIH1o59fP9VCKZ1ab4ySIslMoErw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240458710"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="240458710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 09:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="467481775"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 09:54:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 09:54:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 09:54:51 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Mon, 20 Dec 2021 09:54:51 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Mark Zhang <markzhang@nvidia.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
Thread-Topic: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
Thread-Index: AQHX88apkCCUAfjhkEmDdrZR/l+ARaw57bwAgAATcYCAAaoNcA==
Date:   Mon, 20 Dec 2021 17:54:51 +0000
Message-ID: <e441cd2204474035aa040053b0dfcfcd@intel.com>
References: <20211218204438.1345160-1-yanjun.zhu@linux.dev>
 <d76dfbd5-5812-85b8-7d70-c93c3bce3fe1@nvidia.com>
 <d2de2fb5-d2f2-f47c-34de-1d519d021c2d@linux.dev>
In-Reply-To: <d2de2fb5-d2f2-f47c-34de-1d519d021c2d@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIdjIgMS8xXSBSRE1BL2lyZG1hOiBNYWtlIHRoZSBzb3VyY2Ug
dWRwIHBvcnQgdmFyeQ0KPiANCj4gDQo+IOWcqCAyMDIxLzEyLzE5IDE1OjExLCBNYXJrIFpoYW5n
IOWGmemBkzoNCj4gPiBPbiAxMi8xOS8yMDIxIDQ6NDQgQU0sIHlhbmp1bi56aHVAbGludXguZGV2
IHdyb3RlOg0KPiA+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiA+Pg0KPiA+Pg0KPiA+PiBGcm9tOiBaaHUgWWFuanVuIDx5YW5qdW4u
emh1QGxpbnV4LmRldj4NCj4gPj4NCj4gPj4gQmFzZWQgb24gdGhlIGxpbmsNCj4gPj4gaHR0cHM6
Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtcmRtYS9tc2c3MzczNS5odG1sLA0KPiA+PiBn
ZXQgdGhlIHNvdXJjZSB1ZHAgcG9ydCBudW1iZXIgZm9yIGEgUVAgYmFzZWQgb24gdGhlIGdyaC5m
bG93X2xhYmVsDQo+ID4+IG9yIGxxcG4vcnFwbi4gVGhpcyBwcm92aWRlcyBhIGJldHRlciBzcHJl
YWQgb2YgdHJhZmZpYyBhY3Jvc3MgTklDIFJYDQo+ID4+IHF1ZXVlcy4NCj4gPj4gVGhlIG1ldGhv
ZCBpbiB0aGUgY29tbWl0IDJiODgwYjJlNWUwMyAoIlJETUEvbWx4NTogRGVmaW5lIFJvQ0V2MiB1
ZHANCj4gPj4gc291cmNlIHBvcnQgd2hlbiBzZXQgcGF0aCIpIGlzIGEgc3RhbmRhcmQgd2F5LiBT
byBpdCBpcyBhbHNvIGFkb3B0ZWQNCj4gPj4gaW4gdGhpcyBjb21taXQuDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPiA+PiAtLS0N
Cj4gPj4gVjEtPlYyOiBBZG9wdCBhIHN0YW5kYXJkIG1ldGhvZCB0byBnZXQgdWRwIHNvdXJjZSBw
b3J0Lg0KPiA+PiAtLS0NCj4gPj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL3ZlcmJz
LmMgfCAxMyArKysrKysrKysrKysrDQo+ID4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJk
bWEvdmVyYnMuYw0KPiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS92ZXJicy5jDQo+
ID4+IGluZGV4IDhjZDVmOTI2MTY5Mi4uOWZlNzNkMWRiMGQ5IDEwMDY0NA0KPiA+PiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvdmVyYnMuYw0KPiA+PiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvaXJkbWEvdmVyYnMuYw0KPiA+PiBAQCAtMTA5NCw2ICsxMDk0LDE1IEBAIHN0
YXRpYyBpbnQgaXJkbWFfcXVlcnlfcGtleShzdHJ1Y3QgaWJfZGV2aWNlDQo+ID4+ICppYmRldiwg
dTMyIHBvcnQsIHUxNiBpbmRleCwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4g
Pj4gwqAgfQ0KPiA+Pg0KPiA+PiArDQo+ID4+ICtzdGF0aWMgdTE2IGlyZG1hX2dldF91ZHBfc3Bv
cnQodTMyIGZsLCB1MzIgbHFwbiwgdTMyIHJxcG4pIHsNCj4gPj4gK8KgwqDCoMKgwqDCoCBpZiAo
IWZsKQ0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbCA9IHJkbWFfY2FsY19m
bG93X2xhYmVsKGxxcG4sIHJxcG4pOw0KPiA+PiArDQo+ID4+ICvCoMKgwqDCoMKgwqAgcmV0dXJu
IHJkbWFfZmxvd19sYWJlbF90b191ZHBfc3BvcnQoZmwpOyB9DQo+ID4+ICsNCj4gPj4gwqAgLyoq
DQo+ID4+IMKgwqAgKiBpcmRtYV9tb2RpZnlfcXBfcm9jZSAtIG1vZGlmeSBxcCByZXF1ZXN0DQo+
ID4+IMKgwqAgKiBAaWJxcDogcXAncyBwb2ludGVyIGZvciBtb2RpZnkNCj4gPj4gQEAgLTExNTks
NiArMTE2OCwxMCBAQCBpbnQgaXJkbWFfbW9kaWZ5X3FwX3JvY2Uoc3RydWN0IGliX3FwICppYnFw
LA0KPiA+PiBzdHJ1Y3QgaWJfcXBfYXR0ciAqYXR0ciwNCj4gPj4NCj4gPj4gwqDCoMKgwqDCoMKg
wqDCoCBjdHhfaW5mby0+cm9jZV9pbmZvLT5wZF9pZCA9IGl3cGQtPnNjX3BkLnBkX2lkOw0KPiA+
Pg0KPiA+PiArwqDCoMKgwqDCoMKgIHVkcF9pbmZvLT5zcmNfcG9ydCA9DQo+ID4+ICtpcmRtYV9n
ZXRfdWRwX3Nwb3J0KHVkcF9pbmZvLT5mbG93X2xhYmVsLA0KPiA+PiArIGlicXAtPnFwX251bSwN
Cj4gPj4gKyByb2NlX2luZm8tPmRlc3RfcXApOw0KPiA+PiArDQo+ID4NCj4gPiBGWUkgdGhhdCBp
biBtbHg1IGRyaXZlciB0aGUgdWRwX3Nwb3J0IGlzIG9ubHkgc2V0IHdoZW4gYWRkcmVzcyB2ZWN0
b3INCj4gPiBhbmQgZGVzdCBxcG4gKElCX1FQX0FWIGFuZCBJQl9RUF9ERVNUX1FQTikgaXMgcHJv
dmlkZWQuDQo+IA0KPiBTdXJlLiBGcm9tIG15IHRlc3RzLCB3aGVuIHRoaXMgZnVuY3Rpb24gaXJk
bWFfZ2V0X3VkcF9zcG9ydCBpcyBjYWxsZWQsIGRlc3QgcXBuDQo+IGlzIHJlYWR5Lg0KPiANCg0K
SSB0aGluayB0aGlzIG5lZWRzIHRvIG1vdmUgdG8gd2hlbiB3ZSBoYXZlIElCX1FQX0FWIGluIHRo
ZSBtYXNrIGFuZCBJQl9BSF9HUkggaW4gYWhfZmxhZ3MuDQoNClNvLCBpbiB0aGlzIGJsb2NrLA0K
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTYtcmM2L3NvdXJjZS9kcml2ZXJz
L2luZmluaWJhbmQvaHcvaXJkbWEvdmVyYnMuYyNMMTE3MSANCg0KU2hpcmF6DQo=
