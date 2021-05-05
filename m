Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAF374786
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhEER61 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 13:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhEER6P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 May 2021 13:58:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F371C043445
        for <linux-rdma@vger.kernel.org>; Wed,  5 May 2021 10:29:18 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j17so1804471qtx.6
        for <linux-rdma@vger.kernel.org>; Wed, 05 May 2021 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fojQ2PXj0G/XPL225fjb5EMP1GoQwlvE1vKQPnzG0g8=;
        b=H8/wac+roD0zr/mQrjnERr6NiF9XiIa85wQwHeCU8YtZbuIZWVVmestISt/QReZUSq
         x9qRqSPw/XKyzkyqaHz6tAmQFsLxWkd6pvyKpfp3i/q7S86PtQ7xcKHZs7l0b1wXNndG
         pwaJowF1D5xXcPtA4vIyMFYVkS3SqnmOcgVvpQ0O/YinHHbRrtCXwh7cDmhs2fGjR+4z
         a4/BhwbD1Zlbz6y1Z53ZmPONRzVb+oETDUV/u25WfYR/ZLZSQcyF/drX9XaFRiaELSFQ
         t6TbOhf11xDe/ULB3BARbleCkkdI8bAI+vMJ9iaDkeF72bUVzy9dzGJYHOPEN5oZbI7j
         YHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fojQ2PXj0G/XPL225fjb5EMP1GoQwlvE1vKQPnzG0g8=;
        b=G3ccIXOjPMyQNraMXfaENtfnDTyLjN9Av7Z7Oztl4oNgZWEX+XcilXLcpdwoQ2hIIJ
         pILIsSoNTfeeAMnRMocIbAxcMoqbTPAaUTCCaAfYf82aErvBHvCmQO4EveLvTEx+tJoc
         ZPAd+km736VfLh+Qc7pIruLhMDw6IqP4Nrv4MjTfHUlUrE2b4/X/QYI2p3zs9FnPbDD9
         EajkuvfnSF7IIjVnRPFLemTThnxMVdUHee8L+rIuap1MqGDgahmmMisyTgLBgi0lVIiT
         GqYHtzejeqpZBwgqgd8FNQuDm9+DDgpTJ4wLBc7rgjBmi47SEdFf7S/P6hRVQh6pXNzg
         t90w==
X-Gm-Message-State: AOAM531KHNKq/T/g+qD+sqE16aGTT8Tekcw4qudo5QQ8fqXzWHTu3sFF
        kF/2w4jiXDtwTXZLb+a8EAWVJA==
X-Google-Smtp-Source: ABdhPJyt2lSY/nPhbJPbVUr8rJDTNBoFXA01E//fEcJPmPzB91Jm0NrfyfLyjFX6+eSOMHephKpY1A==
X-Received: by 2002:ac8:6e87:: with SMTP id c7mr17134578qtv.358.1620235757561;
        Wed, 05 May 2021 10:29:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id z4sm5441793qtq.34.2021.05.05.10.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:29:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1leLKm-0017M9-8i; Wed, 05 May 2021 14:29:16 -0300
Date:   Wed, 5 May 2021 14:29:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <20210505172916.GC2047089@ziepe.ca>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210402233018.GA7721@ziepe.ca>
 <202104021823.64FA6119@keescook>
 <20210404135713.GB7721@ziepe.ca>
 <YJLHHpatWOgJo0Zk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJLHHpatWOgJo0Zk@kroah.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 05, 2021 at 06:26:06PM +0200, Greg KH wrote:
> > They are in many places, for instance.
> > 
> > int device_create_file(struct device *dev,
> >                        const struct device_attribute *attr)
> > 
> > We loose the type safety when working with attribute arrays, and
> > people can just bypass the "proper" APIs to raw sysfs ones whenever
> > they like.
> > 
> > It is fundamentally completely wrong to attach a 'struct
> > kobject_attribute' to a 'struct device' kobject.
> 
> But it works because we are using C and we don't have RTTI :)
>
> Yes, it's horrid, but we do it because we "know" the real type that is
> being called here.  That was an explicit design decision at the time.

I think it is beyond horrid. Just so everyone is clear on what is
happening here..

RDMA has this:

struct hw_stats_attribute {
	struct attribute	attr;
	ssize_t	(*show)(struct kobject *kobj,
			struct attribute *attr, char *buf);

And it has two kobject types, a struct device kobject and a ib_port
kobject.

When the user invokes show on the struct device sysfs we have this
call path:

dev_sysfs_ops
  dev_attr_show()
    struct device_attribute *dev_attr = to_dev_attr(attr);
      ret = dev_attr->show(dev, dev_attr, buf); 
        show_hw_stats()
          struct hw_stats_attribute *hsa = container_of(attr, struct hw_stats_attribute, attr)

And from the ib_port kobject we have this one:

port_sysfs_ops
  port_attr_show()
    struct port_attribute *port_attr =
      container_of(attr, struct port_attribute, attr);
       	return port_attr->show(p, port_attr, buf);
          show_hw_stats()
           struct hw_stats_attribute *hsa = container_of(attr, struct hw_stats_attribute, attr)

Then show_hw_stats() goes on to detect which call chain it uses so it
can apply the proper container of to the kobj:

	if (!hsa->port_num)
		dev = container_of((struct device *)kobj,
				   struct ib_device, dev);
	else
		port = container_of(kobj, struct ib_port, kobj);

There are several nasty defeats of the C typing system here:

 - A hw_stats_attribute is casted to device_attribute hidden inside
   container_of()

 - The 'show' function pointer is being casted from from a
     (*show)(kobject,attr,buf) to (*show)(device,device_attr,buf)
   This cast is hidden by the above wrong use of container_of()

 - The dev_attr 'struct device_attribute *' is casted directly to a
   'struct attribute *' and this cast is hidden because of the wrongly type
   function pointer

 - The dev 'struct device *' is casted directly to a 'struct kobject *'
   and like above this is hidden inside the wrongly typed function
   pointer.

 - All of the above is true again when talking about port_attribute
   and struct ib_port.

This all implicitly relies on the following unchecked and undocumated
relationships:
 - struct device's kobject is the first member in the struct
 - struct ib_port's kobject is the first member in the struct
 - The attr, show and store members are at the same offset
   in struct device_attribute and struct hw_stats_attribute

None of this is even slightly clear from the code. If Nathan hadn't
pointed it out I don't think anyone would have known..

> If that was a good decision or not, I don't know, but it's served us
> well for the past 20 years or so...

I agree with Kees, "my mind rebelled". I don't think it aligned with
the modern kernel style. If tooling starts to shine light on these
bast casts I feel it would only improve code quality.

For instance the patch Kees pointed at e6d701dca989 ("ACPI: sysfs: Fix
pm_profile_attr type")

This is a legitimate typing bug. ACPI should not have been using
struct device_attribute with a kobject creted by

  acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);

Certainly this RDMA code has no buisness being written like this
either, it nets out to saving about 50 lines of straightforward
duplicated code for a lot of worse junk.

Regards,
Jason
