Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D952712501
	for <lists+linux-rdma@lfdr.de>; Fri, 26 May 2023 12:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjEZKoL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 May 2023 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEZKoK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 May 2023 06:44:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A4E12F
        for <linux-rdma@vger.kernel.org>; Fri, 26 May 2023 03:44:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so4067885e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 26 May 2023 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1685097846; x=1687689846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsQxO8IPaN8nlkq2Xhl3/vTTB1iuV7FAGBCEMX0YyP4=;
        b=a/Dxr0an09yn6eTERfXRH+v8faaaU6lJpIpaMVdr8uhHgGPIFcSHLjgyJP0Vs9vG3X
         CI7CvyUojqeAfJkJ6DzM8lVf+D7nruedj2h/O4/cJ6MP1iQEUxZcP/SUtjVxubwB+PHl
         OkrRiXzOYbQahNp6wZsjc944QrRWhl9c1yRa+ptE0DNk6jCj+mqRbAh8NRGdWajyTcQv
         /nMjWZzEDwCU3H/txJSK6o3Zb8IMhF9k44d3DYWlpn7OGbptrtAlsPOKp/PDH+zBorEI
         FLlQmIKKJOViWnURGXVbGY5pCbOmioounsv+72zQR/DZ5qTYnzkibGOGV2pUPmbH/HzF
         JnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097846; x=1687689846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsQxO8IPaN8nlkq2Xhl3/vTTB1iuV7FAGBCEMX0YyP4=;
        b=XUD2P4nx1aMvEZ12WtLXZhSKBJnGfjF3fiwtvZ0sdSRiuBO1P/BCalGXXGIRotTaMx
         2nrupPZh5GyZYQX7bNX5ULBbTYy+bsBEafiLkqQDYx4BVL4hN6SyyJ8t1OFl4j4J/43B
         dfHcrXkSHRUp3lq0R+XYMhEZEUJPG5PkcElNFAfvQLHezUxLzP8YvZvyGbXeP2mNzoTY
         cgR4JuivEUaaN3SlRifo6biUa95RhC4orGhyb0UDJcJe6LFUDIJoyXPex4J5YJ1hUHK1
         sXCo02npRw+N5oC3A99KsisKcbuM2TzGzaSbRMKbnn71U3W3ahbE/AnqgpjeN54NgTd0
         bOQA==
X-Gm-Message-State: AC+VfDw+2Yf64GxGKn1B9wyYKNVDbZGmBdj+lvEzDobt6lrRoYgb85ZN
        IdHrvknqy2A/tBO/3mPPCuB6IA==
X-Google-Smtp-Source: ACHHUZ7L0BkNcRhWjehagPKWH/0YUPeR2EChh9bPq+mRlKo9vIF2GGsqEqyEcn8B+nVasosRFerNoA==
X-Received: by 2002:a05:600c:2196:b0:3f6:3da:1603 with SMTP id e22-20020a05600c219600b003f603da1603mr1158694wme.26.1685097846338;
        Fri, 26 May 2023 03:44:06 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b003f42328b5d9sm4792425wmj.39.2023.05.26.03.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:44:05 -0700 (PDT)
Date:   Fri, 26 May 2023 12:44:04 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
        ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
        hawk@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Fix perf regression: remove rx_cqes,
 tx_cqes counters
Message-ID: <ZHCNdEez3yN0Vccb@nanopsycho>
References: <1684963320-25282-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684963320-25282-1-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, May 24, 2023 at 11:22:00PM CEST, haiyangz@microsoft.com wrote:
>The apc->eth_stats.rx_cqes is one per NIC (vport), and it's on the
>frequent and parallel code path of all queues. So, r/w into this
>single shared variable by many threads on different CPUs creates a
>lot caching and memory overhead, hence perf regression. And, it's
>not accurate due to the high volume concurrent r/w.
>
>Since the error path of mana_poll_rx_cq() already has warnings, so
>keeping the counter and convert it to a per-queue variable is not
>necessary. So, just remove this counter from this high frequency
>code path.
>
>Also, remove the tx_cqes counter for the same reason. We have
>warnings & other counters for errors on that path, and don't need
>to count every normal cqe processing.
>
>Cc: stable@vger.kernel.org
>Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
>Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
