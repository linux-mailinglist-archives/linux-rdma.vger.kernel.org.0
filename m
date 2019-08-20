Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA07D967AF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTRiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:38:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34801 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTRiO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Aug 2019 13:38:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id m10so5203729qkk.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t/XucQk/F+uHSqHuBS2YrnHXMmID5xflFtz7nTUyQdQ=;
        b=bckHKnzaSP1IJnDDGsBm6dmBKwP2gQFWZpK+sG9FsrTRv8UhFKdG0mgtwPw3BfVtin
         VuhSkAXZsux9oJpk8OgJunoVUnVuU0LlLUZIjdQR7vv1P0Sq7deX9BOvm5okLKcEwmPF
         56Ib3iJwAw1rAy1hktg4wTUOH3e6tsb/LKZTMvocNTv0K6y49c8HTz2yEAHVitA6k8RF
         ND+PNkrGg7amvPkGCw835L8Vluu6NG9zx6jQTUfxQdODGYXOAly0lGwSFyXl48L525Dj
         9eER+VAVKAvT1QVdMSPSE/EY2Vs0m26UziVPSXl/XKP81vOOkrHi9NPVpLSQiAOJLDkk
         5MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t/XucQk/F+uHSqHuBS2YrnHXMmID5xflFtz7nTUyQdQ=;
        b=HPEVMn8N+CsXL2HRLyueZAaB2VwhdmdAqhJ8mbzFBh0sH5gRx3Cz75rac7OLme8dsH
         PfwQn+SJaZrLGSLCJ6/V+I/aMMzFGppwUO8iQGSyWRCCzQpHr/MUHItfKZxDFfz55nvP
         0muZYYrnmumjQlvQM7fa0kQxk80QN6SWi0popgnNmZQS0wuYMvd/qHnqLJz9cElXNSD8
         AJpzluVdxYBZTBemwh0PKSk+IdmE++hwsJUrqCbg2lmyx6ggk39TbmToATJrkqZasRX1
         8TieFFhFDwpXwPRnBxRxK94QXQsEMoFmxvdCM2d8xAw9ZhfKxQWBBp5BkAE3ETDW3J+9
         WrGw==
X-Gm-Message-State: APjAAAW9I35rgSYSr5ldB2zfDH3Ad1C38e3A2LRUCXR9uovoemufAqMg
        hkMMnpiw/TiRetLYRd8kaCRJKg==
X-Google-Smtp-Source: APXvYqwtSww+Mj7BIpUXNkgW1GL1xrnHxjogfyBZorKKh+//l8c2RRuRKSFSgwDWK6b+RCJQ+rtq7g==
X-Received: by 2002:a05:620a:659:: with SMTP id a25mr26865992qka.148.1566322693238;
        Tue, 20 Aug 2019 10:38:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q6sm8766686qke.109.2019.08.20.10.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 10:38:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i085E-00059H-7M; Tue, 20 Aug 2019 14:38:12 -0300
Date:   Tue, 20 Aug 2019 14:38:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/8] Fixes for v5.3
Message-ID: <20190820173812.GI29246@ziepe.ca>
References: <20190815083834.9245-1-leon@kernel.org>
 <a263ac8f6c8340f050ca28394361aa956ac94cb4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a263ac8f6c8340f050ca28394361aa956ac94cb4.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 12:56:37PM -0400, Doug Ledford wrote:
> On Thu, 2019-08-15 at 11:38 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> > 
> > Hi,
> > 
> > This is a collection of new fixes for v5.3, everything here is fixing
> > kernel crash or visible bug with one exception: patch #5 "IB/mlx5:
> > Consolidate use_umr checks into single function". That patch is nice
> > to have improvement to implement rest of the series.
> > 
> > Thanks
> > 
> > Ido Kalir (1):
> >   IB/core: Fix NULL pointer dereference when bind QP to counter
> > 
> > Jason Gunthorpe (1):
> >   RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
> > 
> > Leon Romanovsky (2):
> >   RDMA/counters: Properly implement PID checks
> >   RDMA/restrack: Rewrite PID namespace check to be reliable
> > 
> > Moni Shoua (4):
> >   IB/mlx5: Consolidate use_umr checks into single function
> >   IB/mlx5: Report and handle ODP support properly
> >   IB/mlx5: Fix MR re-registration flow to use UMR properly
> >   IB/mlx5: Block MR WR if UMR is not possible
> 
> Hi Leon,
> 
> I took everything except Jason's patch to for-rc.  He had tagged his
> patch in patchworks as under review by himself, mainly because there are
> some conflicts with other hmm patches I think, so he wanted to process
> all the patches himself on a distinct branch to resolve the issues. 
> Thanks.

Ah, I thought that got grabbed alread

Can you take it but rebase it to be the first patch on top of v5.3-rc5
in the -rc branch?

Thanks,
Jason
