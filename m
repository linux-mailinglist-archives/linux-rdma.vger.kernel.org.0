Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F237843ED
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjHVOXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjHVOXg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DDFB;
        Tue, 22 Aug 2023 07:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D27C658BC;
        Tue, 22 Aug 2023 14:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D43BC433C9;
        Tue, 22 Aug 2023 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714213;
        bh=DvmRTbc7FiFkB6N+0RgDXMx/7Pm2H0TTbTq5N8sv1Gs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Zn6XODWEilEuWyYjBd3ledFCKuaB5eQAlHx2xT2vbqpWf6YPA5uhAnXoPOq9C0bu2
         7QE9qUXFfpZvqqRh1XEhjnEGqGBZw2HDAJkS8UQVwPqb+CKkGT+Zqpc0Mazif9rqxc
         GJAZ9N/hau0OyZVDOwx94D+bVD5iewMPNZKyRqGTJEk05pRe/lYOMNuPUXTrztvJ+s
         n6HJxnyHI3qncdiQf5ampO3voHwlo8+gHLC3Ntu6TQqiZE7woAUOZafdBENyJI+ylS
         r86chX1F4+m2KzpleZ0wXJhusFAKUDkBnSLRYbwt1RVkjgdB9o+qV3U8Ig8vpaQH/N
         4QR0KnZg70GXA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Chavan <roheetchavan@gmail.com>
In-Reply-To: <20230822091304.7312-1-roheetchavan@gmail.com>
References: <20230822091304.7312-1-roheetchavan@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix redundant break statement in switch-case.
Message-Id: <169271420934.37184.9960349249889873256.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:23:29 +0300
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


On Tue, 22 Aug 2023 14:43:04 +0530, Rohit Chavan wrote:
> Removed unreachable break statement after return.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix redundant break statement in switch-case.
      https://git.kernel.org/rdma/rdma/c/6812e069990547

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
