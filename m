Return-Path: <linux-rdma+bounces-11911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C31AFA392
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513167AE8FF
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908E91A314D;
	Sun,  6 Jul 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NabR035O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE117A586
	for <linux-rdma@vger.kernel.org>; Sun,  6 Jul 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751788590; cv=none; b=GDsNsRswy/xZ0RYh61q5d+YEub3GlcnR5DqsfH7RL52hfiKrRSl2ZvYsNd1ukckfYl/Rb96QrBu39lpHqSzHM13MNxXbDkZ2Qik7ghm7sdHKK0tKzoo2zgnXSrGY898xGEDbVD39f+P89qMCuB+y2uEGvsYEtJS00I9gfp0z6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751788590; c=relaxed/simple;
	bh=vAtbKeo7n6QYWSVjP/hg0BSPcaKtXKbTUE4PRa1PBTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khRFH1lrf9darVSD1esa2Quy45HV0bUfFaorKoa7/yHH8zPIzVpZKM1M8IK38y9/64FJUG5m9IhCEU82EiJuvifEge++jAF4o1Kj9pHW+1ibBLPuxnuAbZg/uUBTSP1zSgbAGvW+GjIhdESNkuyqNQ9FfEVA/+rwq9B59pMZZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NabR035O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF1C4CEED;
	Sun,  6 Jul 2025 07:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751788589;
	bh=vAtbKeo7n6QYWSVjP/hg0BSPcaKtXKbTUE4PRa1PBTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NabR035OMlc9tQmtnpcb93Fb8a8j/RKiS3SyNfKvuCcXTuGa3tDnIlS10goiv4+1Q
	 +keN+XpPSFV62/Jx3Wz5ybe2Y0O+6opkjDe8I5BqkTV6WPA3UYxooJhYcIhn8Dqk8e
	 W4QiLESj6VpAvjfak1zNeX2NnELdxNeutCZMs9EyAfnf8glWTsSBZ7tMSnqkAOyg4a
	 WAU4lzI3mXRcpj6VoAx8DyhV7lflcYvMHriBvEhUyYLB0/6K73iAi9Rez9PoEOgWmB
	 onRRBHVPfDIdrrmTwK5Mic8l/3bUjmJC8pQoFdXpP5EjtY5kPWiSnp0QiNoW/xIdaJ
	 sxSBvzj9qYcaA==
Date: Sun, 6 Jul 2025 10:56:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH 0/8] RDMA/siw: [re-]introduce module parameters and add
 MPA V1
Message-ID: <20250706075624.GS6278@unreal>
References: <cover.1751561826.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751561826.git.metze@samba.org>

On Thu, Jul 03, 2025 at 07:26:11PM +0200, Stefan Metzmacher wrote:
> While working on smbdirect cleanup I'm using siw.ko for
> testing against Windows using Chelsio T404-BT (only supporting MPA V1)
> and T520-BT (supporting MPA V2) cards.
> 
> Up to now I used old patches to add MPA V1 support
> to siw.ko and compiled against the running kernel
> each time. I don't want to do that forever, so
> I re-introduced module parameters in order to
> avoid patching and compiling.
> 
> For my testing I'm using something like this:
> 
>   echo 1 > /sys/module/siw/parameters/mpa_crc_required
>   echo 1 > /sys/module/siw/parameters/mpa_crc_strict
>   echo 0 > /sys/module/siw/parameters/mpa_rdma_write_rtr
>   echo 1 > /sys/module/siw/parameters/mpa_peer_to_peer
> 
>   echo 1 > /sys/module/siw/parameters/mpa_version
>   rdma link add siw_v1_eth0 type siw netdev eth0
> 
>   echo 2 > /sys/module/siw/parameters/mpa_version
>   rdma link add siw_v2_eth1 type siw netdev eth1
> 
> The global parameters are copied at 'rdma link add' time
> and will stay as is for the lifetime of the specific device.
> 
> So I can testing against the T520-BT card using siw_v2_eth1
> and against the T404-BT card using siw_v1_eth0.
> 
> It would be great if this can go upstream.

Sorry no, there is no benefit in adding complexity for such an old device,
like Chelsio T404-BT.

Thanks

