Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7200D353180
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Apr 2021 01:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhDBXa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 19:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBXa0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 19:30:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84388C0613E6
        for <linux-rdma@vger.kernel.org>; Fri,  2 Apr 2021 16:30:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y2so4633492qtw.13
        for <linux-rdma@vger.kernel.org>; Fri, 02 Apr 2021 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DUrZ26ujqM3QH+AI2fr1q6gmaG6zG9DayC1eq0IxhSk=;
        b=VC23UchA4J9bfV/sfuT9otlTK2bD8j2XBa0RdA8wXN1iCDY4ehhZfOmbvIvnizSYXz
         dzQpEFn04N7wmFOzpZPsMZ/mo1/4AoaX9/fX5DCf/MxyRxaXYxJg/z6VMx9ebrtIXIZL
         Mh0y20k8HZZFmYoAUlCC/CEAa2+HN1ksO+WA8Dp3Y6SzL/auivv3nJWGW3lgdgRoQ4ab
         82W7LZfjiPO+6rtsaGclwHeChKw6j0vqAy7Ht4pr2LKNgHGqy55PMlhLF9XvxVKwbXF+
         CeDgl0yoYaQ56Avn9f54CnIcgYg6gSaKEuyQWgi2l5pf9aDorerWwdiSEDTFD2ZP6hwy
         EV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DUrZ26ujqM3QH+AI2fr1q6gmaG6zG9DayC1eq0IxhSk=;
        b=KVcMpqKP45Z1LUXNn5cC5wIZHYLvGoWjW5g97Pq6U0Y/KIPkzCdBDkRFs67wh/Esf7
         45cMb20GpLGCZS5g8wUTeVT2FvskrJtPjJfsqB96T1133Jc/xQPR0g5FvfiYmHI1NKK0
         oMpkGMAJamSRaVpPNh6X/ncXCuU3/jwI9bfV75bTzqCWrabYXJAswSJ3WxsLWKdG1hh7
         fDixi9GBHYutUGOn0UaQ54y0oa3f+tlRiRgm/Pd3yuPsgywOeeM0F45Zbl+TCXcshDJ/
         ULqmiwzZpses0ze6lp82xC0pIkAE7wcL7rzRdOQ+x9CqHaWLnxIfib0OKSfa8nIOFUSi
         OhBg==
X-Gm-Message-State: AOAM5339h2RPn6cWNXDLVcO2uR1Jpxc1DBmCRIyjtnKutEJLMbOWwB/Q
        c053fBM0w/fv0EQqMLEKEZavTZ9zDWa/UgP6
X-Google-Smtp-Source: ABdhPJyXq9JJVKh9ZPP03LEYB2MdprlBH5ccTsJoqe+CHuailVTPToie9FqXqBBwvulXgWZ2jd4m4A==
X-Received: by 2002:ac8:544:: with SMTP id c4mr13510366qth.248.1617406220566;
        Fri, 02 Apr 2021 16:30:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j6sm8695976qkl.84.2021.04.02.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 16:30:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lSTF4-0003Yk-So; Fri, 02 Apr 2021 20:30:18 -0300
Date:   Fri, 2 Apr 2021 20:30:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <20210402233018.GA7721@ziepe.ca>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104021555.08B883C7@keescook>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 04:03:30PM -0700, Kees Cook wrote:

> > relevant. It seems to me that the hw_counters 'struct attribute_group'
> > should probably be its own kobj within both of these structures so they
> > can have their own sysfs ops (unless there is some other way to do this
> > that I am missing).

Err, yes, every subclass of the attribute should be accompanied by a
distinct kobject type to relay the show methods with typesafety, this
is how this design pattern is intended to be used.

If I understand your report properly the hw_stats_attribute is being
assigned to a 'port_type' kobject and it only works by pure luck because
the show/store happens to overlap between port and hsa attributes?

> > I would appreciate someone else taking a look and seeing if I am off
> > base or if there is an easier way to solve this.
> 
> So, it seems that the reason for a custom kobj_type here is to use the
> .release callback. 

Every kobject should be associated with a specific, fixed, attribute
type. The purpose of the wrappers is to inject type safety so the
attribute implementations know they are working on the right stuff.

In turn, an attribute of a specific attribute type can only be
injected into a kobject that has the matching type.

This code is insane because it does this:

		hsag->attrs[i] = alloc_hsa(i, port_num, stats->names[i]);

		// This is port kobject
		struct kobject *kobj = &port->kobj;
		ret = sysfs_create_group(kobj, hsag); 
[..]
                // This is a struct device kobject
		struct kobject *kobj = &device->dev.kobj;
		ret = sysfs_create_group(kobj, hsag); 

Which is absolutely not allowed, you can't have a generic attribute
handler and stuff it into two different types! Things MUST use the
proper attribute subclass for what they are being attached to.

The answer is that the setup_hw_stats_() for port and device must
be split up and the attribute implementations for each of them have to
subclass starting from the correct type.

So we'd end up with two attributes for hw_stats

struct port_hw_stats {
    struct port_attr attr;
    struct hw_stats_data data;
};


struct device_hw_stats {
    struct device_attr attr;
    struct hw_stats_data data;
};

And then two show/set functions that bounce through the correct types
to the data.

And so on.

Jason
