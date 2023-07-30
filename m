Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626376854D
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jul 2023 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjG3Mm3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3Mm3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 08:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B34511B
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 05:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBCA660C0A
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 12:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1FBC433C7;
        Sun, 30 Jul 2023 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690720947;
        bh=VRKFxYVGDVuJ1IEogZXqGGDoPqdBGWpBunYLv3f2gNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlAlnXXvY1tIg9EMVJTQcNtOfiFGOOLr89gXGGn/uhjkJLt1/AXVNLJZh9bQwwY8p
         469HbiUvAc+acuWE7b5/y4+z14kXptKLwGX/beG7Ux7yqrp2jJbrXj7r7lASN8XfsQ
         w/liUqC6dUDFNMLmcU1T4QoG5K4B0e/q9UYxWCzBT7pAUJBaKfzfs7QMS7bOBQnx5h
         7c0PE3S/d1O8ETXoTzpH8DrGMwXcGNz53qB6qFVH0FlpzYv+yaDQ9pfmFCvAwiBbgE
         YfbTRU7ldNIlzAJJSUgVCH0gOCqQpguyDtSTRccdW9OdE3j9cuopsSdgODwJG0Dcbx
         HerdTugdPHbQQ==
Date:   Sun, 30 Jul 2023 15:42:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>
Subject: Re: [PATCH for-next 1/2] RDMA/irdma: Allow accurate reporting on QP
 max send/recv WR
Message-ID: <20230730124222.GD94048@unreal>
References: <20230725155525.1081-1-shiraz.saleem@intel.com>
 <20230725155525.1081-2-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725155525.1081-2-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 25, 2023 at 10:55:24AM -0500, Shiraz Saleem wrote:
> From: Sindhu Devale <sindhu.devale@intel.com>
> 
> Currently the attribute cap.max_send_wr and cap.max_recv_wr
> sent from user-space during create QP are the provider computed
> SQ/RQ depth as opposed to raw values passed from application.
> This inhibits computation of an accurate value for max_send_wr
> and max_recv_wr for this QP in the kernel which matches the value
> returned in user create QP. Also these capabilities needs to be
> reported from the driver in query QP.
> 
> Add support by extending the ABI to allow the raw cap.max_send_wr and
> cap.max_recv_wr to be passed from user-space, while keeping compatibility
> for the older scheme.
> 
> The internal HW depth and shift needed for the WQs needs to be computed
> now for both kernel and user-mode QPs. Add new helpers to assist with this:
> irdma_uk_calc_depth_shift_sq, irdma_uk_calc_depth_shift_rq and
> irdma_uk_calc_depth_shift_wq.
> 
> Consolidate all the user mode QP setup into a new function
> irdma_setup_umode_qp which keeps it with its counterpart
> irdma_setup_kmode_qp.
> 
> Signed-off-by: Youvaraj Sagar <youvaraj.sagar@intel.com>
> Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c    |  89 +++++++++++++++---
>  drivers/infiniband/hw/irdma/user.h  |  10 ++
>  drivers/infiniband/hw/irdma/verbs.c | 182 ++++++++++++++++++++++--------------
>  drivers/infiniband/hw/irdma/verbs.h |   3 +-
>  include/uapi/rdma/irdma-abi.h       |   6 ++
>  5 files changed, 203 insertions(+), 87 deletions(-)

Fixed and applied.

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 2986aee3a429..ac650a784245 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1427,7 +1427,7 @@ static void irdma_setup_connection_wqes(struct irdma_qp_uk *qp,
 void irdma_uk_calc_shift_wq(struct irdma_qp_uk_init_info *ukinfo, u8 *sq_shift,
                            u8 *rq_shift)
 {
-       bool imm_support = ukinfo->uk_attrs->hw_rev >= IRDMA_GEN_2 ? true : false;
+       bool imm_support = ukinfo->uk_attrs->hw_rev >= IRDMA_GEN_2;
 
        irdma_get_wqe_shift(ukinfo->uk_attrs,
                            imm_support ? ukinfo->max_sq_frag_cnt + 1 :
@@ -1452,7 +1452,7 @@ void irdma_uk_calc_shift_wq(struct irdma_qp_uk_init_info *ukinfo, u8 *sq_shift,
 int irdma_uk_calc_depth_shift_sq(struct irdma_qp_uk_init_info *ukinfo,
                                 u32 *sq_depth, u8 *sq_shift)
 {
-       bool imm_support = ukinfo->uk_attrs->hw_rev >= IRDMA_GEN_2 ? true : false;
+       bool imm_support = ukinfo->uk_attrs->hw_rev >= IRDMA_GEN_2;
        int status;
 
        irdma_get_wqe_shift(ukinfo->uk_attrs,
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index ebe8bdce2557..5d7b983f47a2 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -18,8 +18,8 @@ struct irdma_ucontext {
        struct list_head qp_reg_mem_list;
        spinlock_t qp_reg_mem_list_lock; /* protect QP memory list */
        int abi_ver;
-       bool legacy_mode:1;
-       bool use_raw_attrs:1;
+       u8 legacy_mode : 1;
+       u8 use_raw_attrs : 1;
 };
 
 struct irdma_pd {

