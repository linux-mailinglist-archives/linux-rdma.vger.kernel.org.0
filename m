Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE13D8E7C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhG1NFz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 09:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhG1NFy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 09:05:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2697460E09;
        Wed, 28 Jul 2021 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627477552;
        bh=4np9wk+yiG/x8xYaEtb+gM6wwFNM/F7ygc6UKQlos/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAckPS5FMCxssrtNr2K2cq0bRmX80/eQMSvwiRDw4c6eChZ5PJr/5ylturB1KtmHN
         ZAli+YbXjdGRkpf4xg98Y+cAhvxvf56gjQJBiNd05Pq7YcRj7q5e2aN1cscC4kfyzn
         V2R9EUJ0N67AKKrHtYbK/6hKnAV8bEcpcaNJE/QL3Ip25+oJk9+H3hSFO7r+7VsF83
         Es9aQtBsfOCQJjSnh83+uY2Wnfp+ggH0RKqNpHfb+sLPrXbDFa+Fs7TQeunuc+rq8m
         P6c56WLXw1/KItlM6HCoVghFMZS5e85Cheee0f0yFCKwaAZu9My666SHmjfKNdsFud
         fu2HjIrr7SyiQ==
Date:   Wed, 28 Jul 2021 16:05:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] docs: Fix infiniband uverbs minor number
Message-ID: <YQFWLDPlYqTy1ujg@unreal>
References: <a1213ef6064911aa3499322691bc465482818a3a.1626936170.git.leonro@nvidia.com>
 <YPrJorr7r9Kd2IzA@unreal>
 <YQFFJgMXFSN8IcjC@unreal>
 <20210728115933.GP1721383@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728115933.GP1721383@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 28, 2021 at 08:59:33AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 28, 2021 at 02:53:10PM +0300, Leon Romanovsky wrote:
> > Jason ????
> 
> I don't know what happened here, but it is not in patchworks
> 
> The patch looks fine unless there are remarks from the docs people -
> please get it in patchworks

Done,
https://patchwork.kernel.org/project/linux-rdma/patch/bad03e6bcde45550c01e12908a6fe7dfa4770703.1627477347.git.leonro@nvidia.com/

> 
> Jason
