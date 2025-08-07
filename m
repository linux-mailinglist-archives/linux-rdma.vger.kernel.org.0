Return-Path: <linux-rdma+bounces-12621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A789B1D141
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 05:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B923F17168E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 03:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4081DE8A4;
	Thu,  7 Aug 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XYEAnTGx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44043524F;
	Thu,  7 Aug 2025 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537680; cv=none; b=QcPCtxQPokFXFx2sBrlGN/l+icU3KfQ0xcSNt4eRZ8T8r0PYm1Fn1aogPUWUzyE1/1uVNM2cPHq2fsj5xoR5RjM2ri2iSxppO5QZLoe2JQz9VgikvPgEo/8cVNxAIs4v0R4uEW4Q58FqyJsmi/NDasUhvZhQk7N8hjJzQn4YxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537680; c=relaxed/simple;
	bh=y8nioLbV5o8a9uuZ42Va/r1J0Xpx1iyjokFJZB2/TYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlVEmt8GeqVtHvGLoSyoSXc9jI4M8Ke+uovffyxWsmIdvUTNxM/TIOfHjI6s5xQC9REPz8ZI+EdCrWWvfNOi53UAahJh22RowrCBL5egM3SFrkRrjpS1jVpUXBfFKYn6tiFP6hnHBo/eSNq7Pq+BnMmcgw6Jg7tugFtCZ6rC7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XYEAnTGx; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754537673; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=TYAtQyuM0GCObX8x0XidoUON81hG/onakbba9CnK3Pw=;
	b=XYEAnTGx19obP/CMcBeN8y2ISVX1B8mcMK6npyiwZTzKrzMJQeukr4RfHmtGucsoTqpwRARbnQSTUPUa9aqYQqQAoHuFojr6uxqUlOhkW0997Li9NGgYnrDBLy0yosoPhA2kmmvY0Sr8RogVz/h2VZOusb959g7onCdhcrHGDSI=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlCg0yN_1754537671 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 11:34:32 +0800
Date: Thu, 7 Aug 2025 11:34:31 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 01/17] net/smc: Remove __init marker from
 smc_core_init()
Message-ID: <aJQex0Ey-eaysumJ@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-2-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-2-wintera@linux.ibm.com>

On 2025-08-06 17:41:06, Alexandra Winter wrote:
>Remove the __init marker because smc_core_init() is not the
>init function of the smc module and for consistency with
>smc_core_exit() which neither has an __exit marker.

Have you seen a real warning or error because of the __init marker ?

I think the __init marker is just to tell the kernel this function
will only be called during initialization. So it doesn't need to
be the module's init function.

Best regards,
Dust

>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> net/smc/smc_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>index 262746e304dd..67f9e0b83ebc 100644
>--- a/net/smc/smc_core.c
>+++ b/net/smc/smc_core.c
>@@ -2758,7 +2758,7 @@ static struct notifier_block smc_reboot_notifier = {
> 	.notifier_call = smc_core_reboot_event,
> };
> 
>-int __init smc_core_init(void)
>+int smc_core_init(void)
> {
> 	return register_reboot_notifier(&smc_reboot_notifier);
> }
>-- 
>2.48.1

