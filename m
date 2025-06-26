Return-Path: <linux-rdma+bounces-11682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0193AE9EB4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11507188B546
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC92E5433;
	Thu, 26 Jun 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mBhj5Ean"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19A28C009;
	Thu, 26 Jun 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944375; cv=none; b=ksoa58Fp1sbhSqEpEHbiVJ68+RZ+EAdnjrIqwp8iIMkjPQTguHVWbohtG5b+dpjqm+OhXKTs3QtAHT7bF4AsHK2Xly2hEKKWrvG6FV5ni4+JKoMkGu2HdpecxXJlWFaunjHYc6phrqv9X9lHEzRwIZbm5vEeDl+WSKncnir1ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944375; c=relaxed/simple;
	bh=WrztCgo/u9U/MdwKZA9o7yX+ZBLJewFK4uNbWKPb1fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjgQ9YWyajm1g4wSSIako+FYaK9zLoCraNPPtR1YOyz4lE5K+V4if/9im06HRulyBbuM1LIXP9fuPR0mbxz9IQseO2EYF5mD3U+2Ee4Q6QqR60+4+u8zDAiuom6CnPk3jKVhXLkgYU/l6Wny8vM14o/IGEl9okHQYUA8AQKJBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mBhj5Ean; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QBTrMb019605;
	Thu, 26 Jun 2025 13:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KIhS+X
	0s3emxbkTkmLwZ1E9uauCzQCnaacBuXWC4txA=; b=mBhj5Eanlu3oE/dcWEXSON
	bs+nUNHFhj52nhZTNcBcQnD8w4MOqR1APPdKOy/2Z4xqo7W+AlfHq5zcimMH/p7M
	SPoerEsOmWn7EMwali96VcM/n0hJ419D/uqK2I1GxGpeeHHrKz2oUjDKeX2IDvQR
	e8DyC2Z8/a7sMAlTqrOgwjayce/JIKNykjPEnik4k+QyBvx3ICHSumvr835me32j
	pw6sRI5KW1QXWeKspVOSszhIPBkgyV6zT72qSrYqYXuxku+hPfdBeXAEMFgzToNk
	gebjadwYVFjSnB1a30iBWmt+TtehjXzXfa6GDOZ6GcmIL/TAyooEzyV6KSgnwg8g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3eb8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 13:25:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QDG2ji007108;
	Thu, 26 Jun 2025 13:25:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3eb8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 13:25:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55QD932l003994;
	Thu, 26 Jun 2025 13:25:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kxu6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 13:25:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QDPce926018338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 13:25:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27C3E58056;
	Thu, 26 Jun 2025 13:25:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24AB5803F;
	Thu, 26 Jun 2025 13:25:31 +0000 (GMT)
Received: from [9.43.40.242] (unknown [9.43.40.242])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 13:25:31 +0000 (GMT)
Message-ID: <59f869f7-586b-4021-b44d-dfd5df36d17a@linux.ibm.com>
Date: Thu, 26 Jun 2025 18:55:30 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/9] net/smc: Drop nr_pages_max initialization
To: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Neal Cardwell <ncardwell@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685d4a55 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WDAXKTNUUXuyYHq0jyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDExMiBTYWx0ZWRfXy3bcL4KxEbLd qBpE+zXX99M5NXGzAZREjCuHb+lSyQK/AuEmVpmsTwmc6w3jMPFpoS6yLoICU6wkS+ebCvSdM2P yIgGPCsQPpD7KZoLsgjUGqbHDqHqNTLXr/yY5zc4JP5jrc6NPNAkyoZB1ZEiAuOLXPZZG8v7UOS
 x3Wh8HgNZnewlgj/ZIAg4bB9sEtlP09rKfcXucJbpKqLrRxHEfcgkAdlOAYu3Sg0bPcwR42/SQK kPAUfm1RVb7a6I66nG14rCcSleb1Te1++q1TeGJOxa2zVOvXsyaTT5rKIVdrL8mX1fOoFr7M7kz +tOkqOsr9ue6Ql7vrQRm9oUb1rnBoUuNvrGsrxMOwwYxay1tP+50OuJF1FZo7ME76DCujjM/HnJ
 hwMcproKNFhT195vJbBB4Hc4pLCusxWDl5P43/Rbo/TIW/DAbWWnWhYppko8zmbuHrGlVZcY
X-Proofpoint-GUID: mXg7mT2CW3aKLbyhfQI2l7s2PzaJ7Rh8
X-Proofpoint-ORIG-GUID: ib18akj9XBROQCGZlfP3AB-I4y3i0s5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260112



On 26/06/25 2:03 pm, Michal Luczaj wrote:
> splice_pipe_desc::nr_pages_max was initialized unnecessarily in
> commit b8d199451c99 ("net/smc: Allow virtually contiguous sndbufs or RMBs
> for SMC-R"). Struct's field is unused in this context.
> 
> Remove the assignment. No functional change intended.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>   net/smc/smc_rx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index e7f1134453ef40dd81a9574d6df4ead95acd8ae5..bbba5d4dc7eb0dbb31a9800023b0caab33e87842 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
> @@ -202,7 +202,6 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
>   			offset = 0;
>   		}
>   	}
> -	spd.nr_pages_max = nr_pages;
>   	spd.nr_pages = nr_pages;
>   	spd.pages = pages;
>   	spd.partial = partial;
> 
LGTM.
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

