Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D897E97E6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjKMIjS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjKMIjQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:39:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197A10F6
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 00:39:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5173BC433AB;
        Mon, 13 Nov 2023 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699864752;
        bh=z/LZyzCO5xf5Kooj8/KGmUgE3kdueQBlTs8ybimvdJA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ux05WOvNCXtDZEttw24+0ylg1NUWpSDk+ED5dzAp5K9/lpxaUd9+pujNY4BFkZlAn
         F19wAyuqkYTcNFhsBtP3m7dnQXnaNBtNUpkp2CEMQ4z6J26yPug80AZsLpi9a+yeEn
         pHiISNFU3G5aTcuZwL2fV05aqL1OULhilhqV9E1J71kxcqxJnQVuwlcJsh33zW+ezY
         cxstBKu52UE/CbMpShdK9Zndlbgk93D1c6bmWvz0oN6vS5VoKynepx00PEBNkYUy+x
         clpUVLxR2QoPlufsoyg9r3gxam+acrP7f0XLCBmrh4IokrEGCXepZBDyWaYEiwRLzg
         39QxsQ+2swisA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1698069803-1787-1-git-send-email-selvin.xavier@broadcom.com>
References: <1698069803-1787-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/2] RDMA/bnxt_re: Optimize the memory usage by
 the driver
Message-Id: <169986474906.283834.12109462043088378375.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 10:39:09 +0200
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


On Mon, 23 Oct 2023 07:03:21 -0700, Selvin Xavier wrote:
> This series changes the wrap around condition and avoid
> using the power of 2 number of entries while creating the HW
> resources like QPs/CQs/MRs. Also, added backward compatibility
> to work with different versions of the driver and library.
> 
> Corresponding lib changes are available in the following pull request.
> https://github.com/linux-rdma/rdma-core/pull/1400
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Refactor the queue index update
      https://git.kernel.org/rdma/rdma/c/3a4304d8269501
[2/2] bnxt_re: Remove roundup_pow_of_two depth for all hardware queue resources
      https://git.kernel.org/rdma/rdma/c/48f996d4adf15a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
