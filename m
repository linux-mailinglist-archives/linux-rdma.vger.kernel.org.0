Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A476277BC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 09:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiKNIc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 03:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiKNIc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 03:32:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17031B9D8
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 00:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B7ED60F14
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F93C433C1;
        Mon, 14 Nov 2022 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668414746;
        bh=iRIBLynOyeXShEeXRwCNsdaj99aKPrr3Fy9encIf1Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iycpTOePdyh03Xbk/c+l3ke0AQk/OolPO86HAjRm9iSK4Patpnvm4GEoFsf/3+B0g
         /voDZMUKHh1FFqZMaoBg10OBwdxbnde+xbn6gpoL0WFTNqyp16alFpybJOviUQeS5K
         unIyCeOgaQ9JPYgjr6+40b+ezBu0TiTNgQuGc+asEZXiLS/bY4oh03MkYFndJil2sS
         9/nQVwa976JRCm/cyOTnOCVoU0V74yqQK6P4OONiNF1jJhUib7QNMe1jUu3T3T9ald
         ZUF+ueLq/W9Na8Z+YXt4bwV8J5zfLLhkt1nwPQZCLWdIyrW/Z01PRGS/cs8mh25uIZ
         G+mdnqIciFuTg==
Date:   Mon, 14 Nov 2022 10:32:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/12] Misc changes for rtrs
Message-ID: <Y3H9FrmwdEe/q8wu@unreal>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 13, 2022 at 09:08:11AM +0800, Guoqing Jiang wrote:
> Hi,
> 
> Here are some changes for rtrs, please review them.
> 
> Thanks,
> Guoqing
> 
> Guoqing Jiang (12):
>   RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
>   RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
>   RDMA/rtrs-srv: Only close srv_path if it is just allocated
>   RDMA/rtrs-srv: refactor the handling of failure case in map_cont_bufs
>   RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
>   RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
>   RDMA/rtrs-srv: Remove outdated comments from create_con
>   RDMA/rtrs: Kill recon_cnt from several structs
>   RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
>   RDMA/rtrs-srv: Remove paths_num
>   RDMA/rtrs-srv: fix several issues in rtrs_srv_destroy_path_files
>   RDMA/rtrs-srv: Remove kobject_del from
>     rtrs_srv_destroy_once_sysfs_root_folders
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  12 +-
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   6 -
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  13 ++-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 110 ++++++-------------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   2 -
>  drivers/infiniband/ulp/rtrs/rtrs.c           |  22 +---
>  6 files changed, 47 insertions(+), 118 deletions(-)

Why is this series marked as RFC?

Thanks

> 
> -- 
> 2.31.1
> 
