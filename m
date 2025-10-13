Return-Path: <linux-rdma+bounces-13848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD9BD59C3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5288A350C07
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C22BCF75;
	Mon, 13 Oct 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSbLoXOE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AFD49659;
	Mon, 13 Oct 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378089; cv=none; b=l0AUnOkQ/qbuXYqHJE3j5pukLJmoA1wZLR0ZERUZamGJ8/xOL/vC3XznHkDRmkE6zJhFTYTLu7rXtiYbsQP5CBFqaA7uK3QjrCP7UPhAeg/TZsg5yWkqLxbcsHG5qIWNm6QgyfUwt8d8n+yKMGQizTzbXHnL28BRXaK0oN+jhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378089; c=relaxed/simple;
	bh=EWEtJ0uVO4HZO/aJ732euBce8aoHBa3Di6u9l2h4/yI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhfhumpF/kMHaOy2VZW6k9/WSipnHbVlEpohxGO3iOaUaVMte4/bJEM7FG4hiZx5D/YU09BNz6fivq14MNcC1IEUlnGxmwY/4OivqUa8id5SexRX7bLh+4Sqb0o2K82HH0Aa44Y+7we5h8za3/YFHccHUFz+xKtjOWQ8TxwU4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSbLoXOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00839C4CEE7;
	Mon, 13 Oct 2025 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760378088;
	bh=EWEtJ0uVO4HZO/aJ732euBce8aoHBa3Di6u9l2h4/yI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSbLoXOEvrilJkaTbESHRLeDE5e2R4V+3bVG0TYE+nSUAvDl1/+AOhI5ue6domWT9
	 nQEougzn96fcv4zpP8/x/fx9NN6l2hY/cRlqpA6KIJ5PFzvrwhcfL2XO8WpILANJpV
	 GDgdfY5uogjl4DqMM4edXdZdXoCcoOrYlqiDfe5Ie9eDMMIQctzkopFU/CkxLJFc6k
	 jI9xuKQ0SK05N89h4C6/IqqMFtzHpi59hx0JLMPAF/gmZRhcPFkNawFZGQsceW62v0
	 XuesLaIzifjs9IJZCRjlS28CX1iOcSelVW6nBsU5xzsmuIeY2cue6B/HndV5wcbZJ9
	 np8BoLnKJapzg==
Date: Mon, 13 Oct 2025 10:54:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Jian Shen
 <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Alexander
 Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Joe Damato <joe@dama.to>, David Wei
 <dw@davidwei.uk>, Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Breno Leitao <leitao@debian.org>, Dragos Tatulea
 <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
Message-ID: <20251013105446.3efcb1b3@kernel.org>
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 15:54:02 +0100 Pavel Begunkov wrote:
> Jakub Kicinski (20):
>   docs: ethtool: document that rx_buf_len must control payload lengths
>   net: ethtool: report max value for rx-buf-len
>   net: use zero value to restore rx_buf_len to default
>   net: clarify the meaning of netdev_config members
>   net: add rx_buf_len to netdev config
>   eth: bnxt: read the page size from the adapter struct
>   eth: bnxt: set page pool page order based on rx_page_size
>   eth: bnxt: support setting size of agg buffers via ethtool
>   net: move netdev_config manipulation to dedicated helpers
>   net: reduce indent of struct netdev_queue_mgmt_ops members
>   net: allocate per-queue config structs and pass them thru the queue
>     API
>   net: pass extack to netdev_rx_queue_restart()
>   net: add queue config validation callback
>   eth: bnxt: always set the queue mgmt ops
>   eth: bnxt: store the rx buf size per queue
>   eth: bnxt: adjust the fill level of agg queues with larger buffers
>   netdev: add support for setting rx-buf-len per queue
>   net: wipe the setting of deactived queues
>   eth: bnxt: use queue op config validate
>   eth: bnxt: support per queue configuration of rx-buf-len

I'd like to rework these a little bit.
On reflection I don't like the single size control.
Please hold off.

Also what's the resolution for the maintainers entry / cross posting?

