Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6C76C179
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 02:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHBA0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 20:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBA0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 20:26:45 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FC972113;
        Tue,  1 Aug 2023 17:26:42 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.233.175] ) by
 ajax-webmail-mail-app3 (Coremail) ; Wed, 2 Aug 2023 08:26:06 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.233.175]
Date:   Wed, 2 Aug 2023 08:26:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Leon Romanovsky" <leon@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, fw@strlen.de,
        yang.lee@linux.alibaba.com, jgg@ziepe.ca, markzhang@nvidia.com,
        phaddad@nvidia.com, yuancan@huawei.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, aharonl@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230801105726.1af6a7e1@kernel.org>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
 <20230731120326.6bdd5bf9@kernel.org> <20230801081117.GA53714@unreal>
 <20230801105726.1af6a7e1@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <385b9766.f63d7.189b3a33c6b.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3v5+foslkxqYjDA--.43974W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUPEmTIYfoZ3QABsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8gdGhlcmUsCgo+IEZvciB0aGUgbG9uZ2VzdCB0aW1lIHRoZXJlIHdhcyBubyBkb2NzIG9y
IGJlc3QgcHJhY3RpY2VzIGZvciBuZXRsaW5rLgo+IFdlIGhhdmUgdGhlIGRvY3VtZW50YXRpb24g
YW5kIG1vcmUgaW5mcmFzdHJ1Y3R1cmUgaW4gcGxhY2Ugbm93Lgo+IEkgaG9wZSBpZiB5b3Ugd3Jv
dGUgdGhlIGNvZGUgdG9kYXkgdGhlIGRpc3RpbmN0aW9uIHdvdWxkIGhhdmUgYmVlbgo+IGNsZWFy
ZXIuCj4gCj4gSWYgd2Ugc3RhcnQgYWRkaW5nIEFQSXMgZm9yIHZhcmlvdXMgb25lLSh0d28/KS1v
ZmZzIGZyb20gdGhlIHBhc3QKPiB3ZSdsbCBuZXZlciBkaWcgb3Vyc2VsdmVzIG91dCBvZiB0aGUg
Im5vIGlkZWEgd2hhdCdzIHRoZSBub3JtYWwgdXNlCj4gb2YgdGhlc2UgQVBJcyIgaG9sZS4uCgpU
aGlzIGlzIHRydWUuIEFjdHVhbGx5LCB0aG9zZSBjaGVjayBtaXNzaW5nIGNvZGVzIGFyZSBtb3N0
bHkgb2xkIGNvZGVzIGFuZAptb2Rlcm4gbmV0bGluayBjb25zdW1lcnMgd2lsbCBjaG9vc2UgdGhl
IGdlbmVyYWwgbmV0bGluayBpbnRlcmZhY2Ugd2hpY2gKY2FuIGF1dG9tYXRpY2FsbHkgZ2V0IGF0
dHJpYnV0ZXMgZGVzY3JpcHRpb24gZnJvbSBZQU1MIGFuZCBuZXZlciBuZWVkIHRvCmRvIHRoaW5n
cyBsaWtlICptYW51YWwgcGFyc2luZyogYW55bW9yZS4KCkhvd2V2ZXIsIGFjY29yZGluZyB0byBt
eSBwcmFjdGljZSBpbiBhdWRpdGluZyB0aGUgY29kZSwgSSBmb3VuZCB0aGVyZSBhcmUKc29tZSBn
ZW5lcmFsIG5ldGxpbmsgaW50ZXJmYWNlIHVzZXJzIGNvbmZyb250IG90aGVyIGlzc3VlcyBsaWtl
IGNob29zaW5nCkdFTkxfRE9OVF9WQUxJREFURV9TVFJJQ1Qgd2l0aG91dCB0aGlua2luZyBvciBm
b3JnZXR0aW5nIGFkZCBhIG5ldwpubGFfcG9saWN5IHdoZW4gaW50cm9kdWNpbmcgbmV3IGF0dHJp
YnV0ZXMuCgpUbyB0aGlzIGVuZCwgSSdtIGN1cnJlbnRseSB3cml0aW5nIGEgc2ltcGxlIGRvY3Vt
ZW50YXRpb24gYWJvdXQgTmV0bGluawppbnRlcmZhY2UgYmVzdCBwcmFjdGljZXMgZm9yIHRoZSBr
ZXJuZWwgZGV2ZWxvcGVyICh0aGUgbmV3bHkgY29taW5nIGRvY3MKYXJlIG1vc3RseSBhYm91dCB0
aGUgdXNlciBBUEkgcGFydCkuIAoKSSBndWVzcyBJIHdpbGwgcHV0IHRoaXMgZG9jIGluIERvY3Vt
ZW50YXRpb24vc3RhZ2luZyA6KQphbmQgSSB3aWxsIGZpbmlzaCB0aGUgZHJhZnQgQVNBUC4KClRo
YW5rcwpMaW4=
