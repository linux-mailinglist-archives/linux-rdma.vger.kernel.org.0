Return-Path: <linux-rdma+bounces-14034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B1C041CC
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 04:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD981899DC8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 02:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA523F41A;
	Fri, 24 Oct 2025 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iDlBOWn9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86492288CB;
	Fri, 24 Oct 2025 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272805; cv=none; b=aVPMvWManTmxHCvA6RhsMzRxpeu916xAgjhYZGoTbCPVL/uYcOGJ1X4f+9f2XP/pTHCERyHZ4Zwy60t8eqWvYjVSH5mo4SFDoBKgXFeILR2ninfYrajLGx3TE2KQbdmKk6M7hhZUt0fz0QdC3nzT3mBfVy8SdwHo89Y5kA0NVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272805; c=relaxed/simple;
	bh=wQpmCdnPiZWmAmsFyUglq5MuxoHdirnRwcGRhM90wec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4V+kA4bq9fbXdMfIwrDOrvg70DmuqLt/PN07i6Gu1GbVpMRvoKxwYdVzHbINM+uhwodVXy08klSdLy3VDKWZ9vAHsexJ0RYW4rCxzq5xhVHGf4yPdV0TPcR9PciImR/fCM6BMvTHh3hCFwjUnnVVqQLGICJwOBvi5DQmJBfJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iDlBOWn9; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761272794; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=rMRovXo+3+MpvXSuGPioYnBEqG1+1rhN5W4ESciS63M=;
	b=iDlBOWn9TE0HnZUOdh42Z1zpVlKa+HiZsGMR47kAtBXhnwgBq/AzU+WZuxvQzwP8waTTZ3UvZv3jBNZYmRuxCTDMmjUcCP43cMnalZgrdA5za5wg4OjB+Jx+z/PRKb1lcKYEKNLTw4zcYNYNeUtc5iPXWsMq9+Efm4D62Lr5AoA=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WqskSC1_1761272793 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 10:26:33 +0800
Date: Fri, 24 Oct 2025 10:26:32 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 1/2] dibs: Remove reset of static vars in
 dibs_init()
Message-ID: <aPrj2FCKi5NGPF8u@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20251023150636.3995476-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023150636.3995476-1-wintera@linux.ibm.com>

On 2025-10-23 17:06:35, Alexandra Winter wrote:
>'clients' and 'max_client' are static variables and therefore don't need to
>be initialized.
>
>Reported-by: Mete Durlu <meted@linux.ibm.com>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> drivers/dibs/dibs_main.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
>index 0374f8350ff7..b015578b4d2e 100644
>--- a/drivers/dibs/dibs_main.c
>+++ b/drivers/dibs/dibs_main.c
>@@ -254,9 +254,6 @@ static int __init dibs_init(void)
> {
> 	int rc;
> 
>-	memset(clients, 0, sizeof(clients));
>-	max_client = 0;
>-
> 	dibs_class = class_create("dibs");
> 	if (IS_ERR(dibs_class))
> 		return PTR_ERR(dibs_class);
>-- 
>2.48.1

