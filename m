Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05F036B084
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhDZJ1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 05:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhDZJ1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Apr 2021 05:27:36 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CFCAC061574;
        Mon, 26 Apr 2021 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=3y42CmakslYKka++COtqrzGnC+kuMUtZxgSI
        TRSHDZI=; b=P6lH5zwf9woLnFDupT9HKjCDRmDDCwJxmpbrdkyk5ZHuTci5X5kn
        m4Ygxj868lFCQRKYOPeIK+WncbWAuug6RCugBGWlSK9Wzx1eWDgNJ7PdTy3d/Qu6
        CmYiFIpWlWHaGSCrH9F5L2oyarTrzvXMuCEYlbksrcDy273/aTaoDt8=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Mon, 26 Apr
 2021 17:26:47 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Mon, 26 Apr 2021 17:26:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] rdma/siw: Fix a use after free in siw_alloc_mr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YIZK4gb2qytVpMS0@unreal>
References: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
 <YIZK4gb2qytVpMS0@unreal>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <312624d5.60ea8.1790d80ae44.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygCnrJhXh4Zg4KBJAA--.7W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsDBlQhn6bROQAAsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkxlb24gUm9tYW5v
dnNreSIgPGxlb25Aa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTA0LTI2IDEzOjA4
OjUwICjmmJ/mnJ/kuIApDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1haWwu
dXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogYm10QHp1cmljaC5pYm0uY29tLCBkbGVkZm9yZEByZWRo
YXQuY29tLCBqZ2dAemllcGUuY2EsIGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnLCBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtQQVRDSCB2Ml0gcmRtYS9zaXc6
IEZpeCBhIHVzZSBhZnRlciBmcmVlIGluIHNpd19hbGxvY19tcg0KPiANCj4gT24gU3VuLCBBcHIg
MjUsIDIwMjEgYXQgMDY6MTY6NDdQTSAtMDcwMCwgTHYgWXVubG9uZyB3cm90ZToNCj4gPiBPdXIg
Y29kZSBhbmFseXplciByZXBvcnRlZCBhIHVhZi4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIHNoYXJl
IG1vcmUgZGV0YWlscyBhYm91dCB0aGlzICJjb2RlIGFuYWx5emVyIj8NCj4gDQo+IFRoYW5rcw0K
PiANCj4gPiANCj4gPiBJbiBzaXdfYWxsb2NfbXIsIGl0IGNhbGxzIHNpd19tcl9hZGRfbWVtKG1y
LC4uKS4gSW4gdGhlIGltcGxlbWVudGF0aW9uDQo+ID4gb2Ygc2l3X21yX2FkZF9tZW0oKSwgbWVt
IGlzIGFzc2lnbmVkIHRvIG1yLT5tZW0gYW5kIHRoZW4gbWVtIGlzIGZyZWVkDQo+ID4gdmlhIGtm
cmVlKG1lbSkgaWYgeGFfYWxsb2NfY3ljbGljKCkgZmFpbGVkLiBIZXJlLCBtci0+bWVtIHN0aWxs
IHBvaW50DQo+ID4gdG8gYSBmcmVlZCBvYmplY3QuIEFmdGVyLCB0aGUgZXhlY3V0aW9uIGNvbnRp
bnVlIHVwIHRvIHRoZSBlcnJfb3V0IGJyYW5jaA0KPiA+IG9mIHNpd19hbGxvY19tciwgYW5kIHRo
ZSBmcmVlZCBtci0+bWVtIGlzIHVzZWQgaW4gc2l3X21yX2Ryb3BfbWVtKG1yKS4NCj4gPiANCj4g
PiBNeSBwYXRjaCBtb3ZlcyAibXItPm1lbSA9IG1lbSIgYmVoaW5kIHRoZSBpZiAoeGFfYWxsb2Nf
Y3ljbGljKC4uKTwwKSB7fQ0KPiA+IHNlY3Rpb24sIHRvIGF2b2lkIHRoZSB1YWYuDQo+ID4gDQo+
ID4gRml4ZXM6IDIyNTEzMzRkY2FjOWUgKCJyZG1hL3NpdzogYXBwbGljYXRpb24gYnVmZmVyIG1h
bmFnZW1lbnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEx2IFl1bmxvbmcgPGx5bDIwMTlAbWFpbC51
c3RjLmVkdS5jbj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
bWVtLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfbWVtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiA+
IGluZGV4IDM0YTkxMGNmMGVkYi4uOTZiMzhjZmJiNTEzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gPiBAQCAtMTA2LDggKzEwNiw2IEBAIGludCBzaXdfbXJf
YWRkX21lbShzdHJ1Y3Qgc2l3X21yICptciwgc3RydWN0IGliX3BkICpwZCwgdm9pZCAqbWVtX29i
aiwNCj4gPiAgCW1lbS0+cGVybXMgPSByaWdodHMgJiBJV0FSUF9BQ0NFU1NfTUFTSzsNCj4gPiAg
CWtyZWZfaW5pdCgmbWVtLT5yZWYpOw0KPiA+ICANCj4gPiAtCW1yLT5tZW0gPSBtZW07DQo+ID4g
LQ0KPiA+ICAJZ2V0X3JhbmRvbV9ieXRlcygmbmV4dCwgNCk7DQo+ID4gIAluZXh0ICY9IDB4MDBm
ZmZmZmY7DQo+ID4gIA0KPiA+IEBAIC0xMTYsNiArMTE0LDggQEAgaW50IHNpd19tcl9hZGRfbWVt
KHN0cnVjdCBzaXdfbXIgKm1yLCBzdHJ1Y3QgaWJfcGQgKnBkLCB2b2lkICptZW1fb2JqLA0KPiA+
ICAJCWtmcmVlKG1lbSk7DQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gIAl9DQo+ID4gKw0K
PiA+ICsJbXItPm1lbSA9IG1lbTsNCj4gPiAgCS8qIFNldCB0aGUgU1RhZyBpbmRleCBwYXJ0ICov
DQo+ID4gIAltZW0tPnN0YWcgPSBpZCA8PCA4Ow0KPiA+ICAJbXItPmJhc2VfbXIubGtleSA9IG1y
LT5iYXNlX21yLnJrZXkgPSBtZW0tPnN0YWc7DQo+ID4gLS0gDQo+ID4gMi4yNS4xDQo+ID4gDQo+
ID4gDQoNClllcywgaSB3b3VsZCBsaWtlIHRvIHNoYXJlIHNvbWUgZGV0YWlscyBhYm91dCBpdCBh
bHRob3VnaCBpdCBzdGlsbCBoYXMgbm8gbmFtZS4NCldlIGRlc2lnbmVkIHRoaXMgYW5hbHp5ZXIg
YnkgYWRvcHQgYSBkZWVwIGxlYXJuaW5nIG1vZGVsIHRvIHJlY29nbml6ZSB0aGUNCm1lbW9yeSBh
bGxvY2F0aW9uIGFuZCBkZWFsbG9jYXRpb24gaW4ga2VybmVsIGZpcnN0LiBBbmQgdGhlbiB1c2Ug
Q2xhbmcgU3RhdGljDQpBbmFseXplciB0byBzY2FuIHRoZSBrZXJuZWwgY29kZS4=
