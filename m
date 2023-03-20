Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3F6C0BA1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 08:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCTHwn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjCTHwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 03:52:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4A2714
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 00:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 981AEB80D6B
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 07:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E3C433D2;
        Mon, 20 Mar 2023 07:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679298757;
        bh=cn9F0rQrKsM8TmNNTAm3jqkMWmH5wqtki5rowLedBYw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZOCFFRLYgOmZKBqhr95G9Sz/oG45Qn8nyOrYaDh9aW0H8hb7CnAdHbbPdPcGtsUAv
         dPWjCMmf3iaPUC0cVolP1SZSd2l52gDyo2P8xiyj2JevgoxmxUb+kc9zwQ3zeewFiB
         AKRMMjfR7QEin2pydBizBywuq/5mPIgibnIOys0B3tECSVUz8VJciw3Q3tVVE2Rh20
         j5ey4VfAyoXZwTh/7XBJ3yXIBZaAEUJvKvAnu5BlRRrRKvcSHiOdriGGwAyQjmrVb1
         vBRaWMMIwQQjKVd7U7H6icrD8LDxgUMUwXAJjGPVmvp5iNAI1i2ddWDTDIPUmCqF/l
         8k0iwTdst5VuA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Maher Sanalla <msanalla@nvidia.com>, Aya Levin <ayal@mellanox.com>,
        Aya Levin <ayal@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
In-Reply-To: <ec9040548d119d22557d6a4b4070d6f421701fd4.1678973994.git.leon@kernel.org>
References: <ec9040548d119d22557d6a4b4070d6f421701fd4.1678973994.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Add support for 400G_8X lane speed
Message-Id: <167929875259.995853.16469171148434323066.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 09:52:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 16 Mar 2023 15:40:49 +0200, Leon Romanovsky wrote:
> Currently, when driver queries PTYS to report which link speed is being
> used on its RoCE ports, it does not check the case of having 400Gbps
> transmitted over 8 lanes. Thus it fails to report the said speed and
> instead it defaults to report 10G over 4 lanes.
> 
> Add a check for the said speed when querying PTYS and report it back
> correctly when needed.
> 
> [...]

Applied, thanks!

[1/1] IB/mlx5: Add support for 400G_8X lane speed
      https://git.kernel.org/rdma/rdma/c/88c9483faf15ad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
