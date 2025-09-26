Return-Path: <linux-rdma+bounces-13671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F2BA359D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 12:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81551C04F7A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91752F3C22;
	Fri, 26 Sep 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X0a4yXyk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B942F360D;
	Fri, 26 Sep 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882645; cv=none; b=qKS83yYt2kBbqSiOw/Hf/xFQlZLw31RGlyoFk8/f0vEOp1l0AmeZyhCJ1hXUHr1j8q31nEd91L3dOztOkDp6P6Ha4SfKX2CqF1OWdZtJjmIq5RuJe6MSW/Iv9CCh9laxeuhzzQTZUbOgOTj7dXWcKKCpXX/+V0LoCWUOGKU3Udg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882645; c=relaxed/simple;
	bh=VcaRO8Q4BuhxAFlGDSCDBACnJVMhZ7quCZavgMmXH1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrSEgVxDilGyMAQnC30BEboCN9c1D3tWOcgoT8RNew08ealuCoe/0hirbZK9QR86jHcldlmqUrCEw8Csko5xt9yWVQp+L9qzmLC9o7l9tsmSsrOp2xKoyjuLqYfDtQIEyYbtTI9iAd9hYrUodVV14rIaIPXOWaFMiZyjtkdjTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X0a4yXyk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8UVEK017833;
	Fri, 26 Sep 2025 10:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K4PW2i
	h2I+vEDzAbxVRYkCFdsvu/qJABukRhxOE7B98=; b=X0a4yXykz8zb8zcOQmG/BY
	LK2KL/7szT9osmnb9V+KTwldUDJok2r4ywUmU7FHhE/7RwU1RzsSNDUa49tUf7n5
	QVZqLl/mBrxxdVPXPRfe+7LvMwRtFVgv/bemGu0bkPN7DdZl+HMDLnFxUu2u7UIx
	9CUCD1h8lR3Fbtbq5L8p8v1OefJ3/gut9tIABcrGqU6S5611/J7kWL+7c1tneiou
	fvlj75EFOIMi8DK5exjyz8s2Nyst17jdk1Z8HZdoQkysWBN6IGOpBZTJNed6xMfO
	Gq8ixSy8kpjg8sFYbOyGwTx7xr1p7RQF4SHNbuuq3wTdupe7MoPAgHkr2/ib51tA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbdbup1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 10:30:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58QAUdQb025104;
	Fri, 26 Sep 2025 10:30:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbdbunx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 10:30:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q9VRZC023715;
	Fri, 26 Sep 2025 10:30:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ddbd2td9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 10:30:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QAUXVn37028244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 10:30:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB832004B;
	Fri, 26 Sep 2025 10:30:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E871920043;
	Fri, 26 Sep 2025 10:30:32 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.129.170])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 26 Sep 2025 10:30:32 +0000 (GMT)
Date: Fri, 26 Sep 2025 12:30:28 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon
 Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <20250926123028.2130fa49.pasic@linux.ibm.com>
In-Reply-To: <20250926121249.687b519d.pasic@linux.ibm.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-2-pasic@linux.ibm.com>
	<1aa764d0-0613-499e-bc44-52e70602b661@linux.alibaba.com>
	<20250926121249.687b519d.pasic@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=F/Jat6hN c=1 sm=1 tr=0 ts=68d66b4f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SRrdq9N9AAAA:8 a=6pkw325JrgbbFHPZdqQA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX6lcfK5uy7NVa
 96OE2el9UT0J7bWeuh+b7yUme3xjPQSdZUn69acRRJrKMb8WkEyvgR6Cwmw58kDF9HAoZD2O+2i
 X7xFizfTKf7FRAIxPEGMHk3GabKPIrnLpAhJwrcxLaufvAbCnvQSsmPMV5gdLqEzRq3g1naoBlT
 JvTOf/faxvgA8RId+tGXuQ2RwFp7KkgduUHMrQw+PY5421woaJbvulPUq5odlbTi8nWJwx+1Ic8
 jsp+2UtrrakFJX35dueMFa+TeYXfavaXYdJiFM3Hy64+o0NS2+dogHxlm4TkuHAl2btldh0jsY/
 ZRd01NqSsEKX9uzbWq4rnmI7E5Sp+G/y8Vui6P1r8nM5L4lEfIi1fj6R/xeseEufS3ifm331YS1
 PsefuGfK4wQuP3x7TBRYIam1x+7uqA==
X-Proofpoint-GUID: zSeVLDsre_ZUVPL33QuOob9J3t1Jqdgt
X-Proofpoint-ORIG-GUID: lUEV-8kojKKyErlWjc2CZKjZurQxZZKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Fri, 26 Sep 2025 12:12:49 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 26 Sep 2025 10:44:00 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
> > > +
> > > +smcr_max_send_wr - INTEGER
> > > +	So called work request buffers are SMCR link (and RDMA queue pair) level
> > > +	resources necessary for performing RDMA operations. Since up to 255
> > > +	connections can share a link group and thus also a link and the number
> > > +	of the work request buffers is decided when the link is allocated,
> > > +	depending on the workload it can a bottleneck in a sense that threads
> > > +	have to wait for work request buffers to become available. Before the
> > > +	introduction of this control the maximal number of work request buffers
> > > +	available on the send path used to be hard coded to 16. With this control
> > > +	it becomes configurable. The acceptable range is between 2 and 2048.
> > > +
> > > +	Please be aware that all the buffers need to be allocated as a physically
> > > +	continuous array in which each element is a single buffer and has the size
> > > +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> > > +	like before having this control.
> > > +
> > > +	Default: 16
> > > +
> > > +smcr_max_recv_wr - INTEGER
> > > +	So called work request buffers are SMCR link (and RDMA queue pair) level
> > > +	resources necessary for performing RDMA operations. Since up to 255
> > > +	connections can share a link group and thus also a link and the number
> > > +	of the work request buffers is decided when the link is allocated,
> > > +	depending on the workload it can a bottleneck in a sense that threads
> > > +	have to wait for work request buffers to become available. Before the
> > > +	introduction of this control the maximal number of work request buffers
> > > +	available on the receive path used to be hard coded to 16. With this control
> > > +	it becomes configurable. The acceptable range is between 2 and 2048.
> > > +
> > > +	Please be aware that all the buffers need to be allocated as a physically
> > > +	continuous array in which each element is a single buffer and has the size
> > > +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> > > +	like before having this control.
> > > +
> > > +	Default: 48    
> > 
> > Notice that the ratio of smcr_max_recv_wr to smcr_max_send_wr is set to 3:1, with the
> > intention of ensuring that the peer QP's smcr_max_recv_wr is three times the local QP's
> > smcr_max_send_wr and the local QP's smcr_max_recv_wr is three times the peer QP's
> > smcr_max_send_wr, rather than making the local QP's smcr_max_recv_wr three times its own
> > smcr_max_send_wr. The purpose of this design is to guarantee sufficient receive WRs on
> > the side to receive incoming data when peer QP doing RDMA sends. Otherwise, RNR (Receiver
> > Not Ready) may occur, leading to poor performance(RNR will drop the packet and retransmit
> > happens in the transport layer of the RDMA).  

Sorry this was sent accidentally by the virtue of unintentionally
pressing the shortcut for send while trying to actually edit! 

> 
> Thank you Guangguan! I think we already had that discussion. 

Please have a look at this thread
https://lore.kernel.org/all/4c5347ff-779b-48d7-8234-2aac9992f487@linux.ibm.com/

I'm aware of this, but I think this problem needs to be solved on
a different level.

> > 
> > Let us guess a scenario that have multiple hosts, and the multiple hosts have different
> > smcr_max_send_wr and smcr_max_recv_wr configurations, mesh connections between these hosts.
> > It is difficult to ensure that the smcr_max_recv_wr/smcr_max_send_wr is 3:1 on the connected
> > QPs between these hosts, and it may even be hard to guarantee the smcr_max_recv_wr > smcr_max_send_wr
> > on the connected QPs between these hosts.  
> 
> 
> It is not difficult IMHO. You just leave the knobs alone and you have
[..]

It is not difficult IMHO. You just leave the knobs alone and you have
3:1 per default. If tuning is attempted that needs to be done carefully.
At least with SMC-R V2 there is this whole EID business, as well so it
is reasonable to assume that the environment can be tuned in a coherent
fashion. E.g. whoever is calling the EID could call use smcr_max_recv_wr:=32
and smcr_max_send_wr:=96. 

> > 
> > Therefore, I believe that if these values are made configurable, additional mechanisms must be
> > in place to prevent RNR from occurring. Otherwise we need to carefully configure smcr_max_recv_wr
> > and smcr_max_send_wr, or ensure that all hosts capable of establishing SMC-R connections are configured
> > smcr_max_recv_wr and smcr_max_send_wr with the same values.  
> 

I'm in favor of adding such mechanisms on top of this. Do you have
something particular in mind? Unfortunately I'm not knowledgeable enough
in the area to know what mechanisms you may mean. But I guess it is
patches welcome as always! Currently I would encourage to users
to tune carefully. 

Sorry about that half baked answer before.

Regards,
Halil


