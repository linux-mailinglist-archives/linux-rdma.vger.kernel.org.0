Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1E3634DD
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhDRLaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 07:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDRLai (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 07:30:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7C1E610A1;
        Sun, 18 Apr 2021 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618745410;
        bh=A8z1s34gsJtLKis3+DpKCjV//81Nr2WWpAV+3De/vHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKRpqN2ucMbn1tVyPDS5mb0Hujk84xty4QUgtFiPMOQmI05ejMS39H+6WKTy113pz
         bBy3Kv2E0PYusq7ra94HTaAukaYBWXkYmAz+9RiSnjbLes5LwKUCCJyDMdKD4LRNw/
         KHtjWLhw/RSPeYEx++B/mKI4O27FtnhljYQBeddHogVICgVzgJyWb9xsfYxnRhPuAh
         yqGUF5/VAy2K3Bo/ep528CIloRqvggBzGqdtWyl+kr73Vj+pufOgbIE/387idHqSBW
         2O9IxgqTi3a0LBW9jHyQMJRA6fhaendjwhRYwu1H4hfIw8VEj6es8pkF29BWBAftjy
         dcIoTWaWgsejw==
Date:   Sun, 18 Apr 2021 14:30:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Cc:     linux-rdma@vger.kernel.org, Jack Morgenstein <jackm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH] net/mlx4: Treat VFs fair when handling
 comm_channel_events
Message-ID: <YHwYP/+MRZ/7i9Yd@unreal>
References: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 15, 2021 at 01:43:42PM +0200, Hans Westgaard Ry wrote:
> Handling comm_channel_event in mlx4_master_comm_channel uses a double
> loop to determine which slaves have requested work. The search is
> always started at lowest slave. This leads to unfairness; lower VFs
> tends to be prioritized over higher VFs.
> 
> The patch uses find_next_bit to determine which slaves to handle.
> Fairness is implemented by always starting at the next to the last
> start.
> 
> An MPI program has been used to measure improvements. It runs 500
> ibv_reg_mr, synchronizes with all other instances and then runs 500
> ibv_dereg_mr.
> 
> The results running 500 processes, time reported is for running 500
> calls:
> 
> ibv_reg_mr:
>              Mod.   Org.
> mlx4_1    403.356ms 424.674ms
> mlx4_2    403.355ms 424.674ms
> mlx4_3    403.354ms 424.674ms
> mlx4_4    403.355ms 424.674ms
> mlx4_5    403.357ms 424.677ms
> mlx4_6    403.354ms 424.676ms
> mlx4_7    403.357ms 424.675ms
> mlx4_8    403.355ms 424.675ms
> 
> ibv_dereg_mr:
>              Mod.   Org.
> mlx4_1    116.408ms 142.818ms
> mlx4_2    116.434ms 142.793ms
> mlx4_3    116.488ms 143.247ms
> mlx4_4    116.679ms 143.230ms
> mlx4_5    112.017ms 107.204ms
> mlx4_6    112.032ms 107.516ms
> mlx4_7    112.083ms 184.195ms
> mlx4_8    115.089ms 190.618ms
> 
> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cmd.c  | 75 +++++++++++++++++--------------
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h |  1 +
>  2 files changed, 43 insertions(+), 33 deletions(-)

Please fix kbuild error and resubmit to the netdev ML with Tariq CCed.

Thanks
