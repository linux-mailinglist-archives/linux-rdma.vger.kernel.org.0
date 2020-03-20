Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3CE18D47A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 17:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCTQcb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 12:32:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37070 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCTQcb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 12:32:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id d12so2978312qtj.4
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9F1ZPsoEv1st3nLar3fK6NpUj5Oj6im2YsYGJJlWFs=;
        b=AvzaCG1C3/+L4zPHq9r4vvp4VPGYp2MJ5lcgvbk0GDMwZ0BxrK8qib9L/y+WM5grHP
         /CLaITbkVS92RzZQfpEBoKawfbHAS6ofxhP4Iu6FfMXyQ4bFaqSG+9AMYERManexEl+G
         YNbz0kceb5nnt/Ax5wUrEzRNy41HR+1msnEFenJOk2q5tLzJ/ddO+0CTxI4kpDoDa3dH
         MCcInIhp1pPyj5Sh1rg1zcJ76ERlVoDOvuNqUwANFpwtVRas8YfSHiI3BdDw8Y94CNSa
         g81FpFuupGFhC1x9v0E5GYHiMrpOgwC1t7ocZLVEme341cjrHAHUAE0eiTUMo/KoSNKp
         Eexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9F1ZPsoEv1st3nLar3fK6NpUj5Oj6im2YsYGJJlWFs=;
        b=pg64U1NwrfRlUmxDKUb8LiVz+9JP4FcsMJ+oa5vNFd3NkTTvtnSDK4VfWDn8UGUdls
         e+5l0pkQl09q8HwT20+waheT21MBWedieMajSiEizCNvUfNnX+PJ5fYxuumtHOHi9vjz
         W0TAbzDH5BXbeXynhLa7ZmfZofjmTpVFuwL1q2AIf55Vw8mWLkdkTC6u6Blvpr/KwlKT
         yQBFJGyuvMK3j4oNewLEvrnljELxaEbVvb5kjLOXOJTXtYb8HjUS/x74RIPGJRmUG61b
         MB4raj2qosYSQ/Dl2vzHt+vI9fcR8Ez6S3LabXdyTsaefPtKaBk2gfydKbfJ3sHUdvCe
         LMvQ==
X-Gm-Message-State: ANhLgQ1VZbxX34aD28hYzS0MVkAHbNhe2yIKtYv0z/cQbHUWSsNrRfPH
        MBI4eYWNtIum9zspJG4g+V3XPg==
X-Google-Smtp-Source: ADFU+vsp1pA9Il24X438lTpwQt7HLZSolUabHNr3a5vzv6ZRXCYcbkxLB3kFn+j9Pf4kwukBtOuMBw==
X-Received: by 2002:ac8:5458:: with SMTP id d24mr994568qtq.255.1584721949920;
        Fri, 20 Mar 2020 09:32:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x51sm5190617qtj.82.2020.03.20.09.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Mar 2020 09:32:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jFKZP-0002C8-Pi; Fri, 20 Mar 2020 13:32:27 -0300
Date:   Fri, 20 Mar 2020 13:32:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Message-ID: <20200320163227.GS20941@ziepe.ca>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318231830.GA9586@ziepe.ca>
 <MW3PR11MB46651022C7EFD74C856675E1F4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB46651022C7EFD74C856675E1F4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 04:09:36PM +0000, Wan, Kaike wrote:

> >  2) WTF? Why is it changing the devt inside a struct ib_device??
> This is needed to create /dev/hfi1_xxx. See below.

Well, you can't do this, that belongs to the ib_device, not the
driver.
  
> > Why is it calling kobject_set_name()? Look in Documentation/kobject.txt.
> > This function isn't supposed to be used.
> There is no need to set the kobject name in cdev. Will be removed.

So the hfi1_0 name is actually the name of the ib device? But that
makes no sense, now the name of the char dev is not going to be stable
in sysfs after the ib_device is renamed.

> > Shouldn't there be a struct device to anchor this in sysfs? I'm very confused
> > how this is working, where did the hif1_xx sysfs directory come
> > from?

> Yes, ib_device is the struct device the cdev is anchored to. All we
> do here is to imitate what is done in cdev_device_add(), as
> suggested by you previously. 

I said to use cdev_device_add because that is the right thing to do.

> If this is not desirable, we could keep the current approach to
> create the struct device dynamically through device_create(). In
> that case, all we need to do is to clean up the code. Which one do
> you prefer?

The issue here was parentage. There should not be a virtual device
involved.

The hfi1 user_class device should be parented to the ib_device, look
at how things like umad work to do this properly.

And of course refcounting is tricky, so the cdev and this other device
must be in the same struct, again refer to umad.

Jason
