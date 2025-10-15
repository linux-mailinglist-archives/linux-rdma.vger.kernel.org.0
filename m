Return-Path: <linux-rdma+bounces-13866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39CBDC020
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 03:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617C14E771D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B81270568;
	Wed, 15 Oct 2025 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMiL3hX8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE42F9DAF;
	Wed, 15 Oct 2025 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492482; cv=none; b=ojjBTWHLIT4J9lqJ8odWUwJGue3/9R5blRlnZGPhDOOEedh9niPbkv4tnLV8RtShtlfUe8+mlHI8BiO6m756LLthqmHVU0SGHz+dHDFNZ0HIUgwDBSXL9JVkN1xF8tJzUkMDC9Sv28Q2iH+rBq/znVdP8NhjOOKm8OMzRcQ6E20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492482; c=relaxed/simple;
	bh=SyJQgJW0irdP5xxqqLPTFxfy59JUm3m73O6H7QTmz2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ8RXAH1mTRHJ3AvovyHFzkVfgR8YkfGh2keoxC4Vei3SueKCyRGua0r2BaKQfhR+DQPj65IZQnEiyqDlYI74VBW1j8UOJu6JiO3T2rWqmmNLQSY/7MvmGew0H9FOk7hBW5eZXZ4PHA9zwO0cywTkn68AOiKs/8ylKLT70yFZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMiL3hX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C61AC4CEE7;
	Wed, 15 Oct 2025 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760492482;
	bh=SyJQgJW0irdP5xxqqLPTFxfy59JUm3m73O6H7QTmz2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMiL3hX8vxmiEwgCLvgeRSHprM1Kj/R/uq/r3jfd5NO/FWqCmRxpFs5sHM7n9Hyws
	 T7Qt21vQQB8W9v7t1ZZJR7ZJrMVBnFzeW6OrTrpxScom0/IRNfJ351buvSTEq/bcNe
	 ZkhxT2XLAtTPWraUxejX3cgKhZPkDL8pkPCxik/ZIhZJHtj8tIuG7cXJnBZpdVupOQ
	 6+kf4nHZexMOM6AN7j2UQfITgko/mGweSwTayw/ZZuTySR6R0/jIiIwdep5skQNPq7
	 WrOxvCz1btwFJZ5GDSq1TRjDwugSA1SJJlFmlpa8oz1JvO2/Bqp3DdjUSP5dGZN/yF
	 lVxbgMTSumU1g==
Date: Tue, 14 Oct 2025 18:41:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Joshua
 Washington <joshwash@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Joe
 Damato <joe@dama.to>, David Wei <dw@davidwei.uk>, Willem de Bruijn
 <willemb@google.com>, Breno Leitao <leitao@debian.org>, Dragos Tatulea
 <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
Message-ID: <20251014184119.3ba2dd70@kernel.org>
In-Reply-To: <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
	<20251013105446.3efcb1b3@kernel.org>
	<CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 21:41:38 -0700 Mina Almasry wrote:
> > I'd like to rework these a little bit.
> > On reflection I don't like the single size control.
> > Please hold off.
>
> FWIW when I last looked at this I didn't like that the size control
> seemed to control the size of the allocations made from the pp, but
> not the size actually posted to the NIC.
>=20
> I.e. in the scenario where the driver fragments each pp buffer into 2,
> and the user asks for 8K rx-buf-len, the size actually posted to the
> NIC would have actually been 4K (8K / 2 for 2 fragments).
>=20
> Not sure how much of a concern this really is. I thought it would be
> great if somehow rx-buf-len controlled the buffer sizes actually
> posted to the NIC, because that what ultimately matters, no (it ends
> up being the size of the incoming frags)? Or does that not matter for
> some reason I'm missing?

I spent a couple of hours trying to write up my thoughts but I still haven't
finished =F0=9F=98=85=EF=B8=8F I'll send the full thing tomorrow.

You may have looked at hns3 is that right? It bumps the page pool order
by 1 so that it can fit two allocations into each page. I'm guessing
it's a remnant of "page flipping". The other current user of rx-buf-len
(otx2) doesn't do that - it uses simple page_order(rx_buf_len), AFAICT.
If that's what you mean - I'd chalk the hns3 behavior to "historical
reasons", it can probably be straightened out today to everyone's
benefit.

I wanted to reply already (before I present my "full case" :)) because
my thinking started slipping in the opposite direction of being
concerned about "buffer sizes actually posted to the NIC".=20
Say the NIC packs packet payloads into buffers like this:

          1          2     3     =20
packets:  xxxxxxxxx  yyyy  zzzzzzz
buffers:  [xxxx] [xxxx] [x|yyy] [y|zzz] [zzzz]

Hope the diagram makes sense, each [....] is 4k, headers went elsewhere.

If the user filled in the page pool with 16k buffers, and driver split
it up into 4k chunks. HW packed the payloads into those 4k chunks,
and GRO reformed them back into just 2 skb frags. Do we really care
about the buffer size on the HW fill ring being 4kB ? Isn't what user
cares about that they saw 2 frags not 5 ?

