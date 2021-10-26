Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB643AE1C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhJZIfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 04:35:13 -0400
Received: from mx22.baidu.com ([220.181.50.185]:35872 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234435AbhJZIfM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 04:35:12 -0400
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id BA0F310589D61CEC0ABC;
        Tue, 26 Oct 2021 16:32:30 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 26 Oct 2021 16:32:30 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Tue, 26 Oct 2021 16:32:30 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] kthread: Add the helper function
 kthread_run_on_cpu()
Thread-Topic: [PATCH v3 1/6] kthread: Add the helper function
 kthread_run_on_cpu()
Thread-Index: AQHXxvDG6BMxoeagk0Ch2rpac1seKavk+Xww
Date:   Tue, 26 Oct 2021 08:32:30 +0000
Message-ID: <40fae23eb02c4363bc75649e23f78c1c@baidu.com>
References: <20211022025711.3673-1-caihuoqing@baidu.com>
 <20211022025711.3673-2-caihuoqing@baidu.com>
In-Reply-To: <20211022025711.3673-2-caihuoqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.21.146.48]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8sDQpKdXN0IGEgcGluZywgdG8gc2VlIGlmIHRoZXJlIGFyZSBhbnkgbW9yZSBjb21tZW50
cyA6LVANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2FpLEh1b3Fpbmcg
PGNhaWh1b3FpbmdAYmFpZHUuY29tPg0KPiBTZW50OiAyMDIxxOoxMNTCMjLI1SAxMDo1Nw0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjMgMS82XSBrdGhyZWFkOiBBZGQgdGhlIGhlbHBlciBmdW5jdGlvbiBr
dGhyZWFkX3J1bl9vbl9jcHUoKQ0KPiANCj4gdGhlIGhlbHBlciBmdW5jdGlvbiBrdGhyZWFkX3J1
bl9vbl9jcHUoKSBpbmNsdWRlcw0KPiBrdGhyZWFkX2NyZWF0ZV9vbl9jcHUvd2FrZV91cF9wcm9j
ZXNzKCkuDQo+IEluIHNvbWUgY2FzZXMsIHVzZSBrdGhyZWFkX3J1bl9vbl9jcHUoKSBkaXJlY3Rs
eSBpbnN0ZWFkIG9mDQo+IGt0aHJlYWRfY3JlYXRlX29uX25vZGUva3RocmVhZF9iaW5kL3dha2Vf
dXBfcHJvY2VzcygpIG9yDQo+IGt0aHJlYWRfY3JlYXRlX29uX2NwdS93YWtlX3VwX3Byb2Nlc3Mo
KSBvcg0KPiBrdGhyZWFkZF9jcmVhdGUva3RocmVhZF9iaW5kL3dha2VfdXBfcHJvY2VzcygpIHRv
IHNpbXBsaWZ5IHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2FpIEh1b3FpbmcgPGNh
aWh1b3FpbmdAYmFpZHUuY29tPg0KPiAtLS0NCj4gdjEtPnYyOg0KPiAJKlJlbW92ZSBjcHVfdG9f
bm9kZSBmcm9tIGt0aHJlYWRfY3JlYXRlX29uX2NwdSBwYXJhbXMuDQo+IAkqVXBkYXRlZCB0aGUg
bWFjcm8gZGVzY3JpcHRpb24gY29tbWVudC4NCj4gdjItPnYzOg0KPiAJKkNvbnZlcnQgdGhpcyBo
ZWxwZXIgbWFjcm8gdG8gc3RhdGljIGlubGluZSBmdW5jdGlvbg0KPiAJKkZpeCB0eXBvIGluIGNo
YW5nZWxvZw0KPiANCj4gdjEgbGluazoNCj4gCWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMTEwMjExMjAxMzUuMzAwMy0yLQ0KPiBjYWlodW9xaW5nQGJhaWR1LmNvbS8NCj4gdjIgbGlu
azoNCj4gCWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTEwMjExMjI3NTguMzA5Mi0y
LQ0KPiBjYWlodW9xaW5nQGJhaWR1LmNvbS8NCj4gDQo+ICBpbmNsdWRlL2xpbnV4L2t0aHJlYWQu
aCB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rdGhyZWFkLmgg
Yi9pbmNsdWRlL2xpbnV4L2t0aHJlYWQuaA0KPiBpbmRleCAzNDZiMGYyNjkxNjEuLmRiNDdhYWU3
YzQ4MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9rdGhyZWFkLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC9rdGhyZWFkLmgNCj4gQEAgLTU2LDYgKzU2LDMxIEBAIGJvb2wga3RocmVhZF9p
c19wZXJfY3B1KHN0cnVjdCB0YXNrX3N0cnVjdCAqayk7DQo+ICAJX19rOwkJCQkJCQkJICAgXA0K
PiAgfSkNCj4gDQo+ICsvKioNCj4gKyAqIGt0aHJlYWRfcnVuX29uX2NwdSAtIGNyZWF0ZSBhbmQg
d2FrZSBhIGNwdSBib3VuZCB0aHJlYWQuDQo+ICsgKiBAdGhyZWFkZm46IHRoZSBmdW5jdGlvbiB0
byBydW4gdW50aWwgc2lnbmFsX3BlbmRpbmcoY3VycmVudCkuDQo+ICsgKiBAZGF0YTogZGF0YSBw
dHIgZm9yIEB0aHJlYWRmbi4NCj4gKyAqIEBjcHU6IFRoZSBjcHUgb24gd2hpY2ggdGhlIHRocmVh
ZCBzaG91bGQgYmUgYm91bmQsDQo+ICsgKiBAbmFtZWZtdDogcHJpbnRmLXN0eWxlIG5hbWUgZm9y
IHRoZSB0aHJlYWQuIEZvcm1hdCBpcyByZXN0cmljdGVkDQo+ICsgKgkgICAgIHRvICJuYW1lLiol
dSIuIENvZGUgZmlsbHMgaW4gY3B1IG51bWJlci4NCj4gKyAqDQo+ICsgKiBEZXNjcmlwdGlvbjog
Q29udmVuaWVudCB3cmFwcGVyIGZvciBrdGhyZWFkX2NyZWF0ZV9vbl9jcHUoKQ0KPiArICogZm9s
bG93ZWQgYnkgd2FrZV91cF9wcm9jZXNzKCkuICBSZXR1cm5zIHRoZSBrdGhyZWFkIG9yDQo+ICsg
KiBFUlJfUFRSKC1FTk9NRU0pLg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCB0YXNr
X3N0cnVjdCAqDQo+ICtrdGhyZWFkX3J1bl9vbl9jcHUoaW50ICgqdGhyZWFkZm4pKHZvaWQgKmRh
dGEpLCB2b2lkICpkYXRhLA0KPiArCQkJdW5zaWduZWQgaW50IGNwdSwgY29uc3QgY2hhciAqbmFt
ZWZtdCkNCj4gK3sNCj4gKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnA7DQo+ICsNCj4gKwlwID0ga3Ro
cmVhZF9jcmVhdGVfb25fY3B1KHRocmVhZGZuLCBkYXRhLCBjcHUsIG5hbWVmbXQpOw0KPiArCWlm
ICghSVNfRVJSKHApKQ0KPiArCQl3YWtlX3VwX3Byb2Nlc3MocCk7DQo+ICsNCj4gKwlyZXR1cm4g
cDsNCj4gK30NCj4gKw0KPiAgdm9pZCBmcmVlX2t0aHJlYWRfc3RydWN0KHN0cnVjdCB0YXNrX3N0
cnVjdCAqayk7DQo+ICB2b2lkIGt0aHJlYWRfYmluZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKmssIHVu
c2lnbmVkIGludCBjcHUpOw0KPiAgdm9pZCBrdGhyZWFkX2JpbmRfbWFzayhzdHJ1Y3QgdGFza19z
dHJ1Y3QgKmssIGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrKTsNCj4gLS0NCj4gMi4yNS4xDQoN
Cg==
