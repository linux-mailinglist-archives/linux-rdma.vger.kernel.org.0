Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBA39A0F
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 03:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfFHBrW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 21:47:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40592 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbfFHBrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 21:47:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so2440099qkg.7
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nc6xGH604Ibjz1J23Rb+p/HSbXggztW0x+56PG9xNfU=;
        b=RzikS2kkWB0yrELIxgOKLXI7n4K6BJfDButHAVBC/ZMtnKj9yRR01Gnk1MX5Wvtry3
         kC7LOlMabScS8+6SgA690KRqkMx4YF/wk5KRtrM8TUpQIPevIFuD9RLh756wG5jzrO0u
         bszQkMJEE+oGUuSRlcoJcg81LGTFNkoJQzy6/hRMAA2ruxbSXL9D1pPwzRGFl89qiHD8
         bFLVrpGj4wTlH/KA7c/LZKJAdoc5Ll+42EURexdS0k7qha7cppex+m6A9m9qANDBZwGK
         ZC2QbDqv7tCrDTHZw0yqwsuUkrQHcVWL95VP2Zxvnz/oWzhVXifsSAXOWXXRMR0JbrBC
         I82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nc6xGH604Ibjz1J23Rb+p/HSbXggztW0x+56PG9xNfU=;
        b=hPZZGnfV1SvgifgQKySbGoYnSEqHjFcEBssQ4yIlJWpL1+IbXaQbKrc0n12PkfT2qt
         GwV7fV7Rh1y3iwR1lWq5D5Rc5EH3GNN26ueIeFdD/XzQ/OOwk5y5c52T252pJnzlFQUW
         0xGgAbsUOi4goPjrbb38QWS51g4mgOhvXEAKNqN7IEifaHBpCiarUup/DpT17M4ZkXJ4
         68Ub5ewvxp7QxmdJP3xX3S+zwyKjOqyAfZxtzIEhxjsCqj0R0HhlFBnVX7MJiaLZ3Kg3
         cDDgbEY4GkWnrq5cu1v/RhjQCRiFjLc3OpFySiEUu6bb3pldACauWYlYuRuL5LayhmxG
         1x3Q==
X-Gm-Message-State: APjAAAWMWplvXgiM8cHHX3d4kLKzd/UexanlHANFzuMk8RidJ76NDgFG
        1pE9xngXpIhXk79OpOixIy57lA==
X-Google-Smtp-Source: APXvYqzJ0Y9PkmyZQUNKepOagJid3O/yJSUEccWesudwHooEMgZ4TRfl4qAnoz7gxWh5y3LkbErzsw==
X-Received: by 2002:a05:620a:1285:: with SMTP id w5mr37337035qki.302.1559958441410;
        Fri, 07 Jun 2019 18:47:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m4sm1851701qka.70.2019.06.07.18.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 18:47:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZQS0-0002Fo-D2; Fri, 07 Jun 2019 22:47:20 -0300
Date:   Fri, 7 Jun 2019 22:47:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
Message-ID: <20190608014720.GC7844@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <6833be96-12a3-1a1c-1514-c148ba2dd87b@nvidia.com>
 <20190607191302.GR14802@ziepe.ca>
 <e17aa8c5-790c-d977-2eb8-c18cdaa4cbb3@nvidia.com>
 <20190607204427.GU14802@ziepe.ca>
 <ba55e382-c982-8e50-4ee7-7f05c9f7fafa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba55e382-c982-8e50-4ee7-7f05c9f7fafa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 03:13:00PM -0700, Ralph Campbell wrote:
> > Do you see a reason why the find_vma() ever needs to be before the
> > 'again' in my above example? range.vma does not need to be set for
> > range_register.
> 
> Yes, for the GPU case, there can be many faults in an event queue
> and the goal is to try to handle more than one page at a time.
> The vma is needed to limit the amount of coalescing and checking
> for pages that could be speculatively migrated or mapped.

I'd need to see an algorithm sketch to see what you are thinking..

But, I guess a driver would have figure out a list of what virtual
pages it wants to fault under the mmap sem (maybe use find_vam, etc),
then drop mmap_sem, and start processing those pages for mirroring
under the hmm side.

ie they are two seperate unrelated tasks.

I looked at the hmm.rst again, and that reference algorithm is already
showing that that upon retry the mmap_sem is released:

      take_lock(driver->update);
      if (!range.valid) {
          release_lock(driver->update);
          up_read(&mm->mmap_sem);
          goto again;

So a driver cannot assume that any VMA related work done under the
mmap before the hmm 'critical section' can carry into the hmm critical
section as the lock can be released upon retry and invalidate all that
data..

Forcing the hmm_range_start_and_lock() to acquire the mmap_sem is a
rough way to force the driver author to realize there are two locking
domains and lock protected information cannot cross between.

> OK, I understand.
> If you come up with a set of changes, I can try testing them.

Thanks, I make a sketch of the patch, I have to get back to it after
this series is done.

Jason
