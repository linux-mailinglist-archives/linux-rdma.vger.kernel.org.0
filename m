Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B256C50265A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346504AbiDOHs7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Apr 2022 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiDOHs7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Apr 2022 03:48:59 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9D99EC5
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 00:46:31 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 1-20020a4a0901000000b003296ea2104eso1259187ooa.13
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EtNjtJGwpl04ZNEm6w3o1bEAo92ckXt1OoEdRiYPSPw=;
        b=K00juqfWQ84cvOKz9f+/sMTjF2PKkA9K2gL6X72vTvTRNMDuDBmTJ3zrg/sAo9FEuP
         B7l+TB8QP0XOO3pmUrMbV83nyQkieo1hkg6uQrmX5y7/uqw2pPRS3XalzF9299tOWOjm
         6nJdhnnDQp8isMyDgy016lR0NcG6FcvT/ojQi6daY7chYNBYbFZv8qRhdxvil6dIWcwa
         ad9fDvbOMnIdGX4rItaOOY62Fq4BMJWDXTkGl1c8oVrEvTZorAXMlD49mWFLvdL9qnVu
         9HvrABLh/XRFDWo6UE+OSPNFCzlbmT8EWV986V/RgXhMdkROGn9fesa5++vEpuFtsZUh
         G7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EtNjtJGwpl04ZNEm6w3o1bEAo92ckXt1OoEdRiYPSPw=;
        b=1iNF8fCz76vvg/FOYuvHGrRQLqo9KoeDyCL2ma+W8UAhMms0UeYssBnvDZgT17O0Oa
         SfbM0arxTcJmAH04XwOMxgzUHrTXVHkS1XA13LW0C4u1EMOiupDWrufkk0NKd/28ub35
         3/CYd56QkBYl81LxeOfaQzTU6nhQ7PvcBg/x4GE1KORDwyGErdw/xEiO78rTT1WC4Eqr
         EPIiewA9cnTL+eiLHAfdkVQ8GgcthNU7H/Cps+wMi+3eQtH1nILwiMUIVmntGB0oC32J
         lYa8HuSVMYXNj9Tvhlmbb12eFhDD8TZOCUbW2tw9xqhLhEzIRwPR69nw86WHYorPa6Xe
         Hfpg==
X-Gm-Message-State: AOAM530K4OcxRHLAks+xDwvuXLVnQHpb6281vvwYaEdttwliI0PpP2Ph
        IR3RKXOaraPi7k7g0J9mHUQ=
X-Google-Smtp-Source: ABdhPJySKPsZrWp7ST9kx/bWm7Fe8GpnpDO3AWvj74fnBEz/5n7hYOWwugI1mbqUbzHUGxFkR0Zn7A==
X-Received: by 2002:a4a:e1c4:0:b0:321:20f6:c4d with SMTP id n4-20020a4ae1c4000000b0032120f60c4dmr1919887oot.88.1650008791060;
        Fri, 15 Apr 2022 00:46:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:447:11e9:73f1:b59c? (2603-8081-140c-1a00-0447-11e9-73f1-b59c.res6.spectrum.com. [2603:8081:140c:1a00:447:11e9:73f1:b59c])
        by smtp.gmail.com with ESMTPSA id v20-20020a056870e29400b000da4a0089c9sm1463439oad.27.2022.04.15.00.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 00:46:30 -0700 (PDT)
Message-ID: <2ddef344-5df4-dd7b-08e8-655edf7b3014@gmail.com>
Date:   Fri, 15 Apr 2022 02:46:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktest failures
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
 <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
 <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
 <20220409050405.GA17755@lst.de>
 <8ff53db7-137f-8d29-18e7-3926de255deb@gmail.com>
 <d594aef2-7728-d9f3-59eb-148a492ec8af@linux.dev>
 <faacdaa0-849b-e10f-7f27-f63bd203aaed@gmail.com>
 <789cfa63-55f9-0074-1245-ad38a6fe8bf8@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <789cfa63-55f9-0074-1245-ad38a6fe8bf8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/22 02:37, Yanjun Zhu wrote:
> 
> 在 2022/4/15 15:29, Bob Pearson 写道:
>> On 4/15/22 02:12, Yanjun Zhu wrote:
>>> 在 2022/4/10 5:43, Bob Pearson 写道:
>>>> On 4/9/22 00:04, Christoph Hellwig wrote:
>>>>> On Fri, Apr 08, 2022 at 04:25:12PM -0700, Bart Van Assche wrote:
>>>>>> One of the functions in the above call stack is sd_remove(). sd_remove()
>>>>>> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown()
>>>>>> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the
>>>>>> following comment: "Fail any new I/O". Do you agree that failing new I/O
>>>>>> before sd_shutdown() is called is wrong? Is there any other way to fix this
>>>>>> than moving the blk_queue_start_drain() etc. calls out of del_gendisk() and
>>>>>> into a new function?
>>>>> That SYNCHRONIZE CACHE is a passthrough command sent on the request_queue
>>>>> and should not be affected by stopping all file system I/O.
>>>> When I run check -q srp
>>>> all the test cases pass but each one stops for 3+ minutes at synchronize cache.
>>>> The rxe device is still active until sync cache returns when the last QP and the PD
>>>> are destroyed. It may be that the queues are blocked waiting for something else
>>>> even though they have reported success??
>>> If you remove all the xarray patches and use the original source code. This will not occur.
>>>
>>> Zhu Yanjun
>>>
>> I missed one other point. The 3 minute delay is actually not a rxe bug at all but was recently
>> caused by a bad scsi patch which has since been reverted.
> 
> I am not sure about this because wr NULL problem exists with xarray patches.
> 
> Please let us find the root cause of wr NULL.
> 
> This can make RXE more stable.
> 
> Zhu Yanjun
> 

You mean mr = NULL. And it is not happening in my tree. I have WARN_ONs looking for it
and it isn't happening.
