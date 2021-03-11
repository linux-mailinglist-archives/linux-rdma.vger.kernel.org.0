Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E826A337005
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhCKK3v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhCKK30 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Mar 2021 05:29:26 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EE66C061574;
        Thu, 11 Mar 2021 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=BLNMpQ/qYLIXfz8KYOf4S/wVQmoq4ZxSzAKu
        seZ1oDQ=; b=J1Pr0UqxFJwz+cpYSuN8v3867CB9JpJDHtzDede0IyiEW8yV3fjt
        fmnOuFRor0YknrGym+qzz4SXXxoFb1jn0aZpldnM7ERshuyVw0SwMid+gI1wUfka
        0wecE/OFcD0H1ibiLGUSDRH6EXkcsBkm1m7b3z+pnG82AvQS/zMBjD8=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 11 Mar
 2021 18:29:19 +0800 (GMT+08:00)
X-Originating-IP: [202.79.170.108]
Date:   Thu, 11 Mar 2021 18:29:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] infiniband/core: Fix a use after free in
 cm_work_handler
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YEnhO9EXgI8pwVD2@unreal>
References: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
 <YEnhO9EXgI8pwVD2@unreal>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1149b747.c620.17820d56572.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygB3ZGH_8ElgN5oLAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoQBlQhn497xwAOsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SW4gdGhlIGltcGxlbWVudGF0aW9uIG9mIGRlc3RvcnlfY21faWQoKSwgaXQgcmVzdG9yZXMgY21f
aWRfcHJpdiBieSANCiJjbV9pZF9wcml2ID0gY29udGFpbmVyX29mKGNtX2lkLCBzdHJ1Y3QgaXdj
bV9pZF9wcml2YXRlLCBpZCk7Ii4NCg0KQW5kIHRoZSBsYXN0IGxpbmUgb2YgZGVzdG9yeV9jbV9p
ZCgpIGNhbGxzICIodm9pZClpd2NtX2RlcmVmX2lkKGNtX2lkX3ByaXYpOyINCnRvIGZyZWUgdGhl
IGNtX2lkX3ByaXYuDQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujog
Ikxlb24gUm9tYW5vdnNreSIgPGxlb25Aa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIx
LTAzLTExIDE3OjIyOjAzICjmmJ/mnJ/lm5spDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxs
eWwyMDE5QG1haWwudXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogZGxlZGZvcmRAcmVkaGF0LmNvbSwg
amdnQHppZXBlLmNhLCBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIGluZmluaWJhbmQvY29yZTogRml4
IGEgdXNlIGFmdGVyIGZyZWUgaW4gY21fd29ya19oYW5kbGVyDQo+IA0KPiBPbiBXZWQsIE1hciAx
MCwgMjAyMSBhdCAwNjoyMTo1M1BNIC0wODAwLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+IEluIGNt
X3dvcmtfaGFuZGxlciwgaXQgY2FsbHMgZGVzdG9yeV9jbV9pZCgpIHRvIHJlbGVhc2UNCj4gPiB0
aGUgaW5pdGlhbCByZWZlcmVuY2Ugb2YgY21faWRfcHJpdiB0YWtlbiBieSBpd19jcmVhdGVfY21f
aWQoKQ0KPiA+IGFuZCBmcmVlIHRoZSBjbV9pZF9wcml2LiBBZnRlciBkZXN0b3J5X2NtX2lkKCks
IGl3Y21fZGVyZWZfaWQNCj4gPiAoY21faWRfcHJpdikgd2lsbCBiZSBjYWxsZWQgYW5kIGNhdXNl
IGEgdXNlIGFmdGVyIGZyZWUuDQo+ID4NCj4gPiBGaXhlczogNTljNjhhYzMxZTE1YSAoIml3X2Nt
OiBmcmVlIGNtX2lkIHJlc291cmNlcyBvbiB0aGUgbGFzdCBkZXJlZiIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTHYgWXVubG9uZyA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMgfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL2l3Y20uYw0KPiA+IGluZGV4IGRhOGFkYWRmNDc1NS4uY2I2YjRhYzQ1ZTIxIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYw0KPiA+IEBAIC0xMDM1LDggKzEwMzUsMTAgQEAgc3Rh
dGljIHZvaWQgY21fd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqX3dvcmspDQo+ID4N
Cj4gPiAgCQlpZiAoIXRlc3RfYml0KElXQ01fRl9EUk9QX0VWRU5UUywgJmNtX2lkX3ByaXYtPmZs
YWdzKSkgew0KPiA+ICAJCQlyZXQgPSBwcm9jZXNzX2V2ZW50KGNtX2lkX3ByaXYsICZsZXZlbnQp
Ow0KPiA+IC0JCQlpZiAocmV0KQ0KPiA+ICsJCQlpZiAocmV0KSB7DQo+ID4gIAkJCQlkZXN0cm95
X2NtX2lkKCZjbV9pZF9wcml2LT5pZCk7DQo+ID4gKwkJCQlyZXR1cm47DQo+IA0KPiBUaGUgZGVz
dHJveV9jbV9pZCgpIGlzIGNhbGxlZCB0byBmcmVlIC0+aWQgYW5kIG5vdCBjbV9pZF9wcml2LiBU
aGlzICJyZXR1cm4iDQo+IGxlYWtzIGNtX2lkX3ByaXYgbm93IGFuZCB3aGF0ICJhIHVzZSBhZnRl
ciBmcmVlIiBkbyB5b3Ugc2VlPw0KPiANCj4gPiArCQkJfQ0KPiA+ICAJCX0gZWxzZQ0KPiA+ICAJ
CQlwcl9kZWJ1ZygiZHJvcHBpbmcgZXZlbnQgJWRcbiIsIGxldmVudC5ldmVudCk7DQo+ID4gIAkJ
aWYgKGl3Y21fZGVyZWZfaWQoY21faWRfcHJpdikpDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
PiA+DQo=
