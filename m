Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAF7F0638
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 13:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSM4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 07:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSM4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 07:56:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C7182;
        Sun, 19 Nov 2023 04:56:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EDFC433C8;
        Sun, 19 Nov 2023 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700398580;
        bh=io1dwRp0/JdWoYSldfHaA0c+QBcagHYXsszIKLN3DVQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hdhwuVcRA52pLKEeDKaAQifhiWBROIuyveT2sLiHGtQ/Q7yOincco29tsU3W4xLa2
         MFs4lqy8Uim9ZVfsJa0vx5GiO9sNVTOeIhgj3FivsuOlxqEN3XdPvljcRcYOKnfCSs
         7WnASVYaipjhXImxWJ973GYOIuCm5yLWKkMpQV8ptCO/CoxaI+WiTRMLvz4HtLgn8l
         03u95J60vwOqvEII7Q8V5+1FNbI/O0HJbgLW0f6fT2TPB7XoOqnMUcbrNB4QJQaUiP
         Tlcm88VY0ACgrjut1emKZvA+ta+Dy0G40dUFlUF4lLl2D0Kdno2/TM47Oaf1yLfHq0
         oiSXOS9UT1EQA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
References: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next 0/3] Support SW stats with debugfs
Message-Id: <170039857588.99710.1428151994236691489.b4-ty@kernel.org>
Date:   Sun, 19 Nov 2023 14:56:15 +0200
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


On Tue, 14 Nov 2023 20:34:46 +0800, Junxian Huang wrote:
> This patchset introduces hns debugfs and supports SW stats with it.
> 
> Junxian Huang (3):
>   RDMA/hns: Fix inappropriate err code for unsupported operations
>   RDMA/hns: Add debugfs to hns RoCE
>   RDMA/hns: Support SW stats with debugfs
> 
> [...]

Applied, thanks!

[1/3] RDMA/hns: Fix inappropriate err code for unsupported operations
      https://git.kernel.org/rdma/rdma/c/f45b83ad39f803
[2/3] RDMA/hns: Add debugfs to hns RoCE
      https://git.kernel.org/rdma/rdma/c/ca7ad04cd5d2f8
[3/3] RDMA/hns: Support SW stats with debugfs
      https://git.kernel.org/rdma/rdma/c/eb7854d63db543

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
