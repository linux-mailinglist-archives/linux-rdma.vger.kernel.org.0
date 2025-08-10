Return-Path: <linux-rdma+bounces-12641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA6B1FA56
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0F1897C3B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA6261574;
	Sun, 10 Aug 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uq3rfduX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07323AD51;
	Sun, 10 Aug 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834883; cv=none; b=u8XlG0FafPYcS2Rdqn+0il/alhfgtpIkcJ7uL9xvkyi6spHrS1QpI2HVZTmgLYsBLTM6fcr/+KHqAbH8xCe4uCAr1u7SnLOfhcgul83z2wMGvEz2lsrVYPBOP03dofMef5BpoYMAWvE0+YlSHClDKU5w91pM8HjTQ4hEn3rnF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834883; c=relaxed/simple;
	bh=qVRkzZvzPdBekjycalq5skMDXPDtqFBpZlTX7g2Gs50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrWdvnMNm6kvVGeEoubCaN7ny+YPYiJS2eEcqu3Pj7nFw0R0eVXUxr0WhW35ik/0UZP7pkuDjdMPS05rkWnEZ+hS4odGV7PuWj6lTprYB76LdmXEi4thcPWdw9JHB4w1aErcZTKvm5j9My4BU3cjW0St7oHQ4FoG+bVtjCMnVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uq3rfduX; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754834858; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=9Z2iDYVYqr88DsRR2IRi94pyfVlJ3id41jS49K9dm2s=;
	b=uq3rfduXQOApBwro6VrWu8Wof9jlOkSfl9hZVfXMKhW9Znau3hYdARYhnt5u8zNziQ6CIrbWpO/Ve7Eiuy8h/yhfkSZt5n17xmSPwzLFglehWw93wNvG94ru0Q47iIuG5NbkfnuhmgpxeG//2RhoZ5XpspKfX/HI4fXKU+kObso=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlMT66R_1754834856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 Aug 2025 22:07:37 +0800
Date: Sun, 10 Aug 2025 22:07:36 +0800
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
Subject: Re: [RFC net-next 05/17] net/smc: Improve log message for devices
 w/o pnetid
Message-ID: <aJinqObGQ-OHjadu@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-6-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-6-wintera@linux.ibm.com>

On 2025-08-06 17:41:10, Alexandra Winter wrote:
>Explicitly state in the log message, when a device has no pnetid.
>"with pnetid" and "has pnetid" was misleading for devices without pnetid.
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

This patch doesn't seem strongly related to this patchset, so it might
be better to send this patch separately.

Best regards,
Dust

>---
> net/smc/smc_ib.c  | 18 +++++++++++-------
> net/smc/smc_ism.c | 13 +++++++++----
> 2 files changed, 20 insertions(+), 11 deletions(-)
>
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 53828833a3f7..f2de12990b5b 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -971,13 +971,17 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
> 					   smcibdev->pnetid[i]))
> 			smc_pnetid_by_table_ib(smcibdev, i + 1);
> 		smc_copy_netdev_ifindex(smcibdev, i);
>-		pr_warn_ratelimited("smc:    ib device %s port %d has pnetid "
>-				    "%.16s%s\n",
>-				    smcibdev->ibdev->name, i + 1,
>-				    smcibdev->pnetid[i],
>-				    smcibdev->pnetid_by_user[i] ?
>-				     " (user defined)" :
>-				     "");
>+		if (smc_pnet_is_pnetid_set(smcibdev->pnetid[i]))
>+			pr_warn_ratelimited("smc:    ib device %s port %d has pnetid %.16s%s\n",
>+					    smcibdev->ibdev->name, i + 1,
>+					    smcibdev->pnetid[i],
>+					    smcibdev->pnetid_by_user[i] ?
>+						" (user defined)" :
>+						"");
>+		else
>+			pr_warn_ratelimited("smc:    ib device %s port %d has no pnetid\n",
>+					    smcibdev->ibdev->name, i + 1);
>+
> 	}
> 	schedule_work(&smcibdev->port_event_work);
> 	return 0;
>diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>index 7363f8be9f94..503a9f93b392 100644
>--- a/net/smc/smc_ism.c
>+++ b/net/smc/smc_ism.c
>@@ -515,10 +515,15 @@ static void smcd_register_dev(struct ism_dev *ism)
> 	}
> 	mutex_unlock(&smcd_dev_list.mutex);
> 
>-	pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
>-			    dev_name(&ism->dev), smcd->pnetid,
>-			    smcd->pnetid_by_user ? " (user defined)" : "");
>-
>+	if (smc_pnet_is_pnetid_set(smcd->pnetid))
>+		pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
>+				    dev_name(&ism->dev), smcd->pnetid,
>+				    smcd->pnetid_by_user ?
>+					" (user defined)" :
>+					"");
>+	else
>+		pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
>+				    dev_name(&ism->dev));
> 	return;
> }
> 
>-- 
>2.48.1

