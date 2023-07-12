Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FB375089A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjGLMqW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjGLMqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD91995
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 05:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25731617BD
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 12:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EBFC433C8;
        Wed, 12 Jul 2023 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689165976;
        bh=80fSw/vvGRbwEkz/ubmkFFoZeTQVogp/gTDy55dhf3w=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Fmhf8L7xdCdWG5EDLAcTmk+9pvUfiNP8krwNZ0LT90wXOuiJMLtNadfTZz6k3SPZC
         wPA++0F1E9XOX3cgD1MeH4VZCBhPS5Y95D3FQ+HcKphT4q0heOeE5qLYjdjcy42SLv
         WZ0HUKgsRxjBorKHrasDCKHqR+UrYb4eyH0d+VF2xVRu+wOdWVnboMrNdEBWVNJp6L
         KvejZ3r7PVJ3LWdmAWX61dskaa4RvwT9NvEYaMWAl+MswQuGVX3bf6mx8TWe0yhA8I
         zrjHvIVEz1iNMtHhv6dwv73skA0ghZqsTtR3tXoSUAMhn5bXBhjnFr6QH/dQCtATR7
         Go2XhvFCSwbmw==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
In-Reply-To: <20230711175253.1289-1-shiraz.saleem@intel.com>
References: <20230711175253.1289-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc 0/3] irdma KCSAN fixes
Message-Id: <168916597262.1232125.17373243742095411297.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:46:12 +0300
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


On Tue, 11 Jul 2023 12:52:50 -0500, Shiraz Saleem wrote:
> This series address missing read barriers and a couple
> of KCSAN reports on the irdma driver.
> 
> Shiraz Saleem (3):
>   RDMA/irdma: Add missing read barriers
>   RDMA/irdma: Fix data race on CQP completion stats
>   RDMA/irdma: Fix data race on CQP request done
> 
> [...]

Applied, thanks!

[1/3] RDMA/irdma: Add missing read barriers
      https://git.kernel.org/rdma/rdma/c/13120f2d08fd73
[2/3] RDMA/irdma: Fix data race on CQP completion stats
      https://git.kernel.org/rdma/rdma/c/df56ce725d7c61
[3/3] RDMA/irdma: Fix data race on CQP request done
      https://git.kernel.org/rdma/rdma/c/e77ac83ee5fd16

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
