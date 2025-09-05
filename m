Return-Path: <linux-rdma+bounces-13111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94913B45724
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B64E5482
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67734AAE0;
	Fri,  5 Sep 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SLWS7XJg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903B267AF6;
	Fri,  5 Sep 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073710; cv=none; b=ila6JDYW610R2AIHTGIBrOcDnnWuDD2y9KjQ/kfhe0/PVgKIVrZ7Pv0yN8W/zB0xS/DgWUQ7TGqTyrjAQMshSqX0oVXNskuOq+R5dPYpF/JlmIP/n7PclGfj/4Mw48c8WcOgm9N1o8QsBvLpsvEX5jrctC0wzIsUSOQZqxbQutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073710; c=relaxed/simple;
	bh=x7CfNWzhysW2tmr+31/z5JWos3W0TLidFrU9+BAQ4AM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vum8zTD0canJVJ7aMhb83gY7wV6CeD1eofRiY5f5SG69l5m09IakK5cQNKnmNqUhSGvz7nUhxELxGxpnBtLPb2xeQ5C88xWeSGwHCu2YQ8vvP4i96ovgQdgpuq2mQpxHc09xQjWnVOTDWZDto5YI7RFVEwHJ959lQXXX3lzYwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SLWS7XJg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856fqR0027660;
	Fri, 5 Sep 2025 12:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3Q0Kk1
	twUqbc+CYwqm2wcSG5DNW9I13tTKUpqyij7k4=; b=SLWS7XJg0oRrpm+ElknuyX
	E9EqWl8ihXKfE3XqCqv0BQkfUNG2QUcGceSX4z5h58CPwX2vnXM/OqgEITyfZ357
	MTiB9ZmgkM5NmjJuhcfN0rjHXpJvvn4DZ2nRcEcqjHP2XndzCbEa8FVGWUKJ47k6
	huUX7gBHtye53xzgKysRgbkgeYqTUUhQjHD092EhyBZBJQRD+pNgmLg7S9cfytiE
	3/u8zeFpQdzdKA/N26kq26yzm89tA3SdW/QexooiaElA53jSYYO9h397FEzUu/yd
	o+LdO5fRXIYtGcUwqA6SsXI9yyYlv2gZMElCZz0y4JeWy+R4z2kou5VkxgboZdPg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg7dqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 12:01:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585BspIU019578;
	Fri, 5 Sep 2025 12:01:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg7dqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 12:01:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5858RNBW017205;
	Fri, 5 Sep 2025 12:01:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc111fev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 12:01:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585C1cwF42795410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 12:01:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D11EF2004E;
	Fri,  5 Sep 2025 12:01:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B432720040;
	Fri,  5 Sep 2025 12:01:37 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.48.22])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  5 Sep 2025 12:01:37 +0000 (GMT)
Date: Fri, 5 Sep 2025 14:01:35 +0200
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
Subject: Re: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
Message-ID: <20250905140135.2487a99f.pasic@linux.ibm.com>
In-Reply-To: <20250905110059.450da664.pasic@linux.ibm.com>
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
	<20250904211254.1057445-2-pasic@linux.ibm.com>
	<aLpc4H_rHkHRu0nQ@linux.alibaba.com>
	<20250905110059.450da664.pasic@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68bad128 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=vYtxJBzLSLu-a_qLxUIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fJAOnqgGNIUegCEl7lDr_wUr1MOijxB7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX55DlTtph7uTr
 xm5FeUgrbjfrtm/GNqkXL4EHPCDwimZglnFhRKAvt3z3tfF56jFWMkC7s60V0oyTWT6wYJbcmez
 sEIgOu9d0FIuH+kksAxGp8E4kfQXty0iD4UrXiVN0jMfmiqhghq2RNxCIm8/N3otYsrTa3cQbUH
 RQRUVXZpjioAhcf+sCbP9dEMwE7SVnW8tIvMKMz4BwHkaZu4ODAtB+DZInsU+cval+/GHZEJVeC
 PmH8tUN4bARehCBVo31ZLg/DKnXJxClRQsk1e9/EnjnyF1m6iHf4Wl3rPhUOBRFP5RkHe2tfMyv
 i4Rqyx6vc4qAmNug+iRTvO9Qr6vqZOVf/WYhNvXzgDpijpmADOKt90vFiyAk8iJi2GvAEl4gb1O
 mA/yNehm
X-Proofpoint-GUID: vq0ghxuKxLZ7XoLbz2YobQiJd7nP3Ynw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Fri, 5 Sep 2025 11:00:59 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> > 1. What if the two sides have different max_send_wr/max_recv_wr configurations?
> > IIUC, For example, if the client sets max_send_wr to 64, but the server sets
> > max_recv_wr to 16, the client might overflow the server's QP receive
> > queue, potentially causing an RNR (Receiver Not Ready) error.  
> 
> I don't think the 16 is spec-ed anywhere and if the client and the server
> need to agree on the same value it should either be speced, or a
> protocol mechanism for negotiating it needs to exist. So what is your
> take on this as an SMC maintainer?
> 
> I think, we have tested heterogeneous setups and didn't see any grave
> issues. But let me please do a follow up on this. Maybe the other
> maintainers can chime in as well.

Did some research and some thinking. Are you concerned about a
performance regression for e.g. 64 -> 16 compared to 16 -> 16? According
to my current understanding the RNR must not lead to a catastrophic
failure, but the RDMA/IB stack is supposed to handle that.

I would like to also point out that bumping SMC_WR_BUF_CNT basically has
the same problem, although admittedly to a smaller extent because it is
only between "old" and "new".

Assuming that my understanding is correct, I believe that the problem of
the potential RNR is inherent to the objective of the series, and
probably one that can be lived with. Given this entire EID business, I
think the SMC-R setup is likely to happen in a coordinated fashion for
all potential peers, and I hope whoever tweaks those values has a
sufficent understanding or empiric evidence to justify the tweaks.

Assuming my understanding is not utterly wrong, I would very much like
to know what would you want me to do with this?

Thank you in advance!

Regards,
Hali

