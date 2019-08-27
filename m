Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332379EAAE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfH0ORp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 10:17:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35677 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbfH0ORp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 10:17:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-14-7hY9DUGUPHysiFy6Id__jw-1; Tue, 27 Aug 2019 15:17:41 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 27 Aug 2019 15:17:40 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 27 Aug 2019 15:17:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        Joe Perches <joe@perches.com>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Thread-Topic: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Thread-Index: AQHVVrGr4BhhBlFhpEW57H2RBHAQPacPFp7g
Date:   Tue, 27 Aug 2019 14:17:40 +0000
Message-ID: <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com>
References: <20190819100526.13788-1-geert@linux-m68k.org>
 <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
 <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
In-Reply-To: <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 7hY9DUGUPHysiFy6Id__jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDE5IEF1Z3VzdCAyMDE5IDE4OjE1DQou
Li4NCj4gPiBJIHRoaW5rIGEgY2FzdCB0byB1bnNpZ25lZCBsb25nIGlzIHJhdGhlciBtb3JlIGNv
bW1vbi4NCj4gPg0KPiA+IHVpbnRwdHJfdCBpcyB1c2VkIH4xMzAwIHRpbWVzIGluIHRoZSBrZXJu
ZWwuDQo+ID4gSSBiZWxpZXZlIGEgY2FzdCB0byB1bnNpZ25lZCBsb25nIGlzIG11Y2ggbW9yZSBj
b21tb24uDQo+IA0KPiBUaGF0IGlzIHRydWUsIGFzIHVpbnRwdHJfdCB3YXMgaW50cm9kdWNlZCBp
biBDOTkuDQo+IFNpbWlsYXJseSwgdW5zaWduZWQgbG9uZyB3YXMgdXNlZCBiZWZvcmUgc2l6ZV90
IGJlY2FtZSBjb21tb24uDQo+IA0KPiBIb3dldmVyLCBub3dhZGF5cyBzaXplX3QgYW5kIHVpbnRw
dHJfdCBhcmUgcHJlZmVycmVkLg0KDQpJc24ndCB1aW50cHRyX3QgZGVmaW5lZCBieSB0aGUgc2Ft
ZSBzdGFuZGFyZCBhcyB1aW50MzJfdD8NCklmIHRoZSBmb3JtZXIgaXMgYWxsb3dlZCBzbyBzaG91
bGQgdGhlIGxhdHRlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

