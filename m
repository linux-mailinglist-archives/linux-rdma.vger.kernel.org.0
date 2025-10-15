Return-Path: <linux-rdma+bounces-13877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7765BBDFEC6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D3355C40
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92E2FDC40;
	Wed, 15 Oct 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsAPqUAE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD527E076
	for <linux-rdma@vger.kernel.org>; Wed, 15 Oct 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550275; cv=none; b=iigSN6TBMS317ug/c4uaPzTuK+JLIzcCd27I9MDp4geLGz90SxTiYgTNxHzrZ97KJvidHjeqB4HkkQL6Nrp9mVK/jAtPRZZpwSP5vbxgHoA3kFOXVj0a8dcgWzHeB5qQ2Qy+2pPgWE7bHop8NmGpte/0RUr0evUOBEH/CYFEHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550275; c=relaxed/simple;
	bh=3AUIEStV7cdbPd++W98zRPC/OeYAHWTOst7DyxGEouE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsABfEVhsmR6/xLjL5waq5atHmxQSW5LtE7y4XP77D9xV5ljDliWQZjK8HirltyhhRy5o+hfTpJD+/zzLFYLH61aS2lmApxGPPUJ0U7AhnXvbqCwSkeE0wRXsGWN9V4TmNoHu+H6BaHEOrU10El8GmBK7/9++EQqvTwnrJ6ouFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsAPqUAE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-58877f30cd4so663e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Oct 2025 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760550272; x=1761155072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY8QZndwhT3+NL15Z/FlWhrmYP9xi4mJKswCgkhxCxA=;
        b=OsAPqUAEODUwcXhfXzKrGTgsA7TWLp/kadRcqCUadj9YM07Qnu3tSGd7Izh/e1vgzd
         UkdVqCsLynx6kOBbBcTsyeHLusWciKgW4SWL67Ssq4QE9rokwyeQwLnYLFh5FWiGQGTC
         9u+8UmrSAgzKpT3zpX6e1ZpDpk7OpnO1y9riFr+RhegBMf7JKS7rZ3VOqfnP/rAVeQqG
         F2rGY+zKpA11IGze1+7/6cm4YrTTUmY8jgPjiNtOZTsKMiQBKO0H7aOv4l0FSl6JnU8U
         Uw+qU4D7iiSOaRjfmObn5kpu/nz7qEbKQKp4fK6k0xgCJzP1RcBwEiyyGS/Z0MDurxeu
         7upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550272; x=1761155072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY8QZndwhT3+NL15Z/FlWhrmYP9xi4mJKswCgkhxCxA=;
        b=xR9pR4gev7Zku0v4oGnjIppSzWBRQbOuNtyVVjOv1ZtuZDwISyjQLvA+byM+lRLCd0
         GDzZHYqgLGTUNwtWRxFpUK08yLtGUfpbBBTTemtrTD3NOXptsdE5OSVStsrPbhPsvaXL
         QHxgsNz4EOHtXvuRxue0umtC3HwQFd9fdsNMdnDr5v+OYVP4wRjAal1MiNBSDWcK2tZE
         iEOwhzSrmRHx3GT9vRDiQrvxF6Yf8lnDnuqJ9EDlfeiSEGNaCYe5c0zCMD/2fqPG1lLn
         pKIBjknFbUbBJeg4hzK3n8PRYOX9STYKrytrwnS0vblFGq6U+1Dsn0sj6ruf+KSZRofs
         tSEg==
X-Forwarded-Encrypted: i=1; AJvYcCVoYOpSXb26qeUnw8Fpgkxoze8vAUjZ/0tts5ucsGbDhbyXnoe4AEZnwsrenBRkmknbjZ1NzGFP5UVg@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJ/rKjADz7sYo+uGT6YdZahnpQsMiZqZbRkpvBfTI169AywVG
	Uc1IpxDM2O9eNVRc8kQO9L9nLspB08zUW4m4z7e+Lp/QR1c8MFe1aIMCS/3/D/u+vb6dASoi87V
	eemBLuez7HhxSEk+l317Af+kT0zsdFjE6Q0q+p6wG
X-Gm-Gg: ASbGncsicBdovWjixO8dBZCnToS4bkKDvnBoRyhLn9kxkYpA1D936xvuZ89uof2N20j
	Jzfzjs3DsHeBOut7pm0Kq7u159IrDkO5OOBVAy8UdtARxzlIMhjO47CEE/T+4UDwqbeg84cKsjA
	RndpsMJM4g1wuB6k/vHVlskYrsxspoC5hNwuX4MVEjYr/+xX59zJs51hHOLjhEp3dd7pdd4j9fM
	iLHMLqsWUUeaO+Rc6mhvcYDyPLGRjLdA4eGhNlWcN/tfBKLdohtTm3lZhgkxno=
X-Google-Smtp-Source: AGHT+IHx5Sap8SgnApTXFbqfybLicQYBWKriw3rBnz1ag8JZ5i0NwBJ8RBbeffYVeAvVKPzvXptpArbao695kNWSp1A=
X-Received: by 2002:a05:6512:3089:b0:591:c473:5bb6 with SMTP id
 2adb3069b0e04-591c93205f3mr448255e87.0.1760550271312; Wed, 15 Oct 2025
 10:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760364551.git.asml.silence@gmail.com> <20251013105446.3efcb1b3@kernel.org>
 <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com> <20251014184119.3ba2dd70@kernel.org>
In-Reply-To: <20251014184119.3ba2dd70@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 15 Oct 2025 10:44:19 -0700
X-Gm-Features: AS18NWBNAtVbc4MmchZmMh3H3Ojj06sazP4EU7tysH0mrHozuhBSQzUN8gwMOFY
Message-ID: <CAHS8izOnzxbSuW5=aiTAUja7D2ARgtR13qYWr-bXNYSCvm5Bbg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>, 
	Willem de Bruijn <willemb@google.com>, Breno Leitao <leitao@debian.org>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 13 Oct 2025 21:41:38 -0700 Mina Almasry wrote:
> > > I'd like to rework these a little bit.
> > > On reflection I don't like the single size control.
> > > Please hold off.
> >
> > FWIW when I last looked at this I didn't like that the size control
> > seemed to control the size of the allocations made from the pp, but
> > not the size actually posted to the NIC.
> >
> > I.e. in the scenario where the driver fragments each pp buffer into 2,
> > and the user asks for 8K rx-buf-len, the size actually posted to the
> > NIC would have actually been 4K (8K / 2 for 2 fragments).
> >
> > Not sure how much of a concern this really is. I thought it would be
> > great if somehow rx-buf-len controlled the buffer sizes actually
> > posted to the NIC, because that what ultimately matters, no (it ends
> > up being the size of the incoming frags)? Or does that not matter for
> > some reason I'm missing?
>
> I spent a couple of hours trying to write up my thoughts but I still have=
n't
> finished =F0=9F=98=85=EF=B8=8F I'll send the full thing tomorrow.
>
> You may have looked at hns3 is that right? It bumps the page pool order
> by 1 so that it can fit two allocations into each page. I'm guessing
> it's a remnant of "page flipping". The other current user of rx-buf-len
> (otx2) doesn't do that - it uses simple page_order(rx_buf_len), AFAICT.
> If that's what you mean - I'd chalk the hns3 behavior to "historical
> reasons", it can probably be straightened out today to everyone's
> benefit.
>
> I wanted to reply already (before I present my "full case" :)) because
> my thinking started slipping in the opposite direction of being
> concerned about "buffer sizes actually posted to the NIC".
> Say the NIC packs packet payloads into buffers like this:
>
>           1          2     3
> packets:  xxxxxxxxx  yyyy  zzzzzzz
> buffers:  [xxxx] [xxxx] [x|yyy] [y|zzz] [zzzz]
>
> Hope the diagram makes sense, each [....] is 4k, headers went elsewhere.
>
> If the user filled in the page pool with 16k buffers, and driver split
> it up into 4k chunks. HW packed the payloads into those 4k chunks,
> and GRO reformed them back into just 2 skb frags. Do we really care
> about the buffer size on the HW fill ring being 4kB ? Isn't what user
> cares about that they saw 2 frags not 5 ?

I think what you're saying is what I was trying to say, but you said
it more eloquently and genetically correct. I'm not familiar with the
GRO packing you're referring to so I just assumed the 'buffer sizes
actually posted to the NIC' are the 'buffer sizes we end up seeing in
the skb frags'.

I guess what I'm trying to say in a different way, is: there are lots
of buffer sizes in the rx path, AFAICT, at least:

1. The size of the allocated netmems from the pp.
2. The size of the buffers posted to the NIC (which will be different
from #1 if the page_pool_fragment_netmem or some other trick like
hns3).
3. The size of the frags that end up in the skb (which will be
different from #2 for GRO/other things I don't fully understand).

...and I'm not sure what rx-buf-len should actually configure. My
thinking is that it probably should configure #3, since that is what
the user cares about, I agree with that.

IIRC when I last looked at this a few weeks ago, I think as written
this patch series makes rx-buf-len actually configure #1.

--=20
Thanks,
Mina

