Return-Path: <linux-rdma+bounces-13026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48046B3F36A
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 06:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024384831F1
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 04:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDF2E0B68;
	Tue,  2 Sep 2025 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dr5nYrtc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16821C17D;
	Tue,  2 Sep 2025 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786169; cv=none; b=hhlq2GCpEM2LizJIziY1oHLS+Dubhybnvjp3Jm95Y919H6x6FSBWFjrvlaTz7NSnKLa2z2b3pn9z+K5JInbodMO8rPKfNfMEulc+hilSqhzqVDDUBJFSsYiAIAOwsgkkaM84Ruy3UVvw4fDmyyxWVPEGKLgs7tkDmtxVY7hLgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786169; c=relaxed/simple;
	bh=5dI+o8+/VX8vNatbzWuIyuhVC2ZOzo6CI09Rjw6XzoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAEL1xTDGoiv7552tidUfxRyUQFWx82fVb5u4sqfZHXMAEzA4PJrG51xw8EwB4QzVB76SBExDZblLsqWAoR+CxIMsFfHtOcQ8y4gf4dFYKP2vWyEH7SyLVMsD+eMssdM5HZc9mWWSBVJw0beeTZG5X4ijVNfnjLiox7KmdnKiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dr5nYrtc; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756786158; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=G+TTJZpvM1oLnn0O3P9/SPMdGWfxxUtCQSOzuT9UnIs=;
	b=dr5nYrtc2QD1gsaTO+mc9PWWr3cQXGdo9tGY1Fg0bcYjaZCpw3/mB4FSAnkjOryC6b4IquliWdCP4JXeGbsvNbeDY3GWWSI9DMKmD6+X9Qthij5U7l2gJ2YKsmT4WTnjqHSB3PYSxtSwLQwtGORXfsf1xz2h/bMIXmJ4TtmB1MY=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wn6ArLY_1756786156 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 12:09:17 +0800
Date: Tue, 2 Sep 2025 12:09:16 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: James Flowers <bold.zone2373@fastmail.com>, alibuda@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, skhan@linuxfoundation.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] net/smc: Replace use of strncpy on NUL-terminated
 string with strscpy
Message-ID: <aLZt7PLarvNIedau@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250901030512.80099-1-bold.zone2373@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901030512.80099-1-bold.zone2373@fastmail.com>

On 2025-08-31 20:04:59, James Flowers wrote:
>strncpy is deprecated for use on NUL-terminated strings, as indicated in
>Documentation/process/deprecated.rst. strncpy NUL-pads the destination
>buffer and doesn't guarantee the destination buffer will be NUL
>terminated.
>
>Signed-off-by: James Flowers <bold.zone2373@fastmail.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
>V1 -> V2: Replaced with two argument version of strscpy
>Note: this has only been compile tested.
>
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
>2.50.1

