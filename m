Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E896C00E1
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 12:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCSLk5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSLk4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 07:40:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71F6E9B;
        Sun, 19 Mar 2023 04:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C968B80AB5;
        Sun, 19 Mar 2023 11:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A93C433D2;
        Sun, 19 Mar 2023 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679226052;
        bh=LldkDG7q1fdcJMFLpCO5/nBIKzU9c/xA/fLYRPQZFdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvRQ9wIPHfFR6JB9JCMJ4w97u/hq5jiMubcgODSoRSXQW8WsESnSizCcnxxJJh8Ar
         qxWLlpXabMLDPXhcsXGpI583MEqcPO48Tcs44apqaJpH/yyA0mM4W6jOIKKAax68MR
         I6YiWXAwYPqQZ41dq9BIOMtp3+3s1gkz0j6ac8EUQnUbVSn/oQP7jmBTDbnCdiLDid
         lp65sGiJUmUJz24k8XWsA7tMgOgo84QlJHESuOP+5UVpWeJt1HDfsDg2gLtnn0QbR4
         PLWnP7LW5kRnFBQeDQwk+grQCZmgEjzXf4gvAuacOBwO0wSNZHvLc/ymnpUozirDu5
         Co/d4Nj+PJtqg==
Date:   Sun, 19 Mar 2023 13:40:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Fix exception handling in siw_accept_newconn()
Message-ID: <20230319114048.GB36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 18, 2023 at 08:43:04PM +0100, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 20:30:12 +0100
> 
> The label “error” was used to jump to another pointer check despite of
> the detail in the implementation of the function “siw_accept_newconn”
> that it was determined already that corresponding variables contained
> still null pointers.
> 
> 1. Use more appropriate labels instead.
> 
> 2. Delete two questionable checks.
> 
> 3. Omit extra initialisations (for the variables “new_cep” and “new_s”)
>    which became unnecessary with this refactoring.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 6c52fdc244b5ccc468006fd65a504d4ee33743c7 ("rdma/siw: connection management")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 32 ++++++++++++++----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)

Please read Documentation/process/submitting-patches.rst and resubmit.
Your patch is not valid.

Thanks
