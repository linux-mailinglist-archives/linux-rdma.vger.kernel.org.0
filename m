Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49994C5FE5
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 00:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiB0XWY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Feb 2022 18:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiB0XWY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Feb 2022 18:22:24 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA853EA8E
        for <linux-rdma@vger.kernel.org>; Sun, 27 Feb 2022 15:21:47 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id i1so9217933plr.2
        for <linux-rdma@vger.kernel.org>; Sun, 27 Feb 2022 15:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PAxWN/Fn2Mczw45wFLz8L+Vyy3ASNUMHSwWD9KKoHkQ=;
        b=CCSvli2N/P132+mwq4N1xK4x1U2JB8vyPTd90nChcDUId0e/ra+3AeHfBBGvXUg0Uz
         3SA4zWJ6WgKzMI2cTLbWz9SzckzyvIE4YiJAtSNvyeRcrFGulIdDDjye2qW4FdwHBaq2
         2v8ziPA7AEczGFM5+dviIs3WaqicXyeKvJLD2HCV78Q+hl0p/8FFRR57vJUfevKN/nZF
         yfJ+4bIJW/VyaqOuO4Nq6qkDAlZk9mVXC/CWQn4ze1HZnRQQqtSvC2qYrALv3Kc3F8Yz
         aVPulzqYCEFuF0/8wJj8emtPOXFI1jUO2YtJrMhKLHmhtLWVgeaBeJevA5ACzIi16lRb
         e56Q==
X-Gm-Message-State: AOAM533p4A05U/retuBdSFVjm10WCnFI8ZLQAWqgCfuWm19ndlf2HCla
        GJW3Ocbpyj0i0BwGydnG4sZPUpD20Es7nA==
X-Google-Smtp-Source: ABdhPJx3hEjd67rMbJmf0135OrWhFWBYzB+s9qHiBPBu3CDQnOPnI0KAABf9pqTHWfY3++H0rAZCyw==
X-Received: by 2002:a17:90a:f8c:b0:1bc:cf23:2319 with SMTP id 12-20020a17090a0f8c00b001bccf232319mr13931101pjz.67.1646004106456;
        Sun, 27 Feb 2022 15:21:46 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id b17-20020a637151000000b00372e85c81casm8489669pgn.77.2022.02.27.15.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 15:21:45 -0800 (PST)
Message-ID: <bc4ae9f0-3028-3f27-157a-44a00632c214@acm.org>
Date:   Sun, 27 Feb 2022 15:21:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/3/21 19:04, Yi Zhang wrote:
> Below WARNING triggered by blktests nvmeof-mp/002, it can be
> reproduced with the latest 5.16.0-rc3 and also exists on 5.12, pls
> check it.
> 
> # use_siw=1 ./check nvmeof-mp/002

I can reproduce this issue with kernel v5.17.0-rc2.

Bart.
