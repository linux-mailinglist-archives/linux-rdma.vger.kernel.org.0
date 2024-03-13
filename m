Return-Path: <linux-rdma+bounces-1410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4587A13F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 03:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CB9B20F56
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532ABB66C;
	Wed, 13 Mar 2024 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5qKkqNh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFFAD21;
	Wed, 13 Mar 2024 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295357; cv=none; b=GTGGnOhlaPWgKb1pKIWBiTWfnUyHz6nfrcBWjzGoYEXpWLW9ucjnbvaqV3NYNMvuXTy74eVRNCP9BnwH2pEErGKXsGVEQUjMdMaoLRFo96Ymq3IPEDbmDVxP5RAUzha+HpSsBOof768rGBNs82ALv0rkBCccVTUTA6ksCwgqXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295357; c=relaxed/simple;
	bh=aRlNr6TlZ6w/16sVYsd6NmAi7cgcr+0+wqyyHtNPDk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DETJ1pyeH9hnxIJMXgcNrXk8PVJNuJN+DWgVeT2/Galcxxrn3e8c4NX1+F/6jSLSYFi2G8Acg02sTeGEVPT/k4Bx+Kqez625twEQQqMPybHR5a+2P6E2k3vgdXdixf4f1n0UcLgHJruIIUsN790Mmt2c4gMW96k1yulMOuJGTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5qKkqNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B175C433F1;
	Wed, 13 Mar 2024 02:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710295356;
	bh=aRlNr6TlZ6w/16sVYsd6NmAi7cgcr+0+wqyyHtNPDk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5qKkqNhtgeCrT4GuacNQraKZGExyDx54pnYKh5mqd/fwY2S0Pmok7xZLvWAgpMfR
	 A0JvXgvprBxJHH76DlG0/OE3Cby+oXOjcDPzqgtwRe+7JH1Hu0cbw8fXhTXfyJMv4U
	 NTluLbQytfgN6CI7guPqC7EA7hQM44eL8mGXf3jpA6cqt8SB7NI1Dct6VJJwItWCnw
	 lae7F0uBZBZON16hC62wgJpuu74x50n1NfMVEoWL2nnNzUnZwyhnicp3WT701MNh8r
	 +GXTDmX33OgA4svJyR2oBOS14EsnNBd3Ml5f8B2JAhGG5b0GY1MyYgGk56v4VLdxm3
	 yn7Zi541kjtNA==
Date: Tue, 12 Mar 2024 19:02:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, allison.henderson@oracle.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: Re: [PATCH v5 net 0/2] tcp/rds: Fix use-after-free around kernel
 TCP reqsk.
Message-ID: <20240312190235.7ac3bcb4@kernel.org>
In-Reply-To: <20240312085942.3601d2c6@kernel.org>
References: <20240308200122.64357-1-kuniyu@amazon.com>
	<171025623204.23106.14167752316235591977.git-patchwork-notify@kernel.org>
	<20240312085942.3601d2c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 08:59:42 -0700 Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 15:10:32 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
> >   - [v5,net,1/2] tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
> >     https://git.kernel.org/netdev/net/c/a7b7079bc292
> >   - [v5,net,2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
> >     https://git.kernel.org/netdev/net/c/a28895fc04fa  
> 
> I think I need to discard these, otherwise I won't be able to fast
> forward after Linus pulls :( I re-apply later.

Back in it goes, hopefully we didn't cause too much strife with 
the reset.

