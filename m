Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86E164059
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBSJ16 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 04:27:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40482 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgBSJ15 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 04:27:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so23137114oii.7
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKQTfCajagr4J1OSDU17sA1kYXaEuT7aHw/dFjtanFA=;
        b=YJHvcfnaEtqIV9PKgwpEwTObjxIAwBWyLS+yE7DeJQUiX73MOSMkWr+jY+x8uEsJn2
         EPJLqVqilfrxOm7b1sB6S5FmwRSGshQ2c/TgidqVM8vzBQ4efb4d1k9uq6nc9VFfql8P
         sUHOhoABCAAqtSw0XP9TtKZNiwcw+xf5v0dwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKQTfCajagr4J1OSDU17sA1kYXaEuT7aHw/dFjtanFA=;
        b=Lp2GhZk2YaC71PX0zVO+UX3rKBd+2DnXKAgyzQXVJXbRkvbOCVJq+N8qGu2AMUvEGe
         VIvmVXhHWD2ZDBcrms1AOrB7Tz1ZLDmpBxIl0ppV+YnIlv21m5zmW9D/f7QC7YSFagI3
         +lHCBHQFxLMAdTgSyLjk2Gb/jn/RzxadKTOI6xPbEWXgOw96uN45aHOzQ6onsG9cLAVO
         EnlYkBzOBTAUPPwBhzj8HRprV3oAOtJLwdBO6mTUTWea7tThIj/HAQiDFqnA2z6Y9c3Y
         HUHsXtUmJW2aVjdR6+Kud3J/v9Ut4AgIkw8LfOtD/vNbCIHaygB9Ws5E/+/kdKulQ6wO
         0plQ==
X-Gm-Message-State: APjAAAWglMPJZ4En0HJ2iMS0OUru4Djc5tj5VIp8KU7F8nyuiBPiL/UC
        qYAVbDVjurk8NbkkWw+4RfJN+eI2jGsmQtwMphySjgVy5eI=
X-Google-Smtp-Source: APXvYqwzdPho1dIK1KeT7a9bQ56CBmGNl34qQS7/Qgk/YbMDLeT8MZ50Md+3nmWUqSYP/SG9AkusEXZN2Qhv5tkoyIc=
X-Received: by 2002:aca:f0b:: with SMTP id 11mr4169877oip.34.1582104476415;
 Wed, 19 Feb 2020 01:27:56 -0800 (PST)
MIME-Version: 1.0
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com>
 <20200103194458.GA16980@ziepe.ca> <CA+sbYW0_o62UXae1h_U7+F9uH=qTOh0ou3w47jNdfHDdB0Ebtw@mail.gmail.com>
 <20200219001550.GK31668@ziepe.ca>
In-Reply-To: <20200219001550.GK31668@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 19 Feb 2020 14:57:45 +0530
Message-ID: <CA+sbYW0-wrDQPCNKSBqAJvqmv9Hs7VxqLA9mbA3PJhviqXg_Rw@mail.gmail.com>
Subject: Re: [PATCH for-next 5/6] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 5:45 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 18, 2020 at 05:19:27PM +0530, Selvin Xavier wrote:
> > On Sat, Jan 4, 2020 at 1:15 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Nov 25, 2019 at 12:39:33AM -0800, Selvin Xavier wrote:
> > >
> > > >  static void __exit bnxt_re_mod_exit(void)
> > > >  {
> > > > -     struct bnxt_re_dev *rdev, *next;
> > > > -     LIST_HEAD(to_be_deleted);
> > > > +     struct bnxt_re_dev *rdev;
> > > >
> > > > +     flush_workqueue(bnxt_re_wq);
> > > >       mutex_lock(&bnxt_re_dev_lock);
> > > > -     /* Free all adapter allocated resources */
> > > > -     if (!list_empty(&bnxt_re_dev_list))
> > > > -             list_splice_init(&bnxt_re_dev_list, &to_be_deleted);
> > > > -     mutex_unlock(&bnxt_re_dev_lock);
> > > > -       /*
> > > > -     * Cleanup the devices in reverse order so that the VF device
> > > > -     * cleanup is done before PF cleanup
> > > > -     */
> > > > -     list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
> > > > -             dev_info(rdev_to_dev(rdev), "Unregistering Device");
> > > > +     list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
> > > >               /*
> > > > -              * Flush out any scheduled tasks before destroying the
> > > > -              * resources
> > > > +              * Set unreg flag to avoid VF resource cleanup
> > > > +              * in module unload path. This is required because
> > > > +              * dealloc_driver for VF can come after PF cleaning
> > > > +              * the VF resources.
> > > >                */
> > > > -             flush_workqueue(bnxt_re_wq);
> > > > -             bnxt_re_dev_stop(rdev);
> > > > -             bnxt_re_ib_uninit(rdev);
> > > > -             /* Acquire the rtnl_lock as the L2 resources are freed here */
> > > > -             rtnl_lock();
> > > > -             bnxt_re_remove_device(rdev);
> > > > -             rtnl_unlock();
> > > > +             if (rdev->is_virtfn)
> > > > +                     rdev->rcfw.res_deinit = true;
> > > >       }
> > > > +     mutex_unlock(&bnxt_re_dev_lock);
> > >
> > > This is super ugly. This driver already has bugs if it has a
> > > dependency on driver unbinding order as drivers can become unbound
> > > from userspace using sysfs or hot un-plug in any ordering.
> > >
> > The dependency is from the HW side and not from the driver side.
> > In some of the HW versions, RoCE PF driver is allowed to allocate the
> > host memory
> > for VFs and this dependency is due to this.
> > > If the VF driver somehow depends on the PF driver then destruction of
> > > the PF must synchronize and fence the VFs during it's own shutdown.
> >
> > Do you suggest that synchronization should be done in the stack before
> > invoking the
> > dealloc_driver for VF?
>
> 'in the stack'? This is a driver problem.. You can't assume ordering
> of driver detaches in Linux, and drivers should really not be
> co-ordinating across their instances.
>
> > > But this seems very strange, how can it work if the VF is in a VM
> > > or something and the PF driver is unplugged?
>
> > This code is not handling the case where the VF is attached to a VM.
> > First command to HW after the removal of PF will fail with timeout.
> > Driver will stop sending commands to HW once it sees this timeout. VF
> > driver removal
> > will proceed with cleaning up of host resources without sending any
> > commands to FW
> > and exit the removal process.
>
> So why not use this for the host case as well? The timeout is too
> long?
Yeah. Timeout for the first command is 20sec now. May be, I can use
a smaller timeout in the unreg path.
>
> > On hypervisor, if we don't set rdev->rcfw.res_deinit as done in this
> > patch, when VF removal is initiated,
> > the first command will timeout and driver will stop sending any more commands
> > to FW and proceed with removal. All VFs will exit in the same way.
> > Just that each
> > function will wait for one command to timeout. Setting
> > rdev->rcfw.res_deinit was added
> > as a hack to avoid this  waiting time.
>
> The issue is that pci_driver_unregister undoes the driver binds in
> FIFO not LIFO order?
>
> What happens when the VF binds after the PF?

This is not dependent on PCI driver unregister. This particular issue
is happening when bnxt_re
driver only  is unloaded and the new  ib_unregister_driver is invoked
by bnxt_re driver in the mod_exit hook.
dealloc_driver for each IB device  is called mostly in FIFO
order(using xa_for_each).  So since PF ib device was added first, it
gets removed and then VF is removed.

After this discussion, now I feel, it's better to remove the hack and
allow the commands to fail with timeout and exit.
The issue is seen only when users try to unload bnxt_re alone, without
destroying the VFs.The chances of this type of usage is slim.
Anyway, it's not a Fatal error if any of the users try this sequence.
Just that the rmmod will take some time to exit.

Shall i repost by removing this hack?
>
> Jason
