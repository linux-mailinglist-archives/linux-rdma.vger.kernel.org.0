Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D531947AA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 20:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgCZTmz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 15:42:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44786 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTmz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 15:42:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so8148011qkc.11
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tqdyi2OCjIL4T6wmWygo4z3ceBD56bBQAAMaQ7AZltY=;
        b=g+/KoyoSY+55o5rAk0EjhhAuIkecr3zN5DEo3eKelw7r7M4B8pV8/I2gFRvQrD3/ut
         LIp56gTy2nGZvMpVVoED0Wcz4NwUdoFJZ/eNtVVUCXTPF3onM9kOynz8zeWIb83NZqrT
         F0N8TLiOyhG5e9ZGiIrxgJOE7seQmZNsGrepvh84h+g9ExY/W8oOoaQ5T+75/Z3bAH5N
         IEBb2unJ+P8qSzBcgdnI9kK+N525GAyP0UWqISWMKB0nwS8e5cerzDhOiMoTk+IB7RYi
         KcGRzdtcEL+skz+gU6i78TTI573FH/rmF4tYj/zBOk+psb2kk+5CVZPmYXqATXPsGK6C
         W0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tqdyi2OCjIL4T6wmWygo4z3ceBD56bBQAAMaQ7AZltY=;
        b=aSKQvyoON271eDSbnXcd/zNDNbY5RlWwDzpYYX1Xvvq+7+/tI4amg+9Hh9RJhsmm/5
         YuAsOwcXOmZ7o+kBThAvPG6PTVMK0uEh577PEEB+GBHteZOk6L1bkDud8+0AKOJOUHew
         dZAuT1G0FbiYYJSGmmPtXdfMHC9iAtPOsP9iUXHouauw+I7rxDJ8AGbvquadvxHQHzzi
         qxSroq5varoezOjj9zA6j6YRulHYvChRM2+xPQkiYNuZwgF6HGzHz0TknHS9681UPAOK
         kcRGI4wKew+e3GvWVSJRVGjVKg2zy4UfKyUK6Mz5ujgumcTqkddJoJQjEkZVbKD41Iss
         nEiQ==
X-Gm-Message-State: ANhLgQ0YFNaPB5CcvOJvHBIpux7mCjHts86VPWqArCEa10wsBpbqfg5y
        EZ+cdMZa3Td4irLd5hh/fTYjBQ==
X-Google-Smtp-Source: ADFU+vt/vZb8r6r+fNUCSZRclVCTGjP2pJ4BMx60j9aabgHKsAU+3H0mFVxffaq2aumjmA3D+D7wxw==
X-Received: by 2002:a37:7687:: with SMTP id r129mr9249250qkc.263.1585251773329;
        Thu, 26 Mar 2020 12:42:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n38sm2191158qtk.64.2020.03.26.12.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 12:42:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHYOx-0005Yr-Tg; Thu, 26 Mar 2020 16:42:51 -0300
Date:   Thu, 26 Mar 2020 16:42:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH for-rc 1/2] IB/hfi1: Fix memory leaks in sysfs
 registration and unregistration
Message-ID: <20200326194251.GO20941@ziepe.ca>
References: <20200326163619.21129.13002.stgit@awfm-01.aw.intel.com>
 <20200326163807.21129.27371.stgit@awfm-01.aw.intel.com>
 <20200326172541.GM20941@ziepe.ca>
 <MW3PR11MB466550446C9C322CAB52AAE7F4CF0@MW3PR11MB4665.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB466550446C9C322CAB52AAE7F4CF0@MW3PR11MB4665.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 26, 2020 at 07:09:57PM +0000, Wan, Kaike wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, March 26, 2020 1:26 PM
> > To: Dalessandro, Dennis <dennis.dalessandro@intel.com>
> > Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Marciniszyn, Mike
> > <mike.marciniszyn@intel.com>; stable@vger.kernel.org; Wan, Kaike
> > <kaike.wan@intel.com>
> > Subject: Re: [PATCH for-rc 1/2] IB/hfi1: Fix memory leaks in sysfs registration
> > and unregistration
> > 
> > On Thu, Mar 26, 2020 at 12:38:07PM -0400, Dennis Dalessandro wrote:
> > > From: Kaike Wan <kaike.wan@intel.com>
> > >
> > > When the hfi1 driver is unloaded, kmemleak will report the following
> > > issue:
> > >
> > > unreferenced object 0xffff8888461a4c08 (size 8):
> > > comm "kworker/0:0", pid 5, jiffies 4298601264 (age 2047.134s) hex dump
> > > (first 8 bytes):
> > > 73 64 6d 61 30 00 ff ff sdma0...
> > > backtrace:
> > > [<00000000311a6ef5>] kvasprintf+0x62/0xd0 [<00000000ade94d9f>]
> > > kobject_set_name_vargs+0x1c/0x90 [<0000000060657dbb>]
> > > kobject_init_and_add+0x5d/0xb0 [<00000000346fe72b>] 0xffffffffa0c5ecba
> > > [<000000006cfc5819>] 0xffffffffa0c866b9 [<0000000031c65580>]
> > > 0xffffffffa0c38e87 [<00000000e9739b3f>] local_pci_probe+0x41/0x80
> > > [<000000006c69911d>] work_for_cpu_fn+0x16/0x20
> > [<00000000601267b5>]
> > > process_one_work+0x171/0x380 [<0000000049a0eefa>]
> > > worker_thread+0x1d1/0x3f0 [<00000000909cf2b9>] kthread+0xf8/0x130
> > > [<0000000058f5f874>] ret_from_fork+0x35/0x40
> > >
> > > This patch fixes the issue by:
> > > - Releasing dd->per_sdma[i].kobject in hfi1_unregister_sysfs().
> > >   - This will fix the memory leak.
> > > - Calling kobject_put() to unwind operations only for those entries in
> > >    dd->per_sdma[] whose operations have succeeded (including the current
> > >    one that has just failed) in hfi1_verbs_register_sysfs().
> > >
> > > Fixes: 0cb2aa690c7e ("IB/hfi1: Add sysfs interface for affinity
> > > setup")
> > > Cc: <stable@vger.kernel.org>
> > > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > > Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > >  drivers/infiniband/hw/hfi1/sysfs.c |   13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > I'm not certain, but this seems unwise.
> > 
> > After hfi1_verbs_unregiser_sysfs() returns there should be no sysfs left
> > under the ibdev as we are going to delete the ibdev sysfs next.
> > 
> > kobject_del() triggers synchronous delete of the sysfs, while
> > kobject_put() potentially defers it to the future.

> True.  However, kobject_del() will only delete the sysfs for the
> object, ie, unwrap what has been done in object_add, but it will not
> decrement the refcount for the kobject.  To unwap
> kobject_init_and_add(), one can call 
> (1) kobject_del() (optional)
> (2) object_put()

Yes, you must call both, but kobject_put is not a replacement for
kobject_del.

> The kobject cleanup function (kobject_cleanup()) will call
> kobject_del if kobj->state_in_sys is set. Therefore, one can call
> object_put() alone to get the job done.

No, as I already explained, the moment that kobject_del happens is no
longer reliable with kobject_put.

> > Will ib unregister fail if the kobject_del() has not happened yet? I am unsure.
> 
> I don't think so. We only observed the kmemleak complaints after
> unloading the driver, nothing else.

Of course, hfi1 is missing the required kobject_put, so it was only a
leak.

To see if there is an issue here delete the kobject_del and
kobject_put entirely to leave a dangling sysfs during registration and
see if ib device unregistration explodes.

Jason
