Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D521C3371F1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhCKMDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 07:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhCKMDo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Mar 2021 07:03:44 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A58DC061574;
        Thu, 11 Mar 2021 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=MJ6Q5FhH+niYRr9MZksYZGfNJSjeJDZSgTze
        IWL6YNg=; b=ri4dkvhbHjfVFDabwO7vc2oameppvWI1s4YqNs21HrdK9bjqo5Ib
        H/2ZhhJDTTFxfDpfO7+okTY/wvMaC8WiLjJ1LQge/Sj53XzWFYNEVz4TRHGnCMiV
        lfGo4FLGpHIgTUZaBKQIckcElDJibZsmFBQSZJm6doIL0H8v2JIx4j8=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 11 Mar
 2021 20:03:23 +0800 (GMT+08:00)
X-Originating-IP: [202.79.170.108]
Date:   Thu, 11 Mar 2021 20:03:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] infiniband/core: Fix a use after free in
 cm_work_handler
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YEn5XxgB1LqQ0PSE@unreal>
References: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
 <YEnhO9EXgI8pwVD2@unreal>
 <1149b747.c620.17820d56572.Coremail.lyl2019@mail.ustc.edu.cn>
 <YEn5XxgB1LqQ0PSE@unreal>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <f748b4c.c8d4.178212b8650.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygB3ZGELB0pg9R8MAA--.4W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoRBlQhn5AKUgABs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkxlb24gUm9tYW5v
dnNreSIgPGxlb25Aa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTExIDE5OjA1
OjAzICjmmJ/mnJ/lm5spDQo+IOaUtuS7tuS6ujogbHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuDQo+
IOaKhOmAgTogZGxlZGZvcmRAcmVkaGF0LmNvbSwgamdnQHppZXBlLmNhLCBsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJl
OiBSZTogW1BBVENIXSBpbmZpbmliYW5kL2NvcmU6IEZpeCBhIHVzZSBhZnRlciBmcmVlIGluIGNt
X3dvcmtfaGFuZGxlcg0KPiANCj4gT24gVGh1LCBNYXIgMTEsIDIwMjEgYXQgMDY6Mjk6MTlQTSAr
MDgwMCwgbHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuIHdyb3RlOg0KPiA+IEluIHRoZSBpbXBsZW1l
bnRhdGlvbiBvZiBkZXN0b3J5X2NtX2lkKCksIGl0IHJlc3RvcmVzIGNtX2lkX3ByaXYgYnkNCj4g
PiAiY21faWRfcHJpdiA9IGNvbnRhaW5lcl9vZihjbV9pZCwgc3RydWN0IGl3Y21faWRfcHJpdmF0
ZSwgaWQpOyIuDQo+ID4NCj4gPiBBbmQgdGhlIGxhc3QgbGluZSBvZiBkZXN0b3J5X2NtX2lkKCkg
Y2FsbHMgIih2b2lkKWl3Y21fZGVyZWZfaWQoY21faWRfcHJpdik7Ig0KPiA+IHRvIGZyZWUgdGhl
IGNtX2lkX3ByaXYuDQo+IA0KPiBJdCBpcyBub3QgZW5vdWdoIHRvIHNlZSBkb3VibGUgY2FsbCB0
byBpd2NtX2RlcmVmX2lkKCkgYmVjYXVzZSBpdCBpcw0KPiBwcm90ZWN0ZWQgd2l0aCByZWZjb3Vu
dCB0byBjbGFpbSB1c2UtYWZ0ZXItZnJlZS4gRGlkIHlvdSBoaXQgdGhlIEJVR19PTigpDQo+IGZv
ciB0aGUgc2Vjb25kIGNhbGwgdG8gaXdjbV9kZXJlZl9pZCgpPw0KPiANCj4gQW5kIHBsZWFzZSBk
b24ndCBkbyB0b3AtcG9zdGluZy4NCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+DQo+ID4gPiAt
LS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6ICJMZW9uIFJvbWFub3Zza3ki
IDxsZW9uQGtlcm5lbC5vcmc+DQo+ID4gPiDlj5HpgIHml7bpl7Q6IDIwMjEtMDMtMTEgMTc6MjI6
MDMgKOaYn+acn+WbmykNCj4gPiA+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1h
aWwudXN0Yy5lZHUuY24+DQo+ID4gPiDmioTpgIE6IGRsZWRmb3JkQHJlZGhhdC5jb20sIGpnZ0B6
aWVwZS5jYSwgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiA+IOS4u+mimDogUmU6IFtQQVRDSF0gaW5maW5pYmFuZC9jb3JlOiBGaXgg
YSB1c2UgYWZ0ZXIgZnJlZSBpbiBjbV93b3JrX2hhbmRsZXINCj4gPiA+DQo+ID4gPiBPbiBXZWQs
IE1hciAxMCwgMjAyMSBhdCAwNjoyMTo1M1BNIC0wODAwLCBMdiBZdW5sb25nIHdyb3RlOg0KPiA+
ID4gPiBJbiBjbV93b3JrX2hhbmRsZXIsIGl0IGNhbGxzIGRlc3RvcnlfY21faWQoKSB0byByZWxl
YXNlDQo+ID4gPiA+IHRoZSBpbml0aWFsIHJlZmVyZW5jZSBvZiBjbV9pZF9wcml2IHRha2VuIGJ5
IGl3X2NyZWF0ZV9jbV9pZCgpDQo+ID4gPiA+IGFuZCBmcmVlIHRoZSBjbV9pZF9wcml2LiBBZnRl
ciBkZXN0b3J5X2NtX2lkKCksIGl3Y21fZGVyZWZfaWQNCj4gPiA+ID4gKGNtX2lkX3ByaXYpIHdp
bGwgYmUgY2FsbGVkIGFuZCBjYXVzZSBhIHVzZSBhZnRlciBmcmVlLg0KPiA+ID4gPg0KPiA+ID4g
PiBGaXhlczogNTljNjhhYzMxZTE1YSAoIml3X2NtOiBmcmVlIGNtX2lkIHJlc291cmNlcyBvbiB0
aGUgbGFzdCBkZXJlZiIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEx2IFl1bmxvbmcgPGx5bDIw
MTlAbWFpbC51c3RjLmVkdS5jbj4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGRyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2l3Y20uYyB8IDQgKysrLQ0KPiA+ID4gPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9p
d2NtLmMNCj4gPiA+ID4gaW5kZXggZGE4YWRhZGY0NzU1Li5jYjZiNGFjNDVlMjEgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYw0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmMNCj4gPiA+ID4gQEAgLTEwMzUsOCArMTAz
NSwxMCBAQCBzdGF0aWMgdm9pZCBjbV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICpf
d29yaykNCj4gPiA+ID4NCj4gPiA+ID4gCQlpZiAoIXRlc3RfYml0KElXQ01fRl9EUk9QX0VWRU5U
UywgJmNtX2lkX3ByaXYtPmZsYWdzKSkgew0KPiA+ID4gPiAJCQlyZXQgPSBwcm9jZXNzX2V2ZW50
KGNtX2lkX3ByaXYsICZsZXZlbnQpOw0KPiA+ID4gPiAtCQkJaWYgKHJldCkNCj4gPiA+ID4gKwkJ
CWlmIChyZXQpIHsNCj4gPiA+ID4gCQkJCWRlc3Ryb3lfY21faWQoJmNtX2lkX3ByaXYtPmlkKTsN
Cj4gPiA+ID4gKwkJCQlyZXR1cm47DQo+ID4gPg0KPiA+ID4gVGhlIGRlc3Ryb3lfY21faWQoKSBp
cyBjYWxsZWQgdG8gZnJlZSAtPmlkIGFuZCBub3QgY21faWRfcHJpdi4gVGhpcyAicmV0dXJuIg0K
PiA+ID4gbGVha3MgY21faWRfcHJpdiBub3cgYW5kIHdoYXQgImEgdXNlIGFmdGVyIGZyZWUiIGRv
IHlvdSBzZWU/DQo+ID4gPg0KPiA+ID4gPiArCQkJfQ0KPiA+ID4gPiAJCX0gZWxzZQ0KPiA+ID4g
PiAJCQlwcl9kZWJ1ZygiZHJvcHBpbmcgZXZlbnQgJWRcbiIsIGxldmVudC5ldmVudCk7DQo+ID4g
PiA+IAkJaWYgKGl3Y21fZGVyZWZfaWQoY21faWRfcHJpdikpDQo+ID4gPiA+IC0tDQo+ID4gPiA+
IDIuMjUuMQ0KPiA+ID4gPg0KPiA+ID4gPg0KDQpJJ20gbm90IGZhbWlsaWFyIHdpdGggZGVidWcg
dGhlIGtlcm5lbCwgc29ycnkuVGhpcyBwcm9ibGVtIHdhcw0KIHJlcG9ydGVkIGJ5IG15IGNvZGUg
YW5hbHl6ZXIgYW5kIHJldmlld2VkIGJ5IG15c2VsZi4NCg0KQnV0IGkgdGhpbmsgYXMgbG9uZyBh
cyBkZXN0cm95X2NtX2lkKCkgaXMgY2FsbGVkLCBpd2NtX2RlcmVmX2lkKCkgd2lsbCBiZSBjYWxs
ZWQgdHdpY2UuDQpUaGVuICJCVUdfT04oYXRvbWljX3JlYWQoJmNtX2lkX3ByaXYtPnJlZmNvdW50
KT09MCk7IiBpbiBpd2NtX2RlcmVmX2lkKCkgd2lsbCBiZSB0cmlnZ2VyZWQuDQoNCklzIGl0IG5v
dCBhIHRydWUgcHJvYmxlbT8NCg0KDQoNCg0K
