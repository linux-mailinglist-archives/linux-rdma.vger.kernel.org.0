Return-Path: <linux-rdma+bounces-12672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2958B20B5F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913F61707A4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421ED2459C7;
	Mon, 11 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OQKabDCS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563E21504E;
	Mon, 11 Aug 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921455; cv=none; b=PsHEepE8hzO0YhPmIyPN5FIY4sO/2vTtJRuH6qVJIkWUGUWPWCKB3erlj1pzUbYIyMGnphtO6CcnYDy92jknnD4cwhz/PSQ3mLwSRpNrRARRgTJk+V8/ZgiuiD6YmuIhUMtLLIwYPaZcbX9kQTlfoung3Ye11YI9KrC09x90TjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921455; c=relaxed/simple;
	bh=GOPzfBHk73dLWo3dYx183O4CEy9BVlilrv2VHXktgCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpbqcCogCaDgzDiC1au2wVZXoi84JGE8mHbBGvW6IHGbn/4HZkUGSzNXk8GVgSYpK9ptC5yiNBSl9VOco3Uh3ZDJAElY6w53Eywl2W/oX4CuWDgfkQn3RVbyj78LZ/TCUKXRlJQv4b8iwSz5ffiK3wrm4F8Iz/04VqDq+a/sSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OQKabDCS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDdQMG026314;
	Mon, 11 Aug 2025 14:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sE30Z9
	P1ro4AVXsJ1u5vy58MJt7mO4XO9gYxxo8aZU0=; b=OQKabDCSCzzb6k9hH6/VlR
	sMWJU6BRjr3+QrA75nMNZhoVuvTIs4IxV+8xp5M1kEIu0TKdzpb+TNcW6Wm6gdm4
	rHPppRTpscoXz4Ut3b6NyOzzcHL3Jxb68ujkiO65AZJ3bB+KvY7C1gVG/F82DpSA
	p6MksneVhn/yhdlrKEN3KJ0Hel5I1/pw+oqJXpykNHrU2FzU/eLUlbLLqzHw5/07
	7zSh2FC5RutpGXGx/NV0w+6ScRV9LEGAqS6QhDmip6mUJRG8DUSXP4ZuE8PXuogC
	ovq0qRCJs1bxpj2n0iiZcBjaHcg377AdUw7gyGTzHBHiLKUx6Q+8rzkhALLhCKDA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cspmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:10:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BDjqqU014720;
	Mon, 11 Aug 2025 14:10:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cspmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:10:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BC0Mc1017617;
	Mon, 11 Aug 2025 14:10:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3dttm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:10:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BEAcDH23068972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:10:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A46B20040;
	Mon, 11 Aug 2025 14:10:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7B2720043;
	Mon, 11 Aug 2025 14:10:37 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 14:10:37 +0000 (GMT)
Message-ID: <bfcadbfa-ba05-49a1-96d2-47cc8a4fdfe1@linux.ibm.com>
Date: Mon, 11 Aug 2025 16:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 05/17] net/smc: Improve log message for devices w/o
 pnetid
To: dust.li@linux.alibaba.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
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
 <20250806154122.3413330-6-wintera@linux.ibm.com>
 <aJinqObGQ-OHjadu@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJinqObGQ-OHjadu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4OCBTYWx0ZWRfX0FTaUTY0WTBs
 PhxJ/BqdnXJpWKKVnh4BwjnaCzJggxNWhHsWoEi/1CZ6VoRRNLMBYNZZgYqGWR3vcjULV7h3eYD
 ZucPxB5GPr8o2XNTRz8OrQ4vrIBBnzBitf+Y961tmVQ6UdOaiV7qk4N0QAF1Lv3p8dgiKdKxFY5
 bjol5ITPRCQkjB/0Abuibkc2Wk8/0nVBP0QYEEYre7sMne97RNVg3lKH3EGzWfyWyj3cfG3lZOM
 SwKF44huPCuOqp5+abIV+P+DZU5UGJLFYmpOnLtytbaxdpsp93qCOdI0aVwauUjE9GwHubNgk50
 1UfvnCanDwIzlZUIBSxmmjrKvoj5caRh10Qqpw1nskyKAfeSTqSKDVXvPQWpMbaSJGzkSvrPCsc
 GQKVtwVhR5P4apP1RX/DK2yDC2cAAmvuw1Cthw8SwlSe5CjgWvEikPzktoisVSNaRMcQDGH5
X-Proofpoint-GUID: VdbhveRbsMKp5zBBBsego82JyDFYar9b
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=6899f9e3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=YXTC0nPQFvoLocbtccsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y0SSZvxv-iYbzH3LbdyEuevGSX3JQldY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=487 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110088



On 10.08.25 16:07, Dust Li wrote:
> This patch doesn't seem strongly related to this patchset, so it might
> be better to send this patch separately.
> 
> Best regards,
> Dust

You are right, and the same is true for
[RFC net-next 02/17] s390/ism: Log module load/unload

At the moment I would like to keep them in the series, so people don't have to worry about
applying the series with or without them, because they touch the same files.
In case the series gets delayed, I will split them off. That's why they are in the front.

