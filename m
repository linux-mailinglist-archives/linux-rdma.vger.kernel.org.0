Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267F643AB86
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 07:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhJZFGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 01:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhJZFGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Oct 2021 01:06:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC14C061745
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 22:03:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so18151975ott.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 22:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xVYvTNbhyz5JA8XkPjkZliZQAmXEl2qmsG7wn3AKZqo=;
        b=MpCobLSDWo4J4OTGoEoJTrOWXh48Woe05svLENUhPantvejAAtX1JAQmnI/gx5caFX
         BMO5iUl11mYhScJhIm3qe+8qDmeYQ6tw3oeYH0Rtq1C4RykjPo71fgXGqR6UjMovgN6g
         XDwZFSpzPO40Z6Ga4kMfTktwNBFSzv4smBYDC2zu0Ps2YY5UirXoc7O/Tl2EbPDxY7C4
         qpR1IK0JBqXMoA/IZYwfsCkXLTkceZ3P+gyY5AET5I2BEpYo5i6klwqqqouqsKC7Z6qO
         F+Jb0F+t2cc9prRdDKLnbCJUp3XyxysIDbot2k5Ex7Py9kqP2B3KvJNLjltxE+acyLTK
         TIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xVYvTNbhyz5JA8XkPjkZliZQAmXEl2qmsG7wn3AKZqo=;
        b=cA/7WtNzdYWVzKZoLFh/VHRUfREnMe2CCs+hPaJPUwWz6yW+61ZGTfGkqSXTWkKlgQ
         7Ds0DqnQKZ6Nx1JhUspWcDsEi0xwXtfYK+8yHTjXJQu9i6NIkm8aKyQf3DfFE8gMNi7E
         rCh92Cgj/nczPrRt4t8bh0sevqxMR4zTjbXJAu68w/MsOpnIRZNznAVSghlfh9oHbYwq
         YxVyUqYloQFDlncNYtKkM//qS5JVvitcjeKiMdy42/Jbu1wgg++7U9gys1jeWagpLkbB
         8sHsV8Q/J2SU1Ehs6J2D8/RUKxOweuiN7gkhV6+WTviU+oRPIU+57tzsWzYv1eCkRaUr
         xu6A==
X-Gm-Message-State: AOAM531KBVaiX6B5u+nkuVZSQ1KNoOXzkkxb3dsPNpBJJqKYhrn86n90
        5u2TZqfWxePFHLy0Zp6QFQN95gA3X5A=
X-Google-Smtp-Source: ABdhPJwmhzx7pQfEyJGS4kvMCR7E7pq9uqEE7TSwWT3pgLXVjPRMYsr7Up1+sKF3hlWQo87C5Fxdgw==
X-Received: by 2002:a9d:4114:: with SMTP id o20mr17369480ote.171.1635224630337;
        Mon, 25 Oct 2021 22:03:50 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:e580:1e56:fd2a:ef7c? (2603-8081-140c-1a00-e580-1e56-fd2a-ef7c.res6.spectrum.com. [2603:8081:140c:1a00:e580:1e56:fd2a:ef7c])
        by smtp.gmail.com with ESMTPSA id e9sm4170268otr.25.2021.10.25.22.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:03:50 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: attach multicast verb
Message-ID: <f5703260-46ab-2d96-e2db-70e9801741e2@gmail.com>
Date:   Tue, 26 Oct 2021 00:03:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I spent some time looking at the current code for attach multicast and it seems likely not to work. Unfortunately there isn't very much test code for multicast over RoCEv2. Currently the rxe receive code maps all ipv4 multicast addresses ([224-239].x.x.x) to IPV6 unicast addresses using the 46 mapping 0::0000:ffff:aabb:ccdd where the IPV4 address is aa.bb.cc.dd.
This is then mapped to a 48 bit MAC address using the IPV6 to MAC mapping

IPV6 mcast addr = FFts:xxxx:xxxx:xxxx::xxxx:xxxx:aabb:ccdd -> 33, 33, aa, bb, cc, dd.
The 33, 33 identifies the mac address as a mapped IPV6 address. The real mapping from
IPV4 address to MAC address is

Ea.bb.cc.dd -> 01, 00, 5E, bb, cc, dd with the msb of the bb set to zero. The 01, 00, 5E
identifies the address as a mapped IPV4 address. The mapped MAC addresses create a filter
to allow the (non unique sets of) multicast addresses to be accepted by the NIC.

Real IPV4 multicast traffic is not likely to be accepted by this.

Is there any documentation on how mcast is supposed to work for RoCEv2? Or an expert
I can direct questions to?

Bob
