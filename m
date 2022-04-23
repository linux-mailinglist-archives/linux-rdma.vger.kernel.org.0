Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815B50C644
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiDWB5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 21:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiDWB5p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 21:57:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC07E4B
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 18:54:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t15so11010917oie.1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=p7vjC567BURP8YKsIzj2NxBh4cGKgwagWxOhdvW3eo8=;
        b=cs5lsrjhx6QXVYkA9C8DrRm3BUjaXhH/jehrk2iCOsWmhICQeTUwNLEe6MiBKFV0XI
         pXy1G8Vd/yuDCSvl7+svjxmWJMoWV7OkO5ZfCwTA9fGTbE4pdJ9bL7pTMhyXkRFPIv+J
         Qw5NwDOCn6gJB9Wk+HiD/eYbm+WyiD/oAOtGBzTgaiZo2HL2qY/QVwl9Z19QlQRjHasY
         QHkjqge3HTnQmpOjk6Ng/Y38OH2H3JvHjqz2pmRtdwbkA9QfdcoROXxiU1lvRzX212ew
         pdbxAJtidsqxdtpVoM5l36EyqP9CCxPO1MVgsmYXMjrFxP6s4oNnECCjuBrp9wZUqNSh
         Braw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=p7vjC567BURP8YKsIzj2NxBh4cGKgwagWxOhdvW3eo8=;
        b=cD8Wqt2z1yF0zMmjdmhSo57TGlJk3K6ZsWvLBoc70DDAD5iSzhR8UwCkjhMiopGnJe
         umYqtdS2jFBH7mHRHw3hHhXl1qyHUx5ErMb/w6nRdW+oj5jg7Jvkt+BZqtGxfA4nVfdv
         E1btWfelnH9qvI2FyGerfML/yvBqdvms0GNzgzChaak5fvGBfjU8uuGvtPI74dLdh3TV
         jEATUQ0vbtzR2g+5P/a8Dvgf6om/8UcRZCY8wvb2nMhjDpxmw0Zv6mEEHopwqAW+ISV1
         ed9yYrwkhP7WyavbfInLJ1CyMucCZwtm6jDEK9yuqrMTSA88hUSnQA5ocTbdeaWqZxBj
         EJgg==
X-Gm-Message-State: AOAM532rNKbMBHIv/mXvYoxf6Ib5nIvpFEEoTQGnh/cyXMGyLHa4QDlT
        tOJ7wR9pV1Dk3E1qNXPoD/4=
X-Google-Smtp-Source: ABdhPJxmOQfim2m0ldQSmihxqSoVS7m9W++gbY0Ukz5h5b8+gOeojVvjCFLqAlcKQ8fi1BQuoi3tiQ==
X-Received: by 2002:a05:6808:17a3:b0:324:fcbf:3142 with SMTP id bg35-20020a05680817a300b00324fcbf3142mr1314494oib.5.1650678889752;
        Fri, 22 Apr 2022 18:54:49 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e508:94f4:5ee:8557? (2603-8081-140c-1a00-e508-94f4-05ee-8557.res6.spectrum.com. [2603:8081:140c:1a00:e508:94f4:5ee:8557])
        by smtp.gmail.com with ESMTPSA id k15-20020a4a2a0f000000b0033a34a057c8sm1457554oof.11.2022.04.22.18.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 18:54:49 -0700 (PDT)
Message-ID: <c362b55f-64c2-4eda-8acf-c389b6435bcd@gmail.com>
Date:   Fri, 22 Apr 2022 20:54:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: bug report for rdma_rxe
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
In-Reply-To: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/22/22 16:04, Bob Pearson wrote:
> Local operations in the rdma_rxe driver are not obviously idempotent. But, the
> RC retry mechanism backs up the send queue to the point of the wqe that is
> currently being acknowledged and re-walks the sq. Each send or write operation is
> retried with the exception that the first one is truncated by the packets already
> having been acknowledged. Each read and atomic operation is resent except that
> read data already received in the first wqe is not requested. But all the
> local operations are replayed. The problem is local invalidate which is destructive.
> For example
> 
> sq:	some operation that times out
> 	bind mw to mr
> 	some other operation
> 	invalidate mw
> 	invalidate mr
> 
> can't be replayed because invalidating the mr makes the second bind fail.
> There are lots of other examples where things go wrong.
> 
> To make things worse the send queue timer is never cleared and for typical
> timeout values goes off every few msec whether anything actually failed.
> 
> Bob

This looks like an unholy mess. The reason I was looking at it is because Lustre
on rxe doesn't work at the moment and the problems were traced to retry flows (on a very
reliable network) caused by stray timeouts. We see local_invalidate_mr operations
getting retried multiple times and not all of them succeed because the caller
is remapping the fast MR in the mean time and changing the rkey.

Bob
