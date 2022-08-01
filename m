Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0143158715B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 21:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiHATYy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 15:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiHATYy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 15:24:54 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C12B628
        for <linux-rdma@vger.kernel.org>; Mon,  1 Aug 2022 12:24:53 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10cf9f5b500so14857992fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 01 Aug 2022 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AeiUldSme5BmyJUGprY521ecgP1gxL+CjAAV/fDcr7U=;
        b=il6Xro7lU1kDl6L8PBQ+2S4ceNd9buelQ4ysw8LxRdEGQu9RHXYNzmHvrTjb7x3AU2
         l6XSFfSbciaGSm62Y/Ean7pX5uQPe3FZNH8rFW/1i398/i4BM37wWfrtz1dITB2vre/p
         2gygq+2mRRl7iqqaWvbObUGQxAL3OGjvGO3B7klY6YwdAunMrBeUQZlfNs7aqvI2cWW8
         pgEucJsAGIonK0oMvuMlVB8WG+M7bDJs2bQOHnclnRX7T7fxbXNSR66n8x3trdqfQ1YD
         idb4u6C2IU0BWbEzOVn7re1tSauQmDJcsPfiyh3rdSm+tUxNzP13wiMXt1fiuqMaCEVo
         zORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AeiUldSme5BmyJUGprY521ecgP1gxL+CjAAV/fDcr7U=;
        b=VOirxKoqr9zLmEOH0VvzE0Ra2ad0AH1MPkCDi8PgBbwu3AzU/kixMWjcLcj5+hcLJa
         WJqDf2XY/Ajs7Qp/PwCderYMZTw2fG5vdgbGKMJTx1OhODrDd/OdDuP/PGzegBBfVjtt
         auQ30EdZlaXrl+W7gSUbZt9dPGUjizBWtZluoIiw6b8bD/rG7jhDZcc5AshGAEoYRowK
         33Z2em7EL+vx6pQHSrW5PWt63ciAKFNTauzut8/HmwOOmjl5c/v1UP4lQS9LAALlsaIJ
         fMXA2zMh6FgqByJ59weBLSxif9Po3Xo8PORFRhNhbFQrxDF1PoDYuDUZ3GtfnPqTHsN1
         g40w==
X-Gm-Message-State: ACgBeo2+qIdXSlcV4sTaYM07nY8ux0uJPmiRAbo7PMLPYO0x34QGz3Sm
        czJaNR+0+B87R+grPAbpha4=
X-Google-Smtp-Source: AA6agR7XbD78f2ErPytzRcCPnWecr/mLyhaU8tgFIvkh4tM60dfbbPNtyf1eA/hdG5krBZpIUTJPHQ==
X-Received: by 2002:a05:6870:d38c:b0:10e:daa7:da69 with SMTP id k12-20020a056870d38c00b0010edaa7da69mr73445oag.61.1659381892531;
        Mon, 01 Aug 2022 12:24:52 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fad3:624f:1d1b:8d14? (2603-8081-140c-1a00-fad3-624f-1d1b-8d14.res6.spectrum.com. [2603:8081:140c:1a00:fad3:624f:1d1b:8d14])
        by smtp.gmail.com with ESMTPSA id w190-20020acaadc7000000b0034012d60934sm680497oie.46.2022.08.01.12.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 12:24:52 -0700 (PDT)
Message-ID: <e737cce4-f7e1-aca1-8355-c8c3e7013449@gmail.com>
Date:   Mon, 1 Aug 2022 14:24:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND for-next v6 0/4] RDMA/rxe: Fix no completion event
 issue
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Cheng Xu <chengyou@linux.alibaba.com>
References: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
 <YuQ5iYNSOSyVLZsz@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <YuQ5iYNSOSyVLZsz@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/29/22 14:48, Jason Gunthorpe wrote:
> On Wed, Jul 20, 2022 at 04:56:04AM -0400, Li Zhijian wrote:
>> No change since v5, just resend it via another smtp instead of
>> Microsoft Exchange which made patches messed up.
>>
>> It's observed that no more completion occurs after a few incorrect posts.
>> Actually, it will block the polling. we can easily reproduce it by the below
>> pattern.
>>
>> a. post correct RDMA_WRITE
>> b. poll completion event
>> while true {
>>   c. post incorrect RDMA_WRITE(wrong rkey for example)
>>   d. poll completion event <<<< block after 2 incorrect RDMA_WRITE posts
>> }
>>
>> V4 add new patch from Bob where it make requester stop executing qp
>> operation as soon as possible.
>>
>> Both blktests and pyverbs tests are passed fine.
>>
>> Bob Pearson (1):
>>   RDMA/rxe: Split qp state for requester and completer
>>
>> Li Zhijian (3):
>>   RDMA/rxe: Update wqe_index for each wqe error completion
>>   RDMA/rxe: Generate error completion for error requester QP state
>>   RDMA/rxe: Fix typo in comment
> 
> Bob are you Ok with these?
> 
> Jason

yes. I had reviewed these a while ago and suggested a change which he included.
I'm fine with this.

Bob
