Return-Path: <linux-rdma+bounces-3901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D0934A2F
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 10:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27EA1F25296
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C07D3F8;
	Thu, 18 Jul 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C72Ah/uF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F993B784;
	Thu, 18 Jul 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292279; cv=none; b=jS9lLeKBri82tSXPFhofX9hwm3PePS8qUMwZFcuAry5DFFqz2VZgY0uPRj0m9m0NadNZ9bPwlOfbf3SvnZmYjKj8e26DDgMInq0XE4yG9917Yal0d+MsajrFyKgdTE5HrmqVAN8XS/eATfytrVjwxDfEVMLE6jbBnNGtYtyDxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292279; c=relaxed/simple;
	bh=Pri/XnCUYumHgHDkGr3RQJ9BWhPmkJqoPzCRjvI1bGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy/a+hqzSjOBdxS+kaQ9UwZagLlfwM4ZU1j8eWFHC8zsTp2F26e1h1TGvR1Gzv7nY+9xFyAmGXrkf6AErsIsdB2IPONUuvoO7m36oZt8zOEHpQPUQEyEtXHSygtbVkhExUqz+95b0wSXcqYtDNlKqQdN9OVe+9tW/EQINotj0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C72Ah/uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B13C4AF0B;
	Thu, 18 Jul 2024 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721292278;
	bh=Pri/XnCUYumHgHDkGr3RQJ9BWhPmkJqoPzCRjvI1bGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C72Ah/uFOiLZjwZt4/hRUuB0DeET01UgOb7QDV5zfUKG8qrgGV9yosAAqqO1vyurL
	 iWWLnn928fcxdLLwu2cr4dru5aG2QclnYW6RG+fqku6L3xTuZdDWHAZGIsyY+yhpTH
	 HZ0aFs1/FZ9xIgdpPXWcdaZ/J0whQV/I0OnoRsO3015azT20HS0bKcgjshA31pia8g
	 nGFg9h5c74ZcJbImKvwPUL62oIT9MqL/iSRpeE2ZD5WaPA15/BMe5jF/NpQ0Pgea5i
	 Tff02eH1sp7qqZ1jgzumrgcPRLk6hxGeM8skfwiIPknRKxXCjPS0N7d3U6cynvAkGJ
	 rPC9qJdBogM4g==
Date: Thu, 18 Jul 2024 11:44:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rds: Remove duplicate MODULE_LICENSE() from ib.c
Message-ID: <20240718084434.GO5630@unreal>
References: <20240717-ml-net-rds-rdma-v1-1-5cc471a5e20f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-ml-net-rds-rdma-v1-1-5cc471a5e20f@quicinc.com>

On Wed, Jul 17, 2024 at 04:45:36PM -0700, Jeff Johnson wrote:
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=1. One strategy for identifying such
> modules is to search for files which have a MODULE_LICENSE() but which
> do not have a MODULE_DESCRIPTION(). net/rds/ib.c is one such file. And
> its product, ib.o, is a component of the rds_rdma module via:
> 
> obj-$(CONFIG_RDS_RDMA) += rds_rdma.o
> rds_rdma-y :=	rdma_transport.o \
> 			ib.o ib_cm.o ib_recv.o ib_ring.o ib_send.o ib_stats.o \
> 			ib_sysctl.o ib_rdma.o ib_frmr.o
> 
> Interestingly, when CONFIG_RDS_RDMA=m, the missing description warning
> is NOT emitted by modpost. This is because rdma_transport.c contains a
> MODULE_DESCRIPTION() that describes this module. And in addition,
> rdma_transport.c contains a MODULE_LICENSE() for this module.
> 
> Since rdma_transport.c already contains both the MODULE_LICENSE() and
> the MODULE_DESCRIPTION() for the rds_rdma module, remove the duplicate
> MODULE_LICENSE() from ib.c
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  net/rds/ib.c | 2 --
>  1 file changed, 2 deletions(-)

The title of the patch is wrong, it should be "net/rds: Remove duplicate MODULE_LICENSE() from ib.c"

Thanks

