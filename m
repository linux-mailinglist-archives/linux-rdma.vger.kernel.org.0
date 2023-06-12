Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC272B90C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjFLHs7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjFLHsy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A381BF6
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB3860A66
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F78C4339B;
        Mon, 12 Jun 2023 07:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686554003;
        bh=M/vyPvgpbmUMzqiWEq6GJrDY7BY/ILutwv2mSK464tQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NqV9xiBsktWcOOHmr+3W+SCuPEFYP7q5dwL8oyeiisBp096tIfbaoc+Nx4+V2ZB1d
         2CWoacxSqpYGVHgG+p2KZF5oXYlyDCvQk2WSCo7ctyPJrpD50rCqFmO8KKvqifQDkm
         to25PcX/akBf28BI8QT/m3RbQAgKVePvgsoOJ3Dm0aSYKz6mr8K6U4RODUZKfQTt6S
         OA9q9rXpYGtf2b4Q5hHum81LUlLFfV/JU1fqSkhqNd7dnANr3Sa0rW1F7f7fbE7BQs
         0e5YBUsTrY3wHxN4MV7ZvVXGycbmjM8C31AXKPEppD4eumSeZs5CHSUWQFQuUa3IX2
         frMBpRSSxio4w==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Message-Id: <168655399888.1341983.14853412430695427413.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 10:13:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 12 Jun 2023 14:42:37 +0900, Shin'ichiro Kawasaki wrote:
> When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
> *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler() [1].
> To prevent the destroy of id_priv, keep its reference count by calling
> cma_id_get() and cma_id_put() at start and end of cma_iw_handler().
> 
> [1]
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: prevent rdma id destroy during cma_iw_handler
      https://git.kernel.org/rdma/rdma/c/fd06a5925e4773

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
