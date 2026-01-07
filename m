Return-Path: <linux-rdma+bounces-15343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635DCFD940
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 13:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945FC3004F73
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CC30FC17;
	Wed,  7 Jan 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fncxoOsY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC730F53A
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787820; cv=none; b=du6IEVGB2TwZWPGHjgHg1DxJkg6dnSx0f14TxbL2tUEVXrGpKPIRQWhm/GbFz6OguSp6oU8vfuUKmZt6MNewU+nVkZ2iG6qos8/eL3lan656mU02RYzc5YWH57GsECIs7x3zHvUdItXq+Rms4ReZWzCO1MBEnESDLn9sGU1Q8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787820; c=relaxed/simple;
	bh=+MeWLzBJhCgNfr6oqAb2bN0MvWd+w4M92RtrMQhnVpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBG/4WBku+kI3oMQ/1yi0ALfihOPOmwyKcS8hbXYVlXiEtDy+J8v4OEwyrzyvN/4oh+WrHuMMIH9hkfNwIcoueJKA9Yh2ZHaMi4tPWloHWqvsj1HuzmuPQTfMO6t79MGfIWN91SH/v+Xg4Uuu1hMN3dBBWjMXPk0zTL9CP14XgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fncxoOsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A85C16AAE;
	Wed,  7 Jan 2026 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767787819;
	bh=+MeWLzBJhCgNfr6oqAb2bN0MvWd+w4M92RtrMQhnVpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fncxoOsYUrLuxs6jon+c74TucLq1oMUH9lAUjX/3PZqot2WBxZeZXRopvMSJWFmdN
	 eOO4Lz+EJ302b41dZgOuuouLAYg1s/HNAt97R0j55Xj11tXwfvlXpIQfrxc1AGD38H
	 XnBex53A9slAvMAiMmPR6LLViDB0Iryjvr7XExUy/nICMGhOniXGdpeb9qw4nnvAWu
	 T+TViIJUEx7tQqCclABBeEKXY73i46+biN+454PiSF1tMbrCXcxLjgQjvPSEBPN+H1
	 02IAAPvkGpeIxnTfywBKYLKXWcxSbqtTtuAwssVN7rwN+xqd9BIYrolCDnksPFj7Kr
	 vUaPzXDThVgRg==
Date: Wed, 7 Jan 2026 14:10:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chen Zhen <chenzhen126@huawei.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, huyizhen2@huawei.com
Subject: Re: Question about the relevance of "Fix memory corruption in CM"
 patchset to syzkaller bugs found on stable 5.10
Message-ID: <20260107121016.GC11783@unreal>
References: <239215b6-5780-4f58-a6f4-5bddf1edf33e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239215b6-5780-4f58-a6f4-5bddf1edf33e@huawei.com>

On Wed, Jan 07, 2026 at 05:22:55PM +0800, Chen Zhen wrote:
> Hi everyone,
> 
> I am reaching out to consult on two recent syzkaller issues found in the ib/cm module on stable 5.10.
> Both issues occur when ib_cancel_mad interacts with cm_id_priv->av.port data.
> 
> I noticed the following patchset from Leon:
> Fix memory corruption in CM, Link:https://lore.kernel.org/all/cover.1622629024.git.leonro@nvidia.com/
> The description of that patchset mentions fixing memory corruption.
> 
> I would like to ask:
> Is this specific patchset intended to cover the null-ptr-deref and UAF scenarios described below?

It looks like that work should address your MAD issues.

> If not, is there any other known work regarding these lifetime issues in the CM module?

I'm not aware of any.

Thanks

