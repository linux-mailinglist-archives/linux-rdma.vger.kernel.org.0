Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB231865C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 09:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhBKIef (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 03:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBKIeH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Feb 2021 03:34:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5019264DE1;
        Thu, 11 Feb 2021 08:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613032407;
        bh=/a1FV5uNCp2JOhLHdCvE0a291A2DxoupZOA4Hhi+uJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=La+BPoYDSlTJ65rS+vEzwztzuXm31vaEW5nQ6JBfGoWe1ECn7VYQln6LN7JNGJpjr
         2FI8byzfq6LFeUr5450VffpTWVGh87+b49mhSIW61XONVqJn1ZFTOJ5k6eecpzdqWL
         R9lEDTBUDFyzNmiUnkp6fJdNeUnLaR8rbefgWIZD7DfPmBJah0iGImimLtP7Es0aoC
         ysxRdpEzD8fF6JJvFbJVUaz40x1ERJk8rSVE0x83LVf3HCyJYVC/TqZjURuE5K74FE
         YF60KKEnfOPzMzO/F9nMlCIt5XDnjc8oOkPlRBMepKjAoegxWitNWC5ksKKMSFQOYO
         gCDDCpQceLyUQ==
Date:   Thu, 11 Feb 2021 10:33:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 1/4] RDMA/rtrs-srv: Fix BUG: KASAN:
 stack-out-of-bounds
Message-ID: <20210211083323.GA1275163@unreal>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
 <20210211065526.7510-2-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211065526.7510-2-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 07:55:23AM +0100, Jack Wang wrote:
> [  125.352752] ==================================================================
> [  125.353122] BUG: KASAN: stack-out-of-bounds in _mlx4_ib_post_send+0x1bd2/0x2770 [mlx4_ib]
> [  125.353337] Read of size 4 at addr ffff8880d5a7f980 by task kworker/0:1H/565
>
> [  125.353655] CPU: 0 PID: 565 Comm: kworker/0:1H Tainted: G           O      5.4.84-storage #5.4.84-1+feature+linux+5.4.y+dbg+20201216.1319+b6b887b~deb10
> [  125.353924] Hardware name: Supermicro H8QG6/H8QG6, BIOS 3.00       09/04/2012
> [  125.354144] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [  125.354317] Call Trace:
> [  125.354531]  dump_stack+0x96/0xe0
> [  125.354715]  print_address_description.constprop.4+0x1f/0x300
> [  125.354943]  ? irq_work_claim+0x2e/0x50
> [  125.355129]  __kasan_report.cold.8+0x78/0x92
> [  125.355334]  ? _mlx4_ib_post_send+0x1bd2/0x2770 [mlx4_ib]
> [  125.355545]  kasan_report+0x10/0x20
> [  125.355730]  _mlx4_ib_post_send+0x1bd2/0x2770 [mlx4_ib]
> [  125.355930]  ? check_chain_key+0x1d7/0x2e0
> [  125.356203]  ? _mlx4_ib_post_recv+0x630/0x630 [mlx4_ib]
> [  125.356399]  ? lockdep_hardirqs_on+0x1a8/0x290
> [  125.356595]  ? stack_depot_save+0x218/0x56e
> [  125.356781]  ? do_profile_hits.isra.6.cold.13+0x1d/0x1d
> [  125.356973]  ? check_chain_key+0x1d7/0x2e0
> [  125.357174]  ? save_stack+0x4d/0x80
> [  125.357374]  ? save_stack+0x19/0x80
> [  125.357547]  ? __kasan_slab_free+0x125/0x170
> [  125.357728]  ? kfree+0xe7/0x3b0
> [  125.357899]  rdma_write_sg+0x5b0/0x950 [rtrs_server]
>
> The problem is when we send imm_wr, the type should be ib_rdma_wr, so
> hw driver like mlx4 can do rdma_wr(wr), so fix it by use the ib_rdma_wr
> as type for imm_wr.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 64 +++++++++++++-------------
>  1 file changed, 33 insertions(+), 31 deletions(-)
>

You have many lines with double space before "=".

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
