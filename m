Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222932730D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 01:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEVX5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 19:57:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39023 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEVX5k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 19:57:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so4662022qtk.6
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ep9uVHpBGZswzwZ+H/eF/1/q1Yi9oKaegrCzMMn+v2w=;
        b=Q1hKWyHArMJk0cuB6S0l9Ps4LFjPimg+ITsAv/pNx1HPV30Y0Dw5vtjo5ZJdvu6uDU
         uPLkBnGxRltUikh5/RqnfW79NkePV+iLYOoOU2MZW0dGzUcIeDu2UjkmOW+72KOG+Z95
         Os8nZL84gacPJsIDatNU8+oDl61IP9Wf+bHI48QXLL3m+HTuFfmqe0aTGUECJYAeXj1U
         C6AYMQYiU26cdRliq/8oE9WKABTISlXuBsRwuKf6ehITMVfulLupiuy5N/Ac+bHWvVWh
         9ESy3JVc3OeFWxRykU8wGeRnSFhJHV66xh0QhkSgpXG/QexM/GevHVjean7GbYVYi+8w
         4y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ep9uVHpBGZswzwZ+H/eF/1/q1Yi9oKaegrCzMMn+v2w=;
        b=f7qjsGQUKuwN1dfiKyGc0iVkhw5K+58tUJpSbny6p/zFgFgJ6n5w7HSefY4MKkvw7k
         1LII15iH/obmmR1jmNcunHvfW2/9I/ResLqhWmX13nlvO9irbS37vESNSoLoyY0R2UYz
         sbeZO9uVzUwDlmUxder5oXzOX4jkJihQPAIgnH9ioK1V4UNDN8zzWJGZ1B2OCjF/6PoE
         VPBABUgnNCLdE1M6p5NPQzdyqOE9LBWG0PZWOVTQ6ysf0pLnam68RxJ2E3CtWXIwtxF5
         BYNCFvr+1gaJmnFGgmbB05Xvesu6+yXsrZNAGL5kxPFPFEv1B3a4rxRrjdDDK+2IU3Us
         Xlgg==
X-Gm-Message-State: APjAAAUc2X7M05/FWdh+floIkoUYDo8wnGjJjlvm8MbjjickQOPF5H6h
        514Ttmko2ZphNjpUjfWV5jRkLw==
X-Google-Smtp-Source: APXvYqzaonhnkp/bUloxWlJ3maBzgQam/abanIz+C6FRxel/0h/X8xe2Qu7CLsQrUUqePsk4cAL/DQ==
X-Received: by 2002:aed:2494:: with SMTP id t20mr75861244qtc.135.1558569459047;
        Wed, 22 May 2019 16:57:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q66sm12719518qke.66.2019.05.22.16.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 16:57:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTb73-0001PC-MU; Wed, 22 May 2019 20:57:37 -0300
Date:   Wed, 22 May 2019 20:57:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522235737.GD15389@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522174852.GA23038@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:

> > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > (prefetch and not and different sizes). Seems to work ok.
> > 
> > Urk, it already doesn't apply to the rdma tree :(
> > 
> > The conflicts are a little more extensive than I'd prefer to handle..
> > Can I ask you to rebase it on top of this branch please:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > 
> > Specifically it conflicts with this patch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34

There is at least one more serious blocker here:

config ARCH_HAS_HMM_MIRROR
        bool
        default y
        depends on (X86_64 || PPC64)
        depends on MMU && 64BIT

I can't loose ARM64 support for ODP by merging this, that is too
serious of a regression.

Can you fix it?

Thanks,
Jason
