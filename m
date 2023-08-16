Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587D377DA73
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 08:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbjHPG2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 02:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbjHPG1h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 02:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593C1BF8
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 23:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 881BA6259F
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 06:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F36C433C8;
        Wed, 16 Aug 2023 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692167254;
        bh=1anVmRyMhMC0EutYW4Z4WqbAJz3ZsOrnFEbV4BK1juU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N5Jml6JACa2fAgzoLvvGSXtjLD9T5AhIlMmJeGt5nRL1JtfyQjK2KWG6131ePsYSl
         WAbSR0CcPSWXYCNRgmCYyLwTpm03T2X+AKTvG4uUBxXH7VYSUwXjJnucUt4IZO58Tt
         Ivh1edxylHZm2ytb5abhhAIiWkzDgobxFUSgdHqL19eguAqzeDLWPn5sA7baa2mx9a
         vj3j0jKBcuJHoT67E9GoBCYXB9nbLqNu4qbbZXe4olZXSLOFc3nFsaONBQs+HavsR7
         LBPO6kv8+5Lzvc7yD4oavrfaW9jrWgADI7ItQSJGql8uB2Iw3XkHGDQOrqdrSDMGv2
         W+Zzc2EXqzedQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     kernel test robot <lkp@intel.com>
In-Reply-To: <20230816001209.1721-1-shiraz.saleem@intel.com>
References: <20230816001209.1721-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH v1 for-next] RDMA/irdma: Drop unused kernel push code
Message-Id: <169216725039.1858989.11211287800822794617.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 09:27:30 +0300
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


On Tue, 15 Aug 2023 19:12:09 -0500, Shiraz Saleem wrote:
> The driver has code blocks for kernel push WQEs but does not
> map the doorbell page rendering this mode non functional [1]
> 
> Remove code associated with this feature from the kernel fast
> path as there is currently no plan of record to support this.
> 
> This also address a sparse issue reported by lkp.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Drop unused kernel push code
      https://git.kernel.org/rdma/rdma/c/295c95aa7e0310

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
