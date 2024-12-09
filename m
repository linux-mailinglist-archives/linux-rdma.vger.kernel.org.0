Return-Path: <linux-rdma+bounces-6362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D20B9EA2FE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 00:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901B8282A31
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4DB22489F;
	Mon,  9 Dec 2024 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxdAJsiY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE719B3EE;
	Mon,  9 Dec 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787793; cv=none; b=dco4hVO6SkkURZ+XmSLW/Xoq5YqQ7wJp/NPraGsmyKWGeOuaexvsT+sv9XdU66G4BGrXAYoHOeiOmefJ1B210acm+mnZYZWbmnaB3qp9qDcyM6MWh+nf4MEHJ5MUjjxYO9X+JYRIapDB8QjzKX/K8NqR6/9nN/gwhpiLJZpWEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787793; c=relaxed/simple;
	bh=2wzS+Olg+lmZyD9EpYRER7c4q8VA96UI6j8BtIqUWas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWmxBxbJa7pRoKs7umq9/unH4/Hr4ZEmRTDpBOZ2lhFHrpYXnARP8rZEitITFkbJF0cwEZ2JSRJms8/bwbF9alQ0PGxbolnQEc6HIy5AyEcpY/vERb4fDLymMlhJwvCYMizEmJ4QRs43GCZ2/RYpotVdZ3f/IdIiUhZSbVf6JsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxdAJsiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B60C4CED1;
	Mon,  9 Dec 2024 23:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733787792;
	bh=2wzS+Olg+lmZyD9EpYRER7c4q8VA96UI6j8BtIqUWas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxdAJsiYuXIxXF1gkwuev2otojh8GZ3JHHplWU1GLyeHnaLnLWyMJQG4pCOhGQg9f
	 4TdWP2W9hgFQf5W+D44e6op35MtC1tnEeu82ChavQaj/dxCBGK/wAXfWlUtmx47qb0
	 SKDijhyGIYUkrcznMNJEAN4MSz7BfirwUGER6y4G4U36imEWZNQVJceWzO7BMxxcPM
	 tV+Z/LuEHB+pGfmEhAUXIZikEoJxXSGkRWVnCaJUd+FXpUbi9MEzuAOrxVlceNd0fJ
	 r9zHQX0hjWxLuC1LyRViYSbGsOgfxC9WwsfHGpwqrEq1pbVZtSQoTGGDloRoXtJUn9
	 81PhNQP/Py79A==
Date: Mon, 9 Dec 2024 15:43:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>, pasic@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
Message-ID: <20241209154310.49a092da@kernel.org>
In-Reply-To: <1fc33d2e-83c1-4651-b761-27188d22fba0@linux.ibm.com>
References: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
	<20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
	<1fc33d2e-83c1-4651-b761-27188d22fba0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 15:10:56 +0100 Wenjia Zhang wrote:
> @Jakub, could you please give us some more time to verify the issue 
> mentioned above?

No problem. I'll marked it as Awaiting upstream, please repost when
ready. This is our usual process when maintainers of a subsystem need
more time or need to do validation before we merge.
-- 
pw-bot: au

