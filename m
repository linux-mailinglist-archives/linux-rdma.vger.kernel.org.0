Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724B55A8F84
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 09:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiIAHOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiIAHNR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 03:13:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FE124852
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 00:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4381361CE1
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 07:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E466C433D6;
        Thu,  1 Sep 2022 07:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662016392;
        bh=E3UdHVbxwBBV48CAwL2LX8W+zQvWEai/W/MmnyO2wwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVtPXAwbf+YfdnJV3E4udexL5Vh7jfjuyBdTl0uJLScLgNCCnvIAt42jYS2OjIlRf
         pZRi01ij8FGzYQ6EOpewPdpIAx0PBbGsfLTssgnUc8Lb9amdTr2C3b392nsCTXsJNP
         k7gNkBMrpY+q0Y/PLn+mmI8SYVp9P2P5M1P7qXxLcs4ONH+I+4ogeWB75tO2lGM4UG
         0Cni7y0znncmvVK56r8hor0jiAjn6pOtUxS3e2CJr+nSavI+BuFwH1AY0MRnv0Oz7b
         5Ghig8SC0ATAaufOoPzL5jdX2ApeMIo/swT2+PTbXSAql6sRvi+W1UecyGBBTbrOdr
         X6bEGhD9irB1A==
Date:   Thu, 1 Sep 2022 10:13:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tom Talpey <tom@talpey.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Add missing Kconfig selections
Message-ID: <YxBbhONAZmZN5JsF@unreal>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 31, 2022 at 12:30:48PM -0400, Tom Talpey wrote:
> The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.
> 
> In addition, it improperly "depends on" LIBCRC32C, this should be a
> "select", similar to net/sctp and others. As a dependency, SIW fails
> to appear in generic configurations.
> 
> Signed-off-by: Tom Talpey <tom@talpey.com>
> ---
>  drivers/infiniband/sw/siw/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/Kconfig
> b/drivers/infiniband/sw/siw/Kconfig

I don't know how you created the patch and sent it later, but it broken.
1. diff --git line above was broken to two lines. It causes to the
following error:
➜  kernel git:(wip/leon-for-next) ✗ git am -s ./20220831_tom_rdma_siw_add_missing_kconfig_selections.mbx
Applying: RDMA/siw: Add missing Kconfig selections
error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
Patch failed at 0001 RDMA/siw: Add missing Kconfig selections
....
2. You changed tabs to white spaces in the patch itself.
➜  kernel git:(wip/leon-for-next) ✗ git am --reject -s ./20220831_tom_rdma_siw_add_missing_kconfig_selections.mbx
Applying: RDMA/siw: Add missing Kconfig selections
Checking patch drivers/infiniband/sw/siw/Kconfig...
error: while searching for:
 config RDMA_SIW
        tristate "Software RDMA over TCP/IP (iWARP) driver"
       depends on INET && INFINIBAND && LIBCRC32C
        depends on INFINIBAND_VIRT_DMA
        help
        This driver implements the iWARP RDMA transport over
        the Linux TCP/IP network stack. It enables a system with a

error: patch failed: drivers/infiniband/sw/siw/Kconfig:1
Applying patch drivers/infiniband/sw/siw/Kconfig with 1 reject...
Rejected hunk #1.
Patch failed at 0001 RDMA/siw: Add missing Kconfig selections

I fixed everything and applied to -next.

Thanks
