Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AD35384C
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhDDN5W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDDN5W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Apr 2021 09:57:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB005C061756
        for <linux-rdma@vger.kernel.org>; Sun,  4 Apr 2021 06:57:15 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id t16so4452566qvr.12
        for <linux-rdma@vger.kernel.org>; Sun, 04 Apr 2021 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ZjxEGyqxVpobPm/RJ+EZNtUYuEiSg65YJlV16IYPyU=;
        b=LCW+fT8rx2qHIIP239+nDUBLp+c1282aG2+FqtHvbjuZI6brFk5QP6aCj9eROh0eQI
         GRfKmrH15iGTQdZFmnmNuDuERSzQR+t0ZlrNKQOngvVotuM5gUxBY0vdDKnJWZgL0kvh
         03gfu+aLd+hBeopKcIbFZ/vno2nJwwoGDhk/9nXBiG8Myw7/4OPpGRnE7jTdsU7KtzUM
         eM0ber+/GZWfef/mP3pSG48Qayj1qZc9RhVujD98ljtPjIdpiZXC1cpAhTlmwrDWG0I8
         Yl1GtgxO8PENZkacmAgZh8+WDdp2GVX+uGCvBkSRb8bkRq+HixHxbCPJosZysNt47uT9
         KqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ZjxEGyqxVpobPm/RJ+EZNtUYuEiSg65YJlV16IYPyU=;
        b=QhstCHXM4VxEJU0oWUf66d39MNslRLJNdvqUx9yzv6ChmTtFSizwcd40WC1CwmHEgJ
         K9Y3wbG76S5XfGoXkU5HHYmWADEFO+G6w3B1VflqlmwiZtTTKEjHcOJ3VADN32Vffeo0
         zykrKATNfezvis9P8ZIjqnY9epGZbLGpSpnMlhmw7P/KJ0sLo2g89cyxcF4dAVAJhJOI
         B1roCKIWSJq8JdwgbnzrF6G+I6U5u8lSB0vaWqheAYv5K4OY/onvldDxTE6CuD/zABFN
         ubNF42sM0nvcydPWJOY2Ges5mXcZHI4hFpc71InWpkV+i5350FNSzC9VRSkldsajJHm5
         Fvsw==
X-Gm-Message-State: AOAM5309+tLkx11HvSHVcgB5UZLRZJ2qrnhlkzEaXGE/WArrjz7a5Ttw
        ueAKVLnXIlvIMgI7Fy/RHjlqOxatcZ1PUUtq
X-Google-Smtp-Source: ABdhPJzKBN066Q7y6DNJFJhqNXnOig4um47v1oV/4zA5WZGlgjJCCnLgb3RbRyV5vXJbxWckMC4JkQ==
X-Received: by 2002:a0c:f749:: with SMTP id e9mr1900291qvo.14.1617544634869;
        Sun, 04 Apr 2021 06:57:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id d2sm9830886qte.84.2021.04.04.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 06:57:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lT3FZ-000Vay-2X; Sun, 04 Apr 2021 10:57:13 -0300
Date:   Sun, 4 Apr 2021 10:57:13 -0300
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
Message-ID: <20210404135713.GB7721@ziepe.ca>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210402233018.GA7721@ziepe.ca>
 <202104021823.64FA6119@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104021823.64FA6119@keescook>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 06:29:55PM -0700, Kees Cook wrote:
> On Fri, Apr 02, 2021 at 08:30:18PM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 02, 2021 at 04:03:30PM -0700, Kees Cook wrote:
> > 
> > > > relevant. It seems to me that the hw_counters 'struct attribute_group'
> > > > should probably be its own kobj within both of these structures so they
> > > > can have their own sysfs ops (unless there is some other way to do this
> > > > that I am missing).
> > 
> > Err, yes, every subclass of the attribute should be accompanied by a
> > distinct kobject type to relay the show methods with typesafety, this
> > is how this design pattern is intended to be used.
> > 
> > If I understand your report properly the hw_stats_attribute is being
> > assigned to a 'port_type' kobject and it only works by pure luck because
> > the show/store happens to overlap between port and hsa attributes?
> 
> "happens to" :) Yeah, they're all like this, unfortunately:
> https://lore.kernel.org/lkml/202006112217.2E6CE093@keescook/

All? I think these are all bugs, no?

struct kobj_attribute is only to be used with a kobj_sysfs_ops type
kobject

To cross it over to a 'struct device' kobj is completely wrong, the
same basic wrongness being done here.
 
> I'm not convinced that just backing everything off to kobject isn't
> simpler?

It might be simpler, but isn't right - everything should continue to
work after a patch like this:

--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -67,6 +67,7 @@ struct ib_port {
 
 struct port_attribute {
 	struct attribute attr;
+	uu64 pad[2];
 	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
 	ssize_t (*store)(struct ib_port *, struct port_attribute *,
 			 const char *buf, size_t count);

If it doesn't it is still broken.

Using container_of() with the wrong types is an unconditional
error. A kasn test to catch this would be very cool (think like RTTI
and dynamic_cast<>() in C++)

> > And then two show/set functions that bounce through the correct types
> > to the data.
> 
> I'd like to make these things compile-time safe (there is not type
> associated with use the __ATTR() macro, for example). That I haven't
> really figured out how to do right.

They are in many places, for instance.

int device_create_file(struct device *dev,
                       const struct device_attribute *attr)

We loose the type safety when working with attribute arrays, and
people can just bypass the "proper" APIs to raw sysfs ones whenever
they like.

It is fundamentally completely wrong to attach a 'struct
kobject_attribute' to a 'struct device' kobject.

Which is what is happening here and the link above.

Jason
