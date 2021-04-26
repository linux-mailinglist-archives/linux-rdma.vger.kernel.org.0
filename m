Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FF36AA3E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 03:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDZBTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Apr 2021 21:19:11 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1E5EC061574;
        Sun, 25 Apr 2021 18:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=FxdNj7rDau33YfRFAqQMS4vgkwVHj+KxhN7H
        jlIREtQ=; b=oG9kDSRNIV6SSsL+4SKib23eBVCYSczxT4xlf7e8mMp/nHeEGZ9p
        A/FIXoVdS5uv2HosbqVKgKUIoe9KEpWww++eFx4brE2n+j2UAISA5eX7xFtOTHRL
        N/6Fk7RFBCCf69n3iAtMjvmNSXDAYY2G8yxDai2jhD8AeCZTBNEbLdg=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Mon, 26 Apr
 2021 09:18:25 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Mon, 26 Apr 2021 09:18:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] rdma/siw: Fix a use after free in siw_alloc_mr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YIVzcBMCtvlFov4W@unreal>
References: <20210425132001.3994-1-lyl2019@mail.ustc.edu.cn>
 <YIVzcBMCtvlFov4W@unreal>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <76eac729.5f6b6.1790bc192ab.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygDHzDzhFIZgBEhGAA--.2W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoSBlQhn6PI4wAIs1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkxlb24gUm9tYW5v
dnNreSIgPGxlb25Aa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTA0LTI1IDIxOjQ5
OjM2ICjmmJ/mnJ/ml6UpDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1haWwu
dXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogYm10QHp1cmljaC5pYm0uY29tLCBkbGVkZm9yZEByZWRo
YXQuY29tLCBqZ2dAemllcGUuY2EsIGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnLCBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtQQVRDSF0gcmRtYS9zaXc6IEZp
eCBhIHVzZSBhZnRlciBmcmVlIGluIHNpd19hbGxvY19tcg0KPiANCj4gT24gU3VuLCBBcHIgMjUs
IDIwMjEgYXQgMDY6MjA6MDFBTSAtMDcwMCwgTHYgWXVubG9uZyB3cm90ZToNCj4gPiBPdXIgY29k
ZSBhbmFseXplciByZXBvcnRlZCBhIHVhZi4NCj4gPiANCj4gPiBJbiBzaXdfYWxsb2NfbXIsIGl0
IGNhbGxzIHNpd19tcl9hZGRfbWVtKG1yLC4uKS4gSW4gdGhlIGltcGxlbWVudGF0aW9uDQo+ID4g
b2Ygc2l3X21yX2FkZF9tZW0oKSwgbWVtIGlzIGFzc2lnbmVkIHRvIG1yLT5tZW0gYW5kIHRoZW4g
bWVtIGlzIGZyZWVkDQo+ID4gdmlhIGtmcmVlKG1lbSkgaWYgeGFfYWxsb2NfY3ljbGljKCkgZmFp
bGVkLiBIZXJlLCBtci0+bWVtIHN0aWxsIHBvaW50DQo+ID4gdG8gYSBmcmVlZCBvYmplY3QuIEFm
dGVyLCB0aGUgZXhlY3V0aW9uIGNvbnRpbnVlIHVwIHRvIHRoZSBlcnJfb3V0IGJyYW5jaA0KPiA+
IG9mIHNpd19hbGxvY19tciwgYW5kIHRoZSBmcmVlZCBtci0+bWVtIGlzIHVzZWQgaW4gc2l3X21y
X2Ryb3BfbWVtKG1yKS4NCj4gPiANCj4gPiBGaXhlczogMjI1MTMzNGRjYWM5ZSAoInJkbWEvc2l3
OiBhcHBsaWNhdGlvbiBidWZmZXIgbWFuYWdlbWVudCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTHYg
WXVubG9uZyA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfbWVtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0K
PiA+IGluZGV4IDM0YTkxMGNmMGVkYi4uM2JkZTNiNmZjYTA1IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gPiBAQCAtMTE0LDYgKzExNCw3IEBAIGludCBzaXdf
bXJfYWRkX21lbShzdHJ1Y3Qgc2l3X21yICptciwgc3RydWN0IGliX3BkICpwZCwgdm9pZCAqbWVt
X29iaiwNCj4gPiAgCWlmICh4YV9hbGxvY19jeWNsaWMoJnNkZXYtPm1lbV94YSwgJmlkLCBtZW0s
IGxpbWl0LCAmbmV4dCwNCj4gPiAgCSAgICBHRlBfS0VSTkVMKSA8IDApIHsNCj4gPiAgCQlrZnJl
ZShtZW0pOw0KPiA+ICsJCW1yLT5tZW0gPSBOVUxMOw0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0K
PiA+ICAJfQ0KPiANCj4gUGxlYXNlIG1vdmUgIm1yLT5tZW0gPSBtZW07IiBhc3NpZ25tZW50IHRv
IGJlIGhlcmUsIGFmdGVyIGlmICguLi4pIHt9IHNlY3Rpb24uDQo+IA0KPiBUaGFua3MNCj4gDQo+
ID4gIAkvKiBTZXQgdGhlIFNUYWcgaW5kZXggcGFydCAqLw0KPiA+IC0tIA0KPiA+IDIuMjUuMQ0K
PiA+IA0KPiA+IA0KDQpPaywgaSBoYXZlIG1vZGlmaWVkIG15IHBhdGNoIGFuZCBzZW5kIHRoZSBQ
QVRDSCB2Mi4NCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUuDQo=
