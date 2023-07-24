Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5275EE3F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 10:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjGXIsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjGXIsY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 04:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40710D8;
        Mon, 24 Jul 2023 01:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C5260FE7;
        Mon, 24 Jul 2023 08:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F20C433C8;
        Mon, 24 Jul 2023 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690188500;
        bh=GDHHB+TxYXuEknx3/QZhkDKIqYbsGLig4QsdfikHfuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifCIhC+9fckVFKi1JWvORJPR1WpvOThotImpJgPyJ7DTot80CxhSdPu7DiQ0Wk2qL
         9WBwRcvXrpHkkx/Uh813wwzivm5PpDvcFMFFnnDLm4lcRu43IiHIUG7CATHPTWUD4I
         4XUPYOvc0wgwxxPBwGiShZkyAwtvQ6I+QQWTR011X4Cwfn7U817+50HsJnh8bhXja2
         Ip5AzWm/tBZb/YoBaaeYR6OlwqJMYxXf4tEj7fgqUHJ2koBP3xIMmyblsNHogaavp6
         VhlPBDnq7PMmT+VQ3yts5kJgDo5xxvb3aVaseIXdotUK4A3XFR9b2/cL5I32jdOMpd
         Px5f9HQpPxMrQ==
Date:   Mon, 24 Jul 2023 11:48:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-rc 0/2] RDMA/hns: Improvements for function
 resource configuration
Message-ID: <20230724084816.GA9776@unreal>
References: <20230721025146.450831-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721025146.450831-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 10:51:44AM +0800, Junxian Huang wrote:
> Here are 3 patches involving function resource configuration.
> 
> 1. #1: The first patch supports getting xrcd num from firmware.
> 
> 2. #2: The second patch removes a redundant configuration in driver,
>        which is now handled by firmware.
> 
> V2 removes 'inline' before function names in the third patch.
> 
> V3 removes the third patch in V1 and V2.
> 
> *** BLURB HERE ***
> 
> Junxian Huang (1):
>   RDMA/hns: Remove VF extend configuration
> 
> Luoyouming (1):
>   RDMA/hns: support get xrcd num from firmware
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 89 +++------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 13 +--
>  3 files changed, 14 insertions(+), 89 deletions(-)

Applied to -next.

Thanks

> 
> --
> 2.30.0
> 
