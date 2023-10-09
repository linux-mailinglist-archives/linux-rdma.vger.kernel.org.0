Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B67BD310
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjJIGKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 02:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 02:10:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684C9E
        for <linux-rdma@vger.kernel.org>; Sun,  8 Oct 2023 23:10:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6B9C433C9;
        Mon,  9 Oct 2023 06:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831843;
        bh=65v6++6oPlHP2u710xTu9/OHaiW4em/A840mljzzcU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qscuviVPbOZgUQtE9x5FbBZDVgshIk6Lgjvq9vXACGt9FDiLGwDVj00oRCO4A2j8k
         DbqFPBhmHGEk4DcOGOe3Ez/LNZ7z9IcuDR12F7uTpfkASBZj7s4/OOLCaLYoLfoF2Y
         PJmnMkbWtHILJFB4Eo51xjbbJ75svxXt7W7+GFU+PZBu3yDI3O7rgFb98S+LiVZ+fx
         CzY2fCfYCHQ7KF++WNdpiw6hMTYKuwEMqXR01t1l2QAGV4RZfYctsn81spDM6fN1lA
         xhCFC0jKdBS/+HYeLiYHJ1tSKjjzPPssQ0ri5WkFgTNvgj+oJvjlJ5/UpxkTdEYRJR
         PClofrJw8dFuA==
Date:   Mon, 9 Oct 2023 09:10:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>
Subject: Re: [PATCH for-next 2/3] RDMA/bnxt_re: Report async events and errors
Message-ID: <20231009061038.GB5042@unreal>
References: <1696483889-17427-1-git-send-email-selvin.xavier@broadcom.com>
 <1696483889-17427-3-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696483889-17427-3-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 04, 2023 at 10:31:28PM -0700, Selvin Xavier wrote:
> From: Chandramohan Akula <chandramohan.akula@broadcom.com>
> 
> Report QP, SRQ and CQ async events and errors.
> 
> Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 165 +++++++++++++++++++++++++++++++++--
>  1 file changed, 156 insertions(+), 9 deletions(-)

<...>

> +	if (err_event->res_err_state_reason || err_event->req_err_state_reason) {
> +		dev_err_once(rdev_to_dev(qp->rdev),
> +			     "%s %s qp_id: %d cons (%d %d) req (%d %d) res (%d %d)\n",
> +			     __func__, rdma_is_kernel_res(&qp->ib_qp.res) ? "kernel" : "user",
> +			     qp->qplib_qp.id,
> +			     err_event->sq_cons_idx,
> +			     err_event->rq_cons_idx,
> +			     err_event->req_slow_path_state,
> +			     err_event->req_err_state_reason,
> +			     err_event->res_slow_path_state,
> +			     err_event->res_err_state_reason);

<...>

> +		dev_err_once(rdev_to_dev(cq->rdev),
> +			     "%s err reason %d\n", __func__, cqerr->cq_err_reason);
> +		cq->ib_cq.event_handler(&ibevent, cq->ib_cq.cq_context);

ibdev_*() prints please.

Thanks
