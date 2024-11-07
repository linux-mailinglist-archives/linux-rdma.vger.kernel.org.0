Return-Path: <linux-rdma+bounces-5834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF569C04FD
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BBB1F2304A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF620C463;
	Thu,  7 Nov 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="No8l+H17"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D718FDAF;
	Thu,  7 Nov 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980619; cv=none; b=VembSVvZEIBl+OYMh3wLjIm0H+RgrcEQWoC+2IayFOAIEk5I4YtTZJALbeQSLo5mO+YvTTTW0qcW99/qckt+mTt366PrjQ/oHBzBH7AHD3NxQ8sQ7ysS1cQUZuWznJeG+2VYDRrkW+58zjVhR/9o5psq/AX+EZTc5VktSl80Sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980619; c=relaxed/simple;
	bh=4pwJUW7QPMkOtc6HwpDYlGs/K22/GegT4OlM7GsMWGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjhSf+cJe52KH2po6XIigtOIu2xpKLASq/p2714aV7CGG88HRXsLzgRcM1va/RSL8lUDNKXwoDiGzdf0z+dou5Uim8E6Q36osmpTy9gyFFvUmew5t6iXzvgOi4DOQf9iCKIrZWb6Yqy6gRZ0EJFtYoixSbJAn/NWeZrYJqNx8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=No8l+H17; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BjSZJ002624;
	Thu, 7 Nov 2024 11:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c+qNo6
	yMcqwgT34P54tk473Xr4TkpvXiT2oLlxbaqSs=; b=No8l+H17lMoEA/y6O5PlJS
	rC4PuGmalvx6wKMz//ol5rm2+dxKBL7Ib9Hlr3gg5zgiSY/UWhfwlL9RWTS7emBR
	E7N9euDH6pACRlXzTg4Zfx5rnVhsH8HE1w10ys7Oj4Nbqbh0/Jhnrd5BLk7Yt5UI
	ZpVHisCRmLQ7grxdpLr+hBtdcX7IpSZ3Y40ErmCdXBws/jEB1dUFqUpgK/C4HoGk
	fAtDAb/r7bCar8VpET9KoAMgh78NAWR1DYPIX4n6eRuA+dvUrV15JaZeQBhDKs+6
	UA0yBOU610IuCGhsqc/djEUpvu3BUts6/IKZQ6lsW/jw7DSxwowUQgjjF/PLFsQA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rvy2815g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:56:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7BupCa027204;
	Thu, 7 Nov 2024 11:56:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rvy2815d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:56:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ADL5L008430;
	Thu, 7 Nov 2024 11:56:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywm5tn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:56:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7Bukwh54788376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 11:56:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C45A62004B;
	Thu,  7 Nov 2024 11:56:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F46F20040;
	Thu,  7 Nov 2024 11:56:45 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.13.246])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 Nov 2024 11:56:45 +0000 (GMT)
Date: Thu, 7 Nov 2024 12:56:43 +0100
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
        Halil Pasic <pasic@linux.ibm.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241107125643.04f97394.pasic@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: q-k8qkSNdHBA__T88Xb-YjymiaM95i7D
X-Proofpoint-GUID: oPIbzZlpAq3pL_m2OVcWioYUNsMcK2h-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411070086

On Wed, 6 Nov 2024 15:59:10 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> > Does  fs/smb/server/transport_rdma.c qualify as inside of RDMA core code?  
> 
> RDMA core code is drivers/infiniband/core/*.

Understood. So this is a violation of the no direct access to the
callbacks rule.

> 
> > I would guess it is not, and I would not actually mind sending a patch
> > but I have trouble figuring out the logic behind  commit ecce70cf17d9
> > ("ksmbd: fix missing RDMA-capable flag for IPoIB device in
> > ksmbd_rdma_capable_netdev()").  
> 
> It is strange version of RDMA-CM. All other ULPs use RDMA-CM to avoid
> GID, netdev and fabric complexity.

I'm not familiar enough with either of the subsystems. Based on your
answer my guess is that it ain't outright bugous but still a layering 
violation. Copying linux-cifs@vger.kernel.org so that 
the smb are aware.

Thank you very much for all the explanations!

Regards,
Halil 

