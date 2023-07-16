Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D45754E98
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jul 2023 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGPMLo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPMLn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 08:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC610E
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 05:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B78C60C90
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 12:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A85C433C8;
        Sun, 16 Jul 2023 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689509501;
        bh=YWt74iQx4gMJPMXf8jWG0i7UBz0wRAzwYTQrrlPzMsw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UyGhTItf2vH4axfG6Kch5guXWPp0GDrSnIq/hWWqY5Fyby1s5y00zHNOLNgGUGgAu
         ZbqE4r+GQUL2TzBAyOKwfyaf7iPlavOzUqxfNgQ8kAFTn50D1YHcS0s8rKF/i2YdA6
         hUsTx8yS87Zv7Skj9wz7pwS/VtFlwfc6tZ63tAZkXK8u762ixnLXaIfSOkt12hVKQF
         aSr4+Q7+L2MP4C34KSo/KPNZLlhbWtfz9NWqz/8gMtPzXhXqZbZVktDbJfInLL00ng
         4gaO+nHknTVIX6PIaasItmiJeugcdG2FhO/89bJeQB9EYkFn+ThaOoCpDVJL0bqHZt
         p6DeRjhfZ4uIQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1689322969-25402-1-git-send-email-selvin.xavier@broadcom.com>
References: <1689322969-25402-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc 0/2] RDMA/bnxt_re: Bug fixes
Message-Id: <168950949774.241694.16699000186892753748.b4-ty@kernel.org>
Date:   Sun, 16 Jul 2023 15:11:37 +0300
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


On Fri, 14 Jul 2023 01:22:47 -0700, Selvin Xavier wrote:
> Includes two fixes for issues seen during load/unload stress tests.
> 
> Kashyap Desai (1):
>   RDMA/bnxt_re: Prevent handling any completions after qp destroy
> 
> Selvin Xavier (1):
>   bnxt_re: Fix hang during driver unload
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Prevent handling any completions after qp destroy
      https://git.kernel.org/rdma/rdma/c/ab939c8a3a1675
[2/2] bnxt_re: Fix hang during driver unload
      https://git.kernel.org/rdma/rdma/c/2c03afae5ff9b3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
