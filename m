Return-Path: <linux-rdma+bounces-13644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3AB9EE61
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB6B7A31A6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02D2F7ADA;
	Thu, 25 Sep 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ihnaF8Yi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B520CCCA;
	Thu, 25 Sep 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799554; cv=none; b=cz5jz0qfXnEGsyz/KhlSi9CcOuTC/4seG56nDKMPSJpOvejBHfEjp7HII372bNzQ+fW9vUyxwq54FGqIVelZ+Ri3eLfO7suwPXvRD6BWImVZyhtTzqdIpqhmI2igfPCOIWSuKFldAENXU2lKHzpgQDThvgBvYTf3nR8LeLZ6wmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799554; c=relaxed/simple;
	bh=SRZwo8X8Ab4jnZeDhJ3dBokGUpKzvICVuAlXS/xMWjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGEG6AssSJ23tj2NlPMwoRy7iMcqc4LV62vGYqbfwn+ZiQqEvtLnw5JofocjGBaDJn+XenuV99jbd61ksRelG1r7KDK9k7qRN0YosPXXuPDlGFjIEbA3MnAVs82SsyceblizoULp0XSKIjzqXGoKElX0v3aPm9cd1irTt6pWUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ihnaF8Yi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P3mXjT002073;
	Thu, 25 Sep 2025 11:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i/4JFs
	q4pJZc7DKs/v/2k9j2INIBw3Zqo4ZyiAxkSe4=; b=ihnaF8YiVhMjdI4Mb0uEP0
	sVoqUaQnZ61nuDdInKNcjaidD4A9nLeEU+ZxlLhOdPMltdrkrF0ivK4YQVe0ai/s
	rclgK9MX2xp6ADhFwSQKE/xk7rvYnbUPneFDNO1Ja1JbLGCKCw13eGtItmHnesoZ
	mlt0LNGCQPlronW9RJcgmfY6rMp+aWr6Umpr1wpWsQupinX1mVAZQ7ghDh+WcnZS
	i/SIxGqXE5IGVO+jVq0Cue9r0UjxjxbyB4j6DMJFwIHMZ5B+MmQBlIIbF/xCSDb3
	3jOSlA2GuWF+iVfwhkkbQkUtTY5BMxP7q3dpTO2RwzRuSuCRVD0qm+E6/hw8Tx4A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkmn0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 11:25:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PBPmmP024919;
	Thu, 25 Sep 2025 11:25:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkmn0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 11:25:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAOK0Z030370;
	Thu, 25 Sep 2025 11:25:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1daqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 11:25:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PBPheS25887128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 11:25:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A2420049;
	Thu, 25 Sep 2025 11:25:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 857E120040;
	Thu, 25 Sep 2025 11:25:42 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.151.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 25 Sep 2025 11:25:42 +0000 (GMT)
Date: Thu, 25 Sep 2025 13:25:40 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        "D.
 Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <20250925132540.74091295.pasic@linux.ibm.com>
In-Reply-To: <7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-2-pasic@linux.ibm.com>
	<7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
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
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d526bc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=AX5NG-fjE0sAVBkmVVgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfXwmH4BqZNWINJ
 66oCEAr2m76HVkEnVPnJWaz9VlMxVqrVN6G+tUv5A7M8MUI8Vcz0c9k+0paqLeNEWbrfp/fSh6Y
 Z0MpqPdwMQczFRUoIPUkhTyWShCYNZRfrcEN9b2X/Yv2gWb62huM0CWcUUYHJk11VQpE9XiYvnm
 KTxZjlNPGC59ImKnonHqDG8iIM7eZM+9zOULHBk/ONGJWTcUFNbbfvP/uZ4idX1s0r4tnOXFk1K
 tywD+q8ovOX3UWlWf+iFNpadckqlgce4qNvU7Q1+EF2Nv13db19uHc6WzrKMToaATaIXlbv4kHQ
 k6DMjmCV97voM8u+eUD5AfAm+LKHdZ5TNIaF8k9GN9qWBymQt8V63NTcbi95cAQZMKynjNWj+lq
 emP4airN
X-Proofpoint-ORIG-GUID: HWXWXpRVgwWqwqZ-BPbuPsqi-76RIJrY
X-Proofpoint-GUID: cS1p2UpoI1fDrNznIt1dB83-s_-ZOBWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010

On Thu, 25 Sep 2025 11:27:38 +0200
Paolo Abeni <pabeni@redhat.com> wrote:
[..]
> > +smcr_max_recv_wr - INTEGER
> > +	So called work request buffers are SMCR link (and RDMA queue pair) level
> > +	resources necessary for performing RDMA operations. Since up to 255
> > +	connections can share a link group and thus also a link and the number
> > +	of the work request buffers is decided when the link is allocated,
> > +	depending on the workload it can a bottleneck in a sense that threads  
> 
> same                               here^^

Sorry about those! Will fix for v4.

> 
> [...]
> > @@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
> >  	};
> >  	int rc;
> >  
> > +	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
> > +	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;  
> 
> Possibly:
> 
> 	cap = max(3 * lnk->lgr->max_send_wr, lnk->lgr->max_recv_wr);
> 	qp_attr.cap.max_send_wr = cap;
> 	qp_attr.cap.max_recv_wr = cap
> 
> to avoid assumption on `max_send_wr`, `max_recv_wr` relative values.

Can you explain a little more. I'm happy to do the change, but I would
prefer to understand why is keeping qp_attr.cap.max_send_wr ==
qp_attr.cap.max_recv_wr better? But if you tell: "Just trust me!" I will.

[..]

> >  
> > diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> > index b04a21b8c511..f5b2772414fd 100644
> > --- a/net/smc/smc_wr.c
> > +++ b/net/smc/smc_wr.c
> > @@ -34,6 +34,7 @@
> >  #define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
> >  
> >  #define SMC_WR_RX_HASH_BITS 4
> > +  
> 
> Please avoid unrelated whitespace only changes.

Will fix  for v4. Really sorry!

Regards,
Halil

