Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0F502634
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiDOH3U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Apr 2022 03:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDOH3T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Apr 2022 03:29:19 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EABB820D
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 00:26:51 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z2so3362449oic.6
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qgnUI9r4fJMDz+Lo8Xa85Jzwuj7q/JPRQ8V0e4xHDj4=;
        b=olVtZsZTzFC3j/4UVIP/IeRYEcm7tOiqrGrcoP17uJF24VIXRUc3QWOLR/YCIJz87w
         1HgIiNZzt7iE4scFP2UQeaJH6gruYyk34zZ+c7QlQPSSSH8D09ZTiF7J8gGO5mAvsn8U
         IgUV7MEHDcQWEs8X7zVnGL+zV3WfXkliRL4u1iuI7posfW1I2QXPqzCvVrKQyD1Rl08O
         zG/VciuI1ROgXJhbjd/aGwN7mboCSdml0ZKxm4k7NsZ4EVZ+kq2tGOLbVNm5zvh6DPlG
         wxUbs8ZNLTXkBQCB9/MoPMYpprZlEFVNiHfbiLXWv+jP23mbf9zZxISUxPI8wgip22Nx
         9F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qgnUI9r4fJMDz+Lo8Xa85Jzwuj7q/JPRQ8V0e4xHDj4=;
        b=BL61IRd26j/2gnIq2nsemq6R8OVHnU512219YQcsK5hBcci7gggiRPJOC/wM/OKPu3
         SmZBDDbqfLkCaCyItE8OmQy8t3OeK4YEGwVwVMhaff0FWFyw+bzYMsARQup++ZnOxD1X
         lNc3op2ph1+WnLi2LK89RNwVvnBH7FYrnhD7vxh6DMyOwEn2od0UVsscQkxFn7gFD5ua
         cQfPapMfbzxxUT9pi12/3IghK2KOfkrwikISZHXVKwYoHQxQ12CjqB16jtmaQgpGYWqr
         F/QQe0SOAz3ekF2N6ifyNtiYkS6cwkyOT2bq1N591/cKeCp34K2UEAKAiTxi/WnKs8yj
         G4VQ==
X-Gm-Message-State: AOAM531n0aDb6xY7VIAFi1oWEfh6/pNdD9IUN7FzCNGc9OuXv4oRGbcz
        erk8H0IEKznmFcR2PrangQ8=
X-Google-Smtp-Source: ABdhPJwGJIGciMQ1ZqQx+Qd+rYhYywZKOiaRaeeVux6LACpSWrGeLU76kkTrfGNfSar/1fsoPFsUUA==
X-Received: by 2002:a05:6808:10d3:b0:2ec:ddb3:c82d with SMTP id s19-20020a05680810d300b002ecddb3c82dmr1047881ois.250.1650007611331;
        Fri, 15 Apr 2022 00:26:51 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:447:11e9:73f1:b59c? (2603-8081-140c-1a00-0447-11e9-73f1-b59c.res6.spectrum.com. [2603:8081:140c:1a00:447:11e9:73f1:b59c])
        by smtp.gmail.com with ESMTPSA id n124-20020aca4082000000b002ecd08d8497sm877622oia.5.2022.04.15.00.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 00:26:51 -0700 (PDT)
Message-ID: <3154cd57-cde4-139b-c363-0bca5fbcf2a7@gmail.com>
Date:   Fri, 15 Apr 2022 02:26:50 -0500
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <d594aef2-7728-d9f3-59eb-148a492ec8af@linux.dev>
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

On 4/15/22 02:12, Yanjun Zhu wrote:
> 在 2022/4/10 5:43, Bob Pearson 写道:
>> On 4/9/22 00:04, Christoph Hellwig wrote:
>>> On Fri, Apr 08, 2022 at 04:25:12PM -0700, Bart Van Assche wrote:
>>>> One of the functions in the above call stack is sd_remove(). sd_remove()
>>>> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown()
>>>> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the
>>>> following comment: "Fail any new I/O". Do you agree that failing new I/O
>>>> before sd_shutdown() is called is wrong? Is there any other way to fix this
>>>> than moving the blk_queue_start_drain() etc. calls out of del_gendisk() and
>>>> into a new function?
>>>
>>> That SYNCHRONIZE CACHE is a passthrough command sent on the request_queue
>>> and should not be affected by stopping all file system I/O.
>>
>> When I run check -q srp
>> all the test cases pass but each one stops for 3+ minutes at synchronize cache.
>> The rxe device is still active until sync cache returns when the last QP and the PD
>> are destroyed. It may be that the queues are blocked waiting for something else
>> even though they have reported success??
> 
> If you remove all the xarray patches and use the original source code. This will not occur.
> 
> Zhu Yanjun
> 

I know. I am trying to find out why. For performance reasons I very much want to
make the xarray + rcu_locking patches work correctly. All the spinlock issues are
now fixed in my tree. What is left is a race in the RDMA read retry code somewhere.
I'll find it. In the process of chasing this I have found several real bugs and
I suspect a few more are out there.

Bob
