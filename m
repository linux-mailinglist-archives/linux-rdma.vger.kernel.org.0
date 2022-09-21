Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350195BF7C3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIUHcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUHcq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 03:32:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C5E564EE
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 00:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46977B810F2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 07:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B47CC433C1;
        Wed, 21 Sep 2022 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663745562;
        bh=2COxTtMzRmLhFUEnmyoRmpH3nA5VHAXwTaUIyjy2tK4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dnhDCbLquUtR4aJcm6Ol0th2JEwA41be4SS+hcKQIJcQ18UZg+qZ/fQSY0ithx1qw
         T9fNEy4YLDMI1NVlmDaPw8yipt6mutg99HzCcioACWJVowp4J4AGKit2esryq+C/To
         xsg0VcjwHKM5v4Pnjw0w31HMKFIOFY9S0iRgytLKminE3cR3VcdeBfUYBFRzJSABS+
         jG+iIlIMJa3E7KpF/TQB2fnfINDRQQs56H3HwaYgH4G+3cinTqsBlEnDc8mj9oA32W
         q7ceXUFQhF8ZG1HsI0v0nZ87eP6r/HI/svNhbGZKICZISJ5H4SxzlDZBaWTv6cjQDl
         l7ESH2D1Lz+fw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc:     KaiShen@linux.alibaba.com, linux-rdma@vger.kernel.org
In-Reply-To: <20220909093822.33868-5-chengyou@linux.alibaba.com>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com> <20220909093822.33868-5-chengyou@linux.alibaba.com>
Subject: Re: (subset) [PATCH for-next 4/4] RDMA/erdma: Support dynamic mtu
Message-Id: <166374555855.382547.12933122276354334691.b4-ty@kernel.org>
Date:   Wed, 21 Sep 2022 10:32:38 +0300
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

On Fri, 9 Sep 2022 17:38:22 +0800, Cheng Xu wrote:
> Hardware now support jumbo frame for RDMA. So we introduce a new CMDQ
> message to support mtu change notification.
> 
> 

Applied, thanks!

[4/4] RDMA/erdma: Support dynamic mtu
      https://git.kernel.org/rdma/rdma/c/9bdb9350f3808b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
