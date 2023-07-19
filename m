Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6B758E7A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 09:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGSHOB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSHOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 03:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B977E43;
        Wed, 19 Jul 2023 00:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40AB612C9;
        Wed, 19 Jul 2023 07:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72670C433C8;
        Wed, 19 Jul 2023 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689750839;
        bh=wKMTdx6Rq19uLdNhU2xuF85dRnRfzVgD3FULIvhmTjs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LBEIFzPtSjmrwRUReqABzv9wl9O6sYg5edpu3HQcl0wunebsoFNMF78EEBrpCEkgv
         QbBUr3B+SbJ3oHz9aUh4gQ/iQ9aQOVFCCyxg8an2Zhb9rDcM+8YGVuyIchp9XZnQAS
         CYefFDmtWM6UzmJvVkPHWTFzI4M4AGKBBC2cvn7hxUTkhqD+irENkQkKRFigqCBQNv
         gLkC2Lrrsz3ncDqhK6jzLpJHtY0oh4tLsTMgr93HxqinvssDZC5ajUn3eM2XzzzOha
         17cMwecKsWHQypFAh8roD3+OkT23p7WyQqcc6EEqAkhQGG/HDjugQHrRXFs7meZi3y
         IDEn9nngtWUVg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sindhu Devale <sindhu.devale@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230718193835.3546684-1-arnd@kernel.org>
References: <20230718193835.3546684-1-arnd@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: fix building without IPv6
Message-Id: <168975083513.990259.11334065090312758176.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 10:13:55 +0300
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


On Tue, 18 Jul 2023 21:38:09 +0200, Arnd Bergmann wrote:
> The new irdma_iw_get_vlan_prio() function requires IPv6 support to build:
> 
> x86_64-linux-ld: drivers/infiniband/hw/irdma/cm.o: in function `irdma_iw_get_vlan_prio':
> cm.c:(.text+0x2832): undefined reference to `ipv6_chk_addr'
> 
> Add a compile-time check in the same way as elsewhere in this file to avoid
> this by conditionally leaving out the ipv6 specific bits.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: fix building without IPv6
      https://git.kernel.org/rdma/rdma/c/b3d2b014b259ba

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
