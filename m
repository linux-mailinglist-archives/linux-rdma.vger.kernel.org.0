Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227F4363A1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJUOBd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 10:01:33 -0400
Received: from mx22.baidu.com ([220.181.50.185]:34436 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230072AbhJUOBd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 10:01:33 -0400
Received: from BC-Mail-Ex25.internal.baidu.com (unknown [172.31.51.19])
        by Forcepoint Email with ESMTPS id E40531B02753C10474E3;
        Thu, 21 Oct 2021 21:58:55 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex25.internal.baidu.com (172.31.51.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 21:58:55 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Thu, 21 Oct 2021 21:58:55 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH 0/6] kthread: Add the helper macro kthread_run_on_cpu()
Thread-Topic: [PATCH 0/6] kthread: Add the helper macro kthread_run_on_cpu()
Thread-Index: AQHXxnNpfugAUqUbeEyqP9NX9k+uv6vdeeGQ
Date:   Thu, 21 Oct 2021 13:58:55 +0000
Message-ID: <e886ea99c2d44932a53f597191a6d54e@baidu.com>
References: <20211021120135.3003-1-caihuoqing@baidu.com>
In-Reply-To: <20211021120135.3003-1-caihuoqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.190.132]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGksIGZvbGtzDQpWMiBpcyBoZXJlDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEx
MDIxMTIyNzU4LjMwOTItMi1jYWlodW9xaW5nQGJhaWR1LmNvbS8NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDYWksSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+
DQo+IFNlbnQ6IDIwMjHE6jEw1MIyMcjVIDIwOjAxDQo+IFRvOiBDYWksSHVvcWluZw0KPiBDYzog
QmVybmFyZCBNZXR6bGVyOyBEb3VnIExlZGZvcmQ7IEphc29uIEd1bnRob3JwZTsgRGF2aWRsb2hy
IEJ1ZXNvOyBQYXVsDQo+IEUuIE1jS2VubmV5OyBKb3NoIFRyaXBsZXR0OyBTdGV2ZW4gUm9zdGVk
dDsgTWF0aGlldSBEZXNub3llcnM7IExhaQ0KPiBKaWFuZ3NoYW47IEpvZWwgRmVybmFuZGVzOyBJ
bmdvIE1vbG5hcjsgRGFuaWVsIEJyaXN0b3QgZGUgT2xpdmVpcmE7IGxpbnV4LQ0KPiByZG1hQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcmN1QHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMC82XSBrdGhyZWFkOiBBZGQgdGhlIGhlbHBlciBt
YWNybyBrdGhyZWFkX3J1bl9vbl9jcHUoKQ0KPiANCj4gdGhlIGhlbHBlciBtYWNybyBrdGhyZWFk
X3J1bl9vbl9jcHUoKSBpbmN1bGRlcw0KPiBrdGhyZWFkX2NyZWF0ZV9vbl9jcHUvd2FrZV91cF9w
cm9jZXNzKCkuDQo+IEluIHNvbWUgY2FzZXMsIHVzZSBrdGhyZWFkX3J1bl9vbl9jcHUoKSBkaXJl
Y3RseSBpbnN0ZWFkIG9mDQo+IGt0aHJlYWRfY3JlYXRlX29uX25vZGUva3RocmVhZF9iaW5kL3dh
a2VfdXBfcHJvY2VzcygpIG9yDQo+IGt0aHJlYWRfY3JlYXRlX29uX2NwdS93YWtlX3VwX3Byb2Nl
c3MoKSBvcg0KPiBrdGhyZWFkZF9jcmVhdGUva3RocmVhZF9iaW5kL3dha2VfdXBfcHJvY2Vzcygp
IHRvIHNpbXBsaWZ5IHRoZSBjb2RlLg0KPiANCj4gQ2FpIEh1b3FpbmcgKDYpOg0KPiAgIGt0aHJl
YWQ6IEFkZCB0aGUgaGVscGVyIG1hY3JvIGt0aHJlYWRfcnVuX29uX2NwdSgpDQo+ICAgUkRNQS9z
aXc6IE1ha2UgdXNlIG9mIHRoZSBoZWxwZXIgbWFjcm8ga3RocmVhZF9ydW5fb25fY3B1KCkNCj4g
ICByaW5nLWJ1ZmZlcjogTWFrZSB1c2Ugb2YgdGhlIGhlbHBlciBtYWNybyBrdGhyZWFkX3J1bl9v
bl9jcHUoKQ0KPiAgIHJjdXRvcnR1cmU6IE1ha2UgdXNlIG9mIHRoZSBoZWxwZXIgbWFjcm8ga3Ro
cmVhZF9ydW5fb25fY3B1KCkNCj4gICB0cmFjZS9vc25vaXNlOiBNYWtlIHVzZSBvZiB0aGUgaGVs
cGVyIG1hY3JvIGt0aHJlYWRfcnVuX29uX2NwdSgpDQo+ICAgdHJhY2UvaHdsYXQ6IE1ha2UgdXNl
IG9mIHRoZSBoZWxwZXIgbWFjcm8ga3RocmVhZF9ydW5fb25fY3B1KCkNCj4gDQo+ICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMgfCAgNyArKystLS0tDQo+ICBpbmNsdWRlL2xp
bnV4L2t0aHJlYWQuaCAgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+
ICBrZXJuZWwvcmN1L3JjdXRvcnR1cmUuYyAgICAgICAgICAgICAgfCAgNyArKy0tLS0tDQo+ICBr
ZXJuZWwvdHJhY2UvcmluZ19idWZmZXIuYyAgICAgICAgICAgfCAgNyArKy0tLS0tDQo+ICBrZXJu
ZWwvdHJhY2UvdHJhY2VfaHdsYXQuYyAgICAgICAgICAgfCAgNiArLS0tLS0NCj4gIGtlcm5lbC90
cmFjZS90cmFjZV9vc25vaXNlLmMgICAgICAgICB8ICAzICstLQ0KPiAgNiBmaWxlcyBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMjUuMQ0K
DQo=
