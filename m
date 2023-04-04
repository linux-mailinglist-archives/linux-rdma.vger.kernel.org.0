Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF46D5866
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 08:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjDDGFa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 02:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDGF3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 02:05:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C71FEF;
        Mon,  3 Apr 2023 23:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6650962E89;
        Tue,  4 Apr 2023 06:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFE0C433D2;
        Tue,  4 Apr 2023 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680588326;
        bh=js5GflryL8KokvpMUy9om9TOh3IfXf85X8v6+R6xhtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ar1Kv2AX4L3zpx9o0k/Ht9gIiUTt5vdNh/xFgAHiZf1kCoSE7R0gSInTKkNsoBlW3
         J/YaiIssmu+S/pcMIbAanFbXNAlhnz87NEhFzb63KiwPckY5j6Y7DlO9fOEm4WLBb0
         vvVemBmUl74E1m0x3LNlW5NHsEfR+FhLr3g7XUThotPVJ6dVq6m/D1qdj0F0mPNuZU
         f6PTzS7GzZIbyFm9tCCo4Rtr5uprzA8RLgVJyGK8xjYLID3BTo7R3/R7q4jFAMEVWD
         UGmRqvvVqt+9/wWfsfVrCC/5pCMQ6SIMpuaeis0cMFY+QKw9oAu+L04P9K4prfUYvo
         aRld0CXJgAhUA==
Date:   Tue, 4 Apr 2023 09:05:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     xiaolinkui <xiaolinkui@126.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] RDMA/hfi: add a judgment on the availability of cpumask
Message-ID: <20230404060522.GH4514@unreal>
References: <20230404030525.24020-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404030525.24020-1-xiaolinkui@126.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 04, 2023 at 11:05:25AM +0800, xiaolinkui wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> When CONFIG_CPUMASK_OFFSTACK is n, cpumask may fail to allocate, cpumask may
> be NULL, and performing a bitmap operation on cpumask may cause problems at
> this time.
> 
> Of course, this is a unlikely event.
> 
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
> index 77ee77d4000f..3caa861f4d1d 100644
> --- a/drivers/infiniband/hw/hfi1/affinity.c
> +++ b/drivers/infiniband/hw/hfi1/affinity.c
> @@ -1047,16 +1047,16 @@ int hfi1_get_proc_affinity(int node)
>  	 */
>  
>  	ret = zalloc_cpumask_var(&diff, GFP_KERNEL);
> -	if (!ret)
> +	if (!ret || unlikely(!diff))

Why do you think that check of "ret" is not enough?
"ret" will be false if diff == NULL.

Thanks
