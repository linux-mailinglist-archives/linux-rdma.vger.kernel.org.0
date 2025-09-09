Return-Path: <linux-rdma+bounces-13190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16189B4AA48
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE6340868
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD831AF15;
	Tue,  9 Sep 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YfrHPNLB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CD219A7A;
	Tue,  9 Sep 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413144; cv=none; b=E+s+odI7+mQfBbFSR/pExah9xapZGNcEnKwxQqs+QmdG44PZ3j4cI3QErY4x5dDT9VgxhwaepxRxnHiqlYP65Q88DgBwYTvtal2wpx1/5NuQAbEnQ9xfHAGO4c5LHKXPHlIWhyyxfOcyCY/nMVC3yQLNrrYxvj5lbqz8NSvFDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413144; c=relaxed/simple;
	bh=NWOEu18B+foxaU60ODchsyiVUXQtXS2hXD0XBYzA0yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc9apHU4sMBkg2Xpme1/uelxZqWLcIQdNVFiV1TC9cMlUwhzNcZChIIAQaHjDqcfQi2K8179m+85CmTOmlZBAGWA3kxC8T4PTUppxs6Zj43wB1qNAv4PdpkioJuFMZWJ2dFGSgBfWhr94rI6NIPJDSyXbzRUbM/pnuyd0FpkWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YfrHPNLB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5890Lf9x011307;
	Tue, 9 Sep 2025 10:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o2nQEF
	sqMXsSZn1MR5zX/hHpl0yOesXiOxhC6JXsvJ0=; b=YfrHPNLBzAYj3w4Mbfl2PS
	GOnfUa8GcaK/bMbs8D9K8xZ7pZaF+nERCHXzi8OT2NI6vRHiLhy9iX3KoRoToxHf
	AD+JVzRnsYp60LQ/SDJ+j+oYV+hB0eC9h6CkC994S0hWMmVxkyc3nkhA3m4Hcwk9
	fYLlYfke/NUQt4zrRNLP2/iVPCqbwZEbVEWoZrUCkbOCzXnlBR56WkiaGxj6PYVW
	sKzHAlOM73sxN8jxyujgyAeaYVraWuDedWdytS8pXUkd5NfKJ1iVUwj69rDQc5f7
	bZsPP7YHuZ/D2OatHq+vUikbdBP1+9qAWXXJSs+fjfx6wO6IRW1A21gXCHNtRpoQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsptxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 10:18:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 589AHfan024446;
	Tue, 9 Sep 2025 10:18:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsptxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 10:18:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899NqXK020492;
	Tue, 9 Sep 2025 10:18:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0tr7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 10:18:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589AIrlJ34013882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 10:18:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B06B2006E;
	Tue,  9 Sep 2025 10:18:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE372006C;
	Tue,  9 Sep 2025 10:18:52 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.23.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  9 Sep 2025 10:18:52 +0000 (GMT)
Date: Tue, 9 Sep 2025 12:18:50 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon
 Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya
 Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v2 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <20250909121850.2635894a.pasic@linux.ibm.com>
In-Reply-To: <aL-YYoYRsFiajiPW@linux.alibaba.com>
References: <20250908220150.3329433-1-pasic@linux.ibm.com>
	<20250908220150.3329433-2-pasic@linux.ibm.com>
	<aL-YYoYRsFiajiPW@linux.alibaba.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXxeWmgkEAGi/D
 SxGF3ya44SyJJrQUdNkgCofOTXWHrwaCViXubHVn/69Z53lJumdAjq3CCM/ykAQF4BN5NxIBBlf
 KOzO7HmB7PVWNAUKb4azcarSKjGoU4yhr0q90t2HXXMqgX1OoWeqi06+XCKvz9qT0mNYeoZi3G5
 rOkBescYPpoBIMoejs4CY7tP56MaBLKLDL03549msbuI2JKSMzAgKb+/lCRSOSVYcnqevqVs/m9
 0jpvIkIRCh4x/5wg3FaB+jE8o+Hv0HVM9P79YmuE4zZr9BEOQRN/hnBpWLjA9iz59irKEBFA+lZ
 mpsLHonI6Tm3moUx7aBpFVdG80whMgMhpzTLDPRAmH0fVHBTTUqR+UmlRXyETOxdohmLnjKWP38
 fi3kv6WT
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bfff12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=yba5Uwut08PlTq8H50kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 0U49OlBsC8IZnhxJiIXafk6oEFThXR0F
X-Proofpoint-ORIG-GUID: NGqJhiHEEpz3BjjobnLk_onfjMoTwbps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Tue, 9 Sep 2025 11:00:50 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> On 2025-09-09 00:01:49, Halil Pasic wrote:
> >Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
> >SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
> >get replaced with lgr->pref_send_wr and lgr->max_recv_wr respective.  

Yes it is just in the commit message, I messed up the search and replace
in the commit message. :(

>                             ^                       ^
>                             better to use the same prefix
> 
> I personally prefer max_send_wr/max_recv_wr.
> 

Will go back to that then for v3

> >
> >While at it let us also remove a confusing comment that is either not
> >about the context in which it resides (describing
> >qp_attr.cap.pref_send_wr and qp_attr.cap.max_recv_wr) or not applicable  
>                 ^
> I haven't found pref_send_wr in qp_attr.cap
> 

Again search and replace. Sorry!

[..]
> >+
> >+	Please be aware that all the buffers need to be allocated as a physically
> >+	continuous array in which each element is a single buffer and has the size
> >+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> >+	like before having this control.
> >+	this control.  
> 
> The final 'this control' looks unwanted.
 

You are right

[..]
> > 
> >@@ -741,50 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
> > int smc_wr_alloc_link_mem(struct smc_link *link)
> > {
> > 	/* allocate link related memory */
> >-	link->wr_tx_bufs = kcalloc(SMC_WR_BUF_CNT, SMC_WR_BUF_SIZE, GFP_KERNEL);
> >+	link->wr_tx_bufs = kcalloc(link->lgr->pref_send_wr,
> >+				   SMC_WR_BUF_SIZE, GFP_KERNEL);
> > 	if (!link->wr_tx_bufs)
> > 		goto no_mem;
> >-	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
> >+	link->wr_rx_bufs = kcalloc(link->lgr->pref_recv_wr, SMC_WR_BUF_SIZE,
> > 				   GFP_KERNEL);  


I will have to do some digging, let's assume for now that it is my
mistake. Unfortunately I won't be able to revisit this before next
Wednesday.

Thank you for your review!

Regards,
Halil


