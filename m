Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357BE768516
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jul 2023 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjG3Lhh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3Lhh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 07:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB8198B
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 04:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FCEF60C17
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 11:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0472FC433C7;
        Sun, 30 Jul 2023 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690717055;
        bh=l7Wq/3lRNQlC8XMCwUIptTbG95gahShkIQvm2b8dK7E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ofZwmcOO9c+wiaed6VvMyzn/3fEtOZTGy8FdsTTaShIJuqxajZOr+9OiBs9oO4aTK
         J/L0n6kTznojwmikDahroGEkjsfUVGZji6+lDuIKih4vSFFd78EtAC+6ja2UzFEuiW
         z5I7rPIN8kgop4UW31FyE61jyD3RK/QkKOdrJ7eNJHQSNGUkhuzvW/h1GN1VihvSwU
         IyXE6EfJWxB+M6lzmOZqu2y9EmjDcj+1TDCF99Ijm6lIC7zaEDx/rPB+7sz07Y2A+M
         10ITrwReM49Sg9P5YbwgbEoU6chbhbIXPfwNg2Q26UiTDQOJBQliw7Tf9MneGieoau
         81PFY0zFuXn4A==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/4] RDMA/bnxt_re: Stats update
Message-Id: <169071705117.177499.169200519196403200.b4-ty@kernel.org>
Date:   Sun, 30 Jul 2023 14:37:31 +0300
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


On Wed, 26 Jul 2023 07:51:17 -0700, Selvin Xavier wrote:
> This series adds some of the missing hw statistics. Also, adds
> some debug stats maintained by the driver.
> 
> Please review an apply.
> 
> Thanks,
> Selvin
> 
> [...]

Applied, thanks!

[1/4] bnxt_re: Reorganize the resource stats
      https://git.kernel.org/rdma/rdma/c/063975feedb143
[2/4] bnxt_re: Update the hw counters for resource stats
      https://git.kernel.org/rdma/rdma/c/cb95709e0dca7a
[3/4] bnxt_re: Expose the missing hw counters
      https://git.kernel.org/rdma/rdma/c/4405baf85a83ed
[4/4] bnxt_re: Update the debug counters for doorbell pacing
      https://git.kernel.org/rdma/rdma/c/8b6573ff3420a2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
