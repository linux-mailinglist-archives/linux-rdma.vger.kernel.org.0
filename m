Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FEE73D06E
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jun 2023 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjFYL0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Jun 2023 07:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFYL0y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Jun 2023 07:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E211B1;
        Sun, 25 Jun 2023 04:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E65F60BAD;
        Sun, 25 Jun 2023 11:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3011BC433C8;
        Sun, 25 Jun 2023 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687692412;
        bh=pjlScPKHUS94vTjsKXZ3xF+zo3hkrH8i9whHdTl8+/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKj4sq3H8gNfTrlqC9da6bmkrfr2p1qgIlDQLv4hMJk0VEWhG97xykojhGh8UeUPX
         DhXX1sYkQSMpPMYFWQiqEnsGvV0lnId1ChCt3zhK66VtK8IE5sujIuAhwS3PJlm3pO
         bQhuqc4gUATlkNSbAqQ+Igg10o2Fl3GYenG77vykdoMoLPKQ9jxkeG2GmlSF9iSSo9
         GZsXzxnpSLjU7JVqcsaRgw0W0/sjkkuZb4lLc8eoZUBKYZDAPbFNKVN6iLeXoHi58Z
         dqOqVo34kC3ICXnLodtnh5NPNNSgpZJNfTPpUarUXOq4M/8/u6VexEb8/Klv+oB3TX
         UlvIRMbEfm4mw==
Date:   Sun, 25 Jun 2023 14:26:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     selvin.xavier@broadcom.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove unneeded semicolon
Message-ID: <20230625112648.GB23952@unreal>
References: <20230625005743.125952-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625005743.125952-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 25, 2023 at 08:57:43AM +0800, Yang Li wrote:
> ./drivers/infiniband/hw/bnxt_re/main.c: ib_verbs.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5588
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 1e5b60f9269e..b42166fe7454 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -66,7 +66,6 @@
>  #include <rdma/bnxt_re-abi.h>
>  #include "bnxt.h"
>  #include "hw_counters.h"
> -#include "ib_verbs.h"

The subject line doesn't correlate with commit message and the proposed
change.

Thanks
