Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E124FF167
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiDMIJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDMIJl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 04:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04F2C667;
        Wed, 13 Apr 2022 01:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8819E6179D;
        Wed, 13 Apr 2022 08:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDEAC385A6;
        Wed, 13 Apr 2022 08:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649837240;
        bh=duybfUK7p8IMLtGdbMUQQq9RpI3J9wPTX8WRpMneCsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiPRSivfW8wH5EU8coOWqdXf0liNpdjTnAIFJz1hFaKsUz1NHewvnoYqnvhFtPQFG
         QbK/lftookgypXWarh2SKFcSxZpJ5aOcvVxJxOibnTun7P6JTb9RiIf4FPSHy8EaIz
         AYtJbjZ0oWDGhBjerk8+umli10LtgwKQIqCe+/dsZ3EsG3TUOmfDxjfJJ6kgcoELRl
         Btg8xtOEsX5BwtFHg7r2OoGOB0Kg1Xg9XifVQ+/vhkn6EJPtbMZTrsem6i9PjPhm+B
         O98OUwVF38EucMIdcbGIsxOs7gsPDx24N0sNh5c/MnS62nofhGcjhCsJO/GKOVN5J/
         TWgH4OBXKvcYA==
Date:   Wed, 13 Apr 2022 11:07:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Limit join multicast to UD QP type only
Message-ID: <YlaEsxCpAajlXgyo@unreal>
References: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com>
 <20220408182440.GA3647277@nvidia.com>
 <YlLHjFlR8BtCc5Hu@unreal>
 <20220412141134.GI2120790@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412141134.GI2120790@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 11:11:34AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 10, 2022 at 03:03:24PM +0300, Leon Romanovsky wrote:
> > On Fri, Apr 08, 2022 at 03:24:40PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 04, 2022 at 05:52:18PM +0300, Leon Romanovsky wrote:
> > > > -static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > > > +static int cma_set_default_qkey(struct rdma_id_private *id_priv)
> > > >  {
> > > >  	struct ib_sa_mcmember_rec rec;
> > > >  	int ret = 0;
> > > >  
> > > > -	if (id_priv->qkey) {
> > > > -		if (qkey && id_priv->qkey != qkey)
> > > > -			return -EINVAL;
> > > > -		return 0;
> > > > -	}
> > > > -
> > > > -	if (qkey) {
> > > > -		id_priv->qkey = qkey;
> > > > -		return 0;
> > > > -	}
> > > > -
> > > >  	switch (id_priv->id.ps) {
> > > >  	case RDMA_PS_UDP:
> > > >  	case RDMA_PS_IB:
> > > > @@ -528,9 +517,22 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > > >  	default:
> > > >  		break;
> > > >  	}
> > > > +
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > > > +{
> > > > +	if (!qkey)
> > > > +		return cma_set_default_qkey(id_priv);
> > > 
> > > This should be called in the couple of places that are actually
> > > allowed to set a default qkey. We have some confusion about when that
> > > is supposed to happen and when a 0 qkey can be presented.
> > > 
> > > But isn't this not the same? The original behavior was to make the
> > > set_default a NOP if the id_priv already had a qkey:
> > > 
> > >  -	if (id_priv->qkey) {
> > >  -		if (qkey && id_priv->qkey != qkey)
> > > 
> > > But that is gone now?
> > 
> > When I reviewed, I got an impression what once we create id_priv and set
> > qkey to default values, we won't hit this if (..).
> 
> We don't set qkey during create, so I'm not so sure..
> 
> The only places setting non-default qkeys are SIDR, maybe nobody uses
> SIDR with multicast.
> 
> 
> > > >  static void cma_translate_ib(struct sockaddr_ib *sib, struct rdma_dev_addr *dev_addr)
> > > >  {
> > > >  	dev_addr->dev_type = ARPHRD_INFINIBAND;
> > > > @@ -4762,8 +4764,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> > > >  	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
> > > >  
> > > >  	ib.rec.pkey = cpu_to_be16(0xffff);
> > > > -	if (id_priv->id.ps == RDMA_PS_UDP)
> > > > -		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > > > +	ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > > 
> > > Why isn't this symetrical with the IB side:
> > > 
> > > 	ret = cma_set_default_qkey(id_priv);
> > > 	if (ret)
> > > 		return ret;
> > > 	rec.qkey = cpu_to_be32(id_priv->qkey);
> > > 
> > > 
> > > ??
> > 
> > The original code didn't touch id_priv.
> 
> I know, but I think that is a mistake, we should make it symmetric

ok, I added it to regression.

Thanks

> 
> Jason
