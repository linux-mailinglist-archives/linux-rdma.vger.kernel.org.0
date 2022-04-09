Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51134FAB02
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiDIVtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiDIVtV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 17:49:21 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC5E3A
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 14:47:13 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id s10so3349147plg.9
        for <linux-rdma@vger.kernel.org>; Sat, 09 Apr 2022 14:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/CTrF4vvavVFAeUqAYmj5Sy9DUxAsKRx8kichp0U/g=;
        b=UW8uvZ3G50DDVWy7BPYrN71erHGCvZnriBZpnTPAMFusso/IcDahHyfACw/gpCpeJY
         b0woD6CL+fDdghZE3DkXWtqPfEdPmB9W7pKVJQjVse2kTQcP61S6CCD6PlMcY3J4l999
         0ZL45RTPBkhl15JW4H/QdOp7sYAh9+y5ekngZ7mx5xcjZbOWIdszyMrfQ5oRdPIAYaQw
         O2bgTE6BcfXlZwziQqxHlocjenVleAtddtWaXGmUGfSglDIMFJjL27h029mmeDbNuCxd
         kMRcBZiRlXv5Jk3sC9pXMLwZ6kIdiL7yeu4VF9gSxHQtLY8NIItyAhxYXhk4eBw9A7k9
         mUyg==
X-Gm-Message-State: AOAM530d8PQ4ACqNI6F99xESPxB76WThd5p3D9KOUU9po5RbQjcUyot8
        sRn25o8Cmf4lmD78/f3/t8kAu3m/lH0=
X-Google-Smtp-Source: ABdhPJwtI4vyS49YjBWJdwtQYvIuMcjcrAKQbFoKR3tJfhX5Jyq+ITesCnYnNmzKaJE2Drp2vYthpg==
X-Received: by 2002:a17:902:8306:b0:14f:a386:6a44 with SMTP id bd6-20020a170902830600b0014fa3866a44mr25255529plb.140.1649540833236;
        Sat, 09 Apr 2022 14:47:13 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm13990167pgp.22.2022.04.09.14.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 14:47:12 -0700 (PDT)
Message-ID: <ca5cf784-702b-ebf8-2736-cf1e89a09ae5@acm.org>
Date:   Sat, 9 Apr 2022 14:47:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktest failures
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
 <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
 <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
 <20220409050405.GA17755@lst.de>
 <8ff53db7-137f-8d29-18e7-3926de255deb@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8ff53db7-137f-8d29-18e7-3926de255deb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/9/22 14:43, Bob Pearson wrote:
> On 4/9/22 00:04, Christoph Hellwig wrote:
>> On Fri, Apr 08, 2022 at 04:25:12PM -0700, Bart Van Assche wrote:
>>> One of the functions in the above call stack is sd_remove(). sd_remove()
>>> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown()
>>> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the
>>> following comment: "Fail any new I/O". Do you agree that failing new I/O
>>> before sd_shutdown() is called is wrong? Is there any other way to fix this
>>> than moving the blk_queue_start_drain() etc. calls out of del_gendisk() and
>>> into a new function?
>>
>> That SYNCHRONIZE CACHE is a passthrough command sent on the request_queue
>> and should not be affected by stopping all file system I/O.
> 
> When I run check -q srp
> all the test cases pass but each one stops for 3+ minutes at synchronize cache.
> The rxe device is still active until sync cache returns when the last QP and the PD
> are destroyed. It may be that the queues are blocked waiting for something else
> even though they have reported success??

Hi Bob,

After having taken a closer look at del_gendisk(), I agree with what 
Christoph wrote above. Please revert patch "scsi: scsi_debug: Address 
races following module load" locally when running blktests. See also 
https://lore.kernel.org/linux-scsi/5fb68dbd-ae0e-6230-8f9f-dd6df5593584@interlog.com/T/#m47a23ffd5ce68b8183100444d6e711b6b4aba393.

Thanks,

Bart.
