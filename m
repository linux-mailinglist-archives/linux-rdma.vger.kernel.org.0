Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF7B5A76A4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 08:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiHaGbl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiHaGbc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 02:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C389DB5A
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 23:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B77061777
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 06:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556FBC433D6;
        Wed, 31 Aug 2022 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661927488;
        bh=d3Li8jo56Bi1yhkafG54OhExVQ5zBENEvulN2L3fQ+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewlhwvcS5CNUdk93PWWe4gmrbJqIsdvSEe1CxgeOeOOLMhUy/RAVCvZnArE5Ey3A7
         tHkGv8Yq95Vopw1JROHGZlGgwevK/UAv5VWeIjeCTsdZ6zuYZVp8KW3qKmdNEUVJNK
         F7351vz/F5/tsU+7sVJ1ChblCg+/kMRfpmH/qYAquoraCtT2MMaN4kXnn0JFLH59dS
         X/IkMwQvoIK3Ub/bOb4iJvt3z5PkCXvPPwo85uDfkFDuhmO0L4Adee1dSqwSQqR/d1
         oa6QLla9BKF5TJzkU/B+smaWFs+ZeApTn2xnWIDtZoFsc3zDeco/QI8lYqyFMU2KBq
         XlBej8gFzBkMg==
Date:   Wed, 31 Aug 2022 09:31:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Message-ID: <Yw8APL/cxTsSI0+x@unreal>
References: <20220805183523.32044-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805183523.32044-1-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 01:35:24PM -0500, Bob Pearson wrote:
> Move setting of pd in mr objects ahead of any possible errors
> so that it will always be set in rxe_mr_complete() to avoid
> seg faults when rxe_put(mr_pd(mr)) is called.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 11 ++++-------
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 10 +++++++---
>  3 files changed, 14 insertions(+), 13 deletions(-)

I see only one patch out of two "v5 for-next 1/2". Where is the second one?

Thanks
