Return-Path: <linux-rdma+bounces-13517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD81B8A1CD
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E240B6013A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CA313296;
	Fri, 19 Sep 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mJxYt1bO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028A1F3FEC;
	Fri, 19 Sep 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293764; cv=none; b=ne6q2m1qKVxHEnSJeSnPA4Grv9dxbJNLLP6fihSjdVQ2bNujQnk7D99OpZrxBXbjQnBVD5Tpf4Ryer9Zyo/aJ8tJVfz9fh2ipU2+gKPukOyHuQpfmALJ5YOFrYmkDjjUODocz0qiIwHceaOeYyy259xncYNjlcEHV0oCw082+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293764; c=relaxed/simple;
	bh=8uIFhtK2IJ/B47NJpWMNwnQqZrSj51H4Icha31JBO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3I84clbQc3RwnzR7jJhmFticfAOAJIca5ZcBrKQILDruMS+/1LkwfmMd5M6V7oY+WgPcQl3SbAYH+fKj/Em9OifAieYlup4VfNI6Awp+d6ZdFAoo3oZW7UIXnSA0aJwOxtdAJWEdTIM8apDnBs7mPzd5F3qrPUkf+02KqgogEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mJxYt1bO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J54pgL027133;
	Fri, 19 Sep 2025 14:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aU/IL1
	yNGjUFzjuYRWTqCY8LpnItOiXO9jDsErM/ZSw=; b=mJxYt1bO9ZlAJGOriKukNR
	6DRTT67kcYHIqst30BRLtnh1SMyV+iw+RyyHy1d/pgGo776owZC0aTcq259/Y4PV
	EtCjbjz9ddjqDVfW/ji/d6eUueeEGNv+e7TJzWKs7S/eQv9i+6Lp6d6yAHZ8YI/r
	IrN8HV0TfIgPS+/iHqzcCnm8ijIxGoSQ4s2cQggDj9bByZkqTTkP8FLnWYuEp/aR
	2PBDN2EU2NRR9Aa+T5QlRhVUAWuRZ+ds4Gp4GqkzDg8FxZj9d904SJ15dd3SQMbc
	Rew2+rgPJd4hk24k6NYLq0ktzrv470p+fO5USmfSUuTgRP/HRH+I6WXsbPWl8HkQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4phff2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 14:55:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JEkpni015466;
	Fri, 19 Sep 2025 14:55:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4phfeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 14:55:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JE6KCl027308;
	Fri, 19 Sep 2025 14:55:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menm9bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 14:55:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JEtqm030998972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 14:55:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D1202004D;
	Fri, 19 Sep 2025 14:55:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4663920040;
	Fri, 19 Sep 2025 14:55:51 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.70.35])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Sep 2025 14:55:51 +0000 (GMT)
Date: Fri, 19 Sep 2025 16:55:49 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>,
        Guangguan Wang
 <guangguan.wang@linux.alibaba.com>
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
Message-ID: <20250919165549.7bebfbc3.pasic@linux.ibm.com>
In-Reply-To: <20250909121850.2635894a.pasic@linux.ibm.com>
References: <20250908220150.3329433-1-pasic@linux.ibm.com>
	<20250908220150.3329433-2-pasic@linux.ibm.com>
	<aL-YYoYRsFiajiPW@linux.alibaba.com>
	<20250909121850.2635894a.pasic@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX7O7GttvqFagT
 Cdun3QY+uzZBQMr3Un9NEUfVHdWnZ89ljb2eIA+Z180TJxat8rpwzQRJkEPXhPv1dwLpcdnbfrA
 idK0almy44vfEFXQVDYad9se7l4qKhdVK2eshyDNuctlc4iMua3jHv+SK7LkRzt5RTA/X9YJj+G
 1nO1Mi8BVzIkNpOY8xPoPnLCCCb8kdkP3eVICBc7rfp/utcePt7ZZrEBCk8Sa5R2pe8JDMm4fng
 +KyvkxlYLiuVZDDHSliv+cfO3pOxnidDbxJq2Jb2x68NXI09dkJ1rEsGCDh6SUzv6AOlYbJRI6G
 t2PvjRxgQEVFepk4Emyj5t0Wt9GvkfazRUxtz6FNIv3+IkVBzVDRf95DuqTXfWHf28BlkY55+jh
 WB5FYOr/
X-Proofpoint-ORIG-GUID: LvQE9PCL4m0Y2ALvOcZbGvygtvYCo3uo
X-Proofpoint-GUID: 1ej1yVyvFNjiPyIa0glrzXpwWEFApiLH
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cd6efe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=3-ZsZ1Rs_CeAYfPLFTEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 9 Sep 2025 12:18:50 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> > >-	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
> > >+	link->wr_rx_bufs = kcalloc(link->lgr->pref_recv_wr, SMC_WR_BUF_SIZE,
> > > 				   GFP_KERNEL);    
> 
> 
> I will have to do some digging, let's assume for now that it is my
> mistake. Unfortunately I won't be able to revisit this before next
> Wednesday.

Can maybe Wen Gu and  Guangguan Wang chime in. From what I read
link->wr_rx_buflen can be either SMC_WR_BUF_SIZE that is 48 in which
case it does not matter, or SMC_WR_BUF_V2_SIZE that is 8192, if
!smc_link_shared_v2_rxbuf(lnk) i.e. max_recv_sge == 1. So we talk
about roughly a factor of 170 here. For a large pref_recv_wr the
back of logic is still there to save us but I really would not say that
this is how this is intended to work.

Maybe not supporting V2 on devices with max_recv_sge is a better choice,
assuming that a maximal V2 LLC msg needs to fit each and every receive
WR buffer. Which seems to be the case based on 27ef6a9981fe ("net/smc:
support SMC-R V2 for rdma devices with max_recv_sge equals to 1").

For me the best course of action seems to be to send a V3 using
link->wr_rx_buflen. I'm really not that knowledgeable about RDMA or
the SMC-R protocol, but I'm happy to be part of the discussion on this
matter.

Regards,
Halil

