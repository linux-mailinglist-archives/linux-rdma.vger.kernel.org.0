Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A877DE5DE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Nov 2023 19:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbjKASHh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Nov 2023 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjKASHg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Nov 2023 14:07:36 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77111D
        for <linux-rdma@vger.kernel.org>; Wed,  1 Nov 2023 11:07:31 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-581ed744114so41007eaf.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Nov 2023 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698862051; x=1699466851; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yev63EgvyknwR7eDvTTNaFyUriQo+aKXEgf9VCftjYU=;
        b=jTDiiX6dzHPaNZ6zszK/XSykiQ80NvfRmtiJVhpOyA6EzmwL0Tz0BmOEzZnJBt2yOf
         L/+rVAyIkaEHyh7xbyIAFakK09Y69yim9+o2uCWyQ+18VRt61Sy+WG+xUSsyWJOjoobi
         hQcQq/fPYYkV45TJy/75V6xLOT0Uqob5YNPGQz3n34crpqw1kV9iiDpWYz4OuYO7Vz23
         H593FZZD62I4uiNNKl/C0sqCHf3YkxvDWyQHvG+Gaa5ufm91Pr9Gwlgsba8hG+Z9HQQr
         CF/uSsJzf8NQ//Vm0nL7vgjMVNzS4G7STyJ1J/eHAQXjoUx0DSMaaRHzltYIVsL3zyGd
         HE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698862051; x=1699466851;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yev63EgvyknwR7eDvTTNaFyUriQo+aKXEgf9VCftjYU=;
        b=N8m+WgZWyqn2HB19azSKHlvky4UbppI0ILTa0/fRWbwLsWCxhm7tGtFE72zKG3s5RL
         kCgh7olaPo2onzrvG7wdYKg/Y1BUs2j/OyIpneLWgfGZei2eXJEzjRmGDVd1BJVLQriu
         yz0E7PGItCIgQItKPtT3mKO7saKV59rsnhunU4SqR8ydckx86l/wfxv1YBKFEf677aAe
         v2C0lnkGQOV9eNMZwLN4wkMxxDk7q3YUEdFKhJDILBGDt6lY++SyuMYIuSXW3r4S0SAR
         k/eVgdft/JvTqzJlcxYeyso2E7G3yI52E4o6BYqaJK3XHlklJNsNNjMCI7/QASTnzm+c
         1xMQ==
X-Gm-Message-State: AOJu0YygIcc7xjNAQSrKK/55SjdF3+at4TtY3tVTzJktEHRD3dzRnFWq
        PuZgvnzAzCME6MWIn+3Kp7PK3RK9MTS56Q==
X-Google-Smtp-Source: AGHT+IHvTzXruw0UFxFOAudtXPefw++v3KhiHAWUga/R6dw+wVjpbAiIg0RPvHhFCYmjiYGvjx0j5A==
X-Received: by 2002:a4a:c299:0:b0:56c:dce3:ce89 with SMTP id b25-20020a4ac299000000b0056cdce3ce89mr12365621ooq.5.1698862050401;
        Wed, 01 Nov 2023 11:07:30 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:d647:5652:bce0:5754? (2603-8081-1405-679b-d647-5652-bce0-5754.res6.spectrum.com. [2603:8081:1405:679b:d647:5652:bce0:5754])
        by smtp.gmail.com with ESMTPSA id e9-20020a4aaac9000000b0057e88d4f8aesm663284oon.27.2023.11.01.11.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 11:07:29 -0700 (PDT)
Message-ID: <5b5d7549-1d1b-46ec-a6a3-baeaf4dfb179@gmail.com>
Date:   Wed, 1 Nov 2023 13:07:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: rxe mcast
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

I wrote a test program to verify that multicast is working in rxe
since there don't seem to be any pyverbs tests that actually test this.
It turns out that it doesn't work for several reasons most of which
I have fixed. But there is one that I can't figure out.

The rxe driver calls dev_mc_add() with a MAC address to add the
multicast MAC address to the device which shows up when you type
'ip maddr'. But nothing comes through from the network to the driver.
Wireshark does see the packets but they don't get to the IP or
UDP layers in the netdev stack.

If I run iperf -u and bind to a multicast address it works fine and
when you type ip maddr you get both a link: MAC address and an
inet: IP multicast address. In fact if you start an iperf server with 
the same multicast address I am testing with and just let it sit
there my test traffic also come through to the rxe driver.
So creating the IP mcast address seems critical to letting the
netdev stack receive traffic.

I tried creating a separate UDP socket bound to the mcast address
but it doesn't seem to create the required IP address.

Any ideas would be welcome.

Bob
