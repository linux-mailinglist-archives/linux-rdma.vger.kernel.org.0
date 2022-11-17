Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B662D9D6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 12:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKQLt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 06:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiKQLtz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 06:49:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DC1F63A
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 03:49:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C6D611DD
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 11:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13881C433D7;
        Thu, 17 Nov 2022 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685793;
        bh=o2dk0E6yZS+MZezQY//uuy2jI5fE/gjDUMqbWdub30w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LTtkhsTXOfbCifPU+ZrbV/DlDU1Xp62ARyOMELeWHOLnDTokeuIUQkjqt9qWKcAJG
         8bmVYuIIaR+OG8M9u7vlyoxlsQnsR5NtDaDcrmm+0f+r/4CogqI1VXQAcBQxgmub5c
         R9NFBD+mZMkiaj7qks/TBXVjfq4RPY+l0lVoguBV+hgur+mB9/Qjx/gGf0+jdZn0tr
         RGvrov8aLw4JZ44nH5/Z9U/8PrQk3cz5dnjulydqpVyVObqXsc83M7VeCmen4XySRg
         6eL0j94t1To1423tBFbzvPAfxRaWZaOHLxlt47r/UdO/c1WfwsjaKUaljKga8zfrll
         8fa/SJJY3Deew==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20221117101945.6317-1-guoqing.jiang@linux.dev>
References: <20221117101945.6317-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 0/8] Misc patches for rtrs
Message-Id: <166868578922.619010.15883088127604561792.b4-ty@kernel.org>
Date:   Thu, 17 Nov 2022 13:49:49 +0200
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

On Thu, 17 Nov 2022 18:19:37 +0800, Guoqing Jiang wrote:
> This V2 version only fix some typos in headers
> and add collect more tags from Jinpu, so all
> the patches have been reviewed, thanks you!
> 
> Thanks,
> Guoqing
> 
> [...]

Applied, thanks!

[1/8] RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
      https://git.kernel.org/rdma/rdma/c/d7115727e32e94
[2/8] RDMA/rtrs-srv: Refactor the handling of failure case in map_cont_bufs
      https://git.kernel.org/rdma/rdma/c/0f597ac618d04b
[3/8] RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
      https://git.kernel.org/rdma/rdma/c/102d2f70ec0999
[4/8] RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
      https://git.kernel.org/rdma/rdma/c/f5708e6699c230
[5/8] RDMA/rtrs-srv: Remove outdated comments from create_con
      https://git.kernel.org/rdma/rdma/c/a4399563356c86
[6/8] RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
      https://git.kernel.org/rdma/rdma/c/7526198f271072
[7/8] RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files
      https://git.kernel.org/rdma/rdma/c/6af4609c18b3aa
[8/8] RDMA/rtrs-srv: Remove kobject_del from rtrs_srv_destroy_once_sysfs_root_folders
      https://git.kernel.org/rdma/rdma/c/34a046f08b62fb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
