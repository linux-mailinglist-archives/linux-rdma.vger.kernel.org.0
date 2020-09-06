Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7625EE24
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgIFO0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 10:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbgIFOZo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 10:25:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F37C20760;
        Sun,  6 Sep 2020 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402343;
        bh=N1csDf+LLsD7KCK6+jkmbrFYDFmSRi9SrhW083D85es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNYABjLYeM41hQrcw9FdFoRMzXx3NQNXofcK31A7m+TtANZAS5VdNmYPPDdY0Jw2A
         DT5ZnE+znl8bM6VzPI5WB8hsyvV1wwBWbYuXiig+r5LpEayqOMWU+zHPyM8NAq3PeO
         CMKNyvrKcAOzY+jSQ978/iH3Tq13dxVXwOCdw4ZE=
Date:   Sun, 6 Sep 2020 17:25:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 07/13] RDMA/core: Allow drivers to disable
 restrack DB
Message-ID: <20200906142540.GH55261@unreal>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-8-leon@kernel.org>
 <20200903140202.GA1552016@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903140202.GA1552016@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 11:02:02AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2020 at 01:14:30PM +0300, Leon Romanovsky wrote:
> > diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> > index 10bfed0fcd32..d52f7ad6641f 100644
> > +++ b/include/rdma/restrack.h
> > @@ -68,6 +68,14 @@ struct rdma_restrack_entry {
> >  	 * As an example for that, see mlx5 QPs with type MLX5_IB_QPT_HW_GSI
> >  	 */
> >  	bool			valid;
> > +	/**
> > +	 * @no_track: don't add this entry to restrack DB
> > +	 *
> > +	 * This field is used to mark an entry that doesn't need to be added to
> > +	 * internal restrack DB and presented later to the users at the nldev
> > +	 * query stage.
> > +	 */
> > +	u8			no_track : 1;
> >  	/*
> >  	 * @kref: Protect destroy of the resource
> >  	 */
>
> The valid may as well be changed to a bitfield too

I will delete "valid" later in this series.

>
>
> > +/**
> > + * rdma_restrack_no_track() - don't add resource to the DB
> > + * @res: resource entry
> > + *
> > + * Every user of thie API should be cross examined.
> > + * Probaby you don't need to use this function.
> > + */
> > +static inline void rdma_restrack_no_track(struct rdma_restrack_entry *res)
> > +{
> > +	res->no_track = true;
> > +}
> > +static inline bool rdma_restrack_is_tracked(struct rdma_restrack_entry *res)
> > +{
> > +	return !res->no_track;
> > +}
>
> Are these wrappers really necessary?

I don't like them either, added them to make same interface for all
restrack operations.

>
> Jason
