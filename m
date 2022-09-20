Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102415BE489
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiITLdY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITLdX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 07:33:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128B5A3E8
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 04:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B041BCE176E
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 11:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADA9C433C1;
        Tue, 20 Sep 2022 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663673597;
        bh=hlLYGXphi+T0nkb/x1JZZ2W8GS5N9Dy1x/MPi9REHkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0fqegjDzQaA7t9n+n5cVanrp1wvHSpw0WHVCL6MTU4L17+ESfM3s4FQ0FwTkl5Ek
         NfszGzQ1Toaozuz3nxKDxgndib8W3GktzCh6kQ2BnqHPhxjli1lFo1fgnoCCJLdd8l
         CKbSFnPfJqcN4fjtAnzxt/jLm7Tg/BwYEoe/+rtGFcW3G9m8to0n5zUOp+BpDV5PY6
         wVTbvsiMe+9XrpYr8wzFtCF6qNvVJkuA945nrEqw/bU1RgiSpdKlgysP08aGfAq53p
         j4yPlEHrEPi5E8V7xJSDcjOI0rkgihw7KJtxnfhFyKZOvUYSFc1SvGIAtFHVaMBRD5
         23B9GOmqhCjgQ==
Date:   Tue, 20 Sep 2022 14:33:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/4] RDMA/erdma: cleanups and updates 9-9-2022
Message-ID: <Yymk+bDrehINfTL7@unreal>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909093822.33868-1-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 09, 2022 at 05:38:18PM +0800, Cheng Xu wrote:
> Hi,
> 
> This series has new updates for erdma driver:
> - #1~#3 aim at making code more clean, including eliminating unnecessary
>   castings, removing redundant include headers, and hiding hardware
>   internal opcodes.
> - #4 introcuces dynamic mtu support.
> 
> Thanks,
> Cheng Xu
> 
> Cheng Xu (4):
>   RDMA/erdma: Eliminate unnecessary casting for erdma_post_cmd_wait
>   RDMA/erdma: Remove redundant includes
>   RDMA/erdma: Make hardware internal opcodes invisible to driver

I applied these three to -next.

>   RDMA/erdma: Support dynamic mtu

This patch needs clarification.

Thanks
