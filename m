Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3C3871EB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhERGcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 02:32:16 -0400
Received: from smtpbgsg1.qq.com ([54.254.200.92]:38227 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236590AbhERGcP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 02:32:15 -0400
X-Greylist: delayed 1388 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 02:32:15 EDT
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000040
X-QQ-FEAT: OE6UcXCtsg3V1JcbcyT1anz0crsrymcRp9OSD4a4+U8h5l1QUoT4HMVRdxCxt
        9+sZO8acZBfL0eEmrLB45SlM9KD95JVKjVK4F97H3q70VDojvhJYgVosmXzLujqXUjNhr/X
        UcejJMqGJTE3xiyAfPs14YbWpDYDpz95SeM3d5sKrjlfpWYUw6LdgRxWHlQzdL1FpWDVoZR
        cEPDsCcVfi1Tk9s3Vg5f28rrrwMvENSFIdQrIVQG6q9Q3b7pZFvqs9ZP3R66G0EQI7nRnHp
        ewtyH0nW3Q3ZyaJKxccOygL2+hgBAuEOdLm2yI1NWPIj4dkcEnC/9lFrnIJvmliHbriQ==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 182.150.174.174
X-QQ-STYLE: 
X-QQ-mid: logic504t1621319435t4234741
From:   "=?utf-8?B?d2VpLnhpbg==?=" <wei.xin@enmotech.com>
To:     "=?utf-8?B?bGludXgtcmRtYQ==?=" <linux-rdma@vger.kernel.org>
Subject: why ibv_poll_cq always have about 2 seconds delay before available?
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 18 May 2021 14:30:34 +0800
X-Priority: 3
Message-ID: <tencent_7DE23DF5270F283039931C14@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 18 May 2021 14:30:35 +0800 (CST)
Feedback-ID: logic:enmotech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGk6DQogIEkgd3JpdGUgYSBzaW1wbGUgdGVzdCB1c2luZyBSRE1BX0NNIGFuZCBWZXJicyBB
UEksIFJETUFfQ00gZm9yIGNyZWF0ZSBjb25uZWN0aW9uLCBWZXJicyBBUEkgZm9yIGRhdGEg
dHJhbnNmZXIsIHRoZSB0ZXN0IHVzZSBSQyBxcCBhbmQgU2VuZC9SZWN2IFJETUEgb3Bjb2Rl
Lg0KDQogIFRoZSBzZXJ2ZXIgc2lkZSByZWdpc3RlciB0d28gZGlmZmVyZW50IG1lbW9yeSBy
ZWdpb24gYW5kIHN1Ym1pdCB0d28gd29yayByZXF1ZXN0IHVzZSB0aGUgdHdvIGRpZmZlcmVu
dCBtZW1vcnkgcmVnaW9uIGJ5IGNhbGxpbmcgaWJ2X3Bvc3RfZW5kLCBhbmQgdGhlbiwgaW52
b2tlIGlidl9wb2xsX2NxIGluIGEgbG9vcC4NCiAgV2hpbGUgY2xpZW50IHNpZGUsIHdoaWNo
IHJlZ2lzdGVyIG9uZSBtZW1vcnkgcmVnaW9uIGFuZCBjYWxsIGlidl9wb3N0X3JlY3YsIGFu
ZCB0aGVuIGNhbGwgaWJ2X3BvbGxfY3EgaW4gYSBsb29wLCBhZnRlciB0aGUgcmVjdiBjb21w
bGV0ZWQsIHRoZW4gcmUtY2FsbCBpYnZfcG9zdF9yZWN2IHVzZSB0aGUgc2FtZSBtZW1vcnkg
cmVnaW9uLg0KDQogV2hlbiBydW5uaW5nIG9uIG15IGxhcHRvcCAod2hpY2ggcnVubmluZyBv
cGVuU1VTRSBUdW1ibGV3ZWVkIHdpdGggcmRtYV9yeGUpLCBpdCB3b3JrcyBhcyBleHBlY3Rl
ZC4gYnV0IHdoZW4gcnVubmluZyBvbiBhIHNlcnZlciAod2hpY2ggaGFzIE1lbGxhbm94IENv
bm5lY3RYLTUgaW4gUm9DRSBWMSBtb2RlKSB0aGUgY2FsbCBpYnZfcG9sbF9jcSByZXR1cm4g
MCBhZnRlciBhYm91dCAyIHNlY29uZHMuDQoNCkkgdHJ5IHRvIHJld3JpdGUgdGhlIHRlc3Qg
ZW50aXJlbHkgaW4gVmVyYnMgQVBJLCB0aGUgZG9uJ3QgaGF2ZSB0aGUgcHJvYmxlbSBhYm92
ZS4gSXMgdGhlcmUgYW55IHRpcHM/DQoNClRoYW5rIHlvdTE=



