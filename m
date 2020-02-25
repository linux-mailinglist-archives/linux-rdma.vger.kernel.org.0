Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD716B867
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 05:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgBYEKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 23:10:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45748 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYEKy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 23:10:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so10859721otp.12
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 20:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdacGTjOUtKcqGOQXwPuEv6KNLx4lG8Z5rVE3UmsenM=;
        b=XaDM+CCDDaQMjQAQ6quZfaMd1yWoCo81zP9PyRAiGblOIzyt/yAElIgfoEajXrlbST
         mTvfqvBLygu/6SlLRzLnPtTz5yJ36Ip8rJqZ2G6QBGse04LH+vDIaHkaN+CDK6kp5wUe
         zzLwPOWDd3KvtP6gNtm4zi4vWYeQ3i1Cj/kyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdacGTjOUtKcqGOQXwPuEv6KNLx4lG8Z5rVE3UmsenM=;
        b=MCI6FS9yLdYF44vMUPavUOjY/TLIgPJZTAOhNeYHPIg2WpnjrgxNIDtGNankgsu3Kk
         CmT15w+F5dJorbOmjTBXRsoZl2H4ff41JVBjD0A4Fsq0tIoYrjZq5uDbDrA4rF5Dx0LD
         uJw+3LP314HwKFHnz2Q+Gq79voqgUItCisB8PRZHncdLIHA9Mi6LR/aYJBoePpW+dtFS
         W5jAoFNOF84oUuUL93aD2yTmvt0kIDtFdN2Ezd4nJKi0AmiSDro/JEwSJgJ8BAC29uBh
         F3fdorYZSenZh/xRA8BsbFABMzOYaIkcuautNHhhKP6jVV3chG6Dk+D5QOgHPicLLqjI
         kCKA==
X-Gm-Message-State: APjAAAVa/CgRpjireC8di0WWEG8D2XXmmniLmgfTRqMmiBtc78K63p9x
        5DU9P8lcU2A6iHjQF54SqG/hAJbyXIWX7BYd+rnH2Q==
X-Google-Smtp-Source: APXvYqyy2aRdMmeK7wbY/4oCv6HOzoW3zwaAQCK758/DXyEnSXZYnixxfKPIcARMRZn2fvMsDbL0w9eFU6D4uBqWCyM=
X-Received: by 2002:a05:6830:1492:: with SMTP id s18mr722850otq.216.1582603853533;
 Mon, 24 Feb 2020 20:10:53 -0800 (PST)
MIME-Version: 1.0
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-4-git-send-email-selvin.xavier@broadcom.com> <20200224134338.GH26318@mellanox.com>
In-Reply-To: <20200224134338.GH26318@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 25 Feb 2020 09:40:42 +0530
Message-ID: <CA+sbYW2-SLiDNY26h7xgbR3+T3rsr5MTCX9QxORtvREa4vJu5w@mail.gmail.com>
Subject: Re: [PATCH for-next v2 3/3] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 7:13 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Feb 24, 2020 at 02:49:55AM -0800, Selvin Xavier wrote:
> >
> > @@ -1785,32 +1777,23 @@ static int __init bnxt_re_mod_init(void)
> >
> >  static void __exit bnxt_re_mod_exit(void)
> >  {
> > -     struct bnxt_re_dev *rdev, *next;
> > -     LIST_HEAD(to_be_deleted);
> > +     struct bnxt_re_dev *rdev;
> >
> > +     flush_workqueue(bnxt_re_wq);
>
> What is this for? Usually flushing a work queue before preventing new
> work from queueing (ie via unregister) is racy.
To flush out any netdev events scheduled to be handled by
bnxt_re_task. Mainly to wait for
case where we are in the middle of NETDEV_REGISTER event handled from
bnxt_re_task.
>
> >       mutex_lock(&bnxt_re_dev_lock);
> > -     /* Free all adapter allocated resources */
> > -     if (!list_empty(&bnxt_re_dev_list))
> > -             list_splice_init(&bnxt_re_dev_list, &to_be_deleted);
> > -     mutex_unlock(&bnxt_re_dev_lock);
> > -       /*
> > -     * Cleanup the devices in reverse order so that the VF device
> > -     * cleanup is done before PF cleanup
> > -     */
> > -     list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
> > -             ibdev_info(&rdev->ibdev, "Unregistering Device");
> > -             /*
> > -              * Flush out any scheduled tasks before destroying the
> > -              * resources
> > +     list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
> > +             /* VF device removal should be called before the removal
> > +              * of PF device. Queue VFs unregister first, so that VFs
> > +              * shall be removed before the PF during the call of
> > +              * ib_unregister_driver. Commands to any VFs after the
> > +              * PF removal will timeout and driver will proceed with
> > +              * unregisteration and free up the host resources.
> >                */
> > -             flush_workqueue(bnxt_re_wq);
> > -             bnxt_re_dev_stop(rdev);
> > -             bnxt_re_ib_uninit(rdev);
> > -             /* Acquire the rtnl_lock as the L2 resources are freed here */
> > -             rtnl_lock();
> > -             bnxt_re_remove_device(rdev);
> > -             rtnl_unlock();
> > +             if (rdev->is_virtfn)
> > +                     ib_unregister_device_queued(&rdev->ibdev);
>
> Why do it queued? Just call ib_unregister_device(). Otherwise it won't
> order reliably.
Sure. Will change it.
>
> But be very careful about lifetime. All the other drivers had problems
> managing the lifetime of the pointers in their device lists.
>
> Jason
