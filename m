Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1172B8CD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjFLHkg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjFLHkb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F8710F7
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 481DB61FC1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24072C433D2;
        Mon, 12 Jun 2023 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686553461;
        bh=T/rLmMyDX+rt8OhhNeEKbP3c4gi3fGKasmSPixHe7ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZF0GVUGHqNUKDGA0Pob/1TOmELFiyTfZG/NbG5qqFSTcbGwOkbIxFqNbqGdIwol6W
         /9Z3P10bgPaJr+2YhiHoNY+mJYmZyYgqQweeWoC9q0p139yHNMSv8Yr8QAHxMsgmLe
         zoDO/YwlQPPzpp/UkxrGG6D0HhjvfD2AI4fhVYh7rUrCO9fhI6916qdmZCIPoj8rFS
         QrdhA+snQXx3lfc9yaHiH5ZLUjwAKoAO+pFXyU7j2O98Va4gJj9XMKtPF/gGIRpybA
         iVbABRUxKuBCzli6cdwKkQJXh+Amwvi6W3RglnjBLfkZaQgptpErC44BFzou9xmjy5
         R1avGnwSG7+cg==
Date:   Mon, 12 Jun 2023 10:04:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, kashyap.desai@broadcom.com
Subject: Re: [PATCH v2 for-next 09/17] RDMA/bnxt_re: add helper function
 __poll_for_resp
Message-ID: <20230612070417.GO12152@unreal>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
 <1686308514-11996-10-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686308514-11996-10-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 04:01:46AM -0700, Selvin Xavier wrote:
> From: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> This interface will be used if the driver has not enabled interrupt
> and/or interrupt is disabled for a short period of time.
> Completion is not possible from interrupt so this interface does
> self-polling.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 44 +++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  1 +
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 15f6793..3215f8a 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -260,6 +260,44 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
>  	return 0;
>  }
>  
> +/**
> + * __poll_for_resp   -	self poll completion for rcfw command
> + * @rcfw      -   rcfw channel instance of rdev
> + * @cookie    -   cookie to track the command
> + * @opcode    -   rcfw submitted for given opcode
> + *
> + * It works same as __wait_for_resp except this function will
> + * do self polling in sort interval since interrupt is disabled.
> + * This function can not be called from non-sleepable context.
> + *
> + * Returns:
> + * -ETIMEOUT if command is not completed in specific time interval.
> + * 0 if command is completed by firmware.
> + */
> +static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
> +			   u8 opcode)
> +{
> +	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
> +	unsigned long issue_time;
> +	u16 cbit;
> +
> +	cbit = cookie % rcfw->cmdq_depth;
> +	issue_time = jiffies;
> +
> +	do {
> +		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
> +			return bnxt_qplib_map_rc(opcode);
> +
> +		usleep_range(1000, 1001);
> +
> +		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> +		if (!test_bit(cbit, cmdq->cmdq_bitmap))
> +			return 0;
> +		if (jiffies_to_msecs(jiffies - issue_time) > 10000)
> +			return -ETIMEDOUT;
> +	} while (true);
> +};
> +
>  static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
>  				       struct bnxt_qplib_cmdqmsg *msg)
>  {
> @@ -328,8 +366,10 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
>  
>  	if (msg->block)
>  		rc = __block_for_resp(rcfw, cookie, opcode);
> -	else
> +	else if (atomic_read(&rcfw->rcfw_intr_enabled))

Why atomic_t? It doesn't eliminate the need of locking and if locking
exists, you don't need atomic_t.

>  		rc = __wait_for_resp(rcfw, cookie, opcode);
> +	else
> +		rc = __poll_for_resp(rcfw, cookie, opcode);
>  	if (rc) {
>  		/* timed out */
>  		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
> @@ -796,6 +836,7 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
>  	kfree(creq->irq_name);
>  	creq->irq_name = NULL;
>  	creq->requested = false;
> +	atomic_set(&rcfw->rcfw_intr_enabled, 0);
>  }
>  
>  void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
> @@ -857,6 +898,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
>  	creq->requested = true;
>  
>  	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, res->cctx, true);
> +	atomic_inc(&rcfw->rcfw_intr_enabled);
>  
>  	return 0;
>  }
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> index b7bbbae..089e616 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> @@ -221,6 +221,7 @@ struct bnxt_qplib_rcfw {
>  	u64 oos_prev;
>  	u32 init_oos_stats;
>  	u32 cmdq_depth;
> +	atomic_t rcfw_intr_enabled;
>  	struct semaphore rcfw_inflight;
>  };
>  
> -- 
> 2.5.5
> 


