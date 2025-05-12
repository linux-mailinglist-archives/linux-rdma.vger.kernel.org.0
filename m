Return-Path: <linux-rdma+bounces-10298-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968FAB3521
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 12:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C8D17BB4A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C8F25A323;
	Mon, 12 May 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7O2Y98s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CA136988;
	Mon, 12 May 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046719; cv=none; b=Ieqg0gBK6okw2r3vCEs8GplxzPx7DA142mLIxlqmIWwsnvYYY1LgU78ZgzKSfjpthdhfwXGMhtiJb+xN67ltFAtAz/m+a3MFgJDYkxdV2Ggq5oyC/84+JvryGLb4goWT9WVQ1fyqRSFqO5w7mrrh1yF4D/HEWDAfmXwits5iW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046719; c=relaxed/simple;
	bh=GcdRKqkJp370DYiTOA6/0TyNO36BlGXmi7v+/vQvjSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uQ12dpep1NjwSGvvFQlINbB5aNWTOKTqfXI1lhnBHar+2pM2+FpPT0IwxtP3UkQM9vBWG/pzJk8nws/HgJqvby4f/58GBNlR0NM2MZpdHlNfdDgJemSpRwngNAFf8lczZrwDa9Yj5oP+S4stqmyNf3zN60V/MQszW8LvCWdCIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7O2Y98s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC294C4CEE7;
	Mon, 12 May 2025 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747046717;
	bh=GcdRKqkJp370DYiTOA6/0TyNO36BlGXmi7v+/vQvjSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R7O2Y98sziU7KHeRfZDKFZAUutqIae391s/JoHN1Hz1qBXyUx6QzLX1Hg5kl6jUJV
	 QGEm6A2YCQaI60DThDxi77zltC5n2hAY9jfjBjcx6y2xRbawFKXMHzJqU07kSeaHE3
	 F2yV5d3g35JcXlQ5cy3PZf5D+2e0H24jngYDDCtDtV9dWFLrpz3apdOjvVFAFPXwKv
	 OeHW+pXDTep4W77JohxZxf+MmD3hNKGh50h1BMc6Da9wr72Jy4OsPV3C8sNMKjJRkM
	 XhNN/IzpljTRzxa1sInAG2TiNkr314gjJsBoTU/mGdQ2kUztF4TLpqgU3tT9vvZHEm
	 30dIFdVdlAAKg==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com, 
 kys@microsoft.com, edumazet@google.com, kuba@kernel.org, 
 davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
In-Reply-To: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v4 0/4] RDMA/mana_ib: allow separate mana_ib
 for each mana client
Message-Id: <174704671342.585128.135566447814981798.b4-ty@kernel.org>
Date: Mon, 12 May 2025 06:45:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 07 May 2025 08:59:01 -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Microsoft mana adapter has 2 devices in the HW: mana ethernet device and RNIC device.
> Both devices can implement RDMA drivers and, so far, they have been sharing
> one ib device context. However, they are different devices with different
> capabilities in the HW and have different lifetime model.
> 
> [...]

Applied, thanks!

[1/4] net: mana: Probe rdma device in mana driver
      https://git.kernel.org/rdma/rdma/c/ced82fce77e933
[2/4] RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
      https://git.kernel.org/rdma/rdma/c/c390828d4d7b45
[3/4] RDMA/mana_ib: unify mana_ib functions to support any gdma device
      https://git.kernel.org/rdma/rdma/c/d4293f96ce0b6d
[4/4] net: mana: Add support for auxiliary device servicing events
      https://git.kernel.org/rdma/rdma/c/51bb42e5db2b2f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


