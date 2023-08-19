Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89953781A89
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Aug 2023 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjHSQ3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Aug 2023 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjHSQ3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Aug 2023 12:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EE4C3B
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 09:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA1661D30
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 16:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6F5C433C7;
        Sat, 19 Aug 2023 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692462569;
        bh=rAtGDbHPhR/gdEhvN4oCmxRqX83F2dV2lZfIF16RnQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHtyG3GviXZh/zRfN4YXCy+xqxBaqnddf8tFGQSvKdn/N6GnMnKZMLBYpYzq8fc+3
         MMoeeOQ0nkli6pEFnuxkXEOXo7oNRs4mJMWt5iqNlPaeujVTJ73gHotNhAyKS+hymi
         08HOqE4ly72ltUjauK1TInTc75NOwgQruSZr2M2o0T6PTKA75b3Id0J5zWU6mdva6t
         3Xdm6VEsf3DiF9/SoRw4xcjiqQqktl4k8xUUoh+XZjywF6tB1S9A6ES/GDTZbcKpYm
         s9C1TnA/efAQNe/jb18RVxdp6pbnTkrbw84j5U/xIIwVH0hjNOnfwx3l5EwVtCBEV0
         JDSRJOzLQeZXw==
Date:   Sat, 19 Aug 2023 19:29:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        ivan.d.barrera@intel.com,
        Christopher Bednarz <christopher.n.bednarz@intel.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Prevent zero-length STAG registration
Message-ID: <20230819162924.GR22185@unreal>
References: <20230818144838.1758-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818144838.1758-1-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 18, 2023 at 09:48:38AM -0500, Shiraz Saleem wrote:
> From: Christopher Bednarz <christopher.n.bednarz@intel.com>
> 
> Currently irdma allows zero-length STAGs to be programmed in HW during
> the kernel mode fast register flow. Zero-length MR or STAG registration
> disable HW memory length checks.
> 
> Improve gaps in bounds checking in irdma by preventing zero-length STAG or
> MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.
> 
> This addresses the disclosure CVE-2023-25775.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Christopher Bednarz <christopher.n.bednarz@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c  |  6 ++++++
>  drivers/infiniband/hw/irdma/type.h  |  2 ++
>  drivers/infiniband/hw/irdma/verbs.c | 10 ++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)

I applied it to rdma-next because we are in -rc6 now and anyway this
patch will land Linus very soon.

Thanks
