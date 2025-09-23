Return-Path: <linux-rdma+bounces-13602-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A467EB968DA
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B499C3BC0D2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8125A34B;
	Tue, 23 Sep 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvkBnLEE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C81E0B9C;
	Tue, 23 Sep 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640992; cv=none; b=oElVE+wLgu/WJfYeRgkY8hJQ05fXVYTeXw8htgX5vAlU6KsMvMumAgE/3h+2EaFAmr4diWD5lqq93lDdDstxFEBmUzbLabn77oJ6CFPo+/5vNpGXPw4ZKog+IfzFNXYSoYX1MThHRKIzWL16MUP1FMg3I3YWY2VzkO+T+eFsJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640992; c=relaxed/simple;
	bh=iWTdvTd18ug7RGIuY5XN1LnYLa6ileenwsLR0FWRDxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHt0kyVbteqbaxQRXOkH9EWVPoGeCxTFvDP1iirdzOkfrEomonPsW/7hkzhD4TVQUbn8883kwlTqO05mr20kjLHeGScsRAAeGDMDy7ERnmQD9o1fZaniGYQGWk5XlI4ix6FsboJg4+0b8oc3rc8QEQ8gvmUgZt2phUEJHv2hOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvkBnLEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAED6C113CF;
	Tue, 23 Sep 2025 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640991;
	bh=iWTdvTd18ug7RGIuY5XN1LnYLa6ileenwsLR0FWRDxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pvkBnLEE2ltgyg6ZwvmA0uWE8A6nvX5u/30d9iRQrleloE5z/6yB4XchqAtFyCw9O
	 MXskExp+GirsZSSZppO1jHdFMjYc4KKy75uXj/y4A470Mx551nvs96b+zTyQ/V0SpH
	 cBwRyWvu/03vEj7HT8+6x/jx//5SudiFloKh885B5fuiDkncSeP8TAzL1i9tqLNVNi
	 e3P8YJMcN959VjYyQCTgDHK7p57L467bH+LOZ1hDbDx7xHd9e6nuTaBpJxq4HqSIEc
	 0pVwn0WDZ+u0vf1J1VqHgkEnLk6ZBTBz8HgFr1KZOwKJAYgBeihWWZrp6vjAipu0R3
	 RxiyGGjxnG6FQ==
Date: Tue, 23 Sep 2025 08:23:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Message-ID: <20250923082310.2316e34d@kernel.org>
In-Reply-To: <a5m5pobrmlrilms7q6latcmakhuectxma7j3u6jjnamcvwsrdb@3jxnbm2lo55s>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
	<1758532715-820422-3-git-send-email-tariqt@nvidia.com>
	<20250923072356.7e6c234f@kernel.org>
	<a5m5pobrmlrilms7q6latcmakhuectxma7j3u6jjnamcvwsrdb@3jxnbm2lo55s>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 15:12:33 +0000 Dragos Tatulea wrote:
> On Tue, Sep 23, 2025 at 07:23:56AM -0700, Jakub Kicinski wrote:
> > On Mon, 22 Sep 2025 12:18:35 +0300 Tariq Toukan wrote:  
> > > When the user configures a large ring size (8K) and a large MTU (9000)
> > > in HW-GRO mode, the queue will fail to allocate due to the size of the
> > > page_pool going above the limit.  
> > 
> > Please do some testing. A PP cache of 32k is just silly, you should
> > probably use a smaller limit.  
> You mean clamping the pool_size to a certain limit so that the page_pool
> ring size doesn't cover a full RQ when the RQ ring size is too large?

Yes, 8k ring will take milliseconds to drain. We don't really need
milliseconds of page cache. By the time the driver processed the full
ring we must have gone thru 128 NAPI cycles, and the application
most likely already stated freeing the pages.

If my math is right at 80Gbps per ring and 9k MTU it takes more than a
1usec to receive a frame. So 8msec to just _receive_ a full ring worth
of data. At Meta we mostly use large rings to cover up scheduler and
IRQ masking latency.

