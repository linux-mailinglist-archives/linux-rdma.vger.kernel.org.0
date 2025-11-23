Return-Path: <linux-rdma+bounces-14703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6673AC7DE8E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 10:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E153B3A92F1
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7329B764;
	Sun, 23 Nov 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdRrQvQo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D713B293;
	Sun, 23 Nov 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889198; cv=none; b=Kqd9JpfSdrDZBC7FmjznT0qgLKQ0lQbEpdL1KfkbCj+nLKKaiKLKGWwr8mCM13O54iTMuEXQk/K1m90jFy1KlZKvl+imfZk4Mf7h9zvkuMwCAcquvXB5pwxRpaobkzdZyY+QSGFyYz/jokfletwRvLK7/pATtznnf4Ycve1KQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889198; c=relaxed/simple;
	bh=qMwQ/vf94s4B8hgH1kN9jESt5L4ZK46ZgtivkUnpZTM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bnVlrQAP+RMbiMaf5a/GQs6fm0VTV0piZOe6dFeL76bNZjYMuSDLJPTvY2l3deYrbiL5cLEpjI4opfKuu3Yu26drPlGTecWc9mb8pRoKKnSVdpejQjPrPzqP6Fi0xph4GN+t92Ez4BRiaPiGrrQIkd4V3Y85urYU4X4UiYsiFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdRrQvQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F40C113D0;
	Sun, 23 Nov 2025 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763889197;
	bh=qMwQ/vf94s4B8hgH1kN9jESt5L4ZK46ZgtivkUnpZTM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RdRrQvQoc5SCg22nO/ge5bmpHgy7jRrMARdauiiiT6VK8sNYUuFlZPqbFVnBI2X5j
	 37XzyG7f4wkoSjfMvSgqz8y8fCH0QmHQt38U+G6+s5Vjr3KH4lGtvqWqEf8QYQR0rQ
	 zHw4btIAunzD8BvRHN8/VOEnbjBuOxShyRHjxm52GN04p3m0GIuEvMWOLI5oLEdlrW
	 mUuuweBbbaVwO3ESbBX8StDX8dJYvj8nS6466FsP7KhKq5bKTl+O2OE7JP6mCxKnRC
	 yTft9n1upSDupMQBi/1Pc4LMDDEmIspxLIjyYjKRnB2riWszn2kadNdgEzYVxgPR88
	 uYtMjnVqCRg0w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yishai Hadas <yishaih@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>, 
 Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20251120-reduce-ksm-v1-1-6864bfc814dc@kernel.org>
References: <20251120-reduce-ksm-v1-1-6864bfc814dc@kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Reduce IMR KSM size when 5-level
 paging is enabled
Message-Id: <176388919468.1783514.9358959459855331067.b4-ty@kernel.org>
Date: Sun, 23 Nov 2025 04:13:14 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 20 Nov 2025 16:49:28 +0200, Leon Romanovsky wrote:
> Enabling 5-level paging (LA57) increases TASK_SIZE on x86_64 from 2^47
> to 2^56. This affects implicit ODP, which uses TASK_SIZE to calculate
> the number of IMR KSM entries.
> 
> As a result, the number of entries and the memory usage for KSM mkeys
> increase drastically:
> 
> [...]

Applied, thanks!

[1/1] IB/mlx5: Reduce IMR KSM size when 5-level paging is enabled
      https://git.kernel.org/rdma/rdma/c/4bf35d1d17c8d5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


