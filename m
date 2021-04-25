Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3695836A77A
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhDYNVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhDYNVw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 09:21:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACD95611B0;
        Sun, 25 Apr 2021 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619356872;
        bh=QBFk+zzNrn82lut4DJsBhWshxSPHCxu0cFRAqOma3LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgFkcNtpwcy3aUMRWb59hSj09wCw7JKpJA3wKn+DOWQ/VHYu1Wf+Bg7TzAAWfqJqF
         1bK7jDkxy11cUIioVHY12mRklXaR/yQqNG/sXyHC6Uz67nSBXv761KzQQqYSLUuKXm
         a5o20Wv1WKgGwVDyNl0Er1DIsBjONxpCpa6JdiBxsH7v0EO2wBOQ8Y2KpQNqppS0HQ
         Dfz/CGwATPWfk+BF4Q6L/ZwyPQONz25SqssKftwW1CJEceM6HPklc0eZvThvGsXMlS
         rdxZIWZ/rozDNd4p2G0MyFg1o6dKH/GP0fb3rf/l6US2CselR4+faGINvAsbdLIuH2
         KCLR+JJXouiEg==
Date:   Sun, 25 Apr 2021 16:21:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 8/9] IB/cm: Add lock protection when access
 av/alt_av's port of a cm_id
Message-ID: <YIVsw8bULi28L/JE@unreal>
References: <cover.1619004798.git.leonro@nvidia.com>
 <a50fca26e37799491778e5efbf6b6ef21f1c3fbe.1619004798.git.leonro@nvidia.com>
 <20210422190814.GA2451164@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422190814.GA2451164@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 04:08:14PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:40:38PM +0300, Leon Romanovsky wrote:
> > @@ -303,20 +304,37 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
> >  	struct ib_mad_agent *mad_agent;
> >  	struct ib_mad_send_buf *m;
> >  	struct ib_ah *ah;
> > +	int ret;
> > +
> > +	read_lock(&cm_id_priv->av_rwlock);
> > +	if (!cm_id_priv->av.port) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> >  
> >  	mad_agent = cm_id_priv->av.port->mad_agent;
> > +	if (!mad_agent) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> >  	ah = rdma_create_ah(mad_agent->qp->pd, &cm_id_priv->av.ah_attr, 0);
> > -	if (IS_ERR(ah))
> > -		return (void *)ah;
> > +	if (IS_ERR(ah)) {
> > +		ret = PTR_ERR(ah);
> > +		goto out;
> > +	}
> >  
> >  	m = ib_create_send_mad(mad_agent, cm_id_priv->id.remote_cm_qpn,
> >  			       cm_id_priv->av.pkey_index,
> >  			       0, IB_MGMT_MAD_HDR, IB_MGMT_MAD_DATA,
> >  			       GFP_ATOMIC,
> >  			       IB_MGMT_BASE_VERSION);
> > +
> > +	read_unlock(&cm_id_priv->av_rwlock);
> >  	if (IS_ERR(m)) {
> >  		rdma_destroy_ah(ah, 0);
> > -		return m;
> > +		ret = PTR_ERR(m);
> > +		goto out;
> >  	}
> >  
> >  	/* Timeout set by caller if response is expected. */
> > @@ -326,6 +344,10 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
> >  	refcount_inc(&cm_id_priv->refcount);
> >  	m->context[0] = cm_id_priv;
> >  	return m;
> > +
> > +out:
> > +	read_unlock(&cm_id_priv->av_rwlock);
> 
> This flow has read_unlock happening twice on error

Ohh, sorry, I will fix.

Thanks

> 
> Jason
