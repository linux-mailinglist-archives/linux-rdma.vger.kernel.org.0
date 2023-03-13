Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D936B76EB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Mar 2023 12:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCMLzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Mar 2023 07:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMLyn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Mar 2023 07:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106D222F6;
        Mon, 13 Mar 2023 04:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB1F76120F;
        Mon, 13 Mar 2023 11:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC306C4339E;
        Mon, 13 Mar 2023 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678708395;
        bh=3WDft/n4GF5Rgs+mmbtLNtJHS3/y5nz6oKBVuZwpT7Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZOKLklV9ZtG6sbjfhUXgYyQib9co1D+cKzh/5FKq0GwGhwSKAjc8ioIAFPnCCoect
         VrK5zsOnA4WKPsy261rlQO+wLPi2HtnkaTV0CnSDmS/7myGpgrImE4/C/LVychdfIL
         UlHHasvQl6wfzIIJQtJXgogK6OqEvuOpRchGfatVfNY3arQfDnj/vcQzOQQp5yKaHu
         0/H/GQEZfgiQ+eMScWxRk3Ls6i8uJP3aDKz9AQq3X+vGSe/JxNEyoVmF/hbURbykaD
         jgwvIkTcYWtAZZjinkxrIwNBF1U1FCaT3CiBeuPVuQS/++FBnDLInEfuie+m5pKMBa
         UENu1J6foWE5g==
From:   Leon Romanovsky <leon@kernel.org>
To:     dennis.dalessandro@cornelisnetworks.com,
        void0red <void0red@gmail.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227100212.910820-1-void0red@gmail.com>
References: <20230227100212.910820-1-void0red@gmail.com>
Subject: Re: [PATCH] IB/hifi1: add a null check of kzalloc_node in
 hfi1_ipoib_txreq_init
Message-Id: <167870839218.138590.2128615459468695577.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 13:53:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 27 Feb 2023 18:02:12 +0800, void0red wrote:
> kzalloc_node may fails, check it and do the cleanup.
> 
> 

Applied, thanks!

[1/1] IB/hifi1: add a null check of kzalloc_node in hfi1_ipoib_txreq_init
      https://git.kernel.org/rdma/rdma/c/c874ad879c2f29

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
