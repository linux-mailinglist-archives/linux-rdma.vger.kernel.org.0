Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42431F775E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2019 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKKPGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Nov 2019 10:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKKPGu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Nov 2019 10:06:50 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AA620656;
        Mon, 11 Nov 2019 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573484809;
        bh=Z6y8nkI42NDZgtf9OVhoEEBSE388aLp/0lnsi0Eeb3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yq3nYXX03XxqOnjcbrxZZE1tMXlqcYXcoGfem/OL5KZ9EpGv4SQgM8MnS85nuCKIr
         JMolQEhHnBxAFVtqbjEw6NYYds9PNaWwM99UVzXBolqyRVlIJQZITkyP9yks7Vnfok
         AQzFrd/RKfRUiNfH17R25oALZ8n0+mNpRj3cAkR4=
Date:   Mon, 11 Nov 2019 17:06:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: Re: [PATCH rdma-next 00/16] MAD cleanup
Message-ID: <20191111150646.GW6763@unreal>
References: <20191029062745.7932-1-leon@kernel.org>
 <20191106201448.GA25345@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106201448.GA25345@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 04:14:48PM -0400, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2019 at 08:27:29AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Let's clean MAD code a little bit.
> >
> > It is based on
> > https://lore.kernel.org/linux-rdma/20191027070621.11711-1-leon@kernel.org
>
> It doesn't seem related to this at all
>
> > Leon Romanovsky (16):
> >   RDMA/mad: Delete never implemented functions
> >   RDMA/mad: Allocate zeroed MAD buffer
> >   RDMA/mlx4: Delete redundant zero memset
> >   RDMA/mlx5: Delete redundant zero memset
>
> We don't need a patch for every driver just to change the same
> repeating 2 line pattern, I squashed these
>
> >   RDMA/ocrdma: Clean MAD processing logic
> >   RDMA/qib: Delete redundant memset for MAD output buffer
> >   RDMA/mlx4: Delete unreachable code
> >   RDMA/mlx5: Delete unreachable code
> >   RDMA/mthca: Delete unreachable code
>
> Same here
>
> >   RDMA/ocrdma: Simplify process_mad function
> >   RDMA/qib: Delete unreachable code
> >   RDMA/mlx5: Rewrite MAD processing logic to be readable
> >   RDMA/qib: Delete extra line
>
> >   RDMA/qib: Delete unused variable in process_cc call
>
> This is actually a bug from an earlier patch that oddly removed
> check_cc_key, I put that into its own patch
>
> >   RDMA/hfi1: Delete unreachable code
> >   RDMA: Change MAD processing function to remove extra casting and
> >     parameter
>
> Ira seems concerned, so I didn't apply these until we hear from Dennis
>
> Otherwise the rest were applied with re-organization to for-next

Jason,

Can you please take missing two patches?

Thanks

>
> Thanks,
> Jason
