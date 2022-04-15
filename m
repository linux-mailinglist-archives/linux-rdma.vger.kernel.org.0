Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA29502638
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiDOHbo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Apr 2022 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDOHbm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Apr 2022 03:31:42 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A323B8217
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 00:29:15 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so7467559fac.7
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=azXV3BtC/Ojix/p1H0oiuUBj2nroGRqXI6DhkYMhLws=;
        b=hxjs6EuGT2plnKUOZkHTW3xb+QdQ5a4KvfRcw/F+Ot+RtPPY4TOBOWEKd1QLoqadcn
         bjzIE23RpCgqB+1FQDxY/1ZEo/KC4v4ypETWswdg26HbuvMo2T9oyoIRRohIEwFMmAto
         sD/2XlbyX1dEJDFn+uhCMuBrbCjkbny5D6rmAOopFeqe95A5Ns8vPXiq5nMd1oygCqW7
         3DbmgXM0FLHhPhM5aBYOfbLO5dHKgAey4gu5CsudqfXYz1vG//02wiUlZTrwfbtLnNOF
         pcMK8LtxJ3IqCsKT3f/cjMB0ZycHwaQdlkGuu1Tn+I/dCiZzMFFtv4c96ftwRJzU05t4
         kfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=azXV3BtC/Ojix/p1H0oiuUBj2nroGRqXI6DhkYMhLws=;
        b=Un3u0TIL4eaYRnRgEWVPuxIe6pAxSkYeT6OZFTPTwep+sGsAb8d4KvLKWnXbH5crDn
         +jc8/gx5hpl1d3yCUxCvTjhMQAhmu1iFqkR9u8NXdpKRu4lBYlhkMc9p0/cU3GP5fKwk
         IF4gg67QxOzOeqBu0Ec4ssouw7gL6FfUb53xWEatkRzy+W/ExpmEnuB01emzIB6lk74D
         3GVf6gRklkfRzk7pM8T3Lzz7EWp9PcJM83aI/MAJ02+9aDptUQt2F/Krgv427hUnHZAf
         ZacUkHGUXNeewAPJNtQBX6z0fw82AiAlLCQ0aaHUym8bAjsfKmZXmWpR6E8XOtZPA3ZH
         8pog==
X-Gm-Message-State: AOAM531+PChr0wa5eajg9P/BzeM1xmqH3VUPY/MvvsCA/QfM5j55veVY
        0b2LZukMkyBvj1tbuVSNIy8=
X-Google-Smtp-Source: ABdhPJwoRv5DVdcvmRysDXBqlxXNTqvoX3N+9iG4PhKwWP8hDRhQz0VskTZ+Z0G6wU3AVPUyq7y0SQ==
X-Received: by 2002:a05:6870:9589:b0:dc:4640:ef89 with SMTP id k9-20020a056870958900b000dc4640ef89mr919984oao.175.1650007753886;
        Fri, 15 Apr 2022 00:29:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:447:11e9:73f1:b59c? (2603-8081-140c-1a00-0447-11e9-73f1-b59c.res6.spectrum.com. [2603:8081:140c:1a00:447:11e9:73f1:b59c])
        by smtp.gmail.com with ESMTPSA id t22-20020a4a8256000000b003332a0402f5sm908180oog.23.2022.04.15.00.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 00:29:13 -0700 (PDT)
Message-ID: <faacdaa0-849b-e10f-7f27-f63bd203aaed@gmail.com>
Date:   Fri, 15 Apr 2022 02:29:13 -0500
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

I missed one other point. The 3 minute delay is actually not a rxe bug at all but was recently
caused by a bad scsi patch which has since been reverted.
