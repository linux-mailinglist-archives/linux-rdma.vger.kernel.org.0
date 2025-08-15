Return-Path: <linux-rdma+bounces-12777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED751B28642
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239FBB61904
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AB242D6C;
	Fri, 15 Aug 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PruoxHLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3692AD21;
	Fri, 15 Aug 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285562; cv=none; b=WaXhg5neSw2NtntRXnZ7MVgy8Uz0PegH4uJi6g/EV/HpbQI37QwkhRzwbrCljb3p5RvsgyijYpamDehgOmZSNIzEv7+fyHj5Rnf7B1kPdjd7hRRxbaBgCN5jEAQ/FAecv1emQlwbClrTrqjhNFuW/e6EsP/iO40TgevpRvD8tNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285562; c=relaxed/simple;
	bh=qfPT0VRlhVkZQTijCBa6A1kTR1vmk0XxmuYkvun4LjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r60n6bjtiq9jttQmpI55aL0boifvxsfcwGwR7euBY7cEoxHXSxotQAb7Vd/e4gK767YDyfMwql8yXtarhyUqLehti424giA59RbVvqopdS10adlA88UorL8edFcSXy4biHHQy6Vmh90MFf/ef8+w+6SqXdDXTxB1l9qezDYwOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PruoxHLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F364C4CEEB;
	Fri, 15 Aug 2025 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755285561;
	bh=qfPT0VRlhVkZQTijCBa6A1kTR1vmk0XxmuYkvun4LjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PruoxHLgp+5J2J1cq8xZ/REoFYESEe3lNH80UYCQlTTfoJdiZmh01uBKmsl9f2olE
	 Txbg1qGd1Y7HYAO7Y3jy6iWIYhXNYDGJX2mPfJ/qB+nDETW5QxapXx4Ofd7SHrPs6L
	 u2mIn1TpOT4zKbKDsP8M5n4HT0TCj0ROe47nWPMB1gW0Lnv7kC2iMJREGcX7Izi1QM
	 GtumUHuRqtaI/C2Uc2jA6PAN+uWItg38WAvbOs+YaqY2lsdk93IRu6/cIHYyv8z0uA
	 x4+D8tc8FVvRoNrFbHBWCQPLpVw6giCtD8rOIs1NpkPGDV5Qp6pC7fE8TSDPARG6sw
	 Lq8qw72jQlb9Q==
Date: Fri, 15 Aug 2025 12:19:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Brett
 Creeley <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai Huoqing"
 <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>, "Gal Pressman" <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, "Shahar Shitrit" <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next V3 1/5] devlink: Move graceful period parameter
 to reporter ops
Message-ID: <20250815121919.21d391ea@kernel.org>
In-Reply-To: <1755111349-416632-2-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
	<1755111349-416632-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 21:55:45 +0300 Tariq Toukan wrote:
>   * @test: callback to trigger a test event
> + * @default_graceful_period: default min time (in msec)
> +			     between recovery attempts
>   */

Missing * at the start of the line.

