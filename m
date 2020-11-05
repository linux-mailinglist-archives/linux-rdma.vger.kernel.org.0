Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D02A87A8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKEUAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 15:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 15:00:08 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206DC0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 12:00:08 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so2037232qtp.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TFAJdFWarWIUEquRxlbKKUMaZIwh/sjWks082ZN0zzo=;
        b=TY09IapCpLxcVtoXoJotrsyxSfGlcsDfLp1YWv5QYiVbO/oSJQgJeUkt514lPsLwDQ
         EOt52QUH+A1/+HvAcbO/pD5ha2ZFtpqVRzXo8MlNcvj8199gaZMTUru6GeCJ3B1ThHea
         esq6tx3QeiJiN4LqhyLocuwp7yvShRmXQyQbvpWGZ/i1SwIKh7WAgUT9xTIJz05WA8bm
         GaNqJS8lndKiAv8MURXgvAKKyX7qRhIB5O7yOG4c/BXLPfUlAaTTjc/A2YoJX6nDSZHg
         IU9p1TgDM5ar5jF0JzWfvnb5Uv8HtDSeCA2rbq+zUPPI6E50nmKGsVRd6Ea9NQsDFhzX
         kXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TFAJdFWarWIUEquRxlbKKUMaZIwh/sjWks082ZN0zzo=;
        b=QYypQs3BE0oS225HV33gqLUvvnzac+DALqnfKZ+ThedK4taRc1ySYMhZAXe8MCnnYP
         NbAcwCYKFhz4cs/2voZF2nbMwMSRDXtXyfLg5sE9ap4FpY0Vx2O7F1nLlNHS/MQMnUz7
         CRm2QqST1WW7fxSLsDaRIcLCnkiwtuwoS16WfAWt2k5woiR6cVo7H+xGSXHKDaf5KYx9
         Vnv7wvj3paY7OtSwpvDB4mmu/UxzXCdOAGgoOL0pkfR8oPSv3dZZHi3iG925itbPcxJf
         TSPFgeEKRv/1GAfFZwHdQR+oSZvb+UrrZON8h94l9QC0gip1g1XVhiwceGZ/qD1smaJW
         AZzQ==
X-Gm-Message-State: AOAM533tourHSFZPI9vkgbsH7kalq+bPPRx/Bdlc+BrIacNV+9N3uyl2
        pyKE9hj8Oup9BSsoiWKHvboo3Hc98kAl5WVF
X-Google-Smtp-Source: ABdhPJwBTGN+qFwRrezz4Guaw/2VUvn/qnA9MXVRoCw4lCEyXp4psV5gfWO9GAYTcOLpfetpQXpLjw==
X-Received: by 2002:a05:622a:8d:: with SMTP id o13mr3663197qtw.146.1604606407260;
        Thu, 05 Nov 2020 12:00:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k15sm1589050qtq.11.2020.11.05.12.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:00:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kalQT-000N6E-Md; Thu, 05 Nov 2020 16:00:05 -0400
Date:   Thu, 5 Nov 2020 16:00:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201105200005.GJ36674@ziepe.ca>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca>
 <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
> On 03/11/2020 16:22, Jason Gunthorpe wrote:
> > On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
> >> On 03/11/2020 15:57, Leon Romanovsky wrote:
> >>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
> >>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
> >>>>> Add the ability to query the device's bdf through rdma tool netlink
> >>>>> command (in addition to the sysfs infra).
> >>>>>
> >>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
> >>>>
> >>>> Why? What is the use case?
> >>>
> >>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
> >>
> >> When taking system topology into consideration you need some way to pair the
> >> ibdev and bdf, especially when working with multiple devices.
> >> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
> > 
> > You are supposed to use sysfs
> > 
> > /sys/class/infiniband/ibp0s9/device
> > 
> > Should always be the physical device
> > 
> >> Why rdma tool? Because it's more intuitive than sysfs.
> > 
> > But we generally don't put this information into netlink BDF is just
> > the start, you need all the other topology information to make sense
> > of it, and all that is in sysfs only already
> 
> As the commit message says, it's in addition to the device sysfs.
> 
> Many (if not most) of the existing rdma netlink commands are duplicates of some
> sysfs entries, but show it in a more "modern" way.
> I'm not convinced that bdf should be treated differently.

Why did you call it BDF anyhow? it has nothing to do with PCI BDF
other than it happens to be the PDF for PCI devices. Netdev called
this bus_info

> Similarly to how you can see netdevs bdf through 'ethtool -i' in addition to
> sysfs, I think it's useful.

bus_info is incredibly old, it predates even the driver core to an
time when there really was no other way to get the information.

Jason
