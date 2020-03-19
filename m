Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE84A18C2B8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 23:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCSWEG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 18:04:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39629 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSWEG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 18:04:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id f20so3339491qtq.6
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QaxRC7+az1fwzVOX+xgzQZNHvudMK0SBWpx/6A0r6ks=;
        b=DPRHPb1XlbpXETxEf42FuiMVrEz1C1GYH+5P6MexweDwgbHz3Al3AiuaKJ1hNSbC8+
         K19HeroSBKEpNpPENzKTdccYILYJtZuIFtUQe/NtTxLA6QrQaCcLmF75fhlq5quD+VPd
         17VWqjLdg8X/Av2enWFx2T5LVsBpsrxhFKki7enfZgiVxmn4OTIfRHWlcc+k/lR/3g9E
         s3Dr56fsmlZnRp1JhxpbkqF4TkVGA6F7IP4SKfkOrWmNA6UEWXs9qq8/CKsFyvFtVYL3
         +2U+HsqnRe6GSZJAPDGb/24idqnrcBD4jRQ5A0BtiFWJ/A1H98sDyyLZ0ecY5MGnzUvP
         VLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaxRC7+az1fwzVOX+xgzQZNHvudMK0SBWpx/6A0r6ks=;
        b=dWdzGjo5LQjSjn9UvT3pKY9eBOqU5KzG002p7fxJQZx4zE07rICEzi5/e4JBO/Oum7
         868b9uDBAxnrB7vzVpqDXep0qHzbTNsPKPABSgWCxJfiKNRZgzhcPphpUqCOeKPnVqEg
         l5lgwPL4u6nbL807wp8E/GLNHY30yseuxAQwLGw9Zq00c7onOHU/qQf/atw4/fGtal5J
         tipgZl10FzDZSGEWksF4Xl4kthVbXwCi7m+ymAbz4CgFonCtwg/WjEDa5jevcPGhlV3P
         yR/9u9KSlJGNx6Wq/AXL4qLhIZ3jeiLUQdpKH2UtKSTJoyzL05EyKN3VdJGIo2VJFj10
         dE5Q==
X-Gm-Message-State: ANhLgQ1GFTzeKSkcfGI4HhDG7bUgmLxqFNRm/4+LB8WZEAXZuQ4SBNc7
        vzMHpJOxtyV8s4msr4vPxhXsLopd9mB/8g==
X-Google-Smtp-Source: ADFU+vt4Q5gQ6ruer+T6NJYX3fBawavJDBTuF07+7WQ7KiCH6CJtNvSSK3L9T6AKu2OWpB8uRTVGGg==
X-Received: by 2002:ac8:7c9c:: with SMTP id y28mr5204023qtv.58.1584655445244;
        Thu, 19 Mar 2020 15:04:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t55sm2732242qte.24.2020.03.19.15.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 15:04:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jF3Gm-0006TN-0i; Thu, 19 Mar 2020 19:04:04 -0300
Date:   Thu, 19 Mar 2020 19:04:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>
Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Message-ID: <20200319220403.GN20941@ziepe.ca>
References: <20200317160510.85914.22202.stgit@awfm-01.aw.intel.com>
 <20200318234938.GA19965@ziepe.ca>
 <BY5PR11MB3958F9E412A2033B6293772686F40@BY5PR11MB3958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB3958F9E412A2033B6293772686F40@BY5PR11MB3958.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 09:46:54PM +0000, Marciniszyn, Mike wrote:
> > Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
> > 
> > The only place that uses seqlock in infiniband is in hfi1
> >
> > It only calls seqlock_init and write_seqlock
> >
> > Never read_seqlock
>
> The sdma code uses read_seqbegin() and read_seq_retry() to avoid the spin
> that is in that is in read_seqlock().

Hm, I see.. I did not find these uses when I was grepping, but now I'm
even less happy with this :(

> The two calls together allow for detecting a race where the
> interrupt handler detects if the base level submit routines
> have enqueued to a waiter list due to a descriptor shortage
> concurrently with the this interrupt handler.

You can't use read seqlock to protect a linked list when the write
side is doing list_del. It is just wrong.

> The full write_seqlock() is gotten when the list is not empty and the
> req_seq_retry() detects when a list entry might have been added.

A write side inside a read_side? It is maddness.

> SDMA interrupts frequently encounter no waiters, so the lock only slows
> down the interrupt handler.

So, if you don't care about the race with adding then just use
list_empty with no lock and then a normal spin lock

All this readlock stuff doesn't remove any races.

> > Please clean this mess too.
> 
> The APIs associated with SDMA and iowait are pretty loose and we
> will clean the up in a subsequent patch series.  The nature of the locking
> should not bleed out to the client code of SDMA.   We will adjust the
> commit message to indicate this.

So what is the explanation here? This uses a write seqlock for a
linked list but it is OK because nothing uses the read side except to
do list_empty, which is unnecessary, and will be fixed later?

Jason
