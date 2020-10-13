Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674DF28D04B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgJMOdR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJMOdQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 10:33:16 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C6C0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 07:33:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id e20so135930otj.11
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5JB8ce1qUQLsghBM/HvEnamQt1XIb7y86RHLX4xoBXM=;
        b=L8FhTJpEpZbv7Z/uFEJ/jed3g5bpmhMmI0v5mKpFWXno1gsaKgXJCFrivRWbyJ+Cje
         7yCpDy/RzQ+gDDQjMhw7Awo+n7vLD+WRJNp+qA/dqLoJ5uxVaTYp7UD/DIDZnb3i8FyR
         OEdf80D7zgWDod3jNPy3Wbh2YVVlBlwEcwC+dOzS5pb1HqC6wVcUiStR3Une8RpPe2xV
         S+mrGALNoRoYX0R4l1G4+1Qr7D6284eZxzQWNRDNGlJ2VSNN1P++d4qu+xcTlQOVig8A
         T1bxkv8lCJfvHtgKuctpiEKmbAcE1B9vsEoBsWsPJvfu72DAiL4rfmv23d5bPe6wSAP1
         S7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5JB8ce1qUQLsghBM/HvEnamQt1XIb7y86RHLX4xoBXM=;
        b=pNcGPFXPuw80sTeh79Chwboih/AsmPDo/CNV3TqOTJWOIk7q+cAZpjGuechKMwJizk
         BPHduDjAqt1f5MkNvLJq91bimEfv14nEm/U2o2mVawrtrRXy93xiJt2hD9Y4K2VqncX7
         Ajw5TUrhnGHLCV4cHhwzKIgQSBH5ZY4Rv8WH2DgdDOpBFPJKuKIetAXpI3WEICtyDa71
         oxf4ellkSxc6jJ2BjFsQLnVWFEwrDwMC4mHb0GHtMblsGBGTE9bb9XV9bZUvnKSeiawq
         2U8BJIQHU7U3ut1SKqV5LKjWqCXDOaVDN61DCWZiarNwYe0TKFeS22+kPjR8VGJmX8l/
         YkKw==
X-Gm-Message-State: AOAM530BERJcJrqighczBKNJzwCbzyhalENztVF83hJGuCj0Xo4TytYp
        O81163oSAtNcJubuf7sk67k8PhZjzx8=
X-Google-Smtp-Source: ABdhPJwnDGoKU0RFoIjlD/Dxi6OAWheA9ciZGfVsq9zNtq+oq/zFTgPzPD3yMgg5T8B4BaieBKawMg==
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr9953499otk.85.1602599595493;
        Tue, 13 Oct 2020 07:33:15 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d1f8:586d:5100:2ad4? (2603-8081-140c-1a00-d1f8-586d-5100-2ad4.res6.spectrum.com. [2603:8081:140c:1a00:d1f8:586d:5100:2ad4])
        by smtp.gmail.com with ESMTPSA id 8sm11331048oii.45.2020.10.13.07.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:33:15 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: dynamic-sg patch has broken rdma_rxe
Message-ID: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
Date:   Tue, 13 Oct 2020 09:33:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SmFzb24sDQoNCkp1c3QgcHVsbGVkIGZvci1uZXh0IGFuZCBub3cgaGl0IHRoZSBmb2xsb3dp
bmcgd2FybmluZy4NClJlZ2lzdGVyIHVzZXIgc3BhY2UgbWVtb3J5IGlzIG5vdCBsb25nZXIg
d29ya2luZy4NCkkgYW0gdHJ5aW5nIHRvIGRlYnVnIHRoaXMgYnV0IGlmIHlvdSBoYXZlIGFu
eSBpZGVhIHdoZXJlIHRvIGxvb2sgbGV0IG1lIGtub3cuDQoNCkJvYg0KDQpbICAyMDkuNTYy
MDk2XSBXQVJOSU5HOiBDUFU6IDEyIFBJRDogNTM0MyBhdCBsaWIvc2NhdHRlcmxpc3QuYzo0
MzggX19zZ19hbGxvY190YWJsZV9mcm9tX3BhZ2VzKzB4MjEvMHg0NDANClsgIDIwOS41NjIw
OTddIE1vZHVsZXMgbGlua2VkIGluOiByZG1hX3J4ZSBpcDZfdWRwX3R1bm5lbCB1ZHBfdHVu
bmVsIHJmY29tbSB4dF9DSEVDS1NVTSB4dF9NQVNRVUVSQURFIHh0X2Nvbm50cmFjayBpcHRf
UkVKRUNUIG5mX3JlamVjdF9pcHY0IHh0X3RjcHVkcCBpcDZ0YWJsZV9tYW5nbGUgaXA2dGFi
bGVfbmF0IGlwdGFibGVfbWFuZ2xlIGlwdGFibGVfbmF0IG5mX25hdCBuZl9jb25udHJhY2sg
bmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgbGliY3JjMzJjIG5mX3RhYmxlcyBuZm5l
dGxpbmsgaXA2dGFibGVfZmlsdGVyIGlwNl90YWJsZXMgaXB0YWJsZV9maWx0ZXIgYnBmaWx0
ZXIgYnJpZGdlIHN0cCBsbGMgY21hYyBhbGdpZl9oYXNoIGFsZ2lmX3NrY2lwaGVyIGFmX2Fs
ZyBibmVwIGJpbmZtdF9taXNjIGl3bG12bSBidHVzYiBidHJ0bCBidGJjbSBpbnB1dF9sZWRz
IG1hYzgwMjExIGJ0aW50ZWwgYmx1ZXRvb3RoIGxpYmFyYzQgaXdsd2lmaSBpYl91dmVyYnMg
c25kX2hkYV9jb2RlY19yZWFsdGVrIHNuZF9oZGFfY29kZWNfZ2VuZXJpYyBlY2RoX2dlbmVy
aWMgaWJfY29yZSBjZmc4MDIxMSBpZ2IgbGVkdHJpZ19hdWRpbyBlY2Mgc25kX2hkYV9jb2Rl
Y19oZG1pIGhpZF9nZW5lcmljIHNuZF9oZGFfaW50ZWwgc25kX2ludGVsX2RzcGNmZyBkY2Eg
c25kX2hkYV9jb2RlYyBzbmRfaGRhX2NvcmUgdXNiaGlkIHNuZF9od2RlcCBubHNfaXNvODg1
OV8xIGFtZGdwdSBtbHg1X2NvcmUgZWRhY19tY2VfYW1kIGhpZCBzbmRfcGNtIGt2bV9hbWQg
a3ZtIGlvbW11X3YyIHNuZF9zZXFfbWlkaSBzbmRfc2VxX21pZGlfZXZlbnQgZ3B1X3NjaGVk
IHR0bSB3bWlfYm1vZiBteG1fd21pIHNuZF9yYXdtaWRpIGRybV9rbXNfaGVscGVyIHNuZF9z
ZXEgdGxzIGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGdoYXNoX2NsbXVsbmlfaW50
ZWwgYWVzbmlfaW50ZWwgc25kX3NlcV9kZXZpY2UgY3J5cHRvX3NpbWQgc25kX3RpbWVyIG1s
eGZ3IGNyeXB0ZCBjZWMNClsgIDIwOS41NjIxMzVdICBnbHVlX2hlbHBlciBjY3Agc25kIHJh
cGwgcGNpX2h5cGVydl9pbnRmIGkyY19hbGdvX2JpdCBhaGNpIGkyY19waWl4NCBlZmlfcHN0
b3JlIHNvdW5kY29yZSBmYl9zeXNfZm9wcyBsaWJhaGNpIHN5c2NvcHlhcmVhIGsxMHRlbXAg
c3lzZmlsbHJlY3Qgc3lzaW1nYmx0IHdtaSBkcm0gc3VucnBjIHNjaF9mcV9jb2RlbCBwYXJw
b3J0X3BjIHBwZGV2IGxwIHBhcnBvcnQgaXBfdGFibGVzIHhfdGFibGVzIGF1dG9mczQgbnZt
ZSBudm1lX2NvcmUgbWFjX2hpZA0KWyAgMjA5LjU2MjE0OV0gQ1BVOiAxMiBQSUQ6IDUzNDMg
Q29tbTogcHl0aG9uMyBOb3QgdGFpbnRlZCA1LjkuMC1yYzgrICMyMA0KWyAgMjA5LjU2MjE1
MF0gSGFyZHdhcmUgbmFtZTogR2lnYWJ5dGUgVGVjaG5vbG9neSBDby4sIEx0ZC4gWDU3MCBB
T1JVUyBQUk8gV0lGSS9YNTcwIEFPUlVTIFBSTyBXSUZJLCBCSU9TIEYxMSAxMi8wNi8yMDE5
DQpbICAyMDkuNTYyMTUzXSBSSVA6IDAwMTA6X19zZ19hbGxvY190YWJsZV9mcm9tX3BhZ2Vz
KzB4MjEvMHg0NDANClsgIDIwOS41NjIxNTVdIENvZGU6IGMzIDBmIDFmIDg0IDAwIDAwIDAw
IDAwIDAwIDU1IDQ4IDg5IGU1IDQxIDU3IDQxIDU2IDQxIDU1IDQxIDg5IGQ1IDQxIDU0IDUz
IDQ4IDgzIGVjIDQ4IDQ4IDg5IDdkIGEwIDQ4IDhiIDU1IDEwIDQ1IDg1IGM5IDc1IDFiIDww
Zj4gMGIgNDkgYzcgYzIgZWEgZmYgZmYgZmYgNDggODMgYzQgNDggNGMgODkgZDAgNWIgNDEg
NWMgNDEgNWQgNDENClsgIDIwOS41NjIxNTZdIFJTUDogMDAxODpmZmZmYjg2NjQ4Yjg3OWE4
IEVGTEFHUzogMDAwMTAyMDYNClsgIDIwOS41NjIxNTddIFJBWDogMDAwMDAwMDAwMDAwMTAw
MCBSQlg6IDAwMDAwMDAwMDIzOGMwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAyMDku
NTYyMTU4XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmOGFiMGMyNjY3MDAwIFJE
STogZmZmZjhhYjBkN2IwYzFkMA0KWyAgMjA5LjU2MjE1OV0gUkJQOiBmZmZmYjg2NjQ4Yjg3
YTE4IFIwODogMDAwMDAwMDAwMDAwMTAwMCBSMDk6IDAwMDAwMDAwZmZmZmZmZmYNClsgIDIw
OS41NjIxNjBdIFIxMDogMDAwMDAwMDAwMDAwMDAyMiBSMTE6IDAwMDAwMDAwMDAwMDAwMDEg
UjEyOiBmZmZmOGFiMGZhYWNlMDAwDQpbICAyMDkuNTYyMTYxXSBSMTM6IDAwMDAwMDAwMDAw
MDAwMDEgUjE0OiAwMDAwMDAwMGZmZmZmZmZmIFIxNTogZmZmZjhhYjBjMjY2NzAwMA0KWyAg
MjA5LjU2MjE2Ml0gRlM6ICAwMDAwN2YxODQ2ZjAwNzQwKDAwMDApIEdTOmZmZmY4YWIwZmVi
MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWyAgMjA5LjU2MjE2M10gQ1M6
ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KWyAgMjA5
LjU2MjE2NF0gQ1IyOiAwMDAwMDAwMDAyMmM1MDk4IENSMzogMDAwMDAwMDc0YWI0ODAwMCBD
UjQ6IDAwMDAwMDAwMDAzNTBlZTANClsgIDIwOS41NjIxNjVdIENhbGwgVHJhY2U6DQpbICAy
MDkuNTYyMTc2XSAgaWJfdW1lbV9nZXQrMHgxYjEvMHgzOTAgW2liX3V2ZXJic10NClsgIDIw
OS41NjIxODJdICByeGVfbWVtX2luaXRfdXNlcisweDQ4LzB4MWUwIFtyZG1hX3J4ZV0NClsg
IDIwOS41NjIxODddICByeGVfcmVnX3VzZXJfbXIrMHg5Ni8weDE2MCBbcmRtYV9yeGVdDQpb
ICAyMDkuNTYyMTkzXSAgaWJfdXZlcmJzX3JlZ19tcisweDE0MS8weDI3MCBbaWJfdXZlcmJz
XQ0KWyAgMjA5LjU2MjE5OV0gIGliX3V2ZXJic19oYW5kbGVyX1VWRVJCU19NRVRIT0RfSU5W
T0tFX1dSSVRFKzB4ZDIvMHgxNDAgW2liX3V2ZXJic10NClsgIDIwOS41NjIyMDJdICA/IF9f
Y2hlY2tfb2JqZWN0X3NpemUrMHg0ZC8weDE1MA0KWyAgMjA5LjU2MjIwN10gIGliX3V2ZXJi
c19jbWRfdmVyYnMrMHhiMzcvMHhjNzAgW2liX3V2ZXJic10NCg==
