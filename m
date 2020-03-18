Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42578189D08
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCRNb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:31:59 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39112 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgCRNb7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 09:31:59 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so8814591qvf.6
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qzAgeY2gtUUjppeja8hkbhLFuahvZLkObqjCiaqSXN0=;
        b=nOcZJpukzdbrC93OBPLQ/T1ljCPNBFp6cIaa33WZYPBtacX8NRYbYNKokVo/Y8J+xi
         nJdhdBYYn1WJw3qanylpSgRUdRDiTygBtKUYuQSHSAaQbBmPitgqZ8ik00G3Dv6Lokr1
         aI094T1OooA1QHiWsqSa0eRb9n21VKd+eZqx/IIDFtkxS1Pug65hBm2DinwiaYSCsXjc
         bJ6n/T++xxJ8lhW705W4YtOxeHMiOBeg1TfgAJIUdz+U0BQYkPTyGGpJeLPlLD55EBoR
         7rJQ07TLUA5pddAMG47O+7Wzqjr7h+N7/KXIiEiIjoWPTx6Cj7uYvTGtO1s9ansJESCH
         J7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qzAgeY2gtUUjppeja8hkbhLFuahvZLkObqjCiaqSXN0=;
        b=DIi2E8sIG1J2lhXdPAPNZUAWbQ+G7alWmjoTptfQciC0VgI5l+ttUi6+G128QMrHMA
         AeS2LKZn/1yPvnk5jIJWWBgEGpzRtpGyixjJcYFx4x1FLC+aUo7xFz9FGSSAHyTocusb
         jjRqlMSX7JVDFmGSDxG7+5JD8tmakVi/bYMEPy1J5/3+5jeS4qCDHV4eSu3l8MmF49/6
         mjQqWPqxu7EBSeI9WgZnj5Tv785j8GiVlht80PsT7hKkNjIwF8eGyFMDWWH74UPKzLTV
         wcAIkQJ03rkPNtggP/PvaHQUEgSj/DIHexbQA9Y/4zRm6sEpEpCE10NSQPfQbMIaBYYU
         oJng==
X-Gm-Message-State: ANhLgQ01CL9lOuDNhY0Sv1Ml07HbHiPnILMJ7TKZ3d1AFz8PN4u38cLy
        y9tNSJhXRBV+lscQNiqzsXntNg==
X-Google-Smtp-Source: ADFU+vuT3pNTBo9Lvua7ZKsM5p0iV2N1J3n1fcrHADg2nHk5klcNXgmaajYZ5LwE2XBzp/QPGDD98A==
X-Received: by 2002:a05:6214:14a:: with SMTP id x10mr4374877qvs.158.1584538316376;
        Wed, 18 Mar 2020 06:31:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u34sm943338qtj.60.2020.03.18.06.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 06:31:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEYnb-0006hH-Cy; Wed, 18 Mar 2020 10:31:55 -0300
Date:   Wed, 18 Mar 2020 10:31:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Message-ID: <20200318133155.GA20941@ziepe.ca>
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

What do the sysfs paths for the cdev look like now?

Jason
