Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC46CD334
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjC2H27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjC2H2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 03:28:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A255E4492
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 00:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5335CE1FD3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF7CC4339E;
        Wed, 29 Mar 2023 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680074760;
        bh=pi6E3buI/nN6u5tT8L7D2txrVezxp3ShWeV4T8WruBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/lmXDAmq64WfR6FXVNJbALFxTprf7hqYqmXkwr8I68BnIvAYvrIMC9+gIj2W1H4w
         tx6BTCoa2U+cYMXimea4gKqf02mTJL93L1r2TJufRtctywOwX6r9qNLYauwQiDPOYo
         oA6Deb0gGpwoVuglD0wWRm82SbStr2D8BXwDQmqxZTlkTSSNyoPCkA8wWCVQqLD8aG
         Nl7hC5BoMbFJKLtHL9zLhGPI1JrusNe1gyf+RZQbsquvIlgxCX/wyQq0j0UQXKI9jH
         9sQ2vig/vkeyYuSVhrjG3lKsKY1xmjXwuv4mOxaARE843uA3eYyK88kRdOaNJnayUw
         678E0HIaen+mQ==
Date:   Wed, 29 Mar 2023 10:25:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next v2 7/7] RDMA/bnxt_re: Enable congestion control
 by default
Message-ID: <20230329072556.GE831478@unreal>
References: <1679769854-30605-1-git-send-email-selvin.xavier@broadcom.com>
 <1679769854-30605-8-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679769854-30605-8-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 25, 2023 at 11:44:14AM -0700, Selvin Xavier wrote:
> Enable Congesion control by default. Issue FW command
> enable the CC during driver load and disable it during
> unload.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c       |  24 ++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  15 ++--
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  20 ++++--
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 109 +++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h   |  67 ++++++++++++++++++
>  5 files changed, 222 insertions(+), 13 deletions(-)

My comment about cookie on v1 is still applicable.
https://lore.kernel.org/all/20230329072339.GD831478@unreal/

Thanks
