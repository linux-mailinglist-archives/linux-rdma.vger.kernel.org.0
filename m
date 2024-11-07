Return-Path: <linux-rdma+bounces-5833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B8D9C048E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D8B1C221EF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A620C463;
	Thu,  7 Nov 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFtu5G2E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9120C48E;
	Thu,  7 Nov 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980054; cv=none; b=Kti96XVLb77iqcpHYpxX77gM1abQv81gwDAC+3IHcz+SaKlM4AXBynQxocn7LLhsOuMdjqsf343942pEqRvqFHuCeU+YxsGNUZckL49duI1UZsWI5DaHBYSmn517aztIRtafcCzCd1NHP0cd7mzav0QzTO12adRmIaBvA9iusfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980054; c=relaxed/simple;
	bh=6MjnE66MscCz2AktnHYRjBEt00gjdYWDjIHYpaNld5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFrkBsTXACnV5ixKPyc/umDTFfzzA7J4twPcr2/ScuWzuaGRN6b97PjmIB7Nr2ZeuOmBxFRDwL9j7cA+1FzRWwBhvC1+07ckTlKFpArcrjXjc/TZUEuOhFYCuh8GQSDEvx2hs6SOxrmvVKw4yCl8yHhbx0s27nDA7SDqO0BfAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WFtu5G2E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Be10x021281;
	Thu, 7 Nov 2024 11:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFzLPd
	a0aQxdDIFTgNqeOzQ+UaQ+jLl3y27wpIYN9RU=; b=WFtu5G2EdbOrEyU30bV59M
	vTBTE+85MfAyVtPtk92lmw4JN9TSoiXzlmGezI6wlidklJBY4/t1ovuMXKd3QBPC
	TXS58ckXPOO2CX5Qe2n7VgrymBmYmrj+SPmq1znfPW3DJ9L2TT5VyMg3xWpRxwm/
	Mulzjx8Ewm83Gcta18+Dt7sExZc60vO7e+yMazdugNbZ+Ae8nbwpao3CWqKfE5MG
	LLzHsWBqV9yyYxC7CZ0J00c24cIQDKgvHV1ruEVDwCeXDeYS9F+rVmvA6MfcS+u6
	GSoAh1sZqCL2dP/OxyayRdt7u/gnCgdy+q2KWRoMqL2EgLo/OLng2MQK/qTIXyZQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rvvgr0qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:47:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7BlKFC000758;
	Thu, 7 Nov 2024 11:47:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rvvgr0qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:47:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7B5W8H023919;
	Thu, 7 Nov 2024 11:47:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyx8bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:47:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7BlFlT54788592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 11:47:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F862004D;
	Thu,  7 Nov 2024 11:47:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49242004B;
	Thu,  7 Nov 2024 11:47:13 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.13.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 Nov 2024 11:47:13 +0000 (GMT)
Date: Thu, 7 Nov 2024 12:47:11 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Jan Karcher
 <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell
 <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241107124711.2e9e7e8f.pasic@linux.ibm.com>
In-Reply-To: <20241106135910.GF5006@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
	<20241027201857.GA1615717@unreal>
	<8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
	<20241105112313.GE311159@unreal>
	<20241106102439.4ca5effc.pasic@linux.ibm.com>
	<20241106135910.GF5006@unreal>
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
X-Proofpoint-GUID: SpVMvhJ3tBUOjE6AOo2pFADeg6zNQjb3
X-Proofpoint-ORIG-GUID: UuEUpFyFvl6qk90ypW5_SHQQCM7PXDsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxlogscore=848 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070090

On Wed, 6 Nov 2024 15:59:10 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> > I absolutely agree with that statement. But please notice that the
> > commit date of commit c2261dd76b54 ("RDMA/device: Add
> > ib_device_set_netdev() as an alternative to get_netdev") predates the
> > commit date of commit 54903572c23c ("net/smc: allow pnetid-less
> > configuration") only by 9 days. And before commit c2261dd76b54
> > ("RDMA/device: Add ib_device_set_netdev() as an alternative to
> > get_netdev") there was no 
> > ib_device_get_netdev() AFAICT.  
> 
> It doesn't make it right.

I agree!
> 
> 1. While commit c2261dd76b54 was submitted and discussed, RDMA was not
> CCed.

Would the RDMA community agree with adding 
L:	linux-rdma@vger.kernel.org
to the "SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS" section of the
MAINTAINERS file, so that get_maintainer.pl tells contributors to cc
RDMA?

In my personal opinion SMC would have benefited greatly from review by
the RDMA community, and this is not the first time where the RDMA
community was not included where it should have been.
 
> 2. Author didn't try to add his version of ib_device_get_netdev() as it
> is done for all APIs exposed by RDMA core.

I understand now that direct access to ops callbacks is off limits for
ULPs. I'm not sure I understand all the details, but I hope I don't have
to.

Regards,
Halil

