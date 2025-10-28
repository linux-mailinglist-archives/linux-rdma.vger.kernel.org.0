Return-Path: <linux-rdma+bounces-14096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A7C13DD3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 766BB561BE2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED2302150;
	Tue, 28 Oct 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZVGuTDlw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4320010A;
	Tue, 28 Oct 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644061; cv=none; b=A5wY1ZBPo6hXzM3tw9JisaYFlvV7R4VCrSDaEWKtLP1j7Y0rBcrbntgHlXFRaAsuscd+NEmxaqws42hvKk0T7uw1xBPHsv9tIJKoYKQ4JW6ISskakPBxb+UsgcRA+aq2OGnbJCJ3tm6wX7dvxMkeYV/RutzUMimHc2hAq5p9MQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644061; c=relaxed/simple;
	bh=jVLfI4yVKGdiFnT6DQInbzcdjszHzIy4uSzgNXUJDdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtnvsuFaNp02rdWsprUlFLuOhygbZ8OF5J2n42Urhcc/HFVRrZTh/Wlr9t22O7T+rgbvjK+V7DkMBvz0x9hkzz60NpPiS3nu4MYowE0nWs4ODW/LNfUBlzlBPqf1IPx62hnxFXDFdb6GTT2nsmffx2gnZ9kPVyk++n4x83pjGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZVGuTDlw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5Cec7011667;
	Tue, 28 Oct 2025 09:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j8GQXZ
	d2Emr7kAZPCq4OFeSfQwI7uxfH7Sh/8Zh9x5Q=; b=ZVGuTDlwVacT49TuiLa26M
	fyiSMeRqOmpxWDXLG25FK9d9WHSPFtf5rq+XPPw/FY+sqWIyCi3mZpH53ErsMfpZ
	j0SOAKa9089K489BkOq7Co+xElvDLZYslzI9zztydtJcoIvFELRb4Sjn34rMHXut
	AnYLEagaMof+fH+WZwQyLXkPcDDZjqYZ4nQzg374DmpqziGHhiMbOEVm0P2h9xjg
	wYMyMBEibR5Z5UVcA5VjXEazY2ILR7uf19UNROMCktcLbU3F9SAZCO6z9UgPiQay
	FmE3xhyN6hi+ieJiTomdEwA9LdpZCxJXvZzSyHBF2NC2ARR7RvE7AhOwMz9iwAHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p993273-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:34:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S9UUpt029051;
	Tue, 28 Oct 2025 09:34:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p993271-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:34:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S8qHjO009424;
	Tue, 28 Oct 2025 09:34:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j1st7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:34:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S9YB0b8323716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 09:34:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FBEA58059;
	Tue, 28 Oct 2025 09:34:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C204E58057;
	Tue, 28 Oct 2025 09:34:05 +0000 (GMT)
Received: from [9.109.248.153] (unknown [9.109.248.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 09:34:05 +0000 (GMT)
Message-ID: <c1c8f18f-a74e-40c1-8090-985d31cabd1b@linux.ibm.com>
Date: Tue, 28 Oct 2025 15:04:04 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20251027224856.2970019-1-pasic@linux.ibm.com>
 <20251027224856.2970019-3-pasic@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20251027224856.2970019-3-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69008e17 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=bkXrHAGJtgqs1KMYcx4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: M5ZXeYPseEWtehOxGfpeErU-77_Rhbrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX0INeQH/V75fH
 pCYD1kmjafZMlBioN/n20HvwWn4Dbn/q8pjziaQaRUnKtjctwGjEuDmM1jmNhHE+//ZaLzhwgXR
 fqTKOyq10D3O8tCgb5RREfMhSdRzBMLv9gPTTmh9FUe46i9KleyRYJEedw3ozHzxJS0wFqlbuLL
 E/l2VfsXPJ4Q8NB4HX1samRdRqj+fn1gH6Klp+JADEE86gclw7gMWCeOYyDfod1z/EWL+m/emTc
 /RGCLd+kiU5aFYNu8au5KV7oqt77IMa7TiX8/vZCcwjpH/bxkNvmlZJOKMGgcujdKb8YhyKopr9
 WZENWLCFyu7t8vrYWriUbJyUGczBAWFuadHTQlRPGwWdkQcHqdCOeTiZCLTNFHXnjmmEFgc0Z/k
 vPii1dvUSaVh2Lxq7Fkm20A1n6nuYw==
X-Proofpoint-ORIG-GUID: nbQ9WZ-8fnSKwd6ZppZDASRvcf9mvVl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019



On 28/10/25 4:18 am, Halil Pasic wrote:
> Currently if a -ENOMEM from smc_wr_alloc_link_mem() is handled by
> giving up and going the way of a TCP fallback. This was reasonable
> before the sizes of the allocations there were compile time constants
> and reasonably small. But now those are actually configurable.
> 
> So instead of giving up, keep retrying with half of the requested size
> unless we dip below the old static sizes -- then give up! In terms of
> numbers that means we give up when it is certain that we at best would
> end up allocating less than 16 send WR buffers or less than 48 recv WR
> buffers. This is to avoid regressions due to having fewer buffers
> compared the static values of the past.
> 
> Please note that SMC-R is supposed to be an optimisation over TCP, and
> falling back to TCP is superior to establishing an SMC connection that
> is going to perform worse. If the memory allocation fails (and we
> propagate -ENOMEM), we fall back to TCP.
> 
> Preserve (modulo truncation) the ratio of send/recv WR buffer counts.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>


Tested-by: Mahanta Jambigi <mjambigi@linux.ibm.com>


