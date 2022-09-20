Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B35BE2F5
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiITKVG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITKU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 06:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544A659E0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 03:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E5062231
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 10:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF45C433D6;
        Tue, 20 Sep 2022 10:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663669256;
        bh=wCeXX4UvCpr2WGofIOaT5QfPEHJz6Sr7XBy6HG52Hwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUnERLtmDfpb0lrhnEl2MmFUtcit0+wVV9OsMfDwJla2lIvjeLrFUbKM6LZuTBaya
         Ue3qgh9SIuv5s5mVE/bVGoJKxkLFB/LNm6PVlwkhlGweDSpSVtVurnXoI9nAygl8pq
         iDB6FwJ38u4FQANZilCR7PgWrILc/5DMSoCIMNy6S29YoxmHLmi4BD8i1IoR20FMJJ
         OlHI3+vcq3e236GfKWRrdWcZ/O27MFug2EqzqlYcP/0yn8XfmtV1X20UkpghKDfx4y
         MrLREVE0PSRKn0kw2VctVZz01J/BkraBM645PPuDteBpKt3x1OZ1kats86sq/uUfli
         5MMNa+Irf/OSw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] irdma for-next updates 9-7-2022
Date:   Tue, 20 Sep 2022 13:20:43 +0300
Message-Id: <166366921631.95513.16702056670790966720.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907191324.1173-1-shiraz.saleem@intel.com>
References: <20220907191324.1173-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 7 Sep 2022 14:13:22 -0500, Shiraz Saleem wrote:
> This series adds udata inlen/outlen validation for the verb API's
> and fixes up completion error code reporting to ulp's.
> 
> Shiraz Saleem (1):
>   RDMA/irdma: Validate udata inlen and outlen
> 
> Sindhu-Devale (1):
>   RDMA/irdma: Align AE id codes to correct flush code and event
> 
> [...]

Applied, thanks!

[1/2] RDMA/irdma: Align AE id codes to correct flush code and event
      commit: 7f51a961f8c6b84752a48e950074a8c4a0808d91
[2/2] RDMA/irdma: Validate udata inlen and outlen
      commit: 34acb833cc83bdea912a160ff99b537e62bb4cf3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
