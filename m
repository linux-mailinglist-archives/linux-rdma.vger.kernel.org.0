Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5ED72B8BE
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjFLHjN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjFLHjM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4323C10C4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AAB761501
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DBBC433D2;
        Mon, 12 Jun 2023 07:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686553253;
        bh=4SqPBiv41NU6Y3srObFTWiNu+J8KHW3bTix4MHAAM2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmxD7N5nrg/j1z73K2Iquv5bss4rs6UUpjlnjzQxEdUAYsk+hu0E3o2YxP/2QmwTF
         4AedlX0Qsfw4E7r30bB9jng01eZLFW+gdb2vCpW3jS0tFAKeQ66s0sh13seVG9Txtj
         fTED3JzoTF8FKBug0gAJYfTFpU7NsajtsPLMDoRvY0hDmBTDRIJrDFpc7RQXSjCOjz
         eJ9mnQ03p0z11TChSgHwXAe+qzWM2+wMl4ngskriv7MftEh/4uaZ5F4XACiAwJOFtI
         ftirjaXWZo0jEltxVLDCedlq2dWB0GiRJLFnR9uhIljE22DS0kem5VyWPCBgDokZ1a
         p8k18TUUCF3Ow==
Date:   Mon, 12 Jun 2023 10:00:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, kashyap.desai@broadcom.com
Subject: Re: [PATCH v2 for-next 05/17] RDMA/bnxt_re: Enhance the existing
 functions that wait for FW responses
Message-ID: <20230612070048.GN12152@unreal>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
 <1686308514-11996-6-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686308514-11996-6-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 04:01:42AM -0700, Selvin Xavier wrote:
> From: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> Use jiffies based timewait instead of counting iteration for
> commands that block for FW response.
> 
> Also add a poll routine for control path commands. This is for
> polling completion if the waiting commands timeout. This avoids cases
> where the driver misses completion interrupts.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 65 +++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 66121fb..3b242cc 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -53,37 +53,74 @@
>  
>  static void bnxt_qplib_service_creq(struct tasklet_struct *t);
>  
> -/* Hardware communication channel */
> +/**
> + * __wait_for_resp   -	Don't hold the cpu context and wait for response
> + * @rcfw      -   rcfw channel instance of rdev
> + * @cookie    -   cookie to track the command
> + *
> + * Wait for command completion in sleepable context.
> + *
> + * Returns:
> + * 0 if command is completed by firmware.
> + * Non zero error code for rest of the case.

I don't see "return ret;" in this function.

> + */
>  static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
>  {
>  	struct bnxt_qplib_cmdq_ctx *cmdq;
>  	u16 cbit;
> -	int rc;
> +	int ret;
>  
>  	cmdq = &rcfw->cmdq;
>  	cbit = cookie % rcfw->cmdq_depth;
> -	rc = wait_event_timeout(cmdq->waitq,
> -				!test_bit(cbit, cmdq->cmdq_bitmap),
> -				msecs_to_jiffies(RCFW_CMD_WAIT_TIME_MS));
> -	return rc ? 0 : -ETIMEDOUT;
> +
> +	do {
> +		/* Non zero means command completed */
> +		ret = wait_event_timeout(cmdq->waitq,
> +					 !test_bit(cbit, cmdq->cmdq_bitmap),
> +					 msecs_to_jiffies(10000));

Don't you need to check ret here?

> +
> +		if (!test_bit(cbit, cmdq->cmdq_bitmap))
> +			return 0;
> +
> +		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> +
> +		if (!test_bit(cbit, cmdq->cmdq_bitmap))
> +			return 0;
> +
> +	} while (true);
>  };
>  
> +/**
> + * __block_for_resp   -	hold the cpu context and wait for response
> + * @rcfw      -   rcfw channel instance of rdev
> + * @cookie    -   cookie to track the command
> + *
> + * This function will hold the cpu (non-sleepable context) and
> + * wait for command completion. Maximum holding interval is 8 second.
> + *
> + * Returns:
> + * -ETIMEOUT if command is not completed in specific time interval.
> + * 0 if command is completed by firmware.
> + */
>  static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
>  {
> -	u32 count = RCFW_BLOCKED_CMD_WAIT_COUNT;
> -	struct bnxt_qplib_cmdq_ctx *cmdq;
> +	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
> +	unsigned long issue_time = 0;
>  	u16 cbit;
>  
> -	cmdq = &rcfw->cmdq;
>  	cbit = cookie % rcfw->cmdq_depth;
> -	if (!test_bit(cbit, cmdq->cmdq_bitmap))
> -		goto done;
> +	issue_time = jiffies;
> +
>  	do {
>  		udelay(1);
> +
>  		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> -	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
> -done:
> -	return count ? 0 : -ETIMEDOUT;
> +		if (!test_bit(cbit, cmdq->cmdq_bitmap))
> +			return 0;
> +
> +	} while (time_before(jiffies, issue_time + (8 * HZ)));
> +
> +	return -ETIMEDOUT;
>  };
>  
>  static int __send_message(struct bnxt_qplib_rcfw *rcfw,
> -- 
> 2.5.5
> 


