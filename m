Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375784FA017
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 01:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiDHX1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDHX1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 19:27:20 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867811140
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 16:25:15 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so7890245pjb.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 16:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=34HS9uEdYLsxX3U8EmPo0HX9UTdoTaqxltnEVwj7z6k=;
        b=nBWHZaSm0WDxER2hzo/qr9c9ExMuiN7Lo4zJBpSlAsBmi1OTOohFYnVmQHDPw9c52A
         X5rxyflC9vDo5DTpaugf0A38I3xbP9QIt9qALF6+9BNCnWj3299ZXL2oIzRLohE1tuhQ
         4DQqSe+jSjBkafgtIO8pPOm5L20o2AcGR2hn93rMANCYxoIyiE1m/5/LgsVC804Y4OBE
         cZw6VjZLrNXz5yGyRnyt8K/Ak3toAPE404RUNxP57zEql2KUQrCuZt9cPx+cL3t3vGFL
         NOu6SMN8fAeOHV3EH4AFIWuSkkAow/rSZwCEf2sJPAOZDGVCiP7odxmS8YTYRwExcfrR
         S+EA==
X-Gm-Message-State: AOAM532EFa++0/c5jfjSpJZEFMoPgfG9UjfayEUWWXJN+z2rUjP55Wur
        5rLlmvD3h12RX/DfOtK/SsE=
X-Google-Smtp-Source: ABdhPJzcQnn5hiizeN28jzl/nrX0kR9VSgTt0C93+Yz8Ca38ODld6GfS0nFmVt+q5DVpVCvuTkpzJQ==
X-Received: by 2002:a17:902:f54a:b0:156:5f53:5f48 with SMTP id h10-20020a170902f54a00b001565f535f48mr21705338plf.29.1649460314759;
        Fri, 08 Apr 2022 16:25:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e19-20020a637453000000b003821bdb8103sm22663824pgn.83.2022.04.08.16.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 16:25:13 -0700 (PDT)
Message-ID: <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
Date:   Fri, 8 Apr 2022 16:25:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktest failures
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
 <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
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

On 4/8/22 15:50, Bob Pearson wrote:
> Actually it doesn't hang forever but I get the following
> 
> ......
> [  107.579576] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
> 
> [  291.970133] sd 4:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK
> 
> [  292.247547] rdma_rxe: unloaded
> 
> So it waits for about 3 minutes for something and then gives up.

(+Christoph)

Hi Bob,

I can reproduce this behavior with the Soft-iWARP driver by running the 
following command:

cd blktests && use_siw=1 ./check -q srp/001

Christoph, the call stack involved in this issue is as follows:

__schedule+0x4c3/0xd20
schedule+0x82/0x110
schedule_timeout+0x122/0x200
io_schedule_timeout+0x7b/0xc0
__wait_for_common+0x2bc/0x380
wait_for_completion_io_timeout+0x1d/0x20
blk_execute_rq+0x1db/0x200
__scsi_execute+0x1fb/0x310
sd_sync_cache+0x155/0x2c0 [sd_mod]
sd_shutdown+0xbb/0x190 [sd_mod]
sd_remove+0x5b/0x80 [sd_mod]
device_remove+0x9a/0xb0
device_release_driver_internal+0x2c5/0x360
device_release_driver+0x12/0x20
bus_remove_device+0x1aa/0x270
device_del+0x2d4/0x640
__scsi_remove_device+0x168/0x1a0
scsi_forget_host+0xa8/0xb0
scsi_remove_host+0x9b/0x150
sdebug_driver_remove+0x3d/0x140 [scsi_debug]
device_remove+0x6f/0xb0
device_release_driver_internal+0x2c5/0x360
device_release_driver+0x12/0x20
bus_remove_device+0x1aa/0x270
device_del+0x2d4/0x640
device_unregister+0x18/0x70
sdebug_do_remove_host+0x138/0x180 [scsi_debug]
scsi_debug_exit+0x45/0xd5 [scsi_debug]
__do_sys_delete_module.constprop.0+0x210/0x320
__x64_sys_delete_module+0x1f/0x30
do_syscall_64+0x35/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xae

One of the functions in the above call stack is sd_remove(). sd_remove() 
calls del_gendisk() just before calling sd_shutdown(). sd_shutdown() 
submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the 
following comment: "Fail any new I/O". Do you agree that failing new I/O 
before sd_shutdown() is called is wrong? Is there any other way to fix 
this than moving the blk_queue_start_drain() etc. calls out of 
del_gendisk() and into a new function?

Thanks,

Bart.
