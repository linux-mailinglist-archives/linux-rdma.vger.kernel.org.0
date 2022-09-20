Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4732C5BECBB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 20:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiITSYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiITSYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 14:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AFBF77
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 11:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90AA062C29
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A26C433D7;
        Tue, 20 Sep 2022 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698282;
        bh=oVKVCM6i07x5XIinlgxwxGWTwq0gtWlL7K1Ak3xWElo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d+vWeEVps/JN4Q+njR+90W8/3TvI+qclXbDN/Ion+HDlxD/6pYCpvTV7m51Xfv5Z5
         mloQWMjJvLBU8Qxy6rIqidX/TowfLS8PiR0nhiG5kk5wZDsnPs6VGnxl9//lJ3Ypb/
         ZBrYjItvgM9IAJ+F6uLEG31dSTWDRkBcA3NKYPuZZbaVFRxCgVozOqWJ67m2EHAlBA
         +rN4kNRquCuK7RvrYu0iTa/lyt1RqXIm3dvXKJCKwPzIytTw/2xqJbIzIo6KaeZDeP
         O5+cIY6cAj9snHoVwIUMd81LIImD7mxFPqFxVp+0+CCFCCiKMidABchTTaRrIkmCAj
         VgLezq+nR2Z1A==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Olga Kornievskaia <kolga@netapp.com>
In-Reply-To: <20220920082503.224189-1-bmt@zurich.ibm.com>
References: <20220920082503.224189-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Fix QP destroy to wait for all references dropped.
Message-Id: <166369827769.318280.4806860033247455281.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 21:24:37 +0300
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

On Tue, 20 Sep 2022 10:25:03 +0200, Bernard Metzler wrote:
> Delay QP destroy completion until all siw references to QP are
> dropped. The calling RDMA core will free QP structure after
> successful return from siw_qp_destroy() call, so siw must not
> hold any remaining reference to the QP upon return.
> A use-after-free was encountered in xfstest generic/460, while
> testing NFSoRDMA. Here, after a TCP connection drop by peer,
> the triggered siw_cm_work_handler got delayed until after
> QP destroy call, referencing a QP which has already freed.
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Fix QP destroy to wait for all references dropped.
      https://git.kernel.org/rdma/rdma/c/a3c278807a459e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
