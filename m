Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5560A6CE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJXMka (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiJXMiK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 08:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036478A1C4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 05:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B20CC612FB
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 12:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D8C433B5;
        Mon, 24 Oct 2022 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666613167;
        bh=+QIfaH9URJ62eloK4ZJUGwASquvqQ6KNof3pL+s42Bo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YC9D12DGQH2IM7PtgN9Me+p4TGqPS8s70NGxDEmHLUoJKHLmKop1eCPb0z32fsGvA
         ptDsr7U/rJj1UsbZh7/A+yYH5W7Zg15B8le/DMgnR+ojX5cJJZvVTuyqStjNFO/5JQ
         QZqZcDtAZI2KpUmFvawGhrwk3TG+EMhc9faKBBl+8q7Hfn2dJVtG7HO5YeKp+M+aq3
         nAbv/Fv9we57uQdp0tG3pknZhw02TLA8js0+mcRXJb/Kps1iqEq+zZSPkfjCbyx8c3
         TQ5R5I6ZGUNqpD+qrMn5szPYZ4IjhjCnYKk/BDIqyJgc+AcyyPhfvQcFxUD1dIGvPg
         nCgia/fItig9g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     liangwenpeng@huawei.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
In-Reply-To: <20221024083814.1089722-1-xuhaoyue1@hisilicon.com>
References: <20221024083814.1089722-1-xuhaoyue1@hisilicon.com>
Subject: Re: [PATCH for-rc 0/2] Two bugfixes
Message-Id: <166661316293.1125724.15671399753331108431.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 15:06:02 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 24 Oct 2022 16:38:12 +0800, Haoyue Xu wrote:
> The patchset includes:
> 1:The first patch resends the "Disable local invalidate operation."
> Add a detailed description for it.
> 2:The second patch fixes the kernel NULL pointer dereference problem in
> free_mr_init.
> 
> Yangyang Li (1):
>   RDMA/hns: Disable local invalidate operation
> 
> [...]

Applied, thanks!

[1/2] RDMA/hns: Disable local invalidate operation
      https://git.kernel.org/rdma/rdma/c/f164c01b38eb40
[2/2] RDMA/hns: Fix null pointer problem in free_mr_init
      https://git.kernel.org/rdma/rdma/c/45b2d30f069498

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
