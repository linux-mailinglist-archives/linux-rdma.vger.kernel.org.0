Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A94FADBE
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Apr 2022 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiDJMFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiDJMFm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 08:05:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85648515A7;
        Sun, 10 Apr 2022 05:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C77FB80CBF;
        Sun, 10 Apr 2022 12:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46800C385A5;
        Sun, 10 Apr 2022 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649592208;
        bh=XhnYD3ZlSsnUjTeNZb68B85wGee+IQ5tw0+v9WwntL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8npcF3FbNolc81rIV9ILUaWLNxzPH7VwanZHPBgUYJMcX0cg4Y++3sPvlyOQIlHw
         XCO0C2sUK6fn9iTFfNKJuKJW9eB4kVPOi83NEKTWjBbXJcUZugb1/+tPbvCC627aWC
         vLQ/d+gvxzuvqOYFzMWXRBJWNtfAcm/P7APKC2iDROU5vN6a4c5VToMru89Xi1nJVF
         SOlxU/4zY82hmk+pa/zDdZ8lQdlCXXLZuZUqj+UZHdtXjQT1Xtr/c0q4cMAof984aV
         Toqu5pN18Yc5G7SWBOZZ4Q1Bf48OW6wIfSrRWLbco1VMv7JA1vdE8hOJbroKnLZvjT
         UrFA9JpOjghpg==
Date:   Sun, 10 Apr 2022 15:03:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Limit join multicast to UD QP type only
Message-ID: <YlLHjFlR8BtCc5Hu@unreal>
References: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com>
 <20220408182440.GA3647277@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408182440.GA3647277@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 08, 2022 at 03:24:40PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 04, 2022 at 05:52:18PM +0300, Leon Romanovsky wrote:
> > -static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > +static int cma_set_default_qkey(struct rdma_id_private *id_priv)
> >  {
> >  	struct ib_sa_mcmember_rec rec;
> >  	int ret = 0;
> >  
> > -	if (id_priv->qkey) {
> > -		if (qkey && id_priv->qkey != qkey)
> > -			return -EINVAL;
> > -		return 0;
> > -	}
> > -
> > -	if (qkey) {
> > -		id_priv->qkey = qkey;
> > -		return 0;
> > -	}
> > -
> >  	switch (id_priv->id.ps) {
> >  	case RDMA_PS_UDP:
> >  	case RDMA_PS_IB:
> > @@ -528,9 +517,22 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> >  	default:
> >  		break;
> >  	}
> > +
> >  	return ret;
> >  }
> >  
> > +static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> > +{
> > +	if (!qkey)
> > +		return cma_set_default_qkey(id_priv);
> 
> This should be called in the couple of places that are actually
> allowed to set a default qkey. We have some confusion about when that
> is supposed to happen and when a 0 qkey can be presented.
> 
> But isn't this not the same? The original behavior was to make the
> set_default a NOP if the id_priv already had a qkey:
> 
>  -	if (id_priv->qkey) {
>  -		if (qkey && id_priv->qkey != qkey)
> 
> But that is gone now?

When I reviewed, I got an impression what once we create id_priv and set
qkey to default values, we won't hit this if (..).

> 
> I got this:
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 3e315fc0ac16cb..ef980ea7153e51 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1102,7 +1102,7 @@ static int cma_ib_init_qp_attr(struct rdma_id_private *id_priv,
>  	*qp_attr_mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT;
>  
>  	if (id_priv->id.qp_type == IB_QPT_UD) {
> -		ret = cma_set_qkey(id_priv, 0);
> +		ret = cma_set_default_qkey(id_priv);

This is ok

>  		if (ret)
>  			return ret;
>  
> @@ -4430,14 +4430,10 @@ int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
>  
>  	if (rdma_cap_ib_cm(id->device, id->port_num)) {
>  		if (id->qp_type == IB_QPT_UD) {
> -			if (conn_param)
> -				ret = cma_send_sidr_rep(id_priv, IB_SIDR_SUCCESS,
> -							conn_param->qkey,
> -							conn_param->private_data,
> -							conn_param->private_data_len);
> -			else
> -				ret = cma_send_sidr_rep(id_priv, IB_SIDR_SUCCESS,
> -							0, NULL, 0);
> +			ret = cma_send_sidr_rep(id_priv, IB_SIDR_SUCCESS,
> +						conn_param->qkey,
> +						conn_param->private_data,
> +						conn_param->private_data_len);

It is ok too and we have many other places with not-possible "if (conn_param)".

>  		} else {
>  			if (conn_param)
>  				ret = cma_accept_ib(id_priv, conn_param);
> @@ -4685,7 +4681,7 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
>  	if (ret)
>  		return ret;
>  
> -	ret = cma_set_qkey(id_priv, 0);
> +	ret = cma_set_default_qkey(id_priv);
>  	if (ret)
>  		return ret;
>  
> 
> >  static void cma_translate_ib(struct sockaddr_ib *sib, struct rdma_dev_addr *dev_addr)
> >  {
> >  	dev_addr->dev_type = ARPHRD_INFINIBAND;
> > @@ -4762,8 +4764,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> >  	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
> >  
> >  	ib.rec.pkey = cpu_to_be16(0xffff);
> > -	if (id_priv->id.ps == RDMA_PS_UDP)
> > -		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > +	ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> 
> Why isn't this symetrical with the IB side:
> 
> 	ret = cma_set_default_qkey(id_priv);
> 	if (ret)
> 		return ret;
> 	rec.qkey = cpu_to_be32(id_priv->qkey);
> 
> 
> ??

The original code didn't touch id_priv.

> 
> It fells like set_default_qkey() is the right thing to do incase the
> qkey was already set by something, just as IB does it.
> 
> > @@ -4815,6 +4816,9 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
> >  			    READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))
> >  		return -EINVAL;
> >  
> > +	if (id_priv->id.qp_type != IB_QPT_UD)
> > +		return -EINVAL;
> > +
> 
> This makes sense
> 
> Jason
