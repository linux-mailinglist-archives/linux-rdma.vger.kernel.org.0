Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB585603A38
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJSG7J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSG7I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 02:59:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4827548B;
        Tue, 18 Oct 2022 23:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 602D6B82248;
        Wed, 19 Oct 2022 06:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCBC433C1;
        Wed, 19 Oct 2022 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666162745;
        bh=zkHbNMMe/H8kbcI+ewovSQpXvA8zcSql7+69m3QFUZM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=khYrR1424vTYIs02ea1r5p0GfrkLJf3AbeRrgK3wq+91u3LLY5bKh40UuP+7EMK3O
         EkipOB77BlH61oQJFd+E4w6ADzTSXwICQn+lvPv1sWIk74AQTdm53n+xibbIFrzo2T
         NZYhIfvBqhUUPIopeOef1jS9m3pUAD1CYVAVWzvZJDpnEjGK+3pHhhPOSxpw1YS0eh
         4EEr11vOrbLh0t3uHjHYLrOReX1wpJYr1HbiiXwIYlrB889TWVkjPXNlumIMIkCZI3
         kxs2PJ75xqw3fwgGOPCiWw3zxbAJTflHvoe15Vr4xPz3HOqaTAUFBqgZ69H85f1O4Z
         8cPdsy9UI3W/Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20221001020045.8324-1-lizhijian@fujitsu.com>
References: <20221001020045.8324-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next] RDMA: return -EOPNOSUPP for ODP unsupported device
Message-Id: <166616274049.238391.4392133358524096226.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 09:59:00 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 1 Oct 2022 10:00:45 +0800, Li Zhijian wrote:
> ib_reg_mr(3) which is used to register a MR with specific access flags
> for specific HCA will set errno when something go wrong.
> So, here we should return the specific -EOPNOTSUPP when the being
> requested ODP access flag is unspported by the HCA(such as RXE).
> 
> 

Applied, thanks!

[1/1] RDMA: return -EOPNOSUPP for ODP unsupported device
      https://git.kernel.org/rdma/rdma/c/0154331c318907

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
