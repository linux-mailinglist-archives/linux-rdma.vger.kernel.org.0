Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF546760406
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGYAcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGYAcP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 20:32:15 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 17:32:13 PDT
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AE0C10EF
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 17:32:13 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.162.208.50] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 25 Jul 2023 08:11:58 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.208.50]
Date:   Tue, 25 Jul 2023 08:11:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     jgg@ziepe.ca, markzhang@nvidia.com, michaelgur@nvidia.com,
        ohartoov@nvidia.com, chenzhongjin@huawei.com, yuancan@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/nldev: Add length check for
 IFLA_BOND_ARP_IP_TARGET parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230724174707.GB11388@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
 <20230724174707.GB11388@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCnzn1OE79kV1OACg--.41726W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIHEmS91fkV-gABsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8gTGVvbiwKCj4gCj4gT24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgMDM6NDU6MDRQTSArMDgw
MCwgTGluIE1hIHdyb3RlOgo+ID4gVGhlIG5sYV9mb3JfZWFjaF9uZXN0ZWQgcGFyc2luZyBpbiBm
dW5jdGlvbgo+ID4gbmxkZXZfc3RhdF9zZXRfY291bnRlcl9keW5hbWljX2RvaXQoKSBkb2VzIG5v
dCBjaGVjayB0aGUgbGVuZ3RoIG9mIHRoZQo+ID4gYXR0cmlidXRlLiBUaGlzIGNhbiBsZWFkIHRv
IGFuIG91dC1vZi1hdHRyaWJ1dGUgcmVhZCBhbmQgYWxsb3cgYQo+ID4gbWFsZm9ybWVkIG5sYXR0
ciAoZS5nLiwgbGVuZ3RoIDApIHRvIGJlIHZpZXdlZCBhcyBhIDQgYnl0ZSBpbnRlZ2VyLgo+IAo+
IDEuIFN1YmplY3Qgb2YgdGhpcyBwYXRjaCBkb2Vzbid0IHJlYWxseSBtYXRjaCB0aGUgY2hhbmdl
LgoKTXkgYmFkLCBhIHN0dXBpZCBtaXN0YWtlLiBJIHdpbGwgZml4IHRoYXQgYW5kIHByZXBhcmUg
YW5vdGhlciBwYXRjaC4KCj4gMi4gU2VlIG15IGNvbW1lbnQgb24geW91ciBpNDBlIHBhdGNoLgo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMDcyNDE3NDQzNS5HQTExMzg4QHVu
cmVhbC8KPiAKClllYWggSSBoYXZlIHNlZW4gdGhhdC4gSnVzdCBhcyBKYWt1YiBzYWlkLCBlbXB0
eSBuZXRsaW5rIGF0dHJpYnV0ZXMgYXJlIHZhbGlkIAoodGhleSBhcmUgdmlld2VkIGFzIGZsYWcp
LiBUaGUgcG9pbnQgaXMgdGhhdCBkaWZmZXJlbnQgYXR0cmlidXRlIGhhcyBkaWZmZXJlbnQKbGVu
Z3RoIHJlcXVpcmVtZW50LiBGb3IgdGhpcyBzcGVjaWZpYyBjb2RlLCB0aGUgUkRNQV9OTERFVl9B
VFRSX1NUQVRfSFdDT1VOVEVSUwphdHRyaWJ1dGUgaXMgYSBuZXN0ZWQgb25lIHdob3NlIGlubmVy
IGF0dHJpYnV0ZXMgc2hvdWxkIGJlIE5MQV9VMzIuIEJ1dCBhcyB5b3UKY2FuIHNlZSBpbiB2YXJp
YWJsZSBubGRldl9wb2xpY3ksIHRoZSBkZXNjcmlwdGlvbiBkb2VzIG5vdCB1c2UgbmVzdGVkIHBv
bGljeSB0bwplbmZvcmUgdGhhdCwgd2hpY2ggcmVzdWx0cyBpbiB0aGUgYnVnIGRpc2N1c3NlZCBp
biBteSBjb21taXQgbWVzc2FnZS4KCiBbUkRNQV9OTERFVl9BVFRSX1NUQVRfSFdDT1VOVEVSU10g
ICAgICAgPSB7IC50eXBlID0gTkxBX05FU1RFRCB9LAoKVGhlIGVsZWdhbnQgZml4IGNvdWxkIGJl
IGFkZCB0aGUgbmVzdGVkIHBvbGljeSBkZXNjcmlwdGlvbiB0byBubGRldl9wb2xpY3kgd2hpbGUK
dGhpcyBpcyB0b3VibGVzb21lIGFzIG5vIGV4aXN0aW5nIG5sYV9hdHRyIGhhcyBiZWVuIGdpdmVu
IHRvIHRoaXMgbmVzdGVkIG5sYXR0ci4KSGVuY2UsIGFkZCB0aGUgbGVuZ3RoIGNoZWNrIGlzIHRo
ZSBzaW1wbGVzdCBzb2x1dGlvbiBhbmQgeW91IGNhbiBzZWUgc3VjaCBubGFfbGVuCmNoZWNrIGNv
ZGUgYWxsIG92ZXIgdGhlIGtlcm5lbC4KCj4gVGhhbmtzCgpSZWdhcmRzCkxpbg==
