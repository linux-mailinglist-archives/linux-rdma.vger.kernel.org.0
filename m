Return-Path: <linux-rdma+bounces-13178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C5B4A37B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BFF173748
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2C7305977;
	Tue,  9 Sep 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FbXv+VWH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8191F30A4;
	Tue,  9 Sep 2025 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402889; cv=none; b=s/5eMN+EUQQXJPh/SJwoQqPcFrj5lPsbcLAW/iQcgAb5r0CQD0kNLPYuaMXKeUSxJiG3DNzyEQru74LabfXcCxOyArFQQsI0addpDfrp8wCXHxLubopmYyxDACH6BKpE3vJ1fvYgCvES6rXPzHrdDbkHynTJCXb3fuBIV0DDCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402889; c=relaxed/simple;
	bh=7tq0rB+OZeVxR4LDFj8Sj+bBipz9tCBGT0YCkItiXVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eo3mxQ80Nebyp9mRkmnF5p0VAEez6EQFsDqVT+VSm0mG9djHMcKVq4XTrg55v7HQPgdbzSMy8ZWMQD7/LHRnY7tXgw0MBUi18lA8tdMxl8cC8umEnOFBO21zFAlP+u55tmsHnTErB9k9cQongWsHuqznVTrZ3X4fx9vwuBzZM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FbXv+VWH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588IrUS1010489;
	Tue, 9 Sep 2025 07:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y4y1j6
	YJGJnGlcF7FRxfmm3ZmcpNf9zRc3jdNS2kGVs=; b=FbXv+VWHWS3D6L8vAT0Cy3
	jBX3RYLVjFMlaz3LlvYmApqVpw0uvpo8O1QdDn1wfdBNWiOm30RO5dbEB0Yn+BIB
	+jpYTKmGJCw3jxwbx0q+dYVOT1bnMiEDmTVJXxEBL42jGQ/vIF4osrJuujYNzlsK
	ocZoC2kduDQSXP/pR2Y86PKUMYBABwqp3T1LIjJeFWaanJ9R2EWkuK1FhVFbuxWw
	mPHc+wjjSxSYnA+S6liTbrptZxnQrUXvs1herEE9UtA4G7D0ZNzrEew6CPfRqgfy
	22/0KzBVSxEM3BrvGKP39ElwGO4tPZGlrniuySvorXdxmI74cfar8W9YF5fmwaBg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukebcva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:28:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5897N3n3009527;
	Tue, 9 Sep 2025 07:28:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukebcv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:28:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896CaWp007895;
	Tue, 9 Sep 2025 07:27:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109phxhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:27:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5897RtOI39977318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 07:27:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79EE920043;
	Tue,  9 Sep 2025 07:27:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D5C2004B;
	Tue,  9 Sep 2025 07:27:55 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 07:27:55 +0000 (GMT)
Message-ID: <9ae41752-0e49-441a-8032-55673d19e0c2@linux.ibm.com>
Date: Tue, 9 Sep 2025 09:27:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/14] net/dibs: Move data path to dibs layer
To: dust.li@linux.alibaba.com, "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
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
 <aL-QJr0pBCZmXhf0@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aL-QJr0pBCZmXhf0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfXwQX9qfY5I4nR
 L59TT6rZlpKoGDf1UUgUw/vb8fw1tHxxdH8A0kg+LiLzlTICt4Qhk+L7Vd7VOO+OKUzJz3ADy/n
 845csZ6DHQ4BrFb4pzlJ61YJEHCMHO/IT9GEssRyqTCGNxn84weisWmE8buH0hefulY3xH45RCN
 uKD6OmnS+2mS5byBOyKhW1t/WfPVbsUPG5ATIL5jPsGAPZrEVDi0fvFH9AYqRuMN853RxjXBA3x
 gimO1k1VvLMEvcfH6pf1VARns3lYoTMHA93z+rsq7KYiSTaQKa3TN+ZeFxrMPitO77u2tsRLOBr
 WNaZ7EK4hP6g8Whc0gewYitxRmBjyUMt7c3Ba9dhfgDdWFpnOZbOyKikB5TfWQ7B+eQnyUIiPq1
 opQ05U3d
X-Proofpoint-ORIG-GUID: aVTBe4bCCOl-h4-ugl3UkUYP1qZdQLIX
X-Proofpoint-GUID: ve5zoNlqBZ5_w0by38-wbLZ6jBJ9D4Hy
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bfd700 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=6b5ucB2XjEZivXb5_SsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195



On 09.09.25 04:25, Dust Li wrote:
>> diff --git a/net/smc/Makefile b/net/smc/Makefile
>> index 96ccfdf246df..0e754cbc38f9 100644
>> --- a/net/smc/Makefile
>> +++ b/net/smc/Makefile
>> @@ -6,4 +6,3 @@ smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
>> smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
>> smc-y += smc_tracepoint.o smc_inet.o
>> smc-$(CONFIG_SYSCTL) += smc_sysctl.o
>> -smc-y += smc_loopback.o
> Why not remove smc_loopback.* as well ?
> 
> Best regards,
> Dust


Great catch!
-> will be corrected in next version.

