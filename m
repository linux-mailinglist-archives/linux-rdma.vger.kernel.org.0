Return-Path: <linux-rdma+bounces-2765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A938A8D7A8F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 05:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C2281586
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 03:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D05101F4;
	Mon,  3 Jun 2024 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AkUcqDim"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6FEAD7;
	Mon,  3 Jun 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386584; cv=none; b=golCAM0UQruGkzKG4fi1PV/gDwJB0wt/SFPSK0Cv3ZXMV6AjSCW/7LVh6HzuwbMS2JMbpsQzQkCXTR7bjdm4HoD0e/U3VeKgui1IresP5Ko9p9hsbAW5abRIc9TDE7hS+W9s6KYLWvhRFadDte9S4idtB+cPCjKzU/l70kUr+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386584; c=relaxed/simple;
	bh=s19cZwl3TWGGoCSC1PEgttR3nT0kx/iwRjw/DMODQpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnSJSHDM0/yQS82hTVy0mN/fMVKA7ZxfgVkJTeS+jWeef8zTWRBrkU91xOMEQ97fN4Er9SI7LFTLFQE8p0udW+7Wn9wCWOC8MhCbyAS9j4AFYYgDHWADiuFb33VdEaFEkJFrbFit2nLb3JW5gN5uC0dg/TSkNBFUOKgNdLXBbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AkUcqDim; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452NeXha028073;
	Sun, 2 Jun 2024 20:49:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=1f2cQnH/sIZVwp5/0S4/h40TC
	6bfWgDXScC2hPrdk8k=; b=AkUcqDimkvFr0KBRoAcbjOgx2CGa9508jY4iGFQir
	sicrRFQYo8aCHnoXX4EICF7FlPb/2xwO4CJ9Nb/yKljbVo4nWAjvTxe+hGyf44+7
	8/9pe90AdsJg+hDwLLx4oMaJf7a3s+TBQ9Cg9cXOK5ljzrjL6Enj9Yzxi9/6i6v1
	oc6vX5rMbP3FgztMpjzFIxcyAscIj1l+olem0FKVJCCsRX6LV8RyieOqnvp2CTVq
	WT+uxXCSqMZPC9e5G5P6BP9H/pDi5rnrNYhL8DXHY457yi7WEjDkH1KswmD3NnJ8
	2pmOl1PoEWavdEe7AnXO1ODi+M8xys5vRyvPG0dv0Ly+w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ygufms549-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 20:49:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 2 Jun 2024 20:49:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 2 Jun 2024 20:49:06 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3CD5D3F7066;
	Sun,  2 Jun 2024 20:49:01 -0700 (PDT)
Date: Mon, 3 Jun 2024 09:19:01 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
CC: <kgraul@linux.ibm.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
        <wintera@linux.ibm.com>, <guwen@linux.alibaba.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <tonylu@linux.alibaba.com>, <pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH net-next v5 3/3] net/smc: Introduce IPPROTO_SMC
Message-ID: <20240603034901.GA3254291@maili.marvell.com>
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
 <1717061440-59937-4-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1717061440-59937-4-git-send-email-alibuda@linux.alibaba.com>
X-Proofpoint-ORIG-GUID: z0_JaKrGWlGQL8yDx2nt7tQVckTiMsVA
X-Proofpoint-GUID: z0_JaKrGWlGQL8yDx2nt7tQVckTiMsVA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01

On 2024-05-30 at 15:00:40, D. Wythe (alibuda@linux.alibaba.com) wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> +
> +int __init smc_inet_init(void)
> +{
> +	int rc;
> +
> +	rc = proto_register(&smc_inet_prot, 1);
> +	if (rc) {
> +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
> +		return rc;
> +	}
> +	/* no return value */
> +	inet_register_protosw(&smc_inet_protosw);
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	rc = proto_register(&smc_inet6_prot, 1);
> +	if (rc) {
> +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
> +		goto out_inet6_prot;
> +	}
> +	rc = inet6_register_protosw(&smc_inet6_protosw);
> +	if (rc) {
> +		pr_err("%s: inet6_register_protosw smc_inet6_protosw fails with %d\n",
> +		       __func__, rc);
> +		goto out_inet6_protosw;
> +	}
> +#endif /* CONFIG_IPV6 */
> +
> +	return rc;
> +#if IS_ENABLED(CONFIG_IPV6)
Can you combine this #if with above one ? Any way you need this only in case of ipv6.
Error handling with #if is an hindrance to a good readability.

> +out_inet6_protosw:
> +	proto_unregister(&smc_inet6_prot);
> +out_inet6_prot:
> +	inet_unregister_protosw(&smc_inet_protosw);
> +	proto_unregister(&smc_inet_prot);
> +	return rc;
> +#endif /* CONFIG_IPV6 */
> +}
> +
> +void smc_inet_exit(void)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	inet6_unregister_protosw(&smc_inet6_protosw);
> +	proto_unregister(&smc_inet6_prot);
> +#endif /* CONFIG_IPV6 */
> +	inet_unregister_protosw(&smc_inet_protosw);
> +	proto_unregister(&smc_inet_prot);
> +}
> diff --git a/net/smc/smc_inet.h b/net/smc/smc_inet.h
> new file mode 100644
> index 00000000..a489c8a
> --- /dev/null
> +++ b/net/smc/smc_inet.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
> + *
> + *  Definitions for the IPPROTO_SMC (socket related)
> +
> + *  Copyright IBM Corp. 2016
> + *  Copyright (c) 2024, Alibaba Inc.
> + *
> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
> + */
> +#ifndef __INET_SMC
> +#define __INET_SMC
> +
> +/* Initialize protocol registration on IPPROTO_SMC,
> + * @return 0 on success
> + */
> +int smc_inet_init(void);
> +
> +void smc_inet_exit(void);
> +
> +#endif /* __INET_SMC */
> --
> 1.8.3.1
>

