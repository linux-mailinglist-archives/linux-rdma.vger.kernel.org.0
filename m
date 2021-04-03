Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146A33531F1
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Apr 2021 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDCBaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhDCBaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 21:30:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65AC061788
        for <linux-rdma@vger.kernel.org>; Fri,  2 Apr 2021 18:29:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d8so3176227plh.11
        for <linux-rdma@vger.kernel.org>; Fri, 02 Apr 2021 18:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e2qTCTWRtt98zYQjob4A4IBP/hdRfq2CWqOcFYJH1gk=;
        b=EqRbJp8vUMJGXbr17BRNz2nsRO4xaoAkNZtLabGOswgMC/ZN9rCRZmPMUb0AdEKewu
         +RsFWmxqPWWrY+Al2jUBokfFcU1JdfEKIE2WqfveQEGt6wM80MHN/MTgMOMOqZpfrmvR
         QAeNyBAhAT0+9I7SSq89pMB2HK+tJRO97wwnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2qTCTWRtt98zYQjob4A4IBP/hdRfq2CWqOcFYJH1gk=;
        b=oSNCKLAXKEp1uk6QbhVX6nZAfYhD7zXlE2SrT6GMep+obeZ7Flth48PtXzSLGyHOw4
         EueGxd+L83qqQfJOfEgFAwr+oZJSkCrKAxpV0WF88JbbewY3cGp+0BAj43kNaNx22Wwg
         4PEk6SgYFrTIAIbaWFcJqdnVHoVtzqB39F/I04/jmIfvp/Q51234QlWk297Mi9pmnwwM
         24kpPbEawNrZ3Hjwo0gbAEQjBkQ4jkJh/335sMd9sFlgMnXAY5dhlHLANOxp9BPabo7A
         GAunGtc6eAzYGzBRb9Z4v5LL3qVFp5KiWhXcrvvOxTegS0TQq0OkTQxshNmBEdJIHI38
         ascA==
X-Gm-Message-State: AOAM533bZQCI/JSYXmPhWQFEY/M5Qkdt/9+lABIiTX8/+pdOqSnlqNGD
        rh4rY0apK0BfTUK8GoU97R+U/Q==
X-Google-Smtp-Source: ABdhPJxKRvq+ao9XQxJWn30IPQ8sZBNEuZNIP+V72rxkFwJrIAKUyLBZkbNGwo6CCJ5NzfdTYYfmaw==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr16752037pjr.123.1617413398512;
        Fri, 02 Apr 2021 18:29:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y29sm9476046pfp.206.2021.04.02.18.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:29:57 -0700 (PDT)
Date:   Fri, 2 Apr 2021 18:29:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <202104021823.64FA6119@keescook>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210402233018.GA7721@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402233018.GA7721@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 08:30:18PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 02, 2021 at 04:03:30PM -0700, Kees Cook wrote:
> 
> > > relevant. It seems to me that the hw_counters 'struct attribute_group'
> > > should probably be its own kobj within both of these structures so they
> > > can have their own sysfs ops (unless there is some other way to do this
> > > that I am missing).
> 
> Err, yes, every subclass of the attribute should be accompanied by a
> distinct kobject type to relay the show methods with typesafety, this
> is how this design pattern is intended to be used.
> 
> If I understand your report properly the hw_stats_attribute is being
> assigned to a 'port_type' kobject and it only works by pure luck because
> the show/store happens to overlap between port and hsa attributes?

"happens to" :) Yeah, they're all like this, unfortunately:
https://lore.kernel.org/lkml/202006112217.2E6CE093@keescook/

This is the first that I've seen that crossed kobj_types in the same
group, though. :)

> > > I would appreciate someone else taking a look and seeing if I am off
> > > base or if there is an easier way to solve this.
> > 
> > So, it seems that the reason for a custom kobj_type here is to use the
> > .release callback. 
> 
> Every kobject should be associated with a specific, fixed, attribute
> type. The purpose of the wrappers is to inject type safety so the
> attribute implementations know they are working on the right stuff.

Right -- though it's not specifically required to be a fixed attribute.
It can just be a "generic" kobject. This seems to happen a lot when
something wants to show up a global or const value in /sys

> The answer is that the setup_hw_stats_() for port and device must
> be split up and the attribute implementations for each of them have to
> subclass starting from the correct type.

I'm not convinced that just backing everything off to kobject isn't
simpler?

> And then two show/set functions that bounce through the correct types
> to the data.

I'd like to make these things compile-time safe (there is not type
associated with use the __ATTR() macro, for example). That I haven't
really figured out how to do right.

-- 
Kees Cook
