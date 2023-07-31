Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1375769082
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGaIlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGaIkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 04:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2907819AF
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 01:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B1F60F89
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 08:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A519FC433C8;
        Mon, 31 Jul 2023 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690792734;
        bh=ICZtcC5bdWSBD/1GDv+N9Ckg1/zM9qTmFBBeywGa/6k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JrSeoV2dznZ52Tlsyb2ODht2oYngMvcGGk5RlfE6aeZAdo7Jbc8Y2e9/xepiUemFp
         s4lIS5ozCE1XnUoYwKqkjtxEZmDXtWOW+Hy2c9R6jEEM7wQH0CJY1gW4KaqU/54PwE
         PIST6f3eK2ihsl5xlu9oIgUZtqhqi61h2Oi2eCrxa5IFvryh85UwmGcA8rJKAZTmuo
         9EpNnvdZesrR6XOfjgjgk32ngK+jlaBtCmoDzjfLFbrY2xRkwI6mxXUrdO0L8O4RDn
         pyyr3CeXHCcqAc/QzLQuItvlPqPZ78IJqVDWlB7u0sMyT6mr5PoZT6X6qp4H/dDpT/
         /waeqfxr/nPaQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        Artemy Kovalyov <artemyko@nvidia.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: <3d4be7ca2155bf239dd8c00a2d25974a92c26ab8.1689757344.git.leon@kernel.org>
References: <3d4be7ca2155bf239dd8c00a2d25974a92c26ab8.1689757344.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/umem: Set iova in ODP flow
Message-Id: <169079273064.133047.14402153952248673801.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 11:38:50 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 19 Jul 2023 12:02:41 +0300, Leon Romanovsky wrote:
> Fixing the ODP registration flow to set the iova correctly.
> The calculation in ib_umem_num_dma_blocks() function assumes the iova of
> the umem is set correctly.
> 
> When iova is not set, the calculation in ib_umem_num_dma_blocks() is
> equivalent to length/page_size, which is true only when memory is aligned.
> For unaligned memory, iova must be set for the ALIGN() in the
> ib_umem_num_dma_blocks() to take effect and return a correct value.
> 
> [...]

Applied, thanks!

[1/1] RDMA/umem: Set iova in ODP flow
      https://git.kernel.org/rdma/rdma/c/186b169cf1e4be

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
