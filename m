Return-Path: <linux-rdma+bounces-3855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6739307D3
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 00:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C3BB22AD6
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2024 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51150148301;
	Sat, 13 Jul 2024 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTRZrNDD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820114388E;
	Sat, 13 Jul 2024 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910403; cv=none; b=kbtCHcxHSm3pOXDuZg8Ck6UUQiEUSGU5jwT0TOqKEd2hvrVvMcTPUV+JogvOp4FrH3utegLMuveuT9j6fM3uVeF+bl/UQcpJg8MxC7Af2PABXWYj7Q1hKu7GQELBVF6pb0CCrX7W4Wyrl0xYauGZ/1ocgXti+2JVmvLLZbWUdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910403; c=relaxed/simple;
	bh=Mj0RjWNgbBjGNr3FlRvT2/B+5iT7Xih2HynTQ7PZ/u4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfWqjypNcOEqR3OSlO97fmfOa5pZV5ohWY65qeTtKQ3IMeZpjDqY8/EgxWAoi/kikYvn10QCoyXhlObQ36TSS2lFRDc0Ed5tlPSsu8OulcjRxW/EQunONsf7rzFum6+cuHE3LTPQhIXnyy3MsXFyMBRCH0dFnCiSx2x2m1bUWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTRZrNDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1776CC32781;
	Sat, 13 Jul 2024 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720910402;
	bh=Mj0RjWNgbBjGNr3FlRvT2/B+5iT7Xih2HynTQ7PZ/u4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rTRZrNDDxghQLFMWOBvbUAos86D5e6vcIAHcRsHbHNIlRKOel4SSFcd49sT/noSL8
	 xC1YxgMHo0nTzumo0fD9QH2upMAq6wUGeMX6HMiLSYSWMCSYE/XSm2eT0m6UUWZyVo
	 NN/Wvic4988zlLEFUG4yxheGkOdfbURh2OCNlZOkEK9tN7DxFgTFsJoHg3fgnR8bai
	 ZebFlmWhJAm28j68ZSXNBNCh/rIX2KjuDm/yvNFVBVKbbVhyv1ZKtp2zL+BsPcay32
	 ipBbXc8JLKQ+w4cMz9rpLhU3ONiP3Two+gB5iueF6A65/f+iXexdKTnUaBby7AcYkw
	 I3h7jkn3dVOng==
Date: Sat, 13 Jul 2024 15:40:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: Saeed Mahameed <saeed@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, saeedm@mellanox.com,
 leon@kernel.org, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next] net/mlx5: Reclaim max 50K pages at once
Message-ID: <20240713154001.5eb3313f@kernel.org>
In-Reply-To: <ZpDeuoUlVoUON8Em@x130.lan>
References: <20240711151322.158274-1-anand.a.khoje@oracle.com>
	<ZpCI0mGJaNDFjMno@x130>
	<c8d99dba-89e9-4bf2-b436-f1a29cd573bb@oracle.com>
	<ZpDeuoUlVoUON8Em@x130.lan>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 00:43:54 -0700 Saeed Mahameed wrote:
> Maybe improve the commit message a bit? Just explain about the unnecessary
> alloc/free of the extra mailboxes for the large outbox buffer, since the FW
> is limited and will never use this memory, so it's an unnecessary overhead.

+1

