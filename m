Return-Path: <linux-rdma+bounces-13653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEBBA032C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84523BEA6B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573831A07F;
	Thu, 25 Sep 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JOALaPPf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE31A06C;
	Thu, 25 Sep 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812739; cv=none; b=jqw9c2VI4or0KGZCujgIrahhtvfLpTM2oInifIcvbb7D1KxA9DTDnXSAamFU2A/eDDn2BvcxpYOP2kUqrEqYDh++7WdGMWJFSfHctRllGnaBDvnAv0GZXBrl4UoiIQZz47dewvrl2jvjm3XQ6t22n6tgB3EUPVTR2+mCe/7ma38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812739; c=relaxed/simple;
	bh=JHCPquvZB7G0O7g5UTmpSZA2j5My+jkbbFdEeHPVnqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2g+W8oq9dSC1k5O6OPazVk6tNL3kFUhHudK5xwAjj2G0voX8EBnnh45n1b96eoStWicvGTpxWxt0TuLurKybXt6p7YwjTGMzi7yiFVjJCj1NTxJCFFCig+77lng+mpiakSVzuS92WOb5UJqoaHAbyPO4fVmK778cqQqeQ5+/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JOALaPPf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCDuxx003612;
	Thu, 25 Sep 2025 15:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iO7kiS
	/RDntZtZVimHq7uSbHYNpxB8Bx4nnYZchDz0k=; b=JOALaPPfkrX6sU0OjclHoZ
	nbleYF8fEciVdCU1h+xII/D5Ex4CyOKuOE/BPy/r5pMGSRrQc95UZ/y7d464HIG0
	KE2dsYnqrimtrt4CiptZZzQahsWdkc4bBKjdJK2362lvxgl6nt2q9PvkWeV2iZ58
	/DJmH9lp19flze4R216N/sqWw5nK49PQwPkeL+3FUFWvAxxgl2PSEG8SpOihRtv9
	xX+5GCS2IEunu8Rt5bKmmsA2e76mf9+MszM94v0ObxvJNk5SqbfwEKMEJ3g/SVHK
	jf0wS76uJNju3z4SzDZESfgtN9n8G+buN68No1iwaA9efwEY3R8hmT/HoxE79oow
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6eje9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:05:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PEbqVL010021;
	Thu, 25 Sep 2025 15:05:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6eje2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:05:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PE6eJu030340;
	Thu, 25 Sep 2025 15:05:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1e90k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:05:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PF5RNZ49414446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 15:05:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 005602004D;
	Thu, 25 Sep 2025 15:05:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2C0820063;
	Thu, 25 Sep 2025 15:05:25 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.151.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 25 Sep 2025 15:05:25 +0000 (GMT)
Date: Thu, 25 Sep 2025 17:05:24 +0200
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
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <20250925170524.7adc1aa3.pasic@linux.ibm.com>
In-Reply-To: <cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-3-pasic@linux.ibm.com>
	<cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
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
X-Proofpoint-ORIG-GUID: nBZevxKP4kxkAl4FsC2gxe5A7UScRFgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX8UZmBSfyYmpY
 JMmNTOj7URk6vJowSlWekipNbFO86vLcmCSe/dtKSBZMEg0LEQ38HQbvSy5/tQ7ASo7H5MscF65
 Qtia0B0HrD20+FQ8Ena2tNfLgKaE+hAPH4Mzu9Fl38hcR+H3S6xzXnk5ABxk8vH8yg6OjrZ+QVG
 PUeFPa2jrCQ+WXXN7Oc+Wt+aOXHgyOP5z/3+a6fFXnOfRSe2lW7wbwXJncPs/4k1XpIk/uz4k0w
 6tydGrgtgRNBmpOuGwZVmIvqD+RiunSGu+LXU0YIyvSN/N2vNBTdztd2i/0Ge3T3G2Z7vkQ7Plw
 j85gPbnuaHxRgnqF/1C8AqJWMWTVSKDKdyalcn8cY8Ye8oyKxwirnDEXDNkBBctcIIMm9RfZw+1
 2VtD1w2B
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d55a3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=gPG2f1ptgi-rRd_ibX0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: IVesFF_vMbMokXRhspM-AJDwi0Z6rpRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On Thu, 25 Sep 2025 11:40:40 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> > +	do {
> > +		rc = smc_ib_create_queue_pair(lnk);
> > +		if (rc)
> > +			goto dealloc_pd;
> > +		rc = smc_wr_alloc_link_mem(lnk);
> > +		if (!rc)
> > +			break;
> > +		else if (rc != -ENOMEM) /* give up */
> > +			goto destroy_qp;
> > +		/* retry with smaller ... */
> > +		lnk->max_send_wr /= 2;
> > +		lnk->max_recv_wr /= 2;
> > +		/* ... unless droping below old SMC_WR_BUF_SIZE */
> > +		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
> > +			goto destroy_qp;  
> 
> If i.e. smc.sysctl_smcr_max_recv_wr == 2048, and
> smc.sysctl_smcr_max_send_wr == 16, the above loop can give-up a little
> too early - after the first failure. What about changing the termination
> condition to:
> 
> 	lnk->max_send_wr < 16 && lnk->max_recv_wr < 48
> 
> and use 2 as a lower bound for both lnk->max_send_wr and lnk->max_recv_wr?

My intention was to preserve the ratio (max_recv_wr/max_send_wr) because 
I assume that the optimal ratio is workload dependent, and that scaling
both down at the same rate is easy to understand. And also to never dip
below the old values to avoid regressions due to even less WR buffers
than before the change.

I get your point, but as long as the ratio is kept I think the problem,
if considered a problem is there to stay. For example for 
smc.sysctl_smcr_max_recv_wr == 2048 and smc.sysctl_smcr_max_send_wr == 2
we would still give up after the first failure even with 2 as a lower
bound.

Let me also state that in my opinion giving up isn't that bad, because
SMC-R is supposed to be an optimization, and we still have the TCP
fallback. If we end up much worse than TCP because of back-off going
overboard, that is probably worse than just giving up on SMC-R and
going with TCP.

On the other hand, making the ratio change would make things more
complicated, less predictable, and also possibly take more iterations.
For example smc.sysctl_smcr_max_recv_wr == 2048 and
smc.sysctl_smcr_max_send_wr == 2000.

So I would prefer sticking to the current logic.

Regards,
Halil



