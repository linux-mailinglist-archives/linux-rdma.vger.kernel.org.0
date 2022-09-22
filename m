Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C019B5E6133
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIVLen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiIVLel (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 07:34:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928B13D11;
        Thu, 22 Sep 2022 04:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB6B5B835EF;
        Thu, 22 Sep 2022 11:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF18FC433D6;
        Thu, 22 Sep 2022 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663846475;
        bh=c7vYMoiCvtJhPZ8fwLFG0bDhq3eYN1MY5TU4XA8ujfk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CzCr8rs1nHLeMaFWYIWpLXJ9XO00Fb7YNUkP08aLzg71BkrwP3yyweHyrfX/4fHtF
         RzqwNpxszSeRzbdlfa8q60e2+HgcYhzlX3ODsr3DuyTpdXxwizeG9Kt4uoSJWggwq0
         F0mnykKRPbbT9c4ai7CinhY1NBw1ozD1du2IPkTyikh2wcLrtrjb7m/+5sc5+6MHff
         ENtXgpfc9wDfMsNZyHUyy75RZp/oTyuhitFM4NInP0Sc7j+dtVK39ztRpXH6fFU4XJ
         wOOAhBV7MOnL6Cs1l0MwJqyWZ0vjw++TNrpupaZ9MmovZWxtlcgKQL2IFNIPeDFaKR
         y6UWwowiNbwPg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yajun Deng <yajun.deng@linux.dev>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>
In-Reply-To: <YyxFe3Pm0uzRuBkQ@kili>
References: <YyxFe3Pm0uzRuBkQ@kili>
Subject: Re: [PATCH] RDMA/core: Clean up a variable name in ib_create_srq_user()
Message-Id: <166384647089.1039380.13021728777010279495.b4-ty@kernel.org>
Date:   Thu, 22 Sep 2022 14:34:30 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 22 Sep 2022 14:22:35 +0300, Dan Carpenter wrote:
> "&srq->pd->usecnt" and "&pd->usecnt" are different names for the same
> reference count.  Use "&pd->usecnt" consistently for both the increment
> and decrement.
> 
> 

Applied, thanks!

[1/1] RDMA/core: Clean up a variable name in ib_create_srq_user()
      https://git.kernel.org/rdma/rdma/c/b300729b77b0b7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
