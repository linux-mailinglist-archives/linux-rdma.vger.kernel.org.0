Return-Path: <linux-rdma+bounces-915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623484A8B3
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 23:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63091F2DD04
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E55786A;
	Mon,  5 Feb 2024 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEmKs9O0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B557323;
	Mon,  5 Feb 2024 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168513; cv=none; b=F3MvirF+xyA58NBinho8SlvO2WGE+Kr3R45m38ENLZ8Z/8MoQn7xP5OUcgKHX/2qj2t34fRYKSvXOzaqhc1LAUHFRiZPedrdYCUhjndusVP8DS3RseozB76FlJd/B/MFQjfyesnQngwuDJjQ2Qt8/HrjjzWLXno81qHf2QPRONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168513; c=relaxed/simple;
	bh=z4n4Vd0n3U+lCN6DKU3eohvRYPY82wjJzBB2auU/6m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IukBLSin/vyyeVyq3kK0Vi+tTq0UXj8zKLQ0NwKmX77gBm4O/JOKytj9DWLr9rWnAjPW2vjCvOgZtAqxUjOIri2pknBk1PaDWUoQE3LnvYlAX3aXq76qJwF20nsI7JwngVdshoaDE1nQLzBGlPAcOe+K/vA8O7fzN37Q7/uPKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEmKs9O0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bSV0lPnPatMa4CqcYkYg+uR1nV9plc3nYeQphc9sETI=; b=oEmKs9O0iiLD4diVduUmpl/wCU
	iNOCHOOe8ThApK9xYGKzHTT8pcMFofW0sqmQn4UFNJf3cd6yxsv8nItp1+RP7Kd1OuZwKApTnXAsF
	dA00TH2ioXAaLcW/QTZdbwjB+MOl7n8TdD/Myz7vOlOeP4QIyBjIf3QoGMigxJ/B+UsDmoKjx8nFP
	+7wkqTgHl0a3eqtTTSr7MoB/S/kK99kdDoNJSW9MHZ3iQwKXFksNkyTFaTXxfyiyY+i0h2zQazVj+
	K5lXbYPyt2Bli1g2uYod5tmGjs+cmRa17wspYihKDoZ7anUZwxoyVA7Av3dEG2QsoQ6S7rSaalROT
	r2TM5iNw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX6Vv-00000005Eti-40rR;
	Mon, 05 Feb 2024 21:28:28 +0000
Message-ID: <1b1aab8b-fcd2-4dbd-aa79-4b5afb0e0346@infradead.org>
Date: Mon, 5 Feb 2024 13:28:27 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-nex] mlx4: Address spelling errors
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 2/5/24 03:51, Simon Horman wrote:
> Address spelling errors flagged by codespell.
> 
> This patch follows-up on an earlier patch by Colin Ian King,
> which addressed a spelling error in a user-visible log message [1].
> This patch includes that change.
> 
> [1] https://lore.kernel.org/netdev/20231209225135.4055334-1-colin.i.king@gmail.com/
> 
> This patch is intended to cover all files under
> drivers/net/ethernet/mellanox/mlx4
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cmd.c        | 7 ++++---
>  drivers/net/ethernet/mellanox/mlx4/cq.c         | 4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_clock.c   | 4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c  | 5 +++--
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c      | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c      | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/eq.c         | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/fw_qos.h     | 8 ++++----
>  drivers/net/ethernet/mellanox/mlx4/main.c       | 4 ++--
>  drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/port.c       | 2 +-
>  11 files changed, 22 insertions(+), 20 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

