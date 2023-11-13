Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BFF7E97FE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKMIqC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIqC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:46:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21EC7
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 00:45:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F33C433C9;
        Mon, 13 Nov 2023 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699865158;
        bh=R+YbthBcWevS7QzDZRR/F6r4B8sEoGTPJMyLzjiosuQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZyVNEcTFWImhOFKPvYsHFQb5stuA+e/SmpH2fYBMNBISo1egD0gNGodevw6knUE5h
         zSPElYpE94YyhKpC92hn1Qj51I/b9WyXSY7lfPGK41TQAv/sva7CatXRfJc1D0upRt
         OEPPCa6xs5yWzdBh9xqMo5/EUDSmvoM9J9bblshzV8DRAkQHYTvf0TIO+6xhEiB5dV
         6T0IZcjlVC+vfhsxI2bln7iYX2E/yi0qJtUewPx8ZrvuG+c9f4KDhFEPxuS7N2tgtv
         ZF5dbJ0PJxCeR5n5RFgOpn77nt6F/38U9wqKV0nPmfx4wzEcf7KCBKHYfSUWBPDaR9
         707NWAQYZh0lQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
In-Reply-To: <20231029045756.153943-1-ebiggers@kernel.org>
References: <20231029045756.153943-1-ebiggers@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: use crypto_shash_digest() in irdma_ieq_check_mpacrc()
Message-Id: <169986515442.285886.8959271939050774739.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 10:45:54 +0200
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


On Sat, 28 Oct 2023 21:57:56 -0700, Eric Biggers wrote:
> Simplify irdma_ieq_check_mpacrc() by using crypto_shash_digest() instead
> of an init+update+final sequence.  This should also improve performance.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: use crypto_shash_digest() in irdma_ieq_check_mpacrc()
      https://git.kernel.org/rdma/rdma/c/42c9ce5203de6d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
