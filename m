Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47387F063D
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 14:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKSNBb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 08:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSNBb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 08:01:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0BB9
        for <linux-rdma@vger.kernel.org>; Sun, 19 Nov 2023 05:01:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDCBC433C8;
        Sun, 19 Nov 2023 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700398888;
        bh=ss99XRF26FqBiiVqhH9R6tMHSPaaasXHA2i3Juh24wQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wkbn6NAzoObI4V8f9qMbBS+cyVhReuSV0SeoE3Hev4iRnFBf9Iju7awmBMYRJSVD5
         Xbzc2LXspq16tumeXSmhcrtTdBhw/7tc+C2IHHr2ysrwFQLsCIlztXlx0B7Q5whROA
         MJzS05STzX2jRZpdEiNAwC89/IYGmtzXgoOowkZ1vDdYgqUZdRB2dgC5IBUSOfzTvJ
         WH7em8tRvMj90DDTvbd86KUhVn/RWaI/n7S/++ZQC9r4LQF+5MwsGyDDH+R3Hek0kH
         N1MHLlgOT1AcUs0VQx8IWP90rxHGpO49sq9gLSWGeG15JneR4sKr7Wyyq4oLIkUA84
         zDk+VlTYEhWjw==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca, jinpu.wang@ionos.com
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
Subject: Re: (subset) [PATCH for-next 0/9] Misc patches for RTRS
Message-Id: <170039888380.100783.11654442386727226105.b4-ty@kernel.org>
Date:   Sun, 19 Nov 2023 15:01:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 15 Nov 2023 16:27:40 +0100, Md Haris Iqbal wrote:
> Please consider to include following changes to the next merge window.
> 
> Jack Wang (4):
>   RDMA/rtrs-srv: Do not unconditionally enable irq
>   RDMA/rtrs-clt: Start hb after path_up
>   RDMA/rtrs-clt: Fix the max_send_wr setting
>   RDMA/rtrs-clt: Remove the warnings for req in_use check
> 
> [...]

Applied, thanks!

[1/9] RDMA/rtrs-clt: Add warning logs for RDMA events
      https://git.kernel.org/rdma/rdma/c/0529e26d8b7b51

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
