Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582BE3DDAF0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhHBOZ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhHBOZZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:25:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82164C06179E
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:24:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h11so24081694ljo.12
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrmiLmi2xNNwXIdoYlyYaNajS4xKGOSDHbZhpT0dlNo=;
        b=cVTDCehRXtLX+T7u+I6Hmy5WhpfdEpHJvkAD+Nd/dFmEn0tGWGM4hkYfr2N7Panr61
         gTL/cQyEJ5NMHZuUuQzbEOY4jyzHYnZaF4RWK9G3Se15Tlrt5iUBU1e5ez7WG3o7puQi
         9a3LdSXAurpr2Xk+98gG/JJm9eW1qHuTFubROoKb7kVNwcgnxWw+A8Q4hIf3+yy0HAQk
         fiKMoVPfiGCjrdNoXgxk2cn51hxj06/RMNd83yjVVmV19Ywzj3n4x1Af3sdY558clwV/
         PrAXhYaQCUfCputbpmlcAwq3zbmrfJ8GEeP2VNm5Dsv84n+Bjo2EXiWpUpg8GKIh9dbI
         xovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrmiLmi2xNNwXIdoYlyYaNajS4xKGOSDHbZhpT0dlNo=;
        b=pvIurPt1sHQIfbax8YUOzC81Tk7aJLQts6aAE7G5SMqB4lzQBsEicnWdE7V4OoWcCR
         29ZhOwhw+MN4OZBRaTgTbW9DBfygpnQwiRpSJIR9sqh4AOYr5LYrFL7vGWVyDizgenem
         3utVT+mLOuAYc71z/pAKqc5EhiMSaZK/rChjsFv1IPHGhiUH3CvYBd3ItmnfbGRXctDD
         wjX71ieEF4P7c7SWECxjvNJrgR18M6HO9OeB1FtCchgVsn1036ONWrHXDlX2O+VKR6YJ
         2NoMPcJ9EXexmaSlbyN8LkE/HVivc/ESv+SXwk+Gdx01Y9LOTtdniRRZjiWQ9iEknwNM
         Qypg==
X-Gm-Message-State: AOAM530A+mG0wF5OSdUtJGSR+qzGhMsoxtAIDknqQEtaA5tMXlkJDcCr
        PxKgz86BMFjQEZ8y3Di01ONhTKaGn8K0mApYzg4zQw==
X-Google-Smtp-Source: ABdhPJwvNVB6aW4kCssQIcvFZdhEoCdZroGY4g3iv/xipMRqXy/QqF7jQGTxPuDlyA45RuTAqslyU/6LwQIxT3fMqDs=
X-Received: by 2002:a2e:96cb:: with SMTP id d11mr11385149ljj.221.1627914289901;
 Mon, 02 Aug 2021 07:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-3-jinpu.wang@ionos.com>
 <YQeVAMWiZZ1sRqDP@unreal>
In-Reply-To: <YQeVAMWiZZ1sRqDP@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:24:39 +0200
Message-ID: <CAJpMwyjo7H53A33Wzm2yX4qQ6WxHu7Q3ia5xoHqOtdD8VupPYQ@mail.gmail.com>
Subject: Re: [PATCH for-next 02/10] RDMA/rtrs-srv: Prevent sysfs error with
 path name "ctl"
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 8:47 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:24PM +0200, Jack Wang wrote:
> > From: Gioh Kim <gi-oh.kim@ionos.com>
> >
> > If the client tries to create a path with name "ctl",
> > the server tries to creates /sys/devices/virtual/rtrs-server/ctl/.
> > Then server generated below error because there is already ctl directory
> > which manages some setup of the server.
> >
> > sysfs: cannot create duplicate filename '/devices/virtual/rtrs-server/ctl'
> > Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> > Call Trace:
> > dump_stack+0x50/0x63
> > sysfs_warn_dup.cold+0x17/0x24
> > sysfs_create_dir_ns+0xb6/0xd0
> > kobject_add_internal+0xa6/0x2a0
> > kobject_add+0x7e/0xb0
> > ? _cond_resched+0x15/0x30
> > device_add+0x121/0x640
> > rtrs_srv_create_sess_files+0x18f/0x1f0 [rtrs_server]
> > ? __alloc_pages_nodemask+0x16c/0x2b0
> > ? kmalloc_order+0x7c/0x90
> > ? kmalloc_order_trace+0x1d/0xa0
> > ? rtrs_iu_alloc+0x17e/0x1bf [rtrs_core]
> > rtrs_srv_info_req_done+0x417/0x5b0 [rtrs_server]
> > ? __switch_to_asm+0x40/0x70
> > __ib_process_cq+0x76/0xd0 [ib_core]
> > ib_cq_poll_work+0x26/0x80 [ib_core]
> > process_one_work+0x1df/0x3a0
> > worker_thread+0x4a/0x3c0
> > kthread+0xfb/0x130
> > ? process_one_work+0x3a0/0x3a0
> > ? kthread_park+0x90/0x90
> > ret_from_fork+0x1f/0x40
> > kobject_add_internal failed for ctl with -EEXIST, don't try to register things with the same name in the same directory.
> > rtrs_server L178: device_add(): -17
> >
> > This patch checks the path name and disconnect on server to prevent
> > the kernel error.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index cd9a4ccf4c28..b814a6052cf1 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -758,6 +758,14 @@ static bool exist_sessname(struct rtrs_srv_ctx *ctx,
> >       struct rtrs_srv_sess *sess;
> >       bool found = false;
> >
> > +     /*
> > +      * Session name "ct" is not allowed because
> > +      * /sys/devices/virtual/rtrs-server/ctl already exists
> > +      * for setup management.
> > +      */
> > +     if (!strcmp(sessname, "ctl"))
> > +             return true;
>
> Why does it have special treatment?

rtrs-server creates a folder named ctl when the module is modprob'ed.
When a session is established, a folder of the session name is created
at the same location, which would hold sysfs entries such as
clt_hostname, path details, queue_depth, etc.

Due to this conflict of names, creation of session with that name is
not possible. So this gracefully fails the connection establishment
instead of a stack trace.

> And what will happen if user supplies "." or ".."?

Weirdly enough, this succeeds. I tried, and the session creation
succeeds, and there is a hidden entry in the rtrs-server folder, but
it cannot be accessed through bash.

> Does rtrs receive this session name from the other side in the network?

Yes. This string is entered by the user while creating the session.

>
> Thanks
