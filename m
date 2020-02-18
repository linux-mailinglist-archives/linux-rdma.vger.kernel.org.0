Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B11625C5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 12:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgBRLtj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 06:49:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36793 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgBRLtj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 06:49:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so19238681otq.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 03:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9YscxvkKgM7/wdxUrZW+bVmRTKSxISh6UCjyVmwJXE=;
        b=WyDeyZZXR/1+Qe+kcRNkmOROXT65COAjRNV7dZisV+u4crGyMolxkQ0JZEfoY2o19Z
         ojyy3o2jFjXvrXkmkD86JSfqPmMmjhjjvRYN2KrvtlS0Ik3ynN7mFXYWAfpUUSkGW9iA
         c3QbiqdyYD1GLQScuXoDTvzkD0x6EZ2mXSfRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9YscxvkKgM7/wdxUrZW+bVmRTKSxISh6UCjyVmwJXE=;
        b=ZxXttRL0Vs7YaRlBiOkSSjJu0QsKxARoMg032biyu47M8xgN/bWrzxgz0hL0xnviQ8
         1JRutBYmRvWRmA/8pSVBh4nSCCGmwHCdjLOBMLHFFx8JZJ2nkDOq4mTXo+4PKwFTCLcS
         Z0SWCdNpq1D119f7r0dtdBv/DjTsPvFzw6x/Ybv9GdPw7xBO+uWJx6cLB4CUWJdQhYkb
         NF1CPKMThnvSESiaFh8YFpnTKwpZ/46sYEm75rTCi7Y0jNbjQtbwDHL8WkMkL10OowMr
         54VHZhw2F48hqyna6CEsGeXhq772aohhJ7cwARsk0xj+TqO16DtxyTv0nsjRKE9yMPqc
         Ub7w==
X-Gm-Message-State: APjAAAUanW34ENDUFs+Vj2y34Clklih+3NGuktqWwlojEYiTwZ3V+/TZ
        /Q9ZqMRWK++0fkeXXUIdS+ps7fCNdihyDC4g7JVbEw==
X-Google-Smtp-Source: APXvYqyZQmlxgkbCLTeDs8ba17llUYTx4OdETH1GCPLuUiwiP/Kr8NkyR/SP8w4tZnbjTgPaiP5Kf0amb3V3OdCdx5I=
X-Received: by 2002:a9d:a68:: with SMTP id 95mr15065775otg.87.1582026578348;
 Tue, 18 Feb 2020 03:49:38 -0800 (PST)
MIME-Version: 1.0
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com> <20200103194458.GA16980@ziepe.ca>
In-Reply-To: <20200103194458.GA16980@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 18 Feb 2020 17:19:27 +0530
Message-ID: <CA+sbYW0_o62UXae1h_U7+F9uH=qTOh0ou3w47jNdfHDdB0Ebtw@mail.gmail.com>
Subject: Re: [PATCH for-next 5/6] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 4, 2020 at 1:15 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Nov 25, 2019 at 12:39:33AM -0800, Selvin Xavier wrote:
>
> >  static void __exit bnxt_re_mod_exit(void)
> >  {
> > -     struct bnxt_re_dev *rdev, *next;
> > -     LIST_HEAD(to_be_deleted);
> > +     struct bnxt_re_dev *rdev;
> >
> > +     flush_workqueue(bnxt_re_wq);
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
> > -             dev_info(rdev_to_dev(rdev), "Unregistering Device");
> > +     list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
> >               /*
> > -              * Flush out any scheduled tasks before destroying the
> > -              * resources
> > +              * Set unreg flag to avoid VF resource cleanup
> > +              * in module unload path. This is required because
> > +              * dealloc_driver for VF can come after PF cleaning
> > +              * the VF resources.
> >                */
> > -             flush_workqueue(bnxt_re_wq);
> > -             bnxt_re_dev_stop(rdev);
> > -             bnxt_re_ib_uninit(rdev);
> > -             /* Acquire the rtnl_lock as the L2 resources are freed here */
> > -             rtnl_lock();
> > -             bnxt_re_remove_device(rdev);
> > -             rtnl_unlock();
> > +             if (rdev->is_virtfn)
> > +                     rdev->rcfw.res_deinit = true;
> >       }
> > +     mutex_unlock(&bnxt_re_dev_lock);
>
> This is super ugly. This driver already has bugs if it has a
> dependency on driver unbinding order as drivers can become unbound
> from userspace using sysfs or hot un-plug in any ordering.
>
The dependency is from the HW side and not from the driver side.
In some of the HW versions, RoCE PF driver is allowed to allocate the
host memory
for VFs and this dependency is due to this.
> If the VF driver somehow depends on the PF driver then destruction of
> the PF must synchronize and fence the VFs during it's own shutdown.
>
Do you suggest that synchronization should be done in the stack before
invoking the
dealloc_driver for VF?

> But this seems very strange, how can it work if the VF is in a VM
> or something and the PF driver is unplugged?
This code is not handling the case where the VF is attached to a VM.
 First command to HW after the removal of PF will fail with timeout.
Driver will stop sending commands to HW once it sees this timeout. VF
driver removal
will proceed with cleaning up of host resources without sending any
commands to FW
and exit the removal process.

On hypervisor, if we don't set rdev->rcfw.res_deinit as done in this
patch, when VF removal is initiated,
the first command will timeout and driver will stop sending any more commands
to FW and proceed with removal. All VFs will exit in the same way.
Just that each
function will wait for one command to timeout. Setting
rdev->rcfw.res_deinit was added
as a hack to avoid this  waiting time.
> Jason
