Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B295760A1D6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJXLeX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJXLeF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 07:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619326706F;
        Mon, 24 Oct 2022 04:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B79061253;
        Mon, 24 Oct 2022 11:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD4CC433D6;
        Mon, 24 Oct 2022 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611170;
        bh=EkBkVpQtB/kZdOQ1nJKGX43C3dc/bTxKkYkyohDcZ/o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tvbIDxdrn8HHp4/NQKMkiQWJ0IP3+CcRVfuWNxVXU4+jowZPkGZDxi2824j5JhnwQ
         jgSH5ji30+thUimi8QhgUsVv2RA+gNU1rfdcb4SKpcNRJ9D1+VyypCXU11XpSDWGnB
         wpIcKjqHeoy4TKG++cJhVOsJzFUTi29PSyaG/S70iW0+fFK24nKmfjSm2ETHA/zKQr
         0IiJT5oJUb6wlqnG7GOhcsHE5hj9qI6dSDH2291Cz/w68FHHGSai+z25wdyyoalpI7
         UkO+KkmKvH+A2LQv5Ks76DUcgLC0XRJGlubZrSgXmmoQu/THsW0+XhEj01SpvPk9ly
         CnpPXhN8NAyLg==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221021172611.26763-1-colin.i.king@gmail.com>
References: <20221021172611.26763-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] RDMA/hw/qib/qib_tx: Remove variable n
Message-Id: <166661116602.858492.5242965082224048261.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 14:32:46 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 21 Oct 2022 18:26:11 +0100, Colin Ian King wrote:
> The variable n being incremented but it is never referenced,
> it is redundant and can be removed.
> 
> 

Applied, thanks!

[1/1] RDMA/hw/qib/qib_tx: Remove variable n
      https://git.kernel.org/rdma/rdma/c/d0b9f28f0da280

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
