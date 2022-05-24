Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07483533069
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 20:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiEXS1w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 14:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiEXS1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 14:27:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBC7A82E
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:27:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q8so22345140oif.13
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yCti3bx3bTaGI5zUUIkCiWE/AcKCYreNKT5qK1m1Z78=;
        b=OhioDgNn2wG6cRPTv/5qFgSh7hh3sQ9qrXfy/G6/E1ObsHRr6Fb88kzvnbqLD5SPnm
         J86/zlTVSGaMvyvhPLx3UM63jVBXNl9hoRmoCCh1lIOmPuDuBGMDhncFE9d26fQiIF3+
         ww2Z4E8kLzNKz/5qWicHb+ggDTr3hhjLObyghT/yrsbF39auIFZLUykag8RiECtPnhz/
         I9eA5vL8Xb5Iyyy0UjLONjP5A/nv9kWz4eX5zyBggeFxCA1d7Nmn2AW6n/wQ0eND8p7K
         rp+8FLkMbsi/YoCKaPco+JK5p3Jn+DOmqTLyuookDAbzEbFdyKsR/dSjXitfBz1OlZC2
         moPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yCti3bx3bTaGI5zUUIkCiWE/AcKCYreNKT5qK1m1Z78=;
        b=Wki/i5HOhZ9KZg9e4iZhhAm7EugEXgJKOaBrSXEswIjHN+cYbkURsnYsPzvH44ySY0
         ABTP2c0o4s0SjLmyHMDocoQZL4UTsIeEKXCNO8HD+HOsXRnwX21/SC/iaZal8y1NMZhr
         G9sapAf0mLTPMbcHEB9OSlZZZfWXoufYu48Q+4ePWgU+yOJApGGYbH5iQg4IQZel2RZ5
         OBg01t+y5bZmurDBBDJqztRziotXF3kDjodAvieWPWXuj6SOLTUtVSvh45VtcSNf5Pwc
         aTX81IHIpjyFltuVWSRekg4iBwPdkI25I+c4LDwKdA/JH1hokBSwJo0MmUR8H/Nb4PLm
         BuEw==
X-Gm-Message-State: AOAM533fFm3mRjEZ2mQSKzkwivk+QCdc+fiA3gjnIBTagwv1b6Y6xYKD
        0UVy3Po0IyuKuJQ7vRVnNFc=
X-Google-Smtp-Source: ABdhPJyIoYSjApvctZLttaHzJh5ESg7gahs4xdAC2oKd/k70vQ6DyOLvNwgHpy/kHmZV8U/j3NMeSA==
X-Received: by 2002:aca:2306:0:b0:32b:516:eaaf with SMTP id e6-20020aca2306000000b0032b0516eaafmr3014337oie.260.1653416870032;
        Tue, 24 May 2022 11:27:50 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id v23-20020a9d5a17000000b0060603221268sm5252337oth.56.2022.05.24.11.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 11:27:49 -0700 (PDT)
Message-ID: <dfe216f3-43c1-fc6c-d956-9454d7ab5056@gmail.com>
Date:   Tue, 24 May 2022 13:27:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
 <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
 <20220524115753.GO1343366@nvidia.com>
 <ec2369b3-4dad-30bf-35c0-d45ee0a7ce92@gmail.com>
 <20220524182615.GZ1343366@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220524182615.GZ1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/24/22 13:26, Jason Gunthorpe wrote:
> On Tue, May 24, 2022 at 01:22:07PM -0500, Bob Pearson wrote:
>> On 5/24/22 06:57, Jason Gunthorpe wrote:
>>> On Tue, May 24, 2022 at 03:53:30AM +0000, yangx.jy@fujitsu.com wrote:
>>>> On 2022/5/10 2:23, Jason Gunthorpe wrote:
>>>>> On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
>>>>>
>>>>>> Bob Pearson (10):
>>>>>>    RDMA/rxe: Remove IB_SRQ_INIT_MASK
>>>>>>    RDMA/rxe: Add rxe_srq_cleanup()
>>>>>>    RDMA/rxe: Check rxe_get() return value
>>>>>>    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
>>>>>>    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
>>>>>>    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
>>>>>>    RDMA/rxe: Enforce IBA C11-17
>>>>>
>>>>> I took these patches with the small edits I noted
>>>>>
>>>>>>    RDMA/rxe: Stop lookup of partially built objects
>>>>>>    RDMA/rxe: Convert read side locking to rcu
>>>>>>    RDMA/rxe: Cleanup rxe_pool.c
>>>>>
>>>>> It seems OK, but we need to fix the AH problem at least in the destroy
>>>>> path first - lets try to fix it in alloc as well?
>>>> Hi Jason, Bob
>>>>
>>>> Could you tell me what the AH problem is? Thanks a lot.
>>>
>>> rxe doesn't implement RDMA_CREATE_AH_SLEEPABLE /
>>> RDMA_DESTROY_AH_SLEEPABLE
>>>
>>> Jason
>>
>> First I have heard of those. Should we implement them?
> 
> Yes, it is the source of all these AH lockdep bugs.
> 
> 

OK but what is RDMA_CREATE_AH_SLEEPABLE? 

