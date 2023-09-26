Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219707AE93E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjIZJaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjIZJaQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:30:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21DEB
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 02:30:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A988C433C7;
        Tue, 26 Sep 2023 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695720609;
        bh=UtA+wsigUc3f5UjpJdMN70XK9Zr4QqgGShC4CLgSbbs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tcc95ZQA5FWIwB0glCsvCTmWMHMFY7a0EKbEOyHovcXQKdezAS67EbwHAu3m92FGF
         iY+uluth8r+0cPhlIpOdD1kL7i8Jrc9Ket0w+xv1C7ORgwekmfEajpuw4oYvyIib3D
         ax1tMLEVZ/IxuBoS1hmcnIUkvob1GLSRp57mw61QJPdwjFF4kx/K6Ogc7q+vlGAw+B
         Q8VytxUjqxAWhL7vq4UOUKhKuSxq3N+7phPyoLj/zwQFYpvgzhzIkKlAkTL5Gs3awy
         lJoek1QWFNyZ7YSSc3StB59jAsywB0RddVXNsYPfYR7aTiQYK3oIb/MC5yy7a717mt
         Rzke/+wXjIk+g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1695203958.git.leonro@nvidia.com>
References: <cover.1695203958.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-rc 0/3] Batch of mlx5_ib fixes
Message-Id: <169572060499.2578714.17084293393659925252.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 12:30:04 +0300
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


On Wed, 20 Sep 2023 13:01:53 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This patchset is combination of various mlx5_ib fixes.
> 
> Thanks
> 
> [...]

Applied, thanks!

[1/3] RDMA/mlx5: Fix assigning access flags to cache mkeys
      https://git.kernel.org/rdma/rdma/c/4f14c6c0213e1d
[2/3] RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation
      https://git.kernel.org/rdma/rdma/c/2fad8f06a582cd
[3/3] RDMA/mlx5: Fix NULL string error
      https://git.kernel.org/rdma/rdma/c/dab994bcc609a1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
