Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C4505BFC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbiDRPyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 11:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbiDRPyK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 11:54:10 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46D952E6A4;
        Mon, 18 Apr 2022 08:41:05 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 18 Apr 2022 23:41:00
 +0800 (GMT+08:00)
X-Originating-IP: [10.190.65.57]
Date:   Mon, 18 Apr 2022 23:41:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: RE: [PATCH V5] drivers: infiniband: hw: Fix deadlock in
 irdma_cleanup_cm_core()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <MWHPR11MB0029A6F789272ED3AB28F0E7E9F39@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20220417131414.98144-1-duoming@zju.edu.cn>
 <MWHPR11MB0029A6F789272ED3AB28F0E7E9F39@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7e8f030a.7535.1803d559499.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgB3FMSMhl1i9TYAAg--.24505W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgUEAVZdtZQI8gADsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8sCgpPbiBNb24sIDE4IEFwciAyMDIyIDE0OjU3OjA2ICswMDAwIFNhbGVlbSwgU2hpcmF6
IHdyb3RlOgoKPiA+IFRoZXJlIGlzIGEgZGVhZGxvY2sgaW4gaXJkbWFfY2xlYW51cF9jbV9jb3Jl
KCksIHdoaWNoIGlzIHNob3duCj4gPiBiZWxvdzoKPiA+IAo+ID4gICAgKFRocmVhZCAxKSAgICAg
ICAgICAgICAgfCAgICAgIChUaHJlYWQgMikKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgaXJkbWFfc2NoZWR1bGVfY21fdGltZXIoKQo+ID4gaXJkbWFfY2xlYW51cF9jbV9jb3JlKCkg
ICAgfCAgYWRkX3RpbWVyKCkKPiA+ICBzcGluX2xvY2tfaXJxc2F2ZSgpIC8vKDEpIHwgICh3YWl0
IGEgdGltZSkKPiA+ICAuLi4gICAgICAgICAgICAgICAgICAgICAgIHwgaXJkbWFfY21fdGltZXJf
dGljaygpCj4gPiAgZGVsX3RpbWVyX3N5bmMoKSAgICAgICAgICB8ICBzcGluX2xvY2tfaXJxc2F2
ZSgpIC8vKDIpCj4gPiAgKHdhaXQgdGltZXIgdG8gc3RvcCkgICAgICB8ICAuLi4KPiA+IAo+ID4g
V2UgaG9sZCBjbV9jb3JlLT5odF9sb2NrIGluIHBvc2l0aW9uICgxKSBvZiB0aHJlYWQgMSBhbmQg
dXNlIGRlbF90aW1lcl9zeW5jKCkKPiA+IHRvIHdhaXQgdGltZXIgdG8gc3RvcCwgYnV0IHRpbWVy
IGhhbmRsZXIgYWxzbyBuZWVkIGNtX2NvcmUtPmh0X2xvY2sgaW4gcG9zaXRpb24gKDIpCj4gPiBv
ZiB0aHJlYWQgMi4KPiA+IEFzIGEgcmVzdWx0LCBpcmRtYV9jbGVhbnVwX2NtX2NvcmUoKSB3aWxs
IGJsb2NrIGZvcmV2ZXIuCj4gPiAKPiA+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgY2hlY2sgb2Yg
dGltZXJfcGVuZGluZygpIGluIGlyZG1hX2NsZWFudXBfY21fY29yZSgpLAo+ID4gYmVjYXVzZSB0
aGUgZGVsX3RpbWVyX3N5bmMoKSBmdW5jdGlvbiB3aWxsIGp1c3QgcmV0dXJuIGRpcmVjdGx5IGlm
IHRoZXJlIGlzbid0IGEKPiA+IHBlbmRpbmcgdGltZXIuIEFzIGEgcmVzdWx0LCB0aGUgbG9jayBp
cyByZWR1bmRhbnQsIGJlY2F1c2UgdGhlcmUgaXMgbm8gcmVzb3VyY2UgaXQKPiA+IGNvdWxkIHBy
b3RlY3QuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IER1b21pbmcgWmhvdSA8ZHVvbWluZ0B6anUu
ZWR1LmNuPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIFY1Ogo+ID4gICAtIFJlbW92ZSBtb2RfdGlt
ZXIoKSBpbiBpcmRtYV9zY2hlZHVsZV9jbV90aW1lciBhbmQgaXJkbWFfY21fdGltZXJfdGljay4K
PiA+IAo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9jbS5jIHwgNSArLS0tLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9jbS5jIGIvZHJpdmVycy9p
bmZpbmliYW5kL2h3L2lyZG1hL2NtLmMKPiA+IGluZGV4IGRlZGIzYjdlZGQ4Li40YjZiMTA2NWY4
NSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9jbS5jCj4gPiAr
KysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY20uYwo+ID4gQEAgLTMyNTEsMTAgKzMy
NTEsNyBAQCB2b2lkIGlyZG1hX2NsZWFudXBfY21fY29yZShzdHJ1Y3QKPiA+IGlyZG1hX2NtX2Nv
cmUgKmNtX2NvcmUpCj4gPiAgCWlmICghY21fY29yZSkKPiA+ICAJCXJldHVybjsKPiA+IAo+ID4g
LQlzcGluX2xvY2tfaXJxc2F2ZSgmY21fY29yZS0+aHRfbG9jaywgZmxhZ3MpOwo+ID4gLQlpZiAo
dGltZXJfcGVuZGluZygmY21fY29yZS0+dGNwX3RpbWVyKSkKPiA+IC0JCWRlbF90aW1lcl9zeW5j
KCZjbV9jb3JlLT50Y3BfdGltZXIpOwo+ID4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjbV9j
b3JlLT5odF9sb2NrLCBmbGFncyk7Cj4gPiArCWRlbF90aW1lcl9zeW5jKCZjbV9jb3JlLT50Y3Bf
dGltZXIpOwo+ID4gCj4gPiAgCWRlc3Ryb3lfd29ya3F1ZXVlKGNtX2NvcmUtPmV2ZW50X3dxKTsK
PiA+ICAJY21fY29yZS0+ZGV2LT53c19yZXNldCgmY21fY29yZS0+aXdkZXYtPnZzaSk7Cj4gPiAt
LQo+IAo+IEkgYW0gbm90IHN1cmUgdGhlIGRlYWRsb2NrIGlzIHBvc3NpYmxlIHByYWN0aWNhbGx5
IHNpbmNlIGFsbCBDTSBub2RlcyBzaG91bGQgYmUgY3VsbGVkIGJ5IHRoZSB0aW1lIHdlIGdldCB0
byBpcmRtYV9jbGVhbnVwX2NtX2NvcmUuCgpJIHRoaW5rIHRoZSBkZWFkbG9jayBpcyBwb3NzaWJs
ZSwgYmVjYXVzZSB0aGUgdGltZXIgaXMgYSBkZWxheSBtZWNoYW5pc20gdGhhdCBjb3VsZCBleGVj
dXRlIGF0IGFueSB0aW1lLCBhbHRob3VnaCBhbGwgQ00gbm9kZXMgYXJlIGN1bGxlZC4KCj4gSG93
ZXZlciwgdGltZXJfcGVuZGluZyBjaGVjayBhbmQgbG9ja3MgYXJlIHJlZHVuZGFudCBhbmQgc2hv
dWxkIGJlIHJlbW92ZWQuCj4gCj4gVGhlIHN1YmplY3QgbGluZSBmb3IgcGF0Y2hlcyB0byBvdXIg
ZHJpdmVyIGFyZSB0eXBpY2FsbHkgcHJlZml4ZWQgd2l0aCAiUkRNQS9pcmRtYTogIgoKSSBzZW50
ICJbUEFUQ0ggVjZdIFJETUEvaXJkbWE6IEZpeCBkZWFkbG9jayBpbiBpcmRtYV9jbGVhbnVwX2Nt
X2NvcmUoKSIganVzdCBub3cuCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=
