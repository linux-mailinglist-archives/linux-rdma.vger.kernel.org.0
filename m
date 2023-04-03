Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C106D503A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjDCSYe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjDCSYU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 14:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4F2139
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 11:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8843861D60
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 18:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E6C433EF;
        Mon,  3 Apr 2023 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546255;
        bh=xVdSkmRwWCUcKwh5KdgYw2n9b1pwrVIQQU+kg85Xwas=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QpJVeoNNmC3BrsnxVGy+qrOZB1EPQVA0zgSUsfUHEt/1q4Rlr91iksffMEeqAOG1r
         3Gk26+LYZWjsfpnCXpliM180Rk8SaTnkl3j39RZAP72TSSFzMVZcfok9VW/vh+m1qB
         MmJWHEfWvx2qh9adGUcSbWSHuIZkfOhKi1mIP8RrlznEWCBfRwBICFsRshhY/8SIra
         W6BnGoY1kEJbiM0WAKUR+c+SWUD7787kMVHK2umedhQb93ZTuaiHKGSdUkmiJQWxx4
         qX7Qp6E0DZHLy5e+z/6saPwv1m+GLk2trwTeyVH7F4tPE7XTfW7JOojsKVmBtwCTOc
         XADkgSyU9moSA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
In-Reply-To: <a44e9ac5-44e2-d575-9e30-02483cc7ffd1@I-love.SAKURA.ne.jp>
References: <a44e9ac5-44e2-d575-9e30-02483cc7ffd1@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] RDMA/siw: remove namespace check from siw_netdev_event()
Message-Id: <168054625063.6296.1666458353359218649.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 21:24:10 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sun, 02 Apr 2023 14:10:13 +0900, Tetsuo Handa wrote:
> syzbot is reporting that siw_netdev_event(NETDEV_UNREGISTER) cannot destroy
> siw_device created after unshare(CLONE_NEWNET) due to net namespace check.
> It seems that this check was by error there and should be removed.
> 
> 

Applied, thanks!

[1/1] RDMA/siw: remove namespace check from siw_netdev_event()
      https://git.kernel.org/rdma/rdma/c/3ffe884d48b7a9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
