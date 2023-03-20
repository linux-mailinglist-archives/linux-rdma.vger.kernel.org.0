Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9096C0FE2
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 11:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCTK5p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCTK5O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 06:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2828E93
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 03:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E86B26137D
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 10:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC56FC4339B;
        Mon, 20 Mar 2023 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679309632;
        bh=PQb4vJReTxLsufR9xu2Zu96GlKoO8Refq00tWkgICyo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aIgM//UJtJhr1NXEVBfDCnGFJ+ZJijKIeKGk08iGHK8npdFShqDlIA8k3mXU55oy6
         BpQoRY0qi/bPvJ91EJgVjShC9J3DUi+zsQNdI6iYs7103/GxexcsjnRHGUyuLv/Ji/
         W5mN1g78FH1F1m2fuhtJcAh7Kj5lRzGWHz1ohW5YY8dZaKKs4WjuFotk+xMC1BXqKl
         9axEttTGsm0psGPnz0gfXspfsEtS2fFlStTRp27MHZrOHnNQ++Hoshkd+f0laxbx7v
         DY16QkyILTBuDPOF6CCY21D0/c4bhMR+80qBxAQ81KTpla10NoqMsKOL3TD9rOytBm
         ozymd0JRVezMw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20230320084652.16807-1-chengyou@linux.alibaba.com>
References: <20230320084652.16807-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-rc 0/4] RDMA/erdma: erdma fixes 3-20-2023
Message-Id: <167930962831.1017786.5586100850191984134.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 12:53:48 +0200
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


On Mon, 20 Mar 2023 16:46:48 +0800, Cheng Xu wrote:
> Though there is an ongoing patch waiting Jason to take a look, this
> series with small changes may be accepted with less discussion. So I
> submit them first.
> 
> This series has some fixes for erdma driver:
> - #1 fixes some typos.
> - #2 updates the default EQ depth and max_send_wr for SQ.
> - #3 inlines 4 mtt entries for FRMR to achieve the HW limitation.
> - #4 defers probing flow if netdevice does not exist temporarily.
> 
> [...]

Applied, thanks!

[1/4] RDMA/erdma: Fix some typos
      https://git.kernel.org/rdma/rdma/c/3fe26c0493e4c2
[2/4] RDMA/erdma: Update default EQ depth to 4096 and max_send_wr to 8192
      https://git.kernel.org/rdma/rdma/c/6256aa9ae955d1
[3/4] RDMA/erdma: Inline mtt entries into WQE if supported
      https://git.kernel.org/rdma/rdma/c/0dd83a4d775671
[4/4] RDMA/erdma: Defer probing if netdevice can not be found
      https://git.kernel.org/rdma/rdma/c/6bd1bca858f173

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
