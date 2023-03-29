Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5DF6CD824
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjC2LFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC2LFj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 07:05:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052746AC;
        Wed, 29 Mar 2023 04:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85EB7B82244;
        Wed, 29 Mar 2023 11:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6CCC433EF;
        Wed, 29 Mar 2023 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680087858;
        bh=E1W5dQwRJc5iBQxZu5QBFBSKcRmTwI7TzyhXlc8ZUeg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=giQJ2fA/3tWZ6/LWVxb2cS7yJs0MjROBx6/1hdJisvcJqJ6i/Tz3enVrlIiDFkYxs
         gtKel7KWnFbP8yDEx1uFGywGdd51mn2q7ZoTb/A1aEYIZDEtFW/w6qdb0T1zczPT0H
         F8ghBFZAnJMq8hzcqOGzuHVkXWy+AEQh0Bw6ztXM+5d1QRfvle8B/vd3TqlEyh27Nz
         Qo+WsBGNWpVoHPwPzozmgyJKK2PMMf5XDpqFAUTqLFlVL4sVk7ly7Me6hTCZ92uHyk
         yxPXQgGX3zLbpbwtDNbpQfRA4cJXuxMoHylasAd3silasugnQmzZHv3wvJi8qKpmZ8
         f/QjgWNuWPa1g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230323115742.13836-1-cai.huoqing@linux.dev>
References: <20230323115742.13836-1-cai.huoqing@linux.dev>
Subject: Re: [PATCH] RDMA/usnic: Remove redundant pci_clear_master
Message-Id: <168008785405.1076930.5923655020998036907.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 14:04:14 +0300
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


On Thu, 23 Mar 2023 19:57:42 +0800, Cai Huoqing wrote:
> Remove pci_clear_master to simplify the code,
> the bus-mastering is also cleared in do_pci_disable_device,
> like this:
> ./drivers/pci/pci.c:2197
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 	u16 pci_command;
> 
> [...]

Applied, thanks!

[1/1] RDMA/usnic: Remove redundant pci_clear_master
      https://git.kernel.org/rdma/rdma/c/fc36ce35e94585

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
