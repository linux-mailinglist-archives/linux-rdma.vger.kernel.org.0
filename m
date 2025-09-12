Return-Path: <linux-rdma+bounces-13305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176AEB5442C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5532566285
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9D2D2489;
	Fri, 12 Sep 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NhWItY5O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F429827E;
	Fri, 12 Sep 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663361; cv=none; b=qE4OrZO9qobUzsoHAX/dRB17fPPirhML7no0DxfwZVU0/rOwCMH63hWgN0G9fuFZUM6Xuh1B8DWQm9flN5ecQGzzqThFMCzvNlvuCix+PBpPRUH43cTYXO1v9gb06rToi+Xf3zD/adG+zY1dbv3ikeTbFRBLbm5uTu261ML+tZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663361; c=relaxed/simple;
	bh=ycKuyJfA+pW+7/KGrXyyWA8AmijprriOluA76WaJozs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ahdfUoFteiMnvzpgbgCcNnPAQoQAgt06X8835weOxUnVJTKnkn5R3hevMKaAwoq4XWar6Qa9HFvEDTTaU5T24c1+qDANgmuQ1SRqheyM8XOoE5LYdCviWxstFQhUA55fq6Fi11aJOaLpEUvhSy/80cR3bckLJGWsAoydPdQLVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NhWItY5O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMC9GK020534;
	Fri, 12 Sep 2025 07:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zTLFXr
	0+McgcO/Jhm5ZmAHsiQbcdIZZr81OtIcbjHXU=; b=NhWItY5Od2g9kImauxquKp
	1ngtrmKTrlCVcWc81XmbcH+TkDJVYy8Tsu8ZeC8Emvby9+ATA59pf2TWhibGcx3h
	zWJ5AWkBpa5ifa7UxFP9nEttd7ugd79jC5ToUwsWTkVSY65y8Hrf+ekzr1eOIlfg
	FwrSfPixSJzWppEIbhOcYkwgtBK9eZvpcbZ7jcVegYseYRBhVcvXW70QUh7k6suP
	bXgWfoX7THDkIEKNhVbEmqOQBMARJCDoO4PU4d5nNfXwqlA5dW4YUU3eFkk93y5L
	JAvaE9nAu+A8ndvjP/cBHXaHxGY1tHrSJ7JvwGtt3knXknwcjWCc82dmK7bauVHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxa3w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:49:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C7isx0004599;
	Fri, 12 Sep 2025 07:49:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxa3vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:49:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C5mklg020492;
	Fri, 12 Sep 2025 07:49:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp1a06r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:49:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C7n1J510552122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 07:49:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F1335805B;
	Fri, 12 Sep 2025 07:49:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B908B5804B;
	Fri, 12 Sep 2025 07:48:53 +0000 (GMT)
Received: from [9.124.209.229] (unknown [9.124.209.229])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 07:48:53 +0000 (GMT)
Message-ID: <24ced585-1b7f-4577-9cb5-8d6e60ecb363@linux.ibm.com>
Date: Fri, 12 Sep 2025 13:18:52 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
To: Leon Romanovsky <leon@kernel.org>,
        Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, wenjia@linux.ibm.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
 <20250910100100.GM341237@unreal>
Content-Language: en-US
In-Reply-To: <20250910100100.GM341237@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wt_ztnzAbTCUW63_0c_p95yMrAJngxM0
X-Proofpoint-ORIG-GUID: w9Zw26-Md1BhUSCWk9qmTnVUjRXrTtqy
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c3d071 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Pdt1UvFI3CNFTuUL1BYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX4OI6TXazD+le
 56WH6lGl9kaaMFkhLqdhaVodzKHn2p6A9gJsWtX3tageFGrfbkvENmAvvj04r8SJ8hHcRik0lCu
 7VZq3RYLLLa0X2giBf/dkS+JFep9sHgXcl19fa0ktEdiJZgyrqsB0tSWht1nmfGtsNVPvn2gBhH
 acfzeXpLNaZs5HsHVS2alZvuSk0y8zBwfhdqwFziuo++VjY1TSODD4PXG0BpQKxyiF83h80JOuK
 exvWlxrUlum5zbnqF09tkS1CyPLj+8cE+U9J4tFyxZBQvZAu5JSDu2nvugnHUp83mfel+NtU/ra
 9ocMwzQPXR3w6pLoEiL+dz5n47KX6ZuFXud0pZKRaHqgGYA8W+T/O697Jhq5bS8pJ65Yeebyne2
 pwxNkfwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On 10/09/25 3:31 pm, Leon Romanovsky wrote:
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>  		return -ENOMEM;
>>  	new_pe->type = SMC_PNET_IB;
>>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
>> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
>> +	strscpy(new_pe->ib_name, ib_name);
> 
> It is worth to mention that caching ib_name is wrong as IB/core provides
> IB device rename functionality.

In our case we hit this code path where we pass *PCI_ID*
as the *ib_name* using *smc_pnet* tool(smc_pnet -a <pnet_name> -D
<PCI_ID>). I believe PCI_ID will not change, so caching it here is fine.

