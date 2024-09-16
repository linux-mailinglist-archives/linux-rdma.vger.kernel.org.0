Return-Path: <linux-rdma+bounces-4973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E497A6CA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF56B29CCA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17415AD9B;
	Mon, 16 Sep 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzsQ9o9c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28C165F0F;
	Mon, 16 Sep 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507639; cv=none; b=HtAbC972vO8gUnB9aIZdEQ6NheqmvZAJ2DK6NdRh/yd5kA4ZUmfuoAabhRf4EkIoKrIfaBzNskAu0B8kCGmHDFJduCirJ6xXxrOFojEGbpXW7KnHEos+qdkc8xr+0uuWk18eAP7ni4xmp6zzTtBPwYczPc3818TXklM2kEfx5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507639; c=relaxed/simple;
	bh=lQO6b2IwHknDJ/0CJjtpfNa7FR3z+58cxqjvSgqUy/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fQJKbuwk/b7+IMk7GuDTC6GKbALB+cwO9xXrmYK+iKgApRQhuHoFDtP/BBYAYPfASD7tRl8FkgqJ6gql8C08w+LVt24lHXxkxpQ1vy38L/RSmv6rOo79DHSaLUE66VHyT63e5DoVPN66XQ0ITk/6Ie58m3vRBEuU13OaG7doF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzsQ9o9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085F5C4CEC4;
	Mon, 16 Sep 2024 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726507639;
	bh=lQO6b2IwHknDJ/0CJjtpfNa7FR3z+58cxqjvSgqUy/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IzsQ9o9ccbAQh7WwRQfsytzS/1t6ckT/ssd+UxcgrBacVFVkeO9MEy0+Ogkgfz7w6
	 Pb70mYsxvbKvmTGKKIST2BKt3xDvkNhRw/jji5G5thoxL9vV4OJT6rLRhqKp5VwDok
	 rIwo0vqJwe6MFNT5fMJOGu10/kW5zt1lU3liMEZ0PPusldbvARsmsffC9SCX/O+1Hv
	 S7YfY5LTbleAbonw5EvNpNYgZH5dBKzOBjTmCmVDIOUNMXANZ3hO0tjvkDJFppbWIH
	 FF6f/XnjHZXIE5xcu3iIkj/B6DLFO6ojv7g31MWNpDFFf6yvVW1qvrghNn5OEAE9lh
	 gBblrUwkD8rqw==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>, 
 Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Roland Dreier <rolandd@cisco.com>, 
 Steve Wise <larrystevenwise@gmail.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20240912145844.77516-1-m.lobanov@rosalinux.ru>
References: <20240912145844.77516-1-m.lobanov@rosalinux.ru>
Subject: Re: [PATCH] RDMA/cxgb4: Added NULL check for lookup_atid
Message-Id: <172650763520.4296.4110173004963203253.b4-ty@kernel.org>
Date: Mon, 16 Sep 2024 20:27:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 12 Sep 2024 10:58:39 -0400, Mikhail Lobanov wrote:
> The lookup_atid() function can return NULL if the ATID is
> invalid or does not exist in the identifier table, which
> could lead to dereferencing a null pointer without a
> check in the `act_establish()` and `act_open_rpl()` functions.
> Add a NULL check to prevent null pointer dereferencing.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: Added NULL check for lookup_atid
      https://git.kernel.org/rdma/rdma/c/e766e6a92410ca

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


