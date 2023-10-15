Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7C7C9851
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Oct 2023 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJOIFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Oct 2023 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjJOIFR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Oct 2023 04:05:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2582D8
        for <linux-rdma@vger.kernel.org>; Sun, 15 Oct 2023 01:05:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01222C433C8;
        Sun, 15 Oct 2023 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697357111;
        bh=zuHAGMqgSc9NJXz5CuK35Ha2C8EOZ/yfN1zdUxJ4ZJM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ASfGHbhe4BkELyoBpSgtllbX5RWOTjmLg5dDTAEyaB8oQUkTBxyVAjlS1Mlzd79Z1
         /hvX60dpLptjkHHF8YZzMozsM9OhW65BihnqQ+2Nb0OgTmana7tDp3rD+iZbUPbJeg
         ioVT+WshoEE1KQUhE//yJNK/Oz8xx3klVpOFqm0s5YT1c4W4uOQjRv956wwJ18WREG
         TiI9rwf/CA7OdbB2Bm197vI21U5Y5tEb5v81U/skc/otop0F0nFwcZEH2hOjIEN3Fy
         IrUAOn0vFtExGXO/q5ehAHyroeHfxE1BIC30DyLlYoRB3e84q87URL5TIX1ndKLA6i
         W0BHaOHV8GslQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <2e5ab6713784a8fe997d19c508187a0dfecf2dfc.1696847964.git.leon@kernel.org>
References: <2e5ab6713784a8fe997d19c508187a0dfecf2dfc.1696847964.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Fix rdma counter binding for RAW QP
Message-Id: <169735710702.46671.5844125346086856844.b4-ty@kernel.org>
Date:   Sun, 15 Oct 2023 11:05:07 +0300
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


On Mon, 09 Oct 2023 13:41:20 +0300, Leon Romanovsky wrote:
> Previously when we had a RAW QP, we bound a counter to it when it moved
> to INIT state, using the counter context inside RQC.
> 
> But when we try to modify that counter later in RTS state we used
> modify QP which tries to change the counter inside QPC instead of RQC.
> 
> Now we correctly modify the counter set_id inside of RQC instead of QPC
> for the RAW QP.
> 
> [...]

Applied, thanks!

[1/1] IB/mlx5: Fix rdma counter binding for RAW QP
      https://git.kernel.org/rdma/rdma/c/c1336bb4aa5e80

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
