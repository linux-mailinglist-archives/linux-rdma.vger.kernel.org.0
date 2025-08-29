Return-Path: <linux-rdma+bounces-13002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1EB3BEB2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687287B3DEF
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC6322549;
	Fri, 29 Aug 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i/hlEKKR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA03218DF;
	Fri, 29 Aug 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479507; cv=none; b=CIIqtGpvhbUP06gywQE+mBjxjTMUw99UqNmkwnyCrulfn/OmBFFAWNpglOwMWuehj71dmEhihpLEqpHZU9sZVV96hHdqT+WKncAiOl8WAn557IhPbLRg9MrKFD12NaeMS9ewww0wuWurNW4BuENowaUXOBwlXdy3Voa7rFBZkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479507; c=relaxed/simple;
	bh=onFqY4hAxMFMBuN8j/TBQNxlKRQzUK0qi6Le9OMjaX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF0ucxNPvRW0e2Bo9GLs22cEezW8tTT8fZtbAtOSHeKrvQoPUV2f3U7tG5g3C2J0v+OE7+39bUsChBFH4LvwwV9by/QXUfuiT6RvWtUejSvKVQii28sxKbGo95K6BpKDLLTsUfksQdgoWqYcE/lK/4Vq8xhro2jXwDAfXI8oVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i/hlEKKR; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756479493; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=jmm7ekTMsGSF5XYrucl/oT/K7r0Y6mSHpLrRn6c9gpE=;
	b=i/hlEKKRrFFp+9mTXVtDWl2GTfquIufNMZuTO4zzpQC5BXVfviGfUqR+lct1lGawYd0qRP6trkpUPtVmcrigvWzOrDmJz4OVHJ+QHlSW5LqjmUhEszGzhXYDVGNRgkF7cHvK6FbjnEIvU3n/fBTIemTWZjOUkB1J7VktDB2chOU=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wms2ysr_1756479492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Aug 2025 22:58:12 +0800
Date: Fri, 29 Aug 2025 22:58:11 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
Message-ID: <aLHAAy-S_1_Ud7l-@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829102626.3271637-1-mjambigi@linux.ibm.com>

On 2025-08-29 12:26:26, Mahanta Jambigi wrote:
>Currently SMC code is validating the reserved bits while parsing the incoming
>CLC decline message & when this validation fails, its treated as a protocol
>error. As a result, the SMC connection is terminated instead of falling back to
>TCP. As per RFC7609[1] specs we shouldn't be validating the reserved bits that
>is part of CLC message. This patch fixes this issue.
>
>CLC Decline message format can viewed here[2].
>
>[1] https://datatracker.ietf.org/doc/html/rfc7609#page-92
>[2] https://datatracker.ietf.org/doc/html/rfc7609#page-105
>
>Fixes: 8ade200(net/smc: add v2 format of CLC decline message)
>
>Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Reference-ID: LTC214332

I think this is your internal ID ? It's better not to leave that
in the upstream patches.

>Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>
>---
> net/smc/smc_clc.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>index 5a4db151fe95..08be56dfb3f2 100644
>--- a/net/smc/smc_clc.c
>+++ b/net/smc/smc_clc.c
>@@ -426,8 +426,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
> {
> 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
> 
>-	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
>-		return false;

Here it's checking the typev1 in smc_clc_msg_hdr, but your commit message
says it's validating the reserved bits:

  Currently SMC code is validating the reserved bits while parsing the incoming
  CLC decline message & when this validation fails, its treated as a protocol
  error.

Did I miss something ?

Best regards,
Dust

