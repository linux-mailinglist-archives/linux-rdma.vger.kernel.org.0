Return-Path: <linux-rdma+bounces-13681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5815EBA64AD
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 00:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176ED1883F00
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Sep 2025 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35523D7E3;
	Sat, 27 Sep 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WCRpzsJg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F81227599;
	Sat, 27 Sep 2025 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013734; cv=none; b=GR8M7rWZX3xdXPAZ7Dr5QIXgETOsSUFTpouu/30RIR6Q3mtH9dUmL1vL9JQObMQNU0Svfm8TGhkv+FVPYiWJaR5yQ3vqMYJd1vh374EjuWeB4dGkWAiM3fSuCMoeHiykOHPDLi4AA9o5/nSBLuiL86HktnlEhpBsyT9aF1ChEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013734; c=relaxed/simple;
	bh=J/lkEaSlOjgbIMEBcrcnqLn8F4KPz/eqNN7bz7Ax+Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXIMbmdrU5MfAgThgvqh+16WaaUogJEDAyGHvIjIr6V92KUgB6QQq4/ALFEfT3ticd0O+SCNcSpcnU+xCcENV8MiuLPRtE9FDEDOAs5HREDoPrZtJNJrNtz+wKh0uRsPO9uAa3wMj8IX7+xR1lsSBEMieApNRhMMHrTnZrTvccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WCRpzsJg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58RIn5Yj021061;
	Sat, 27 Sep 2025 22:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CGyNmg
	9lCRxrC35psWn0YaeYKYJvFaHxr0YSuHrRWPE=; b=WCRpzsJgvk4FmskRTpKedc
	u46iz0gqDqvhWK/obPldUMM/nhqgvaLJXsjpbuQxryERLMU6c0twg49jw3Ui0Xgs
	erQKXhpnvV8PwDexdLBhyvA2l6TljnL7qbcUTjBuUPPEyXcDUIIiZOA4LmiBK3xk
	L5M3dqssEmRrfn60ila3oOuoWS02zrcfXqNaXYDXSuyru/mIaWSXMueqfH+97V+j
	IoO1PG+pQAi0TilrynNH5vgCfVLtqX7rBLpN0WQlAOAOGDehTv9F7yt6JHdAmkIR
	tzVgF7d9Fm1BKhNmiZV+NhXCcTkjaS+TGJy8T84NDii8v+C+9r+yjBqpParvgYHg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh3nch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 22:55:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58RMtMlI004163;
	Sat, 27 Sep 2025 22:55:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh3ncf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 22:55:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58RLkDEv014407;
	Sat, 27 Sep 2025 22:55:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawmaspt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 22:55:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58RMtH0M50725312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Sep 2025 22:55:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D8A20043;
	Sat, 27 Sep 2025 22:55:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4D220040;
	Sat, 27 Sep 2025 22:55:16 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.130.219])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 27 Sep 2025 22:55:16 +0000 (GMT)
Date: Sun, 28 Sep 2025 00:55:15 +0200
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
Message-ID: <20250928005515.61a57542.pasic@linux.ibm.com>
In-Reply-To: <20250925132540.74091295.pasic@linux.ibm.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-2-pasic@linux.ibm.com>
	<7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
	<20250925132540.74091295.pasic@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d86b5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=d6B9MPh4GzydLbDzm_AA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfXyehZBiMfHR7w
 /n+rhFoG6VKNxi4OIteUySe+T9U5LSk+p9iOJQqjt/toVbbgtBieuiAQdYIG/Li18yuWZDArA1q
 xg1B/ph5qs50y2dELYwGUGWJyPGGN0HEgMrMwm218Ln1MVnR3myymCFlbeQne3I8cjoDeJeo9c+
 JdZBqj8Do4bFVaQ6uzpc1atWlXUaexmZSmtFbO8aKMisvRPOquVCAIU6Oj/AAi1uacWVzcr3Pun
 ipH/xQLpnNXSf81AkJhTPfzoShMQQpGsg/N7orVnpOPvggv9Aqeegz19x5rbt5GNLUiuDcOTcWD
 pU41s+LQ4EXJbdQhtaTRsd6HxsPwis6gJxb2KKNvXLDf2oTFMNcLI+Cu1AVdtLrHFyjX1ZGv0zP
 UoyfIZNWmn20Cpua2BUfNrMrc9k98w==
X-Proofpoint-GUID: ZvXP4YeF5JYu1VuKgBF2CVctlzrCxZDg
X-Proofpoint-ORIG-GUID: pWjiWAZRIuuBP2oSto0eEBbGqHdIJIfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010

On Thu, 25 Sep 2025 13:25:40 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> > [...]  
> > > @@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
> > >  	};
> > >  	int rc;
> > >  
> > > +	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
> > > +	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;    
> > 
> > Possibly:
> > 
> > 	cap = max(3 * lnk->lgr->max_send_wr, lnk->lgr->max_recv_wr);
> > 	qp_attr.cap.max_send_wr = cap;
> > 	qp_attr.cap.max_recv_wr = cap
> > 
> > to avoid assumption on `max_send_wr`, `max_recv_wr` relative values.  
> 
> Can you explain a little more. I'm happy to do the change, but I would
> prefer to understand why is keeping qp_attr.cap.max_send_wr ==
> qp_attr.cap.max_recv_wr better? But if you tell: "Just trust me!" I will.

Due to a little accident we ended up having a private conversation
on this, which I'm going to sum up quickly.

Paolo stated that he has no strong preference and that I should at
least add a comment, which I will do for v4. 

Unfortunately I don't quite understand why qp_attr.cap.max_send_wr is 3
times the number of send WR buffers we allocate. My understanding
is that qp_attr.cap.max_send_wr is about the number of send WQEs.
I assume that qp_attr.cap.max_send_wr == qp_attr.cap.max_recv_wr
is not something we would want to preserve.

Regards,
Halil 

