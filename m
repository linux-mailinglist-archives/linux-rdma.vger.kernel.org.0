Return-Path: <linux-rdma+bounces-5788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2D9BE273
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 10:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ECA283F23
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE61D966A;
	Wed,  6 Nov 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RNkqtIoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA391D95A8;
	Wed,  6 Nov 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885095; cv=none; b=AxYopW2gIkeT7LP2qy9hEpKK2+z/xkMFWXQkmUWbkIBVlaXfLHMMRkfh1hbJsJ2KvVDccGJAKNhqL6rZpZjb/oEkiDNHKvTVqBiG9N+Ezn/7pM6RvruvV6tBPkobfjnMu778PSiBEwzSUJDzV/AqlslTRX5dFXmUJPOv/f0tNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885095; c=relaxed/simple;
	bh=9GwDyy1Sa+NwDRQC7HG/c/OyRWK92tpeVuG1hNpIyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4LOGBxKnXzS1qlRT0eu8L9AiQFa0/m6QvIjRMtgONvxoEvUY9Ad0eZhd6VG0sqw+Bujx8ATMjvHK6u7uomY+tMJ72l+Md+6UzOfQOl+2znH/jI57VSMwKHmtCGDfnl/bbXw+ieMrhQRdBF9a6fcZ0FHu/gskDoJWsbOKJUUP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RNkqtIoa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68f7H5003965;
	Wed, 6 Nov 2024 09:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BlRdg7
	vCZJTd2BYBGxlaJLGRDlENQfLpaBGyDEWK/5M=; b=RNkqtIoazTSaoHJJdpvNNS
	Ux6ElkjyoEKG36ot1ksZRA0VwkHMUHdXd3qU1cekZ4FHPRIn7WooXhFXgQf/gKOJ
	HRIguOljpNszJN7yPWnMmdgFL4Alaj8r+hCpj+0RDjjR5a0Nt3chkU7E4zAXZdlx
	4kZzabh/gAPvsal3IzwAVNP3K2k66IXZpOXom7JpRdiYemnB7ff/5YqcJC8SrKTv
	NGAk4g4wNnT9zd4ULcivIKGQ1uzq7yFjphGtxFhfQhj849B4CTXDKsG+WCU3n+qS
	J/yg9QKBrefHU+uQGtP3JqQUZWddQ9U92S9c6mSQYLCEPjK0keTP37CeJnF2pmxg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r55fg6g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:24:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A69OlrS032301;
	Wed, 6 Nov 2024 09:24:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r55fg6fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:24:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A67SGCY008430;
	Wed, 6 Nov 2024 09:24:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywksh1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:24:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A69OgfE50397626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 09:24:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C18D2004B;
	Wed,  6 Nov 2024 09:24:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE89B20040;
	Wed,  6 Nov 2024 09:24:41 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 09:24:41 +0000 (GMT)
Date: Wed, 6 Nov 2024 10:24:39 +0100
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
Message-ID: <20241106102439.4ca5effc.pasic@linux.ibm.com>
In-Reply-To: <20241105112313.GE311159@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
	<20241027201857.GA1615717@unreal>
	<8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
	<20241105112313.GE311159@unreal>
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
X-Proofpoint-ORIG-GUID: -TaEoACFF2kf8j5ZJhS1hl9kJsiaMwj0
X-Proofpoint-GUID: hHjpfMjNSCrVF8xSm0sL-bIPmsC90wfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=974 adultscore=0
 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060073

On Tue, 5 Nov 2024 13:23:13 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Nov 05, 2024 at 10:50:45AM +0100, Wenjia Zhang wrote:
> > 
> > 
> > On 27.10.24 21:18, Leon Romanovsky wrote:  
> > > On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:  
> > > > Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as
> > > > an alternative to get_netdev") introduced an API
> > > > ib_device_get_netdev. The SMC-R variant of the SMC protocol
> > > > continued to use the old API ib_device_ops.get_netdev() to
> > > > lookup netdev.  
> > > 
> > > I would say that calls to ibdev ops from ULPs was never been right
> > > thing to do. The ib_device_set_netdev() was introduced for the
> > > drivers.
> > > 
> > > So the whole commit message is not accurate and better to be
> > > rewritten. 
> > > > As this commit 8d159eb2117b
> > > > ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> > > > removed the get_netdev callback from
> > > > mlx5_ib_dev_common_roce_ops, calling ib_device_ops.get_netdev
> > > > didn't work any more at least by using a mlx5 device driver.  
> > > 
> > > It is not a correct statement too. All modern drivers (for last 5
> > > years) don't have that .get_netdev() ops, so it is not mlx5
> > > specific, but another justification to say that SMC-R was doing it
> > > wrong. 
> > > > Thus, using ib_device_set_netdev() now became mandatory.  
> > > 
> > > ib_device_set_netdev() is mandatory for the drivers, it is nothing
> > > to do with ULPs.
> > >   
> > > > 
> > > > Replace ib_device_ops.get_netdev() with ib_device_get_netdev().  
> > > 
> > > It is too late for me to do proper review for today, but I would
> > > say that it is worth to pay attention to multiple dev_put() calls
> > > in the functions around the ib_device_get_netdev().
> > >   
> > > > 
> > > > Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> > > > Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and
> > > > get_netdev functions")  
> > > 
> > > It is not related to this change Fixes line.
> > >   
> > 
> > Hi Leon,
> > 
> > Thank you for the review! I agree that SMC could do better. However,
> > we should fix it and give enough information and reference on the
> > changes, since the code has already existed and didn't work with the
> > old way.   
> 
> The code which you change worked by chance and was wrong from day one.

I absolutely agree with that statement. But please notice that the
commit date of commit c2261dd76b54 ("RDMA/device: Add
ib_device_set_netdev() as an alternative to get_netdev") predates the
commit date of commit 54903572c23c ("net/smc: allow pnetid-less
configuration") only by 9 days. And before commit c2261dd76b54
("RDMA/device: Add ib_device_set_netdev() as an alternative to
get_netdev") there was no 
ib_device_get_netdev() AFAICT.

Maybe the two patches crossed mid air so to say.

> 
> > I can rewrite the commit message.
> > 
> > What about:
> > "
> > The SMC-R variant of the SMC protocol still called
> > ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device
> > driver to run SMC-R, it failed to find a device, because in mlx5_ib
> > the internal net device management for retrieving net devices was
> > replaced by a common interface ib_device_get_netdev() in commit
> > 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
> > functions"). Thus, replace ib_device_ops.get_netdev() with
> > ib_device_get_netdev() in SMC. "  
> 
>  The SMC-R variant of the SMC protocol used direct call to
> ib_device_ops.get_netdev() function to lookup netdev. Such direct
> accesses are not correct for any usage outside of RDMA core code. 
> 

I agree, it is not correct since c2261dd76b54 ("RDMA/device: Add
ib_device_set_netdev() as an alternative to get_netdev").

Does fs/smb/server/transport_rdma.c qualify as inside of RDMA core code?
I would guess it is not, and I would not actually mind sending a patch
but I have trouble figuring out the logic behind  commit ecce70cf17d9
("ksmbd: fix missing RDMA-capable flag for IPoIB device in
ksmbd_rdma_capable_netdev()").


>  RDMA subsystem provides ib_device_get_netdev() function that works on
>  all RDMA drivers returns valid netdev with proper locking an reference
>  counting. The commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and
> get_netdev functions") exposed that SMC-R didn't use that function.
> 

I believe the intention was this all along. I think the commit message
was written with the idea that 54903572c23c happened before c2261dd76b54
which is not the case.

>  So update the SMC-R to use proper API,
> 

I believe this is exactly what the patch does! And I agree we need to
improve on the commit message.

Regards,
Halil

