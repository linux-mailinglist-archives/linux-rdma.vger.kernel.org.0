Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87B26CD822
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjC2LFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC2LE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 07:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6174C01;
        Wed, 29 Mar 2023 04:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8300961C64;
        Wed, 29 Mar 2023 11:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C7CC433EF;
        Wed, 29 Mar 2023 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680087862;
        bh=Gw9O6ZaC36eb6d88mB4jNAovDbOA35ixW3ce0NWIAKc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MMMsvWic7lux1PGqaZjU7nNOa5tbBY2YeWUypzShlfe+O7rJTWNTai6r9yKvOZIZe
         NsYiUBaL2/FFhqKlEKX80DYuncdqmM0i/pG/afHa5y8qaE9Uesdy29LKQ2RBvqLwIW
         Yn2qmOJkCmHhP/DXXLmSghNcHKuftc5PwLDwqkjpntCs+E29gT9eeEV1PAqvaYvv8k
         v/hEjBPhS+YFJ1EFSF4J0V25xoOtucCXTarlKPiAiv5h/LEbF+p1jfMC04ljiNEa3/
         rrTd/4TfdM4sX8De6qiUeak2ozHl7hzWwLh+pXx+JAzqlMZ7vjAIcDtzVUS9AVVWhL
         hLjhekCaIHKGg==
From:   Leon Romanovsky <leon@kernel.org>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com, Tom Rix <trix@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230325140559.1336056-1-trix@redhat.com>
References: <20230325140559.1336056-1-trix@redhat.com>
Subject: Re: [PATCH] RDMA/bnxt_re: remove unused num_srqne_processed and
 num_cqne_processed variables
Message-Id: <168008785879.1076930.16938112248605767834.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 14:04:18 +0300
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


On Sat, 25 Mar 2023 10:05:59 -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:303:6: error: variable
>   'num_srqne_processed' set but not used [-Werror,-Wunused-but-set-variable]
>         int num_srqne_processed = 0;
>             ^
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:304:6: error: variable
>   'num_cqne_processed' set but not used [-Werror,-Wunused-but-set-variable]
>         int num_cqne_processed = 0;
>             ^
> These variables are not used so remove them.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: remove unused num_srqne_processed and num_cqne_processed variables
      https://git.kernel.org/rdma/rdma/c/1b69f1e3d7449d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
