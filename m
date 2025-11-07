Return-Path: <linux-rdma+bounces-14304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B3C409EA
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D7734F249C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890332B9BA;
	Fri,  7 Nov 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BeuYfa91"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16B268690;
	Fri,  7 Nov 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529830; cv=none; b=N4GgXg/2zIdGGvOvJ6rbAe6ku7lwytB5R5XSJsWV7ugfHksewiLgxIcFPujSlEGa0jOIVRWswoZXm9Pum+hKUw/dLs7yOQr6yA8MAfS2J3yhfpvzYaXfhoHN8ERZfMNoqVPlmlZhnvxs+AWONg/S+rars1xWdoKHamLL4doa4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529830; c=relaxed/simple;
	bh=bCrSoQu63h7TXwxNL43pN4r1ALSnNbU5F1bAl9mdBuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zsmu/ZzhxeSPZnQ0ZBnEWmaaqxGRiechWgqNNl+XH78lOwz+jB9aHgnX4qKA1jOkZAtEcGrO8vVUq73Ii5ddaEofjd2LWKQn6lAjIaF3ieQEKkIAw78seuo1ADDNCjw7Z15ZDFLGKvovy4PFB32a9/AhJBl1rqanUznoUXIQr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BeuYfa91; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7EsWro030381;
	Fri, 7 Nov 2025 15:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bCrSoQ
	u63h7TXwxNL43pN4r1ALSnNbU5F1bAl9mdBuo=; b=BeuYfa914//ktvu51uwdg2
	NYmbwv7NxePH+S87wg4vSgN0kqEhq+KL13zMZkpaaBy81SNyPLdMuMHzkQncMWKo
	e3d5Ra1P/fr1kV4hfaHnj5hnccayOUFd/5P+EYKZb2wtQFprVinpQOx6PI9Y5vqz
	NVzNDt9A9P7GVkTejtSuIfWmuaCLQqBgDrJOkRRePYMYwQpewLi9kdpauslfrKNQ
	ztUrpA7a1gw+C76Er0L8VlKi+nu+lmWRBt1l31XNsILf2akEDAAVNKmyrsCURdqo
	IysLIgIBerQqXb4mdG4i+ZwACUxWi6MP9V0PpgkcljanGlpaHN3TuY5njGgs05PQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9jxmr8b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 15:37:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A7FPskd003030;
	Fri, 7 Nov 2025 15:37:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9jxmr8ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 15:37:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FJVF2019320;
	Fri, 7 Nov 2025 15:37:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnud8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 15:37:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A7FausR50725316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 15:36:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBDEA20040;
	Fri,  7 Nov 2025 15:36:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6806920043;
	Fri,  7 Nov 2025 15:36:56 +0000 (GMT)
Received: from [9.111.185.176] (unknown [9.111.185.176])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 15:36:56 +0000 (GMT)
Message-ID: <e238fdb5-f495-41dc-9f5a-7367d480cd08@linux.ibm.com>
Date: Fri, 7 Nov 2025 16:36:56 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix mismatch between CLC header and
 proposal
To: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
        wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        pabeni@redhat.com, edumazet@google.com, sidraya@linux.ibm.com,
        jaka@linux.ibm.com
References: <20251107024029.88753-1-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20251107024029.88753-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BZvVE7t2 c=1 sm=1 tr=0 ts=690e121e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=ESNYVigEsH7QVG4fgMUA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEyMiBTYWx0ZWRfX4dvWmd4ENyMG
 YEEIXZN2fK2l3iRHs4ufppVhOz7ld6lfm+cosbqGrQ7xiPUt/mW5ZQ5Uhmukkdp+veHg5Hy6vvS
 Qfe0l7WHQdkJeK9NKUyRo3/gWDFRu/H5sQ7FhSCvK5ChrMwg7/vROyjK/nOBFVTpGSfWe1G31qK
 7Sezvm37LK6AHQiZuxa+Xy5j6mG5Nw97cDXlYb224SVxzOm+djrV1OS1D59L99IEKKUKAn+ia8X
 kI8m43rDNHIf6MHAEWCBHp/K0xkgh6lwFhJAthLXJvFo0ZBgYqAaKJ0TuBqz/oa6Sof7A0T2tzI
 A98ZWZSmyWgdgsqYiaVm8ri1qdBsO9kOY6Gru+BltkQl+/pUopPgJs9n+Pp+hQRgqGjkAx+tiF7
 /FwdQRtW9iLVpk4TPU3IyhRZUH7teg==
X-Proofpoint-GUID: KH4Tg-uLZ3AOsT9Olu5qQBTbighSBv6V
X-Proofpoint-ORIG-GUID: -zCtIbyES6nWr9OnAqwO-vYTlvTm_mUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511070122



On 07.11.25 03:40, D. Wythe wrote:
> Fixes: 8c3dca341aea ("net/smc: build and send V2 CLC proposal")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Thank you, D. Wythe

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


