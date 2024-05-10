Return-Path: <linux-rdma+bounces-2384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A488C1BC6
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D311F21B56
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C7534CDD;
	Fri, 10 May 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rX3ONkD5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3381E492
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715301068; cv=none; b=VJehdX+ugVwsjHV54F43UNcCetxN59JsvyRiW9S6FjwuMl9pzJ2+u+zWEMmWKj8JRys5WcQL2AEeF9QSaTZMePvaalPPAPGkBoIKJR5qg3zkf9NOvmV3oCyEF9YI0dC1QHj3nhiAr1nUIxEeCUd4WPazxych/+2E5oKcVaH/R60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715301068; c=relaxed/simple;
	bh=0KgQrDUz9XM38RTU0UKKESCM6bwbLhmxO4pbT7KG+xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPtoH5NUQZvg60BNSeqQcrmsntXMMf5lpNXNCAN9y9vC7hqlCOZ3rJEma9N3PhZ/DxCHf8SvgEv0qTMRvWtqL5GMgLAeTzTAnY1+JBzsd/LE+T2ELN78TqFKBJ7/1vDkHl/xO0fIDvHaP0RaLgHBdeqDWg79HYTYSA6RiUcJpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rX3ONkD5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1080914a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715301066; x=1715905866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uW7kaHfhybyf7BeUNmVZfbR4EXdAjRYiQZg99RGCKIE=;
        b=rX3ONkD5mxRxzsiOE/Js1ZlOlAPFmHjzD26Hmg/hB7YrkiVzdKNuJFOjDL0kT9aY19
         wzCgXHP2KlzSHnWkWgwSsqx1X89g8/xOTqY/E07CYsgsoll9ZUds+QqHgdhR9EQfTljE
         QcaOAdo8fAy8JvTzfNsNSsbdo6v0XdVlcPzNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715301066; x=1715905866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW7kaHfhybyf7BeUNmVZfbR4EXdAjRYiQZg99RGCKIE=;
        b=lUyfmBKqLBxTVUiTJmsDshNt6qPXr7KRZUqOwCCZ68iuihTgaaQX/0Gfen1fCpbQSh
         +0IqilsXvaqSobJKDK28uZePlsTzmhaeVX2ipYKddCjqEmyOmFfNGJYJFQzXoYabufLO
         gV9H3AynQRgl4OgdBwo0PAZmXMz7XAgFSlr9Eo58aTcpLNXqU8hZAp9rUoDQOHZnbGOz
         27GxivcERbsiu4Vc2euYfQ9d2zJUCwBhkZWIB6dGYiQW9qmbcQPaA/ErgeKX/YGZ5PW8
         fycNG4DxYJqrIJO4D8SAIjnyHJaS/fqsjdSDnljR9GCplg2aHkx0CNGSf63mJFxDvpTw
         UIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXUITldDYG4ON7BTpvH+43l9xWaZOAMy3rqXrcErXnRWJFJm9UGn8L4I4qje6Rdmw04bNge47xiWuxMsUTQV+6Us6AFGaT9uJasA==
X-Gm-Message-State: AOJu0YwnZN/7s0KQZ+8UkkA+t/04kqkWtZ0Fv85nxIgp/3e+4eqWA2W7
	McDpQGIc9hugnDWHvvXstBvt1iVA59LG1ztOa7LFPwIL1owWvQxJjC6976mD3bQ=
X-Google-Smtp-Source: AGHT+IG4t+GAVKOh7/FjtEXQWtNTTgiQcAduFs5qq7NWKRBkX7tswNr5fhXjKQpcwb1Az4bClUsw0w==
X-Received: by 2002:a17:90b:3587:b0:2b2:a607:ea4a with SMTP id 98e67ed59e1d1-2b6ccd8fc28mr1005227a91.44.1715301066486;
        Thu, 09 May 2024 17:31:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30bb9sm20245965ad.135.2024.05.09.17.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:31:05 -0700 (PDT)
Date: Thu, 9 May 2024 17:31:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <Zj1qxgElgHhtxj4h@LQ3V64L9R2>
References: <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu>
 <20240508190839.16ec4003@kernel.org>
 <ZjxtejIZmJCwLgKC@ubuntu>
 <32495a72-4d41-4b72-84e7-0d86badfd316@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32495a72-4d41-4b72-84e7-0d86badfd316@gmail.com>

On Thu, May 09, 2024 at 01:16:15PM +0300, Tariq Toukan wrote:
> 
> 
> On 09/05/2024 9:30, Joe Damato wrote:
> > On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
> > > On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> > > > If I'm following that right and understanding mlx5 (two things I am
> > > > unlikely to do simultaneously), that sounds to me like:
> > > > 
> > > > - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
> > > >    priv->channels.params.num_channels (instead of priv->stats_nch),
> > > 
> > > Yes, tho, not sure whether the "if i < ...num_channels" is even
> > > necessary, as core already checks against real_num_rx_queues.
> > > 
> > > >    and when
> > > >    summing mlx5e_sq_stats in the latter function, it's up to
> > > >    priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> > > > 
> > > > - mlx5e_get_base_stats accumulates and outputs stats for everything from
> > > >    priv->channels.params.num_channels to priv->stats_nch, and
> > > 
> > > I'm not sure num_channels gets set to 0 when device is down so possibly
> > > from "0 if down else ...num_channels" to stats_nch.
> > 
> > Yea, you were right:
> > 
> >    if (priv->channels.num == 0)
> >            i = 0;
> >    else
> >            i = priv->channels.params.num_channels;
> >    for (; i < priv->stats_nch; i++) {
> > 
> > Seems to be working now when I adjust the queue count and the test is
> > passing as I adjust the queue count up or down. Cool.
> > 
> 
> I agree that get_base should include all inactive queues stats.
> But it's not straight forward to implement.
> 
> A few guiding points:
> 
> Use mlx5e_get_dcb_num_tc(params) for current num_tc.
> 
> txq_ix (within the real_num_tx_queues) is calculated by c->ix + tc *
> params->num_channels.
> 
> The txqsq stats struct is chosen by channel_stats[c->ix]->sq[tc].
> 
> It means, in the base stats you should include SQ stats for:
> 1. all SQs of non-active channels, i.e. ch in [params.num_channels,
> priv->stats_nch), tc in [0, priv->max_opened_tc).
> 2. all SQs of non-active TCs in active channels [0, params.num_channels), tc
> in [mlx5e_get_dcb_num_tc(params), priv->max_opened_tc).
> 
> Now I actually see that the patch has issues in mlx5e_get_queue_stats_tx.
> You should not loop over all TCs of channel index i.
> You must do a reverse mapping from "i" to the pair/tuple [ch_ix, tc], and
> then access a single TXQ stats by priv->channel_stats[ch_ix].sq[tc].

It looks like txq2sq probably will help with this?

Something like:

for (j = 0; j < mlx5e_get_dcb_num_tc(); j++) {
  sq = priv->txq2sq[j];
  if (sq->ch_ix == i) {
    /* this sq->stats is what I need */
  }
}

Is that right?

Not sure if I'm missing something obvious here, sorry, I've been puzzling
over the mlx5 source for a bit.

BTW: kind of related but in mlx5e_alloc_txqsq the int tc param is unused (I
think). It might be helpful to struct mlx5e_txqsq to have a tc field and
then in mlx5e_alloc_txqsq:

  sq->tc = tc;

Not sure if that'd be helpful in general, but I could send that as a
separate patch.

