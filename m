Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91D54DB5C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiFPHQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 03:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359138AbiFPHQm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 03:16:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A75C34F;
        Thu, 16 Jun 2022 00:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DC2CB8228B;
        Thu, 16 Jun 2022 07:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C45CC34114;
        Thu, 16 Jun 2022 07:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655363798;
        bh=ut6uYExedPckbSWXfPNrGg7mXTgN0/UFQXwmXOinMNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzjjduVNKJVz9gfN0VzxCJSo49+LX0/Dn7QFJ3zhKQbJsJqtr/qkjXLekgYaIi5hT
         /V1eBYi2o4lp5j81sxKKfH1AXzg3FGhvjxMYKMCuKWiomB7EjH7/I1xPjMfHYKk9Me
         aWy2EEywalyjsfHb1S9dpG+k+81AQqcVXVvCIJhwHqhSL/QE16aa+xp/h4K5wbsn2V
         pFuyhPLIn3D93lynsfJcg25o+wiG64ldknlEjQ2pNZv6KK8TKp3V7BrG5dC5nSnV+c
         /kssJPqTxq3za96/WyotW6QEN9ckciXkB6aS9+iGpH6QfaGl8N8BrXJLCh0uCrbWks
         2bCZIY25vmfiQ==
Date:   Thu, 16 Jun 2022 10:16:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     benve@cisco.com, neescoba@cisco.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/usnic: Use device_iommu_capable()
Message-ID: <YqrY0iRXRAJ0SEIi@unreal>
References: <96ffe7050da0aa0ad6bce4705c3532f3ecaf32e3.1654688682.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ffe7050da0aa0ad6bce4705c3532f3ecaf32e3.1654688682.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 08, 2022 at 12:46:33PM +0100, Robin Murphy wrote:
> Use the new interface to check the capability for our device
> specifically.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_uiom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied
