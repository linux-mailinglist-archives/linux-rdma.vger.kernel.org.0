Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B474FA0B0
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiDIAeQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 20:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiDIAeP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 20:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A114F1CA3BC
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649464329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/uJ8buieiUf5/yuiyE3waxDidy3HXD5N1canBV0NCQ=;
        b=PuCR2oowqiB9CrOfoj+krdrgtDaVyHMf47DR+MKfHLiDSm2AvW96gfM+Ppe6maWuFMadWX
        KyfSqOE2phAXaVluW57Wrm7I7EQnZiWccEwfOqtGcf8xkqWQOWjctzZaOQ+fPEBtwdAtKj
        4Y6W3f+irD6Nc91+LTb9JoZ+2NK7L/g=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-IlEk3QfCOb2zeqp4_X1zXg-1; Fri, 08 Apr 2022 20:32:08 -0400
X-MC-Unique: IlEk3QfCOb2zeqp4_X1zXg-1
Received: by mail-pf1-f199.google.com with SMTP id x2-20020a628602000000b005057a9b1675so2154899pfd.15
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 17:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/uJ8buieiUf5/yuiyE3waxDidy3HXD5N1canBV0NCQ=;
        b=H8OAsiS5qQE64ObVzyOx2pQncHtrrbwX+mIc61mF0cPrOtD7RJlfGoawLMbDd33eEK
         +Z7Hfj3gGvOgsVRYLGoibDJO5qUG6KjckF4H5W2dVO6f8+PNUXOfN87N0ILKdiX7jeyt
         j6CAWVFZzOaoKcGVM5PKB2wTdjyV+uoRR0vSaIpi2bZWg+Wj7KAr06mlC6SsYZ5nayrs
         I564b/8KPDxVaDl9RiQwtiBgaPsjL5A+emFf9CoSUNYSPiOW4Rff/2Nlm41kmGMxIhAU
         jz6HSR6m/rwjblahm4mqcjq8LB2F9aejRwpA+IIA4YmiSwFx4T7ey2srR3K2kLZKHfb5
         WL1w==
X-Gm-Message-State: AOAM533JZYfQr2jadHt6mn0cMMzCfydOXAbAnooRwJWjfgYC0vo/t+HG
        6MYk2SyVNQvLRYkaF2pYtSSxxNSuoeTJBtfS5TrerTTYbK+diphqoaBmPsJhh+byVtkXfn9TA6g
        SoN/6Y1Li9j1xHIJSkR6YdA90GJHMxSI+3ScoyA==
X-Received: by 2002:a63:ff65:0:b0:39c:ef72:77f7 with SMTP id s37-20020a63ff65000000b0039cef7277f7mr6170613pgk.28.1649464327513;
        Fri, 08 Apr 2022 17:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSpWS65H3fi1MP3d02L5PzdNYOxlf89dmSrPiljNO/ixSzqvFMYPt6s3mdFONOAwc6Xo1RcWQbx2HXY0pXpXI=
X-Received: by 2002:a63:ff65:0:b0:39c:ef72:77f7 with SMTP id
 s37-20020a63ff65000000b0039cef7277f7mr6170595pgk.28.1649464327274; Fri, 08
 Apr 2022 17:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
 <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com> <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
In-Reply-To: <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 9 Apr 2022 08:31:55 +0800
Message-ID: <CAHj4cs8Z7LAWQxf2H8wX18rxOMUEy6bogo-dPCY8mVef4iR=cw@mail.gmail.com>
Subject: Re: blktest failures
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 9, 2022 at 7:25 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/8/22 15:50, Bob Pearson wrote:
> > Actually it doesn't hang forever but I get the following
> >
> > ......
> > [  107.579576] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
> >
> > [  291.970133] sd 4:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK
> >
> > [  292.247547] rdma_rxe: unloaded
> >
> > So it waits for about 3 minutes for something and then gives up.
>
> (+Christoph)
>
> Hi Bob,
>
> I can reproduce this behavior with the Soft-iWARP driver by running the
> following command:
>
> cd blktests && use_siw=1 ./check -q srp/001
>
> Christoph, the call stack involved in this issue is as follows:
>
> __schedule+0x4c3/0xd20
> schedule+0x82/0x110
> schedule_timeout+0x122/0x200
> io_schedule_timeout+0x7b/0xc0
> __wait_for_common+0x2bc/0x380
> wait_for_completion_io_timeout+0x1d/0x20
> blk_execute_rq+0x1db/0x200
> __scsi_execute+0x1fb/0x310
> sd_sync_cache+0x155/0x2c0 [sd_mod]
> sd_shutdown+0xbb/0x190 [sd_mod]
> sd_remove+0x5b/0x80 [sd_mod]
> device_remove+0x9a/0xb0
> device_release_driver_internal+0x2c5/0x360
> device_release_driver+0x12/0x20
> bus_remove_device+0x1aa/0x270
> device_del+0x2d4/0x640
> __scsi_remove_device+0x168/0x1a0
> scsi_forget_host+0xa8/0xb0
> scsi_remove_host+0x9b/0x150
> sdebug_driver_remove+0x3d/0x140 [scsi_debug]
> device_remove+0x6f/0xb0
> device_release_driver_internal+0x2c5/0x360
> device_release_driver+0x12/0x20
> bus_remove_device+0x1aa/0x270
> device_del+0x2d4/0x640
> device_unregister+0x18/0x70
> sdebug_do_remove_host+0x138/0x180 [scsi_debug]
> scsi_debug_exit+0x45/0xd5 [scsi_debug]
> __do_sys_delete_module.constprop.0+0x210/0x320
> __x64_sys_delete_module+0x1f/0x30
> do_syscall_64+0x35/0x80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> One of the functions in the above call stack is sd_remove(). sd_remove()
> calls del_gendisk() just before calling sd_shutdown(). sd_shutdown()
> submits the SYNCHRONIZE CACHE command. In del_gendisk() I found the
> following comment: "Fail any new I/O". Do you agree that failing new I/O
> before sd_shutdown() is called is wrong? Is there any other way to fix
> this than moving the blk_queue_start_drain() etc. calls out of
> del_gendisk() and into a new function?
>
> Thanks,
>
> Bart.
>

I reported/bisected for this issue last week, not sure if it helped.
https://lore.kernel.org/linux-block/CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com/T/#t
-- 
Best Regards,
  Yi Zhang

