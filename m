Return-Path: <linux-rdma+bounces-13754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE53BAFE2D
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA421C7806
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Oct 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79922D9ED7;
	Wed,  1 Oct 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZSXykRCi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5B278150;
	Wed,  1 Oct 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311495; cv=none; b=ELZTFnKh4t1jmkWXNY5jzf/DUfQrCntBGkqwWFHlZLiPvXGkWxUKNCkBzZJ9QIuZUIRKXJvSS6E1lMCWIyZsmE8oeZDgzjknue/HXq0xooPjtgn2+mAdaHO8NVAVGty4Cv+RJmBhSIGJfOclIn3R8QKQfWLuvrtxU3KaxGB73/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311495; c=relaxed/simple;
	bh=HBNLnWqag4y3UT0dBQ5pPCBHzHPEBNk+pQGMnJzp98M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0iRpTWV373bGnNgCaAJ6gIroMZN+7qKgn2WNRwH/ZZcKqvbflXcziIZb1um1UyqjowRa43QuevFoLkg3AqTtj6SOQAiyS4njqpMWXutnkA5f3wxZ2Sop6UgAi/HLAGS6VuaMJfsXgSgEOrK+pvegzc7SnBBrY0wItIzxpF9T44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZSXykRCi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916Y4DL008978;
	Wed, 1 Oct 2025 09:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dZJ4bR
	wYxvI8Llc1XXA1o+1TApcKPXxvoY49BSpv3gI=; b=ZSXykRCiCDi9qSn/D4pq0Y
	H8vOXkVzvAt8+L3rfNy7XVF9JOkvzOKQf/TrxsOVXhGBOeHFrr54mRCqX2H9bbBj
	xuHyF+oNuvPK/SdpIy8q8rXR8dnXe8txGh3gLLyfpWeGgGxA++jGFq+T51FM+AV4
	cqy+uKtMd+tLcgMAEN9dnIauaMt+v6kptdJ48d7fiTx9pvv46qUe6eumgb9teeZC
	6bex0+24uKEpseR6JOjIBzv/IOP0mu9gX/RzqdOZnfOa2uSP9HlpLbT1uJrhQUkq
	15usyxINfaLSKu2YMs0ImDCRvqSqEhy74vwjPsI37lgp0x73e3d2nyhQ0Nsgm70Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqx33q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 09:37:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5919bx4m022819;
	Wed, 1 Oct 2025 09:37:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqx33k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 09:37:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5915aJdN024191;
	Wed, 1 Oct 2025 09:37:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy17rhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 09:37:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5919bsY456951258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 09:37:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E50120043;
	Wed,  1 Oct 2025 09:37:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E1D20040;
	Wed,  1 Oct 2025 09:37:53 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.14.128])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Oct 2025 09:37:53 +0000 (GMT)
Date: Wed, 1 Oct 2025 11:37:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta
 Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>,
        Guangguan Wang
 <guangguan.wang@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <20251001113751.17e9eb31.pasic@linux.ibm.com>
In-Reply-To: <acad498b-06e6-4639-b389-ef954e4c6abc@redhat.com>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
	<20250929000001.1752206-3-pasic@linux.ibm.com>
	<aNnl_CfV0EvIujK0@linux.alibaba.com>
	<20250929112251.72ab759d.pasic@linux.ibm.com>
	<acad498b-06e6-4639-b389-ef954e4c6abc@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX1CiPGiYSFxCl
 dtfuqyNFp79/kJN6zzDiBVaozb4Afu+yvcTwZCUN2ps38P6Gmg4gxRVDx7J9P6VAlQ+HzZDofLt
 3NK1gy7CSW770Lkum/PzF849jmJ4V0FzDVruuhZ/tp5ORiN1uthfT/vTQAAX6uIj8MMGwQYNv0p
 13UAF0VJxYnp4F/uhK2KWoPywIftxkI3AiY+kAXhkyTNgRleNj7hSUyqSW974a7E0mmZaMwSmCY
 Q2Y4e+k0O70KVVVmxAXr7riLIt199TbN5VoBJlymXg14GhhT40yHuegPss/ISjh5ege7TfMTZGZ
 0rL1eebJhzS0H6NeWGSjvNXII4/4Tj1y3QEoxaXnP1No4TOV5ov4VFHZ1rHpCydrUW2tkyCmDb2
 9yppB6HEURyOvlNsYQ+GgXCTsrM0TQ==
X-Proofpoint-GUID: SwTTiudnV0p8FOOkMonpK7JmQkDqDN08
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dcf677 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=20KFwNOVAAAA:8 a=SWeHzL2Wsuba8V6tri8A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: fAL13DQhW0VQgaJcTSECik-HboFRYs-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

On Wed, 1 Oct 2025 09:21:09 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> >>
> >> Since in Alibaba we doesn't use multi-link configurations, we haven't tested
> >> this scenario. Have you tested the link-down handling process in a multi-link
> >> setup?
> >>  
> > 
> > Mahanta was so kind to do most of the testing on this. I don't think
> > I've tested this myself. @Mahanta: Would you be kind to give this a try
> > if it wasn't covered in the past? The best way is probably to modify
> > the code to force such a scenario. I don't think it is easy to somehow
> > trigger in the wild.
> > 
> > BTW I don't expect any problems. I think at worst the one link would
> > end up giving worse performance than the other, but I guess that can
> > happen for other reasons as well (like different HW for the two links).
> > 
> > But I think getting some sort of a query interface which would tell
> > us how much did we end up with down the road would be a good idea anyway.
> > 
> > And I hope we can switch to vmalloc down the road as well, which would
> > make back off less likely.  
> 
> Unfortunately we are closing the net-next PR right now and I would
> prefer such testing being reported explicitly. Let's defer this series
> to the next cycle: please re-post when net-next will reopen after Oct 12th.

Than you Paolo! Will do! I have talked to Mahanta yesterday about this,
and he has done some testing in the meanwhile, but I'm not sure he
covered everything he wanted. And he is out for the week (today and
tomorrow is public holiday in his geography).

Regards,
Halil

