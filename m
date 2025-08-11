Return-Path: <linux-rdma+bounces-12673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5BCB20BE0
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3931A189E396
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2324A057;
	Mon, 11 Aug 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mknuml1E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791524468E;
	Mon, 11 Aug 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922457; cv=none; b=fb5iCaUISmSqSGLH4zUCkr/QW9W0blUc2TQAbOZAgx2C30NV/tlWTH40YbJmgX2K5ZDBGbGcUU6Je8PCYRGe9tJEz/Lq1gXndFaWSMZJecoJKXWOa1Epdlgj52e9JuCs9iU9U8V6nAs4WibssFwAm+NR+LYWYYTmgsGEFNtBic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922457; c=relaxed/simple;
	bh=xc8zEZ4SLBVXvaNiqal5fEDwwLv5B3xd+aESbYwhq/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKNJjfMxGSHHi08ySKSJBQmAMHU99MoEMp8/DLaKEiKaP4T1+/HPh7Ze6FqtxloLdguhRUDcTgzgE7ur5IWnWLpnDMndUXxLJ7MxeZSH+aA+6QjRx4OGklLAlUS9pReJWZZlOPheP1NsXw1gtaaydviT6pjLsdQzc3IO1INIV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mknuml1E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9HB7m025025;
	Mon, 11 Aug 2025 14:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n3LE3A
	RJejgP5xBFaNFZkL86tktjb39ybgxhlNJATXU=; b=Mknuml1Eh9b/JHHpDQLICK
	VSw419Kce4lx1xdEB+30dnLCI/rqx0I580ZoJOLBB468IYzRtNnd6qKnS+Z2yDJi
	9SLaHzjcTcS4CwGJ3/bnHrdZGFW62jR74XuR9KjGRBjWo4+8LS9OEGi5/IPJYpso
	j+hc17c78hrEFP8dqdPOutM2zlqz918eAmjil2FfsmREbTmskTlZWiwpEFf0pMQz
	ul/BqxvfpkPD32rYQciG8u5t8p+xqBl7VbmnnZJEvhSdUEGW/VibEz/nYsA7sSpu
	Ft+zzkTgyCDEBfW3JPPK62jxvihXIWVvwY0aOBTx93tr6gOgyLnKbxtrZZRuRIjw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx149rg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:27:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BEQgTC012345;
	Mon, 11 Aug 2025 14:27:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx149rfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:27:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDoC1q026345;
	Mon, 11 Aug 2025 14:27:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20xc2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:27:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BERLJa26870018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:27:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEBBC20043;
	Mon, 11 Aug 2025 14:27:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DC2D20040;
	Mon, 11 Aug 2025 14:27:21 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 14:27:21 +0000 (GMT)
Message-ID: <2d511067-0cc6-4911-846a-ab815a0b318b@linux.ibm.com>
Date: Mon, 11 Aug 2025 16:27:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 08/17] net/dibs: Register ism as dibs device
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
 <20250806154122.3413330-9-wintera@linux.ibm.com>
 <aJiwrG-XD06gTKb3@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJiwrG-XD06gTKb3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 97XCpIFJhX24vLAD4jLkyGgNX9O26ocC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5MSBTYWx0ZWRfXzCKc2BmAaubV
 Gew20LbWShdR38JKj6BbCYhKeRTFwX1WTY4eaJV6mlbro+oesbwWBTUdb68Tg/G+u0+gC/xlZAt
 Td2sZEeMUPDg3WfrOei0FfAwD9sxGx5iCx8rfqI0y4DwNNc8NMpSXuYBtG4azoqCi4K7v80dud7
 sYGJIEOzgKbAd1Nb0qSaemah8ZebTro4J6gdKGNQPae4L3oOiQIaOWNjQmLx18OtJMhJETjiT1y
 G7/iZaCVdWuOff6wul/OlWnr1y2GfeYb5fl1ldmOMEcDGgtXNU6t2t8FqmPYXZpj3b9oMAXJwcd
 7P8/JfnPqXG/PbfWRY5GXCFlIpnssAi3QcLUhty6JgWh597A21Op6GHWTZ0+M1tN8hPbJGyD+vA
 r8wV0BIP6gZd59+3vY46+msU0nZmMsGuXpGFSMMoFTV24U7MVlCsoZulofpL9ZWP/bdIHup3
X-Proofpoint-GUID: kiRFILACJSlKp_sugaUvxe1JQQXDy_Bx
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=6899fdcf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ZVXq7tgFbyrpfJilAYUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=862 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110091



On 10.08.25 16:46, Dust Li wrote:
> I've been wondering whether we should completely remove the ISM concept
> from SMC. Including rename smc_ism.c into smc_dibs.c.
> 
> Since DIBS already serves as the replacement for ISM, having both ISM
> and DIBS coexist in the codebase seems a bit confusing and inconsistent.
> Removing ISM could help streamline the code and improve clarity.
> 
> Best regards,
> Dust

I second that.
Like I wrote in the last commit message:
"[RFC net-next 17/17] net/dibs: Move event handling to dibs layer
...
SMC-D and ISM are now independent.
struct ism_dev can be moved to drivers/s390/net/ism.h.

Note that in smc, the term 'ism' is still used. Future patches could
replace that with 'dibs' or 'smc-d' as appropriate."


I am not sure what would be the best way to do such a global replacement.
One big patch on top of dibs-series? That would be a lot of changes without
adding any functionality.
Or do you have other clarity improvements in the pipeline that could be combined?
I would like to defer that decision to the smc maintainers. Would that be ok for you?



