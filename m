Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3793262C3
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Feb 2021 13:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBZMdR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 07:33:17 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:47110 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230140AbhBZMdP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Feb 2021 07:33:15 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Fri, 26 Feb 2021 20:32:22
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Fri, 26 Feb 2021 20:32:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Bernard Metzler" <BMT@zurich.ibm.com>
Cc:     kjlu <kjlu@umn.edu>, "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re:  [PATCH] RDMA/siw: Fix missing check in siw_get_hdr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <OF56E5E5C1.78489712-ON00258688.0032E2EA-00258688.003301A1@notes.na.collabserv.com>
References: <20210226075515.21371-1-dinghao.liu@zju.edu.cn>
 <OF56E5E5C1.78489712-ON00258688.0032E2EA-00258688.003301A1@notes.na.collabserv.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4ded6c6f.9953b.177de5360ef.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnrvBW6jhg9mPIAQ--.60326W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgQGBlZdtSfEeAAPss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CgomcXVvdDtCZXJuYXJkIE1ldHpsZXImcXVvdDsgJmx0O0JNVEB6dXJpY2guaWJtLmNvbSZndDvl
hpnpgZPvvJoKPiAtLS0tLSJEaW5naGFvIExpdSIgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+IHdy
b3RlOiAtLS0tLQo+IAo+ID5UbzogZGluZ2hhby5saXVAemp1LmVkdS5jbiwga2psdUB1bW4uZWR1
Cj4gPkZyb206ICJEaW5naGFvIExpdSIgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4gPkRhdGU6
IDAyLzI2LzIwMjEgMDg6NTZBTQo+ID5DYzogIkJlcm5hcmQgTWV0emxlciIgPGJtdEB6dXJpY2gu
aWJtLmNvbT4sICJEb3VnIExlZGZvcmQiCj4gPjxkbGVkZm9yZEByZWRoYXQuY29tPiwgIkphc29u
IEd1bnRob3JwZSIgPGpnZ0B6aWVwZS5jYT4sCj4gPmxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPlN1YmplY3Q6IFtFWFRFUk5BTF0gW1BB
VENIXSBSRE1BL3NpdzogRml4IG1pc3NpbmcgY2hlY2sgaW4KPiA+c2l3X2dldF9oZHIKPiA+Cj4g
PldlIHNob3VsZCBhbHNvIGNoZWNrIHRoZSByYW5nZSBvZiBvcGNvZGUgYWZ0ZXIgY2FsbGluZwo+
ID5fX3JkbWFwX2dldF9vcGNvZGUoKSBpbiB0aGUgZWxzZSBicmFuY2ggdG8gcHJldmVudCBwb3Rl
bnRpYWwKPiA+b3ZlcmZsb3cuCj4gCj4gSGkgRGluZ2hhbywKPiBObyB0aGlzIGlzIG5vdCBuZWVk
ZWQuIFdlIGFsd2F5cyBmaXJzdCByZWFkIHRoZSBtaW5pbXVtCj4gaGVhZGVyIGluZm9ybWF0aW9u
IChNUEEgbGVuLCBERFAgZmxhZ3MsIFJETUFQIG9wY29kZSwKPiBTVGFnLCB0YXJnZXQgb2Zmc2V0
KS4gT25seSBpZiB3ZSBoYXZlIHJlY2VpdmVkIHRoYXQKPiBpbnRvIGxvY2FsIGJ1ZmZlciwgd2Ug
Y2hlY2sgZm9yIHRoZSBvcGNvZGUgdGhpcyBvbmUgdGltZS4KPiBOb3cgdGhlIG9wY29kZSBkZXRl
cm1pbmVzIHRoZSByZW1haW5pbmcgbGVuZ3RoIG9mIHRoZQo+IHZhcmlhYmx5IHNpemVkIHBhcnQg
b2YgdGhlIGhlYWRlciB0byBiZSByZWNlaXZlZC4KPiAKPiBXZSBkbyBub3QgaGF2ZSB0byBjaGVj
ayB0aGUgb3Bjb2RlIGFnYWluLCBzaW5jZSB3ZQo+IGFscmVhZHkgcmVjZWl2ZWQgYW5kIGNoZWNr
ZWQgaXQuCj4gCgpJdCdzIGNsZWFyIHRvIG1lLCB0aGFua3MhCgpSZWdhcmRzLApEaW5naGFvCg==

