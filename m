Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555E68FCFE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Feb 2023 03:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBICQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 21:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBICQe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 21:16:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E87273C;
        Wed,  8 Feb 2023 18:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E316181D;
        Thu,  9 Feb 2023 02:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98292C433EF;
        Thu,  9 Feb 2023 02:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675908992;
        bh=zxuoxziI8jyG8v98JQH01KgPXTbx+A+CFTlPIEN0GQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sm6TfzLOF0gZqsGaSMjp84t6qn5Of94Ig7kL6TWiZkCPPaGkgV1yw8cNw2+Dn/sTC
         YcCkMCT2cafy6T3FwQakjS/o8MmYmG86ALCYSbqskN4S2yTIpEIoAWjNwHbvh4aztd
         et1ANYNbJPyNYOsFs5awDf8GXvUfY2PcpbRUJLG5fC+oFU2Cg37K3QrGdjMBAw38vG
         60kYVKZ4cOAgEtybsVOpvbutdzgky/m4h+phH2N9mNCP1CffDQ2qzVjXFWiFEuoaQF
         6+pcx0WDlrMczyafXBtyAjPCjrnf6WCbzR+LFokGTEOxfHbDNvDbPwdhPErAzoRRWW
         XUtOKTCpsOLzQ==
Date:   Wed, 8 Feb 2023 19:16:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Distinguish between sockaddr_in and
 sockaddr_in6 by size
Message-ID: <Y+RXfXDDKxKHjLbh@dev-arch.thelio-3990X>
References: <20230208232549.never.139-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208232549.never.139-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 08, 2023 at 03:25:53PM -0800, Kees Cook wrote:
> Clang can do some aggressive inlining, which provides it with greater
> visibility into the sizes of various objects that are passed into
> helpers. Specifically, compare_netdev_and_ip() can see through the type
> given to the "sa" argument, which means it can generate code for "struct
> sockaddr_in" that would have been passed to ipv6_addr_cmp() (that expects
> to operate on the larger "struct sockaddr_in6"), which would result in a
> compile-time buffer overflow condition detected by memcmp(). Logically,
> this state isn't reachable due to the sa_family assignment two callers
> above and the check in compare_netdev_and_ip(). Instead, provide a
> compile-time check on sizes so the size-mismatched code will be elided
> when inlining. Avoids the following warning from Clang:
> 
> ../include/linux/fortify-string.h:652:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
>                         __read_overflow();
>                         ^
> note: In function 'cma_netevent_callback'
> note:   which inlined function 'node_from_ndev_ip'
> 1 error generated.
> 
> When the underlying object size is not known (e.g. with GCC and older
> Clang), the result of __builtin_object_size() is SIZE_MAX, which
> will also compile away, leaving the code as it was originally.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1687
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Mark Zhang <markzhang@nvidia.com>
> Cc: Patrisious Haddad <phaddad@nvidia.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

Should this have a 'Cc: stable@vger.kernel.org', since we see this in
6.1?

> ---
>  drivers/infiniband/core/cma.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 1d2bff91d78b..308155937713 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -479,13 +479,20 @@ static int compare_netdev_and_ip(int ifindex_a, struct sockaddr *sa,
>  	if (sa->sa_family != sb->sa_family)
>  		return sa->sa_family - sb->sa_family;
>  
> -	if (sa->sa_family == AF_INET)
> -		return memcmp((char *)&((struct sockaddr_in *)sa)->sin_addr,
> -			      (char *)&((struct sockaddr_in *)sb)->sin_addr,
> +	if (sa->sa_family == AF_INET &&
> +	    __builtin_object_size(sa, 0) >= sizeof(struct sockaddr_in)) {
> +		return memcmp(&((struct sockaddr_in *)sa)->sin_addr,
> +			      &((struct sockaddr_in *)sb)->sin_addr,
>  			      sizeof(((struct sockaddr_in *)sa)->sin_addr));
> +	}
> +
> +	if (sa->sa_family == AF_INET6 &&
> +	    __builtin_object_size(sa, 0) >= sizeof(struct sockaddr_in6)) {
> +		return ipv6_addr_cmp(&((struct sockaddr_in6 *)sa)->sin6_addr,
> +				     &((struct sockaddr_in6 *)sb)->sin6_addr);
> +	}
>  
> -	return ipv6_addr_cmp(&((struct sockaddr_in6 *)sa)->sin6_addr,
> -			     &((struct sockaddr_in6 *)sb)->sin6_addr);
> +	return -1;
>  }
>  
>  static int cma_add_id_to_tree(struct rdma_id_private *node_id_priv)
> -- 
> 2.34.1
> 
