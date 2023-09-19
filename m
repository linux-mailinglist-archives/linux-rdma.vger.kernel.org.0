Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3487A5DEF
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjISJaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjISJay (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 05:30:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66096EC
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 02:30:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42743C433C8;
        Tue, 19 Sep 2023 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695115848;
        bh=GICM30NyoOiuhUF/P/2Ms7K83NSCZEgrBSs50QFZ0IE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TRRC3d8Cpk4FS8+f6VfaZV0bhvOyLxFrn3cvbzCqh2G1xjzBganjjOS9GQ3yUDT2C
         4CvTzvP77/Dgh5gQPiiJeJXeU42ImGxeIDNZzuUXt5f3fvqKZhxPBNQK0+Itjy0avF
         4Kq1/xcxdfrk7XPduLGER/f98ZH7Bq0ZfPdVBL7tfrmW+cYTh1cdCCRnkeNW5RMkLi
         G4BoNYSszjzpFS0VHFRbZppMN1lVQGMBz/djnOb+M3tz1d+E6lwQaoWEcHPQ/ajH9c
         TrK47uf8ekvLjINzyjBXH36NZhveXOD2fCJ5x/1lAn3/YbuzTW0bITiOrxxkOU2Nuw
         l6EqdPSWugo2Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230919020806.534183-1-yanjun.zhu@intel.com>
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not initialized fully
Message-Id: <169511584482.89993.7975984584733665971.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 12:30:44 +0300
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


On Tue, 19 Sep 2023 10:08:06 +0800, Zhu Yanjun wrote:
> No functionality change. The variable which is not initialized fully
> will introduce potential risks.
> 
> 

Applied, thanks!

[1/1] RDMA/rtrs: Fix the problem of variable not initialized fully
      https://git.kernel.org/rdma/rdma/c/c5930a1aa08aaf

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
