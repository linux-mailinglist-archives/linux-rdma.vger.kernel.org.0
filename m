Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6416338360
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCLB5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 20:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhCLB5h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Mar 2021 20:57:37 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 314B1C061574;
        Thu, 11 Mar 2021 17:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=mu5caJTVFIl7UEHXdabLTzS0G5R3LPGJH9xr
        lBMv9Zw=; b=UntVm0WU75vzpUbE66exJ0URf5jgV8WCYC616kqK//xfXxJfBAeU
        b0VuYuPWd7HrPhGeW9l2r8iXqk02pCzACnJRV2K8ut9acAjvuiW0jIwzGAUnJY6k
        rpP/jtss5B4tqWzsDcKoR4VoZvYfot0+QMy+HpoF7RKfYLcbhJjiYVc=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Fri, 12 Mar
 2021 09:57:12 +0800 (GMT+08:00)
X-Originating-IP: [211.86.152.244]
Date:   Fri, 12 Mar 2021 09:57:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "Jason Gunthorpe" <jgg@nvidia.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH] infiniband/i40iw: Fix a use after free in
 i40iw_cm_event_handler
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <1fc386d78c044d3da723fe38446edb75@intel.com>
References: <20210311031414.5011-1-lyl2019@mail.ustc.edu.cn>
 <20210311182114.GA2733907@nvidia.com>
 <1fc386d78c044d3da723fe38446edb75@intel.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <43271428.d966.1782426e7a3.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygDn7T14ykpgnE0QAA--.3W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoSBlQhn5BFyAAAso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlNhbGVlbSwgU2hp
cmF6IiA8c2hpcmF6LnNhbGVlbUBpbnRlbC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyMS0wMy0x
MiAwOToxMzozOSAo5pif5pyf5LqUKQ0KPiDmlLbku7bkuro6ICJKYXNvbiBHdW50aG9ycGUiIDxq
Z2dAbnZpZGlhLmNvbT4sICJMdiBZdW5sb25nIiA8bHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuPg0K
PiDmioTpgIE6ICJMYXRpZiwgRmFpc2FsIiA8ZmFpc2FsLmxhdGlmQGludGVsLmNvbT4sICJkbGVk
Zm9yZEByZWRoYXQuY29tIiA8ZGxlZGZvcmRAcmVkaGF0LmNvbT4sICJsaW51eC1yZG1hQHZnZXIu
a2VybmVsLm9yZyIgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPiwgImxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmciIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiDkuLvpopg6
IFJFOiBbUEFUQ0hdIGluZmluaWJhbmQvaTQwaXc6IEZpeCBhIHVzZSBhZnRlciBmcmVlIGluIGk0
MGl3X2NtX2V2ZW50X2hhbmRsZXINCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW5maW5p
YmFuZC9pNDBpdzogRml4IGEgdXNlIGFmdGVyIGZyZWUgaW4NCj4gPiBpNDBpd19jbV9ldmVudF9o
YW5kbGVyDQo+ID4gDQo+ID4gT24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMDc6MTQ6MTRQTSAtMDgw
MCwgTHYgWXVubG9uZyB3cm90ZToNCj4gPiA+IEluIHRoZSBjYXNlIG9mIEk0MElXX0NNX0VWRU5U
X0FCT1JURUQsIGk0MGl3X2V2ZW50X2Nvbm5lY3RfZXJyb3IoKQ0KPiA+ID4gY291bGQgYmUgY2Fs
bGVkIHRvIGZyZWUgdGhlIGV2ZW50LT5jbV9ub2RlLiBIb3dldmVyLCBldmVudC0+Y21fbm9kZQ0K
PiA+ID4gd2lsbCBiZSB1c2VkIGFmdGVyIGFuZCBjYXVzZSB1c2UgYWZ0ZXIgZnJlZS4gSXQgbmVl
ZHMgdG8gYWRkIGZsYWdzIHRvDQo+ID4gPiBpbmZvcm0gdGhhdCBldmVudC0+Y21fbm9kZSBoYXMg
YmVlbiBmcmVlZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMdiBZdW5sb25nIDxseWwy
MDE5QG1haWwudXN0Yy5lZHUuY24+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2luZmluaWJh
bmQvaHcvaTQwaXcvaTQwaXdfY20uYyB8IDUgKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gVGhpcyBtaWdodCBiZSBP
SyAodGhvdWdoIEkgZG9uJ3QgbGlrZSB0aGUgZnJlZSB2YXJpYWJsZSksIFNoaXJhej8/DQo+ID4g
DQo+IA0KPiBIb3cgd2FzIHRoaXMgcmVwcm9kdWNlZD8gRG8geW91IGhhdmUgc29tZSBjYWxsIHRy
YWNlIGxlYWRpbmcgdXAgdG8gdXNlIGFmdGVyIGZyZWU/DQo+IA0KPiBUaGUgY21fbm9kZSByZWZj
bnQgaXMgYnVtcGVkIGF0IGNyZWF0aW9uIHRpbWUgYW5kIG9uY2UgaW4gaTQwaXdfcmVjZWl2ZV9p
bHEgYmVmb3JlIHBhY2tldCBpcyBwcm9jZXNzZWQuDQo+IFRoYXQgc2hvdWxkIHByb3RlY3QgdGhl
IGNtX25vZGUgZnJvbSBkaXNhcHBlYXJpbmcgaW4gdGhlIGV2ZW50IGhhbmRsZXIgaW4gdGhlIGFi
b3J0IGV2ZW50IGNhc2UuDQo+IFRoZSBkZWMgYXQgZW5kIG9mIGk0MGl3X3JlY2VpdmUgaWxxIHNo
b3VsZCBiZSBwb2ludCB3aGVyZSB0aGUgY21fbm9kZSBpcyBmcmVlZCBzcGVjaWZpY2FsbHkgaW4g
dGhlIGFib3J0IGNhc2UuDQo+IA0KPiBTaGlyYXoNCj4gDQoNClRoaXMgcHJvYmxlbSB3YXMgcmVw
b3J0ZWQgYnkgYSBwYXRoLXNlbnNpdGl2ZSBhbmFseXplciBkZXZlbG9wZWQgYnkgb3VyIFNlY3Vy
aXR5IExhYihMb2NjcykuDQpUaGUgYW5hbHl6ZXIgcmVwb3J0ZWQgdGhhdCB0aGVyZSBpcyBhIGZl
YXNpYmxlIHBhdGggdG8gZnJlZSBldmVudC0+Y21fbm9kZSBhbmQgdXNlIGl0IGFmdGVyLA0KYW5k
IHRoYXQgaXMgd2hhdCBpIGRlc2NyaWJlZCBpbiB0aGUgZmlyc3QgY29tbWl0Lg0KDQpUaGFua3Mu
DQo=
