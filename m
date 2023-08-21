Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45C7824AA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjHUHlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 03:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjHUHlH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 03:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A2B1
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 00:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74E4C62AD1
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 07:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53398C433C7;
        Mon, 21 Aug 2023 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692603664;
        bh=V0IrppgmVHhuCEPGpkkpR+Repj0ZUopx/fj5Zvs1B08=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nCGb6DfyyiQqalu7SaLDDXemjIebxo+z1l12fEjE7OYbPd7+c0ri7oSm3fw/n9hXm
         JbdHa4o7a2xx5yfOlY6fYYc9N3AotZ3YodPUaMZ8llPWw3mk1i02M+mwKpgXWZZbly
         hGPx5DPW+usvm8rBN6BQsS6j+L1ZsrULAqgEr3bmG5gIN5Xu31yk9G6IdDhyng7cQN
         EPOVAxxfCYiav1iLXtzo371tfTVrO7Rj4g5ONt9WVjQudHe+uzuqsT865xKHLcPOFQ
         uRXyxZmYYnEsB0ANfIzmmQlLqjHugvzLokvrRZ5R6GafIRPdCP0CHh9FL0w7nGXBxh
         yVHy3/MkG7svw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org, ivan.d.barrera@intel.com,
        Christopher Bednarz <christopher.n.bednarz@intel.com>
In-Reply-To: <20230818144838.1758-1-shiraz.saleem@intel.com>
References: <20230818144838.1758-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Prevent zero-length STAG registration
Message-Id: <169260366115.61271.8531136997205117019.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 10:41:01 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 18 Aug 2023 09:48:38 -0500, Shiraz Saleem wrote:
> Currently irdma allows zero-length STAGs to be programmed in HW during
> the kernel mode fast register flow. Zero-length MR or STAG registration
> disable HW memory length checks.
> 
> Improve gaps in bounds checking in irdma by preventing zero-length STAG or
> MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Prevent zero-length STAG registration
      https://git.kernel.org/rdma/rdma/c/bb6d73d9add68a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
