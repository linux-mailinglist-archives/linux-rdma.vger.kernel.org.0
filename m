Return-Path: <linux-rdma+bounces-13616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7FB993FE
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB513B80F0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA392DA775;
	Wed, 24 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="URWEmomo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEB15624D;
	Wed, 24 Sep 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707434; cv=none; b=P9pMK1wJY/3K/bobH+q9zj7qcXcvj8AJsNwAYmLIIVuV0qGHuyR8HIsQ5y4Y5JqJEcZ4NRj2WkZwXj8GJxVbwB4PVZsTiz4SplxV0QgKJ8oZp+7ah4P+YXE0Ar2VIqsbEYNsQWEZlU//g5FK7F+XzujZ/8qZL1oXf+YNsUlVSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707434; c=relaxed/simple;
	bh=M27GQZgq+H2Ogvn7201UWaor2G51R6HZ5rOLNQvNruk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw3tc3bdn4wbRUAiplbUTTBiVFdtubxbx4vXcobI3Q6w2PSVnUD2j/7Y8D2COZZDhn1qwdyP7UjyABt4GdHAcvcuXgO+EpAfPU/OPYYgGC5H1YTChihiHGFGgFTVlv3p0o7ERXrWIHleED9sqbAbZ6ad3IIo3RPBQ77ZuxGIcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=URWEmomo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NNVKNh010289;
	Wed, 24 Sep 2025 09:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lMXgsO
	bamqkAXxqsbpwU6QaASBM7CFQRyYuBRmQ0KLM=; b=URWEmomo76yRO5YAbteJGo
	EmXXF2EOAdMk3KL51B8z3Ljl5D8KD1fQlppB1SmwH8nvNwc2VjJoOafRMRvIvqfB
	nYzqx+RPtdNXoC3M+5It5n0CL3Xu7zQgMGJR8YYbaJWmxv1tLbS6WeGkxmPFgfmo
	tadg+2MO7DvIbdJBetkxXr3MMua0Xciz5zCObpouIR1o54Yn4SUJUEJVckz+99m7
	KsodJg1Q0Wiar9DpkhNyI/teVVKQdJ3k9UKHhC4YRro6sdUH/peV3fwmBk7LGg6F
	swjZ6iF3xngL70s0EeX6ROofjMXWkLX6c0oMIkvBA5Cf75VjXgvmfDkJ/REFNAug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky66pr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 09:50:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58O9aNvl024359;
	Wed, 24 Sep 2025 09:50:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky66pqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 09:50:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9EgK0019743;
	Wed, 24 Sep 2025 09:50:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83k7uht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 09:50:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58O9oDLd31850790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:50:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F7E120043;
	Wed, 24 Sep 2025 09:50:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F4EF20040;
	Wed, 24 Sep 2025 09:50:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.44.102])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 24 Sep 2025 09:50:12 +0000 (GMT)
Date: Wed, 24 Sep 2025 11:50:10 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "D.
 Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta
 Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v2 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <20250924115010.38d2f3cb.pasic@linux.ibm.com>
In-Reply-To: <06a87a92-6cce-4a63-99d0-463a1d035478@linux.alibaba.com>
References: <20250908220150.3329433-1-pasic@linux.ibm.com>
	<20250908220150.3329433-2-pasic@linux.ibm.com>
	<aL-YYoYRsFiajiPW@linux.alibaba.com>
	<20250909121850.2635894a.pasic@linux.ibm.com>
	<20250919165549.7bebfbc3.pasic@linux.ibm.com>
	<06a87a92-6cce-4a63-99d0-463a1d035478@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BcH40_KyCP9ayG1dBlqF9yqqOm_j9uEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX+8dat0XeZkWX
 SWPq5+2Gyvpg8HLdSsPp0klTW+gqpM1ulWcvJFct99xQe3Svh+0iaAQ+pS4nA+c0/IrfTbh4uY8
 pvMTg2j4BsislxtcFC77IYmBOPTz+KOIobNvr9KYI7upLTSof+YT6rTWgT2lkigyAAq0UCAZTr1
 D/7vIL1eT1iibJxGjd6nEx3gt6AoOrWUHnMta3CBr4ilI8fPdJJtpvsVOYaVdqgSqyexjBA74J1
 dKWKw2btDnCLRXs2uTzuWwQVVYNwqNJAx7kK76LkhrOO86Ix2XkoipIv9uy53MmdXdQs1q4gRjT
 0VYZ4VOFwDbj4+rqzke6hzGVzMOTnf0Dg3f7nJ7SvAYqq5rSEnZ9KvZbCGEX/roZH3n/38BUIei
 1yuepwZd
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d3bedb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=Fd28zW55FITmtQHuAhYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jEBrHji86dlxFlrZwn0xIePAVyfHtCK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On Wed, 24 Sep 2025 11:13:05 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> 在 2025/9/19 22:55, Halil Pasic 写道:
> > On Tue, 9 Sep 2025 12:18:50 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> > 
> > Can maybe Wen Gu and  Guangguan Wang chime in. From what I read
> > link->wr_rx_buflen can be either SMC_WR_BUF_SIZE that is 48 in which
> > case it does not matter, or SMC_WR_BUF_V2_SIZE that is 8192, if
> > !smc_link_shared_v2_rxbuf(lnk) i.e. max_recv_sge == 1. So we talk
> > about roughly a factor of 170 here. For a large pref_recv_wr the
> > back of logic is still there to save us but I really would not say that
> > this is how this is intended to work.
> >   
> 
> Hi Halil,
> 
> I think the root cause of the problem this patchset try to solve is a mismatch
> between SMC_WR_BUF_CNT and the max_conns per lgr(which value is 255). Furthermore,
> I believe that value 255 of the max_conns per lgr is not an optimal value, as too
> few connections lead to a waste of memory and too many connections lead to I/O queuing
> within a single QP(every WR post_send to a single QP will initiate and complete in sequence).
> 
> We actually identified this problem long ago. In Alibaba Cloud Linux distribution, we have
> changed SMC_WR_BUF_CNT to 64 and reduced max_conns per lgr to 32(for SMC-R V2.1). This
> configuration has worked well under various workflow for a long time.
> 
> SMC-R V2.1 already support negotiation of the max_conns per lgr. Simply change the value of
> the macro SMC_CONN_PER_LGR_PREFER can influence the negotiation result. But SMC-R V1.0 and SMC-R
> v2.0 do not support the negotiation of the max_conns per lgr.
> I think it is better to reduce SMC_CONN_PER_LGR_PREFER for SMC-R V2.1. But for SMC-R V1.0 and
> SMC-R V2.0, I do not have any good idea.
> 

I agree, the number of WR buffers and the max number of connections per
lgr can an should be tuned in concert.

> > Maybe not supporting V2 on devices with max_recv_sge is a better choice,
> > assuming that a maximal V2 LLC msg needs to fit each and every receive
> > WR buffer. Which seems to be the case based on 27ef6a9981fe ("net/smc:
> > support SMC-R V2 for rdma devices with max_recv_sge equals to 1").
> >  
> 
> For rdma dev whose max_recv_sge is 1, as metioned in the commit log in the related patch,
> it is better to support than SMC_CLC_DECL_INTERR fallback, as SMC_CLC_DECL_INTERR fallback
> is not a fast fallback, and may heavily influence the efficiency of the connecting process
> in both the server and client side.

I mean another possible mitigation of the problem can be the following,
if there is a device in the mix with max_recv_sge < 2 the don't propose/
accept SMCR-V2. 

Do you know how prevalent and relevant are max_recv_sge < 2 RDMA
devices, and how likely is it that somebody would like to use SMC-R with
such devices?

> 
>  
> > For me the best course of action seems to be to send a V3 using
> > link->wr_rx_buflen. I'm really not that knowledgeable about RDMA or
> > the SMC-R protocol, but I'm happy to be part of the discussion on this
> > matter.
> > 
> > Regards,
> > Halil  
>
> And a tiny suggestion for the risk you mentioned in commit log
> ("Addressing this by simply bumping SMC_WR_BUF_CNT to 256 was deemed
> risky, because the large-ish physically continuous allocation could fail
> and lead to TCP fall-backs."). Non-physically continuous allocation (vmalloc/vzalloc .etc.) is
> also supported for wr buffers. SMC-R snd_buf and rmb have already supported for non-physically
> continuous memory, when sysctl_smcr_buf_type is set to SMCR_VIRT_CONT_BUFS or SMCR_MIXED_BUFS.
> It can be an example of using non-physically continuous memory.
> 

I think we can put this on the list of possible enhancements. I would
perfer to not add this to the scope of this series. But I would be happy to
see this happen. Don't know know if somebody form Alibaba, or maybe
Mahanta or Sid would like to pick this up as an enhancement on top.

Thank you very much for for your comments!

Regards,
Halil 

