Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E605D23D024
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 21:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgHET3y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgHERKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 13:10:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC7C0F26C2
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 08:20:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so35177211qkb.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/tKLJQerXAd3IgNPAHruQgQjEuVQ8X51x0/Hm0qS14o=;
        b=XkWRNKzos6RgtLNAoLG8ZqpBImUQJtQbl5iOZX6FYYABNq8W8UxSmfV5pZBOl6M8ha
         23CqhkftlOKAS2CUfwjzJD1w9gJN9S0x1Lg3ZQA5zwHPnOh9hSin+Xe6OikM5uskHI2w
         fvihzKHQKYICjQTiNNy4ccVCVMyjzEJU/w0R1gMGJOGhDGqo7CbsUqaT6qNVfAK8BeD4
         Aa9NW9VcCU72QTj6uTYFa9uXcJ5wgnByQxbu9N4V8g2e5Kmr6YZmYoGPVy+y8RIik3i9
         qy/4SlwwMX2Tt3Y+VuNhfF4eGCxhG5q4NcdQf9ZzkPhJ4hngmyu4VLfwpalUNMuSOjCJ
         DRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/tKLJQerXAd3IgNPAHruQgQjEuVQ8X51x0/Hm0qS14o=;
        b=bNvJyO7pN5jKYDHetKl35Yy/drugrWi/eastMsEGcZQ2XgSQZcH6ly5R8ALXRmoYrL
         h8i1yLSLsOaIk/d5AKLNaumI+UifMWGh5yHyoBUm9HCvinXPjMk4ZJ19UjRMYQTZJUFQ
         9HMu+7Wc1uvRTAIdEfaTXEeF6hceKAAtvH7frVWVTnO3Rr8qduzcovEMN/oVDP3OF/oC
         v/MN+rqikjW8UACDxv4gj+OQytm5WbxzFXPyCjTfmY39dCn79ZcuCXP3f3d/1duzDAq1
         4+/pRHXJbPj5S9A2lVYs0+SROOHPye+EgjecUj8+ZpE11T6Txb9sKVedA7AJrFn9w1yt
         jWzw==
X-Gm-Message-State: AOAM532eRym5uvDhca8NtXICEfEubdKSdUn3owNhwv5f5nEAESp6M8++
        u9G4rWKXZjCWOAS04GZCRv3c2Tqmf7A=
X-Google-Smtp-Source: ABdhPJwTuHqoGr+EOp/oEpmcu+tl2UY7H6KOYj4gWuTioPF0y42q1PQVq60jEk9mh3DtDWUVKuUzdQ==
X-Received: by 2002:a37:6741:: with SMTP id b62mr3781846qkc.217.1596640812168;
        Wed, 05 Aug 2020 08:20:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x24sm2502113qtj.8.2020.08.05.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:20:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k3LD7-003qYn-U3; Wed, 05 Aug 2020 12:20:09 -0300
Date:   Wed, 5 Aug 2020 12:20:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in netdevice_event_work_handler
Message-ID: <20200805152009.GR24045@ziepe.ca>
References: <0000000000005b9fca05aa0af1b9@google.com>
 <20200731211122.GA1728751@thinkpad>
 <20200802222226.GO24045@ziepe.ca>
 <20200804200013.GB263814@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804200013.GB263814@thinkpad>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 04, 2020 at 01:00:13PM -0700, Rustam Kovhaev wrote:
> On Sun, Aug 02, 2020 at 07:22:26PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jul 31, 2020 at 02:11:22PM -0700, Rustam Kovhaev wrote:
> > 
> > > IB roce driver receives NETDEV_UNREGISTER event, calls dev_hold() and
> > > schedules work item to execute, and before wq gets a chance to complete
> > > it, we return to ip_tunnel.c:274 and call free_netdev(), and then later
> > > we get UAF when scheduled function references already freed net_device
> > > 
> > > i added verbose logging to ip_tunnel.c to see pcpu_refcnt:
> > > +       pr_info("about to free_netdev(dev) dev->pcpu_refcnt %d", netdev_refcnt_read(dev));
> > > 
> > > and got the following:
> > > [  410.220127][ T2944] ip_tunnel: about to free_netdev(dev) dev->pcpu_refcnt 8
> > 
> > I think there is a missing call to netdev_wait_allrefs() in the
> > rollback_registered_many().
> calling it there leads to rtnl deadlock, i think we should call
> net_set_todo(), so that later when we call rtnl_unlock() it will
> execute netdev_run_todo() and there it will proceed to calling
> netdev_wait_allrefs(), but in ip tunnel i will need get
> free_netdev() to be called after we unlock rtnl mutex
> i'll try to send a new patch for review

Oh the whole register is called under rtnl? Yikes..

This is probably a systemic problem with register_netdevice error
unwind, not just ip tunnel

The other way to handle it would be to organize things so that
register cannot fail once it starts calling notifiers?

Jason
