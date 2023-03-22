Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5AD6C48AA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCVLLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 07:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVLLS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 07:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5247816
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 04:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF13612DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 11:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6114DC433EF;
        Wed, 22 Mar 2023 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679483476;
        bh=WCT+FKAX/5aL1xoN37YcLif4eB26vWovni2Stvl6Xzc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aalfOPZo+z//st6ErcHj1xHVa/q0SKj+CTOkbA/lZMzKZhpwKbAB6Wmf/TG3ykjjR
         8FkqqGmiM3qPCBhpN9k0fQ2u5gwagQYvdpupmcE6pBqZE4R02agRQJvDLMOpEBCOim
         EEHRtU0oc+QxFzwamYM4kybY3Aq92AoMVaahrupIb/lIrBYSgUx9fO8AHbKmqvbBqL
         /7GH1a7hpqTk+1K9UdYLQTxrIX6umDWKQLHuvjPrUWLuEGDFCq+kc4HCVGxQo+JJKf
         ukgUsU3Paa/1ljv2M/AZRSJHWdU6uVzIIv1y/0qV+sSdSyque0pEBhXO0GBlgeTI9+
         FDzsRs4mbMzHg==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20230322093319.84045-1-chengyou@linux.alibaba.com>
References: <20230322093319.84045-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: erdma updates 3-22-2023
Message-Id: <167948347268.1493391.183321560595333511.b4-ty@kernel.org>
Date:   Wed, 22 Mar 2023 13:11:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 22 Mar 2023 17:33:16 +0800, Cheng Xu wrote:
> This series has some updates for erdma driver:
> - #1 unifies the byte ordering API usage in erdma, removes APIs
>   prefixing with underlines and introduces be32_to_cpu_array
>   to copy and swap byte order.
> - #2 eliminates unnecessary casting of EQ doorbells.
> - #3 refactors the initialization flow to make code cleaner.
> 
> [...]

Applied, thanks!

[1/3] RDMA/erdma: Unify byte ordering APIs usage
      https://git.kernel.org/rdma/rdma/c/de19ec778c7a4e
[2/3] RDMA/erdma: Eliminate unnecessary casting of EQ doorbells
      https://git.kernel.org/rdma/rdma/c/72769dba6dc0b8
[3/3] RDMA/erdma: Minor refactor of device init flow
      https://git.kernel.org/rdma/rdma/c/901d9d62416bae

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
