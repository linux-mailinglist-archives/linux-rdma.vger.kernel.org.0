Return-Path: <linux-rdma+bounces-7505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9CA2B9F7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 04:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CC53A780B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 03:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1321DE3D8;
	Fri,  7 Feb 2025 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxZCAg9W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D21DE3BF;
	Fri,  7 Feb 2025 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900672; cv=none; b=a7W4xAw4NDN9b3W4aIsob+qkS7RUok39JFa6DZDcb8X3ernnTwgEul3sWK8iunRoFSfTM0UhzM9YXIO/sNiYIpQo/kU/xb/5VXgds+vUg+ZDVevbgP9HSJzNyT9mFlZW1ryY1pxS3BLgIjM39YwISHlvkd/xDUNYfvGQ3SToUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900672; c=relaxed/simple;
	bh=zKMDSSJVgP7r5dDFgUpPRcJMAjIK6Y3ObMNUxWdzdmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1oPQz1uxrQP69pQhocPJFBHFpu815sVwlPbw/4nW7WeI2IITuybr/C0fqrk+BEBIAhTfvprfb3Nbkt7QBXK7MPkxxA8LWNR/27lzM2d70zBIdVZ9t6EFrFy/wsrHCqu/KtaUXHDrgX3DX07uW0EBuorUi+B3uKqeqaf2asqCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxZCAg9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C2C4CED1;
	Fri,  7 Feb 2025 03:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738900672;
	bh=zKMDSSJVgP7r5dDFgUpPRcJMAjIK6Y3ObMNUxWdzdmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxZCAg9WKRNOuuuQwZ0dBZ+tHxOYH4/TRjLiDlGY5IEyD3PpIbl/5oduKomnDECqa
	 Xm45m63+/ewVemPN6ndAQaKDaDc5yg6s1LRKRfnT4qwk+lhKmvQXe6/33tpq68D3YD
	 60fLSzHaaB3FBZ1f+waDv3xpl0uh2Euo0hNVkMZiwVDh5H8k2qq/NDnXUvA6nHmtbt
	 jX7ViH5b/Ytx3uUKo0sfgeg6PzmphWu2xlD9yOkLV/vJXQ9aTedq+vsHZLtyGCHY/1
	 /27p2dYiZDsTIyjW6foitrVL9MQdcxQy0H74IGsAwEdJBNk1JoDtv/0OD6c2g18zZx
	 8jIKRLpv7FHLw==
Date: Thu, 6 Feb 2025 19:57:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/irdma: switch to using the crc32c library
Message-ID: <20250207035750.GA43210@sol.localdomain>
References: <20250207033643.59904-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207033643.59904-1-ebiggers@kernel.org>

On Thu, Feb 06, 2025 at 07:36:43PM -0800, Eric Biggers wrote:
> +int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val)
>  {
> -	u32 crc = 0;
> -
> -	crypto_shash_digest(desc, addr, len, (u8 *)&crc);
> -	if (crc != val)
> +	if (~crc32c(~0, addr, len) != val)
>  		return -EINVAL;
>  
>  	return 0;
>  }

Sorry, I just realized this isn't actually equivalent on big endian CPUs, since
the byte array produced by crypto_shash_digest() used little endian byte order,
whereas crc32c() just returns a CPU endian value.

And of course this broken subsystem uses u32 for the little endian values
instead of __le32 like the result of the kernel.

Not sure it's worth my time to continue to try to fix this subsystem properly.

- Eric

