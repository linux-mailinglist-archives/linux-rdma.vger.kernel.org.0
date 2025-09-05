Return-Path: <linux-rdma+bounces-13133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDAB46525
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5095C7914
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAF22ECD10;
	Fri,  5 Sep 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kFjJXLIa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4BB2EA493;
	Fri,  5 Sep 2025 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106325; cv=none; b=OEyjkvZ4Qs+YkNCqNyuF8hXTCWULQEZ846kI4bcGPCBmbCvwlaTRHfIE+Xfm9rAi+jmno8fnLzqoN8vak8slPbVlOuuZIqjSrA3BYzyihl6X9iuX2tQsOwUHSSuIZHoua85cb7kqa1ZDb8E5CbWgbkXjsTScwtu5uHlS2KKwIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106325; c=relaxed/simple;
	bh=WwXmevbkvQGC2scZhhIJEKbZtmCmkQ9lVU6gO1rOqmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VarEe7fMA9S6okDXkxsnB2+GEEOEPBo20tlu+HQit2Hh0Ijklc03bhNmSF1phQEXfziGXpOO1czncUEfzEESBdtnH3Hn9yBRDUsF9+Poov1daxeUeO2M8cOlb2oDgpS/Z1RiMtK9Ug0kaGX1HFx6V5PXTmmXj4MnNlzUT1udf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kFjJXLIa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GoQAG032215;
	Fri, 5 Sep 2025 21:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WeBZPL
	befegcelt2pAe1gHU6EeWURDShAbvkLnzzvbA=; b=kFjJXLIavwzCft0z8Xzj+l
	Yq+wIvqdhB0R9IWyhA0/bAJDPUsS1NM4QvwNeDF819meGmlVqwTrdmVl2Hbll6Jm
	g6dUP/or/4Nr/40COfo0hfG/aqa7jP8VXvvc5E3igEpHUr+s4IeEFL1Xr4O3yqLR
	GTZ1ogSd3ObXxf04/TPrJVx/iW2h3ymVQ0bso+rf35TYFoVQCHgIzjakREdU7cSh
	zRtjSvaMCu3OLPiiMiAjXBl4rbElLzpYQR5qE0f0/mqOH9LzAFfaQXN82NDkDQzO
	3gjt1JtEaVQoyLr4trMjRXBSjwoD6oav9T+hRQxJLBt/gtUo+vNveam/6hJK0t3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfe3n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 21:05:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585Kxarm028378;
	Fri, 5 Sep 2025 21:05:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfe3n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 21:05:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585HqE2A014365;
	Fri, 5 Sep 2025 21:05:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3u1ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 21:05:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585L5E5t28574352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 21:05:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F32C20040;
	Fri,  5 Sep 2025 21:05:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F152720043;
	Fri,  5 Sep 2025 21:05:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.18.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  5 Sep 2025 21:05:12 +0000 (GMT)
Date: Fri, 5 Sep 2025 23:05:10 +0200
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
Message-ID: <20250905230510.76171115.pasic@linux.ibm.com>
In-Reply-To: <aLr4-V8V1ZWGMrOj@linux.alibaba.com>
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
	<20250904211254.1057445-2-pasic@linux.ibm.com>
	<aLpc4H_rHkHRu0nQ@linux.alibaba.com>
	<20250905110059.450da664.pasic@linux.ibm.com>
	<20250905140135.2487a99f.pasic@linux.ibm.com>
	<aLryOL-fahUINVg0@linux.alibaba.com>
	<aLr4-V8V1ZWGMrOj@linux.alibaba.com>
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
X-Proofpoint-GUID: 8kAslMKBxvWgLUbRtWp7CSySMvN480U-
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68bb508f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SRrdq9N9AAAA:8 a=SH69JWTYOVUKGAvczP0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xoMw5JAyoRFrxm5iJo3FhvMUghevaDfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX5szN4hcKmu+4
 AMkRIWahJP8eudhEtuHBdms+HHNJaWNZ0waQsaSUsHE+pmrSyZ6LraYZcHaFYMmG8OI0losoP0t
 HQuzs53h8qFiFhMIptffRsXlW3E/NHf4qAgx74zznn9TiCp8GltD0bj5gB8b5twl04hQNYLaAMF
 +80HVTMWH70PoLpfrcZB1VLL2W7uanJCF0pn8+vB7KAidGbw2HXMIYzi6896A0ragxM7AtnMX2r
 RZwpB8fNh1JWkWcOcv1Ra6tiibnmzI1E5Twse3ZHqgMcZAg1QSBGLGzSMzoPMj0FuK8+BMplJMK
 El4edhL2qdJDTnVU0bVQ+nQN3DHdvH4GgHWiy5MllQT1sZ1VejMwDZlgxV63GxcJgc7IGRsGSF5
 doM0WOX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

On Fri, 5 Sep 2025 22:51:37 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> >>Did some research and some thinking. Are you concerned about a
> >>performance regression for e.g. 64 -> 16 compared to 16 -> 16? According
> >>to my current understanding the RNR must not lead to a catastrophic
> >>failure, but the RDMA/IB stack is supposed to handle that.  
> >
> >No, it's not just a performance regression.
> >If we get an RNR when going from 64 -> 16, the whole link group gets
> >torn down — and all SMC connections inside it break.
> >So from the user’s point of view, connections will just randomly drop
> >out of nowhere.  
> 
> I double-checked the code and noticed we set qp_attr.rnr_retry =
> SMC_QP_RNR_RETRY = 7, which means "infinite retries."
> So the QP will just keep retrying — we won't actually get an RNR.
> That said, yeah, just performance regression.
> 
> So in this case, I would regard it as acceptable. We can go with this.

Yes, that is consistent with Mahanta's testing in a sense that he did
not see any catastrophic failure. Regarding the performance regression,
I don't know how bad it is. Mahanta was so kind to do most of the
testing. 

So that leaves us with replacing tabs with spaces and maybe with the
names, or? If you have a proposal for a better name let's talk about
is.

BTW are you aware of any generic counters that would help with
figuring out how many RNRs have been sent/received?

Regards,
Halil

