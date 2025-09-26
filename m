Return-Path: <linux-rdma+bounces-13670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E5DBA34DF
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499921703F8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A62DC331;
	Fri, 26 Sep 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aGS8g3jp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4929D289;
	Fri, 26 Sep 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881584; cv=none; b=A5LM9M7O50hIXtbbJWkC5Xj3pgQDAJ9It6oR6M1o+jEVwUkGtkdQFmLk3qEBsN2sej56nHFrgf3Cukuiq3aZMa5nUZMCwMY3CADSebW48YB4HR/tUuNNLCqUzd092ig1860WXNuKs0IGnvZhZA5bwfz4BcITCj2oxgTjv7pNWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881584; c=relaxed/simple;
	bh=jxwkLcSlFmLlhuSO9JAqyrMk8tO6ktk/gXc+hdvU51Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1BHJHh1ZG+NVrJEFLqMZSpaaz2MtKt8Ig9DzwuTo78c2pAOQbpImcjJ4Gmtigu1NNNZ7tkcU+kPbwzaLDBjTjgvnNtSNHJdDr5lKYaNQc0YlLxImhD4wZ3Y8ClGOfk6nlLVjbFjTnAd391sWQRArjKpG5pDQRwyIPOwlp9vvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aGS8g3jp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q5qIwk029715;
	Fri, 26 Sep 2025 10:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=20t6D+
	fKshQ1xZ374I0WRhkvucIJKVOb9UKEMWdZ/5w=; b=aGS8g3jpKTORvjbZ87voR5
	tl+j9rvZZQGXJVdbqOVym/WWD/BYc+6rJq9dXtCJBxj5kDs6JpmxI2A2z6T+0sbz
	gYto8PXuAJSqa5Xbih2XND4uGvbHPuJ6D+pAy9Qq0BYW8BaPVoOsyKZ909tgMOMR
	KmgwUiQFTlDE8epBDr0HwZ17TT26qBP021kyIv7Gp0UDz/twERDL8L5fPKFSwMgC
	jQmeFalVHYaF2BtIvqUFNdqflX6x3kMQqjDSRFjxtbD+lJAIRToDp+VIIq9UEn7c
	KwDlhR+Z5mdDI3v3AlY3JZghLsMI2lw53uC1bEvh1Gj9UxWk9//NY0V+HZP8EbyQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb3uter-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 10:12:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58Q9n5fZ025930;
	Fri, 26 Sep 2025 10:12:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb3uten-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 10:12:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QACbg1006458;
	Fri, 26 Sep 2025 10:12:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawpkgj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 10:12:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QACqle52691358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 10:12:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C70A20043;
	Fri, 26 Sep 2025 10:12:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6944720040;
	Fri, 26 Sep 2025 10:12:51 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.129.170])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 26 Sep 2025 10:12:51 +0000 (GMT)
Date: Fri, 26 Sep 2025 12:12:49 +0200
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
Message-ID: <20250926121249.687b519d.pasic@linux.ibm.com>
In-Reply-To: <1aa764d0-0613-499e-bc44-52e70602b661@linux.alibaba.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-2-pasic@linux.ibm.com>
	<1aa764d0-0613-499e-bc44-52e70602b661@linux.alibaba.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX4LsnfnEISYHh
 YdnXdz1EUb+HFq89QlFF5kq0OZsIj8n842o2KZ96MiJ4HoJtGZ13BnsbouTe8doGQ4oAl6yhk7f
 I5zYL/o39QyywMwpwfmpoz1zKJBuq23nqMqid391Bz3FFOa4dfIH2/85ws4ZQb7IaFHfl893qHh
 oPy8edTI9hRY0iLLgpvMsogibKIw4dlAL1Eo3gCoro8DiwuM+eY7lASGM7mBWQOBbG4e7IN0z31
 RWcsbJn4ct4PaNr8x1nPOENSI81yD4klScLj6RKSIpMTaoje8LYbTGSumN9iRK7PQXxjj3mC24z
 F1p7cnXdtbgiVoN/sgNf0wmhOFlad6aQ3Hhy9pkRutlorVsZ0TALzXApdBc5JGdxSN0jJuEtYsu
 6Q0hliHXlAYnSEPnd7l2RAPJJSdaxA==
X-Proofpoint-GUID: 6dQaDM1mPAJ4Jzk0yl6fQVY57NpGgFXK
X-Authority-Analysis: v=2.4 cv=T/qBjvKQ c=1 sm=1 tr=0 ts=68d6672a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=hP6Lh0ber_LRzFWUQkQA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UWvketDTN0Ot3v1bfgOxKp68MJngqz5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Fri, 26 Sep 2025 10:44:00 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> > +
> > +smcr_max_send_wr - INTEGER
> > +	So called work request buffers are SMCR link (and RDMA queue pair) level
> > +	resources necessary for performing RDMA operations. Since up to 255
> > +	connections can share a link group and thus also a link and the number
> > +	of the work request buffers is decided when the link is allocated,
> > +	depending on the workload it can a bottleneck in a sense that threads
> > +	have to wait for work request buffers to become available. Before the
> > +	introduction of this control the maximal number of work request buffers
> > +	available on the send path used to be hard coded to 16. With this control
> > +	it becomes configurable. The acceptable range is between 2 and 2048.
> > +
> > +	Please be aware that all the buffers need to be allocated as a physically
> > +	continuous array in which each element is a single buffer and has the size
> > +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> > +	like before having this control.
> > +
> > +	Default: 16
> > +
> > +smcr_max_recv_wr - INTEGER
> > +	So called work request buffers are SMCR link (and RDMA queue pair) level
> > +	resources necessary for performing RDMA operations. Since up to 255
> > +	connections can share a link group and thus also a link and the number
> > +	of the work request buffers is decided when the link is allocated,
> > +	depending on the workload it can a bottleneck in a sense that threads
> > +	have to wait for work request buffers to become available. Before the
> > +	introduction of this control the maximal number of work request buffers
> > +	available on the receive path used to be hard coded to 16. With this control
> > +	it becomes configurable. The acceptable range is between 2 and 2048.
> > +
> > +	Please be aware that all the buffers need to be allocated as a physically
> > +	continuous array in which each element is a single buffer and has the size
> > +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> > +	like before having this control.
> > +
> > +	Default: 48  
> 
> Notice that the ratio of smcr_max_recv_wr to smcr_max_send_wr is set to 3:1, with the
> intention of ensuring that the peer QP's smcr_max_recv_wr is three times the local QP's
> smcr_max_send_wr and the local QP's smcr_max_recv_wr is three times the peer QP's
> smcr_max_send_wr, rather than making the local QP's smcr_max_recv_wr three times its own
> smcr_max_send_wr. The purpose of this design is to guarantee sufficient receive WRs on
> the side to receive incoming data when peer QP doing RDMA sends. Otherwise, RNR (Receiver
> Not Ready) may occur, leading to poor performance(RNR will drop the packet and retransmit
> happens in the transport layer of the RDMA).

Thank you Guangguan! I think we already had that discussion. 
> 
> Let us guess a scenario that have multiple hosts, and the multiple hosts have different
> smcr_max_send_wr and smcr_max_recv_wr configurations, mesh connections between these hosts.
> It is difficult to ensure that the smcr_max_recv_wr/smcr_max_send_wr is 3:1 on the connected
> QPs between these hosts, and it may even be hard to guarantee the smcr_max_recv_wr > smcr_max_send_wr
> on the connected QPs between these hosts.


It is not difficult IMHO. You just leave the knobs alone and you have
3:1 per default. If tuning is attempted that needs to be done carefully.
At least with SMC-R V2 there is this whole EID business, as well so it
is reasonable to assume that the environment can be tuned in a coherent
fashion. E.g. whoever is calling the EID could call use smcr_max_recv_wr:=32 and smcr_max_send_wr:=

> 
> Therefore, I believe that if these values are made configurable, additional mechanisms must be
> in place to prevent RNR from occurring. Otherwise we need to carefully configure smcr_max_recv_wr
> and smcr_max_send_wr, or ensure that all hosts capable of establishing SMC-R connections are configured
> smcr_max_recv_wr and smcr_max_send_wr with the same values.

Thank you for 

