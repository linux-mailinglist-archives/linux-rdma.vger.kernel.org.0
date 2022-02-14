Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA84B5C12
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiBNVFT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 16:05:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBNVFS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 16:05:18 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6AE106B37
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 13:05:10 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so20820061oos.6
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8CcDOZEvGhv8SAWXOxkSF1qzJ6KBN6h24iUEgdql2RE=;
        b=Q84p2sVY/STkh8XH2H6H35Cp1qWuEZagudaFuflpIAbR/p1vU8PeosVyMXKNB+bL7r
         o3NAk0NEjl0RewLB40KdaZRFMMA1iX3uyTMaANbj11uc4KNXD9yWMicJmnZBHnKXSuqa
         HkairqCnDTNeHC12eVH7Muj2vVLas0R9Wl/1RZXueJdHkCmZEznEcUukjJWsgWac7W5n
         deESYoae0XYC+j7fd1ZNwKp2GF9f83tmG5fB6y1SQ80zqRTZ+8S6pAZbdJ3g7vQBbS1k
         5P5rjXJ3pxukpnl8Yw7/MXu6ggpZUOMyRgmzJI6q1xA1aiQwfW1TRmu83IaXrgsPuGtu
         KMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8CcDOZEvGhv8SAWXOxkSF1qzJ6KBN6h24iUEgdql2RE=;
        b=bSvlV56NbvLMzAb7ECODzXtzVH3UL/YzGulS323wo3mVHBhtMQDBJY8U9Ivf1114pi
         POiYz/a1aU6yxQJeRC/UxmHFHg11lXEyc7gbBzJNyCz9ku3jx90fwc9oLZ+JgBQWNNvC
         /9rO3xTV8D8EIer0vkwa5AcecJPOC0jjwOx88hZRB590tjMVlDEBlj4SI7RUSLF9HHZv
         CwRRKAIlb6YtpVJgZp/iM+vYBmUSC7ETwsZ/Kbb3EZmUy8VRVyBSW8QPZCCCN8ZIhO9Q
         8iVdpaHCMUVjOJLx68M3Kbo+kxEH/AIvOQaP7Yc9Q26kV9FMxzpSlSiU3Gmjr+6B9y/8
         pFMw==
X-Gm-Message-State: AOAM530hesSvGG3woaTaqlJy3AMWzlyQPXBLJpS3Vp0UqHH5vxIbuDuR
        H0ZujtAULJ2YCwPunk1gj+84OZh4Eyg=
X-Google-Smtp-Source: ABdhPJxSos+BRxN0mm4ZdHL8Woo9IRhDc9tG+3WVWHofo6M+uHR3LKArZSPXMCgptVJEdLArZP/fxA==
X-Received: by 2002:a05:6808:493:b0:2ce:6ee7:2cbb with SMTP id z19-20020a056808049300b002ce6ee72cbbmr174637oid.233.1644868316186;
        Mon, 14 Feb 2022 11:51:56 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:6e69:6a60:fe6d:5371? (2603-8081-140c-1a00-6e69-6a60-fe6d-5371.res6.spectrum.com. [2603:8081:140c:1a00:6e69:6a60:fe6d:5371])
        by smtp.gmail.com with ESMTPSA id x19sm13009659otj.59.2022.02.14.11.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 11:51:55 -0800 (PST)
Message-ID: <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
Date:   Mon, 14 Feb 2022 13:51:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/22 12:01, Bart Van Assche wrote:
> Hi Bob,
> 
> If I run the SRP tests against Jason's rdma/for-next branch then these
> tests pass if I use the siw driver but not if I use the rdma_rxe driver.
> Can you please take a look at the output triggered by running blktests?
> If I run blktests as follows: ./check -q srp, the following output
> appears:
> 5.17.0-rc1+
You are running kernel 5.17.0-rc1-dbg+ I have 5.17.0-rc1+. I assume they are different. How do I make the same kernel
you are running?

Bob
