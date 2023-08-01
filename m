Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A176A6A4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 04:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjHACAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 22:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjHACAq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 22:00:46 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A7C1BE2;
        Mon, 31 Jul 2023 19:00:41 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 1 Aug 2023 10:00:01 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.60]
Date:   Tue, 1 Aug 2023 10:00:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca,
        markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com,
        ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com,
        leon@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230731120326.6bdd5bf9@kernel.org>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
 <20230731120326.6bdd5bf9@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <38179c76.f308d.189aed2db99.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHTQoiZ8hkSOJqCg--.61766W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUOEmTIYfoAqwAAsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8gSmFrdWIsCgo+ID4gCj4gPiBIb3dldmVyLCB0aGlzIGlzIHRlZGlvdXMgYW5kIGp1c3Qg
bGlrZSBMZW9uIHNhaWQ6IGFkZCBhbm90aGVyIGxheWVyIG9mCj4gPiBjYWJhbCBrbm93bGVkZ2Uu
IFRoZSBiZXR0ZXIgc29sdXRpb24gc2hvdWxkIGxldmVyYWdlIHRoZSBubGFfcG9saWN5IGFuZAo+
ID4gZGlzY2FyZCBubGF0dHIgd2hvc2UgbGVuZ3RoIGlzIGludmFsaWQgd2hlbiBkb2luZyBwYXJz
aW5nLiBUaGF0IGlzLCB3ZQo+ID4gc2hvdWxkIGRlZmluZWQgYSBuZXN0ZWRfcG9saWN5IGZvciB0
aGUgWCBhYm92ZSBsaWtlCj4gCj4gSGFyZCBuby4gUHV0dGluZyBhcnJheSBpbmRleCBpbnRvIGF0
dHIgdHlwZSBpcyBhbiBhZHZhbmNlZCBjYXNlIGFuZCB0aGUKPiBwYXJzaW5nIGNvZGUgaGFzIHRv
IGJlIGFibGUgdG8gZGVhbCB3aXRoIGxvdyBsZXZlbCBuZXRsaW5rIGRldGFpbHMuCgpXZWxsLCBJ
IGp1c3Qga25vd24gdGhhdCB0aGUgdHlwZSBmaWVsZCBmb3IgdGhvc2UgYXR0cmlidXRlcyBpcyB1
c2VkIGFzIGFycmF5CmluZGV4LgpIZW5jZSwgZm9yIHRoaXMgYWR2YW5jZWQgY2FzZSwgY291bGQg
d2UgZGVmaW5lIGFub3RoZXIgTkxBIHR5cGUsIG1heWJlIApOTEFfTkVTVEVEX0lEWEFSUkFZIGVu
dW0/IFRoYXQgbWF5IGJlIG11Y2ggY2xlYXJlciBhZ2FpbnN0IG1vZGlmeWluZyBleGlzdGluZwpj
b2RlLgoKPiBIaWdoZXIgbGV2ZWwgQVBJIHNob3VsZCByZW1vdmUgdGhlIG5sYV9mb3JfZWFjaF9u
ZXN0ZWQoKSBjb21wbGV0ZWx5Cj4gd2hpY2ggaXMgcmF0aGVyIGhhcmQgdG8gYWNoaWV2ZSBoZXJl
LgoKQnkgaW52ZXN0aWdhdGluZyB0aGUgY29kZSB1c2VzIG5sYV9mb3JfZWFjaF9uZXN0ZWQgbWFj
cm8uIFRoZXJlIGFyZSBiYXNpY2FsbHkKdHdvIHNjZW5hcmlvczoKCjEuIG1hbnVhbGx5IHBhcnNl
IG5lc3RlZCBhdHRyaWJ1dGVzIHdob3NlIHR5cGUgaXMgbm90IGNhcmVkICh0aGUgYWR2YW5jZSBj
YXNlCiAgIHVzZSB0eXBlIGFzIGluZGV4IGhlcmUpLgoyLiBtYW51YWxseSBwYXJzZSBuZXN0ZWQg
YXR0cmlidXRlcyBmb3IgKm9uZSogc3BlY2lmaWMgdHlwZS4gU3VjaCBjb2RlIGRvCiAgIG5sYV90
eXBlIGNoZWNrLgoKRnJvbSB0aGUgQVBJIHNpZGUsIHRvIGNvbXBsZXRlbHkgcmVtb3ZlIG5sYV9m
b3JfZWFjaF9uZXN0ZWQgYW5kIGF2b2lkIHRoZQptYW51YWwgIHBhcnNpbmcuIEkgdGhpbmsgd2Ug
Y2FuIGNob29zZSB0d28gc29sdXRpb25zLgoKU29sdXRpb24tMTogYWRkIGEgcGFyc2luZyBoZWxw
ZXIgdGhhdCByZWNlaXZlcyBhIGZ1bmN0aW9uIHBvaW50ZXIgYXMgYW4KICAgICAgICAgICAgYXJn
dW1lbnQsIGl0IHdpbGwgY2FsbCB0aGlzIHBvaW50ZXIgYWZ0ZXIgY2FyZWZ1bGx5IHZlcmlmeSB0
aGUKICAgICAgICAgICAgdHlwZSBhbmQgbGVuZ3RoIG9mIGFuIGF0dHJpYnV0ZS4KClNvbHV0aW9u
LTI6IGFkZCBhIHBhcnNpbmcgaGVscGVyIHRoYXQgdHJhdmVyc2VzIHRoaXMgbmVzdGVkIHR3aWNl
LCB0aGUgZmlyc3QKICAgICAgICAgICAgdGltZSAgdG8gZG8gY291bnRpbmcgc2l6ZSBmb3IgYWxs
b2NhdGluZyBoZWFwIGJ1ZmZlciAob3Igc3RhY2sKICAgICAgICAgICAgYnVmZmVyIGZyb20gdGhl
IGNhbGxlciBpZiB0aGUgbWF4IGNvdW50IGlzIGtub3duKS4gVGhlIHNlY29uZAogICAgICAgICAg
ICB0aW1lIHRvIGZpbGwgdGhpcyBidWZmZXIgd2l0aCBhdHRyaWJ1dGUgcG9pbnRlcnMuCgpXaGlj
aCBvbmUgaXMgcHJlZmVycmVkPyBQbGVhc2UgZW5saWdodGVuIG1lIGFib3V0IHRoaXMgYW5kIEkg
Y2FuIHRyeSB0byBwcm9wb3NlCmEgZml4LiAoSSBwZXJzb25hbGx5IGxpa2UgdGhlIHNvbHV0aW9u
LTIgYXMgaXQgd29ya3MgbGlrZSB0aGUgZXhpc3RpbmcgcGFyc2VycwpsaWtlIG5sYV9wYXJzZSkg
Cgo+IAo+IE5hY2tlZC1ieTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4KClRoYW5r
cwpMaW4=
