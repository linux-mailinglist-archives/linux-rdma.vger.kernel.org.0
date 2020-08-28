Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B735A255F2C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgH1QvN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Aug 2020 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH1QvK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Aug 2020 12:51:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F1C061264
        for <linux-rdma@vger.kernel.org>; Fri, 28 Aug 2020 09:51:10 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j21so1209304oii.10
        for <linux-rdma@vger.kernel.org>; Fri, 28 Aug 2020 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AQ4IUTMEiAC2nqPUaFG7iJ9hUjpy610oWXuWv2tEcd4=;
        b=a77VhveDjljIs5gWM2ikWpQ7HUGP8sL2udw3Kp+LKBV76ExGEONUC0gmhwvsBfVHAw
         1oYUqAJs06pdu2swWYrvmeFw1SQSXHfEqnMyvXDL6I1yYO0R+DJK1aFxkKcwLJWgmO49
         QO5YkdkmgDEXKqcbJHXEWrhowTg8hRqfJwbmxNUcgApuNh/ZSMstWi3ZXDaUpFSq8NT5
         O8FGM8AoWUu1a+CavJSVY5jRddAYt4gndXy3THBYf3/gXxAb5YCzc3rL0Oi0YK8o12R/
         9FAaQDsZQUtYdhqU104B3+qgJ55LvMHRQ/3sNl6u3Ngd0DTT1Bu+7H2pUxrxfKYCvYfS
         xrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AQ4IUTMEiAC2nqPUaFG7iJ9hUjpy610oWXuWv2tEcd4=;
        b=i8ETjZHMQmoJV4SzGsdDDawxMFy+JK8/b/LiiwdX1UbjcnAW7zoqotn8+Zv5x3LZ3p
         8ixJUNO5hSXWqe86t3c2craHsljGsCrX7YOuE0qF+2wU4TYsE1syEFBLKWPlOnu7E2n/
         CiJpOVADoTOaVk/I0sEoa1LQoS5OipapQuaA0pD+GkQ3rVHQjNlrE3Xguv8giIujgPiI
         5pZyyQzgMw52kwQlTJx/nn/EJFygghZEUcQNaPomme3yN0XuUDXX4t5Iy3QnlzOCWPOb
         K0ARfZy2Roact2eCtoLIbKhLGeg78MhyH2GmigVV9SiETndgoNPIfs5yOxBknv+n3uhf
         qNOA==
X-Gm-Message-State: AOAM532g2uh030xTCMEsWHsI692oN9ww/DGYxRiJIrwVIDQ5aIRlC0vr
        a0RhoWyWd+9acMicbMlY0cqI3cqdp2R03Q==
X-Google-Smtp-Source: ABdhPJwkm9ySZTIwc4P/oeSVV4ayBbN29vWZt0lRAzOceQEEqdKaB9dx5knFl7elXQj3jlzO5VaBDg==
X-Received: by 2002:aca:916:: with SMTP id 22mr21665oij.134.1598633469127;
        Fri, 28 Aug 2020 09:51:09 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:7c61:982b:7ba3:8870? ([2605:6000:8b03:f000:7c61:982b:7ba3:8870])
        by smtp.gmail.com with ESMTPSA id j2sm315528ooo.6.2020.08.28.09.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 09:51:08 -0700 (PDT)
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: pyverbs failures
Message-ID: <0c4cef74-21bf-19b5-1523-6fffa450e764@gmail.com>
Date:   Fri, 28 Aug 2020 11:51:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SSBoYXZlIGJlZW4gdHJ5aW5nIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIHRlc3QgZmFpbHVy
ZXMgaW4gdGhlIHB5dmVyYnMgdGVzdHMgZm9yIHRoZSByeGUgZHJpdmVyLiBUaGVyZSBpcyBv
bmUgY2xhc3Mgb2YgdGhlc2UgZXJyb3JzIHRoYXQgc2VlbXMgdG8gYmUgcG90ZW50aWFsbHkg
YSBkZXNpZ24gZmFpbHVyZSBpbiByZG1hIGNvcmUuIEJ5IGRlZmF1bHQgZWFjaCB0aW1lIGEg
bmV3IFJvQ0UgZGV2aWNlIGlzIHJlZ2lzdGVyZWQgdGhlIGNvcmUgc2V0cyB1cCBhIGdpZCB0
YWJsZSBpbiBjYWNoZS5jIGFuZCBwb3B1bGF0ZXMgdGhlIGZpcnN0IGdpZCBlbnRyeSB3aXRo
IHRoZSBldWk2NCB2ZXJzaW9uIG9mIHRoZSBJUFY2IGxpbmsgbG9jYWwgYWRkcmVzcy4gTGF0
ZXIgdGhlIG90aGVyIElQIGFkZHJlc3NlcyBjb25maWd1cmVkIG9uIGVhY2ggcG9ydCBhcmUg
YWRkZWQgYXMgd2VsbC4gSXQgaXMgZXhwZWN0ZWQgdGhhdCB0aGUgZGVmYXVsdCBlbnRyeSB3
aXRoIHNnaWRfaW5kZXggPSAwIHdpbGwgZnVuY3Rpb24gYXMgYSB2YWxpZCBzb3VyY2UgYWRk
cmVzcy4gRml2ZSB5ZWFycyBhZ28gdGhpcyBwcm9iYWJseSBhbHdheXMgd29ya2VkIGJ1dCBt
b3JlIG1vZGVybiBPU2VzIGhhdmUgc3RvcHBlZCB1c2luZyB0aGlzIGFkZHJlc3MgZm9yIHBy
aXZhY3kgcmVhc29ucy4gVWJ1bnR1IDIwLjA0IHdoaWNoIGlzIHRoZSBvbmUgSSBhbSB3b3Jr
aW5nIG9uIHVzZXMgYSBwc2V1ZG8gcmFuZG9tIGFkZHJlc3MgYW5kIG5vdCB0aGUgTUFDIGJh
c2VkIG9uZS4gV2luZG93cyBhbmQgSU9TIGFsc28gYXBwYXJlbnRseSBubyBsb25nZXIgdXNl
IHRoaXMgYWRkcmVzcy4gVGhlIHJlc3VsdCBpcyB0aGF0IHRoZSBweXZlcmJzIHRlc3QgY2Fz
ZXMgd2hpY2ggdXNlIHNnaWRfaW5kZXggPSAwIGluIHNvbWUgY2FzZXMsIGFuZCB1c2UgcmFu
ZG9tIHNnaWRfaW5kaWNlcyBpbmNsdWRpbmcgMCBpbiBvdGhlcnMsIGZhaWwuIFRoZSBtb3N0
IGNvbW1vbiBmYWlsdXJlIHN5bXB0b20gaXMgdGhhdCB3aGVuIGF0dGVtcHRpbmcgdG8gYWRk
IGEgcmVtb3RlIGFkZHJlc3MgdG8gYSBRUCAoSU5JVCAtPiBSVFIpIGl0IGlzIHVuYWJsZSB0
byBjb250YWN0IHRoZSBpbnZhbGlkIGFkZHJlc3MgYW5kIGl0IHRpbWVzIG91dC4NCg0KQSBi
ZXR0ZXIgY2hvaWNlIGZvciB0aGUgZGVmYXVsdCBHSUQgZm9yIFJvQ0V2MiBkZXZpY2VzIG1h
eSBiZSB0byBqdXN0IHVzZSB0aGUgSVBWNiBhZGRyZXNzIGNvbmZpZ3VyZWQgYXMgdGhlIGxp
bmsgbG9jYWwgYWRkcmVzcyBmb3IgdGhlIG5kZXYuIElmIHRoZXkgdXNlIHRoZSBldWk2NCBh
ZGRyZXNzIHRoZSByZXN1bHQgd2lsbCBiZSB0aGUgc2FtZS4gQXQgbGVhc3Qgc29tZSBvZiB0
aGVzZSBPU2VzIGNsYWltIHRoYXQgdGhlIGxpbmsgbG9jYWwgYWRkcmVzcyBpcyB0ZW1wb3Jh
cnksIGNoYW5naW5nIHBlcmlvZGljYWxseS4gVGhpcyB3b3VsZCByZXF1aXJlIHRyYWNraW5n
IElQVjYuDQoNCkJvYg0K
