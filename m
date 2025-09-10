Return-Path: <linux-rdma+bounces-13225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE6B50F8C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89773A8346
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E230BB92;
	Wed, 10 Sep 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mrc24Ov6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1816307482;
	Wed, 10 Sep 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489694; cv=none; b=dS3fx5IJvLjG+8z606CRiW9fYwFdk0Yi4ab1HZ2fQFyI92lMviyJaO59siOG/Fr38hoz5XTtyzSoQO74y33/Ab6iyKdSP8XC0B/1AFb6hybrflC8F5jcxgQcxQRWH3ngxZcFydCxsXUrgNLJQp/sOXIEEqkEiZ1G/IESbf8E+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489694; c=relaxed/simple;
	bh=ykmA5jaVgb8EGCG4tf/T8yLLrrfQlIBVbuhaU7Cf2/Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VdBbkutSC/n6B+CR7iblGjhoOVJUP9PQaugizVK6nW2haNYs8wJE4ZlDPYq31Uj/K542FPwNlsR2wC3YJjUK9igRmcnzZ2NWTNgm8S+NeegS9mBcnL0vWujo2vESwGPRSdxtKx5/H3+MZFwUShV6qjcJ559yknFztj4YYijW81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mrc24Ov6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589JrRxJ002811;
	Wed, 10 Sep 2025 07:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CRy9cT
	mLj42zyN4VEUmHt8NS2KOT1rlIw1fWL7XgbDk=; b=mrc24Ov6zE7q3rTlrhdTVq
	Nrb1vag9QkmtMrNpg1tNc9Vh6S10tF2dZz6wCePnNSEQu1ZdKaF+cQ8NodoONeT2
	XyoY7Tq1H60lYhYK3DeJ4Hp6CPW6rIN3fvKgtWP65Z5d7/P6Is96JyvNQYnx/QsB
	+z1SW+pDOqPSwqJoO5cYzULrbVaz5bpKOgKigJO52YbwRnUv0HCLuQ9k2J5sVuy0
	V0dN8kOo+ZTDroJ/TGVtcb+3ltJD4kwQnYa0/Sqfe6tf3zVMVdIy7ADKsXcVCBgQ
	A2w7oXA2O3oN6G5htC8wdhsVhpU9PaTSWAvJxNGlMuN0Bs8XoeETa8UtU3DJDF1g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffckjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 07:34:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58A7X0V2029012;
	Wed, 10 Sep 2025 07:34:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffckjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 07:34:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A699r4010618;
	Wed, 10 Sep 2025 07:34:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smy7dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 07:34:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58A7Yd2Y51970508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 07:34:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FCF420040;
	Wed, 10 Sep 2025 07:34:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E04A92004D;
	Wed, 10 Sep 2025 07:34:37 +0000 (GMT)
Received: from localhost (unknown [9.111.18.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 07:34:37 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 09:34:37 +0200
Message-Id: <DCOY3FWT1W5E.3SSDEILQWSZOF@linux.ibm.com>
Cc: "Julian Ruess" <julianr@linux.ibm.com>,
        "Aswin Karuvally"
 <aswin@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "Mahanta
 Jambigi" <mjambigi@linux.ibm.com>,
        "Tony Lu" <tonylu@linux.alibaba.com>,
        "Wen Gu" <guwen@linux.alibaba.com>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        "Heiko Carstens"
 <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Simon
 Horman" <horms@kernel.org>
Subject: Re: [PATCH net-next 03/14] net/dibs: Create net/dibs
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Alexandra Winter" <wintera@linux.ibm.com>, <dust.li@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        "Sidraya Jayagond"
 <sidraya@linux.ibm.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        "David
 Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Andrew
 Lunn" <andrew+netdev@lunn.ch>
X-Mailer: aerc 0.20.1-89-g2ed71ec4c9b9
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
 <20250905145428.1962105-4-wintera@linux.ibm.com>
 <aL-IwWQN7ZUNdjky@linux.alibaba.com>
 <b2c1b2b9-ce28-4a20-bf48-a427b364a664@linux.ibm.com>
In-Reply-To: <b2c1b2b9-ce28-4a20-bf48-a427b364a664@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pxur2GrhIb__hu_izBeNTHQgDshD3mVK
X-Proofpoint-GUID: P6EM-awCuj6tn-6cVxdhsRWxlqtVst7t
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c12a15 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=jaUBvY7-Jl_CN4xHXQkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX/sLBkCjqALY8
 YoOkgaMwGNBCvZ2wXM5TAmzooiAJW95uqRutvE3Vei2x98WDsVhL+nv2GrgAMd6WpvhutwbZBkm
 lNLqHiq6wvhkWDyAQcm+AedscG2hGtMLibgBb5p149W3YcVr4e5rE24nuICLUf738OSqUfqSDZT
 Q149aISq1c8KHDDEQgQv90U54U/zALTemK9ptEtIoGhgl3a8pfk2TGH6PXfODbqqV19hXuQHlBq
 79echPlnzKpbAs64FaRwkSHuyKE+PdAsZnhriVdapxoy7w3o0PFBFOfZh8H6SjjARnea7SRggAl
 UqHjiQTNr0WxhMNJr8eJ24Ykrr2y4mFyl64WXkGexngI6fn4LHWzovDXy7tn0xkUsYjAF7Flp6Z
 f/QrgPuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Tue Sep 9, 2025 at 9:36 AM CEST, Alexandra Winter wrote:
>
>
> On 09.09.25 03:54, Dust Li wrote:
>> On 2025-09-05 16:54:16, Alexandra Winter wrote:
>>> Create an 'DIBS' shim layer that will provide generic functionality and
>>> declarations for dibs device drivers and dibs clients.
>>>
>>> Following patches will add functionality.
>>>
>>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>>> ---
>>> MAINTAINERS          |  7 +++++++
>>> include/linux/dibs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>>> net/Kconfig          |  1 +
>>> net/Makefile         |  1 +
>>> net/dibs/Kconfig     | 12 ++++++++++++
>>> net/dibs/Makefile    |  7 +++++++
>>> net/dibs/dibs_main.c | 37 +++++++++++++++++++++++++++++++++++++
>>> 7 files changed, 107 insertions(+)
>>> create mode 100644 include/linux/dibs.h
>>> create mode 100644 net/dibs/Kconfig
>>> create mode 100644 net/dibs/Makefile
>>> create mode 100644 net/dibs/dibs_main.c
>>=20
>> I recall we previously discussed the issue of which directory to place
>> it in, and I don't have any strong preference regarding this. However,
>> I'm not sure whether we reached an agreement on this point. In my
>> opinion, placing it under the drivers/ directory seems more reasonable.
>> But if net/ is OK, that works for me too.
>>=20
>> Best regards,
>> Dust
>>=20
>>=20
>
> You mean like drivers/infiniband that provides sys/class/infiniband?
> I don't have any strong feelings about where to place the directory.
> Are there any practical consequences?
> Other opinions?

I agree with Dust. Since we are planning to also have non-networking use-ca=
ses,
it would be better to place it in drivers/.

