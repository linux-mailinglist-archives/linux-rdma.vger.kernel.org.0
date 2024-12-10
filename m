Return-Path: <linux-rdma+bounces-6380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC69EAD64
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAE8288968
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF262080F3;
	Tue, 10 Dec 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qm9JVpnS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E72080C9;
	Tue, 10 Dec 2024 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824800; cv=none; b=aPz2muW2iraqNvH9u38U8AcwSPs3G3fBf0pC/wbaPt4+IWkb0kEh0PHIUF/V4Cd4ow2cEf/oSUQvZqKUj7X8m5ju6Lau/mMVr58DH9SaRsIXibtC+BhDi0yzKhisHPpRnM3jLrZEqLlFZVDhY6YSsSV9jRUCwC/MFhf9wZOaGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824800; c=relaxed/simple;
	bh=t5EUydVzLEUmqeeWH9AEltt3IDkS6msVBQR7PHoGIfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/kmibDbPhfYjNDv1Dfa5UTnsHPmJtFKFlfqvvnn3fEFBxc3Fjjdeq7oOmhnsY5ng57sKPl+MjNviIKFV/YV1Hj0iYTgGksw6CpFSXZWLhYX9MZPs/zGzNS73wYMMELxRa/FMIb4PfmPpkykiqTf928CBJeVl4fGgsfjOQJZm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qm9JVpnS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9RiFj019995;
	Tue, 10 Dec 2024 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vkFVlj
	oYH9tR0VLBFqHDDM+41lBT98TZUnYgw/2vQoA=; b=Qm9JVpnSTodL6Jn+KB49XV
	f9nDS8IPQZ9xAesoWjK91x5dceFBm3H527xuZJo2J6YoGFLxlZoxPX6/eyaz/EhK
	nVMEzx9qZKm1WMCtkOdhn1J0wm031Qx7DeCniPryb7Ee0mZyaji41b+gDx+Uwy5t
	ZfqlMAtBVPhtRQSNRJz4YmyupXUogGb2Eq4VN9RsJDKxpqq/woa08P5lhunpdcVy
	5f6AWUabbj35aXNyqG5zQsouEInumm7FgqYsL+Z5iTp1yTNZ2d0YPpCaCFBF+Gur
	9I66aqy6ARe66rdt7NDaq2bqy55RKHdJfScKOnkl31+sPI0oh6VsFWrZYznvtj/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38pak1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:59:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA9tgcM020180;
	Tue, 10 Dec 2024 09:59:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38pajy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:59:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA8uKK3023018;
	Tue, 10 Dec 2024 09:59:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjtrke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:59:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BA9xngf59113872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 09:59:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD6420043;
	Tue, 10 Dec 2024 09:59:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3714720040;
	Tue, 10 Dec 2024 09:59:49 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 09:59:49 +0000 (GMT)
Date: Tue, 10 Dec 2024 10:59:47 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
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
Message-ID: <20241210105947.466674a4.pasic@linux.ibm.com>
In-Reply-To: <58075d86-b43a-4d58-bf64-c29418f99143@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
	<20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
	<894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
	<20241205135833.0beafd61.pasic@linux.ibm.com>
	<5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
	<7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
	<3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
	<d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
	<868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
	<20241209104647.5c36c429.pasic@linux.ibm.com>
	<85d1c6e1-0fe3-4c71-af4e-8015270b90dc@linux.alibaba.com>
	<20241209214449.0bb5afce.pasic@linux.ibm.com>
	<58075d86-b43a-4d58-bf64-c29418f99143@linux.alibaba.com>
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
X-Proofpoint-GUID: dHsgy1URY5S9tEcSQkFfxg7h82R871U5
X-Proofpoint-ORIG-GUID: 2Ce0Tx0GAoXpvCY_w4Jxbxfc-J6aTeY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=857
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100074

On Tue, 10 Dec 2024 15:07:04 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> On 2024/12/10 04:44, Halil Pasic wrote:
> > On Mon, 9 Dec 2024 20:36:45 +0800
> > Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> >   
> >>> I believe we would like to have a v3 here. Also I'm not sure
> >>> checking on saddr is sufficient, but I didn't do my research on
> >>> that question yet.
> >>>
> >>> Regards,
> >>> Halil    
> >>
> >> Did you mean to research whether the daddr should be checked too?  
> > 
> > Right! Or is it implied that if saddr is a ipv4 mapped ipv6 addr
> > then the daddr must be ipv4 mapped ipv6 addr as well?
> > 
> > Regards,
> > Halil  
> 
> I did a test by iperf3:
> A server with IPV4 addr 11.213.5.33/24 and real IPV6 addr 2012::1/64.
> A client with IPV4 addr 11.213.5.5/24 and real IPV6 addr 2012::2/64.
> iperf3 fails to run when server listen on IPV6 addr and client connect
> to server using IPV4 mapped IPV6 addr. commands show below:
> server: smc_run iperf3 -s -6 -B 2012::1
> client: smc_run iperf3 -t 10 -c 2012::1 -6 -B ::ffff:11.213.5.5
> 
> Failure happened due to the connect() function got the errno -EAFNOSUPPORT,
> I also located the kernel code where the -EAFNOSUPPORT is returned
> (https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/ipv6/ip6_output.c#:~:text=err%20%3D%20%2DEAFNOSUPPORT%3B).

Thanks! That is enough for me!


