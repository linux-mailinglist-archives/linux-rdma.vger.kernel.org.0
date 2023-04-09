Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D76DBF64
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjDIJ7Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIJ7Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 05:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88F40E2;
        Sun,  9 Apr 2023 02:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2BA601BE;
        Sun,  9 Apr 2023 09:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDC4C433D2;
        Sun,  9 Apr 2023 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681034354;
        bh=QmmQZdyjYCnNGuNTcKRnoJE/jVdQdVNviwZvG55h2Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJicAWxL6JCHkBqEmC6nykPChOjUKu/hDMd9rLBf1O5+ByNu7F5XL679NjFJpceBi
         UYo5sMr4g9ci4Xl/kr4TaHZFv3V2mdhq1LrWTyljU3sStjdDU8frBg9ZuZKWAkVAfm
         cXLrh0IduBoaiuWTfJ1m/LBEUv7TI2/DKxnUt//m8nFzgkLvNOOU/rWurhiebZbIGx
         7b0B9SMJjZ4f+Dde8HM44Fiqfx7fHl8MtyhMGbVQGL1k+owPxazEjozpJDLJzhjHYk
         q6wQ1gMUswoHFxWmM59PFGRDvxFZ+zK3tbYDlhbMHrc9ANsP1k5Mn4cPg4CW8pkgbe
         iQKVonAy1hH3Q==
Date:   Sun, 9 Apr 2023 12:59:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matan Barak <matanb@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] IB/uverbs: Adjustments for create_qp()
Message-ID: <20230409095910.GG14869@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <01af2ec9-4758-1fe6-0d74-b30b95c3e9a5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01af2ec9-4758-1fe6-0d74-b30b95c3e9a5@web.de>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 06, 2023 at 06:10:14PM +0200, Markus Elfring wrote:
> Date: Thu, 6 Apr 2023 17:50:05 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Improve exception handling
>   Delete a duplicate check

Like I said it before,
NACK to any RDMA patches from you.

To make it very clear, if you send any patches to RDMA, please add the
following line:

Nacked-by Leon Romanovsky <leon@kernel.org>

Thanks
