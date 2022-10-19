Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB229603A3B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 09:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJSG7M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 02:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJSG7L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 02:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8901A74E34;
        Tue, 18 Oct 2022 23:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2408C61780;
        Wed, 19 Oct 2022 06:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC3CC433C1;
        Wed, 19 Oct 2022 06:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666162749;
        bh=OfVW4QnOh93RwF/s/KLpFrhT6CiZCgqwx9xOE292feg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rAxDA2Kq9vo5Ivl04DGNgDlP0Zey2E1LKgbu/w6gE96YKH7RJWNc5qXJF3opHDZEu
         Ptm3QqboS+4rp8tupRa3cGv4yvHrEuyiywQ0a+G6JIj9PZ720RjCTTGiVt7474ruU4
         g+ekTaMXinOKdGtri61SHBakQ75TAxGW47jH8D2UG4Nh0L80qkvC7R2lkHaDR0LvSk
         bQ+11+wIx4fwOGo+9RHK7evAO7nrSje5NJt24evlpmQGAA1tPObSs641WbEfTHBkoJ
         GM9C4qXtyN7RnWRRGs0sVH3UQYZC1RUfRJEBukeN7V/f8JuwtpM4lpc/CmVpI7H1CW
         hKhO7eOnNyAMA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiangshan Yi <13667453960@163.com>, jgg@ziepe.ca
Cc:     Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221009081047.2643471-1-13667453960@163.com>
References: <20221009081047.2643471-1-13667453960@163.com>
Subject: Re: [PATCH] include/rdma/opa_vnic.h: fix spelling typo in comment
Message-Id: <166616274559.238391.7371433630937415786.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 09:59:05 +0300
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

On Sun, 9 Oct 2022 16:10:47 +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> 

Applied, thanks!

[1/1] include/rdma/opa_vnic.h: fix spelling typo in comment
      https://git.kernel.org/rdma/rdma/c/fac12d9d4d3577

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
