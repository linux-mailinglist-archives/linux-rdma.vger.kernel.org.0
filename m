Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FC374711
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhEERm7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 13:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238904AbhEERk5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 May 2021 13:40:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4BDE608FE;
        Wed,  5 May 2021 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620236399;
        bh=ZjWFsZx1U67ZQFN1wQdlYA9nKqiS+q/v3JEstpo4rD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhWldoB3roWUH6qAvHDRmFA/OCZIr7MxdQaxSH1aBPIFILc7cA8mJ6zPi+4jCTNV0
         UJhgyF+qrx55YK9btsBBiZmE6O1+GOBLHCFp3U+jGeCpbg4IJri6a8VaddCv0Na3Iw
         TtLhk2xDP4hqdBVHF0+73qviCCeajeG05p7u4Mv0=
Date:   Wed, 5 May 2021 19:39:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <YJLYbCIKgLCZlcOv@kroah.com>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210402233018.GA7721@ziepe.ca>
 <202104021823.64FA6119@keescook>
 <20210404135713.GB7721@ziepe.ca>
 <YJLHHpatWOgJo0Zk@kroah.com>
 <20210505172916.GC2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505172916.GC2047089@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 05, 2021 at 02:29:16PM -0300, Jason Gunthorpe wrote:
> On Wed, May 05, 2021 at 06:26:06PM +0200, Greg KH wrote:
> > > They are in many places, for instance.
> > > 
> > > int device_create_file(struct device *dev,
> > >                        const struct device_attribute *attr)
> > > 
> > > We loose the type safety when working with attribute arrays, and
> > > people can just bypass the "proper" APIs to raw sysfs ones whenever
> > > they like.
> > > 
> > > It is fundamentally completely wrong to attach a 'struct
> > > kobject_attribute' to a 'struct device' kobject.
> > 
> > But it works because we are using C and we don't have RTTI :)
> >
> > Yes, it's horrid, but we do it because we "know" the real type that is
> > being called here.  That was an explicit design decision at the time.
> 
> I think it is beyond horrid. Just so everyone is clear on what is
> happening here..
> 
> RDMA has this:
> 
> struct hw_stats_attribute {
> 	struct attribute	attr;
> 	ssize_t	(*show)(struct kobject *kobj,
> 			struct attribute *attr, char *buf);
> 
> And it has two kobject types, a struct device kobject and a ib_port
> kobject.
> 
> When the user invokes show on the struct device sysfs we have this
> call path:
> 
> dev_sysfs_ops
>   dev_attr_show()
>     struct device_attribute *dev_attr = to_dev_attr(attr);
>       ret = dev_attr->show(dev, dev_attr, buf); 
>         show_hw_stats()
>           struct hw_stats_attribute *hsa = container_of(attr, struct hw_stats_attribute, attr)
> 
> And from the ib_port kobject we have this one:
> 
> port_sysfs_ops
>   port_attr_show()
>     struct port_attribute *port_attr =
>       container_of(attr, struct port_attribute, attr);
>        	return port_attr->show(p, port_attr, buf);
>           show_hw_stats()
>            struct hw_stats_attribute *hsa = container_of(attr, struct hw_stats_attribute, attr)
> 
> Then show_hw_stats() goes on to detect which call chain it uses so it
> can apply the proper container of to the kobj:

Wait, what?  That's not how any of this was designed, you should not be
"sharing" a callback of different types of objects, because:

> 
> 	if (!hsa->port_num)
> 		dev = container_of((struct device *)kobj,
> 				   struct ib_device, dev);
> 	else
> 		port = container_of(kobj, struct ib_port, kobj);

Yeah, ick.

No, that's not how this was designed or intended to be used.  Why not
just have 2 different show functions?

thanks,

greg k-h
