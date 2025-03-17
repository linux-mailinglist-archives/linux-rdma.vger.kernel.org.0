Return-Path: <linux-rdma+bounces-8741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A59A64D34
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BC7168084
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1F233728;
	Mon, 17 Mar 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxwjl3r+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702117D346;
	Mon, 17 Mar 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212206; cv=none; b=GsQh6x+0Mh/aiY9VySfQDeijEYgTgDd7MFFpcXD1aGhxt4kPDr99IJo+e0sDxASpS6erF4HSo02hEEX+jxY9W5qILQzBGJCwOYBqDgVkVVC0C5GzcOEKorOup7O0EdzeVueyJ8swDABTxxi59wV7q+z8GBZBU2LcwrMBLKe4dN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212206; c=relaxed/simple;
	bh=1GSc+zGZpUI8fJ7T9KHkpfUps6GJZmaDZpoKUJ5ir64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g27KoXGwH0P6gZB3x6r87WdxZXtaKvKShE8txK5hmqmaO8ZYdQOZyZPOP/2dUz6BSqPANvW6gUpt2l021JjsoCWPI/wDgCqaPjTWIDK2qsyVmYj6MeOsAG9cq1d6/aV3w2iO22kykI+Yr/alTruY6Gvm2dtlGJXrvR6/iBhJTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxwjl3r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D0C4CEE3;
	Mon, 17 Mar 2025 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742212205;
	bh=1GSc+zGZpUI8fJ7T9KHkpfUps6GJZmaDZpoKUJ5ir64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxwjl3r+spvMcKVwGmicju2473ayM8BLZVaAVz5fMBCsD+Y84bCPpldJnXapyL/JS
	 V9H8NgTEUHsXEuaASOD5wwcoVWSVR+JEqxtktcTTs1oUjN3JIXSRvjUgHsS0RUVTxt
	 0GkW+qiziMBWLuVogK8lpfH+8/rQ54okgFfLp8pgb+oTfNrw6MnRDDboMTwdtODYjJ
	 IICDGrexBtHRlejjapDul/NRwlWgyP9yRqig0Kit3ORWodt6jv1jXy271RxURftCZz
	 iUAowb1YwvDS639jTD+Pqlk3X2JDVM7GgMpzqGuQXwCgNsKWycbVmAzddl16aNvzXM
	 jrBso2YddHnAA==
Date: Mon, 17 Mar 2025 13:50:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inifiniband: ucaps: avoid format-security warning
Message-ID: <20250317115000.GS1322339@unreal>
References: <20250314155721.264083-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314155721.264083-1-arnd@kernel.org>

On Fri, Mar 14, 2025 at 04:57:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Passing a non-constant format string to dev_set_name causes a warning:
> 
> drivers/infiniband/core/ucaps.c:173:33: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>   173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
>       |                                        ^~~~~~~~~~~~~~~~
> drivers/infiniband/core/ucaps.c:173:33: note: treat the string as an argument to avoid this
>   173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
>       |                                        ^
>       |                                        "%s",
> 
> Turn the name into thet %s argument as suggested by gcc.
> 
> Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/core/ucaps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why don't you change ucap_names[] declaration instead?

diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index 6853c6d078f9..90ac41bc0f07 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -23,7 +23,7 @@ struct ib_ucap {
        struct kref ref;
 };

-static const char *ucap_names[RDMA_UCAP_MAX] = {
+static const char *const ucap_names[RDMA_UCAP_MAX] = {
        [RDMA_UCAP_MLX5_CTRL_LOCAL] = "mlx5_perm_ctrl_local",
        [RDMA_UCAP_MLX5_CTRL_OTHER_VHCA] = "mlx5_perm_ctrl_other_vhca"
 };
(END)

Thanks

> 
> diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
> index 6853c6d078f9..de5cb8bf0a61 100644
> --- a/drivers/infiniband/core/ucaps.c
> +++ b/drivers/infiniband/core/ucaps.c
> @@ -170,7 +170,7 @@ int ib_create_ucap(enum rdma_user_cap type)
>  	ucap->dev.class = &ucaps_class;
>  	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
>  	ucap->dev.release = ucap_dev_release;
> -	ret = dev_set_name(&ucap->dev, ucap_names[type]);
> +	ret = dev_set_name(&ucap->dev, "%s", ucap_names[type]);
>  	if (ret)
>  		goto err_device;
>  
> -- 
> 2.39.5
> 

