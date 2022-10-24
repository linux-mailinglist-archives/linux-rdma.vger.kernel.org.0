Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82C60A5FA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiJXMah (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiJXM3F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 08:29:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE574E39;
        Mon, 24 Oct 2022 05:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7157B811FE;
        Mon, 24 Oct 2022 12:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE42C433D6;
        Mon, 24 Oct 2022 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612802;
        bh=GAvKdiCXmJ3TdTl3w2z3oNTgZyAdY9zlwgO7MDYfPBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TBBVIAZXuUScDHsS+KRrh0jcvp9hHeCkLkbVYjYmOLyIfM0/bqyGPMF9rjWKMyD13
         gUm53ljsPboY0W5728rR7CqUuBdnDpahlwKe4RXGzGQBWp/y/mEL92gmfVAxCvdKNd
         lPmiV2CLMW8vTzWh2gMp+5aOLRimiuQbi+cdawNw3OEz60UQZwQi86YQJrGgefBHi5
         RI850tdyP0ZeqRH0Z+vmteCLhPT/HTwOoYS74C8Eqg1J0ykYSCzEO6i9nHN0J+nx7w
         +zEmiAOxsxUyRaj03uof/iaDCChxaZ30zkip1/QTJ95ujHNI3fPs05YF9Lodf6jxRU
         3ua5CvfFIRkjA==
Date:   Mon, 24 Oct 2022 14:59:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Message-ID: <Y1Z+PnTk0Tr7sxcb@unreal>
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
 <20221024052049.20577-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024052049.20577-1-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 01:20:49PM +0800, Li Zhijian wrote:
> rxe_recheck_mr() will increase mr's ref_cnt, so we should call rxe_put(mr)
> to drop mr's ref_cnt in RESPST_ERR_RNR to avoid below warning:
> [  633.447883] WARNING: CPU: 0 PID: 4156 at drivers/infiniband/sw/rxe/rxe_pool.c:259 __rxe_cleanup+0x1df/0x240 [rdma_rxe]
> ...
> [  633.509482] Call Trace:
> [  633.510246]  <TASK>
> [  633.510962]  rxe_dereg_mr+0x4c/0x60 [rdma_rxe]
> [  633.512123]  ib_dereg_mr_user+0xa8/0x200 [ib_core]
> [  633.513444]  ib_mr_pool_destroy+0x77/0xb0 [ib_core]
> [  633.514763]  nvme_rdma_destroy_queue_ib+0x89/0x240 [nvme_rdma]
> [  633.516230]  nvme_rdma_free_queue+0x40/0x50 [nvme_rdma]
> [  633.517577]  nvme_rdma_teardown_io_queues.part.0+0xc3/0x120 [nvme_rdma]
> [  633.519204]  nvme_rdma_error_recovery_work+0x4d/0xf0 [nvme_rdma]
> [  633.520695]  process_one_work+0x582/0xa40
> [  633.522987]  ? pwq_dec_nr_in_flight+0x100/0x100
> [  633.524227]  ? rwlock_bug.part.0+0x60/0x60
> [  633.525372]  worker_thread+0x2a9/0x700
> [  633.526437]  ? process_one_work+0xa40/0xa40
> [  633.527589]  kthread+0x168/0x1a0
> [  633.528518]  ? kthread_complete_and_exit+0x20/0x20
> [  633.529792]  ret_from_fork+0x22/0x30
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> V2: remove mr testing

This should be after ---

> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b02639cf8cba..41250154a478 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -806,8 +806,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  
>  	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
>  				 res->cur_psn, AETH_ACK_UNLIMITED);
> -	if (!skb)
> +	if (!skb) {
> +		rxe_put(mr);
>  		return RESPST_ERR_RNR;
> +	}
>  
>  	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>  		    payload, RXE_FROM_MR_OBJ);
> -- 
> 2.31.1
> 
