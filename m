Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B974E792515
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjIEQBO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354306AbjIEKj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 06:39:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D539E8;
        Tue,  5 Sep 2023 03:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1620BB8110F;
        Tue,  5 Sep 2023 10:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D6AC433C9;
        Tue,  5 Sep 2023 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693910392;
        bh=j8+1Hm4mUtM7Sdzk8t3pym7+APouKwS+Fm2dc4RCSX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUK1W8ki5VZew0euPZppawmgK/OH7XKYcJKl9dSF8bM5V5HF836tBWu1ORPqzPlGP
         9JNtuYCCM6KlDqkQUxkG03MY2XQyVOYoGEEEaW47GIFkcE7hdo+OzPCjYU0n4LLAGr
         iMXhGEQAawxDg1bLQxWduT+viuFmZdsASTIA5NFE=
Date:   Tue, 5 Sep 2023 11:39:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, benjamin.tissoires@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH] RDMA/uverbs: Fix typo of sizeof argument
Message-ID: <2023090538-seduce-saucy-6b2c@gregkh>
References: <20230905103258.1738246-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905103258.1738246-1-konstantin.meskhidze@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 05, 2023 at 06:32:58PM +0800, Konstantin Meskhidze wrote:
> Since size of 'hdr' pointer and '*hdr' structure is equal on 64-bit
> machines issue probably didn't cause any wrong behavior. But anyway,
> fixing of typo is required.
> 
> Fixes: da0f60df7bd5 ("RDMA/uverbs: Prohibit write() calls with too small buffers")
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 7c9c79c13941..508d6712e14d 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -535,7 +535,7 @@ static ssize_t verify_hdr(struct ib_uverbs_cmd_hdr *hdr,
>  	if (hdr->in_words * 4 != count)
>  		return -EINVAL;
> 
> -	if (count < method_elm->req_size + sizeof(hdr)) {
> +	if (count < method_elm->req_size + sizeof(*hdr)) {
>  		/*
>  		 * rdma-core v18 and v19 have a bug where they send DESTROY_CQ
>  		 * with a 16 byte write instead of 24. Old kernels didn't
> --
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
