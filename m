Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDA623DB9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKJIpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 03:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJIpJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 03:45:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B3275E6
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 00:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8FA1B820F6
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 08:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AF6C433C1;
        Thu, 10 Nov 2022 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668069906;
        bh=FyxQEI5yp9QF+5kzP2LKfhKlnzhUZ9Z3+3/ZP+WSIjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZ1J3mecJ7+J+TslIyrsB24EV7Rp8XBtlwNYlCpAgoLhzXRWrXxMcZIBayge+6vGT
         tbMWkOfHZ+sNY/eYrmmxZlZnhRERgGAiJNoOx7nRDdvia+LQAsvsbMzm3h8WkAhD2i
         KrR9kATkdQesTcwAIsQfdMGOwmx04+NDiQZ3IoWo5xFqcxLxUmL4XfkP1JUBsfaO4v
         K6JnoqarLBs4gsAEOeAvFQeAojeJnphiKmOK+9mS2QxGMk7KAz8Q2VwRliIHiU+jXZ
         oPqspojtR5gWn1PEprTIkv9hLkQX0SnMGIzLJ8CX2o/AW5Tz0cLsdnZGy0ZjOqmxGE
         37/Y48ZValuTQ==
Date:   Thu, 10 Nov 2022 10:45:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH v1 for-next 2/3] RDMA/irdma: Fix RQ completion opcode
Message-ID: <Y2y6DXem7XmKi1JM@unreal>
References: <20221108162958.1227-1-shiraz.saleem@intel.com>
 <20221108162958.1227-3-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108162958.1227-3-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 08, 2022 at 10:29:57AM -0600, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> The opcode written by HW, in the RQ CQE, is the
> RoCEv2/iWARP protocol opcode from the received
> packet and not the SW opcode as currently assumed.
> Fix this by returning the raw operation type and
> queue type in the CQE to irdma_process_cqe and add
> 2 helpers set_ib_wc_op_sq set_ib_wc_op_rq to map
> IRDMA HW op types to IB op types.
> 
> Note that for iWARP, only Write with Immediate is
> supported so the opcode can only be IB_WC_RECV_RDMA_WITH_IMM
> when there is immediate data present.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c    | 19 +++-----
>  drivers/infiniband/hw/irdma/user.h  |  1 +
>  drivers/infiniband/hw/irdma/utils.c |  2 +
>  drivers/infiniband/hw/irdma/verbs.c | 91 +++++++++++++++++++++++--------------
>  4 files changed, 68 insertions(+), 45 deletions(-)

<...>

> +static inline void set_ib_wc_op_sq(struct irdma_cq_poll_info *cq_poll_info,
> +				   struct ib_wc *entry)
> +{
> +	switch (cq_poll_info->op_type) {
> +	case IRDMA_OP_TYPE_RDMA_WRITE:
> +	case IRDMA_OP_TYPE_RDMA_WRITE_SOL:
> +	entry->opcode = IB_WC_RDMA_WRITE;

1. Please run clang formatter on your series, I see wrong indentation here.
2. We are honoring 80-symbol limit, when it is possible. First patch is
full of such warnings.
3. No inline functions in .c code please.

Thanks
