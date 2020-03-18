Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B518A91A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCRXSe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 19:18:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36490 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRXSe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 19:18:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id m33so254829qtb.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4RLZb77gj0zoaGf7wAyAoYhQmqKvnCs3jyf7RIbpTTA=;
        b=KM9G+x8jZLaPKA1qIQoHIY2onPuvTDC9PZV+31Qu9hRgqvAEOg7NbBG7T6IyanKrKs
         Gdt4tCecf7o9Jc8QCoU06Cram4SuPIzE+KiiNYuzeR+NxmLf3oYkJCyH8EF3G0Q/iSOG
         T+knqktD4qYx1IlN0bxsXjKDduaAXRvTCxp9tBwDEnARA2i2kdpJ+8Z62+LzSJ64U88q
         K+U69rMYZS/gvl4oTM6nJETLomXB/pYryAQhKawi6sG5AJ1SGKHa45aNeF8D93Dmk/Vj
         OyVztNgX6eJOTC5irbT+WDIiwpd0fKw7q51RnTrQkRYjo6ISS+760tcQ1KsZrT/kIuAl
         E3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4RLZb77gj0zoaGf7wAyAoYhQmqKvnCs3jyf7RIbpTTA=;
        b=ArrI25lQ6kx3HE3WahrUCtSYxqlDOGbTf6v5xu/d6R8MvzV6/Xs8ejOd5fPfthLbrL
         jRKvh19ZYkHsvsL+Srl42UCs6lVGLbvsC4SNdPbo6e12krNwWaEgi2cZAab50HRr2hu8
         x2Aks7YY/1UtaWxvV0cdx0bzM7mvuIK9xRoTsbJACUnaejzegB9my0or7w0drC31etHl
         aT8cGeIw/4Qg6KW2R3N37lysOiRTTBfMBY2FnI4pbuBXTordHOmzuK5VQs8eCDmmhHgI
         oQM0oU5IITILr3D2vDT2XCiae6h7bAHxAE42JubCAK0TBkIqRJDQdIjg1bec0l2J0Xrf
         /ErA==
X-Gm-Message-State: ANhLgQ0Lb5uJcjD40l3lT1y0VACS9DSjbjc7ubssgs9t3XAsfJSGcRwl
        dO0MMsJMRJZUNOu8JQDIN38BFg==
X-Google-Smtp-Source: ADFU+vujiOePBkPjuzMCdJD0wa7xyCmOYX9KV9j1ffNWUrLYVjisLGVHidef3WmDqONzFqbPoAGAFQ==
X-Received: by 2002:ac8:3630:: with SMTP id m45mr124647qtb.330.1584573511532;
        Wed, 18 Mar 2020 16:18:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d9sm185655qth.34.2020.03.18.16.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 16:18:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEhxG-00034D-8M; Wed, 18 Mar 2020 20:18:30 -0300
Date:   Wed, 18 Mar 2020 20:18:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Message-ID: <20200318231830.GA9586@ziepe.ca>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 16, 2020 at 05:05:07PM -0400, Dennis Dalessandro wrote:
> From: Kaike Wan <kaike.wan@intel.com>
> 
> This patch is implemented to address the concerns raised in:
>   https://marc.info/?l=linux-rdma&m=158101337614772&w=2
> 
> The hfi1 driver dynammically allocates a struct device to represent the
> cdev in sysfs and devtmpfs (/dev/hfi1_x). On the other hand, the
> hfi1_devdata already contains a struct device in its ibdev field
> (hfi1_devdata.verbs_dev.rdi.ibdev.dev), and it is therefore possible to
> eliminate the dynamical allocation when creating the cdev. Since each
> device could be added to the sysfs only once and the function
> device_add() is already called for the ibdev in ib_register_device(),
> the function cdev_device_add() could not be used to create the cdev,
> even though the hfi1_devdata contains both cdev and ibdev in the same
> structure.
> 
> This patch eliminates the dynamic allocation by creating the cdev
> first, setting up the ibdev, and then calling the ib_register_device()
> to add the device to sysfs and devtmpfs.
> 
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
>  drivers/infiniband/hw/hfi1/device.c   |   23 ++++++++++++++++-------
>  drivers/infiniband/hw/hfi1/file_ops.c |    5 ++---
>  drivers/infiniband/hw/hfi1/hfi.h      |    1 -
>  drivers/infiniband/hw/hfi1/init.c     |   18 +++++++++---------
>  4 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
> index bbb6069..4e1ad5f 100644
> +++ b/drivers/infiniband/hw/hfi1/device.c
> @@ -79,10 +79,12 @@ int hfi1_cdev_init(int minor, const char *name,
>  		goto done;
>  	}
>  
> -	if (user_accessible)
> -		device = device_create(user_class, NULL, dev, NULL, "%s", name);
> -	else
> +	if (user_accessible) {
> +		device = kobj_to_dev(parent);
> +		device->devt = dev;

What is this doing?

The only caller passes:

parent == &dd->verbs_dev.rdi.ibdev.dev.kobj

So,

 1) the kobj_to_dev is obfuscation
 2) WTF? Why is it changing the devt inside a struct ib_device??

> +	} else {
>  		device = device_create(class, NULL, dev, NULL, "%s", name);
> +	}

And since there is only one caller and user_accessible == true, this
confusing code is dead, please clean this up.

Actually this whole thing would be a lot less confusing to read if this
function was just lifted into user_add().

>  
>  	if (IS_ERR(device)) {
>  		ret = PTR_ERR(device);
> @@ -92,20 +94,27 @@ int hfi1_cdev_init(int minor, const char *name,
>  		cdev_del(cdev);
>  	}
>  done:
> -	*devp = device;
> +	if (devp)
> +		*devp = device;
>  	return ret;
>  }
>  
> +/*
> + * The pointer devp will be provided only if *devp is allocated
> + * dynamically, as shown in device_create().
> + */

And the only caller passes NULL:

drivers/infiniband/hw/hfi1/file_ops.c:  hfi1_cdev_cleanup(&dd->user_cdev, NULL);

So why add this comment and obfuscation? Delete this function and call
cdev_del from the only call side

And even user_add /user_remove are only called from one place, so spaghetti

> diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
> index b06c259..8e63b11 100644
> +++ b/drivers/infiniband/hw/hfi1/hfi.h
> @@ -1084,7 +1084,6 @@ struct hfi1_devdata {
>  	struct cdev user_cdev;
>  	struct cdev diag_cdev;
>  	struct cdev ui_cdev;
> -	struct device *user_device;
>  	struct device *diag_device;
>  	struct device *ui_device;

And I wondered about these other cdevs.. but this is all some kind of
dead code too, please fix it as well.

..

And I'm looking at some of the existing code around the cdev and
wondering how on earth does it even work?

Why is it calling kobject_set_name()? Look in
Documentation/kobject.txt. This function isn't supposed to be used.

Shouldn't there be a struct device to anchor this in sysfs? I'm very
confused how this is working, where did the hif1_xx sysfs directory come
from?

Jason
