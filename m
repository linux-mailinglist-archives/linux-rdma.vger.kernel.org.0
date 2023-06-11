Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46572B11F
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFKJUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjFKJT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 05:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5D2722
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 02:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AB0611EC
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 09:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41761C433A1;
        Sun, 11 Jun 2023 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686475194;
        bh=xTi3abJAEaS1tfCPyw7CWWztgshTpaDCZBuq04+KRAo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VHymba9iV2+237quSnnAgiZQHTSlQxxsMVMpp49cdPhdBanNT2FyQJzmz/wR7CKED
         rVB0ml7yfsFj5gdmTcBExqu+tHN0D0fe3gkog14XLWUVPQPk6chVPCfx4wiEbXcihc
         h9QI42v7X1XEb1Irpc2kX9MLGnEhA3qIEb50gCcSg0n+kwQqjB7mQHPO6DZkvHace1
         TfRg7aezSH0lsDFpQ8oqzs+N7d+z+ouSSyhAw0T1L9rjIm+BJS9wmHnLpMhNZJ0ojW
         YWYysLKRym2XpwhvZxblKGtH3UH7DeA5+r4C5Xks1hNK4U5GfWW9Qp9aY0OXUT+Zob
         pVwKRSdIDS2BA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20230606055005.80729-1-chengyou@linux.alibaba.com>
References: <20230606055005.80729-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next 0/4] RDMA/erdma: Add a new doorbell allocation mechanism
Message-Id: <168647519066.116598.18282681779687114248.b4-ty@kernel.org>
Date:   Sun, 11 Jun 2023 12:19:50 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 06 Jun 2023 13:50:01 +0800, Cheng Xu wrote:
> This series adds a new doorbell allocation mechanism to meet the
> the isolation requirement for userspace applications. Two main change
> points in this patch set: One is that we extend the bar space for doorbell
> allocation, and the other one is that we associate QPs/CQs with the
> allocated doorbells for authorization. We also keep the original doorbell
> mechanism for compatibility, but only used under CAP_SYS_RAWIO to prevent
> non-privileged access, which suggested by Jason before.
> 
> [...]

Applied, thanks!

[1/4] RDMA/erdma: Configure PAGE_SIZE to hardware
      https://git.kernel.org/rdma/rdma/c/128f8404306d42
[2/4] RDMA/erdma: Allocate doorbell resources from hardware
      https://git.kernel.org/rdma/rdma/c/7e9a1dada2266c
[3/4] RDMA/erdma: Associate QPs/CQs with doorbells for authorization
      https://git.kernel.org/rdma/rdma/c/6534de1fe38514
[4/4] RDMA/erdma: Refactor the original doorbell allocation mechanism
      https://git.kernel.org/rdma/rdma/c/3b3dfd58bace12

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
