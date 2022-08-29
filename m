Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF965A4363
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiH2Gsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 02:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiH2Gsf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 02:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35DC45F48
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 23:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5024F60FDB
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 06:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27874C433C1;
        Mon, 29 Aug 2022 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661755711;
        bh=QwskvcDknL/dtECS+16i4JLr364ka3G65vKQ7tVVi8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsdEhCdg8QONBzfyDckLYGyRStrkSKaa5gA55s8q6Ow4tbp1kZIurduGW5hbHsriv
         fawAovAZRxxKFiPQ7v0tsdHCQbjKMg1yl005uiTsr2sxnyOoIo6LwZhiFOo4SXZwuD
         8f5ErhoNE+kL+I1xt54AS5Y+WwaBNY1rmuzCrLK1SifOcKGit+8s8KxX1rteVDjp/V
         UmvOq0IlVHrYCwCXFSFLyM0JJ0jh08oqw3fHszouxmGRax8vz8A9OjChuVJrBXHbAR
         pNoeRdgpl2ZWGvPW2H/Dz4aaEXiQew3Hez7S9fETbkczCfTrTI3QwQ0wJQlRO+M2Dv
         W1zf8bOPJgOcg==
Date:   Mon, 29 Aug 2022 09:48:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rxe: Remove an unused member from struct rxe_mr
Message-ID: <YwxhOzl5VyXucpdt@unreal>
References: <b02722ae-0eb9-0ba2-ea46-a15ec35426a2@linux.dev>
 <20220829012335.1212697-1-matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829012335.1212697-1-matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 10:23:35AM +0900, Daisuke Matsuda wrote:
> Commit 1e75550648da ("Revert "RDMA/rxe: Create duplicate mapping tables for
> FMRs"") brought back the member 'va' to struct rxe_mr. However, it is
> actually used by nobody and thus can be removed.
> 
> Fixes: 1e75550648da ("Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> v2
>   Added a Fixes tag
> 
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>  3 files changed, 3 deletions(-)
> 

Thanks, applied.

BTW, please don't send new patches as reply to previous versions.
