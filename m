Return-Path: <linux-rdma+bounces-13704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3DEBA7639
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FFE3A3CF9
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F4244698;
	Sun, 28 Sep 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NuS64/zC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8A149E17;
	Sun, 28 Sep 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759084336; cv=none; b=dLjIyxOayvQs0ED0rbNoLjRinnEfVKPEbMqYdFu6kY0Hjra4ejMLNH/bqyATJnV6wN9shKSn6J3dUEcGPOQxMJCnycPtovo7quvDmjHhjbyZZ5PY1iyVsQ/7i8wEZnYrYGTQ2a/FraXso92BTcCSoaGhd5AiqeuOX4526Wi45XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759084336; c=relaxed/simple;
	bh=3fXN/jGvJgMgNtDL2f1i10+UbkOMXScOnXk2zWvjpZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd/Br9QihFe+W+LBTxu+34TBHteMUMLGKvJ3tmHRWvYktl72edsqBoow7ssY/VoiHyx0fP5gsHoL+xrD66vAipnkiFSYA82qcCkBezfjBpGPLaDG8QycldWvoJyP4Vwcyd5n6cD70Wf9z7plN4JEIHt/cvfPGFAjJ5GeD2+yse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NuS64/zC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SCJnR8018653;
	Sun, 28 Sep 2025 18:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=poUkSA
	wxxn9OgsiB0V78chkL7btUOpcQgI6qcsINleE=; b=NuS64/zC9nrf4+6KCceOWr
	6zSFoOFcdArj9hAaOiBpFUDJ6/NFIQjNeneK84SGq5m6azpi8hrk5QH8eV6EhoAs
	1lOyJ9ncQ9eate5VdGww5vGtdJUJY/4rX6N1Y5Mp678R5nlDMHY+gN5stKUG1v0X
	Fojg/CADZj+ZmYco2gC6BL+xYEh33jCnoX9B5gWucNyQIHTZxBjLtZnYg6XR/azy
	ZeZjOTiAJbZkfwtCey9j9ZrG9OUDoNO+28E/v2pKRtAxaN4Sodsbbvnt5l9pjMxt
	E3WNsb3SFySnikFERCSPGLNePRpb1qoZNccKCQaGHnD/aZdhs4FqsbjWwaWeLDeQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqeren-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 18:32:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58SIW97G029923;
	Sun, 28 Sep 2025 18:32:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqerej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 18:32:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH1QoB020057;
	Sun, 28 Sep 2025 18:32:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8rtvqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 18:32:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58SIW55E55247338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 18:32:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 125DB20043;
	Sun, 28 Sep 2025 18:32:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2871620040;
	Sun, 28 Sep 2025 18:32:04 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.130.219])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 28 Sep 2025 18:32:04 +0000 (GMT)
Date: Sun, 28 Sep 2025 20:32:02 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <20250928203202.7d31a9bb.pasic@linux.ibm.com>
In-Reply-To: <aNkfPqTyQxYTusKw@linux.alibaba.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-2-pasic@linux.ibm.com>
	<7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
	<20250925132540.74091295.pasic@linux.ibm.com>
	<20250928005515.61a57542.pasic@linux.ibm.com>
	<aNiXQ_UfG9k-f9-n@linux.alibaba.com>
	<20250928103951.6464dfd3.pasic@linux.ibm.com>
	<aNkfPqTyQxYTusKw@linux.alibaba.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX53OcWNRbjcq4
 pv02O5YTQAryATb/G5CCwKXa7rOKDruQstUBLUbc9iFFAhfIRpCZv6p40Cw7JsSe81CIrChuIRt
 iyHMLK021J8MvaeNoZC1OqyLzgJ34QGuc8kYmDlLDFqICAbxHn5ksV5jvJ0OLohrliBuRd9iOo3
 /V4MHBWKwtsNOweOKpEflZNOBgzybf5xgiW+eNhJLOWX0rPiflwHlrh7C9kR3tBXkj3MSgeZSbE
 Pt4IWuDN1L3eC5gD7GuJKgM3nswzeuXkFTPnso+DoBjRbDeO6y6ja6YrGQ/armKqxWAfwUVT9Pw
 Mo5zul38Cmz0e9bVIIJNliCeMpd3LHtjxGwIm8W6OECRLQdRALIfhoIZIxHgmC1ceWyHtB0JpjS
 euDwTmuH3lL1dNdEYi2sZEKpi6DgJQ==
X-Proofpoint-GUID: ImC0uIDMvTV6wjFfCmyexAaU3oEHByVb
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68d97f2a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=fgEhGd6aAAAA:8 a=SRrdq9N9AAAA:8
 a=bxKWgVZqml0MJVlldkoA:9 a=CjuIK1q_8ugA:10 a=lTNmK5dgYt2SiR4ZQSdr:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QQJ3MbGicb2uuvcm3G71W-nh2WF5rxUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

On Sun, 28 Sep 2025 19:42:54 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> >> We have at most 2 RDMA Write for 1 RDMA send. So 3 times is necessary.
> >> That is explained in the original comments. Maybe it's better to keep it.
> >> 
> >> ```
> >> .cap = {
> >>                 /* include unsolicited rdma_writes as well,
> >>                  * there are max. 2 RDMA_WRITE per 1 WR_SEND
> >>                  */  
> >
> >But what are "the unsolicited" rdma_writes? I have heard of
> >unsolicited receive, where the data is received without
> >consuming a WR previously put on the RQ on the receiving end, but
> >the concept of unsolicited rdma_writes eludes me completely.  
> 
> unsolicited RDMA Writes means those RDMA Writes won't generate
> CQEs on the local side. You can refer to:
> https://www.rdmamojo.com/2014/05/27/solicited-event/
> 
> >
> >I guess what you are trying to say, and what I understand is
> >that we first put the payload into the RMB of the remote, which
> >may require up 2 RDMA_WRITE operations, probably because we may
> >cross the end (and start) of the array that hosts the circular
> >buffer, and then we send a CDC message to update the cursor.
> >
> >For the latter a  ib_post_send() is used in smc_wr_tx_send()
> >and AFAICT it consumes a WR from wr_tx_bufs. For the former
> >we consume a single wr_tx_rdmas which and each wr_tx_rdmas
> >has 2 WR allocated.  
> 
> Right.

Thank you Dust Li! Unfortunately I have already spinned a v4. Let
me add back that comment, as for people knowledgeable enough it does
not appear to be confusing at all. I can try to improve that comment
and maybe add a new one on the reason why we do need more WRs on the
receive end than on the send end, after this series has been merged. Or
if you want to do it yourself, I'm happy with it as well. In the end
it is you who me helped get a better understanding of this :)

Thank you again!

Regards,
Halil

