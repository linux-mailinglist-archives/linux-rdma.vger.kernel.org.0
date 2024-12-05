Return-Path: <linux-rdma+bounces-6274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EAF9E561A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50931885134
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B1218ACA;
	Thu,  5 Dec 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aLj91NEv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE521884B;
	Thu,  5 Dec 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403554; cv=none; b=pLmGrJ2k4F4yzXdifyuxK2oFauf06K4bb8GzX9FgRYGsVlc6YG9YJ2vESugpT/B2eW9kFZJSeVJM+4cdGdmigTqir0EMoPNfE0CCPYTFKOg2MMmke6k4nyd3R3CRSJxpFBcIeXr5kqp4L6xseap+SWgnXrEZARd77/lNcN+e9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403554; c=relaxed/simple;
	bh=fg07RDDUmuTpQ6lJX/VD2zvAkPFpkUgAQreDDh3h7Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeMpdh34MOx5pq8Dc4UH0JRLTEis2Z2aBORqqUVJCdj+UVmvKSTRvYUt+xwqxnNkhJRBGSzCHwva+1Ga8MzV5QsKcf3Lii4hGFT8NglMPH3zQ0/q+UuPOmyeRyvjRTSMRN7AcqhyYvKUkzLWdYO0dBH67Ph4wONFf7Ex3N76dKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aLj91NEv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B560br5031839;
	Thu, 5 Dec 2024 12:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8sbkj9
	gkyLAobLOZcSqKyA1r9ycFlPZjwRLP/kCuEME=; b=aLj91NEvjY21hhzpjKZMiK
	u9fH8uA/gvFw+lB8fWxlR++mkjRHZ7ltJokNFYWsKojJLjy8tDEdbE833l/aGaZe
	h8cHJcWQJKMo8KU4jb9JRjrq1d862XqY7YQzsVJUvVsBTYF8JpngSaK/geetzCFp
	6yjBuLvbNwGQQitTiDkddrse3bsWkfR6+cazpW7wAT4mk3x6z83tHMw6EM40THel
	VJ2DRVOTLs0SH8Dh5FM0pZpZhgQMl+eJhQcmvFka0lwyj6+2hU/3MfBWgV16QGCB
	9Bnyri60Qg7UAn6/DTljrEdmLaCHZRh7tB6+IfZETEdQoesTzAoERYbANVuw8kBQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb1xpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 12:59:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B5CqLNr016494;
	Thu, 5 Dec 2024 12:59:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb1xmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 12:59:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5B9N7Y005544;
	Thu, 5 Dec 2024 12:58:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1sxq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 12:58:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B5CwaRD21233920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 12:58:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A44020043;
	Thu,  5 Dec 2024 12:58:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5C920040;
	Thu,  5 Dec 2024 12:58:35 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.76.77])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  5 Dec 2024 12:58:35 +0000 (GMT)
Date: Thu, 5 Dec 2024 13:58:33 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
Message-ID: <20241205135833.0beafd61.pasic@linux.ibm.com>
In-Reply-To: <894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
	<20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
	<894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: P7wskdYk2e_Iqwnk39ux8NOnVyaYMq6i
X-Proofpoint-GUID: 6T3slWX1cnSPVrB_IYU9GoSSZxVQA6RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=924 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050094

On Thu, 5 Dec 2024 11:16:27 +0100
Wenjia Zhang <wenjia@linux.ibm.com> wrote:

> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct
> > smc_sock *smc, ini->check_smcrv2 = true;
> >   	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
> >   	if (!(ini->smcr_version & SMC_V2) ||
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	    (smc->clcsock->sk->sk_family != AF_INET &&
> > +
> > !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||  
> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET
> && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If
> it is, the negativ form of the logical operation (a&&b) is (!a)||(!b),
> i.e. here should be:
> （smc->clcsock->sk->sk_family != AF_INET）|| 
> （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）

Wenjia, I think you happen to confuse something here. The condition
of this if statement is supposed to evaluate as true iff we don't want
to propose SMCRv2 because the situation is such that SMCRv2 is not
supported.

We have a bunch of conditions we need to meet for SMCRv2 so
logically we have (A && B && C && D). Now since the if is
about when SMCRv2 is not supported we have a super structure
that looks like !A || !B || !C || !D. With this patch, if
CONFIG_IPV6 is not enabled, the sub-condition remains the same:
if smc->clcsock->sk->sk_family is something else that AF_INET
the we do not do SMCRv2!

But when we do have CONFIG_IPV6 then we want to do SMCRv2 for
AF_INET6 sockets too if the addresses used are actually
v4 mapped addresses.

Now this is where the cognitive dissonance starts on my end. I
think the author assumes sk_family == AF_INET || sk_family == AF_INET6
is a tautology in this context. That may be a reasonable thing to
assume. Under that assumption 
sk_family != AF_INET &&	!ipv6_addr_v4mapped(addr) (shortened for
convenience)
becomes equivalent to
sk_family == AF_INET6 && !ipv6_addr_v4mapped(addr)
which means in words if the socket is an IPv6 sockeet and the addr is not
a v4 mapped v6 address then we *can not* do SMCRv2. And the condition
when we can is sk_family != AF_INET6 || ipv6_addr_v4mapped(addr) which
is equivalen to sk_family == AF_INET || ipv6_addr_v4mapped(addr) under
the aforementioned assumption.

But if we assume sk_family == AF_INET || sk_family == AF_INET6 then
the #else does not make any sense, because I guess with IPv6 not
available AF_INET6 is not available ant thus the else is always
guaranteed to evaluate to false under the assumption made.

Thus I conclude, that I am certainly missing something here. Guangguan,
do you care to explain?

Regards,
Halil





