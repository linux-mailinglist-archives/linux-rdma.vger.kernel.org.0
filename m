Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6568BEF8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 14:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBFNzs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 08:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBFNzd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 08:55:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE462B286
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 05:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE8160EF1
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 13:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC7DC4339B;
        Mon,  6 Feb 2023 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675691558;
        bh=AcjDBBnKuDsMeknqWqV++sYqCYDOdI0Dh5UxqDr1GVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scl0x4lNH6Nl1SVDdHrUTSHwXVFcT7gnvnMEVc3+oSLef/Zo6UjtiBfjr24AkST/T
         BBH2JtMT7GCeSY9roUzRFg0BfB026p6iTBnehsu4AWs+z/CO4UkSw3d84x6H8b25yt
         FhskAvOLk08i6vjdgl8IPqTElzSLoolHHYRKuTI7PbzhlkDn+84Tpl0t+OMGc6v6qa
         vhypqBifnrFYzLjD8o4adaQNQd5gA51JDYrczVGe7Sl52Jvc+SqurDHJA9G6c7sGMo
         bYTHzqGtlarXb7lMVJJlpDTGNQqH9GtdQ1Vsy+45pD9Y56/d8TzUpa2A32axsjYQ3b
         vYElO4fSd7njg==
Date:   Mon, 6 Feb 2023 15:52:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Sindhu Devale <sindhu.devale@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com
Subject: Re: [PATCH for-rc] RDMA/irdma: Cap MSIX used to online CPUs + 1
Message-ID: <Y+EGI0Z9wnXlkWGv@unreal>
References: <20230202181211.1123-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202181211.1123-1-sindhu.devale@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 12:12:11PM -0600, Sindhu Devale wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> The irdma driver can use a maximum number of msix
> vectors equal to num_online_cpus() + 1 and the Kernel

kernel

> warning stack below is shown if that number is exceeded.
> The kernel throws a warning as the driver tries to update
> the affinity hint with a CPU mask greater than the max CPU IDs.
> Fix this by capping the MSIX vectors to num_online_cpus() + 1.

You shouldn't squeeze your commit message to 60 chars, please don't break
lines like this.

> 
> kernel: WARNING: CPU: 7 PID: 23655 at include/linux/cpumask.h:106 irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
> kernel: RIP: 0010:irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
> kernel: Call Trace:
> kernel: irdma_rt_init_hw+0xa62/0x1290 [irdma]

Please provide full kernel splat and not truncated version.

> 
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index ab246447520b..2e1e2bad0401 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -483,6 +483,8 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
>  	iw_qvlist->num_vectors = rf->msix_count;
>  	if (rf->msix_count <= num_online_cpus())
>  		rf->msix_shared = true;
> +	else if (rf->msix_count > num_online_cpus() + 1)
> +		rf->msix_count = num_online_cpus() + 1;
>  
>  	pmsix = rf->msix_entries;
>  	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
> -- 
> 2.27.0
> 
