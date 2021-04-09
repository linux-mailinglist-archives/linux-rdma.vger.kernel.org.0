Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C11935A8F5
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Apr 2021 00:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhDIWuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Apr 2021 18:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhDIWuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Apr 2021 18:50:17 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7EC061762
        for <linux-rdma@vger.kernel.org>; Fri,  9 Apr 2021 15:50:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c16so7385369oib.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Apr 2021 15:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=z4iDj33Bi5VUMSySDhKEDdXEbKxTbGOqNEATqR6z0Cw=;
        b=NemnD75MhNtAdF1ymsO1+2HI/GAw4iofiQnaZeso4kcpDFRdKMdFeuMgwnA2KQKiuX
         186yzONI/haIpi375H9j3EvDDLNKYgy+cxPNv1KRJUqeZcjnBkLw4rUhKed2gUiZNQd9
         qDAQXJ/zxnrD1QdpSB01H2WJjcCjy40qfxN4mkTrrF9iWqDG9XmHq2FSSMt7uiNpDpwl
         KPv6naxgpMifalVCfb5FQXx7eDsMmVpPhPuMwhgNhX3+NPSmtpDntx7qfk4yySTyWaNq
         DSt9xrVjX7NnXGs8JfX3fV5jR69WjeSEzxAf7fpuennBWxF1aRZtM4M8POwU/HNT7uW6
         mjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=z4iDj33Bi5VUMSySDhKEDdXEbKxTbGOqNEATqR6z0Cw=;
        b=cqqoBtTbykoQcJCC2c0rH28PxMSJnk9aXYukKUzZvNPfDvI27wk7fV7yQlhJQLme6e
         hteHzLKFf200VALdpJWDz6acf2ShA7wp0dHZ9wRCFOK/fKd/hVXSbAwjYdOC2r0XCwv8
         Bztk/hHeEq6q9+PTRXMEbtIn7Kei4ohAZYg4TYIOf7o5ylfb1mAaA7aih5Ge1GDX+WAE
         4db8/uF89RmTTr7X1qr95XVXHB0BYQfj7tT5zIZ4cGQ7SyvZL1dQegXrtoB1VjTMgB+K
         DDTuJHNcTX+EWTnkMYNOW12e4NJkPCXrQTXcTM7WNQqL7JBWTX3kRpAYwgaLubtlHFx+
         EqKQ==
X-Gm-Message-State: AOAM533pj6BkcAblIhmGSgnaQ87ECRpQcmOd7weaaEmAu1+/54Aj3M/9
        CWZ6uP0jrBC0zFWThpbrSQTZMLm3PBo=
X-Google-Smtp-Source: ABdhPJzi9SYFpe06EtmhSZ5NeytIw7U0UCZ+rlhSZ3TKcf5RYmqyn4i7GmWaAGbHBArzF6xAPB5ywA==
X-Received: by 2002:a05:6808:907:: with SMTP id w7mr11576500oih.94.1618008602704;
        Fri, 09 Apr 2021 15:50:02 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c3b8:e8:40ff:c36d? (2603-8081-140c-1a00-c3b8-00e8-40ff-c36d.res6.spectrum.com. [2603:8081:140c:1a00:c3b8:e8:40ff:c36d])
        by smtp.gmail.com with ESMTPSA id 77sm870574otg.55.2021.04.09.15.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 15:50:02 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Edward Srouji <edwards@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: I need help with the rdmacm tests
Message-ID: <bc01d5dc-4d2c-81ca-0fb3-337d6a160b94@gmail.com>
Date:   Fri, 9 Apr 2021 17:50:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The tests in tests/test_rdmacm.py for rxe are failing because they are not able to compute an IP address for the rxe ports.

The python code depends on having the directory /sys/class/infiniband/<IB_DEVICE>/device/net present. But rxe does not have this
directory. Apparently it would find a list of network devices in this directory and once it has that it can succeed. If I hack the
code in get_net_name in base.py to just return the Ethernet device rxe is using ("enp5s0") the tests all pass.

There are two ways to go forward here. I can figure out how to make rdma-core to create the missing directory or if that is not
correct I can figure out how to add another way for the python code to find the netdev for rxe.

I need help on which way to proceed and any hints how to fix this would be very helpful.

Bob
