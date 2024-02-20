Return-Path: <linux-rdma+bounces-1072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1E85B473
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 09:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F22B215CB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1455BAFC;
	Tue, 20 Feb 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5q4Vg87"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632F5C5FD;
	Tue, 20 Feb 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416390; cv=none; b=gIETTIMXgU3YK146QyMfYyZvP4bsqasx2xKmSuAJZhHgA6PQ8ty3oqf1QZU3YPEojeAVTJj7zsp6Yb+1ThJF3GjhNcyCvajPbpVsO7+E8pdc1ToEc7x1PoWgPPMj5swIkYXKiWp30+6mRSD5nEfJPVrJGqO+a0LWwopQ1X2AEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416390; c=relaxed/simple;
	bh=oWpAKlAuGH6pCkTNf8skez1OA5APeMMN1elQviqEXlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz/AC8otDJ4IAoGPkcOaoBuPNHRbrEav/wjG+nGmTI9DSGxGMhej67CklmHAbyzTirRIJtBIijHC76f6o8GFGYRAGcvrbZFTQtSRUneoA5b7f1TXcZe9p4Gfl0licRJ7Dr+NZLyy7caaXHIKqGJ+nLEW+AyHA4kSuDYNLtU6zBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5q4Vg87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005EAC433F1;
	Tue, 20 Feb 2024 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708416389;
	bh=oWpAKlAuGH6pCkTNf8skez1OA5APeMMN1elQviqEXlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5q4Vg87Tc8+FYUf2vrQQ7O2SQcXeWpPaW8snYXaMmwNff63GeIJFN0XXXPr2tQqG
	 uwf7/ZY9LrTJsRfwbFQ0Wa3o/2BDZjOHqQLydbr6njgyXGwapQY+1frep8EKPsvDYD
	 qSgGIcd8hz4OGFMolWO3wYKuNcUnhWcK+QXGb9AweVAPWDiQlK0GaE3b6++M8Vp4ei
	 tndl7soZ354BH9GG05ni2K82cE/wqkNkLgC5WMOZbDkNFLvTnGP4fCfZ3sd4S/KYHD
	 XMAhnAtS163L8YeiQXw1H0C+qNKbk+D3/aWR3xKHHl5y6TQYAsngpXinyNYbsjI3Kj
	 Rfqfqw73sVzgQ==
Date: Tue, 20 Feb 2024 08:06:24 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] net/mlx5: fix possible stack overflows
Message-ID: <20240220080624.GQ40273@kernel.org>
References: <20240219100506.648089-1-arnd@kernel.org>
 <20240219100506.648089-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219100506.648089-2-arnd@kernel.org>

On Mon, Feb 19, 2024 at 11:04:56AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A couple of debug functions use a 512 byte temporary buffer and call another
> function that has another buffer of the same size, which in turn exceeds the
> usual warning limit for excessive stack usage:
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
> dr_dump_start(struct seq_file *file, loff_t *pos)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
> dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
> dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
> 
> Rework these so that each of the various code paths only ever has one of
> these buffers in it, and exactly the functions that declare one have
> the 'noinline_for_stack' annotation that prevents them from all being
> inlined into the same caller.
> 
> Fixes: 917d1e799ddf ("net/mlx5: DR, Change SWS usage to debug fs seq_file interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> [v2] no changes, just based on patch 1/2 but can still be applied independently
> ---
>  .../mellanox/mlx5/core/steering/dr_dbg.c      | 82 +++++++++----------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
> index be7a8481d7d2..eae04f66b8f4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
> @@ -205,12 +205,11 @@ dr_dump_hex_print(char hex[DR_HEX_SIZE], char *src, u32 size)
>  }
>  
>  static int
> -dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
> +dr_dump_rule_action_mem(struct seq_file *file, char *buff, const u64 rule_id,
>  			struct mlx5dr_rule_action_member *action_mem)
>  {
>  	struct mlx5dr_action *action = action_mem->action;
>  	const u64 action_id = DR_DBG_PTR_TO_ID(action);
> -	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
>  	u64 hit_tbl_ptr, miss_tbl_ptr;
>  	u32 hit_tbl_id, miss_tbl_id;
>  	int ret;

Hi Arnd,

With patch 1/2 in place this code goes on as:

	switch (action->action_type) {
	case DR_ACTION_TYP_DROP:
		memset(buff, 0, sizeof(buff));

buff is now a char * rather than an array of char.
siceof(buff) doesn't seem right here anymore.

Flagged by Coccinelle.

