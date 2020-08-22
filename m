Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49F24E5B7
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Aug 2020 07:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgHVF7c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Aug 2020 01:59:32 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:21190 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgHVF7c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Aug 2020 01:59:32 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sat, 22 Aug 2020 13:58:59
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sat, 22 Aug 2020 13:58:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Cc:     kjlu@umn.edu, "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Yishai Hadas" <yishaih@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Michel Lespinasse" <walken@google.com>,
        "Ariel Elior" <ariel.elior@marvell.com>,
        "Michal Kalderon" <michal.kalderon@marvell.com>,
        "OFED mailing list" <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] IB/uverbs: Fix memleak in ib_uverbs_add_one
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <E59593D2-E7F5-4D41-B6DC-B8B8C55241CE@oracle.com>
References: <20200821081013.4762-1-dinghao.liu@zju.edu.cn>
 <E59593D2-E7F5-4D41-B6DC-B8B8C55241CE@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <152fbf70.7b.17414bfaa7c.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBn6PwjtEBfKnIzAQ--.39571W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoSBlZdtPnBhAAssz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbAIS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVACI402YVCY1x02628vn2kIc2xKxwCS07vE7I0Y64k_MIAIbVCY0x0Ix7I2Y4
        AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY
        6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s
        026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIAIbV
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        V2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAKPiA+IE9uIDIxIEF1ZyAyMDIwLCBhdCAxMDoxMCwgRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1
QHpqdS5lZHUuY24+IHdyb3RlOgo+ID4gCj4gPiBXaGVuIGlkYV9hbGxvY19tYXgoKSBmYWlscywg
dXZlcmJzX2RldiBzaG91bGQgYmUgZnJlZWQKPiA+IGp1c3QgbGlrZSB3aGVuIGluaXRfc3JjdV9z
dHJ1Y3QoKSBmYWlscy4gSXQncyB0aGUgc2FtZQo+ID4gZm9yIHRoZSBlcnJvciBwYXRocyBhZnRl
ciB0aGlzIGNhbGwuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFv
LmxpdUB6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS91dmVy
YnNfbWFpbi5jIHwgMSArCj4gPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiA+IAo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19tYWluLmMgYi9k
cml2ZXJzL2luZmluaWJhbmQvY29yZS91dmVyYnNfbWFpbi5jCj4gPiBpbmRleCAzNzc5NGQ4OGIx
ZjMuLmM2YjRlM2UyYWZmNiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L3V2ZXJic19tYWluLmMKPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19t
YWluLmMKPiA+IEBAIC0xMTcwLDYgKzExNzAsNyBAQCBzdGF0aWMgaW50IGliX3V2ZXJic19hZGRf
b25lKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSkKPiA+IAkJaWJfdXZlcmJzX2NvbXBfZGV2KHV2
ZXJic19kZXYpOwo+ID4gCXdhaXRfZm9yX2NvbXBsZXRpb24oJnV2ZXJic19kZXYtPmNvbXApOwo+
ID4gCXB1dF9kZXZpY2UoJnV2ZXJic19kZXYtPmRldik7Cj4gPiArCWtmcmVlKHV2ZXJic19kZXYp
Owo+IAo+IElzbid0IHRoaXMgdGFrZW4gY2FyZSBvZiBieSB0aGUgKnJlbGVhc2UqIGZ1bmN0aW9u
IHBvaW50ZXIsIHdoaWNoIGhhcHBlbnMgdG8gYmUgaWJfdXZlcmJzX3JlbGVhc2VfZGV2KCkgPwo+
IAoKWW91IGFyZSByaWdodCwgdGhhbmsgeW91IGZvciBwb2ludGluZyBvdXQgdGhhdCEKClJlZ2Fy
ZHMsCkRpbmdoYW8K
