Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976114FAB00
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 23:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiDIVpt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiDIVps (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 17:45:48 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E1C0E
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 14:43:40 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-deb9295679so13302503fac.6
        for <linux-rdma@vger.kernel.org>; Sat, 09 Apr 2022 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+R67a4my/0IO/JLPem9R5VNzP/lqtwnHAXLo67C9u8k=;
        b=N02byGdoBRVHtf05dSxEe4NAAPTAri1nEAZbgmNk8t9r+zcb5bvQmQ6NUj84CsnZNT
         gqR/3mxYkPnWWBgYOTa7dUxyJoQ1oJzr9p7wBqIAYOJLajqyK5V2WH7omXjijExWM+CD
         rHy3UTw+96WWhY/Q3R8bsl6F33ispjQU+NMN396LiuDHwQhrqABkB3XcJWuxRy6UCUEM
         pU2PuuR5IDyJQo1mmslz4G5nduJiX1g5pe+fSKGfXx8RIx0gkQPOVyirvn2GZhkyBdBD
         FfwtZI25PuxN3OnZO8u4XG/bLnvo52xNxCDTUt+So8JXVtrIqn2gfc0DkF/K+uapylt2
         L6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+R67a4my/0IO/JLPem9R5VNzP/lqtwnHAXLo67C9u8k=;
        b=FPmwqrG7XgIt5/kpcvB/2DNsIfwfazLc2J1raUkdodDt02wW8zOUZPk0zTQhohKzpO
         BFUcPa9p+4UnbNzwXRwoNjUbtMuz5LT1c5MyntA0U+q4cEn1sCqVKx/mFcbZxo6oldZK
         1e6anDmfXMmtUow+TS4CQAQA9s3OKyiTj8Zlsa3swiMuMv9U6h6b6C39iwDg8j/AyDLT
         x70LSjAHQ6PXBpL/qJ/w0NdRWsk4NCgc6+/RyYZsZrom49+AB2v6O/lNIwf7vzv1L1ti
         XLrGJaJyC7WYsUR8A+U9QFOkhQNZFnD7+LYKThj0zGOhzunDC2p7uDZoYgTokdhBPdsw
         /FMg==
X-Gm-Message-State: AOAM533vpew/y7UPVkv9AmeuH1J/ZMU9C6TRl2zJJAi++FgiSffUh23T
        eZflNaD8r++q62dWgjtxa4Q=
X-Google-Smtp-Source: ABdhPJxOc7Sm/WgdukjfO2Y604PFmAzrWyqYtdlY6YXCcLyzEy7zYWHWY3x1u6tFN8PD4AKe3N+VJA==
X-Received: by 2002:a05:6870:d182:b0:e2:a20c:707f with SMTP id a2-20020a056870d18200b000e2a20c707fmr2599951oac.289.1649540618953;
        Sat, 09 Apr 2022 14:43:38 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:cef7:555e:8ef2:9897? (2603-8081-140c-1a00-cef7-555e-8ef2-9897.res6.spectrum.com. [2603:8081:140c:1a00:cef7:555e:8ef2:9897])
        by smtp.gmail.com with ESMTPSA id t4-20020a0568301e2400b005c9781086d9sm10305894otr.9.2022.04.09.14.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 14:43:38 -0700 (PDT)
Message-ID: <8ff53db7-137f-8d29-18e7-3926de255deb@gmail.com>
Date:   Sat, 9 Apr 2022 16:43:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktest failures
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
 <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
 <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
 <20220409050405.GA17755@lst.de>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220409050405.GA17755@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/9/22 00:04, Christoph Hellwig wrote:
> On Fri, Apr 08, 2022 at 04:25:12PM -0700, Bart Van Assche wrote:
>> One of the functions in the above call stack is sd_remove(). sd_remove() 
>> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown() 
>> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the 
>> following comment: "Fail any new I/O". Do you agree that failing new I/O 
>> before sd_shutdown() is called is wrong? Is there any other way to fix this 
>> than moving the blk_queue_start_drain() etc. calls out of del_gendisk() and 
>> into a new function?
> 
> That SYNCHRONIZE CACHE is a passthrough command sent on the request_queue
> and should not be affected by stopping all file system I/O.

When I run check -q srp
all the test cases pass but each one stops for 3+ minutes at synchronize cache.
The rxe device is still active until sync cache returns when the last QP and the PD
are destroyed. It may be that the queues are blocked waiting for something else
even though they have reported success??
