Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015CF4B77EB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiBOSm7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:42:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbiBOSm7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:42:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A2427FFC
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:42:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B43061633
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 18:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00414C340EC;
        Tue, 15 Feb 2022 18:42:45 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:42:42 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 1/3] ib_srp: Add more documentation
Message-ID: <Ygv0IhNMJxFHSi8Q@unreal>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215182650.19839-2-bvanassche@acm.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 10:26:48AM -0800, Bart Van Assche wrote:
> Make it more clear what the different ib_srp data structures represent.
> 
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
> index abccddeea1e3..55a575e2cace 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.h
> +++ b/drivers/infiniband/ulp/srp/ib_srp.h
> @@ -92,6 +92,9 @@ enum srp_iu_type {
>  };
>  
>  /*
> + * RDMA adapter in the initiator system.
> + *
> + * @dev_list: List of RDMA ports associated with this RDMA adapter (srp_host).

Isn't this list of RDMA devices and not ports?

>   * @mr_page_mask: HCA memory registration page mask.
>   * @mr_page_size: HCA memory registration page size.
>   * @mr_max_size: Maximum size in bytes of a single FR registration request.
> @@ -109,6 +112,12 @@ struct srp_device {
>  	bool			use_fast_reg;
>  };
>  
> +/*
> + * One port of an RDMA adapter in the initiator system.
> + *
> + * @target_list: List of connected target ports (struct srp_target_port).
> + * @target_lock: Protects @target_list.
> + */
>  struct srp_host {
>  	struct srp_device      *srp_dev;
>  	u8			port;
> @@ -183,7 +192,7 @@ struct srp_rdma_ch {
>  };
>  
>  /**
> - * struct srp_target_port
> + * struct srp_target_port - RDMA port in the SRP target system
>   * @comp_vector: Completion vector used by the first RDMA channel created for
>   *   this target port.
>   */
