Return-Path: <linux-rdma+bounces-13029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F856B3F5B3
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AE61A86333
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 06:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7AD2E541F;
	Tue,  2 Sep 2025 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phmmLiln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985472DF15D;
	Tue,  2 Sep 2025 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795224; cv=none; b=niEkKyVZKN62yZt+tFkLXDUqezKHh9YFG5AyZ9gdNEyVXDt4I9USfCFQo+FLDh8RPNLSfPWy/kDLvvZGORCN3Tz9ZLhja6YbhWL+FmYp/9qiUi0yF5SqngSm+hZye1xZmHH6+62awktyVeBd/S9vuAOgdPQg9Qa+U2lKF4r48PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795224; c=relaxed/simple;
	bh=NAGgal8RBero3MRCvjOxT3Rpb5VFZnYuL8Rb0yFeA3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phuRo7usJoNpOwJ4ibhvXDvl5BAYHuoFJktGWGPwpe68XDNuUecMsSA/V3ylnLfaLuiXm0DIHHODVDCTmkoMFO0jZRkTFrh7zOjm6soYaz5ZTO0CzqYF3MuxGT+SfAbeV7POGmgh5uWFH9MjGrHgRug82pJTVYiEdKhk6/SBjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phmmLiln; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581NpLCJ009463;
	Tue, 2 Sep 2025 06:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=smH8Iv
	Caai28BF62WFWYENlbU2adoO3gGfBik1qn5Jw=; b=phmmLiln2whz5z3tzD0H72
	bSB6AzJEmmWDInxAmRixRaHp/c4BP3mzyyWZzpzlH3ggjmLy3s6eaNPBT03+sxK5
	WTbAReYAmAACUNbms2xq7R5dEW67p+T/LgOy8K5UyAbtivX94iyn6VP1PIlV9P+C
	9FtB8M4pVHcVc3ZBY0Vp5OOKZk/VzW9F65LodEhrZYRTELx/J/WeHDSy6iiW83g3
	gimxiXX7gaDVfxSasMAo2qvU3F9fZY090DpaWAXLMhPhQPHhJ7AvjEaZRqxyf/gA
	JxdHlFac90VIZttae9CYkW+VTtlqMA+KAC6BbX5pHNiTfok5Y7/bBJei0Et4SAVA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvfmfda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 06:40:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5826Zmrt029485;
	Tue, 2 Sep 2025 06:40:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvfmfd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 06:40:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58252UsA019390;
	Tue, 2 Sep 2025 06:40:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4ms60k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 06:40:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5826e8sk53739864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 06:40:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6934C58045;
	Tue,  2 Sep 2025 06:40:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77DB258050;
	Tue,  2 Sep 2025 06:40:02 +0000 (GMT)
Received: from [9.109.249.226] (unknown [9.109.249.226])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 06:40:02 +0000 (GMT)
Message-ID: <7bd60e6d-4b33-4a04-998b-0be163a6fdb0@linux.ibm.com>
Date: Tue, 2 Sep 2025 12:10:01 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/smc: Replace use of strncpy on NUL-terminated
 string with strscpy
To: James Flowers <bold.zone2373@fastmail.com>, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, skhan@linuxfoundation.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev
References: <20250901030512.80099-1-bold.zone2373@fastmail.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250901030512.80099-1-bold.zone2373@fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b6914b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=ZLGELXoPAAAA:8 a=VnNF1IyMAAAA:8
 a=sRZyJRDGTCvSbJG7FuwA:9 a=QEXdDO2ut3YA:10 a=CFiPc5v16LZhaT-MVE1c:22
X-Proofpoint-ORIG-GUID: qFoqQJwTEhWngaDNxFh9_NbK6veFWD-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX+tpSirvNyrKD
 U7go02OKOYzuE28ig91Hi4h12iuG5B5vZUli47hI/KPsQltpN1zz4+j8HDML9zbLhZ8QuhtD5o/
 vz3R1yP/fdaOoPbZR5Hq25yiw6suqG1Y+ukOqGWGe4hsf/7f01poEOHDhAxLax7JZ1bUCTYv1Pi
 yMmaDhP23+lkUAFGqvDyzPsj43UcheN0R9+X41Ea7TStDzvPqFnBhTVtqIbkPa01cSWBKi/Ab1h
 DrqbFtkd3SUHs2uB9rk/3UxFzTzpGghsYlGcZuvEYAN3FPC6CQUbEwVsBQUuVAu0WtMbcqxrnpR
 liEZvHQLHf7oZSvLCEwHPGwIxIijkJDIo5ECy4gjBN3JGNAX25qr6BWSU8nuNitNhXdNL9J/Ta5
 vy5uIlPI
X-Proofpoint-GUID: Kod15Y-6MTn7jlVkHQlYp0VZB3uqdvce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034



On 01/09/25 8:34 am, James Flowers wrote:
> strncpy is deprecated for use on NUL-terminated strings, as indicated in
> Documentation/process/deprecated.rst. strncpy NUL-pads the destination
> buffer and doesn't guarantee the destination buffer will be NUL
> terminated.
> 
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---
> V1 -> V2: Replaced with two argument version of strscpy
> Note: this has only been compile tested.
> 
>  net/smc/smc_pnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 76ad29e31d60..b90337f86e83 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>  		return -ENOMEM;
>  	new_pe->type = SMC_PNET_IB;
>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
> +	strscpy(new_pe->ib_name, ib_name);

I tested your changes by creating a Software PNET ID using *smc_pnet*
tool & it works fine. Your changes are similar to ae2402b(net/smc:
replace strncpy with strscpy) commit.

Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

>  	new_pe->ib_port = ib_port;
>  
>  	new_ibdev = true;



