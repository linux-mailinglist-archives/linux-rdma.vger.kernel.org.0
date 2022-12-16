Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721B64E965
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 11:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiLPKXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 05:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiLPKXJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 05:23:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2550D76
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 02:23:07 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-P4IjutzAPZ-CU4wgQYv4rA-1; Fri, 16 Dec 2022 10:23:05 +0000
X-MC-Unique: P4IjutzAPZ-CU4wgQYv4rA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Dec
 2022 10:23:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 16 Dec 2022 10:23:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bernard Metzler' <BMT@zurich.ibm.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Topic: Re: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Index: AQHZEKfEZmHYt+KmU0GxS8VCrAg8Pq5wTljw
Date:   Fri, 16 Dec 2022 10:23:02 +0000
Message-ID: <fa8b6397c285413c83194e471056feea@AcuMS.aculab.com>
References: <20221215170347.2612403-1-arnd@kernel.org>
 <1bba42a31e0a487bbbf67955b674583e@AcuMS.aculab.com>
 <CACRpkdY_050MZ3Gun_bOZiTk=q+7xUkiP0CO7daLEiX2wRi_yg@mail.gmail.com>
 <SA0PR15MB3919F3295251A173D0E14C3F99E69@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB3919F3295251A173D0E14C3F99E69@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RnJvbTogQmVybmFyZCBNZXR6bGVyDQo+IFNlbnQ6IDE2IERlY2VtYmVyIDIwMjIgMTA6MDENCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBMaW51cyBXYWxsZWlq
IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+ID4gU2VudDogRnJpZGF5LCAxNiBEZWNlbWJl
ciAyMDIyIDA4OjQ3DQo+ID4gVG86IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5j
b20+DQo+ID4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz47IEJlcm5hcmQgTWV0
emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsNCj4gPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgQXJuZA0KPiA+IEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBb
UEFUQ0hdIFJETUEvc2l3OiBmaXggcG9pbnRlciBjYXN0IHdhcm5pbmcNCj4gPg0KPiA+IE9uIFRo
dSwgRGVjIDE1LCAyMDIyIGF0IDExOjIwIFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20+DQo+ID4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IEFybmQgQmVyZ21hbm4NCj4g
PiA+ID4gU2VudDogMTUgRGVjZW1iZXIgMjAyMiAxNzowNA0KPiA+ID4gPg0KPiA+ID4gPiBGcm9t
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgcHJl
dmlvdXMgYnVpbGQgZml4IGxlZnQgYSByZW1haW5pbmcgaXNzdWUgaW4gY29uZmlndXJhdGlvbnMN
Cj4gPiA+ID4gd2l0aCA2NC1iaXQgZG1hX2FkZHJfdCBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlczoN
Cj4gPiA+ID4NCj4gPiA+ID4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzog
SW4gZnVuY3Rpb24gJ3Npd19nZXRfcGJscGFnZSc6DQo+ID4gPiA+IGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3FwX3R4LmM6MzI6Mzc6IGVycm9yOiBjYXN0IHRvIHBvaW50ZXINCj4gPiBm
cm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy0NCj4gPiA+ID4gV2Vycm9yPWludC10by1w
b2ludGVyLWNhc3RdDQo+ID4gPiA+ICAgIDMyIHwgICAgICAgICAgICAgICAgIHJldHVybiB2aXJ0
X3RvX3BhZ2UoKHZvaWQgKilwYWRkcik7DQo+ID4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXg0KPiA+ID4gPg0KPiA+ID4gPiBVc2UgdGhlIHNhbWUgZG91
YmxlIGNhc3QgaGVyZSB0aGF0IHRoZSBkcml2ZXIgdXNlcyBlbHNld2hlcmUNCj4gPiA+ID4gdG8g
Y29udmVydCBiZXR3ZWVuIGRtYV9hZGRyX3QgYW5kIHZvaWQqLg0KPiA+ID4gPg0KPiA+ID4gPiBJ
dCB0b29rIG1lIGEgd2hpbGUgdG8gZmlndXJlIG91dCB3aHkgdGhpcyBkcml2ZXIgZG9lcyBpdA0K
PiA+ID4gPiBsaWtlIHRoaXMsIGFzIHRoZXJlIGlzIG5vIGhhcmR3YXJlIGFjY2VzcyBhbmQgaXQg
anVzdCBzdG9yZXMNCj4gPiA+ID4ga2VybmVsIHBvaW50ZXJzIGluIHBsYWNlIG9mIGRldmljZSBh
ZGRyZXNzZXMgd2hlbiBjb21tdW5pY2F0aW5nDQo+ID4gPiA+IHdpdGggdGhlIHJkbWEgY29yZSBh
bmQgd2l0aCB1c2VyIHNwYWNlLg0KPiA+ID4NCj4gPiA+IEkgaG9wZSB0aGF0IGRvZXNuJ3QgbWVh
biBpdCBpcyByZWx5aW5nIG9uIHVzZXIgc3BhY2Ugb25seQ0KPiA+ID4gZ2l2aW5nIGl0IGJhY2sg
dmFsaWQgdmFsdWVzPw0KPiA+DQo+ID4gSXQgbG9va3MgdG8gbWUgbGlrZSB0aGlzIGRyaXZlciB0
b3RhbGx5IHRydXN0cyB1c2Vyc3BhY2UuDQo+ID4NCj4gDQo+IFNoYW1lIG9uIG1lLiBZZXMsIHNv
bWVob3csIGFuIGFjY2Vzc19vaygodm9pZCBfX3VzZXIgKilzdGFydCwgbGVuKQ0KPiBpcyBtaXNz
aW5nISBMZXQgbWUgZml4IHRoYXQgd2hlbiBJIGFtIGJhY2sgYXQgbXkgZGVzay4gU2VlbXMgaXQg
bmVlZHMNCj4gaW1tZWRpYXRlIGFjdGlvbi4NCg0KVGhhdCB3YXNuJ3QgdGhlIHNvcnQgb2YgaXNz
dWUgSSB3YXMgdGhpbmtpbmcgYWJvdXQuDQpJIHdhcyB3b3JyaWVkIHRoYXQgaXQgd2FzIHB1dHRp
bmcgdGhlIGFkZHJlc3NlcyBvZiBrZXJuZWwgbWVtb3J5DQppbnRvIGJ1ZmZlcnMgd3JpdHRlbiB0
byB1c2Vyc3BhY2UgYW5kIHRoZW4gbGF0ZXIgcmVhZGluZyB0aGUNCmFkZHJlc3NlcyBiYWNrIGZy
b20gdXNlcnNwYWNlIGFuZCBhY2Nlc3NpbmcgdGhlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

