Return-Path: <linux-rdma+bounces-2360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD588C097A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 03:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989DAB21780
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAF13C904;
	Thu,  9 May 2024 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Sks9IBPE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C413C683
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219878; cv=none; b=VCxLnq1XcKv5xhtn2pqepkLjpmu0VdPSNQKIxef0fynjkZ3ClepcvnpOulYxhzW2x+ivq1j5vQG3GsJK2qr9yLtycBVQZXM+BSwgn8KYqvuTA9Xfffem5J4Es65NQYSjFj1pawtomtFqnBZdgmyYmBxRsu8uwuBz5ZCeh84yI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219878; c=relaxed/simple;
	bh=wFHg8u5STogFH/ZoekFKe0WoCicext3N7WZORQvrdDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPBITJI1VBFEsPLD+uhSzfHySHG1V3H4W3U/jUK9r4h3lbZ74KlLy5MzgPs4+9BB0tf0Y6/dob4/lKJjgGst6RFzfO4MjW+tBzy4wVxKnYKyhrcrqcYRWnXEQAurnScu44/ScHfU+yy2wQlOE4bBY4PdUuhYgzkudcihd/KtoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Sks9IBPE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so2523835ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2024 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715219876; x=1715824676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol07fMm5kmX25Akoa7gDRlXSp7tunorw05f28am+peY=;
        b=Sks9IBPESymzhpDHLQJlvEDOTLqR7Sh2SV1zfmi50CgRi8JlmGGlInrsBkbzmWyH9p
         FBOAR9th0E7/yR9V8naV4BOE01GY0GaFneWkzu+GoX8ltYJ5420vWQ37QfywGOyeKX6B
         QixmprdDDYlnLmotSR3jWskXsiC8iw7E8cqvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219876; x=1715824676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol07fMm5kmX25Akoa7gDRlXSp7tunorw05f28am+peY=;
        b=jpTDjNdFdha6dmnswXgXfEQQSolNjP/TTAbZATOOyF/2VkFQ+Lc5JwMGrqNbL7VbK/
         ZPhzJBYi32C5ePeopsP+KuUvQQg/At5y4Q3THv8h3fWYXjQZ8Sk17Cx46j/9MKtg1RE7
         D8fTVAk04S+DLSmz8KbuDFdYP/agoMj49k8IJBORyMBVY5jmQIUlhvVCEHzcv8wq9rph
         puZgPOuCvkGAzgidCHvZhWLw34uEt/DbDBu0b+8m22eIgh0T833DnqDmnXZNwDPfr/kn
         C5WN8OarMdi6hFsGZlKWT+7qChvoxgTO3TSVLYqxJn+ba8l9ZjTs1eDwvGpFwecW6ztU
         rEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVynAOgWHEIrrHaJZHA0GKGy13wHV+Y+iH0l/p5yJG+W4jPR9RloyCU7bWlbnEV3IZMkwNrZoKKKBPl6V9qZPwySTUrgPLB/7MUNw==
X-Gm-Message-State: AOJu0YyORHzfPd485PsNWd8VBoF2A4RveI8SYbjmIt47GEwQyNj5lusW
	eaAiJ7KSW3FODcqnT81RzgItkw2AHgUshoyr5CNH9I8uougoln9S14d3r7qWH/4=
X-Google-Smtp-Source: AGHT+IFcnjp+pOOLih/Zt/FMX+mO9oZUF+Nach2AjPkraWqiLTStw3+LaLB8b60ReaVNPU/YqG+Tww==
X-Received: by 2002:a17:902:cecc:b0:1e5:1041:7ed4 with SMTP id d9443c01a7336-1eefa12f408mr21848865ad.14.1715219876348;
        Wed, 08 May 2024 18:57:56 -0700 (PDT)
Received: from ubuntu (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c25651dsm2083085ad.298.2024.05.08.18.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:57:55 -0700 (PDT)
Date: Thu, 9 May 2024 01:57:52 +0000
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjwtoH1K1o0F5k+N@ubuntu>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508175638.7b391b7b@kernel.org>

On Wed, May 08, 2024 at 05:56:38PM -0700, Jakub Kicinski wrote:
> On Wed, 8 May 2024 16:24:08 -0700 Joe Damato wrote:
> > > A possible reason for this difference is the queues included in the sum.
> > > Our stats are persistent across configuration changes, so they doesn't reset
> > > when number of channels changes for example.
> > > 
> > > We keep stats entries for al ring indices that ever existed. Our driver
> > > loops and sums up the stats for all of them, while the stack loops only up
> > > to the current netdev->real_num_rx_queues.
> > > 
> > > Can this explain the diff here?  
> > 
> > Yes, that was it. Sorry I didn't realize this case. My lab machine runs a
> > script to adjust the queue count shortly after booting.
> > 
> > I disabled that and re-ran:
> > 
> >   NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
> > 
> > and all tests pass.
> 
> Stating the obvious, perhaps, but in this case we should add the stats
> from inactive queues to the base (which when the NIC is down means all
> queues).

If I'm following that right and understanding mlx5 (two things I am
unlikely to do simultaneously), that sounds to me like:

- mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
  priv->channels.params.num_channels (instead of priv->stats_nch), and when
  summing mlx5e_sq_stats in the latter function, it's up to
  priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.

- mlx5e_get_base_stats accumulates and outputs stats for everything from
  priv->channels.params.num_channels to priv->stats_nch, and
  priv->channels.params.mqprio.num_tc to priv->max_opened_tc... which
  should cover the inactive queues, I think.

Just writing that all out to avoid hacking up the wrong thing for the v2
and to reduce overall noise on the list :)

