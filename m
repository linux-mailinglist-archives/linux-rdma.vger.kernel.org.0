Return-Path: <linux-rdma+bounces-2836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F478FB329
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 15:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4209B2C5B9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC988145B27;
	Tue,  4 Jun 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p000rvcZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E431E519;
	Tue,  4 Jun 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506217; cv=none; b=GqWokPtn59ZPs6r4cra5qMt5aeljdh1JYEF1+PxIG7A7cxpyYTKZJuHJj2YVv8JdY9GTa7b+tP4291pp4zWwe+AmM35Ii8pDlOK0Mm9o4e8VEn9qdkWHL7sQEEzkymq3kYSKXKhUCznPF3/Dpd1kdeGmxH4+RjkT9k7vSdWClvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506217; c=relaxed/simple;
	bh=snaMy2D6q++knfWhNRs+J2NDIjP7SJheVj7QpZxtH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lup02r5PE2BdGxmQ2kIC2x6CAPgwOg/TRM/fOMMAVdWLsPQn//eZS3iKekQYUUKIT8qudmOcugnbBMq9u41+XCAae66GrUngw21GkTnahCmWD0nKfIDWep5urE3kKTf2y9hzeo6dKI/3twFnxlcNUw8mP345+bL3uVkEzp9kT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p000rvcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F797C2BBFC;
	Tue,  4 Jun 2024 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717506217;
	bh=snaMy2D6q++knfWhNRs+J2NDIjP7SJheVj7QpZxtH0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p000rvcZn1zZnKy29vbQxqrV2lXH+T0lAyiDHfEK7+J9qb1fSLz3WbM+0gW26KW+u
	 RY1h1nzMZtHP8XXZYW5bsjgPPpEKzj+af3kQ73ydm/Kycc/dm+SzzUomaEyamc+3pi
	 5mb4VbB+hym//PvzUANxrv6fOAEWsABRYE5uMtY9wpZz6Wjx5bK0lTeF6mjsoppqu2
	 /mMvCqGwCdPOMixbs1N4xXpKXp48lziNvVMSpO9k7Vi88WhYywrH1+Ho6wEJ/QEVI2
	 TBAUJPWrraL+kFJUJzaI3dnKEVh7fiIdrEBiLEjGKdbl5KjGSEduzJ7L4rLhtKO5Sb
	 CRR+3FizNx5UA==
Date: Tue, 4 Jun 2024 16:03:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Message-ID: <20240604130330.GS3884@unreal>
References: <1717502162-4161-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717502162-4161-1-git-send-email-kotaranov@linux.microsoft.com>

On Tue, Jun 04, 2024 at 04:56:02AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Ignore optional ib_access_flags when an MR is created.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/mr.c | 1 +
>  1 file changed, 1 insertion(+)

Please add Fixes line.

Thanks

> 
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
> index 4f13423..887b09d 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -112,6 +112,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
>  		  "start 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
>  		  start, iova, length, access_flags);
>  
> +	access_flags &= ~IB_ACCESS_OPTIONAL;
>  	if (access_flags & ~VALID_MR_FLAGS)
>  		return ERR_PTR(-EINVAL);
>  
> -- 
> 2.43.0
> 

