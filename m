Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F666B08D
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjAOLUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 06:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAOLUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 06:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C98FB451
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 03:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1D63B80B06
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 11:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B94C433EF;
        Sun, 15 Jan 2023 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673781607;
        bh=GJ/dBRlqlo9hjnotITs50RPXYyAVdl2R9r6AaY6/AQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyZNc8RaBZmKcI2ljAeGlz7UAbFaaTcuF+GpjdoaUJniGOQJw7ZE828yaXEq1prqH
         w2xI3t52Qu+raE8U76jLnokoyhTSBUKip4c9Nu9jVlH3ryYNdXZK26As9JpDez62qO
         8lDNYmEjcYesfQGrLwx8+WF+d0nmBoRwaFHgX804G5Gssm22UWlcUY0CQ445FZI1hA
         /YiBSMe4iMDrlE8d/rEzyZjuCtklg5Hk48zsiMqr6g2VBKWmyYDBGAOBx8QlGYiBnD
         FpadkTzhBByvjnYAGXZeNUAbba9V0gNmkJCZ0R0H41kyJO/mBiMuSU7RORpex5aPbq
         VslGYpAEh8NNA==
Date:   Sun, 15 Jan 2023 13:20:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv2 for-next 1/4] RDMA/irdma: Split MEM handler into
 irdma_reg_user_mr_type_mem
Message-ID: <Y8PhY1RAcTmnPdPJ@unreal>
References: <20230112000617.1659337-1-yanjun.zhu@intel.com>
 <20230112000617.1659337-2-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112000617.1659337-2-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 11, 2023 at 07:06:14PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The source codes related with IRDMA_MEMREG_TYPE_MEM are split
> into a new function irdma_reg_user_mr_type_mem.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 81 +++++++++++++++++------------
>  1 file changed, 49 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index f4674ecf9c8c..b67c14aac0f2 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2745,6 +2745,53 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
>  	return ret;
>  }
>  
> +static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
> +{
> +	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
> +	int err;
> +	bool use_pbles;
> +	u32 stag;
> +	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
> +
> +	use_pbles = (iwmr->page_cnt != 1);
> +
> +	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
> +	if (err)
> +		return err;
> +
> +	if (use_pbles) {
> +		err = irdma_check_mr_contiguous(&iwpbl->pble_alloc,
> +						iwmr->page_size);
> +		if (err) {
> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
> +			iwpbl->pbl_allocated = false;
> +		}
> +	}
> +
> +	stag = irdma_create_stag(iwdev);
> +	if (!stag) {
> +		err = -ENOMEM;
> +		goto free_pble;
> +	}
> +
> +	iwmr->stag = stag;
> +	iwmr->ibmr.rkey = stag;
> +	iwmr->ibmr.lkey = stag;
> +	err = irdma_hwreg_mr(iwdev, iwmr, access);
> +	if (err) {
> +		irdma_free_stag(iwdev, stag);
> +		goto free_pble;

Please add new goto label and put irdma_free_stag() there.

Thanks
