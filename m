Return-Path: <linux-rdma+bounces-13028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D9B3F4FC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228F6189F03C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510E2E172B;
	Tue,  2 Sep 2025 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rPWCKIyU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B717555;
	Tue,  2 Sep 2025 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793155; cv=none; b=amZjaA1qPk6uxA3WnFJymi+T2lOFy1JVuCK0S/HgDeJ/zVyDu1O67aA7rTUUlEsEx2dClPSHq9D2/7nc4jutwekH1XsibCcxmaG8iDKbj+ftGGN4qRzrdXmYzTKHYLGPaGF2Aia+7zUS0kcfX4KXbyXvMNHgs9Ch9VactC+kkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793155; c=relaxed/simple;
	bh=vPYcab8hDHpJXvSJf8OmvHQ78QeDxGI/J0l0oFJkqP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AA8rOb82R8+H5/vPvpCA5egJ87QAGT5ZTDZthT5fFpOp1oh9vXduq1Z8J4YXQRWhPAAzdLkLghyQ+IJ1uSCIu/EPOC7WPhMOzltS8UBUbnB5hmaDKpYmi6zoiGCmPBxaZRJYvXZdk8VJQUhf14nybkPzUXRXWe0A553qDVpHqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rPWCKIyU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581MwFNf000795;
	Tue, 2 Sep 2025 06:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+SHkAc
	3R9Zv61uiyMzs3bAeyMpnTV2NY2GyXPaCCSMI=; b=rPWCKIyUzv6un0aqB1rTL9
	kF0qb1Ix913wPlxMT9uwuSN8If8u88PcBr0qqGmquukCzTk5eVcAlWTVG43/lwso
	GjBX34SIMpPU/w/GStZLnUUAgLp+kTrEZOmv/b4iNaLaOF9irX4eng3whh6m88nT
	675E41kvnZa9tCA+E+5N0PyNEzlxk8xrdaVbU/IUrXRJhK0LY3tq9KFzfdIXKw64
	V69mr/W3yfjGpby2XVvDFZJi9M7i2SLcDXQi903ywoet/xwZnOcIjJO7N7Rw8Y2Z
	D+ebRzeJg0+ESgy3kl3C1pPja2fQuzElZRq2F0isf4tRbZCGuthR5sggMfzHNeGA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd4g0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 06:05:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58265jp7029351;
	Tue, 2 Sep 2025 06:05:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd4g0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 06:05:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582428m6017206;
	Tue, 2 Sep 2025 06:05:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc10h9b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 06:05:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58265gGx2425432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 06:05:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16DFA58052;
	Tue,  2 Sep 2025 06:05:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6815258045;
	Tue,  2 Sep 2025 06:05:36 +0000 (GMT)
Received: from [9.109.249.226] (unknown [9.109.249.226])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 06:05:36 +0000 (GMT)
Message-ID: <8a795b8c-5613-4952-a5fc-59cead205e59@linux.ibm.com>
Date: Tue, 2 Sep 2025 11:35:34 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
To: dust.li@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
 <aLHAAy-S_1_Ud7l-@linux.alibaba.com>
 <57c2976e-8b6c-4cee-803f-ca5b0636f30b@linux.ibm.com>
 <aLZtraICmwOQAtsO@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <aLZtraICmwOQAtsO@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b68939 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=48vgC7mUAAAA:8 a=VnNF1IyMAAAA:8
 a=2s6wso4pYNhIxN0xKpgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX91bZLO+n9qJc
 VpJ6s/x/e+TmVDF/jecm92RJ4duornqPOS8cEyrnIgO7heioeNB73mD9lRjuTsQambLtTtvxwbq
 fAxH7WG5Krvur2tvcmBanMVWyxWv3pquXLAWlQWR8VzJMskzmEZYMt3vcZX8W5pdZanrt5zzbS6
 Q+KlVpOmKNI3vBfwrVCqB+Zx/Z3ZeDuy/pWuKnYP4J6xnzuA7aFaAbifPABA8M2xskdcFG7ZVlH
 gSGY5XNgmo0Djb3lvYw47q0ucjuqPs+xF8rDfb66JzAEAtg3oKHxzvPpdebTZ16Yc4wlmSPjz8A
 ryb2DdSRtkAAFd7om1/g3ciUR1cUKRZV4/I/jKb6v6xwBg2HiPlgW+k/fPESQvVSYVccEvz8gBN
 XQGrREgZ
X-Proofpoint-GUID: heUgzJ3ansrwrHMTiAdtNx_18K_u8Pgq
X-Proofpoint-ORIG-GUID: vwprlvVGuF7m_sFkiZX_qGMSgYARY1IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034


On 02/09/25 9:38 am, Dust Li wrote:
>>>
>>> Did I miss something ?
>>
>> If you refer to struct *smc_clc_msg_hdr* in smc_clc.h file, typev1 member
>> represents bits 4 & 5 at offset 7. If we compare it with the CLC Decline
>> message header, it represents one of the reserved(5-7 bits) at offset 7. You
>> can refer to below link for reserved bits.
>>
>> https://datatracker.ietf.org/doc/html/rfc7609#page-105
> 
> Oh, I see, thanks! The patch looks good to me.
> 
> 
> BTW, I checked the rfc7609 and SMCv2.1 spec:
> https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202.1_0.pdf
> 
> I think the name type1/type2 in smc_clc_msg_hdr is confusing, as it doesn't sync
> with the spec for decline message.

I agree with you. We can address them in future. Since they are part of
reserved bits, we can ignore parsing them for now. May I add your R-b
for this patch?

> 
> Best regards,
> Dust
> 
> 


