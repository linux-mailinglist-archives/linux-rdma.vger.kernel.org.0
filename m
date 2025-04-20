Return-Path: <linux-rdma+bounces-9608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE873A94770
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AA2188C02C
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E11E500C;
	Sun, 20 Apr 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvBZFkza"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBF53AC;
	Sun, 20 Apr 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745145412; cv=none; b=raAfTtk+4cuyUE+UMNjHUfmEsik5jVQLZv7Egn08sNxs4ny6omICp2xbUuBQIXV4jB4PstdupYvr1GAPw9eMwwcbRC8t8CHdc8Wdb9OSud9Z0IsRcWfDx0qzLYTyPuq8iqK/z+ZWiGqoBCHMYuDYKnlDG9RH5opvLrAEmK61cfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745145412; c=relaxed/simple;
	bh=uhcP4JQuZ+O5aUwKyL4gci9JJUxubsOlXx56oGvaOp8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UFuGGRJhqY2hOaRn7ze7x31N5dGgRSvw31R8M+EicLDJNn1jrRVS+GM6sb03rGYb2QTh1pced2TH5lsEbUL+40TBi1Zr+IPHMEiOj5PwigtkbLNiGb3Car6f8z8woAgICpetkhQLK/o0rxOwfv2e5+9sSYGInZHaCHZsCpep3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvBZFkza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1C3C4CEE2;
	Sun, 20 Apr 2025 10:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745145411;
	bh=uhcP4JQuZ+O5aUwKyL4gci9JJUxubsOlXx56oGvaOp8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EvBZFkza0iuCzWhxwduMZMhKWAzXK39MLZgIA9708ICHcBA64yI7/hIj9A9V+Gf47
	 d3hxGGbqNmLQByACohunBRkbihOGXdoF1viJbvHogCgcYlG7l4iKiropUY2iG1acAG
	 LwO2l1UFFEgfDEDxdS6KE8Oj1idjQpQjB570X4ucOaqzdWHtiZm/OIxMooZHjpe4O6
	 bXf5FY7dKrtNMR+C7cDa2qWAYweTWicdvf2zYsMwlsfRcHbjp7olTV6zrYpit/1GoP
	 gGfxhs2jEeG3tRI/gqjUMQbICngM9YsAJ1x4xjNZN6aUaW1+3cneef1o2EgXQdQEmz
	 WpwCgTCeBmVDw==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com, 
 kys@microsoft.com, edumazet@google.com, kuba@kernel.org, 
 davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
In-Reply-To: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 0/3] RDMA/mana_ib: extend MR support
Message-Id: <174514540778.718661.3321342934639460524.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 06:36:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 14 Apr 2025 02:00:31 -0700, Konstantin Taranov wrote:
> This patch series extends MR support for mana.
> It implements two flags for MRs: REMOTE_ATOMIC and ZERO_BASED
> It also adds support for large page sizes.
> 
> v1->v2:
> - removed unused enum values for page sizes
> 
> [...]

Applied, thanks!

[1/3] RDMA/mana_ib: Access remote atomic for MRs
      https://git.kernel.org/rdma/rdma/c/7d40ccf018694a
[2/3] RDMA/mana_ib: support of the zero based MRs
      https://git.kernel.org/rdma/rdma/c/8f49682d94f3a1
[3/3] RDMA/mana_ib: Add support of 4M, 1G, and 2G pages
      https://git.kernel.org/rdma/rdma/c/f1652d76f4c51b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


