Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008F134482D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhCVOxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhCVOvt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 10:51:49 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FBCBC061574;
        Mon, 22 Mar 2021 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=1m1Ig7L5F1IxqbCmYrqqdwdru3H08AgyOepL
        5bxsUeo=; b=sIXCoIAyJgQj/8boWbVLB7U4TvRPTURWdimPCWC04Vh8x8mkqQ3h
        yHxk3CpNiwdOnxzD7qEcH28yfAX+hC4yLIMCYxHRYyvKGY2tAElHr5wKg5uD5+WI
        2RSznokRrRauiTL0KoTij8Z8NHzKg2ZjwI9Xll0fiyCLq8MnD6hteXg=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Mon, 22 Mar
 2021 22:51:35 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Mon, 22 Mar 2021 22:51:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] infiniband: Fix a use after free in
 isert_connect_request
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <YFipRTHpr8Xqho4V@unreal>
References: <20210322135355.5720-1-lyl2019@mail.ustc.edu.cn>
 <YFipRTHpr8Xqho4V@unreal>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1af3e912.b6e4.1785a6b7802.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygAXHqb3rlhghE4OAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsIBlQhn5UIHAAAsv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkxlb24gUm9tYW5v
dnNreSIgPGxlb25Aa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIxLTAzLTIyIDIyOjI3
OjE3ICjmmJ/mnJ/kuIApDQo+IOaUtuS7tuS6ujogIkx2IFl1bmxvbmciIDxseWwyMDE5QG1haWwu
dXN0Yy5lZHUuY24+DQo+IOaKhOmAgTogc2FnaUBncmltYmVyZy5tZSwgZGxlZGZvcmRAcmVkaGF0
LmNvbSwgamdnQHppZXBlLmNhLCBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZywgdGFyZ2V0LWRl
dmVsQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvp
opg6IFJlOiBbUEFUQ0hdIGluZmluaWJhbmQ6IEZpeCBhIHVzZSBhZnRlciBmcmVlIGluIGlzZXJ0
X2Nvbm5lY3RfcmVxdWVzdA0KPiANCj4gT24gTW9uLCBNYXIgMjIsIDIwMjEgYXQgMDY6NTM6NTVB
TSAtMDcwMCwgTHYgWXVubG9uZyB3cm90ZToNCj4gPiBUaGUgZGV2aWNlIGlzIGdvdCBieSBpc2Vy
dF9kZXZpY2VfZ2V0KCkgd2l0aCByZWZjb3VudCBpcyAxLA0KPiA+IGFuZCBpcyBhc3NpZ25lZCB0
byBpc2VydF9jb25uIGJ5IGlzZXJ0X2Nvbm4tPmRldmljZSA9IGRldmljZS4NCj4gPiBXaGVuIGlz
ZXJ0X2NyZWF0ZV9xcCgpIGZhaWxlZCwgZGV2aWNlIHdpbGwgYmUgZnJlZWQgd2l0aA0KPiA+IGlz
ZXJ0X2RldmljZV9wdXQoKS4NCj4gPiANCj4gPiBMYXRlciwgdGhlIGRldmljZSBpcyB1c2VkIGlu
IGlzZXJ0X2ZyZWVfbG9naW5fYnVmKGlzZXJ0X2Nvbm4pDQo+ID4gYnkgdGhlIGlzZXJ0X2Nvbm4t
PmRldmljZS0+aWJfZGV2aWNlIHN0YXRlbWVudC4gTXkgcGF0Y2gNCj4gPiBleGNoYW5nZXMgdGhl
IGNhbGxlZXMgb3JkZXIgdG8gZnJlZSB0aGUgZGV2aWNlIGxhdGUuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTHYgWXVubG9uZyA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2luZmluaWJhbmQvdWxwL2lzZXJ0L2liX2lzZXJ0LmMgfCA0ICsrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IFRoZSBmaXggbmVlZHMgdG8gYmUgY2hhbmdlIG9mIGlzZXJ0X2ZyZWVfbG9naW5fYnVmKCkgZnJv
bQ0KPiBpc2VydF9mcmVlX2xvZ2luX2J1Zihpc2VydF9jb25uKSB0byBiZSBpc2VydF9mcmVlX2xv
Z2luX2J1Zihpc2VydF9jb25uLCBjbWFfaWQtPmRldmljZSkNCj4gDQo+IFRoYW5rcw0KPiANCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9pc2VydC9pYl9pc2Vy
dC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9pc2VydC9pYl9pc2VydC5jDQo+ID4gaW5kZXgg
NzMwNWVkODk3NmMyLi5kOGE1MzNlMzQ2YjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZp
bmliYW5kL3VscC9pc2VydC9pYl9pc2VydC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3VscC9pc2VydC9pYl9pc2VydC5jDQo+ID4gQEAgLTQ3MywxMCArNDczLDEwIEBAIGlzZXJ0X2Nv
bm5lY3RfcmVxdWVzdChzdHJ1Y3QgcmRtYV9jbV9pZCAqY21hX2lkLCBzdHJ1Y3QgcmRtYV9jbV9l
dmVudCAqZXZlbnQpDQo+ID4gIA0KPiA+ICBvdXRfZGVzdHJveV9xcDoNCj4gPiAgCWlzZXJ0X2Rl
c3Ryb3lfcXAoaXNlcnRfY29ubik7DQo+ID4gLW91dF9jb25uX2RldjoNCj4gPiAtCWlzZXJ0X2Rl
dmljZV9wdXQoZGV2aWNlKTsNCj4gPiAgb3V0X3JzcF9kbWFfbWFwOg0KPiA+ICAJaXNlcnRfZnJl
ZV9sb2dpbl9idWYoaXNlcnRfY29ubik7DQo+ID4gK291dF9jb25uX2RldjoNCj4gPiArCWlzZXJ0
X2RldmljZV9wdXQoZGV2aWNlKTsNCj4gPiAgb3V0Og0KPiA+ICAJa2ZyZWUoaXNlcnRfY29ubik7
DQo+ID4gIAlyZG1hX3JlamVjdChjbWFfaWQsIE5VTEwsIDAsIElCX0NNX1JFSl9DT05TVU1FUl9E
RUZJTkVEKTsNCj4gPiAtLSANCj4gPiAyLjI1LjENCj4gPiANCj4gPiANCg0KSSBzZWUgdGhhdCBm
dW5jdGlvbiBpc2VydF9mcmVlX2xvZ2luX2J1ZihzdHJ1Y3QgaXNlcnRfY29ubiAqaXNlcnRfY29u
bikgaGFzIG9ubHkNCmEgcGFyYW1ldGVyLCAgZG8geW91IG1lYW4gaSBuZWVkIGNoYW5nZSB0aGUg
aW1wbGVtZW50YXRpb24gb2YgaXNlcnRfZnJlZV9sb2dpbl9idWY/DQoNCkknbSBzb3JyeSB0byBz
YXkgdGhhdCBpIGFtIHVuZmFtaWxhciB3aXRoIHRoaXMgbW9kdWxlIGFuZCBhZnJhaWQgb2YgbWFr
aW5nIG1vcmUgbWlzdGFrZXMsDQpiZWNhdXNlIHRoaXMgZnVuY3Rpb24gaXMgYmVpbmcgY2FsbGVk
IGVsc2V3aGVyZSBhcyB3ZWxsLg0KQ291bGQgeW91IGhlbHAgbWUgdG8gZml4IHRoaXMgaXNzdWU/
IE9yIGp1c3QgZml4IGl0IGFuZCB0ZWxsIG1lIHlvdXIgY29tbWl0IG51bWJlcj8NCg==
