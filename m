Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA51502D40
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355205AbiDOPrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Apr 2022 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiDOPrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Apr 2022 11:47:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D8103F
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 08:44:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id k10so8742632oia.0
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lJ4YGe0lq7Z+7Uv7mJloCJ/twaXB5+lr407lfyRaTEA=;
        b=XNoKWHjXFmifgMXmaSctMd0Z6g8SgEFIk8LcDNCTK6ZyyccBL2DKipNh1XTPfnaPuN
         Bmfeh7h5+mDo1r2K72x/iOWK7DRb0hO/5pZl1LCc0O3X9R/pfYdYnrBbMX9G77XAGqOr
         t2mntrWM7r+xFwp2T54oqVILJEkPzUIVFQ9UUgQDohqiAbtETQxrXgbz5pIwR+cMtkLD
         W+2jy3lFnEBPw+yBjjP8MmQj7j3/lZjpuwUmQCCZ0Xwm6Y7blBTBMgrZP7oGjTpSm65S
         5k7wW+UAgiqZBPhbm4v2xMoue7WWrXSxIGe2UPk+Jlq01IneyAk6c96QCcrTww4REfH9
         kjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lJ4YGe0lq7Z+7Uv7mJloCJ/twaXB5+lr407lfyRaTEA=;
        b=h5ueqe1Jv0vTq6BhCLIJy6NiQ87EvWaATlsBukFJIZwJ/Ab2LODqN62/CUusCNPBZI
         2OVgXNf9TS1LuDsA0Arp+zXD77BBOgsJDKZ/hXXZ4CQEXFKF+3Y3tr7X+08c2/oFwHUb
         Z3eCtQVi+zl+GQjljDGpaJsdKrrwaf5PQMA/Ayh5LAAPDczmWTM6WaH8F9c6Y+7tmH3h
         Ynxi/AZ1y/rl+WPw/JdTBHSpA8D0SSao6lHyAgNxJeo4ltStoWQnoAfLVji3+wsxqy4/
         8sO/yFYytjQqpQxLa5teYE3COWa3aFYwMswQoKZPlt41VeLBA1TN2gZ+AvlIHijJ5ysp
         jw8A==
X-Gm-Message-State: AOAM533e8zsoXw35ydcH+O4L62UQmsrIGss1c98E+EBa1CpH5kGdqaQl
        lj1NYgY7sia/17Rzl8MihcU=
X-Google-Smtp-Source: ABdhPJzg2LDtk67t2Rf9YYmGRsSQLJEgwTL2LkAiXs7AVH09NoEYJdtWf4yxBCxbqvXxeaGlAgzi2w==
X-Received: by 2002:a05:6808:1b25:b0:2da:32ff:ab73 with SMTP id bx37-20020a0568081b2500b002da32ffab73mr1823809oib.285.1650037469898;
        Fri, 15 Apr 2022 08:44:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8657:ca12:c38f:1795? (2603-8081-140c-1a00-8657-ca12-c38f-1795.res6.spectrum.com. [2603:8081:140c:1a00:8657:ca12:c38f:1795])
        by smtp.gmail.com with ESMTPSA id j126-20020acab984000000b002da77222b7dsm1230415oif.22.2022.04.15.08.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 08:44:29 -0700 (PDT)
Message-ID: <10915d1f-8ca2-434b-a830-543dd8c3a7a2@gmail.com>
Date:   Fri, 15 Apr 2022 10:44:28 -0500
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
 <2ddef344-5df4-dd7b-08e8-655edf7b3014@gmail.com>
 <0eaf11a9-7933-8ff9-5c12-94ca6e2df7aa@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <0eaf11a9-7933-8ff9-5c12-94ca6e2df7aa@linux.dev>
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

On 4/15/22 02:59, Yanjun Zhu wrote:
> 在 2022/4/15 15:46, Bob Pearson 写道:
>> On 4/15/22 02:37, Yanjun Zhu wrote:
>>>
>>> 在 2022/4/15 15:29, Bob Pearson 写道:
>>>> On 4/15/22 02:12, Yanjun Zhu wrote:
>>>>> 在 2022/4/10 5:43, Bob Pearson 写道:
>>>>>> On 4/9/22 00:04, Christoph Hellwig wrote:
>>>>>>> On Fri, Apr 08, 2022 at 04:25:12PM -0700, Bart Van Assche wrote:
>>>>>>>> One of the functions in the above call stack is sd_remove(). sd_remove()
>>>>>>>> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown()
>>>>>>>> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the
>>>>>>>> following comment: "Fail any new I/O". Do you agree that failing new I/O
>>>>>>>> before sd_shutdown() is called is wrong? Is there any other way to fix this
>>>>>>>> than moving the blk_queue_start_drain() etc. calls out of del_gendisk() and
>>>>>>>> into a new function?
>>>>>>> That SYNCHRONIZE CACHE is a passthrough command sent on the request_queue
>>>>>>> and should not be affected by stopping all file system I/O.
>>>>>> When I run check -q srp
>>>>>> all the test cases pass but each one stops for 3+ minutes at synchronize cache.
>>>>>> The rxe device is still active until sync cache returns when the last QP and the PD
>>>>>> are destroyed. It may be that the queues are blocked waiting for something else
>>>>>> even though they have reported success??
>>>>> If you remove all the xarray patches and use the original source code. This will not occur.
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>> I missed one other point. The 3 minute delay is actually not a rxe bug at all but was recently
>>>> caused by a bad scsi patch which has since been reverted.
>>>
>>> I am not sure about this because wr NULL problem exists with xarray patches.
>>>
>>> Please let us find the root cause of wr NULL.
>>>
>>> This can make RXE more stable.
>>>
>>> Zhu Yanjun
>>>
>>
>> You mean mr = NULL. And it is not happening in my tree. I have WARN_ONs looking for it
> 
> Why you said that you can not reproduce this problem now?
> 
> Please check your mail. I remember that you can reproduce this wr NULL in your host.

Yes I did see it before but not with the new pool patches. The whole point of the patch series I
have been working on for the past month was to clean up races in shutdown and cleanup code.
These were demonstrated by colleagues here at hpe who are running lustre over soft roce.
I looked at the shutdown code and saw that the whole design was flawed. We were using
kref's to track reference counts on MRs and QPs etc. but always returning to rdma-core
regardless of the reference count. rdma-core having no visibility to our references
then deletes the object fairly soon after that while we are still trying to process late
arriving packets. One of the features in my tree is to use wait_for_completion() in the
return path to rdma-core and pause until all the references have been dropped.

I really don't see the point of debugging the old code because it is just wrong wrong wrong.
It will never be stable under heavy load.

Bob
> 
> Please focus on this problem. This can make RXE more stable.
> Let us find the root cause and fix this problem ASAP.
> 
> Thanks.
> Zhu Yanjun
> 
>> and it isn't happening.
> 

