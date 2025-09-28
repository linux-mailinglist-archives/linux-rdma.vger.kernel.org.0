Return-Path: <linux-rdma+bounces-13693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D5BA6B94
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 10:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FAE17A720
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063E2BEC2D;
	Sun, 28 Sep 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dGNReM+r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6A225791;
	Sun, 28 Sep 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759048807; cv=none; b=aScr0aFCSyvB8o9ml5nVeiHR+ZsMRDpbB1jO3wT4zt9NdC4hUiAuf+Z9RmwBvBiDoiDP7jbljmmKB9qg6+rg6N7P23/74HQCUZmdC0vMMx/j4nU6BGXH5ZaWLmdVFRiSjXXsUI2UXMWjcf7S1VcD55GS809ob5/M4SXi1ZKllsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759048807; c=relaxed/simple;
	bh=UAiDtMls/7PB7c4FD/jtapLq39n9wPN/G9K9tg8xa6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ba/kW5ttVU1s5u88h8iaYpw+WqG8w646pSCOYwQmINxb2XNwVh4tkKBa/0muf1MdZFY4YvS3kzte75TKSYvZQCemG6CUaefvxQHchKn+VhxOVoDlwxfe3UX8RLVi3NGxJnVoRc2lRUN1sCGLAfxyJaDGar8hBn0eWn1wvJeAJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dGNReM+r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58RLKCJv018156;
	Sun, 28 Sep 2025 08:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=26dBy+
	6fvtP4nix+qumgkSsprwt5d+Cgeccq0M1JqCc=; b=dGNReM+r2Kz/zB7fb25my+
	Ab8p3MFptjmNW0KYL7RwH3PpQnWX3+i2ClnyQdWfs5W9EeFbsIj7TTuenp5sZa7A
	XLvQBvF6qvDxI9TGUQalbFCgbcRtrPiU1zmzeZykcEy4WbV3WhE2shyz7qom7+zm
	9Xk1IeFtkuA0w0RfdxhKU3wxbz0Ravmd6hqqbJ1XkNXnvn2TRgAMWamWfWlqtDgL
	9oKNjyiODvwdXOrce6prr4K5jVo0JHeJ+L9AClKifKMCfxga2to+/Y/VTJ5MnNhk
	u0022j52AmDusD/DGjKa3zLIXmd2IEO8/05HPnXUHujw/ThbK9L1XGNtZwcpDjVw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7cxtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 08:40:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58S8dxZE024613;
	Sun, 28 Sep 2025 08:39:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7cxtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 08:39:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58S3FPmR024198;
	Sun, 28 Sep 2025 08:39:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0rsdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 08:39:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58S8ds7O18022900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 08:39:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E4D20043;
	Sun, 28 Sep 2025 08:39:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6B520040;
	Sun, 28 Sep 2025 08:39:53 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.130.219])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 28 Sep 2025 08:39:53 +0000 (GMT)
Date: Sun, 28 Sep 2025 10:39:51 +0200
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
Message-ID: <20250928103951.6464dfd3.pasic@linux.ibm.com>
In-Reply-To: <aNiXQ_UfG9k-f9-n@linux.alibaba.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-2-pasic@linux.ibm.com>
	<7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
	<20250925132540.74091295.pasic@linux.ibm.com>
	<20250928005515.61a57542.pasic@linux.ibm.com>
	<aNiXQ_UfG9k-f9-n@linux.alibaba.com>
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
X-Proofpoint-ORIG-GUID: c6gA6HzoJG_m__DF3vzOC0Er79P5vPYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX0Iym0TzM4LUD
 7wRlax0L/QwIwSUsS5j6N6/ArlJa1Q9kFKUbdGOcc/g/g3mtH+hEB59Uiky3WvZgMLj1x9osgvc
 Afl9mG5VU4gb8Ps9Fc1F0EG8PsImEV+IvYSqhW9mUym1JK+XMDsZ0g5x4LQTS9r84bs2g6GIXzS
 axOeoVboDQ86kwcjFHPj+YvOpWGY6lTIjcgT33RgLImJ5jBdSjos8P555sXKP79zR8vCf+OYNHG
 gnYQ1ocWRp0wkdPnXHWXDB56pnOauS1xZtW8ecLMpkdklvDUV/ROYargbWz36ChRgf9clG9LBU2
 DtkHSaijjTCd8PcRNLIKI3vojNpNNAEw9T37W2QzyF8QmNzAyIQ4ffg+WFtevUOJQj7Nk/Up/XK
 sS8M3FGfllCwgWOZzOKyJZbxHvFTrw==
X-Proofpoint-GUID: P1hxPPalkpptVuof-Jso_qIsXcbYFFNG
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68d8f460 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=LpznLg-6pxwcTV0XsXIA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Sun, 28 Sep 2025 10:02:43 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> >Unfortunately I don't quite understand why qp_attr.cap.max_send_wr is 3
> >times the number of send WR buffers we allocate. My understanding
> >is that qp_attr.cap.max_send_wr is about the number of send WQEs.  
> 
> We have at most 2 RDMA Write for 1 RDMA send. So 3 times is necessary.
> That is explained in the original comments. Maybe it's better to keep it.
> 
> ```
> .cap = {
>                 /* include unsolicited rdma_writes as well,
>                  * there are max. 2 RDMA_WRITE per 1 WR_SEND
>                  */

But what are "the unsolicited" rdma_writes? I have heard of
unsolicited receive, where the data is received without
consuming a WR previously put on the RQ on the receiving end, but
the concept of unsolicited rdma_writes eludes me completely.

I guess what you are trying to say, and what I understand is
that we first put the payload into the RMB of the remote, which
may require up 2 RDMA_WRITE operations, probably because we may
cross the end (and start) of the array that hosts the circular
buffer, and then we send a CDC message to update the cursor.

For the latter a  ib_post_send() is used in smc_wr_tx_send()
and AFAICT it consumes a WR from wr_tx_bufs. For the former
we consume a single wr_tx_rdmas which and each wr_tx_rdmas
has 2 WR allocated.

And all those WRs need a WQE. So I guess now I do understand
SMC_WR_BUF_CNT, but I find the comment still confusing like
hell because of these unsolicited rdma_writes.

Thank you for the explanation! It was indeed helpful! Let
me try to come up with a better comment -- unless somebody
manages to explain "unsolicited rdma_writes" to me.

>         .max_send_wr = SMC_WR_BUF_CNT * 3,
>         .max_recv_wr = SMC_WR_BUF_CNT * 3,
>         .max_send_sge = SMC_IB_MAX_SEND_SGE,
>         .max_recv_sge = lnk->wr_rx_sge_cnt,
>         .max_inline_data = 0,
> },
> ```
> 
> >I assume that qp_attr.cap.max_send_wr == qp_attr.cap.max_recv_wr
> >is not something we would want to preserve.  
> 
> IIUC, RDMA Write won't consume any RX wqe on the receive side, so I think
> the .max_recv_wr can be SMC_WR_BUF_CNT if we don't use RDMA_WRITE_IMM.

Maybe we don't want to assume somebody else (another implementation)
would not use immediate data. I'm not sure. But I don't quite understand
the why the relationship between the send and the receive side either.

Regards,
Halil

