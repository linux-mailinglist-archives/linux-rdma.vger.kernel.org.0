Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA861EC8C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKGIB6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 03:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKGIB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 03:01:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487CB13EB6
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 00:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE759B80905
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160F9C433B5;
        Mon,  7 Nov 2022 08:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667808111;
        bh=0MyGFH+QXbj2BoXPjdwm1JDeCCMc2bg3czl7UxvwznI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dKqZrxJeIYEWLAeFf0SydfVCA6bf8rkUNahEc+yuWmHLQd/xb1bDxG+fa6e2CEXUm
         X7ZRSNpZp5HWIaXMGZlEH0lSjKlLW9Uahx3iBEtSWJnxpjrac1S5tIqhT2JSBe0Ud9
         odjy2jaaplyxtofsqnea4+4/8q6dffx52FW26pNc23/YlrOUBwJ6cIzR6ff9C4mtaM
         XrPYnNcYCHGepAUoNKn8Ocj6H486DoxtQhTh5Mw0yTeBfugwG/38Yrd+L5WopN7YrS
         t7JEFEUr2EpSpzjheWThA7IFGRHuLhfytISwVo06zIQz45diB7fAvcehk0Af2OaDOJ
         TCXYmRMi3UdrQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca
Cc:     KaiShen@linux.alibaba.com, linux-rdma@vger.kernel.org
In-Reply-To: <20221107021845.44598-1-chengyou@linux.alibaba.com>
References: <20221107021845.44598-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next v2 0/3] RDMA/erdma: Add atomic operations support
Message-Id: <166780810733.363768.7952798332685850401.b4-ty@kernel.org>
Date:   Mon, 07 Nov 2022 10:01:47 +0200
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

On Mon, 7 Nov 2022 10:18:42 +0800, Cheng Xu wrote:
> This series introcuces atomic operations support for erdma driver:
> - #1 extends access rights field in FRMR and REG MR commands to support
>   IB_ACCESS_REMOTE_ATOMIC.
> - #2 gets atomic capacity from hardware, and reports the cap to core.
> - #3 implements the IO-path of atomic WR processing.
> 
> v2:
> - Fix static analyzer check errors.
> 
> [...]

Applied, thanks!

[1/3] RDMA/erdma: Extend access right field of FRMR and REG MR to support atomic
      https://git.kernel.org/rdma/rdma/c/ece43fad220ba0
[2/3] RDMA/erdma: Report atomic capacity when hardware supports atomic feature
      https://git.kernel.org/rdma/rdma/c/71c6925f280ae8
[3/3] RDMA/erdma: Implement atomic operations support
      https://git.kernel.org/rdma/rdma/c/0ca9c2e2844aa2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
