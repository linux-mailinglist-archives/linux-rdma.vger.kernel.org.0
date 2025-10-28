Return-Path: <linux-rdma+bounces-14095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86FC13DB2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E84207E4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6CB302149;
	Tue, 28 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fb36uv5q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E572BD5A8;
	Tue, 28 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644030; cv=none; b=TMjxRSpVYd4AEg3M0WwZ3Uhh+Aos3bII25wUqrA9NUg+iPCjXtqLZiuB2Bxx1vHG0L5n+9Om4U7oOihG/PpwSvkH7ebouz0tWdlqJy/mGAnn3E0+YuhGl47n5M1HqxWk6bUdQK4EJFma9S3G6t66UY6WhKWUGhdfzXlQ05FENNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644030; c=relaxed/simple;
	bh=gNIoYwnPGl2poq9hJhXrlXgYqCYv7k4kBJYh6yVqD2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBpmlq+++MugpFnIOc88bHSe/XWA4TUDYg7iBlTcVJtHlIstnfV2240XQvGhc/cqZaRNEMw4fEyhPiJYYQ1oJnj+mToFfsYiqBj0tP6Vt80o+RBVeCjijzn5xfHXdt49CqgrW8JH//8eVfgHTxQb0wlE4LhlYB9iciuJ7lCK49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fb36uv5q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S1jwrs012355;
	Tue, 28 Oct 2025 09:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QRyvVz
	Y1aSZUvVTazOXD95pRWeNWcRO934GJDJqjh/w=; b=fb36uv5qukFk3JqFvVQvVI
	GktXEJOPup1juHADYcyswf+EoH7DzRAwm0obR1OBlQb9Dm20auo9s2nluILsI4ew
	UGIlt6juXUse+EDG8NxxY+KtJwlx/K8PSLpUIs4TmO1WqhduRkES0p9ug4lpDuVI
	j9gJAD362d9eDnleVN80QTuDOp/53Z0/CLoRSfqkzxvV0csHK8V6nbA+p7KFbhaV
	N/z+G2ZvwqUWvTac9W+vWp2gl+bTBcom1ONrb9kZlcs6n5BGagLeIlPWBhc4gDgJ
	/o1uoFNjTd+ia7q9semQNgJ8883sqrOcVCUaQ+UZUtSElYtMgERJCIduUZnJFnDg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81u2g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:33:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S9Inhm017991;
	Tue, 28 Oct 2025 09:33:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81u2fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:33:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S8lXfG030187;
	Tue, 28 Oct 2025 09:33:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjswxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:33:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S9Xces2949800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 09:33:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 962FD58061;
	Tue, 28 Oct 2025 09:33:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BCFE58057;
	Tue, 28 Oct 2025 09:33:32 +0000 (GMT)
Received: from [9.109.248.153] (unknown [9.109.248.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 09:33:31 +0000 (GMT)
Message-ID: <0f70d4ff-ad35-42ee-8b99-cf6e3da7c49e@linux.ibm.com>
Date: Tue, 28 Oct 2025 15:03:30 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net/smc: make wr buffer count
 configurable
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
 <20251027224856.2970019-2-pasic@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20251027224856.2970019-2-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=69008df5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=ffDd5I00xDUYzGQUyCcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: iLJI276jkQYFSUAkCfrGJUpPke3vGuVq
X-Proofpoint-GUID: bZgTWHVMeG6WvbqmK9wxllVKaM1ya5qo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX/RJ3mImZoIyY
 aTH2y+Y8353xw54oqcdtwUceZzf7eWySn7fGScsF62TaXsiSpp2HZZd1IkjWjmzyS7KyUwHxw8t
 YC4jJ8k9YjcQ/GJmDIR3UO/9cAFGxQHL9T5m2ht3f6U2wukpKiwmUvd5bqGkfRH9GUeKAlK67kv
 iB0IGTY+WZnaz4/PNdhw3Bg/XUwiXj6mkmlb9DkSX1VjBaXySSPtugMS3aLdP4ij8gg+y0pQ8I8
 S0gQEoJSUVzr3vwTxktDOJJrSeP32IFDVs5cNir/V49lsc5qj1yw118rbe4fHrBvEO/7RVSvidX
 hC4hpP8kBQLJ9yGrmArlKwdUciWtqWz1IP0T+97clb1FMXhQKAlAQKdVpyBRhNO5jO94TmD4uMs
 Eqs3tuEx+6vFve/NNyVDL5MH/qQxwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024



On 28/10/25 4:18 am, Halil Pasic wrote:
> Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
> SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
> get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.
> 
> Please note that although with the default sysctl values
> qp_attr.cap.max_send_wr ==  qp_attr.cap.max_recv_wr is maintained but
> can not be assumed to be generally true any more. I see no downside to
> that, but my confidence level is rather modest.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---

Tested-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

