Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE83784418
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbjHVO1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjHVO1h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F360FB;
        Tue, 22 Aug 2023 07:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3596265910;
        Tue, 22 Aug 2023 14:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A82AC433C9;
        Tue, 22 Aug 2023 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714455;
        bh=QZSUoPCgcLxeWjkj2eOMQVMDZITD5UA9cVOOEyzbt+Y=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nK2upDBRIiRJgJXuslULpDaYj1ySOe/SdhWD9rkm7hVoBZVHhFLWqs5DD69D5e09f
         iMU6OoJxusSwrPp92HsT9De1PT7f5U1zOiFVuhwBPntjI+t1Di8Ng1SGLORWi+hZrs
         GadNdD+tl5x723CpMhz5fkqs5jzOLB8D5fBKBTWYx1xcbY+hFrZZDHJT5B1OjisTf6
         pCRts9uSmnmXiAnaJr5HZAz+dgiaH5ujcXwhudV0jnqko2Ie1kCS7kq5xNkvlzjqmX
         R1/ah+PTvnnxlYvjTPUf5sgY0RVeugmIbdvtL2nNMplOq2jMY2zxH0c7Me7kB27IZd
         WDVhIMlx+yQhg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rohit Chavan <roheetchavan@gmail.com>
In-Reply-To: <20230822120451.8215-1-roheetchavan@gmail.com>
References: <20230822120451.8215-1-roheetchavan@gmail.com>
Subject: Re: [PATCH] RDMA/mlx5: Fix trailing */ formatting in block comment
Message-Id: <169271445172.40133.1713604810471374671.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:27:31 +0300
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


On Tue, 22 Aug 2023 17:34:51 +0530, Rohit Chavan wrote:
> Resolved a formatting issue where the trailing */ in a block comment
> was placed on a same line instead of separate line.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Fix trailing */ formatting in block comment
      https://git.kernel.org/rdma/rdma/c/d3c2245754220b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
