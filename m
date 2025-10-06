Return-Path: <linux-rdma+bounces-13780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA4BBD171
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 07:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6FF3B0F29
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096B24A076;
	Mon,  6 Oct 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FKDpCBkg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E9243954;
	Mon,  6 Oct 2025 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759730146; cv=none; b=Eb3LSA0LSkYCGaM679m2GERqWZpJk1ikBrTTAn4ZIdgHOrcs2bC3JleYyVzzQZIV5Y8MVb7YShb1Gg8c3v8ikaFLdVNYCwsg471lE060ZWHbKjdVaVAyvls/aNaat00uRxZg5GAS/Z2WfPaL4QkjY0mteBW7bjQyPtDru7BEjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759730146; c=relaxed/simple;
	bh=lVqnxG3KC25qa5DVh4AyhsAPiHaMQQPOhootVnvdlIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MqUCDgJzH2kNPVSWEQRm3+I6DXgER2Ar21+QCXZRFRLl+MVy0Q9Ezzspa+S4eSlpnkuCDEK2vkS1JGURi/pUCdbssLgB/YzsKCglh59zC9p1SK0ipvPTKt0qTxF3OZpavza5Y4/z62GC/JmmHUhLOTYwt7AwPU9Erp48aaowGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FKDpCBkg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595DkVOw018174;
	Mon, 6 Oct 2025 05:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=La7zGt
	+nyFAzLEwpj7ynXIc1qbu7yeQFGLIbDyepaHs=; b=FKDpCBkgKgB3Xr86bbQ7Tf
	QYWw80pd9b8bng18Ub5QWlY/YJnFvpohEgFnObPKsQFqP+Q8OOH/WRtmV7+yJfyQ
	g5YhAu4GmuHY9YFkac8KunaHryAKd+gdj80UV86uK0Ut6MbjWmajR34sLMhE64wO
	OW8aAkgLUokQrK2pR/8pODy+QIyXgvXRRTpR4Kdr14lDOW2DvZYPzZ06Ecb0Ya9Z
	SPEMuDg0qtyJjiJgRl4aWE04SKbg7x3LZsKvlxDPF55oERuarV/dHUqQSC+ccTE5
	SwjRePd55cFyerGx1KqzMyyMahTriDN02zc4OLpgNvLuABXkVGMVfshyypH6hVVg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jua8yf1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 05:55:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5965fQGo004394;
	Mon, 6 Oct 2025 05:55:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jua8yf1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 05:55:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5965SuuU030981;
	Mon, 6 Oct 2025 05:55:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kfdjve95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 05:55:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5965tTO712976706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 05:55:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0F758045;
	Mon,  6 Oct 2025 05:55:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 981E758052;
	Mon,  6 Oct 2025 05:55:23 +0000 (GMT)
Received: from [9.39.19.186] (unknown [9.39.19.186])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Oct 2025 05:55:23 +0000 (GMT)
Message-ID: <de0baa92-417c-475a-a342-9041f8fb5b8e@linux.ibm.com>
Date: Mon, 6 Oct 2025 11:25:22 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: dust.li@linux.alibaba.com, Halil Pasic <pasic@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-3-pasic@linux.ibm.com>
 <aNnl_CfV0EvIujK0@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <aNnl_CfV0EvIujK0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a3AgJ2iUJ6qAbdHCn6hkJxjC9631NxLF
X-Proofpoint-ORIG-GUID: mjnQG6uiKhb8a6hfon6KkBeCQxcC-ftv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX9h4UhhATBP6o
 5EcWGzT9ZSTB8l9O5sfgqv1GnsXpJ0c+JSyGLk4gW8qlDcIsxJwdi6oV3VCr0m6fsDV2I0kDRVa
 QCXutM9BLZBWOd3zXs03std0vmKu2obSUcU9TrUGwkrJ3PeSKN4IRl+P7A1JRGkk7ZmB8ph91W5
 jU+6t3qUEFPJ5whT63VHZJ1r/M5y637pVRTvRo6pOrhNeTjdMrbuR4wSZH6jfetZ034jq6S5xgo
 TyolVRrbXmRzD5y69UBW019BCNK6oULdf9GwH1+P4a2e2LJ2AQP+gGtiPjXD8eweYirj3UrTAdu
 1DjaXqXGM0GI6Ni+F3IpDAd+UWiCfB4IM6BEHr6Y6kooBrqZ5SRoUKnU+SpyZJawYOZENHvJcjG
 xpci0clnoSLjJD1CA56Tbm0N1sXASA==
X-Authority-Analysis: v=2.4 cv=QdBrf8bv c=1 sm=1 tr=0 ts=68e359d5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=TtWLiSDBJoBebt9xJZoA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 29/09/25 7:20 am, Dust Li wrote:
>> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>> index 8d06c8bb14e9..5c18f08a4c8a 100644
>> --- a/net/smc/smc_core.h
>> +++ b/net/smc/smc_core.h
>> @@ -175,6 +175,8 @@ struct smc_link {
>> 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
>> 	int			llc_testlink_time; /* testlink interval */
>> 	atomic_t		conn_cnt; /* connections on this link */
>> +	u16			max_send_wr;
>> +	u16			max_recv_wr;
> 
> Here, you've moved max_send_wr/max_recv_wr from the link group to individual links.
> This means we can now have different max_send_wr/max_recv_wr values on two
> different links within the same link group.
> Since in Alibaba we doesn't use multi-link configurations, we haven't tested

Does Alibaba always use a single RoCE device for SMC-R? In that case how
redundancy is achieved if that link goes down?

> this scenario. Have you tested the link-down handling process in a multi-link
> setup?
I did test this after you query & don't see any issues. As Halil
mentioned in worst case scenario one link might perform lesser than the
other, that too if the kcalloc() failed for that link in
smc_wr_alloc_link_mem() & succeeded in subsequent request with reduced
max_send_wr/max_recv_wr size(half).
> Otherwise, the patch looks good to me.
> 
> Best regards,
> Dust

