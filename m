Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E81657500
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiL1J7T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 04:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiL1J7S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 04:59:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD465B9;
        Wed, 28 Dec 2022 01:59:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFBAAB8125D;
        Wed, 28 Dec 2022 09:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D854AC433EF;
        Wed, 28 Dec 2022 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672221554;
        bh=qDFmQ7WS+lHFEiuhdUxGz7qEzX+aRjlUsKSeYOaC1Mk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=r0d7bSLMBDnBipGWUXFsUCCYlBZTA/29DyuatRWdC8OHXbP6irqUuP4exCly9k3H4
         1+KmvEeAEMvRUDkhvp+nkRRGs3ydxCrJsBUj9jN4w9T+gmlQt43nbPQPvLi7I7Dkkv
         ex8jrbPM3YQYwCqeeJ1DBU3Bum9gMhaTCPnkvOf5Fsx6l8Bjqp2ljEJ+Ym59IJuU7S
         dICrALpTDU8f0aNWGW/v2spTTiNbb9gJQ70tPUjo2c0/YSwFlMTgU+ifmILBYESDHC
         idxlG+EwqJtQf0DewgB1hR/h05+XIuescu1bhhJn5fHJBGm/DHkW6vq0jTEPGouVoi
         H6x6ggLWeCdmA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Kai Shen <kaishen@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20221220121139.1540564-1-linmq006@gmail.com>
References: <20221220121139.1540564-1-linmq006@gmail.com>
Subject: Re: [PATCH] RDMA/erdma: Fix refcount leak in erdma_mmap
Message-Id: <167222155015.52802.7618270448671677586.b4-ty@kernel.org>
Date:   Wed, 28 Dec 2022 11:59:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 20 Dec 2022 16:11:39 +0400, Miaoqian Lin wrote:
> rdma_user_mmap_entry_get() take reference, we should release it when not
> need anymore, add the missing rdma_user_mmap_entry_put() in the error
> path to fix it.
> 
> 

Applied, thanks!

[1/1] RDMA/erdma: Fix refcount leak in erdma_mmap
      https://git.kernel.org/rdma/rdma/c/ee84146c05ad23

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
