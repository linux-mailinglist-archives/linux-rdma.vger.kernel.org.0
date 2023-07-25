Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5F760953
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 07:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjGYFeb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 01:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGYFea (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 01:34:30 -0400
X-Greylist: delayed 164949 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 22:34:25 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD931737;
        Mon, 24 Jul 2023 22:34:24 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.62] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 25 Jul 2023 13:34:17 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.62]
Date:   Tue, 25 Jul 2023 13:34:17 +0800 (GMT+08:00)
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
In-Reply-To: <20230725052557.GI11388@unreal>
References: <20230723074504.3706691-1-linma@zju.edu.cn>
 <20230724174707.GB11388@unreal>
 <3c0760b5.e264b.1898a6368f8.Coremail.linma@zju.edu.cn>
 <20230725052557.GI11388@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <34a51d38.e7c87.1898b8a81b6.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHTQrZXr9knSgPCg--.56959W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQHEmS-J3oE-QAAst
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
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

SGkgTGVvbiwKCj4gCj4gUmlnaHQsIGFuZCB0aGlzIGlzIHdoYXQgYm90aGVycyBtZS4KPiAKPiBJ
IHdvdWxkIG1vcmUgdGhhbiBoYXBweSB0byBjaGFuZ2UgbmxhX2Zvcl9lYWNoX25lc3RlZCgpIHRv
IGJlIHNvbWV0aGluZwo+IGxpa2UgbmxhX2Zvcl9lYWNoX25lc3RlZF90eXBlKC4uLi4sIHNpemVv
Zih1MzIpKSwgd2hpY2ggd2lsbCBza2lwIGVtcHR5Cj4gbGluZXMsIGZvciBjb2RlIHdoaWNoIGNh
bid0IGhhdmUgdGhlbS4KPiAKPiBUaGFua3MKPiAKCldlbGwsIG5sYV9mb3JfZWFjaF9uZXN0ZWRf
dHlwZSguLi4uLCBzaXplb2YodTMyKSkgc2VlbXMgZ29vZCBpZiB0aGUgbmVzdGVkCmF0dHJpYnV0
ZSBpcyBzdXJlIHRvIGNvbnRhaW4gb25seSBvbmUgdHlwZSBvZiBhdHRyaWJ1dGUgd2l0aCBjb25z
dGFudCBsZW5ndGguCihsaWtlIHRoZSBjYXNlIG9mIFJETUFfTkxERVZfQVRUUl9TVEFUX0hXQ09V
TlRFUlMpLgoKSSBhY2NlcHQgdGhhdCBpdCBpcyBhbm90aGVyIGVsZWdhbnQgc29sdXRpb24gaGVy
ZS4gQnV0IGVmZm9ydHMgYXJlIG5lZWRlZCB0bwptYWtlIHN1cmUgaWYgdGhpcyBpcyB0cnVlIGZv
ciBvdGhlciBjYXNlcy4KClJlZ2FyZHMKTGluCgo=
