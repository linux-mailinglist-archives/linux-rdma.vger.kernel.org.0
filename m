Return-Path: <linux-rdma+bounces-13278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79051B534E4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E27E176FE1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E840338F38;
	Thu, 11 Sep 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ey3i2rE1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFDE3376B3;
	Thu, 11 Sep 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599708; cv=none; b=gRqdF/Jz+COL/C6gErO6oKfvM76YXJztfINtKrr6ZxutoCK+T87uy4mIhNGlqLN8Mc+uZKawquabN6OWIgVJbAK3/1vlxD8QgsDbmLljErbLmyzgcKB35gLsEzurqJtnXOcNLtRgsic/JdCKvzDQz21PTeyPA9DCz/xxmXSUnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599708; c=relaxed/simple;
	bh=kv2eBtjwRALSjkTVtevZKAclp/iDEa+pCYEiho0diGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CNpr8EESqWWIH+7RD9G8LeN+XIhI/aLb0iER4sbUVyPQYODuOoV4sFv8J/5+IHyNX8w+YQJQpKKC74Kcy5S4iMPDVv66EjcobnFGPL0L07eXSiBrtnyjZ9WeAbDIatvDWyfZWnjGJw5d8y6CTtA4wp8OgKRatcRLIe3S3YYONWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ey3i2rE1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDsbmW001261;
	Thu, 11 Sep 2025 14:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VskSST
	rWn5qiOMDBZUp59jFR30JzT7l3J5/tgQkHT1U=; b=ey3i2rE1HdC+KK4R5fP7WR
	uf9S0ggSuytcc8KITJBfC12lJXI00z4DrqgLqtAXrRmFuxTa/YLcttGi7daLXmOK
	oXtxUA1DJwduyk/1TiyHZvRYoIpY9EuPlYRy5g0SvIQebUFWuij897kG1DNmxt0z
	UdpSrxoCTGUUOUgBZ625Kwuqf7vRUk+GURtVJZEGE7z2yfNtEWEaLEINsZNamz+9
	b/Z7E3AF1I0Ibv4x4Y9B0uiv3V27Gha/3CGi3ao8bQ9tAwdJ4goXbDod1Bb+KIe1
	ojpu4WqymHwHXpLIYNNNoiVoFBquc5An0i84vHm+mtRJVh+HYvxDeFN9V8q/tIzA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx5460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:08:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BDxNlZ016077;
	Thu, 11 Sep 2025 14:08:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx545t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:08:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BB6UJ2001177;
	Thu, 11 Sep 2025 14:08:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203nw06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:08:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BE8BMU49873362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:08:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D74B2004E;
	Thu, 11 Sep 2025 14:08:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6DDE20043;
	Thu, 11 Sep 2025 14:08:10 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 14:08:10 +0000 (GMT)
Message-ID: <ede6f320-7b22-4c9a-97d4-86ae1a72d115@linux.ibm.com>
Date: Thu, 11 Sep 2025 16:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] net/dibs: Define dibs_client_ops and
 dibs_dev_ops
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
 <20250905145428.1962105-8-wintera@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250905145428.1962105-8-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oKftr45LpQEyG7Ef2Td-gIIhSpgmncHg
X-Proofpoint-ORIG-GUID: mH_FHjlLYfsUdCsQx47M_m1vDZBo_BY1
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c2d7d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Bgk_8WYZIKrMYqbXgc0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX/OShp/m76CvX
 lcn97czU+GCvByJBeFRc56rzgxcaQTwdrZVcNilSynVLGU8Brh4F7WB+Et0Y4VuCOneoOZBkL8k
 PgkjUEeDdM8lpbdzj9hFt9d1DfkWiaCiPGpF+iDmkJJvCjtz/dQ2ggtNlo6IFdQzxSRaERTyipb
 ZY//ni7neHZ3bzJW/+QXLx9bqYHQenZhz9SOYVEPxCX4IemQq897afBHydH2R6JZYVZF9a+a28L
 /4ZzuXtev+MiVx24s6FO1fOltHosVaY637TjQcGolHVcx1M4nVdltSk2UxcRmGH9LmcydgL33CW
 bThvt4rXrBTrUoJum72E+Y5vg/jdCWgPQrqb6FWKsXcNDo/IBKBmlBddALvFlQQCDKTz/WAbmj9
 N5jhFrn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025



On 05.09.25 16:54, Alexandra Winter wrote:
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index a7a965e3c0ce..d90e11e1a945 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
[...]
> -static void smcd_register_dev(struct ism_dev *ism)
> +static void smcd_register_dev(struct dibs_dev *dibs)
>  {
> -	const struct smcd_ops *ops = ism_get_smcd_ops();
>  	struct smcd_dev *smcd, *fentry;
> +	const struct smcd_ops *ops;
> +	struct smc_lo_dev *smc_lo;
> +	struct ism_dev *ism;
>  
> -	if (!ops)
> -		return;
> +	if (smc_ism_is_loopback(dibs)) {
> +		if (smc_loopback_init(&smc_lo))
> +			return;
> +	}
>  
> -	smcd = smcd_alloc_dev(&ism->pdev->dev, dev_name(&ism->pdev->dev), ops,
> -			      ISM_NR_DMBS);
> +	if (smc_ism_is_loopback(dibs)) {
> +		ops = smc_lo_get_smcd_ops();
> +		smcd = smcd_alloc_dev(dev_name(&smc_lo->dev), ops,
> +				      SMC_LO_MAX_DMBS);
> +	} else {
> +		ism = dibs->drv_priv;
> +		ops = ism_get_smcd_ops();
> +		smcd = smcd_alloc_dev(dev_name(&ism->pdev->dev), ops,
> +				      ISM_NR_DMBS);
> +	}
[...]
>  
>  	if (smcd->ops->supports_v2())
>  		smc_ism_set_v2_capable();

If applied on top of
  091d019adce0 ("net/smc: remove unused function smc_lo_supports_v2")
v6.17-rc1
this will crash during boot with CONFIG_DIBS_LO.
Corrected later in the series by
[PATCH net-next 11/14] net/dibs: Move vlan support to dibs_dev_ops


Fixed in v2.




