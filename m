Return-Path: <linux-rdma+bounces-10464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F884ABF0A9
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA067B08EE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB825B1CF;
	Wed, 21 May 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGmIxo6u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7025A65C
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821714; cv=none; b=U+L9gAFZb73SESoErATAVPmVWTsx6fsUD53CyrImBReXXkUfEg0qkSL8aDnyeGmW0eUJgpDaDyCsj52a4yG5hO208NTepcb63oLaCg7FM+qHgcrWG9WICLx+/0qOb4fnU4EOeRF/NFQMEvzicBEuTH1Odm4FyrFQY0SizOy91Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821714; c=relaxed/simple;
	bh=zG3fM3DUYTxJTz2WwJF7qr8pwqUp9LKtMDRcqX2yVt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2PH4GE1SaGahRiW0kdN4Uq7QkUMH7pPG1JEBvt0gqVnMu+6d/5y1FLBZdxITaihxr7YQCHywqK6jfNHOg6GZ+O9sVt0NAJpqrPdMXDWQUSD5/S1AZrVKuSzwnAg/ncqcK3jKLz/Qku++oD2s+E8CPrFNohTnArEoDdlf1LIwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGmIxo6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C99C4CEED;
	Wed, 21 May 2025 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747821713;
	bh=zG3fM3DUYTxJTz2WwJF7qr8pwqUp9LKtMDRcqX2yVt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGmIxo6ud2owAf3cf9HqsDWAJp0o+YBCo8LXTfvBSmVG1JYebtVLfUaHBsmhJKUF9
	 ck3pDwDfdVa7SvqdKL2kP0Ym3LuXguPVTJa/yLO9nxBieMv3Unh3+di7CAMeg8lsbL
	 1XOuIAz9LugP4lyYoHk/eH+qNSLK/JXRxzIyju9SfbicqQW4gPwswehDLr4t50Mv2M
	 7GEwucyFc20hfhjX/rLklimGzQ4Hc0elt+J7bHNbuDMQ1gFqUMC4V9F0HGyYwjowBl
	 XxFHcgg92GqDQM386q4eZw4xL2MH1e6lidR+0Zxuq6oeokgansLPCPxt+OdnNK67lz
	 1mIyPKEG8rWmw==
Date: Wed, 21 May 2025 13:01:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-rc 4/4] RDMA/bnxt_re: Fix null pointer dereference
 in bnxt_re_suspend
Message-ID: <20250521100147.GI7435@unreal>
References: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
 <20250520035910.1061918-5-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520035910.1061918-5-kalesh-anakkur.purayil@broadcom.com>

On Tue, May 20, 2025 at 09:29:10AM +0530, Kalesh AP wrote:
> There is a possibility that the Ethernet driver invokes bnxt_ulp_stop()
> twice during reset recovery scenario. This will result in a NULL pointer
> dereference in bnxt_re_suspend() as en_info->rdev has been set to NULL
> during the first invocation.

Please fix bnxt_ulp_stop() to do not do that. The fix should be there
and not in bnxt_re.

Thanks

> 
> Fixes: dee3da3422d5 ("RDMA/bnxt_re: Change aux driver data to en_info to hold more information")
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 293b0a96c8e3..bc0b40073461 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -2410,6 +2410,8 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
>  	struct bnxt_re_dev *rdev;
>  
>  	rdev = en_info->rdev;
> +	if (!rdev)
> +		return 0;
>  	en_dev = en_info->en_dev;
>  	mutex_lock(&bnxt_re_mutex);
>  
> -- 
> 2.43.5
> 
> 

