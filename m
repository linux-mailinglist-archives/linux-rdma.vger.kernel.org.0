Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBC51EB5C
	for <lists+linux-rdma@lfdr.de>; Sun,  8 May 2022 06:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiEHERX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 May 2022 00:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiEHERW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 May 2022 00:17:22 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C17667
        for <linux-rdma@vger.kernel.org>; Sat,  7 May 2022 21:13:33 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id k1so11040741pll.4
        for <linux-rdma@vger.kernel.org>; Sat, 07 May 2022 21:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Qk4mmyoNPmQOFOEdNrOAi375TkFGSkxDTNsMnGpyv/c=;
        b=hCYfTjSCoKLZ0xJ5oJ/iVhdtoHCAoJwxR96ULZzNOeXS2QHKGQNjR99FT79jSm69Gq
         l32O2bjw5nC2M80AXOC5r6ohmf9y0UiInGVU7erx3VskxroXtjoDxIOerhmWHRoF5qZm
         74PyKjS4bKCvngXjPLrrvS+CmIqm2vsWnJdMsSCKQKBKW8tMO4eDKCy1j8B5/F4A5Cbd
         +sAEGexU7qiXwJ3mImg8+Su05FtoiSyhONXgTShT3IPBuRtohp1C14BZOoVEhIaAXJ32
         yqv6nrpLMTs6o1Nl4dYFTBPf4CJcwd8Tq4z/TmXYq9FcrnG5APENuEatPCyWDO7RcuyF
         EDUQ==
X-Gm-Message-State: AOAM531tNDNtRbZVBCeW/jRZDJ2VcDPgcX+QWlxgLqRouMZGmbSsD4gp
        yIzrjhCO15sltJdErxg9nMQ=
X-Google-Smtp-Source: ABdhPJxhQNq67c6T7/hDQGa9qPhW8A5CSLUGszgi6Kb3zGK+QvDQWnUlQXkSLHNGHK6Wd/BM0qJ8kQ==
X-Received: by 2002:a17:90a:cc0a:b0:1dc:9a3a:6eef with SMTP id b10-20020a17090acc0a00b001dc9a3a6eefmr20197593pju.127.1651983212744;
        Sat, 07 May 2022 21:13:32 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902b48900b0015e8d4eb21asm4340911plr.100.2022.05.07.21.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 21:13:31 -0700 (PDT)
Message-ID: <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
Date:   Sat, 7 May 2022 21:13:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: Apparent regression in blktests since 5.18-rc1+
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
Content-Language: en-US
In-Reply-To: <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/7/22 06:43, Bob Pearson wrote:
> The hang I was showing was for siw not rxe. rxe also shows similar hangs on my system.
> The siw run was vanilla rdma-linux without any patches.

Hi Bob,

If I run the SRP tests against the rdma for-next branch then I can 
reproduce the hang mentioned in a previous email.

If I merge Linus' master branch into the rdma for-next branch then the 
SRP tests pass with the Soft-iWARP driver and also with the soft-RoCE 
driver.

I think this shows that the root cause of the hang is in the rdma 
for-next branch and not in the SRP tests. Maybe a patch from the master 
branch is missing from the rdma for-next branch?

Thanks,

Bart.
