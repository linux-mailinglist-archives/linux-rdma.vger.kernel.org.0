Return-Path: <linux-rdma+bounces-15291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47931CF1109
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7ED1302C238
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F80219A8A;
	Sun,  4 Jan 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcu/MnC2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA2229B18
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767536645; cv=none; b=NPTZdxatf0G23j9rNR3vghL7QbOQplxB2QK5YRPGmqcfFPVqz1f3U1ehafd6GefhlBPMf0Uqb48xrxqjxzYxVRagJ0zXRpNlGQMfAEnsitBxGQe1biqx2Btieqh2Yr32oTqqzZWSoDj+ucwGGmQCex48BO+4JP2/ZHFz7o23qtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767536645; c=relaxed/simple;
	bh=GQS34UVamlbclnYODsy0YFtxwUEu0QLqSDSPZo92WWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OuJ/3H04U2h4tv8nkRO0M6zOO4RWjJtWrC4+tczzxLctshygvOkeHxwntuptm9OsZTQObqOLfG3vt7TwlDoCuOpgMfU+O/IsQVRE144n1dwxZwM/agLWy+4bH6ky8YiRBUpvxX7Xi51cum6SpWONjNTTfHJ3EYbdCs6kwKeWaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcu/MnC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54DC19421;
	Sun,  4 Jan 2026 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767536645;
	bh=GQS34UVamlbclnYODsy0YFtxwUEu0QLqSDSPZo92WWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Xcu/MnC2EoC/cr9RLGNxaysijiIOoGD0eOvhAEUSXWg67jV/Mxr1szMynL968HXVm
	 oLiPe0W2NAlZOp12norfbymrEwHRkEAMVcEUCpxE05YKBwgmUPf6BH5n6ncFfKvYMR
	 Zq+Vc+xne/KjXLiRF2QnH4WZm/EhVJyb4uVS5vhwYtdF7E0/9dJ74ERX6k0RlJiOX3
	 +vVE9zFHHmsOivmyAzIOAuCg1b8n4uE9okUkE229wIjiPPPSI8T2RMDsTkVKjh5ukO
	 rumN2TdK3JmYGAT2MKsAO/felsD7fBl/72J8Gz2jnLi0lrQ4vQ3u0yOXYSFo5FQC/3
	 hIHZEl4TTlG7A==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Etienne AUJAMES <eaujames@ddn.com>
Cc: Romain Fihue <romain.fihue@cea.fr>, Gael Delbary <gdelbary@ddn.com>
In-Reply-To: <aVUfsO58QIDn5bGX@eaujamesFR0130>
References: <aVUfsO58QIDn5bGX@eaujamesFR0130>
Subject: Re: [PATCH] IB/cache: update gid cache on client reregister event
Message-Id: <176753664208.1100674.4411663781736567726.b4-ty@kernel.org>
Date: Sun, 04 Jan 2026 09:24:02 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 31 Dec 2025 14:07:45 +0100, Etienne AUJAMES wrote:
> Some HCAs (e.g: ConnectX4) do not trigger a IB_EVENT_GID_CHANGE on
> subnet prefix update from SM (PortInfo).
> 
> Since the d58c23c92548, the GID cache is updated exclusively on
> IB_EVENT_GID_CHANGE. If this event is not emitted, the subnet prefix
> in the IPoIB interface’s hardware address remains set to its default
> value (0xfe80000000000000).
> Then rdma_bind_addr() failed because it relies on hardware address to
> find the port GID (subnet_prefix + port GUID).
> 
> [...]

Applied, thanks!

[1/1] IB/cache: update gid cache on client reregister event
      https://git.kernel.org/rdma/rdma/c/ddd6c8c873e912

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


