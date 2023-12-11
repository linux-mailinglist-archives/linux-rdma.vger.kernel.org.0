Return-Path: <linux-rdma+bounces-354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8080CAE6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D32B2085C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8633E470;
	Mon, 11 Dec 2023 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ba3og296"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C68B3
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 05:25:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67ab16c38caso29554786d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 05:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702301123; x=1702905923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFtv/UZjlpbIfchVI2Eg4g5klyHxnMNJuBk5+joq/H0=;
        b=Ba3og296wOPlhW3eZQLq3vsMBRB9FHZseUJJkfhHz+16Bfs5STtWRlJU+cP2yONYcc
         d3ujZnS0DTCrV0KpmjSpXOIg6t5+YmUn6Ueby2tTpupSvkJ96pVRVSZxrAnDNQZGlQO2
         oN5fM14Nove7XmT6+Z1Z05lRgvy/CUjtE94TUfFizGVsDAWqGbsinsThq+1nw5UdD5AO
         s6MXDKp27fZjPRmjWLH2z33frsVW01L34yL2I/FGREs88B2HkzG0sjhUCgvoH/lVEY8n
         wLAo+T2LgM4iRKHckGaGU182nOtXn84qwRtVrPziSeMCgLKL+l9wOA9AFbnwpRYWofAP
         +zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702301123; x=1702905923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFtv/UZjlpbIfchVI2Eg4g5klyHxnMNJuBk5+joq/H0=;
        b=gCkW4xMVX+Ffqy+RpEka+0Ur9ScE5LE9bPcB4oSLwPp5znfcjz86+xzkm98FwtQCQT
         urrNRuvLr1D7d0QsOuczpuwEyWlFRLbC6diw/A7Ucw3erPqYBEeGfmtNVoluycPT3NkX
         QskwsnDMrsZ1b9aHEPJWgS5x+T/sEeu81dpOckg/L9pTPjM5urAgJ3uU6NBapGFx/Hvz
         Ewzi1VTQwspF1OVoxWsm8B/RPklSOQMrEzwSkYzzOK9AnMTyBNqBSA8VSnKbEPnC+Pag
         CJd9mVsArH0x/jCBata2uXerjw0z35Fq922mF7B/pHlnn8fVFf0V2HvTIyEEfilM/pQy
         OL7g==
X-Gm-Message-State: AOJu0YxqhZ9mQ9tkhIGDTw8LbH4T9/UZoOUzhvwNng/rPtNpDJE/phNh
	BiMMsaDShhrCc5JrDVJ8k8Kz4A==
X-Google-Smtp-Source: AGHT+IHZGeyP3BjcJlaAjr6e3g0qYv8anKUCcQLzvX5kgf3uL5XcY2iAAOvqcGLs20XwyXPwCpTXXA==
X-Received: by 2002:a0c:f682:0:b0:67a:a721:7846 with SMTP id p2-20020a0cf682000000b0067aa7217846mr4460297qvn.107.1702301123506;
        Mon, 11 Dec 2023 05:25:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id mk10-20020a056214580a00b0067aa860b1f9sm3292627qvb.122.2023.12.11.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:25:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rCgHi-00CaWy-Bc;
	Mon, 11 Dec 2023 09:25:22 -0400
Date: Mon, 11 Dec 2023 09:25:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Daniel Vacek <neelx@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the
 warning
Message-ID: <20231211132522.GY1489931@ziepe.ca>
References: <20231211131051.1500834-1-neelx@redhat.com>
 <20231211132217.GF4870@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132217.GF4870@unreal>

On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
 
> Please fill some text in commit message.

Yes, explain *why* you are doing this
 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > index 5b3154503bf4..ae2c05806dcc 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > @@ -536,17 +536,17 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
> >  	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
> >  					 &rec, comp_mask, GFP_KERNEL,
> >  					 ipoib_mcast_join_complete, mcast);
> > -	spin_lock_irq(&priv->lock);
> >  	if (IS_ERR(multicast)) {
> >  		ret = PTR_ERR(multicast);
> >  		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
> > +		spin_lock_irq(&priv->lock);
> >  		/* Requeue this join task with a backoff delay */
> >  		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
> >  		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
> >  		spin_unlock_irq(&priv->lock);
> >  		complete(&mcast->done);
> > -		spin_lock_irq(&priv->lock);

It is super weird to unlock just around complete.

Jason

