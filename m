Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1556877AE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 09:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBBIjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 03:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjBBIji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 03:39:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874DF83052;
        Thu,  2 Feb 2023 00:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7FFC61920;
        Thu,  2 Feb 2023 08:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC60C4339B;
        Thu,  2 Feb 2023 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675327174;
        bh=w+LG5iu2OTZCGv8sKvoPSMJuh8GGxV5NutNULbkUb6Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jKn8yJ/ZtVxpTI0prdZm2ZsELNmfU1C8pB+9bCdxy6jmcMOKv3Y8VilQkd0zBKWAY
         eM2cjcRsSoGbRHklNOt8PbH7U0TvajUJuPhwY4irBW9GeOaWBx1MrqlKeFS3AORJfT
         HsNFV5KE1C28RbtfjVmOEkob+uZPWKlPmFWdgYQnxxpEopJTNYw8ABdZdcgiKYrGFs
         pRjAZqJG8czGrBih/HCbXg6kYYicVLg6tTX9Ga9BZloP1R0cekPTjIPfulGfbd0/An
         dw5RmoBcTvxzGmARNkHEs+6D4+A1DxihdKo/rfUL2MVWPK0+18CsDBDVuzpcUOmMWZ
         AJqSwVNW7FN2Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Long Li <longli@microsoft.com>, Dan Carpenter <error27@gmail.com>
Cc:     Ajay Sharma <sharmaajay@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dexuan Cui <decui@microsoft.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <Y8/3Vn8qx00kE9Kk@kili>
References: <Y8/3Vn8qx00kE9Kk@kili>
Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()
Message-Id: <167532717017.1954401.2294597501814507302.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 10:39:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 24 Jan 2023 18:20:54 +0300, Dan Carpenter wrote:
> The "port" comes from the user and if it is zero then the:
> 
> 	ndev = mc->ports[port - 1];
> 
> assignment does an out of bounds read.  I have changed the if
> statement to fix this and to mirror how it is done in
> mana_ib_create_qp_rss().
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()
      https://git.kernel.org/rdma/rdma/c/29419daf6c957f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
