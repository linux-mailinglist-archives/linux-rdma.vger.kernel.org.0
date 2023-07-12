Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E198B75079C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGLMKa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjGLMKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA60E4D;
        Wed, 12 Jul 2023 05:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8F906179C;
        Wed, 12 Jul 2023 12:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9683C433C8;
        Wed, 12 Jul 2023 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163828;
        bh=Vo61rsO+lUWHdqkKANoX9t5JCQQtSJ185lJYvF87Rdw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hUQaOiE9iCaW78i0WRqsSeZxV5J1kzmGQ0QKwxMOMJbd7/0Ug9JdNneEEAmjStKHL
         02vyPgxSX7ToxJgT3Vc52dbXy70ShreJ5kz1d7zBjrTqsaljq4/uwKUnMsx001+7Hf
         G2jIbDuPVBjCpKBYU7ZFlSVZS3OfVy8yA4ZqVVHMX4Uj+cmWVdj+/CcbWJ9hRKJ2Bh
         +OoNT9tlkRsMlYmtNFagCtWMZmE+93OrVvYktYWzmwLSqEz5A3lJjWX3Oyu21iFRzP
         weuJ21b80ynkaQyciGrzgwwWcVeNcgSshlyj6UZIceUuNHG0atHlT6P4oBUCVLri8M
         k++llNdDBI0yA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     cachen@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230629213248.3184245-1-yzhong@purestorage.com>
References: <20230629213248.3184245-1-yzhong@purestorage.com>
Subject: Re: [PATCH 0/1] RDMA/mlx5: align MR mem allocation size to power-of-two
Message-Id: <168916382400.1207710.3116190060320574787.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:10:24 +0300
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


On Thu, 29 Jun 2023 15:32:47 -0600, Yuanyuan Zhong wrote:
> Recently I noticed the mlx5_alloc_priv_descs() do many allocations from
> kmalloc-8k. It's called from following chain:
> cma_cm_event_handler => nvme_rdma_cm_handler => nvme_rdma_create_queue_ib
> => ib_mr_pool_init => ib_alloc_mr => __mlx5_ib_alloc_mr
> => _mlx5_alloc_mkey_descs
> 
> When the nvme-rdma asks to allocate memory regions that support maximum 257
> sg entries, the real MR memory allocation size is slightly bigger than 2048.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: align MR mem allocation size to power-of-two
      https://git.kernel.org/rdma/rdma/c/52b4bdd28c861e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
