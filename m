Return-Path: <linux-rdma+bounces-5756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46F9BC9A4
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 10:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB671F224C6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A47A1D150C;
	Tue,  5 Nov 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fL2iXv0t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BA1CEEB4;
	Tue,  5 Nov 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800419; cv=none; b=qJEzCAOcGpGpA/95XJlXBlnP19PHARmPANCp/iFXWgTWhTkyTrzlMQ68dX3eApD9lDOyTsyN0xI5/AMusdA/Uu0yJ8HREYLIP5kebOz4XGqZ8wG6e+7I3nPmAFuBEgKF6eSgTI5CMJmjdK0jRpVmU1sSjspgXsmhknFGFHidgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800419; c=relaxed/simple;
	bh=1Pd1f8c9klxoPC1PZql4/GNFDRt0kjlwhxdp/gLX0TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blrRU+D1ki2p8qhKz46KE1FZ70HuciEM5mwDjtYDzBuAhSDAr0DRGoev9cVEk0YtxgH3hYqG6U0ZEIP5fBrrgDWJFjbcfK2INFYgkPbW2s4ouoyhBpPaRz6e9FfgTCqPaZKE/Z2HRZEGEZgOog1j29QUHhIlYirjss5nYLcoipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fL2iXv0t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59e9oI006588;
	Tue, 5 Nov 2024 09:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V7kgJu
	+AgkwH13Czeh6Tb/eIa0f2kshmnwSpMqWyk4U=; b=fL2iXv0tdtWZJuGtNOtMEe
	cCu+Y43Yv/9PRxgFXFtEL8WrWhQCMifHPZTLjLy9hxg+m7Ydppcjb8wHbo8I4KVk
	hBNHJL/2MMIhRHxfBtg9FCJQ6KSKQpkhx5fC+JC1Pfy2yoHNVDOcMI/DSoGIpTOY
	PKLzN2sJLLRVclvhRIb2e0Kr6UeD9a+p449ndjYmQN69Zg3Ur/Q3dB1cvb1lnmbO
	JsIot1e0cvWvsATJq7Ze+pINJ5yz/OLvFJ5BfYXBletlXwspN9FNqOKZGv/MvBuH
	5fYsTvsf1lJ6ZjgMlO4qhGL28KtGSvWVTqJ9D+jRjqk5JkLKkPCzqzBTWrHLi5Ug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qgx8r1y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:53:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A59rVHV008499;
	Tue, 5 Nov 2024 09:53:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qgx8r1y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:53:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5875dw019625;
	Tue, 5 Nov 2024 09:53:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj3tnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:53:30 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A59rTOh56623496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 09:53:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E6E58059;
	Tue,  5 Nov 2024 09:53:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5082E58058;
	Tue,  5 Nov 2024 09:53:26 +0000 (GMT)
Received: from [9.152.224.138] (unknown [9.152.224.138])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 09:53:26 +0000 (GMT)
Message-ID: <2d2cd3ad-df2e-4f4a-afb0-f43f55e08091@linux.ibm.com>
Date: Tue, 5 Nov 2024 10:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <79f0b90d-9420-4e35-9bad-5775c2104c02@redhat.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <79f0b90d-9420-4e35-9bad-5775c2104c02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tyMjDTaxW-tt3HfQfyiH0elP75THGSYP
X-Proofpoint-ORIG-GUID: ja6Fypsq3vy-TWdDUr10UlfIsDnd7qV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=979 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411050071



On 31.10.24 11:01, Paolo Abeni wrote:
> On 10/25/24 09:23, Wenjia Zhang wrote:
>> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
>> alternative to get_netdev") introduced an API ib_device_get_netdev.
>> The SMC-R variant of the SMC protocol continued to use the old API
>> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
>> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
>> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
>> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
>> device driver. Thus, using ib_device_set_netdev() now became mandatory.
>>
>> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
>>
>> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
>> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
>> Reported-by: Aswin K <aswin@linux.ibm.com>
>> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
>> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> 
> Please adjust the commit message as per Leon suggestion. You can retain
> all the ack collected so far.
> 
> Thanks,
> 
> Paolo
> 
Hi Paolo,

thank you for the reminder!
Sure, I'll do it.

Thanks,
Wenjia

