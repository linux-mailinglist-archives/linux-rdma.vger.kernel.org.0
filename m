Return-Path: <linux-rdma+bounces-2804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F55B8FA460
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BE28D556
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DAD13C901;
	Mon,  3 Jun 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qYHIkmV7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1E13C8EC
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451422; cv=none; b=Fa5pQQBJcF5wENyS4ex5Mt+xAet2k7CVqcYGZB3wt9yUIYBbJwoIWiBIWpgZHgXaMeunkzOyA8WbbmNvUpMR31Eetl5oC/FqiOqxtmN4RPjZ8ayuRUfpdTDp5ZjygjsyNm7Za8xkOm/SKyGFMoJtYsFA1+T/5x1gUM5GjDKApaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451422; c=relaxed/simple;
	bh=jQETexEejuJ/VAhqGR17NqtTNOI2iX3uh3MiiJifQJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNPKRQ8y1vgh3SFjRAbJzDUx857ssXuxb1DQjfTyWugoncEjBpgw5/Wuf2J1p7rRCEg1Lkrgch9DJtTz8B9kOEea6hpUOgqV0ri+wdEivjO0VEtKiRLCCgYYiY1TscECwBKSX+BdN2gClgHGgPVfGGK+v3FU4AvKx0iuzNjYMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qYHIkmV7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-245435c02e1so2650273fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2024 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717451420; x=1718056220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZziI2v+i5IGjIKB8mlMLCYTpY3QI/oZfBdzVvUiG3pw=;
        b=qYHIkmV7eR++1Jk87ogdHtjoEcI5ih1MRWLIA3J5MvcNcogA1uejXla+1L9xhQnePr
         FEOVvJIyyqXHADsMR8Ry+0w6+vaws0JTHn2IVjk9hz8K3AAw4vWrM4OXu2bp00mp0sO4
         uTIFOU10bmKcXBYNyAKa7ZM3lX3VldG3zpsG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717451420; x=1718056220;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZziI2v+i5IGjIKB8mlMLCYTpY3QI/oZfBdzVvUiG3pw=;
        b=SLXvJYJAmlaQ0G5dyN4VUtxYwtj92ViBS+61aLY/b0buTXqNR5Jvczipnm8Dvere6z
         C8v7qIdcENEhWeuAB0yL0qbTFO03kXzqEF7z1xg8eHKIc4O41zyDJEVWpR0803O2/P70
         JyGV7owxI87jWbNjxck7Vn4mA7ReB5wsaXe/hFV+QtHLbdRUUpwr4eYmd2oOHWALY1CA
         UR5UuyNWe2eE6D7SsomOodxXkd0NLg3V9JzRcpzov3I1+01BMP7qLZMoXY1ay7d/n92T
         IJIe8LnwbDN3xxeZhVj2dFzDSo8EWwSw0L+kSo5qtzkGn6U71VcflADQ9jeZRpdCp0nc
         XWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAkDR7idP0cUd0B4x6uDuC33x2iHeCUvEhjGugzVBEpjG/wCUgR0f2Q5BUNAbZWZxb/YzXaskPjT4bopO6vzMw4lWVxxuDE4aJnw==
X-Gm-Message-State: AOJu0YxOyBOphXAmKn8vxA0qmFCBlAihA9wV00zR1YAHkrxL57vSZURM
	mI9+EfnqdbEV5qODbgE4BZfnz9HTu4qWJbWMFAYIPRx7saIP9yOBvybWoVpvvhg=
X-Google-Smtp-Source: AGHT+IExaHxmG4w13jF3tz6Wk1yFelIINj206SDMlX2noHX3ytwoyWzS/nopw4WIncY0zt7vHmmxvA==
X-Received: by 2002:a05:6871:88b:b0:24c:ae57:b4ab with SMTP id 586e51a60fabf-2508b80dc81mr12624917fac.11.1717451419771;
        Mon, 03 Jun 2024 14:50:19 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b09133sm6158526b3a.178.2024.06.03.14.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:50:19 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:50:16 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <Zl46mKIn_cLaqcad@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-3-jdamato@fastly.com>
 <5b3a0f6a-5a03-45d7-ab10-1f1ba25504d3@gmail.com>
 <ZlzGjXxVD-JClqIy@LQ3V64L9R2>
 <eda43490-8d77-4d7d-9b24-1aafd073d760@gmail.com>
 <Zl4X82y3ecR2Mnye@LQ3V64L9R2>
 <eedb6e7e-bd99-400d-81d9-6f72e6009acb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedb6e7e-bd99-400d-81d9-6f72e6009acb@gmail.com>

On Tue, Jun 04, 2024 at 12:36:16AM +0300, Tariq Toukan wrote:
> 
> 
> On 03/06/2024 22:22, Joe Damato wrote:
> > On Mon, Jun 03, 2024 at 02:11:14PM +0300, Tariq Toukan wrote:
> > > 
> 
> ...
> 
> > > 
> > > I still don't really like this design, so I gave some more thought on
> > > this...
> > > 
> > > I think we should come up with a new mapping array under priv, that maps i
> > > (from real_num_tx_queues) to the matching sq_stats struct.
> > > This array would be maintained in the channels open/close functions,
> > > similarly to priv->txq2sq.
> > > 
> > > Then, we would not calculate the mapping per call, but just get the proper
> > > pointer from the array. This eases the handling of htb and ptp queues, which
> > > were missed in your txq_ix_to_chtc_ix().
> > 
> > Maybe I am just getting way off track here, but I noticed this in
> > drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c in
> > set_pflag_tx_port_ts:
> > 
> >    if (!err)
> >      priv->tx_ptp_opened = true;
> > 
> > but what if enable is false, meaning the user is disabling ptp via
> > ethtool?
> > 
> 
> This bool field under priv acts as a flag, means: ptp was ever opened.
> It's the same idea as max_opened_tc, but with boolean instead of numeric.

OK, but then to avoid double counting ptp, I suppose we don't
output ptp stats in base and only when the correct txq_ix is passed
in to the tx stats function which refers to the PTP queue?

It's either that or we dont include ptp's sqstats in the
txq2sq_stats mapping you've proposed, if I understand correctly.

