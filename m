Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE16F52E4
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjECIOU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjECIOS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 04:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9863C3F
        for <linux-rdma@vger.kernel.org>; Wed,  3 May 2023 01:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A19DD62285
        for <linux-rdma@vger.kernel.org>; Wed,  3 May 2023 08:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87647C433EF;
        Wed,  3 May 2023 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683101655;
        bh=PgocR16vurr1QhmXXPLLZpOmwDEfWRJEk6ZdWJl7Hc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+S09KN61olIl26f2YIqG/tOGnu8tOdVkip4mz+xXfxkgL9iAFeCwh/MtJi8/n7WW
         SwBIHIRWrG7NhDAIrkFkoUb9Ct34zweK0X+nWIjtD8ZuWKUgIfKNZS8gnZTxD5F89e
         kwJaNhr33Orqof6HubbD3s6Nts0c0CCa/xPEdm994c975NmUqEKaoa0CwZ6xYxiZdX
         /mjH2X3/yt83aEZszE8Xk26vTPU57U8ZRsJ+6t0SM8lUvIRWdfn4EsjRdxwP42N1sO
         P/15yddprRUDCfa25YKn1mgU81pmNPw+6jdqe3LpMiuSRP8UuXMGqx/Md2qSenp8bZ
         IBr0FiTzmBG5Q==
Date:   Wed, 3 May 2023 11:14:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Changcheng Liu <changchengx.liu@outlook.com>
Cc:     saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] mlx5: correct reserved space offset display
Message-ID: <20230503081410.GF525452@unreal>
References: <OS3P286MB1640832E1812D661FB81925EFE6F9@OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB1640832E1812D661FB81925EFE6F9@OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 12:08:31AM +0800, Changcheng Liu wrote:
> the reserved_at_xx is start offset of the reserved space, update the
> offset display to correct the real offset in the data structure.
> 
> Signed-off-by: Liu, Changcheng <changchengx.liu@outlook.com>

Thanks for the patch. We are currently in merge window and accept only
urgent fixes. I will take this patch once -rc1 will be released.

Acked-by: Leon Romanovsky <leonro@nvidia.com>
