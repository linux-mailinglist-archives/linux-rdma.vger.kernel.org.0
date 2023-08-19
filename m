Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1E78194D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Aug 2023 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHSLoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Aug 2023 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLoo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Aug 2023 07:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476E207DD
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 04:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5805A61541
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 11:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDF1C433C8;
        Sat, 19 Aug 2023 11:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445365;
        bh=hgfl9pmyy3RLTbGgwhRN2kmlKkienBtsAZLe87yDAtA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hQ9AiEyboBKx/MRrzUf//k9gG50rPsRDHMo+Ks2FvD1cFVtZA5+3SIzkL2ZpmR/OZ
         //6YdDQJ+qYrp5+uLfIHHKjmIbP587oRi8NoCYHLIprGBFzA80um9+BgnwVceXhjOQ
         crrL0O7gzELtxiBYVfJ2Q6MUNQbgMPsoH9pASdOsbBbZuHU1KB8KbmdQe8Ni28EzDe
         jDeN6P2gH58EnqMXpPGil6Kuu8y4hopyTEW8cwJF7pkw7VUDO6HKm7e+0GxZGhdhgQ
         HAUhug4wtUW06nf6uJyAFBYjlGoPLXzXkE6NDkOTR2nvF5oNm28zHZgb/oKqY2RZbI
         LZP6iBPd8kDBA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20230817102151.75964-1-chengyou@linux.alibaba.com>
References: <20230817102151.75964-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: Add hierachical MTT support
Message-Id: <169244536118.1287259.14681858012195925613.b4-ty@kernel.org>
Date:   Sat, 19 Aug 2023 14:42:41 +0300
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


On Thu, 17 Aug 2023 18:21:48 +0800, Cheng Xu wrote:
> Currently, erdma only supports 0-level or 1-level MTT, which limits the
> maximum length of MR. It fails to meet the requirements in some scenarios.
> Therefore, we implement hierachical MTT to support 2-level and 3-level
> MTT, so that users can register MRs large to 64G to erdma devices.
> 
> - #1 ~ #2 make some preparations, such as renaming certain variables and
>   refactoring the storage structure of MTT.
> - #3 implements the hierachical MTT.
> 
> [...]

Applied, thanks!

[1/3] RDMA/erdma: Renaming variable names and field names of struct erdma_mem
      https://git.kernel.org/rdma/rdma/c/d7cfbba90b8015
[2/3] RDMA/erdma: Refactor the storage structure of MTT entries
      https://git.kernel.org/rdma/rdma/c/7244b4aa4221d7
[3/3] RDMA/erdma: Implement hierachical MTT
      https://git.kernel.org/rdma/rdma/c/ed10435d358314

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
