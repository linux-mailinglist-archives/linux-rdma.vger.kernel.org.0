Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD5F7508CF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGLMy6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGLMy5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BBD1739
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 05:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2348617AD
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 12:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFDEC433C7;
        Wed, 12 Jul 2023 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689166496;
        bh=ntV84H8mgAN/Ofhw2ZStbUSlFn6ASZfut5kt5PYIWsI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WZDdzHvjsD2+hj0XNtl4YcULq2+jy8k4dIuQUSkEVYvMx6VFDZg/BLWAtekaGDCaC
         mW8f3eEJwRXKIzdsqbI5w91xE0qw19TNbc7haRN4j03mq5nTUot0mxZs4m8ROFC7kH
         h0mhhAhH/dIS4p28YKKpEb9RGJEcSsZRRLas1dUzx+q3YEcTDxVFmPn5gZRvbMK9up
         WjZ4QTT3XGqDs9yqXmG63mmhqmN4W8uuc9cpf3ms8rTpnPd7FCA3RC7ZYzJrcsAoaA
         mSbGrNVBXB69/FTBWk+XqHwHtk+/GYbKIcbUE5jYK61X19eOb2pMuI000JBF7Q86qF
         G4Jdc7YIJvjsQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>
In-Reply-To: <20230711175318.1301-1-shiraz.saleem@intel.com>
References: <20230711175318.1301-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v2] RDMA/irdma: Implement egress VLAN priority
Message-Id: <168916649246.1237854.8517834798507947635.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:54:52 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 11 Jul 2023 12:53:18 -0500, Shiraz Saleem wrote:
> When a VLAN interface is in use, get and use the VLAN
> egress mapping.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Implement egress VLAN priority
      https://git.kernel.org/rdma/rdma/c/f877f22ac1e9bf

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
