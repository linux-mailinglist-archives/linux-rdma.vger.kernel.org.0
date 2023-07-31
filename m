Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829FA769665
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGaMdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjGaMdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 08:33:17 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A207EE53;
        Mon, 31 Jul 2023 05:33:14 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app2 (Coremail) ; Mon, 31 Jul 2023 20:33:02 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.60]
Date:   Mon, 31 Jul 2023 20:33:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Jakub Kicinski" <kuba@kernel.org>, jgg@ziepe.ca,
        markzhang@nvidia.com, michaelgur@nvidia.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/nldev: Add length check for
 IFLA_BOND_ARP_IP_TARGET parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230725183924.GS11388@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
 <20230724174707.GB11388@unreal>
 <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
 <20230725052557.GI11388@unreal> <20230725101405.4cd51059@kernel.org>
 <20230725183924.GS11388@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7a2e7314.ee8a2.189abf00b34.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCnzn3_qcdkiTnaCg--.46655W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIIEmTAePoLZABKsY
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8gdGhlcmUsCgo+ID4gPiA+IFllYWggSSBoYXZlIHNlZW4gdGhhdC4gSnVzdCBhcyBKYWt1
YiBzYWlkLCBlbXB0eSBuZXRsaW5rIGF0dHJpYnV0ZXMgYXJlIHZhbGlkIAo+ID4gPiA+ICh0aGV5
IGFyZSB2aWV3ZWQgYXMgZmxhZykuIFRoZSBwb2ludCBpcyB0aGF0IGRpZmZlcmVudCBhdHRyaWJ1
dGUgaGFzIGRpZmZlcmVudAo+ID4gPiA+IGxlbmd0aCByZXF1aXJlbWVudC4gRm9yIHRoaXMgc3Bl
Y2lmaWMgY29kZSwgdGhlIFJETUFfTkxERVZfQVRUUl9TVEFUX0hXQ09VTlRFUlMKPiA+ID4gPiBh
dHRyaWJ1dGUgaXMgYSBuZXN0ZWQgb25lIHdob3NlIGlubmVyIGF0dHJpYnV0ZXMgc2hvdWxkIGJl
IE5MQV9VMzIuIEJ1dCBhcyB5b3UKPiA+ID4gPiBjYW4gc2VlIGluIHZhcmlhYmxlIG5sZGV2X3Bv
bGljeSwgdGhlIGRlc2NyaXB0aW9uIGRvZXMgbm90IHVzZSBuZXN0ZWQgcG9saWN5IHRvCj4gPiA+
ID4gZW5mb3JlIHRoYXQsIHdoaWNoIHJlc3VsdHMgaW4gdGhlIGJ1ZyBkaXNjdXNzZWQgaW4gbXkg
Y29tbWl0IG1lc3NhZ2UuCj4gPiA+ID4gCj4gPiA+ID4gIFtSRE1BX05MREVWX0FUVFJfU1RBVF9I
V0NPVU5URVJTXSAgICAgICA9IHsgLnR5cGUgPSBOTEFfTkVTVEVEIH0sCj4gPiA+ID4gCj4gPiA+
ID4gVGhlIGVsZWdhbnQgZml4IGNvdWxkIGJlIGFkZCB0aGUgbmVzdGVkIHBvbGljeSBkZXNjcmlw
dGlvbiB0byBubGRldl9wb2xpY3kgd2hpbGUKPiA+ID4gPiB0aGlzIGlzIHRvdWJsZXNvbWUgYXMg
bm8gZXhpc3RpbmcgbmxhX2F0dHIgaGFzIGJlZW4gZ2l2ZW4gdG8gdGhpcyBuZXN0ZWQgbmxhdHRy
Lgo+ID4gPiA+IEhlbmNlLCBhZGQgdGhlIGxlbmd0aCBjaGVjayBpcyB0aGUgc2ltcGxlc3Qgc29s
dXRpb24gYW5kIHlvdSBjYW4gc2VlIHN1Y2ggbmxhX2xlbgo+ID4gPiA+IGNoZWNrIGNvZGUgYWxs
IG92ZXIgdGhlIGtlcm5lbC4gIAo+ID4gPiAKPiA+ID4gUmlnaHQsIGFuZCB0aGlzIGlzIHdoYXQg
Ym90aGVycyBtZS4KPiA+ID4gCj4gPiA+IEkgd291bGQgbW9yZSB0aGFuIGhhcHB5IHRvIGNoYW5n
ZSBubGFfZm9yX2VhY2hfbmVzdGVkKCkgdG8gYmUgc29tZXRoaW5nCj4gPiA+IGxpa2UgbmxhX2Zv
cl9lYWNoX25lc3RlZF90eXBlKC4uLi4sIHNpemVvZih1MzIpKSwgd2hpY2ggd2lsbCBza2lwIGVt
cHR5Cj4gPiA+IGxpbmVzLCBmb3IgY29kZSB3aGljaCBjYW4ndCBoYXZlIHRoZW0uCj4gPiAKPiA+
IEluIGdlbmVyYWwgdGhlIGlkZWEgb2YgYXV0by1za2lwcGluZyBzdHVmZiBrZXJuZWwgZG9lc24n
dCByZWNvZ25pemUKPiA+IGlzIGEgYml0IG9sZCBzY2hvb2wuIEJldHRlciBkaXJlY3Rpb24gd291
bGQgYmUgZXh0ZW5kaW5nIHRoZSBwb2xpY3kKPiA+IHZhbGlkYXRpb24gdG8gY292ZXIgdXNlIGNh
c2VzIGZvciBzdWNoIGxvb3BzLgo+IAo+IEknbSBhbGwgaW4gZm9yIGFueSBzb2x1dGlvbiB3aGlj
aCB3aWxsIGhlbHAgZm9yIGF2ZXJhZ2UgZGV2ZWxvcGVyIHRvIHdyaXRlCj4gbmV0bGluayBjb2Rl
IHdpdGhvdXQgbWlzdGFrZXMuCj4gCj4gVGhhbmtzCgpJIGhhdmUganVzdCBjb21lIG91dCBhIG5l
dyBzb2x1dGlvbiBmb3Igc3VjaCBsZW5ndGggaXNzdWVzLiBQbGVhc2Ugc2VlCiogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNzMxMTIxMjQ3LjM5NzI3ODMtMS1saW5tYUB6anUuZWR1
LmNuL1QvI3UKKiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA3MzExMjEzMjQuMzk3
MzEzNi0xLWxpbm1hQHpqdS5lZHUuY24vVC8jdQoKSSdtIG5vdCBzdXJlIGFkZGluZyBhZGRpdGlv
bmFsIHZhbGlkYXRpb24gbG9naWMgaW4gdGhlIG1haW4gbmxhdHRyIGNvZGUgaXMKdGhlIGJlc3Qg
c29sdXRpb24uIFN0aWxsLCBhZnRlciBpbnZlc3RpZ2F0aW5nIHRoZSBjb2RlLCB0aGUgbGVuIGZp
ZWxkIGNhbgpiZSB2ZXJ5IHN1aXRhYmxlIGZvciBoYW5kbGluZyB0aGUgTkxBX05FU1RFRCBjYXNl
cyBoZXJlLiBBbmQgdGhlIGRldmVsb3BlcgpjYW4gZG8gbWFudWFsIHBhcnNpbmcgd2l0aCBiZXR0
ZXIgbmxhX3BvbGljeS1iYXNlZCBjaGVja2luZyB0b28uCgpJZiB0aGlzIGlkZWEgaXMgYXBwbGll
ZCwgSSB3aWxsIGFsc28gd3JpdGUgYSBzY3JpcHQgdG8gY2xlYW4gdXAgb3RoZXIKbmxhX2xlbiBw
YXRjaGVzIGJhc2VkIG9uIHRoZSBubGFfcG9saWN5IGNoZWNrLgoKUmVnYXJkcwpMaW4K
