Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3650A641D3A
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Dec 2022 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLDN2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Dec 2022 08:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDN2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Dec 2022 08:28:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2FDBE22;
        Sun,  4 Dec 2022 05:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2C39B80959;
        Sun,  4 Dec 2022 13:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E1C433D6;
        Sun,  4 Dec 2022 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670160497;
        bh=sOYEp5Ei/+BdkhfqzNNGOm8GZMHjSqANOKeZ8LDfjm8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YBNyI16lXT9BtdEfOqfUB/xTrknCNxflFdK1OnVJyFTWd2XjLeoHhvhNIDeq/h5UY
         9Ixi0LEJUSEzfmM1n7Hbc5ZUJJ+BkCtewwvZreoVMCLvNECVFbAJIKcx6JNtJV2jho
         j90R9XrkFQrWWbY3fqjdL8i28SArxanGOXWMgfKy+yaFtkTxk1dj7NRUeRJo0rbOx5
         uexnUtWNPZWxCZDLpmdYAL4A1SecJGJCnZL32DFXDYHMSPYEZZ1VCao7+4qA1JDaTX
         m2fNv1HhttEjlLhfXEv2h0+XoxWvbfAqEoMlGEWZlrEyctKV7pT3D4AZezFT8Iicpr
         pRBuZL6tuRckQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     bvanassche@acm.org, Wang Yufen <wangyufen@huawei.com>,
        jgg@ziepe.ca, dennis.dalessandro@cornelisnetworks.com
Cc:     easwar.hariharan@intel.com, andriy.shevchenko@linux.intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1669953638-11747-1-git-send-email-wangyufen@huawei.com>
References: <1669953638-11747-1-git-send-email-wangyufen@huawei.com>
Subject: Re: [PATCH v5 1/2] RDMA/hfi1: Fix error return code in parse_platform_config()
Message-Id: <167016049288.37008.2194616492987528748.b4-ty@kernel.org>
Date:   Sun, 04 Dec 2022 15:28:12 +0200
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

On Fri, 2 Dec 2022 12:00:37 +0800, Wang Yufen wrote:
> In the previous iteration of the while loop, the "ret" may have been
> assigned a value of 0, so the error return code -EINVAL may have been
> incorrectly set to 0. To fix set valid return code before calling to
> goto.
> 
> 

Applied, thanks!

[1/2] RDMA/hfi1: Fix error return code in parse_platform_config()
      https://git.kernel.org/rdma/rdma/c/725349f8ba1e78
[2/2] RDMA/srp: Fix error return code in srp_parse_options()
      https://git.kernel.org/rdma/rdma/c/ed461b30b22c8f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
