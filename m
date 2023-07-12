Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388A1750889
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGLMmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGLMl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB84CF;
        Wed, 12 Jul 2023 05:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF2BA6177D;
        Wed, 12 Jul 2023 12:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35E1C433C8;
        Wed, 12 Jul 2023 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689165718;
        bh=LzSLOQN09xVDxQZyds7MxZIoCJV+XPjKAmqqKtdzcS4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ncHoRwj/+wA5OmxuyjYuJoF8Nm13wbsgW/fvlET/ozEwo7sszhC2jzqy/Xm8/qF9e
         pqrUtZU/83Udr4RJCYLViaW+PmV0tq5rJK2HAm/1D4JRRZANboLwrpaVGugklYX9D7
         L9oSNL2umkAKzeUS9BbvYYjITL9UqwQKPH9MbZqzVCfvhN6NMGP8VGC36p3gx/Doao
         DkuO4XkZNMjaC5jWIm3U2BIMiidzP15L7Y/06UbnifL7IjVMhpiux5CyTw3MMczmS4
         +dybUWCbpDBDAdIuowBR9HvbjnAwtAOJ6ZORIlT6kcdc593kYSIktt/KPwKFYP4lLJ
         QnYGcwp+gGiNg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Guy Levi <guyle@mellanox.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
References: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
Subject: Re: [PATCH] RDMA/mlx4: Make check for invalid flags stricter
Message-Id: <168916571433.1229078.6037889096840333145.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:41:54 +0300
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


On Thu, 29 Jun 2023 09:07:37 +0300, Dan Carpenter wrote:
> This code is trying to ensure that only the flags specified in the list
> are allowed.  The problem is that ucmd->rx_hash_fields_mask is a u64 and
> the flags are an enum which is treated as a u32 in this context.  That
> means the test doesn't check whether the highest 32 bits are zero.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx4: Make check for invalid flags stricter
      https://git.kernel.org/rdma/rdma/c/d64b1ee12a1680

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
