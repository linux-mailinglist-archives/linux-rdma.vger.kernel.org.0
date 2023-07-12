Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939F75079F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGLMKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjGLMKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5DE5F
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 05:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595D7617A4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 12:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF6C433C8;
        Wed, 12 Jul 2023 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163832;
        bh=62ft4BulgBC+POJE8mHbXUYOhpId/Eo3YnY1aC1qGis=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ehwNgNklqDheJnxhkivDI+0tuCTZSO4azs3RQHrrH2MoqfS9DXM9Dt/QEb5ObN/rY
         2DJpov6aT3A/Nrtqy0Hfvtf4Ml1xQXib6BTi9Qa2SAZR6NxxvWRXA3zmzGfUopK9vk
         9iSh9vpEnxSKgKKjiXIUURwRHKCUTKJ9nYxeYTIF2MwKh3+bXeHkK4y223eR7R+3CA
         lrZMf76eXzatv4U/8+jmhhGOaieE3xWWZgqp8aY5xH1Hv2SOk+S/+k6P93NhP2AT9g
         Vw+2gZ4llsKbIU4CwFbnzlTqImKfDGHAK4ecBypeH9cPPk6tpzDasvV2Q1H9F9f433
         UWDtXjwHcclsw==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Margolin <mrgolin@amazon.com>
Cc:     sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yonatan Nachum <ynachum@amazon.com>
In-Reply-To: <20230703153404.30877-1-mrgolin@amazon.com>
References: <20230703153404.30877-1-mrgolin@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add RDMA write HW statistics counters
Message-Id: <168916382868.1207710.15405894941829689696.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:10:28 +0300
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


On Mon, 03 Jul 2023 15:34:04 +0000, Michael Margolin wrote:
> Update device API and request RDMA write counters if RDMA write is
> supported by device. Expose newly added counters through ib core
> counters mechanism.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Add RDMA write HW statistics counters
      https://git.kernel.org/rdma/rdma/c/113383eff3ff6f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
