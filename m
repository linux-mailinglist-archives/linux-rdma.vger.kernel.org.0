Return-Path: <linux-rdma+bounces-5367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A96BE998DBD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB79DB3044A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662E11CDFA4;
	Thu, 10 Oct 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IBux6Cgd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAC1CCB26;
	Thu, 10 Oct 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576555; cv=none; b=Z3rTWqzkUkznvngdF+0ksmdzzlLA1qwIhYD7FvlhdqTN9gcnRSVP532qrdOwArW1HHfNzo1exo1jCH342TqJk5k66DihpFvQ1m6cYOR92FNdj8Z2Keb/V4KZNXsM3yLqgoy9KF/JDDuIL5Oo36QuqyFu1pe3iLqkJXTrpBzrrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576555; c=relaxed/simple;
	bh=MCuPH8xpaKC8KRwyBbb6RnRX8I2bzEkR57xNS3ocq8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0ypwnjLa7V/WYjpEcm56h+wLH1Ztzx1AOvV/gSL4DR86lYxckk3etH5ze2hbbirmgqYIIeK4aEMbbLrUTPRuT3ALJ1pVw8JDklOhnXvqMMDLwTSLaJ6QbAAUGW3mcA5SdjjIYd1YJ2x7euC36/JGRiacd7hXGjRahCgUWLNgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IBux6Cgd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AFuJcP028520;
	Thu, 10 Oct 2024 16:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=u
	sdQ7OwttGgqNiri5YP1Yx9Pjq5rfa7V54jNcOvROmo=; b=IBux6CgdXJ3fJqipA
	V5hSOSLqamARIAqrSSUHMgyq/pEyp4hdcdXmM1cmRNW3OR0GFBjBBu6j9P+45ASB
	+PSR28PtqlYnh0aqlgvlcc3GzBnGJtHe2MJbx4nQ+uBH6qnN+CzcgmisFotsmFwj
	Me8wS5ZQQrXzX6mgm8GKr8WLXMAqr2nEtdKSI8zJzV6NuMmiIuMWNU5/4jGhlk17
	OZoKlW0lBu8+5pwsHlBgxvyg5nDTNgMv8BfXssPpITotJ64v000OGS6u62uBo7Zv
	oo39ekGRk/oc86X+BsbGbpbDCb+3eRelVRX/seO110TcyPx33MG/XqwAx2CtiJgf
	LBhSA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426j0qr2a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:09:08 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49AG97WW027758;
	Thu, 10 Oct 2024 16:09:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426j0qr2a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:09:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49AFUDBf013838;
	Thu, 10 Oct 2024 16:09:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fssgvqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:09:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49AG96wP32637430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 16:09:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B34858071;
	Thu, 10 Oct 2024 16:09:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6D958069;
	Thu, 10 Oct 2024 16:09:04 +0000 (GMT)
Received: from [9.179.5.163] (unknown [9.179.5.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 16:09:03 +0000 (GMT)
Message-ID: <e5a3f5a9-34e1-4575-a1a3-1205afe5ab17@linux.ibm.com>
Date: Thu, 10 Oct 2024 18:09:03 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix memory leak when using percpu refs
To: Kai Shen <KaiShen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org
Cc: davem@davemloft.net, tonylu@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241010115624.7769-1-KaiShen@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241010115624.7769-1-KaiShen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ng1D360P5HDybVhCZ33_WUjBc_bYdOzK
X-Proofpoint-ORIG-GUID: XtgRetAZz8neMJpcXMMjj3bSfxFWhK9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=972 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100106



On 10.10.24 13:56, Kai Shen wrote:
> This patch adds missing percpu_ref_exit when releasing percpu refs.
> When releasing percpu refs, percpu_ref_exit should be called.
> Otherwise, memory leak happens.
> 
> Fixes: 79a22238b4f2 ("net/smc: Use percpu ref for wr tx reference")
> Signed-off-by: Kai Shen <KaiShen@linux.alibaba.com>
> ---
>   net/smc/smc_wr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 0021065a600a..994c0cd4fddb 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -648,8 +648,10 @@ void smc_wr_free_link(struct smc_link *lnk)
>   	smc_wr_tx_wait_no_pending_sends(lnk);
>   	percpu_ref_kill(&lnk->wr_reg_refs);
>   	wait_for_completion(&lnk->reg_ref_comp);
> +	percpu_ref_exit(&lnk->wr_reg_refs);
>   	percpu_ref_kill(&lnk->wr_tx_refs);
>   	wait_for_completion(&lnk->tx_ref_comp);
> +	percpu_ref_exit(&lnk->wr_tx_refs);
>   
>   	if (lnk->wr_rx_dma_addr) {
>   		ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
> @@ -912,11 +914,13 @@ int smc_wr_create_link(struct smc_link *lnk)
>   	init_waitqueue_head(&lnk->wr_reg_wait);
>   	rc = percpu_ref_init(&lnk->wr_reg_refs, smcr_wr_reg_refs_free, 0, GFP_KERNEL);
>   	if (rc)
> -		goto dma_unmap;
> +		goto cancel_ref;
>   	init_completion(&lnk->reg_ref_comp);
>   	init_waitqueue_head(&lnk->wr_rx_empty_wait);
>   	return rc;
>   
> +cancel_ref:
> +	percpu_ref_exit(&lnk->wr_tx_refs);
>   dma_unmap:
>   	if (lnk->wr_rx_v2_dma_addr) {
>   		ib_dma_unmap_single(ibdev, lnk->wr_rx_v2_dma_addr,

It looks reasonable to me. Thanks for the fix!
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia


