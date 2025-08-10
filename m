Return-Path: <linux-rdma+bounces-12640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0AEB1FA4D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D223BC5BD
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F125EF97;
	Sun, 10 Aug 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ue1cezkE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184DF9EC;
	Sun, 10 Aug 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834459; cv=none; b=WGSuP/iiDHIPdcEqGCULFgsj4KO6rWTZiilp/PIIX8EMQmNE7CBiE98OBZYoSWWvcuPHtVjzPSd4InAeoKS6Mk+lvG2mjF/YvpL2qrHVNDpU1McQZ9HmWDPHAIBHohJK+PkciBWJIY2vK7tANsMS2T9a8tUJZg7cI7/WN1Z/n/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834459; c=relaxed/simple;
	bh=A6U1CTsc1ah12H6I0TyIqCR/j0ENxJRYapdSIU4QYck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDD+NoQnH/PrasZxSY6x52EhpQZvVWbFOPhyqdeXBtPwm6m7r0nfF7Y5DVKZbX7RVeGWB1TBT4cHegKH32tCXyfbvk7/pES+H/w4k9TXnbp+IMqbGx/fi+Czconi5odxmsCk+PS20SmJIhc96SSGJB3YqKd50+DZXjeJ3ptBZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ue1cezkE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754834447; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=d/zbPx2SfNsAqXabsEtCfvdkvIJzTIoYPVxDgiGVL6I=;
	b=ue1cezkE8AgkZ/VNcsQUjP9pSUcuLOcvt8Cu+n7w0f/RncWKImWd9IJAVQPuoVxmASlL//P26FKhEDOzYwfnXcEzXo3CfB2gdXvRnxY04LyNAUz/sjsaqSn4cJXvBP1CvJ9USck9KHslQaFhA4vImzHMJ8nupLGmLtJmvdAfJ8s=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlMU8ur_1754834446 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 Aug 2025 22:00:47 +0800
Date: Sun, 10 Aug 2025 22:00:46 +0800
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
Subject: Re: [RFC net-next 04/17] net/smc: Decouple sf and attached send_buf
 in smc_loopback
Message-ID: <aJimDiQupacKNR8M@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-5-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-5-wintera@linux.ibm.com>

On 2025-08-06 17:41:09, Alexandra Winter wrote:
>Before this patch there was the following assumption in
>smc_loopback.c>smc_lo_move_data():
>sf (signalling flag) == 0 : data is already in an attached target dmb
>sf == 1 : data is not yet in the target dmb
>
>This is true for the 2 callers in smc client
>smcd_cdc_msg_send() : sf=1
>smcd_tx_rdma_writes() : sf=0
>but should not be a general assumption.
>
>Add a bool to struct smc_buf_desc to indicate whether an SMC-D sndbuf_desc
>is an attached buffer. Don't call move_data() for attached send_buffers,
>because it is not necessary.
>
>Move the data in smc_lo_move_data() if len != 0 and signal when requested.
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>---
> net/smc/smc_core.h     | 5 +++++
> net/smc/smc_ism.c      | 1 +
> net/smc/smc_loopback.c | 9 +++------
> net/smc/smc_tx.c       | 3 +++
> 4 files changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>index 48a1b1dcb576..fe5f48d14323 100644
>--- a/net/smc/smc_core.h
>+++ b/net/smc/smc_core.h
>@@ -13,6 +13,7 @@
> #define _SMC_CORE_H
> 
> #include <linux/atomic.h>
>+#include <linux/types.h>
> #include <linux/smc.h>
> #include <linux/pci.h>
> #include <rdma/ib_verbs.h>
>@@ -221,12 +222,16 @@ struct smc_buf_desc {
> 					/* virtually contiguous */
> 		};
> 		struct { /* SMC-D */
>+			 /* SMC-D rx buffer: */
> 			unsigned short	sba_idx;
> 					/* SBA index number */
> 			u64		token;
> 					/* DMB token number */
> 			dma_addr_t	dma_addr;
> 					/* DMA address */
>+			/* SMC-D tx buffer */
>+			bool		is_attached;
>+					/* no need for explicit writes */

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

A small sugguestion: there is a hole between sba_idx and token, we can
put is_attached in that hole.
Not a big deal because this is a union and SMC-R use a much large space.

Best regards,
Dust


