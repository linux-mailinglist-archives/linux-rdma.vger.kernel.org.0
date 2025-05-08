Return-Path: <linux-rdma+bounces-10174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ACEAB06BC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 01:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E36F5204DD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 23:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202A22154F;
	Thu,  8 May 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LveVDXjo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F95AD5E;
	Thu,  8 May 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746748003; cv=none; b=JUH9/A+AFGpwPfTocPAq8BaQlJrYuRgo2uDk/VGmR7OSAPAh76pIuSZLWp05kz6IGTq/Q71BvhlDN4IHcix5tMhBBHFD6mSheVplIyUO6NQPoVWJHHZqxJThTuZDPMH9JOI708vWFWFW8HwszGAAypnprh+slQS3mlVPT9fHYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746748003; c=relaxed/simple;
	bh=N35gok4X9sy8tEgWNPKIYlOZoCCgI6fXLs7n3HW7jWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ4HYkqC2UIDADPzHoLOJOtPwS30jV3joqzxNZcM7b4w353nyNLw/u6dt4Rs0WjNmYKUrka/jJ4uTmzvEM2GKrQ1uP23LNHIEJ5MkmJALcXnoPhrnDqKigMwB8OAPQkdIWS6yOnCTgtaL4xfJwoukTT5yEyx6qY2pWp84y04dMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LveVDXjo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso1105150a12.2;
        Thu, 08 May 2025 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746748001; x=1747352801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tf1IL6DZseFMoKdIncvqyz6a/5F2o4zho/5acSF3DDU=;
        b=LveVDXjognnxpjlCFegeiY9CkN9l1+7OoyFjvhikh6dbZLluw0uc7DAwmZ/Z8O4E7o
         W8GxbSAoNy3bzEzjiqkym75TWSBrSWFmHR9AbXhb2aQkASmZ+K4h5Nx7gw/ddeT4Ju6Z
         lnBA984BLb2/TLyI6OALYrNN4vdr8EldyBXAoej3PB4o7kei6NWkI7GGUgr1BtaXhn5i
         +4/adR/cR8hdg2b0mrW7kbsrcy0KyZkFqAxY1g0oWGxWPPPsB8el91BNOVaIhndgzl0D
         M3F2OVUrKs9sAggK6uWY4JaWY+0wg3Hi5cu5naux5GxTFrRZCPHCtTKnD8PughXRtdDq
         XMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746748001; x=1747352801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf1IL6DZseFMoKdIncvqyz6a/5F2o4zho/5acSF3DDU=;
        b=aLUe4ed9fU+RbyWNf84zIIvIVAixnyprRZuCsjfyxEWFMCz8JfM9OSWB/Ad06tIYNa
         IAO0SWUSI549onXLvxDpoSWQpywPACzycRzLn2pgvXqHpLEnQm3m+AbHmwl797w4ibIF
         3CoMNNfmH5ZLaG91xCEgDbM5qPZyey4so6qEH0TDThr4QSekpIEwA+d/ZQ+JtIeaJYKQ
         58TrOyYJBHwSiz1zBoeK+6vd9c7IVHWzQjtxhyn8H/YN3OTLHBSBs2PC+qmg0aMko1lP
         j/yOkvTpQKHa1xlZWengUOoGT3YBlsZMXsFa2scmt8dpVpYVt/V/TKJFzfvNfIv/gwT/
         Q70w==
X-Forwarded-Encrypted: i=1; AJvYcCUCkNMrO+6yLH4STdU1dKiGV4PslEoKqSiC8wZbmEOyDcoIMsYofvJ8DS4n4WNsMc52TIz5NRJEyZAsBYY=@vger.kernel.org, AJvYcCV2XjZFEGumiZd1H7qbaSlCSJnrdNJtdv7Q/zbwKwJ3p0POLUw8ZHhF07itoAO3u6YSNZo76giJ@vger.kernel.org, AJvYcCWfwkM7xn58jdcDFeiolLRc0mz5E7s8WJdfjdxjch7wgvRHbLX+MohpEKkucOUMRcUQr5aYbeZ2ur465Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4ARvZQi/SIq1XdHPsD9cyyn4a1Gki2nvotE/zppAPqZsM55A
	iFBIvfzODFx6uEX+4M8VKrRWJ+nTfvwAlV9uOYhKlX++vD2FfJY=
X-Gm-Gg: ASbGncvPWDIgKhoIqj2LFSboud1QjgUn4eo81grOjmTx+e8Re15Uw6bQJM93MccW6lm
	+1qpjvU3fcrJNYClfe3IoJ4La+Khwqfb4WtAlAuS03ViagwTF6CC0YFWYlUy+3qpG0Fe3o4DfGh
	mLV3URAWrvvR5SGrA+Frww6YTI1QoPnRMNAfbRPbzBXVL90BC1N09VoTbtyKvv0RohAFXdKFp1p
	LefXSa++UTdXWtLy7qNbT0Pp4ipAyDEWFdueCd4kJWROY4oWiyESJZhdQFAab7wWLJ2iVbLtK3g
	UglBBusQd6OxDh/lErcp4RQ8aEgFSDjjntDlUDqogzKzo2vzDfaOPkrOtLeGxdqnC4uamuus9Ex
	ApA==
X-Google-Smtp-Source: AGHT+IEkBEVE8YH96VS/fR37Bdx1kijWy1BXZf+AEXrfHLVKlj3zB0QGCOnM28eXiFEKhIATz3fi5w==
X-Received: by 2002:a17:902:e54f:b0:22e:62f0:885f with SMTP id d9443c01a7336-22fc8e99f2amr19049315ad.40.1746748000995;
        Thu, 08 May 2025 16:46:40 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc8271ccesm5334385ad.144.2025.05.08.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 16:46:40 -0700 (PDT)
Date: Thu, 8 May 2025 16:46:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, leon@kernel.org,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: support software TX timestamp
Message-ID: <aB1CX1OHyzTEo_D9@mini-arch>
References: <20250506215508.3611977-1-stfomichev@gmail.com>
 <1a1ab6eb-9bfc-4298-ba1e-a6f4229ce091@gmail.com>
 <CAL+tcoDu0NdZQ+QmqL9mF8VNj+4cPLgmy1maAucAc7JkKOjm6A@mail.gmail.com>
 <aBzaK8I0hA31ba_4@mini-arch>
 <39c21e55-4aeb-4935-ab8a-759d97662ec3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39c21e55-4aeb-4935-ab8a-759d97662ec3@gmail.com>

On 05/09, Tariq Toukan wrote:
> 
> 
> On 08/05/2025 19:22, Stanislav Fomichev wrote:
> > On 05/08, Jason Xing wrote:
> > > Hi Tariq,
> > > 
> > > On Thu, May 8, 2025 at 2:30 PM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
> > > > 
> > > > 
> > > > 
> > > > On 07/05/2025 0:55, Stanislav Fomichev wrote:
> > > > > Having a software timestamp (along with existing hardware one) is
> > > > > useful to trace how the packets flow through the stack.
> > > > > mlx5e_tx_skb_update_hwts_flags is called from tx paths
> > > > > to setup HW timestamp; extend it to add software one as well.
> > > > > 
> > > > > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > > > ---
> > > > >    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
> > > > >    drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
> > > > >    2 files changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > > > > index fdf9e9bb99ac..e399d7a3d6cb 100644
> > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > > > > @@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
> > > > >                return 0;
> > > > > 
> > > > >        info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> > > > > +                             SOF_TIMESTAMPING_TX_SOFTWARE |
> > > > >                                SOF_TIMESTAMPING_RX_HARDWARE |
> > > > >                                SOF_TIMESTAMPING_RAW_HARDWARE;
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > > > index 4fd853d19e31..f6dd26ad29e5 100644
> > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > > > @@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
> > > > >    {
> > > > >        if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> > > > >                skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> > > > > +     skb_tx_timestamp(skb);
> > > > 
> > > > Doesn't this interfere with skb_tstamp_tx call in the completion flow
> > > > (mlx5e_consume_skb)?
> > > 
> > > skb_tstamp_tx() only takes care of hardware timestamp in this case.
> > > 
> > > > 
> > > > What happens if both flags (SKBTX_SW_TSTAMP / SKBTX_HW_TSTAMP) are set
> > > > Is it possible?
> > > 
> > > If only these two are set, only hardware timestamp will be passed to
> > > the userspace because of the SOF_TIMESTAMPING_OPT_TX_SWHW limit in
> > > __skb_tstamp_tx().
> > > 
> > > If users expect to see both timestamps, then
> > > SOF_TIMESTAMPING_OPT_TX_SWHW has to be set.
> > 
> > Right, skb_tx_timestamp does nothing and bails out if it detects
> > SKBTX_IN_PROGRESS. And skb_tstamp_tx in mlx5e_consume_skb handles
> > only (and will trigger only for) HW tstamp case.
> 
> I see.
> Patch LGTM, except for the function name nit, pointed out in an earlier
> comment.
> We could remove the "hw" from function name mlx5e_tx_skb_update_hwts_flags.

SG, will repost with a rename!

