Return-Path: <linux-rdma+bounces-13180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A029B4A41F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432A01883225
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D723956E;
	Tue,  9 Sep 2025 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E2X4l/QC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662514A4DB;
	Tue,  9 Sep 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404056; cv=none; b=iNrk7Uqf9AsV9BIaKJQf4skZT0oV+GAuQHykynS6tmNLdBAomL32qzvIMvc1T+NZoNTPvveuhT3DqiuDAlfQzZdaJbZQm/iYXZISYXLQmOpbATxcd6vgx759PXvUmLq/iMT3VrCE2J20iy9rdfXiKqM/WHrChLXKpCFhLdxaGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404056; c=relaxed/simple;
	bh=kGnTWfQ4CTQamoq1+tO49uiXJXP2tJV8KZexcEhb2Ck=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AuwJ8PBG4E0dsbB1YynrAtUv2zF3g8+cMSt7zskDpdjnLh4tt8JmYCbGyf0yqKQbM2AF4wX/7KGG4VecfOvavQdEJU/7xb83kvduBNX+qW7HPspHlqBfkb8e09T9IgUqQ0Zr3otC9i2lgDPGtefNNrUoH+PedoyvME8Cb+9rkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E2X4l/QC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5890j5UZ021177;
	Tue, 9 Sep 2025 07:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RuFYkz
	DaUVnvLTwo9EVa+Uqu9UkrA9PdSg56gb/nZxQ=; b=E2X4l/QCrSUvoYEZgQD2U+
	PeibYsNPcsCjUfMnukqfT9u6VQQ3AJLgaXPYVV477CCJFQXAPKSbmwyzrkNo0DqR
	Y4BQ1ocTWKPBCdl7jgqI20xxq4uEen6Sr1UHMlF8fkBjJkbqa3o/zfIIreMQ4Ztd
	1rsn00iWGTGYlRe9oHx7rq97sNAyV/qW6m5h4XD5hEKcygMUjmlKjXISHfkfWaKo
	Hryz5ZHhBM1Ds/ZFJmArG/m5JnBzUK03t0z7qIT2ip2LKx9MxlNg+GxDwDInoH2y
	Fu1OBZbHdAT3wggwg/uYNt9QqOIEyxXZaLRu2a8vTZh/c+KTK4u2S3G5MzDjGwqA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsp33q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:47:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5897XSbl000405;
	Tue, 9 Sep 2025 07:47:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsp31a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:47:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896fDwU010671;
	Tue, 9 Sep 2025 07:47:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smsxhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:47:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5897l6Y946072148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 07:47:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FC7820043;
	Tue,  9 Sep 2025 07:47:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C436E20040;
	Tue,  9 Sep 2025 07:47:05 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 07:47:05 +0000 (GMT)
Message-ID: <cacb638e-c4ac-4360-b5d2-e7912b3fec50@linux.ibm.com>
Date: Tue, 9 Sep 2025 09:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/14] net/dibs: Move data path to dibs layer
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
 <20250905145428.1962105-14-wintera@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250905145428.1962105-14-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX2ZWSy1JZAgff
 50FPgNX9Zd58PAbdHCACWM6YJfdfORG7R3n2AAC2hmhHylUf+Kbii4lr0RcqCyUDiOODYLWnFS/
 a0DpRUZCe+wpdfr0ZFDVcN9GzdwCIjAvT5CqBbU7P8m53EaMQhWh0TDph0TvI+UHusKkBY0ESgN
 TwIV3bGU1g+vNwpEHp1TEVt3yS8Yu1Azl41rvMflXsPXxUXboSGRVbcA2mO69eIfrAbRDUYblP0
 WKt7Ry7KH+OX6rB6b4sKFtpZi2sYtECOEC44FBwNVwjIQrC72o8eWFyR9gdxdNwwfYVEy0T1ePV
 kgd1dcI8HaaYd5vGceFwFqLIGmL2362aHVhNVFPdZPejE8WSWEmrP7fwxoIP64ZQqvUZh/mqDjW
 ypKdjokN
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bfdb8f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=tDHpZH1iRG1uxDiZJcYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0Yi0iLmGVHNGKu7ZfAVakoLBpTRfpi-D
X-Proofpoint-ORIG-GUID: IQ7K7tnIJnan7JBwr4_IVhObPxZ8WsvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010



On 05.09.25 16:54, Alexandra Winter wrote:
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index c17988531bd8..f4a3e7e56034 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
[...]
>  		smcd->priv = ism;
>  #if IS_ENABLED(CONFIG_ISM)
>  		ism_set_priv(ism, &smc_ism_client, smcd);
> -		smcd->client = &smc_ism_client;
>  #endif
>  	}
>  
> @@ -588,8 +584,6 @@ static void smcd_unregister_dev(struct dibs_dev *dibs)
>  	list_del_init(&smcd->list);
>  	mutex_unlock(&smcd_dev_list.mutex);
>  	destroy_workqueue(smcd->event_wq);
> -	if (smc_ism_is_loopback(dibs))
> -		smc_loopback_exit();
>  	kfree(smcd->conn);
>  	kfree(smcd);
>  }
> @@ -630,10 +624,10 @@ static void smcd_handle_event(struct ism_dev *ism, struct ism_event *event)
>   * Context:
>   * - Function called in IRQ context from ISM device driver IRQ handler.
>   */
> -static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
> +static void smcd_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
>  			    u16 dmbemask)
>  {
> -	struct smcd_dev *smcd = ism_get_priv(ism, &smc_ism_client);
> +	struct smcd_dev *smcd = dibs_get_priv(dibs, &smc_dibs_client);
>  	struct smc_connection *conn = NULL;
>  	unsigned long flags;

Here is another one where the scope of IS_ENABLED(CONFIG_ISM) needs to be changed.
patchwork reports:
+ERROR: modpost: "smcd_handle_irq" [net/smc/smc.ko] undefined!
Per-file breakdown

-> Will be fixed in next version.
At least my compile-check script now also reports it :-S

Actually getting rid of these dependencies is a main motivation for this series for me.

