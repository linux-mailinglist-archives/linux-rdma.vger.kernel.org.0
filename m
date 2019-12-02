Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3293210EACF
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2019 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLBNbB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 08:31:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:17542 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBNbB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Dec 2019 08:31:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 05:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="208083122"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2019 05:31:00 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Dec 2019 05:31:00 -0800
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.125]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.88]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 05:31:00 -0800
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>
Subject: RE: [PATCH for-next v2 02/11] IB/hfi1: List all receive contexts
 from debugfs
Thread-Topic: [PATCH for-next v2 02/11] IB/hfi1: List all receive contexts
 from debugfs
Thread-Index: AQHVpGOPjh5aI2cJS0CS26OF5mnLPqem4JbQ
Date:   Mon, 2 Dec 2019 13:30:59 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663D9C96A57@FMSMSX108.amr.corp.intel.com>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
 <20191126141220.58836.41480.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126141220.58836.41480.stgit@awfm-01.aw.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWNmZjljODYtZDFjOC00MmNhLTk1NTktMzhmYTVkYTY0MzM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU1VWM3pzcEp3eG4xRTlMc1VlWHB6V29WZWZvUEthVlRpV0VmTEl6aXlBOEpqRm1vQWZtOHFkanZ4YncyRnpsdiJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFsZXNzYW5kcm8sIERlbm5pcyA8
ZGVubmlzLmRhbGVzc2FuZHJvQGludGVsLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAy
NiwgMjAxOSA5OjEyIEFNDQo+VG86IGpnZ0B6aWVwZS5jYTsgZGxlZGZvcmRAcmVkaGF0LmNvbQ0K
PkNjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgUnVobCwgTWljaGFlbCBKIDxtaWNoYWVs
LmoucnVobEBpbnRlbC5jb20+Ow0KPk1hcmNpbmlzenluLCBNaWtlIDxtaWtlLm1hcmNpbmlzenlu
QGludGVsLmNvbT47IFdhbiwgS2Fpa2UNCj48a2Fpa2Uud2FuQGludGVsLmNvbT4NCj5TdWJqZWN0
OiBbUEFUQ0ggZm9yLW5leHQgdjIgMDIvMTFdIElCL2hmaTE6IExpc3QgYWxsIHJlY2VpdmUgY29u
dGV4dHMgZnJvbQ0KPmRlYnVnZnMNCj4NCj5Gcm9tOiBNaWNoYWVsIEouIFJ1aGwgPG1pY2hhZWwu
ai5ydWhsQGludGVsLmNvbT4NCj4NCj5UaGUgY3VycmVudCBkZWJ1Z2ZzIG91dHB1dCBmb3IgcmVj
ZWl2ZSBjb250ZXh0cyAocmNkcyksIHN0b3BzIGFmdGVyDQo+dGhlIGtlcm5lbCByZWNlaXZlIGNv
bnRleHRzIGhhdmUgYmVlbiBkaXNwbGF5ZWQuICBUaGlzIGlzIG5vdCBlbm91Z2gNCj5pbmZvcm1h
dGlvbi4NCj4NCj5EaXNwbGF5IGFsbCBvZiB0aGUgcmVjZWl2ZSBjb250ZXh0cy4NCj4NCj5BdWdt
ZW50IHRoZSBvdXRwdXQgd2l0aCBzb21lIG1vcmUgY29udGV4dCBpbmZvcm1hdGlvbi4NCj4NCj5M
aW1pdCB0aGUgcmluZyBidWZmZXIgaGVhZGVyIG91dHB1dCB0byA1IGVudHJpZXMgdG8gYXZvaWQN
Cj5vdmVyZXh0ZW5kaW5nIHRoZXkgc2VxdWVudGlhbCBmaWxlIG91dHB1dC4NCg0KTWlub3Igbml0
Og0KDQpzL3RoZXkvdGhlDQoNCk1pa2UNCg0KPg0KPlJldmlld2VkLWJ5OiBEZW5uaXMgRGFsZXNz
YW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0BpbnRlbC5jb20+DQo+UmV2aWV3ZWQtYnk6IE1pa2Ug
TWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AaW50ZWwuY29tPg0KPlNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgSi4gUnVobCA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29tPg0KPlNpZ25lZC1vZmYt
Ynk6IEthaWtlIFdhbiA8a2Fpa2Uud2FuQGludGVsLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBEZW5u
aXMgRGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0BpbnRlbC5jb20+DQo+LS0tDQo+IGRy
aXZlcnMvaW5maW5pYmFuZC9ody9oZmkxL2RlYnVnZnMuYyB8ICAgIDIgKy0NCj4gZHJpdmVycy9p
bmZpbmliYW5kL2h3L2hmaTEvZHJpdmVyLmMgIHwgICAxMiArKysrKysrKystLS0NCj4gMiBmaWxl
cyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaGZpMS9kZWJ1Z2ZzLmMNCj5iL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9oZmkxL2RlYnVnZnMuYw0KPmluZGV4IGQyNjhiZjkuLjQ2MzNhMGMgMTAwNjQ0
DQo+LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2hmaTEvZGVidWdmcy5jDQo+KysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL2h3L2hmaTEvZGVidWdmcy5jDQo+QEAgLTM3OSw3ICszNzksNyBAQCBz
dGF0aWMgdm9pZCAqX3JjZHNfc2VxX25leHQoc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp2LA0K
PmxvZmZfdCAqcG9zKQ0KPiAJc3RydWN0IGhmaTFfZGV2ZGF0YSAqZGQgPSBkZF9mcm9tX2Rldihp
YmQpOw0KPg0KPiAJKysqcG9zOw0KPi0JaWYgKCFkZC0+cmNkIHx8ICpwb3MgPj0gZGQtPm5fa3Jj
dl9xdWV1ZXMpDQo+KwlpZiAoIWRkLT5yY2QgfHwgKnBvcyA+PSBkZC0+bnVtX3Jjdl9jb250ZXh0
cykNCj4gCQlyZXR1cm4gTlVMTDsNCj4gCXJldHVybiBwb3M7DQo+IH0NCj5kaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2hmaTEvZHJpdmVyLmMNCj5iL2RyaXZlcnMvaW5maW5pYmFu
ZC9ody9oZmkxL2RyaXZlci5jDQo+aW5kZXggY2JjNTIxOS4uODM3NDkyMiAxMDA2NDQNCj4tLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaGZpMS9kcml2ZXIuYw0KPisrKyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9oZmkxL2RyaXZlci5jDQo+QEAgLTE3MjYsMjMgKzE3MjYsMjkgQEAgc3RhdGlj
IGludCBwcm9jZXNzX3JlY2VpdmVfaW52YWxpZChzdHJ1Y3QNCj5oZmkxX3BhY2tldCAqcGFja2V0
KQ0KPiAJcmV0dXJuIFJIRl9SQ1ZfQ09OVElOVUU7DQo+IH0NCj4NCj4rI2RlZmluZSBIRkkxX1JD
VkhEUl9EVU1QX01BWAk1DQo+Kw0KPiB2b2lkIHNlcWZpbGVfZHVtcF9yY2Qoc3RydWN0IHNlcV9m
aWxlICpzLCBzdHJ1Y3QgaGZpMV9jdHh0ZGF0YSAqcmNkKQ0KPiB7DQo+IAlzdHJ1Y3QgaGZpMV9w
YWNrZXQgcGFja2V0Ow0KPiAJc3RydWN0IHBzX21kYXRhIG1kYXRhOw0KPisJaW50IGk7DQo+DQo+
LQlzZXFfcHJpbnRmKHMsICJSY2QgJXU6IFJjdkhkciBjbnQgJXUgZW50c2l6ZSAldSAlcyBoZWFk
ICVsbHUgdGFpbA0KPiVsbHVcbiIsDQo+KwlzZXFfcHJpbnRmKHMsICJSY2QgJXU6IFJjdkhkciBj
bnQgJXUgZW50c2l6ZSAldSAlcyBjdHJsIDB4JTA4bGx4DQo+c3RhdHVzIDB4JTA4bGx4LCBoZWFk
ICVsbHUgdGFpbCAlbGx1ICBzdyBoZWFkICV1XG4iLA0KPiAJCSAgIHJjZC0+Y3R4dCwgZ2V0X2hk
cnFfY250KHJjZCksIGdldF9oZHJxZW50c2l6ZShyY2QpLA0KPiAJCSAgIGdldF9kbWFfcnRhaWxf
c2V0dGluZyhyY2QpID8NCj4gCQkgICAiZG1hX3J0YWlsIiA6ICJub2RtYV9ydGFpbCIsDQo+KwkJ
ICAgcmVhZF9rY3R4dF9jc3IocmNkLT5kZCwgcmNkLT5jdHh0LCBSQ1ZfQ1RYVF9DVFJMKSwNCj4r
CQkgICByZWFkX2tjdHh0X2NzcihyY2QtPmRkLCByY2QtPmN0eHQsIFJDVl9DVFhUX1NUQVRVUyks
DQo+IAkJICAgcmVhZF91Y3R4dF9jc3IocmNkLT5kZCwgcmNkLT5jdHh0LCBSQ1ZfSERSX0hFQUQp
ICYNCj4gCQkgICBSQ1ZfSERSX0hFQURfSEVBRF9NQVNLLA0KPi0JCSAgIHJlYWRfdWN0eHRfY3Ny
KHJjZC0+ZGQsIHJjZC0+Y3R4dCwgUkNWX0hEUl9UQUlMKSk7DQo+KwkJICAgcmVhZF91Y3R4dF9j
c3IocmNkLT5kZCwgcmNkLT5jdHh0LCBSQ1ZfSERSX1RBSUwpLA0KPisJCSAgIHJjZC0+aGVhZCk7
DQo+DQo+IAlpbml0X3BhY2tldChyY2QsICZwYWNrZXQpOw0KPiAJaW5pdF9wc19tZGF0YSgmbWRh
dGEsICZwYWNrZXQpOw0KPg0KPi0Jd2hpbGUgKDEpIHsNCj4rCWZvciAoaSA9IDA7IGkgPCBIRkkx
X1JDVkhEUl9EVU1QX01BWDsgaSsrKSB7DQo+IAkJX19sZTMyICpyaGZfYWRkciA9IChfX2xlMzIg
KilyY2QtPnJjdmhkcnEgKyBtZGF0YS5wc19oZWFkDQo+Kw0KPiAJCQkJCSByY2QtPnJoZl9vZmZz
ZXQ7DQo+IAkJc3RydWN0IGliX2hlYWRlciAqaGRyOw0KDQo=
