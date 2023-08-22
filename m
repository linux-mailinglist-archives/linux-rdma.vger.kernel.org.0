Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D178433E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjHVOGs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbjHVOGk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805410C3
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 406EC646CF
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 14:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C8C433C9;
        Tue, 22 Aug 2023 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713129;
        bh=CS5AeoLKDmWhbktqJE/pN1OT9OHJXz19bMpU3GZaeO8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aDYt+TpZaNo7AAdyRRj7GxqhZq8RKGr6FaihpSoxwHLjYdjsiLEsdvmryV6psvn35
         XJGE0PIBd5vmbmiFG0SvGpFdLq+YhmC/YcSixW+Wi8sOcVTSwedtXfdHv5RakMBOSm
         7u5HL7yrMZtynzVpQV9+5icdKBu9SLmFqpQeV36X3fXGsTTl/4mksMSqAkFwcWGHjv
         TRsCdzg7UhQiK/JCwaxHU2Qo+2M1SstOBC6RnDSnEaQ7Zbhm8+mAoNMLHLL14xMMhu
         sT7Wp3+NIZ512afBlv/UHMj/8zEJAZpgKSe8oOYviQCyaYe7+C4U9l49RmeshaTw5y
         kUM2xePKOAfkg==
From:   Leon Romanovsky <leon@kernel.org>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230821133255.31111-1-guoqing.jiang@linux.dev>
References: <20230821133255.31111-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V3 0/3] Misc changes for siw
Message-Id: <169271312528.24310.7120045573364635867.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:05:25 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 21 Aug 2023 21:32:52 +0800, Guoqing Jiang wrote:
> V3 changes:
> 1. collect tags from Bernard, thanks!
> 2. add comment back to the last patch.
> 
> V2 changes:
> 1. add Fixes lines for the first two patches per Leon
> 
> [...]

Applied, thanks!

[1/3] RDMA/siw: Balance the reference of cep->kref in the error path
      https://git.kernel.org/rdma/rdma/c/b056327bee09e6
[2/3] RDMA/siw: Correct wrong debug message
      https://git.kernel.org/rdma/rdma/c/bee024d20451e4
[3/3] RDMA/siw: Call llist_reverse_order in siw_run_sq
      https://git.kernel.org/rdma/rdma/c/9dfccb6d0d3d13

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
