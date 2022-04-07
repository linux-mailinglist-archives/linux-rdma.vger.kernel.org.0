Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CB4F8A35
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 00:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiDGUhH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiDGUg6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 16:36:58 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751BE35770C
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 13:23:05 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id k14so5976555pga.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 13:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cXJAXKnQvf0D6SNlG4wzqYhQvhJ7wKU7ytU/sf+RbQk=;
        b=gTWdAhfa51Uf6RqK2vZDLnAPE4FgtrP7oPYBax7uEJAIE5EfXGjamWJ+dr7cwmxqO5
         qnLC5vBexFLSkOIYswqrBQJzoZy/ycMXaFxI+mF7MQ++8LQpYj59ppHnYBGN8TNZX6Lq
         6yUILEDZRP+o5AWfmqmh6IRBkfIACaB2RLMowSce8yaw+fHG9+rilXwWOehy2zNuH1e0
         I/LY2s6cAu7k/SXb5Y1AyM0N53qC77Wf98DdAQpMRNmJW3qMtVNCk/sGMjsLMcKTo/c7
         3696VqCno3XEl1GQKuFWMj6nGLs1Opu4fPwWeNCeA+dcHIfwjwxgGX36CpJXYVhepYU3
         NtGQ==
X-Gm-Message-State: AOAM530aINe/J4hebzWcTtH7yzL1zOms83Zkbsy+4xkx5q9zOzQ7Hir2
        sC9IbD3c28cdq7a5vnoIAwVSXji35PA=
X-Google-Smtp-Source: ABdhPJy+zznpkBdf1Yvmcc+s2MIDd2eMI2jeV7kWUNBIaTRJtylmNiOUVpFQnNkM8AijV2k2kck1QA==
X-Received: by 2002:a62:1d09:0:b0:4fd:8b00:d28 with SMTP id d9-20020a621d09000000b004fd8b000d28mr15929604pfd.81.1649360961135;
        Thu, 07 Apr 2022 12:49:21 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id me5-20020a17090b17c500b001c63699ff60sm10774116pjb.57.2022.04.07.12.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:49:20 -0700 (PDT)
Message-ID: <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
Date:   Thu, 7 Apr 2022 12:49:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Robert Pearson <rpearsonhpe@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
 <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 12:15, Robert Pearson wrote:
> I would say it is very possible. There was a period when the pool
> locks were switched to _bh spinlocks but that was later reversed back
> to _irqsave locks which cleaned up some failures.
> I don't know which version Yi Zhang was using. The root cause of this
> bug was caused by
> librdmacm making verbs API calls while holding _irqsave locks which I
> didn't figure out until later.

Hi Bob,

I can reproduce the issue Yi reported with kernel v5.18-rc1. Please let 
me know if you need any additional information to reproduce this issue.

Thanks,

Bart.
