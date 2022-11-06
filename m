Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2A61E554
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Nov 2022 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKFSg4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Nov 2022 13:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKFSgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Nov 2022 13:36:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1C7FAE1;
        Sun,  6 Nov 2022 10:36:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 170B5B80C93;
        Sun,  6 Nov 2022 18:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A69BC433C1;
        Sun,  6 Nov 2022 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667759811;
        bh=iaXMsaT6N/esst59h7+2aRkkMyeFognZ0/KjhwSM5As=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cJO/LwFhmFn6QMKC2/2Suw9rnTPk5EHd0XzEsJt9acwNzf1tcd41AR9upsw6Mtjbx
         hHiiCf3du/YoLoehrm7lSqlwQ2SYLneNO7DLbp1Pdi28+xhaFlxMXn9kqvfjHI3CzT
         xhxiT1vFWVugbV7Z/p/LaLr0Jnvh/oYh5qw44+wMJ0Q6B1zXvo8Y6HKXJ9AU2L1Kjf
         xG7gt+sPaiY82cALeJTMuI7mBuiihoFx5PN135D4HCnUQ2aXGUWOHgoZLp71QDZsud
         tIj/qTikbprsXAlupzRUQR0wLTVrLcTLKaD/F051bkK4dWlFgBBDCYzU7lujNWvGIF
         1OAHE14F2jr9Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Arumugam Kolappan <aru.kolappan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
In-Reply-To: <1667287664-19377-1-git-send-email-aru.kolappan@oracle.com>
References: <1667287664-19377-1-git-send-email-aru.kolappan@oracle.com>
Subject: Re: [PATCH rdma-next v2] RDMA/mlx5: update debug log level for remote access error syndromes
Message-Id: <166775980729.499685.4215751686786264846.b4-ty@kernel.org>
Date:   Sun, 06 Nov 2022 20:36:47 +0200
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

On Tue, 1 Nov 2022 00:27:44 -0700, Arumugam Kolappan wrote:
> The mlx5 driver dumps the entire CQE buffer by default for few syndromes.
> Some syndromes are expected due to the application behavior [ex:
> MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR, MLX5_CQE_SYNDROME_REMOTE_OP_ERR and
> MLX5_CQE_SYNDROME_LOCAL_PROT_ERR]. Hence, for these syndromes, the patch
> converts the log level from KERN_WARNING to KERN_DEBUG. This enables the
> application to get the CQE buffer dump by changing to KERN_DEBUG level
> as and when needed.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: update debug log level for remote access error syndromes
      https://git.kernel.org/rdma/rdma/c/abef378c434e6f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
