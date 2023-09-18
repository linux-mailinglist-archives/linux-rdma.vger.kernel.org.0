Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D27A4529
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjIRIwg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbjIRIwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 04:52:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65C10F
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 01:51:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F81C433C9;
        Mon, 18 Sep 2023 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695027119;
        bh=jFeTv27tmN5r/IZrnPsSq0VnDoigHk9wL5yUML/fed0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gXKISy+rxr/ploJ6Ow/6wRsGHjbNaMD5R6woOgqHLldwK3rhZ3V33+9Dsi29m2Qep
         2xnntsNOvBi3X7unTz3RhQhqfvYg9qhLsMQ9LaqdPYzFuaLY0DOtooUh1i4KRabwui
         DnoWz1NqZYzmHuh7EYSzHnXICZVR7SYAZqzErhReyfRcRDSLR850JxCkumB2JsVRlE
         h7muDTJahhWGWPP2UaIrYCp5D542JoyPWwjMUldDgAsLlNchoWPEegAPQGAgTDHn8B
         pVoZj/NJRH/bDbXLUTXv+BhB8LFspqm16P/9gd9UcqVg2SElk0crXE2e3T2OoKOP6D
         vjxYlGM+wtx1w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <a7e3b347ee134167fa6a3787c56ef231a04bc8c2.1694434639.git.leonro@nvidia.com>
References: <a7e3b347ee134167fa6a3787c56ef231a04bc8c2.1694434639.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix truncation compilation warning in
 make_cma_ports
Message-Id: <169502711547.89707.11371252791383743507.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 11:51:55 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 11 Sep 2023 15:18:06 +0300, Leon Romanovsky wrote:
> The following compilation error is false alarm as RDMA devices don't
> have such large amount of ports to actually cause to format truncation.
> 
> drivers/infiniband/core/cma_configfs.c: In function ‘make_cma_ports’:
> drivers/infiniband/core/cma_configfs.c:223:57: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>   223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
>       |                                                         ^
> drivers/infiniband/core/cma_configfs.c:223:17: note: ‘snprintf’ output between 2 and 11 bytes into a destination of size 10
>   223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:243: drivers/infiniband/core/cma_configfs.o] Error 1
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Fix truncation compilation warning in make_cma_ports
      https://git.kernel.org/rdma/rdma/c/0c6836da373dfb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
