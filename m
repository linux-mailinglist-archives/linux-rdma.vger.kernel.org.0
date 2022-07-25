Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711F57F7F8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiGYBmX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Jul 2022 21:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYBmW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Jul 2022 21:42:22 -0400
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jul 2022 18:42:20 PDT
Received: from m13114.mail.163.com (m13114.mail.163.com [220.181.13.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 766AAB4B6
        for <linux-rdma@vger.kernel.org>; Sun, 24 Jul 2022 18:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=wELJ5
        FpmthMUhKICiiuSXE3bngVAVy9RpKe6KgZrBeE=; b=jRdzFFiit4idNwcVXfSMS
        38kE8qbIJVkHgyZpq8S5RXLt+Wxg3CEW7IDxV4RHahu8XS25b9VgwUZVqrUEW2wm
        bg0OEeFC7nQ3irA7PE9JmVrzycsW/XdLfaThKUJJYOc3zrltrO1yaalSogzeAM+X
        4a8PJob+/BaUwJ5dPGgsT4=
Received: from slark_xiao$163.com ( [112.97.48.126] ) by
 ajax-webmail-wmsvr114 (Coremail) ; Mon, 25 Jul 2022 09:26:44 +0800 (CST)
X-Originating-IP: [112.97.48.126]
Date:   Mon, 25 Jul 2022 09:26:44 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Jason Gunthorpe" <jgg@nvidia.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] IB/core: Fix typo 'the the' in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20220722150405.GA33010@nvidia.com>
References: <20220721085232.50291-1-slark_xiao@163.com>
 <20220722150405.GA33010@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <720cea88.6fa.18232f6b15d.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: csGowADH_9JU8d1irgklAA--.65004W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQtIZGBbEdc1CAABsT
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMDctMjIgMjM6MDQ6MDUsICJKYXNvbiBHdW50aG9ycGUi
IDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6Cj5PbiBUaHUsIEp1bCAyMSwgMjAyMiBhdCAwNDo1Mjoz
MlBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiBSZXBsYWNlICd0aGUgdGhlJyB3aXRoICd0
aGUnIGluIHRoZSBjb21tZW50Lgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xh
cmtfeGlhb0AxNjMuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3JvY2Vf
Z2lkX21nbXQuYyB8IDIgKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQo+Cj5JIHNxdWFzaGVkIHRoZXNlIHRocmVlIHBhdGNoZXMgdG9nZXRoZXIsIHRo
YW5rcwo+Cj5KYXNvbgpUaGFua3MgZm9yIHRoYXQuCkkgdGhvdWd0IHRoZXkgYmVsb25ncyB0byBk
aWZmZXJlbnQgc3Vic3lzdGVtIHNvIEkgc2VwYXJhdGUgaXQgZnJvbSBlYWNoIG90aGVyLgpBbnl3
YXksIHRoYW5rcyBmb3IgeW91ciBoZWxwIDopIAo=
