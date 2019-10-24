Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00863E2A52
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408528AbfJXGVL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403986AbfJXGVK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:21:10 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950D921655;
        Thu, 24 Oct 2019 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571898070;
        bh=Yyy/+cZHfX+4HG2axjlicjcb8q3eYH+Q+kSqMyzpa+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntjkI1At5Tq+s81Y9bQr4BqM9J9eQ1nd6nnNgzBCaCIHTAsDzFJkLgjmEpfp0WCcE
         yhtEgMcPpW5Tx9PEc+TmZYMCzG42BRpO25hO1Z/w8t+hPGzLj3pyAyO5F/kYb7yZRY
         yvjHF01yFk83+qkD3XPQ3AC/1UntOwNswbKgvpSc=
Date:   Thu, 24 Oct 2019 09:21:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 0/2] Remove PID namespaces support from
 restrack
Message-ID: <20191024062102.GP4853@unreal>
References: <20191010071105.25538-1-leon@kernel.org>
 <20191023190933.GA4836@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023190933.GA4836@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 04:09:33PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 10, 2019 at 10:11:03AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Changelog
> >  v0 -> v1: https://lore.kernel.org/linux-rdma/20191002123245.18153-1-leon@kernel.org
> >  * Beatify code as Parav suggested (patch #2)
> >
> > Hi,
> >
> > Please see individual commit messages for more details.
> >
> > Thanks
> >
> > Leon Romanovsky (2):
> >   RDMA/restrack: Remove PID namespace support
> >   RDMA/core: Check that process is still alive before sending it to the
> >     users
>
> Applied to for-next, thanks

Didn't you push it? I don't see it yet.

Thanks

>
> Jason
