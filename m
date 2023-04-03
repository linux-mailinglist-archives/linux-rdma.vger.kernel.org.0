Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C66D5038
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjDCSYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjDCSYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 14:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDCA358A;
        Mon,  3 Apr 2023 11:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B694F625F0;
        Mon,  3 Apr 2023 18:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A064C433D2;
        Mon,  3 Apr 2023 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546250;
        bh=IFwDoOCJAmZKDpBjepwRj63nEv0Sg9V6Tqt9SLsZuBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ANz1ZmAe1zlqCH5XQ/q6n9Iuvt0kmI50Mw9O7eIBV0HjfJr+k/06vGfPlMPG8i8Mf
         cXO8+OEDmcsGRIPZLLcGBlrDfW+Ud7nUyCWgt3bPLDUR6a2syh4PENhC6CFuOKUAju
         1t2WhV2rR1qeqciD29ZUIGNyJ2E3CMxpsS8Lku+SOkNKnUOcgdQRu1lsQ/XLcXZ+nf
         D+cW2XiFydMbcWKMQ/r8FHSesjDHLaDYwN9f/XbVlWgGBcVfs7GXQROoKY22cs7EfO
         BWtj/hiG0Q4SbouvHbUlBN1NPNqtTtSgQEq2eguB1iyKqFpu3G24tN1NdzuReeq/tU
         FYxEbnzRbJnkw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230331010633.63261-1-yang.lee@linux.alibaba.com>
References: <20230331010633.63261-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/cma: Remove NULL check before dev_{put, hold}
Message-Id: <168054624617.6296.18087414911653959045.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 21:24:06 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 31 Mar 2023 09:06:33 +0800, Yang Li wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warnings:
> 
> ./drivers/infiniband/core/cma.c:713:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> ./drivers/infiniband/core/cma.c:2433:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Remove NULL check before dev_{put, hold}
      https://git.kernel.org/rdma/rdma/c/08ebf57f6e1d73

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
