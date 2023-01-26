Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFD67C950
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 12:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjAZK76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 05:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjAZK7t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 05:59:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADAABB8D
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 02:59:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B226179F
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 10:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A7AC4339B;
        Thu, 26 Jan 2023 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674730787;
        bh=kCXB5RvF2sOqJzh07hVx5auZY97rpXFU1utjqn1EL9k=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=muA5M9MpfjvcIk30fpNVofS86f+fSHPVo/WwG18uT5Eauj9JV7IMAKxcxWURD7MTp
         cIRam7NMuMG5ful+X9idBQryzsEmyqIO5YZlbLmC8LB6pcv9RCF/yskqzJJz8PmVUi
         LYNTNXhCoUkNY8V29883WWzbkGWm5xX6zR1cCe+0dF/Wzl8BUtAcukHYCbXOasrZ/6
         lWNUAKKcq47OfJndEmMj6Ejp8IrumSFSncaoNTZ3q1OlZ1enrL6MG85EE8L7+ylqr/
         hmHqy4EvQA+e+gdHTLsxbtSha0c8tw2u8fIFoPOiEyHrfPiZPUbUYah6i1ceQ73jVW
         4TcCtDQNKC7Ow==
From:   Leon Romanovsky <leon@kernel.org>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
In-Reply-To: <20230116193502.66540-1-yanjun.zhu@intel.com>
References: <20230116193502.66540-1-yanjun.zhu@intel.com>
Subject: Re: [PATCHv3 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr function
Message-Id: <167473078373.1419317.7357804127786397921.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 12:59:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 16 Jan 2023 14:34:58 -0500, Zhu Yanjun wrote:
> V2->V3: 1) Use netdev reverse Christmas tree rule;
> 	2) Return 0 instead of err;
> 	3) Remove unnecessary brackets;
> 	4) Add an error label in error handler;
> 	5) Initialize the structured variables;
> 
> V1->V2: Thanks Saleem, Shiraz.
>         1) Remove the unnecessary variable initializations;
>         2) Get iwdev by to_iwdev;
> 	3) Use the label free_pble to handle errors;
> 	4) Validate the page size before rdma_umem_for_each_dma_block
> 
> [...]

Applied, thanks!

[1/4] RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
      https://git.kernel.org/rdma/rdma/c/01798df19878e8
[2/4] RDMA/irdma: Split mr alloc and free into new functions
      https://git.kernel.org/rdma/rdma/c/693a5386eff0ba
[3/4] RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
      https://git.kernel.org/rdma/rdma/c/e965ef0e7b2ce2
[4/4] RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
      https://git.kernel.org/rdma/rdma/c/2f25e3bab00e97

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
