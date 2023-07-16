Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46C754E76
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jul 2023 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGPLlv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 07:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPLlu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 07:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E7E59
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 04:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21ABF60C86
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 11:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07530C433C8;
        Sun, 16 Jul 2023 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689507708;
        bh=cMt07mZKlEx9Lsld9HwLHoLI+F+9EM1/GQgMRX56xkY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Be0ZjVUcJRVW5CVrCsl1n9dz7L3lDp5UJT1hG1wlmaKE/NTqaY962NCA6pEao0/Q2
         8sl2SQEy6atz3RHauORHOhLnROn/yKSgCjYmRyxx9X/ErxnQKogYI8xDEIOeJIPosi
         QiLIIa9xEVZm04hwlW/cbCv90S94flvRK5k5qRHzwbmvUeFPUQwtv7r/78CScGNLTp
         L5gufjtx15PaYhAtR5rHIH2CMtWKw5N/5G+03Y9GwaS/1O91hGJQCb2HZ4l2FaSSBY
         gVzV7sJA7VORCyXWwKy+EMlVkzSVcSXiNOP6DBpZJIii6kmbmXjXzg4oZ9PF2gZc+J
         84q3GzuyZPlMQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     phaddad@nvidia.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
In-Reply-To: <20230712234133.1343-1-shiraz.saleem@intel.com>
References: <20230712234133.1343-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc] RDMA/core: Update CMA destination address on
 rdma_resolve_addr
Message-Id: <168950770437.219939.5780521580399351530.b4-ty@kernel.org>
Date:   Sun, 16 Jul 2023 14:41:44 +0300
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


On Wed, 12 Jul 2023 18:41:33 -0500, Shiraz Saleem wrote:
> 8d037973d48c ("RDMA/core: Refactor rdma_bind_addr") intoduces as regression
> on irdma devices on certain tests which uses rdma CM, such as cmtime.
> 
> No connections can be established with the MAD QP experiences a fatal
> error on the active side.
> 
> The cma destination address is not updated with the dst_addr when ULP
> on active side calls rdma_bind_addr followed by rdma_resolve_addr.
> The id_priv state is 'bound' in resolve_prepare_src and update is skipped.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Update CMA destination address on rdma_resolve_addr
      https://git.kernel.org/rdma/rdma/c/21b09f979229d9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
