Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93877A5CA
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjHMJWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 05:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E997B4
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 02:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B716361F7D
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 09:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB8C433C8;
        Sun, 13 Aug 2023 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691918560;
        bh=2F01BKXw69vt+u91YvoJmYtc3z947q72/5Gk8GGDYI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nq2Phwd7POxjCSt1utYEnxRuSjyTHvIt0gtU7JJ3YkoKMbYQk3Xa0jtOGpLM7nAG9
         CUVoCFYYaBRh86l9b1pe9qoN3fRkrNpw6eNXLur80rZKgBPU6YBr7jn/EX9m2mE+oU
         BQpGAbuUqkEN/p76eSAhooADUrqHcTfYHy5Pz1kJVdO2GhnQA9xFZg+br4YBnYqtoj
         JHZYcG1pDIPhPd1fLAw3Gs6AGV2Hu2p0DENRZqLYDiHjshCcr/yc0RDYEpmAk73g2T
         vmmkddVTfUc2sVKIuBlwXooSG3bT6U0/zkWaxurhub4YNXcr56hVvhGqupzY7tGQQM
         Sr7opObNeHJmg==
Date:   Sun, 13 Aug 2023 12:22:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH -next] RDMA/irdma: Silence the warnings in
 irdma_uk_rdma_write()
Message-ID: <20230813092235.GI7707@unreal>
References: <20230811062215.2301099-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811062215.2301099-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 11, 2023 at 02:22:15PM +0800, Ruan Jinjie wrote:
> Remove sparse warnings introduced by commit 272bba19d631 ("RDMA: Remove
> unnecessary ternary operators"):
> 
> drivers/infiniband/hw/irdma/uk.c:285:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:386:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:471:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:723:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:797:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:875:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     got restricted __le32 [usertype] *push_db
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308110251.BV6BcwUR-lkp@intel.com/
> ---
>  drivers/infiniband/hw/irdma/uk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
> index a0739503140d..363c67c18924 100644
> --- a/drivers/infiniband/hw/irdma/uk.c
> +++ b/drivers/infiniband/hw/irdma/uk.c
> @@ -282,7 +282,7 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
>  	bool read_fence = false;
>  	u16 quanta;
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = !!qp->push_db;

Shiraz, push_db is declared as pointer, but I don't see where it is
allocated. Current code works because push_db is always 1 entry.

  316 struct irdma_qp_uk {
  ...
  324         __le32 *push_db;

and

   156         set_32bit_val(qp->push_db, 0,
   157                       FIELD_PREP(IRDMA_WQEALLOC_WQE_DESC_INDEX, wqe_idx >> 3) | qp->qp_id);

Such variable use is not great. can you please fix it?
Can Ruan use "qp->push_mode" check instead of "qp->push_db"?

Thanks
