Return-Path: <linux-rdma+bounces-13145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B3B484A7
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C014B177B36
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656472E2EF3;
	Mon,  8 Sep 2025 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ljGmc3CQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E621AC44D;
	Mon,  8 Sep 2025 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314876; cv=none; b=ttm+Q9d1AugtqyGu7eujB/Wg6Zoip999VVNRqs6rfmnJyOKyCYik8Qo75vffi6sW0SDKmoqxnlgBAPmD+Sn1vTuAMYtBTLbFtzGrxBZbVr2RLwyzkzSNJscK8DoKJXfcqF/XqcKKN4dibbQOIUlfb4uPw5oaOoLyXT/nTC8EWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314876; c=relaxed/simple;
	bh=JTG8Vjyzeek0yp8Umwgx5adzgK5gLjnyHxzA41oG9gc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HruWWgw6IFeu3Ad/4VXxC41spLOO2Ke16/NRwGetKue1rwgdEOoOkcQxEwWfWlosPfHun5vNfBeSljxkJXxtRaCgdUVFYb9y35Ferm3VeEA4d9J9Dw+cWuEd3QBKGL+awv5azxyz5Xh9GMPk2YewUPbbmHvAdS3PtwMNMx+LBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ljGmc3CQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587No7AG003430;
	Mon, 8 Sep 2025 07:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gw9hGx
	0intHmWsLypYyWMC3j2vWjYhdPAEOW7ZIt4+U=; b=ljGmc3CQBKcYGF+C+0AKK7
	B31+g8uV+2niQZ3tCLC+03QaFXouVPM6PsfqCNpcKwAW8sDEPB5xfC09Wg+7iLZJ
	b+ce970iS+c1uDbI8kLr+ZxKpDf3E5GBejZEwUJtQafWKLyvAgJYwrOMDXbal7Jx
	JXVQVoc6O+1/a2fTEomgdGZTw4tqCXVDRBDrwnpUux+83NBE5vuYXGCYrNPG4cRr
	f51wlbpevbkbX7/qmv7dw4GZDJAODgqp242oxDIr6PiqAevGDz1xIhrmANiZt6sd
	AOY1kN4jU4DnsEAWwV36AUn29Fj0DvgCLVUskv3/G4q+2DNifZ4aKhBSZkrxKtqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfeyp7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:01:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5886pCVR024915;
	Mon, 8 Sep 2025 07:01:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfeyp74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:01:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5885P9Sk010613;
	Mon, 8 Sep 2025 07:01:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smmpyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:01:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588710K235455318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 07:01:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7CA20043;
	Mon,  8 Sep 2025 07:01:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E7A20040;
	Mon,  8 Sep 2025 07:00:59 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 07:00:59 +0000 (GMT)
Message-ID: <342016da-09f2-47ff-943c-a4f1cded12e6@linux.ibm.com>
Date: Mon, 8 Sep 2025 09:00:59 +0200
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
X-Proofpoint-ORIG-GUID: WcnUc-kqzmFauGh1X4141hjqnLPVmaLb
X-Proofpoint-GUID: _99NiMRaFUyd4hhUYIZH35sGiZGGrGr0
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68be7f32 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=lvVYJMmxSKhX19yQhwUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX6P/GVE5M6gLZ
 crlynzfWBShpoWYlyUzypn5UHA9VxP/uNsvv1P9g8rI1Aog2l5KFfDlwaBW/Q/igccfY+uS2Pbg
 /1v10ND5cf6R0xYfVl2aNybjIXqrTN/eeddtf4dWNNG6sIOYtwnnlX9X3ZGDxDib4iih1jt964D
 ONSkOlhhtwBXGlolgd36TC4ZU+3d5MnjWqZrPSSZPAVRTv0pbD9PE1AqtQAzIhq1rUWd9gwrccr
 4JCYPNsASn8lSvMJEcHNQxdrZw4KojMWBKMaT+a2XEj83R6vN3MuxtJ+kguj6D/SyzUwIp8jdjj
 CixiGitN4gXe+DeE08bkYzGRQeqZefDOsnpLRs2g4I8/2eMV4zs+RpLulZ3miggS5KxxHfTg81T
 uH/H4CFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 05.09.25 16:54, Alexandra Winter wrote:
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index a7a965e3c0ce..d90e11e1a945 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
[..]
>  
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

Patchwork says:
ERROR: modpost: "ism_get_smcd_ops" [net/smc/smc.ko] undefined!

ARGH!! another transient compile error when CONFIG_ISM is not set!
(whole series does compile, but not if you compile e.g. only up to this patch)
I thought I had tested all combinations, sorry about that.
I'll work on fixing it and on improving my script.

