Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72F745D3F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGCN2T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 09:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGCN2T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 09:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63980D2;
        Mon,  3 Jul 2023 06:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0033560F29;
        Mon,  3 Jul 2023 13:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F01C433C7;
        Mon,  3 Jul 2023 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688390897;
        bh=9MfmNkXtRnPAz4JajXu2pnpfR+Wd/raHkYtmI3EjdfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZl4Jdr9tZLbI4xa7wVF+DsqvzqJRLQWX9slxburg1Eoq42DEtQq5t99LJEEqDUBK
         HKLVMT4/dNuNaNBNwWIpDRILAMxqIHj7V/re+O/WbQI9jyzM0KNSwIMGNeDQfX2DTu
         R3/pAOoKTc4XxU1gGnsQRRmj7SuMu8hOwDZDk4pvp/f9gOYz+Ydd4gwMPzSo7sdG2a
         KC5g0UNVU7p1Gz35OupBjiDHUU8lQ7waPDBz45RzFAegKV8ex4HmcKEaV53LRKse01
         w/xex63xJKvf22W1O15doKU5zaHlXO727l7ChD9KFm99HDcu+jxVUl2vxdbxYrlPBT
         JRphIBnhyAGdg==
Date:   Mon, 3 Jul 2023 16:28:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] RDMA/bnxt_re: fix verbs undefined build errors
Message-ID: <20230703132814.GA32152@unreal>
References: <20230701003059.23064-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701003059.23064-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 30, 2023 at 05:30:59PM -0700, Randy Dunlap wrote:
> When INFINIBAND_USER_ACCESS is not set, the bnxt_re driver has
> build errors:
> 
> ERROR: modpost: "uverbs_idr_class" [drivers/infiniband/hw/bnxt_re/bnxt_re.ko] undefined!
> ERROR: modpost: "ib_uverbs_get_ucontext_file" [drivers/infiniband/hw/bnxt_re/bnxt_re.ko] undefined!
> ERROR: modpost: "uverbs_destroy_def_handler" [drivers/infiniband/hw/bnxt_re/bnxt_re.ko] undefined!
> 
> Handle this case by making the driver depend on INFINIBAND_USER_ACCESS.
> 
> Fixes: 592e8b3226a2 ("RDMA/bnxt_re: Add bnxt_re driver build support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Selvin Xavier <selvin.xavier@broadcom.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: Devesh Sharma <devesh.sharma@broadcom.com>
> Cc: Somnath Kotur <somnath.kotur@broadcom.com>
> Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> Cc: Doug Ledford <dledford@redhat.com>
> ---
>  drivers/infiniband/hw/bnxt_re/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

I liked this variant [1] more as bnxt_re driver can theoretically work
without INFINIBAND_USER_ACCESS too.

[1] https://lore.kernel.org/all/20230703113025.356682-1-arnd@kernel.org

Thanks
