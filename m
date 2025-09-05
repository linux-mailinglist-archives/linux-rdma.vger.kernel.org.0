Return-Path: <linux-rdma+bounces-13108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5DCB45252
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94355A01992
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D532459E7;
	Fri,  5 Sep 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNcMZDOE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273701805A;
	Fri,  5 Sep 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062884; cv=none; b=o1iQkLWeSfBzlseLp1NdVNAVyGSMaP6cgU5UapzzRkEy0Ws+d80akULnAe2RDrv44xCZJIg8JQDV7v4ZRM0825vu6rSyvjv6CZAsEhnmpsvdKlDmwU+XulmaKMrywZNDN6UFeUq8tYavdX4LQRGxOEryTacdESkgrZK0sbVYF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062884; c=relaxed/simple;
	bh=bkiflH5uGvr88Tr1HTZ3lrEk1NM47FmFgaXR8yGH2Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJyPxCfzB68F2bUwWL2YGZEoiZlmCTFnzlsRUfU4lu76tDUzS3eZ/gEK5TU8i40S2RD4AebgkrfHnad4gA47hwnYYQwHZMXWa8HFdOTMgJmhuSyIou+10jIUdXEJkQROkmRrv2grGYBSbOWJ+j11raXDyCt0HbyJSE3MevgvISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PNcMZDOE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857YfNM006957;
	Fri, 5 Sep 2025 09:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a9W4u5
	adXbL/N80SZd5jpWT4wlApuy0pwx3AfVS8xFE=; b=PNcMZDOEiOR7QxYl5+L1Zb
	szavYhAgAOMKzGiwEWPQFhCWSAS0XMJC2XOshrStzEJ8XMrJ+Vc72mmiO+4UjXLI
	QMUNw4VJXeboacjSJqLEiOGXhwJWIASIjmQK0+iOZuJmtzhwW2fqqbxR/OrRE5TN
	Maw9n+2Wt/RhZnpxxZPAqvJjw+l+zbovAdzzdUZu2mUtby+abx3caQHn8sTii2b7
	zt0R7rBYMmyy5tBjcf6YCP5kndwBXofaxJZ+1LO/pFzyASnCq2F/hs3RQHYfElZG
	vVnYP23EXqBhLXiV3dDFD47iXWLw5KQ54YBsjYMXgG+LSlb0uMsV/4ngFCadbFrg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurfcdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 09:01:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58591GMK001556;
	Fri, 5 Sep 2025 09:01:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurfcd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 09:01:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5855R3oL019313;
	Fri, 5 Sep 2025 09:01:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n8khs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 09:01:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58591AfB53674346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 09:01:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA0362004E;
	Fri,  5 Sep 2025 09:01:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F7D20049;
	Fri,  5 Sep 2025 09:01:09 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.153.36])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  5 Sep 2025 09:01:09 +0000 (GMT)
Date: Fri, 5 Sep 2025 11:00:59 +0200
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
Message-ID: <20250905110059.450da664.pasic@linux.ibm.com>
In-Reply-To: <aLpc4H_rHkHRu0nQ@linux.alibaba.com>
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
	<20250904211254.1057445-2-pasic@linux.ibm.com>
	<aLpc4H_rHkHRu0nQ@linux.alibaba.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX5uNUSYQWM4C9
 Atr8jnKEzq0tOjKx3r7HLqXieGGBwluvY5HFOxzviZh/GlsKYN6Goz+lnfSawPCLsH9BUkj7/wF
 tPnWCuV8sJRaBWJ49YZU9S/Xo5dKoeafqKy/47NfFmaOat1FqZcwzzApKFt0Uf9Vq2TCVu0kln7
 4p7cXPmcgMH4MSheZKJwF/3TOqSR1pJfyo+WlbAo37yRaR+K0/63+FyiVUqxCdpS6Ot8hgh63X4
 Gk6fayE2cM6SnCcRnPH3k/fO0iJ+hhLWErdYl287lp0/BjHPfMZNxc8c2Venc8ojKRTLG4lfXLX
 TX19/6JYzXwkyU2UNEU1irU9OgoZLtedYDGl6Z0N1OODZHyP6hueP8dszeGFBcWcfWq8qiFaQyv
 4d5AOpLy
X-Proofpoint-GUID: h0rergmXxicsb0JC_9-XPiXjDEVhHVy1
X-Proofpoint-ORIG-GUID: NBvzSwQDWi8yDcf8ETLK2SdLQlnBwj1G
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68baa6dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=6BR_q7ufmxdy0nC1zUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

On Fri, 5 Sep 2025 11:45:36 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> On 2025-09-04 23:12:52, Halil Pasic wrote:
> >Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
> >SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
> >get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.  
> 
> Hi Halil,
> 
> I think making the WR buffer count configurable helps make SMC more flexible.

Hi Dust Li,

Thank you for having a look. 

> 
> However, there are two additional issues we need to consider:
> 
> 1. What if the two sides have different max_send_wr/max_recv_wr configurations?
> IIUC, For example, if the client sets max_send_wr to 64, but the server sets
> max_recv_wr to 16, the client might overflow the server's QP receive
> queue, potentially causing an RNR (Receiver Not Ready) error.

I don't think the 16 is spec-ed anywhere and if the client and the server
need to agree on the same value it should either be speced, or a
protocol mechanism for negotiating it needs to exist. So what is your
take on this as an SMC maintainer?

I think, we have tested heterogeneous setups and didn't see any grave
issues. But let me please do a follow up on this. Maybe the other
maintainers can chime in as well.

> 
> 2. Since WR buffers are configurable, it’d be helpful to add some
> monitoring methods so we can keep track of how many WR buffers each QP
> is currently using. This should be useful now that you introduced a fallback
> retry mechanism, which can cause the number of WR buffers to change
> dynamically.
> 

I agree, but I think that can be done in a different scope. I don't think
this needs to be a part of the MVP. Or do you think that it needs to
be part of the series?
> 
> Some other minor issues in the patch itself, see below
> 
> >
> >While at it let us also remove a confusing comment that is either not
> >about the context in which it resides (describing
> >qp_attr.cap.max_send_wr and qp_attr.cap.max_recv_wr) or not applicable
> >any more when these values become configurable .
> >
> >Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> >---
> > Documentation/networking/smc-sysctl.rst | 37 +++++++++++++++++++++++++
> > net/smc/smc.h                           |  2 ++
> > net/smc/smc_core.h                      |  4 +++
> > net/smc/smc_ib.c                        |  7 ++---
> > net/smc/smc_llc.c                       |  2 ++
> > net/smc/smc_sysctl.c                    | 22 +++++++++++++++
> > net/smc/smc_wr.c                        | 32 +++++++++++----------
> > net/smc/smc_wr.h                        |  2 --
> > 8 files changed, 86 insertions(+), 22 deletions(-)
> >
> >diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> >index a874d007f2db..c687092329e3 100644
> >--- a/Documentation/networking/smc-sysctl.rst
> >+++ b/Documentation/networking/smc-sysctl.rst
> >@@ -71,3 +71,40 @@ smcr_max_conns_per_lgr - INTEGER
> > 	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> > 
> > 	Default: 255
> >+
> >+smcr_max_send_wr - INTEGER  
> 
> Why call it max ? But not something like smcr_send_wr_cnt ?

Because of the back-off mechanism. You are not guaranteed to get
this many but you are guaranteed to not get more.
> > static struct ctl_table smc_table[] = {
> > 	{
> >@@ -99,6 +103,24 @@ static struct ctl_table smc_table[] = {
> > 		.extra1		= SYSCTL_ZERO,
> > 		.extra2		= SYSCTL_ONE,
> > 	},
> >+	{
> >+		.procname       = "smcr_max_send_wr",
> >+		.data		= &smc_ib_sysctl_max_send_wr,
> >+		.maxlen         = sizeof(int),
> >+		.mode           = 0644,
> >+		.proc_handler   = proc_dointvec_minmax,
> >+		.extra1		= &smc_ib_sysctl_max_wr_min,
> >+		.extra2		= &smc_ib_sysctl_max_wr_max,
> >+	},
> >+	{
> >+		.procname       = "smcr_max_recv_wr",
> >+		.data		= &smc_ib_sysctl_max_recv_wr,
> >+		.maxlen         = sizeof(int),
> >+		.mode           = 0644,
> >+		.proc_handler   = proc_dointvec_minmax,  
> 
> It's better to use tab instead of space before those '=' here.
> 

I can definitely fix that and do a respin if you like. But I think
we need to sort out the other problems first.

Regards,
Halil


