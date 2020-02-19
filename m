Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E496163857
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSAPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:15:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46367 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgBSAPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:15:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so20922644qkh.13
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43FYAxubAHcTl7SLjJNqJbMLIzF4CqeOErhaqDx8/k4=;
        b=iQ9fuQGGAzvQw6atDUD+eDRMKio9QEpID8aYoVv8pTd7en3QXnLeqRi0aFYrainWpj
         HtCqAQNsR/LCSjuzK0YHGEaXnReBPj+qQYB4xEauKZwx6ReS3Do425EM7RbJksxIB5AI
         0gJi9AcgCdemsBckMVXetnht7GGunJzGcHBVT1+PmE7qW2utNMWzTI3/nbfxoceMjLNU
         isCIalEKfCdFMT8pd+wOzF5hfx/FVBtAtBnx6bLkVhX05E9VCm368l/yzAraHEsuqNDP
         TLqlZ9Nu4XtexOSPif4aNlZZOfRd6lPHd/l8SYxJPhUQKMvjnjFCmKDiNhOXrIQKXFrG
         L6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43FYAxubAHcTl7SLjJNqJbMLIzF4CqeOErhaqDx8/k4=;
        b=dav0nCd7G4rTN0gTP7gfy4Jzuenq4iTyxORpGxPqeiI73wf8R6COgzIjoImeMRvbKs
         QFXUz0QPn1ydKfIQCesTGtgzd2zR7XSi+jM2MuKswvEB8w84JJ7B1BhTaExHjW0+f1XC
         0PUU/nMvh7cefnfCL4dwNT45CDzADGvPOz6DuIHS1ZPb+76iZswuRVrmlpbY9IZ7cPFv
         Zf5FHwNFpCZyT0+YA3u66nWDRIekVz5UDPjvhh6dvoHIsbmO9C+GxEwhsQzGThqeNETs
         obZiptYiaxsBiSI8P0gMzXI7hlsdHi5PirPpj/dYWU7U9kpRkXHg4GzgR47n4LXc4602
         v+Fg==
X-Gm-Message-State: APjAAAUG/LnwGOkXjFiZ8AXSdfDUbbZ9hjpLxBXkRVSp6NZHWzt/uHQi
        GIbIP/caBhvKCOrizwEpNzyWcw==
X-Google-Smtp-Source: APXvYqwdfR23JM6NnVo8rmnYTeZZQhWd3lL3SnlEaIawaRCts8V+qJ7lMKuDp4jd9mT0mplXj22zDA==
X-Received: by 2002:a37:a64a:: with SMTP id p71mr20879097qke.364.1582071351774;
        Tue, 18 Feb 2020 16:15:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p50sm84292qtf.5.2020.02.18.16.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:15:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4D1q-0002xY-Sx; Tue, 18 Feb 2020 20:15:50 -0400
Date:   Tue, 18 Feb 2020 20:15:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 5/6] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
Message-ID: <20200219001550.GK31668@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com>
 <20200103194458.GA16980@ziepe.ca>
 <CA+sbYW0_o62UXae1h_U7+F9uH=qTOh0ou3w47jNdfHDdB0Ebtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW0_o62UXae1h_U7+F9uH=qTOh0ou3w47jNdfHDdB0Ebtw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 05:19:27PM +0530, Selvin Xavier wrote:
> On Sat, Jan 4, 2020 at 1:15 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Nov 25, 2019 at 12:39:33AM -0800, Selvin Xavier wrote:
> >
> > >  static void __exit bnxt_re_mod_exit(void)
> > >  {
> > > -     struct bnxt_re_dev *rdev, *next;
> > > -     LIST_HEAD(to_be_deleted);
> > > +     struct bnxt_re_dev *rdev;
> > >
> > > +     flush_workqueue(bnxt_re_wq);
> > >       mutex_lock(&bnxt_re_dev_lock);
> > > -     /* Free all adapter allocated resources */
> > > -     if (!list_empty(&bnxt_re_dev_list))
> > > -             list_splice_init(&bnxt_re_dev_list, &to_be_deleted);
> > > -     mutex_unlock(&bnxt_re_dev_lock);
> > > -       /*
> > > -     * Cleanup the devices in reverse order so that the VF device
> > > -     * cleanup is done before PF cleanup
> > > -     */
> > > -     list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
> > > -             dev_info(rdev_to_dev(rdev), "Unregistering Device");
> > > +     list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
> > >               /*
> > > -              * Flush out any scheduled tasks before destroying the
> > > -              * resources
> > > +              * Set unreg flag to avoid VF resource cleanup
> > > +              * in module unload path. This is required because
> > > +              * dealloc_driver for VF can come after PF cleaning
> > > +              * the VF resources.
> > >                */
> > > -             flush_workqueue(bnxt_re_wq);
> > > -             bnxt_re_dev_stop(rdev);
> > > -             bnxt_re_ib_uninit(rdev);
> > > -             /* Acquire the rtnl_lock as the L2 resources are freed here */
> > > -             rtnl_lock();
> > > -             bnxt_re_remove_device(rdev);
> > > -             rtnl_unlock();
> > > +             if (rdev->is_virtfn)
> > > +                     rdev->rcfw.res_deinit = true;
> > >       }
> > > +     mutex_unlock(&bnxt_re_dev_lock);
> >
> > This is super ugly. This driver already has bugs if it has a
> > dependency on driver unbinding order as drivers can become unbound
> > from userspace using sysfs or hot un-plug in any ordering.
> >
> The dependency is from the HW side and not from the driver side.
> In some of the HW versions, RoCE PF driver is allowed to allocate the
> host memory
> for VFs and this dependency is due to this.
> > If the VF driver somehow depends on the PF driver then destruction of
> > the PF must synchronize and fence the VFs during it's own shutdown.
>
> Do you suggest that synchronization should be done in the stack before
> invoking the
> dealloc_driver for VF?

'in the stack'? This is a driver problem.. You can't assume ordering
of driver detaches in Linux, and drivers should really not be
co-ordinating across their instances.

> > But this seems very strange, how can it work if the VF is in a VM
> > or something and the PF driver is unplugged?

> This code is not handling the case where the VF is attached to a VM.
> First command to HW after the removal of PF will fail with timeout.
> Driver will stop sending commands to HW once it sees this timeout. VF
> driver removal
> will proceed with cleaning up of host resources without sending any
> commands to FW
> and exit the removal process.

So why not use this for the host case as well? The timeout is too
long?

> On hypervisor, if we don't set rdev->rcfw.res_deinit as done in this
> patch, when VF removal is initiated,
> the first command will timeout and driver will stop sending any more commands
> to FW and proceed with removal. All VFs will exit in the same way.
> Just that each
> function will wait for one command to timeout. Setting
> rdev->rcfw.res_deinit was added
> as a hack to avoid this  waiting time.

The issue is that pci_driver_unregister undoes the driver binds in
FIFO not LIFO order?

What happens when the VF binds after the PF?

Jason
