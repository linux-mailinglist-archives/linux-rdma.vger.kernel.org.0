Return-Path: <linux-rdma+bounces-13726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC2BA899F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 11:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E9418809EE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE1299923;
	Mon, 29 Sep 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGCadrZb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBA2877E2;
	Mon, 29 Sep 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137788; cv=none; b=R7/YAM5GP0eACoUBFNhhHazcHeHTtS5d87Fud4x8XnMrDq53WqGwzIfMgozfbQxOItkoxS6NjdM5ctPtz6ZNVAM4N18Qw8Jn4QgFgOVXfxTUMhkZh7H+URQDq7I3Heha9jmc1tBoQZwY5Dzf11X7CSTv47+awp7FfEjH9dZJDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137788; c=relaxed/simple;
	bh=o38UPIN29bLniqPiPhFpZrIMTLX/LLvulgo6lweFGic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NijNDWI/8y1q5AG1KZV/DOgdP8UoUgGlMiBE3ncmNnRyeRfq+y4rsEwI+f7GKydE/EiNiQXIxoLt7N/+nsQcZs+O8AEuQcnc1ob5w9W4oSKCFpkgmqwEZlnMivf0Tkz4WNXS+3rjjaUVVB0SuFWgiJIQddSx9MJWisIFOAPHcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGCadrZb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T3eQYh010350;
	Mon, 29 Sep 2025 09:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s1gJnQ
	2qSyMcjpCBSUPDDpGvvrpJYUiX69aCYoKB4ko=; b=CGCadrZbpOzw/Gsgjhf4/F
	SyVr0VsvCuX15NyQWXc1x1jE3nrrsctfWfK25rL1vp2SiuKzqT8zEpg3lJxO1qaQ
	WdWPr87Uz0mpwrtxms1FkbzL5rjTCbEKtrN1m3Fj1LJ3MIXnLgxCKNpPkNukK6v2
	40GlKT4sWxtayuXTrN+BuQRByDAiQIxT3AogN3SL8SCml3L83q+rmUOO/jOBS9Oa
	qqHwBjqQGfR8BMUXMAwcwvOMdzbDtZFcTBtv40r67Q86+2blPzVWsdQwwrNgcN1r
	HiZfspiBCyB7n1VHUqHUQ6b4he+R88NaTckMr1qB/RCzQFv5GAz/600r1EZX5C5A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh9c97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 09:22:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58T9FOkB025149;
	Mon, 29 Sep 2025 09:22:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh9c94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 09:22:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58T8xJb5026736;
	Mon, 29 Sep 2025 09:22:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mnbgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 09:22:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58T9MreZ26607972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 09:22:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC5C20043;
	Mon, 29 Sep 2025 09:22:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3DA20040;
	Mon, 29 Sep 2025 09:22:53 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Sep 2025 09:22:53 +0000 (GMT)
Date: Mon, 29 Sep 2025 11:22:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
 <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta
 Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>,
        Guangguan Wang
 <guangguan.wang@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <20250929112251.72ab759d.pasic@linux.ibm.com>
In-Reply-To: <aNnl_CfV0EvIujK0@linux.alibaba.com>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
	<20250929000001.1752206-3-pasic@linux.ibm.com>
	<aNnl_CfV0EvIujK0@linux.alibaba.com>
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
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68da4ff2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=Rw7vO3jwzhc16tXXxd0A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX1CpacjLlkMq6
 MIbY1/i9PfsW6QpiUG7SAbznR9jJwDMtVQ+bO+jWx4E7eVjDBSuFqAAvRFtVeu2M/xzfvf4w5n8
 XiOUb2qKAQgkxrD7/bpHgFK25I6vtFcuyDmDUQMVs0J+IdIB7cdm5CqyU8ytioHKMG67+Ic9L0f
 IJ9dMqnhFTVeNAQvcNz8VC8eFxYRuqChKT/RcfiSkl+zveLFLoXMhZXWzwfwmxvPoyQlOBdyY47
 l93E7Oth99sEfePpNf09VZxKBLwJCf+0EKXLmXwaSL4LnFH6jOHdIAA1PkdsgDj+a2yb6BRNMh0
 yUtzU7ssrNIZqmpHGAK0vaSJcrJRNz4qT8VqU0fEIJiQRHiLoVe/8HK1bkVjNtubGlUlwkUzgu4
 EG4nHcgYOyC9LtAXenpQZiE0S0tPNw==
X-Proofpoint-GUID: nGVjQKKzu6o9ZAcaEMtguM9SGulJrRt2
X-Proofpoint-ORIG-GUID: iHKcb-bTY_QZrCitDOpNcCuxb1IVoaeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010

On Mon, 29 Sep 2025 09:50:52 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> >@@ -175,6 +175,8 @@ struct smc_link {
> > 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
> > 	int			llc_testlink_time; /* testlink interval */
> > 	atomic_t		conn_cnt; /* connections on this link */
> >+	u16			max_send_wr;
> >+	u16			max_recv_wr;  
> 
> Here, you've moved max_send_wr/max_recv_wr from the link group to individual links.
> This means we can now have different max_send_wr/max_recv_wr values on two
> different links within the same link group.

Only if allocations fail. Please notice that the hunk:

--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->clearing = 0;
 	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
 	lnk->link_id = smcr_next_link_id(lgr);
+	lnk->max_send_wr = lgr->max_send_wr;
+	lnk->max_recv_wr = lgr->max_recv_wr;

initializes the link values with the values from the lgr which are in
turn picked up form the systctls at lgr creation time. I have made an
effort to keep these values the same for each link, but in case the
allocation fails and we do back off, we can end up with different values
on the links. 

The alternative would be to throw in the towel, and not create
a second link if we can't match what worked for the first one.

> 
> Since in Alibaba we doesn't use multi-link configurations, we haven't tested
> this scenario. Have you tested the link-down handling process in a multi-link
> setup?
> 

Mahanta was so kind to do most of the testing on this. I don't think
I've tested this myself. @Mahanta: Would you be kind to give this a try
if it wasn't covered in the past? The best way is probably to modify
the code to force such a scenario. I don't think it is easy to somehow
trigger in the wild.

BTW I don't expect any problems. I think at worst the one link would
end up giving worse performance than the other, but I guess that can
happen for other reasons as well (like different HW for the two links).

But I think getting some sort of a query interface which would tell
us how much did we end up with down the road would be a good idea anyway.

And I hope we can switch to vmalloc down the road as well, which would
make back off less likely.

> Otherwise, the patch looks good to me.
> 

Thank you very much!

Regards,
Halil

