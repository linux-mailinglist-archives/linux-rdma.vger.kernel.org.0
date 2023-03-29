Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2256CD2A8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjC2HJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjC2HJx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 03:09:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7666199
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 00:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F426B820CB
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94572C433EF;
        Wed, 29 Mar 2023 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680073790;
        bh=1QeEu2xxrBglIfd2+cPyElxwRitBW8/lennaeu5LPFQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Avt9kavsgJnO+Jb165oxgYGcAo5bQyOeJR+p6HeHVKhTaSwEf4aFLeoW+Dkq++rLx
         +O5d3lAHMsLvbP+SkyWF5gEcL6yYSIVUty5ow7/mgCF3MeabzqPM/6DZeckdLOyyDM
         JrwtNjc0I7UCt+iDMFKH59eRqCtdTagEMA1ya2Ltq9nz+YeMybXsVyRA8RJkCX5CV/
         NRIT2uBnsgHNEfWK6gBYSW5h3pk7R85oTeAS2b5AeigMOBpYf20xLdwVuQrC+9467w
         DkjsNnOuMDk5iR/uemh1b/p66xkPSvVeLeBb/3wPzfyOWvO2h+duYvVKbYmTBEo6Xr
         J3gSUtlii2eCw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
References: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Add resize_cq support
Message-Id: <168007378587.938793.15699539659340943289.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 10:09:45 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 15 Mar 2023 01:16:55 -0700, Selvin Xavier wrote:
> Add resize_cq verb support for user space CQs. Resize operation for
> kernel CQs are not supported now.
> 
> Driver should free the current CQ only after user library polls
> for all the completions and switch to new CQ. So after the resize_cq
> is returned from the driver, user libray polls for existing completions
> and store it as temporary data. Once library reaps all completions in the
> current CQ, it invokes the ibv_cmd_poll_cq to inform the driver about
> the resize_cq completion. Adding a check for user CQs in driver's
> poll_cq and complete the resize operation for user CQs.
> Updating uverbs_cmd_mask with poll_cq to support this.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Add resize_cq support
      https://git.kernel.org/rdma/rdma/c/d54bd5abf4d26e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
