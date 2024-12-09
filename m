Return-Path: <linux-rdma+bounces-6328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECA9E8F0C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A51281DBF
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407D216619;
	Mon,  9 Dec 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eI52RaXC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE631216611;
	Mon,  9 Dec 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737622; cv=none; b=tvvvqSoGfAwvtunawvQmmnMizh3i+qniGyCQrvuBeQR9kjPz5UPuBFNm1Tjqj2DDFa01jCPP5fAgT7FQGB8J9SK6z8ZVJajUdqYX25gaswDchqFPk2M//caXNMQHkWfVOU1tsE1YafDg/Jhz5/1ehcv0N2HWma5HtqcLbpifULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737622; c=relaxed/simple;
	bh=N60uhZmqgtsTdxA/l+SLwOPWJgwGUdT08XJlCAibg/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmIbhD5nVcC9GSP19R1+lLZt9NLxuEf/UHRdBF9xnRk41lFoXYNTfWkqR71WpwAPmBFkRgg2ZUnMPPjlM/kyPblsyHGYj7RvVEMW+bJBg+pZ1X6tDwD9nrJjhvilt0WHryG/9G56hW1GAD+rENXCzN1VUv82TQ+oqxbiKB9fpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eI52RaXC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MQ3P9010813;
	Mon, 9 Dec 2024 09:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9bUY/v
	wlv1lFTgSljFyNrcWCifJ6kjyfjcjGIbQleK0=; b=eI52RaXCPa9HlJ5aCRAZwd
	05wNVbT4lpJYwv7DdkUezIegFHh1kSev5S3ZtXV+eK6zm7A/XbPlYacAqk2JBTg4
	34JC9+s94ju81eF7f/VmdrQcakPl7qrNEsBRnEByRdN5uuoIqpMXAOQhRP/n6yBe
	0lzhEIivGxh8kvgeZuN6h6zkgUSEwmYElJ3xHwrZbCx6JOMxGFpAY5rhhNf5Z1lu
	th8vjpPpH2r6xdC47YjNuTpWBdA85iFycIDfF0q5sRuTIq4I2Be+Lp8WQEwXvcod
	dSgfq+Lq6AMe8rVyDg0T9Ir75vuTxpodqvhnE3O/nrUaFbR3KNns8kI21j/NKmVg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vggtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:46:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B99imJh002575;
	Mon, 9 Dec 2024 09:46:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vggt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:46:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98B2YJ017397;
	Mon, 9 Dec 2024 09:46:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1dmqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:46:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B99koAi65274136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 09:46:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D5AA20040;
	Mon,  9 Dec 2024 09:46:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7500E20043;
	Mon,  9 Dec 2024 09:46:49 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.14.202])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  9 Dec 2024 09:46:49 +0000 (GMT)
Date: Mon, 9 Dec 2024 10:46:47 +0100
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
Message-ID: <20241209104647.5c36c429.pasic@linux.ibm.com>
In-Reply-To: <868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
	<20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
	<894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
	<20241205135833.0beafd61.pasic@linux.ibm.com>
	<5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
	<7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
	<3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
	<d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
	<868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
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
X-Proofpoint-GUID: ddy6SNq3VtLuAQsrHnlbwLDhUloAOUYZ
X-Proofpoint-ORIG-GUID: MWeIVl2jrEaAB-L2GrTVfcn7T6-ALXy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090073

On Mon, 9 Dec 2024 09:49:23 +0100
Wenjia Zhang <wenjia@linux.ibm.com> wrote:

> > Otherwise, the code below is reasonable.
> >        if (!(ini->smcr_version & SMC_V2) ||
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +        (smc->clcsock->sk->sk_family == AF_INET6 &&
> > +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> > +#endif
> >            !smc_clc_ueid_count() ||
> >            smc_find_rdma_device(smc, ini))
> >            ini->smcr_version &= ~SMC_V2;
> >   
> Ok, I got your point, a socket with an address family other than AF_INET 
> and AF_INET6 is already pre-filtered, so that such extra condition 
> checking for the smc->clcsock->sk->sk_family != AF_INET is not 
> necessary, right?
> 
> Would you like to send a new version? And feel free to use this in the 
> new version:
> 
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

I believe we would like to have a v3 here. Also I'm not sure
checking on saddr is sufficient, but I didn't do my research on
that question yet.

Regards,
Halil

