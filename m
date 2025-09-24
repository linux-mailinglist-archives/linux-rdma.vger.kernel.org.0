Return-Path: <linux-rdma+bounces-13631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CCB9B0E5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E45419C5B84
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A15314B71;
	Wed, 24 Sep 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MZMO3RPF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FC20E6;
	Wed, 24 Sep 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734938; cv=none; b=faWBRLfA8wJ/yNB6wi5LgKLfH0L6VIuf0XlD0Z3XXx4oJhF5R6kddhw1eWpeRsgnXNLljPzugc/oCNJEWanf3yHUcJpZDdF5Aw08FoAQy4kVzockAZUhcnqoFJrO/4L1h9erXtc/TUFKK6DpLUAuTWgwrzntT06HdltGpjlVRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734938; c=relaxed/simple;
	bh=z4DIULKK9DHxBUUPcsZkEgf19jq4cn1uupXwqDbaLHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E3V7doSlRfyEiYvVwL0qFsu4JswnWITpJdcbwGOL/EtgW9P+3UZWDp/3fZ7C+gJPbcsh8bt0CAx1SqUTWyMU4cYGwujnMqJo31TPKQzovwnA4BawrGYUaApC7ma0BFpJ7SRNlvzCI2ZJsIFh0zMgQV+TCUbLO3A7UbDOKz17td4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MZMO3RPF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OAV15t014106;
	Wed, 24 Sep 2025 17:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=89mf8n
	mV4wgznDIULP/pM2jg8xpZGd19lxv+F+NW5Ug=; b=MZMO3RPFzYZ8Po9k7UYymX
	4JnucHk0Yi2dAdvPSagbFp1HQLE3wMa6mmqSRJuGANqVug0oUPtYBbC0zVlSPM8x
	l4oF44qPTsrOhnx3SyzBPhU1nY/3IE5SiZDiaWaUjTtkB4JFKiG0IfOwvzRXpeTy
	JnFAg/K0GR9X7bSUs808vjcVxIQnZ/cMKPhpwmRCKz5VdIbt1GHt7CgFlK04p1Dl
	r/h9z1nPKRXjEYl+3C7YjIxDjZERUXfIu9Zzw1o5I2YEzrcR3/fkpNdPlrSBMlNf
	OB/dwWZJzirZdmkvAzBD2OwaUkTUanPlJbTqfdX+giLmMTHt92flSWF3vwnCGDrA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky692hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:28:52 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OHQmm6004430;
	Wed, 24 Sep 2025 17:28:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky692hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:28:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGb4cJ008311;
	Wed, 24 Sep 2025 17:28:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yy1xaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:28:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OHSntN10945450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:28:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CB1D58056;
	Wed, 24 Sep 2025 17:28:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26EAD58052;
	Wed, 24 Sep 2025 17:28:44 +0000 (GMT)
Received: from [9.124.221.141] (unknown [9.124.221.141])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 17:28:43 +0000 (GMT)
Message-ID: <51015767-e6bd-4ff0-9904-8a643d209e44@linux.ibm.com>
Date: Wed, 24 Sep 2025 22:58:42 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6dfoYFWJVM3bl7UVyj21obfbrJPJz6TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX50N95z35/A5I
 9nvMbTUiOuXa3mRALRQc6AzA/DUPvm2GpSL+hvZGUUi579t1XobAWjijy+PK69ohgPA2r9W0sL/
 iXL6WgwFaXgu9Gf3kG/gZAXle/zfHORyCxc59i4OLbhFzgaG4doWZ4W2vvcOx9nhHdGMWoWEphe
 f8+wzEvVaZQsLKDwkOJrhhFzwByI910hYs2oRy164kq7RrOjfr7vSVUjbX47QRgdkrXnzi+iiqs
 rpsixj3wIspuMfUlPlMn1dCV3uaIC1Fjd1s+HM25WjMNmiTIZTbPPLPR1hOSW8F63FCREyKBqOW
 +oW/tN6/Yw9VDw/bvCdFdDttnsoKfEx61iMUBwwWE1DtTKsXRyckoxVZiY/YlrXJhic/HA8w5SU
 tKeggRw/
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d42a54 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=MWbO73gf5tkkDqYFIcsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eyRpgr6Claa1dHKPEDJXfTH1WShvB5I9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020



On 22/09/25 3:14 am, Halil Pasic wrote:
> Currently if a -ENOMEM from smc_wr_alloc_link_mem() is handled by
> giving up and going the way of a TCP fallback. This was reasonable
> before the sizes of the allocations there were compile time constants
> and reasonably small. But now those are actually configurable.
> 
> So instead of giving up, keep retrying with half of the requested
> size unless we dip below the old static sizes -- then give up!
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> ---
>  Documentation/networking/smc-sysctl.rst |  8 ++++--
>  net/smc/smc_core.c                      | 34 +++++++++++++++++--------
>  net/smc/smc_core.h                      |  2 ++
>  net/smc/smc_wr.c                        | 28 ++++++++++----------
>  4 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index c94d750c7c84..c8dbe7ac8bdf 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -85,7 +85,9 @@ smcr_max_send_wr - INTEGER
>  
>  	Please be aware that all the buffers need to be allocated as a physically
>  	continuous array in which each element is a single buffer and has the size
> -	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
> +	with half of the buffer count until it is ether successful or (unlikely)
> +	we dip below the old hard coded value which is 16 where we give up much
>  	like before having this control.
>  
>  	Default: 16
> @@ -103,7 +105,9 @@ smcr_max_recv_wr - INTEGER
>  
>  	Please be aware that all the buffers need to be allocated as a physically
>  	continuous array in which each element is a single buffer and has the size
> -	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
> +	with half of the buffer count until it is ether successful or (unlikely)
> +	we dip below the old hard coded value which is 16 where we give up much
>  	like before having this control.
>  
>  	Default: 48
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 2a559a98541c..f8131b4dfcd6 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	lnk->clearing = 0;
>  	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
>  	lnk->link_id = smcr_next_link_id(lgr);
> +	lnk->max_send_wr = lgr->max_send_wr;
> +	lnk->max_recv_wr = lgr->max_recv_wr;
>  	lnk->lgr = lgr;
>  	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
>  	lnk->link_idx = link_idx;
> @@ -836,27 +838,39 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	rc = smc_llc_link_init(lnk);
>  	if (rc)
>  		goto out;
> -	rc = smc_wr_alloc_link_mem(lnk);
> -	if (rc)
> -		goto clear_llc_lnk;
>  	rc = smc_ib_create_protection_domain(lnk);
>  	if (rc)
> -		goto free_link_mem;
> -	rc = smc_ib_create_queue_pair(lnk);
> -	if (rc)
> -		goto dealloc_pd;
> +		goto clear_llc_lnk;
> +	do {
> +		rc = smc_ib_create_queue_pair(lnk);
> +		if (rc)
> +			goto dealloc_pd;
> +		rc = smc_wr_alloc_link_mem(lnk);
> +		if (!rc)
> +			break;
> +		else if (rc != -ENOMEM) /* give up */
> +			goto destroy_qp;
> +		/* retry with smaller ... */
> +		lnk->max_send_wr /= 2;
> +		lnk->max_recv_wr /= 2;
> +		/* ... unless droping below old SMC_WR_BUF_SIZE */
> +		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
> +			goto destroy_qp;
> +		smc_ib_destroy_queue_pair(lnk);
> +	} while (1);
> +
>  	rc = smc_wr_create_link(lnk);
>  	if (rc)
> -		goto destroy_qp;
> +		goto free_link_mem;
>  	lnk->state = SMC_LNK_ACTIVATING;
>  	return 0;
>  
> +free_link_mem:
> +	smc_wr_free_link_mem(lnk);
>  destroy_qp:
>  	smc_ib_destroy_queue_pair(lnk);
>  dealloc_pd:
>  	smc_ib_dealloc_protection_domain(lnk);
> -free_link_mem:
> -	smc_wr_free_link_mem(lnk);
>  clear_llc_lnk:
>  	smc_llc_link_clear(lnk, false);
>  out:
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index ab2d15929cb2..b9addf633d8a 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -174,6 +174,8 @@ struct smc_link {
>  	struct completion	llc_testlink_resp; /* wait for rx of testlink */
>  	int			llc_testlink_time; /* testlink interval */
>  	atomic_t		conn_cnt; /* connections on this link */
> +	u16			max_send_wr;
> +	u16			max_recv_wr;
>  };
>  
>  /* For now we just allow one parallel link per link group. The SMC protocol
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index f5b2772414fd..6b14711f0c93 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -548,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  		    IB_QP_DEST_QPN,
>  		    &init_attr);
>  
> -	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
> +	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
>  			       lnk->qp_attr.cap.max_send_wr);
> -	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
> +	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
>  			       lnk->qp_attr.cap.max_recv_wr);
>  }
>  
> @@ -742,51 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
>  int smc_wr_alloc_link_mem(struct smc_link *link)
>  {
>  	/* allocate link related memory */
> -	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
> +	link->wr_tx_bufs = kcalloc(link->max_send_wr,
>  				   SMC_WR_BUF_SIZE, GFP_KERNEL);
>  	if (!link->wr_tx_bufs)
>  		goto no_mem;
> -	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, link->wr_rx_buflen,
> +	link->wr_rx_bufs = kcalloc(link->max_recv_wr, link->wr_rx_buflen,
>  				   GFP_KERNEL);
>  	if (!link->wr_rx_bufs)
>  		goto no_mem_wr_tx_bufs;
> -	link->wr_tx_ibs = kcalloc(link->lgr->max_send_wr,
> +	link->wr_tx_ibs = kcalloc(link->max_send_wr,
>  				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
>  	if (!link->wr_tx_ibs)
>  		goto no_mem_wr_rx_bufs;
> -	link->wr_rx_ibs = kcalloc(link->lgr->max_recv_wr,
> +	link->wr_rx_ibs = kcalloc(link->max_recv_wr,
>  				  sizeof(link->wr_rx_ibs[0]),
>  				  GFP_KERNEL);
>  	if (!link->wr_rx_ibs)
>  		goto no_mem_wr_tx_ibs;
> -	link->wr_tx_rdmas = kcalloc(link->lgr->max_send_wr,
> +	link->wr_tx_rdmas = kcalloc(link->max_send_wr,
>  				    sizeof(link->wr_tx_rdmas[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_rdmas)
>  		goto no_mem_wr_rx_ibs;
> -	link->wr_tx_rdma_sges = kcalloc(link->lgr->max_send_wr,
> +	link->wr_tx_rdma_sges = kcalloc(link->max_send_wr,
>  					sizeof(link->wr_tx_rdma_sges[0]),
>  					GFP_KERNEL);
>  	if (!link->wr_tx_rdma_sges)
>  		goto no_mem_wr_tx_rdmas;
> -	link->wr_tx_sges = kcalloc(link->lgr->max_send_wr, sizeof(link->wr_tx_sges[0]),
> +	link->wr_tx_sges = kcalloc(link->max_send_wr, sizeof(link->wr_tx_sges[0]),
>  				   GFP_KERNEL);
>  	if (!link->wr_tx_sges)
>  		goto no_mem_wr_tx_rdma_sges;
> -	link->wr_rx_sges = kcalloc(link->lgr->max_recv_wr,
> +	link->wr_rx_sges = kcalloc(link->max_recv_wr,
>  				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
>  				   GFP_KERNEL);
>  	if (!link->wr_rx_sges)
>  		goto no_mem_wr_tx_sges;
> -	link->wr_tx_mask = bitmap_zalloc(link->lgr->max_send_wr, GFP_KERNEL);
> +	link->wr_tx_mask = bitmap_zalloc(link->max_send_wr, GFP_KERNEL);
>  	if (!link->wr_tx_mask)
>  		goto no_mem_wr_rx_sges;
> -	link->wr_tx_pends = kcalloc(link->lgr->max_send_wr,
> +	link->wr_tx_pends = kcalloc(link->max_send_wr,
>  				    sizeof(link->wr_tx_pends[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_pends)
>  		goto no_mem_wr_tx_mask;
> -	link->wr_tx_compl = kcalloc(link->lgr->max_send_wr,
> +	link->wr_tx_compl = kcalloc(link->max_send_wr,
>  				    sizeof(link->wr_tx_compl[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_compl)
> @@ -907,7 +907,7 @@ int smc_wr_create_link(struct smc_link *lnk)
>  		goto dma_unmap;
>  	}
>  	smc_wr_init_sge(lnk);
> -	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->max_send_wr);
> +	bitmap_zero(lnk->wr_tx_mask, lnk->max_send_wr);
>  	init_waitqueue_head(&lnk->wr_tx_wait);
>  	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
>  	if (rc)

Code changes looks good to me.
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

