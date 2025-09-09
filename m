Return-Path: <linux-rdma+bounces-13174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3F3B4A002
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 05:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6CE4E099B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8626F2B2;
	Tue,  9 Sep 2025 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vYiYVXiU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7494D515;
	Tue,  9 Sep 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388239; cv=none; b=UtDpKlazvwj1kXdbkNy5g2nSWkAqBsVLqxoBXC1zPmD/hS/AoMeSz1rApSBRDWhaa7SltqW4QVNgY8kN5KE45QJfGYdE9rj6IoiMUMisfAKfkVq+b/uDcxFEOwKN1WJ9vyqCOPv8d2DS5+I0w6pbCInDGn5Nh4HWUeegbBWtobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388239; c=relaxed/simple;
	bh=pswCMpx2vTdQ1c7alrFPSg51STxY+Ef9ucqfFUYaqWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJvG8+w6clZn7VleWoo5u/ESOpbqX9gboYLWj87svO1KoXoTek3vH6Puw5LGhh5ABtecpdSss84EXSBLTCT9rYGfEO+ZpBQc+4qIy0/b4zSjpLmOe1yrDL1EfU2f/rfpqle2JtDkQ2HT5f0BkCJA7Ujz5T0xNyaffOuKPIEX9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vYiYVXiU; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757388233; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=3kUMao3FvCL6I7A/UN7ip7pd2M3nqoLuRCUIBR3cW0E=;
	b=vYiYVXiUUKMEcjfFwUFjDK7FBk4xB1mNoYoXrMlv552rBDl2ILnOaaTF+jO3JDpchH3wGss0rnBdQROPwHJy1gUlL1YzdvSWyim70qcOV2BhRZmLRd/d+YZeI6sWq8aC5r+DHTmMOl6lF/st4d/TkRkC2SU0okJlPyUQCf7cqWU=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wnc7Yfp_1757388232 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 11:23:52 +0800
Date: Tue, 9 Sep 2025 11:23:52 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, alibuda@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
Message-ID: <aL-dyGTIUuwK_R8_@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908180913.356632-1-kriish.sharma2006@gmail.com>

On 2025-09-08 18:09:13, Kriish Sharma wrote:
>Replace the deprecated strncpy() with strscpy() for ib_name in
>smc_pnet_add_ib(). The destination buffer should be NUL-terminated and
>does not require any trailing NUL-padding. Since ib_name is a fixed-size
>array, the two-argument form of strscpy() is sufficient and preferred.
>
>Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

I think d250f14f5f0754ce2d05d9c0ce778e4a51f488b0 has already done the
same thing.

Best regards,
Dust


>---
> net/smc/smc_pnet.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>index 76ad29e31d60..b90337f86e83 100644
>--- a/net/smc/smc_pnet.c
>+++ b/net/smc/smc_pnet.c
>@@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
> 		return -ENOMEM;
> 	new_pe->type = SMC_PNET_IB;
> 	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
>-	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
>+	strscpy(new_pe->ib_name, ib_name);
> 	new_pe->ib_port = ib_port;
> 
> 	new_ibdev = true;
>-- 
>2.34.1

