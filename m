Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDDA18A08C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCRQey (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 12:34:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37842 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQey (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 12:34:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id l20so21229588qtp.4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=usx8FnxjVcxtvY5eA8OlHr3j5yNOPvd73KHGtvnpfI4=;
        b=KoW1iYjqxv4SDkGvrFmr98RLPV86JIxzuAfMv0FF4UQg2GP0jkYUiATHHeHKVcrOie
         othJdl7GPGUCwfTVt7RaBs/RQSuey5Ne16DNzXLpUoVa3WgGkYDP4cvGNl4Gf85Z2WCZ
         pCI5XQxP70gZSupJOKT1xcR3/tPy0D25XQCJCAvk5erXoA74ptnWOPET7cQoX6rM/ucF
         bWwFbnq0XI8lw/clWtentgZ4d31xwYoX3gJ8ZKDm1IwxXEQdF3c56ID06/rd6S4beGo2
         GeXRb01L3KEW9f7hpnSaAdRDj7iHJcphl7V8yFxqJVJTXfTwL/8RsEC1jUXhcvxIZnYS
         uk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=usx8FnxjVcxtvY5eA8OlHr3j5yNOPvd73KHGtvnpfI4=;
        b=bD8SBOFRFYchWGvKo36826OL8pZRmGXnbVYP/Vpm4ZKSWkVQeXYYHFeNpuluDGCj6l
         8OlrORHxa+Iv2wVjUnHSfjcyJyM8DkL/+wZEcLBRMVZKCcgAPFQ6wJoRpteAqGJeNNgy
         dXvbIThMdKUF5vkWC1MqGcwb8vbajCXNDuJbGyAd9MGqH0EOqNTBHPfUh682hvSccSEn
         rVqU3q8cwf5wzDyutz/qybxC5nyjSohlyvh/yqP2Lw159uAdzI4FOSQX8VsAy4LNydo6
         TlBQlkSZZPeLM+DpDfLrVKsAiVPSkhnFlF6CHoQF0th9d0xpxoXVuXOrpC3Rdyex2mKe
         4oVw==
X-Gm-Message-State: ANhLgQ2MDWkKRQCK0PDj0myBD6B3p5Mx+xfsf9u/ISk532K+cQThauoc
        FEuICKA0EnjXIFdRihMm0r5NaA==
X-Google-Smtp-Source: ADFU+vvDEZeX+4t4FBHBHlY9gskU78VCtoa1vkcsHpZIOmlyOs4yTCzMudof9gWH8Qt1ql521qNmaw==
X-Received: by 2002:ac8:346f:: with SMTP id v44mr5294254qtb.205.1584549293166;
        Wed, 18 Mar 2020 09:34:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e2sm4461008qkb.112.2020.03.18.09.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 09:34:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEbed-0002xD-WC; Wed, 18 Mar 2020 13:34:52 -0300
Date:   Wed, 18 Mar 2020 13:34:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Message-ID: <20200318163451.GC20941@ziepe.ca>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318133155.GA20941@ziepe.ca>
 <MW3PR11MB466582BEE0315ABD0ABEBAB9F4F70@MW3PR11MB4665.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB466582BEE0315ABD0ABEBAB9F4F70@MW3PR11MB4665.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 04:02:42PM +0000, Wan, Kaike wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, March 18, 2020 9:32 AM
> > To: Dalessandro, Dennis <dennis.dalessandro@intel.com>
> > Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Marciniszyn, Mike
> > <mike.marciniszyn@intel.com>; Wan, Kaike <kaike.wan@intel.com>
> > Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
> > the parent of cdev
> > 
> > On Mon, Mar 16, 2020 at 05:05:07PM -0400, Dennis Dalessandro wrote:
> > > From: Kaike Wan <kaike.wan@intel.com>
> > >
> > > This patch is implemented to address the concerns raised in:
> > >   https://marc.info/?l=linux-rdma&m=158101337614772&w=2
> > >
> > > The hfi1 driver dynammically allocates a struct device to represent
> > > the cdev in sysfs and devtmpfs (/dev/hfi1_x). On the other hand, the
> > > hfi1_devdata already contains a struct device in its ibdev field
> > > (hfi1_devdata.verbs_dev.rdi.ibdev.dev), and it is therefore possible
> > > to eliminate the dynamical allocation when creating the cdev. Since
> > > each device could be added to the sysfs only once and the function
> > > device_add() is already called for the ibdev in ib_register_device(),
> > > the function cdev_device_add() could not be used to create the cdev,
> > > even though the hfi1_devdata contains both cdev and ibdev in the same
> > > structure.
> > >
> > > This patch eliminates the dynamic allocation by creating the cdev
> > > first, setting up the ibdev, and then calling the ib_register_device()
> > > to add the device to sysfs and devtmpfs.
> > 
> > What do the sysfs paths for the cdev look like now?
> 
> ls -l /sys/dev/char/243:0
> lrwxrwxrwx 1 root root 0 Mar 15 14:30 /sys/dev/char/243:0 -> ../../devices/pci0000:00/0000:00:02.0/0000:02:00.0/infiniband/hfi1_0
> 
> It points back to the IB device (hfi1_0 ).
> 
> Before this change, it pointed back to a virtual device:
> 
> ls /sys/dev/char/243:0 -l
> lrwxrwxrwx 1 root root 0 Mar 18 11:52 /sys/dev/char/243:0 -> ../../devices/virtual/hfi1_user/hfi1_0

Great, yes this looks right to me

So this came up due to PSM having problems.. The right way for PSM
to work is now to find the hfi1_0 devices under /sys/class/hfi1_user/*
and then map then back to RDMA devices and the physical card by doing
realpath and learning the
'/sys/pci0000:00/0000:00:02.0/0000:02:00.0/infiniband/XXX/' path

Yes?

Jason
