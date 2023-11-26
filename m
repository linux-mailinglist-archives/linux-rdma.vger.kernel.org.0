Return-Path: <linux-rdma+bounces-81-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF287F9201
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Nov 2023 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB121C20A42
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Nov 2023 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789786FAF;
	Sun, 26 Nov 2023 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kolzkQt6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2B6AB6
	for <linux-rdma@vger.kernel.org>; Sun, 26 Nov 2023 09:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02795C433C7;
	Sun, 26 Nov 2023 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700991255;
	bh=3Vufds7pYFvN+O3gx5CDpwVUij5xke9LLE3N1ySI6qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kolzkQt6xcgztni4GLiSdIjGVj1AzmcpJbFiUmskSRODZRu4nEKj4LIbJp0bAIDg4
	 reUNI+qeOFFDYsyGsMie26WqxN9CMNpHq5lQze/xhoTWNipzakolW+clnonGSoGdlG
	 J2BmYcfbS0LAJBizLuJMeOAtYX0KegpOGmdxOakUzJGALCr14cuzlhj5cI3rQW2HtJ
	 vtbBZjShgWX1o8yOXOPh38YZA7UCeqqF4AQmNEFig2AdOp1eDLxGv/jPKKYYWbI0Gi
	 4Hj7G5vZ2o1FDHqgtnyMLvJ/a5z74L8hXvs4l03gJ52GPjDfjXLv3xYsdtNJzf9jvJ
	 d36kWFjg/mL4Q==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>
Cc: jgg@ziepe.ca
In-Reply-To: <20231121130316.126364-1-jinpu.wang@ionos.com>
References: <20231121130316.126364-1-jinpu.wang@ionos.com>
Subject: Re: [PATCHv2 0/2] ipoib bugfix
Message-Id: <170099125121.140917.9860282338436034485.b4-ty@kernel.org>
Date: Sun, 26 Nov 2023 11:34:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 21 Nov 2023 14:03:14 +0100, Jack Wang wrote:
> We run into queue timeout often with call trace as such:
> NETDEV WATCHDOG: ib0.beef (): transmit queue 26 timed out
> Call Trace:
> call_timer_fn+0x27/0x100
> __run_timers.part.0+0x1be/0x230
> ? mlx5_cq_tasklet_cb+0x6d/0x140 [mlx5_core]
> run_timer_softirq+0x26/0x50
> __do_softirq+0xbc/0x26d
> asm_call_irq_on_stack+0xf/0x20
> ib0.beef: transmit timeout: latency 10 msecs
> ib0.beef: queue stopped 0, tx_head 0, tx_tail 0, global_tx_head 0, global_tx_tail 0
> 
> [...]

Applied, thanks!

[1/2] ipoib: Fix error code return in ipoib_mcast_join
      https://git.kernel.org/rdma/rdma/c/753fff78f43070
[2/2] ipoib: Add tx timeout work to recover queue stop situation
      https://git.kernel.org/rdma/rdma/c/50af5d12f7e24b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

