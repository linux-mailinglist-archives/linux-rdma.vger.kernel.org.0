Return-Path: <linux-rdma+bounces-12766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC9DB26A26
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0E618840CD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B621B9F0;
	Thu, 14 Aug 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qVWwE5mO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53085218AA3;
	Thu, 14 Aug 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182975; cv=none; b=OeHVqjF7NErakVrhAUtH5W0TF7T/Qc7tMo8aTc7Q7JHR2Wl56h05BNYphogRHDiUcY3MVVxCRFtH3loduoIwbLGewTxdXwuS6cb20a4UwnYbLhVcNx7SlO72FOH7XY1WSoKJoDmlZRHW7HW6tkTqmB9W0B14mEPMyKMyRFMfdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182975; c=relaxed/simple;
	bh=5OQaVcwy8qq0BWPBq0Xv9tdlEf3SSr+Vlbc+VNiKzhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=us6+TfATr49LHl+YNVVpDwWo5Q/CG/anz14ps+eq2otycCmpbFDlWzlWF6ICSXCXvkgPuh4/IRUQBF8qZkmoWv5FRxjrxVkIbFOK2J+E/d5oFszNoFn2eylfLf4z0wn5a7gY3FlLoUvWuz1BuGZ8EPap/vrwES56n0pfkQNonBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qVWwE5mO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EEVUkH029945;
	Thu, 14 Aug 2025 14:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gdTcb/
	3GX9TLmprI5fhVBXai54xRUdMwJgxbtUu3+cQ=; b=qVWwE5mO10SIM7OFwN2Nj0
	P8KR6gzeQvXbFaDrTz90ZvHgQ5xw+a5uvaL1PkmIi92XtXlw+HDEfg2DAh+4HhU4
	iM0Yuc4meMQ/YWYV2o1LtSipK6+i2JXAvWD7l5JuTgbDKWfhf9RRV30zrfEbS80g
	Q10pCoX8nQiBE1ib3Z7GTqNLYyk552rnNDOSE5uUHJmIILtUvymJqy61SjT0o9Xj
	R3wXgt3Tz5AqDskcmGmlle1PJTwPHMNUvc2WTvE44pzfGGEue/uXJc40Y+1uLkfy
	DgugMb9SUZxiQDDRUloyMfzxRpBzk1ZGCBzeMPNwTcHoJxH+Ms09aQqF0LuLnLMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpafqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:49:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57EEgxkY024384;
	Thu, 14 Aug 2025 14:49:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpafqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:49:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECMCb3010832;
	Thu, 14 Aug 2025 14:49:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnuvumj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:49:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57EEnIDg58458472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 14:49:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C84FB20049;
	Thu, 14 Aug 2025 14:49:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6363220040;
	Thu, 14 Aug 2025 14:49:18 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 14:49:18 +0000 (GMT)
Message-ID: <ed4750cf-fcd7-40b3-be7c-84838cf8fd63@linux.ibm.com>
Date: Thu, 14 Aug 2025 16:49:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 15/17] net/dibs: Move query_remote_gid() to
 dibs_dev_ops
To: Julian Ruess <julianr@linux.ibm.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-16-wintera@linux.ibm.com>
 <DBZHV2Z3T4M5.1G8HW0HFP8GLO@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <DBZHV2Z3T4M5.1G8HW0HFP8GLO@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfXyyjYnhW/NHex
 l9zGpqZLgTksdvwvq4wSMgyqwFy6FTNogr75P9uTR330BYqDSGt6nbbzk+UlWgsVtC00x144v+L
 EErWQvIorlsr8StR9sXPexo1EWtfVsi1o05BNzBcSoYV8i8mlepwbaIiuuDvz6RiEH5+oTiPDBS
 mLIAKKKPQpwiD8OhBFwvDDLUEnJUViPUlMTyrAvpOQVMf8XLCUUPYAZJ/m2PIj3hcLvWIH3R2Ux
 OnNCgfkQuPG9xAGRteG3gy/1LcsYd5QQZw/bvJpuJFIBuclxZPcxRmL9PZ0GZpbPWggG8zBk/Gj
 QNSYh6f+PSNWYgSgTfC2kQwM5zByWNFEo9Y783L7kB7q0OngA27Ne96crYOofh2sPJCqEIug2Xh
 Pb8lBEsz
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689df773 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=-a8VnQ1ltUyKSbjGXZUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: t2ZMvLahaUXAs7GJ8CCnFcrO3p-HmseG
X-Proofpoint-ORIG-GUID: aCCuv498CXKYH4gF3BiOPTB3Dx4WO2RG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219



On 11.08.25 11:34, Julian Ruess wrote:
> On Wed Aug 6, 2025 at 5:41 PM CEST, Alexandra Winter wrote:
>> Provide the dibs_dev_ops->query_remote_gid() in ism and dibs_loopback
>> dibs_devices. And call it in smc dibs_client.
>>
>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
>> ---
>>  drivers/s390/net/ism_drv.c | 41 +++++++++++++++++---------------------
>>  include/linux/dibs.h       | 14 +++++++++++++
>>  include/net/smc.h          |  2 --
>>  net/dibs/dibs_loopback.c   | 10 ++++++++++
>>  net/smc/smc_ism.c          |  8 ++++++--
>>  net/smc/smc_loopback.c     | 13 ------------
>>  6 files changed, 48 insertions(+), 40 deletions(-)
>>
> 
> -- snip --
> 
>> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
>> index 10be10ae4660..d940411aa179 100644
>> --- a/include/linux/dibs.h
>> +++ b/include/linux/dibs.h
>> @@ -133,6 +133,20 @@ struct dibs_dev_ops {
>>  	 * Return: 2 byte dibs fabric id
>>  	 */
>>  	u16 (*get_fabric_id)(struct dibs_dev *dev);
>> +	/**
>> +	 * query_remote_gid()
>> +	 * @dev: local dibs device
>> +	 * @rgid: gid of remote dibs device
>> +	 * @vid_valid: if zero, vid will be ignored;
>> +	 *	       deprecated, ignored if device does not support vlan
>> +	 * @vid: VLAN id; deprecated, ignored if device does not support vlan
>> +	 *
>> +	 * Query whether a remote dibs device is reachable via this local device
>> +	 * and this vlan id.
>> +	 * Return: 0 if remote gid is reachable.
>> +	 */
>> +	int (*query_remote_gid)(struct dibs_dev *dev, uuid_t *rgid,
>> +				u32 vid_valid, u32 vid);
> 
> Shouldn't this be 'const uuid_t *rgid'?
> 
> -- snip --
> 
> Thanks,
> Julian


Good point. Same for the 'uuid_t *' in signal_event() in
[RFC net-next 17/17] net/dibs: Move event handling to dibs layer
Changed in next version.

