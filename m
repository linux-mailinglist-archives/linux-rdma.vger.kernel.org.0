Return-Path: <linux-rdma+bounces-6922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5DA06BD3
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 04:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296B918883AE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2613B7AE;
	Thu,  9 Jan 2025 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SLVbenMt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0F139CF2;
	Thu,  9 Jan 2025 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391885; cv=none; b=sg9X0b2qzdd+tq5o2HqJgpz0xRwDy7hEZY+QIzt5yfZxZ+9V/qD7+eXlJSnY/7tyI97AY37uv0+gu42NVvAcBsXOuLneiHOudLpwHMTDk0dPjXnIjbvXzWoWXNdkCaihZkQ453qa/sa+N3YCjnQCr8A35cYAhR1dXF5yy8GNRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391885; c=relaxed/simple;
	bh=K+nUBd2JGauhb1BPitIYbNWXqXl1MYo9/CXFAZQ0+cY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvLlihFe+gq4C6yKh7fDr8JWsS4LPHLCcj8AZIKWDkdoD61YyQqQrtcCZh9pmBKgOjPynuYxi+CKk9dkLUn3uqF2o+5JYLdVxwlFLfd7x1dXcC7UJRkG0SUcJwd+OzO5YQU3Rl78u011KF2XftIp0K2jdRaLaDK7MVEOoQRq/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SLVbenMt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Nwd4U016940;
	Thu, 9 Jan 2025 03:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F521Mj
	HfEQEV+dlWDHPgFtwV3eLXoTVg74aU2NY3oRw=; b=SLVbenMtH6CVzvsmJMpr+1
	vSBMKFQi5iTCtZDd/aTxjmbI7iqAY5WGtaPCfXmcqDBwkgLhBdadRYQKi4ScpWNx
	K2zhCwYTF6SxlE52xMp63+WHd+iDeBUSJeToOKhQQ7zDkVLB5k2ImauMVhLOx8O1
	6owydunUXOyfnlKS4L8iJdrAgeNPVBtaNipAHjrqwHDiWpIC3ZSpxhACeCvtpSZU
	4PLyoBrP0UIvFFP3Pxcrst4JEDHf+uzrGAXoOEpBzg2fgPoWVS0YLZPGZ/3ML8Ac
	PE8OruzedWR9suYpetN2gcYyHxUuKqtjw6BWoKcoBxWLw9PzdnVdaREvKojAAa+A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4423ghrmeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:04:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5092vBLK007706;
	Thu, 9 Jan 2025 03:04:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4423ghrmen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:04:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50905YnZ008869;
	Thu, 9 Jan 2025 03:04:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq037eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:04:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50934W2Z8585492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 03:04:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F184220043;
	Thu,  9 Jan 2025 03:04:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3EC32004B;
	Thu,  9 Jan 2025 03:04:30 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.84.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  9 Jan 2025 03:04:30 +0000 (GMT)
Date: Thu, 9 Jan 2025 04:04:29 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
Message-ID: <20250109040429.350fdd60.pasic@linux.ibm.com>
In-Reply-To: <908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
	<20250107203218.5787acb4.pasic@linux.ibm.com>
	<908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
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
X-Proofpoint-GUID: c-YJzEI6PimfRixeIzOGUPFCXjLQCG_e
X-Proofpoint-ORIG-GUID: -i-ItMAOiafV3SiAw9NPA3NkVctKgiuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxlogscore=500 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090022

On Wed, 8 Jan 2025 12:57:00 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> > sorry for chiming in late. Wenjia is on vacation and Jan is out sick!
> > After some reading and thinking I could not figure out how 890a2cb4a966
> > ("net/smc: rework pnet table") is broken.  
> 
> Before commit 890a2cb4a966:
> smc_pnet_find_roce_resource
>     smc_pnet_find_roce_by_pnetid(ndev, ...) /* lookup via hardware-defined pnetid */
>         smc_pnetid_by_dev_port(base_ndev, ...)
>     smc_pnet_find_roce_by_table(ndev, ...) /* lookup via SMC PNET table */
>     {
>         ...
>         list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
>                 if (ndev == pnetelem->ndev) { /* notice here, it was ndev to matching pnetid element in pnet table */
>         ...
>     }
> 
> After commit 890a2cb4a966:
> smc_pnet_find_roce_resource
>     smc_pnet_find_roce_by_pnetid
>     {
>         ...
>         base_ndev = pnet_find_base_ndev(ndev); /* rename the variable name to base_ndev for better understanding */
>         smc_pnetid_by_dev_port(base_ndev, ...)
>         smc_pnet_find_ndev_pnetid_by_table(base_ndev, ...)
>         {
>                 ...
>                 list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
>                 if (base_ndev == pnetelem->ndev) { /* notice here, it is base_ndev to matching pnetid element in pnet table */
>                 ...
>         }
> 
>     }
> 
> The commit 890a2cb4a966 has changed ndev to base_ndev when matching pnetid element in pnet table.
> But in the function smc_pnet_add_eth, the pnetid is attached to the ndev itself, not the base_ndev.
> smc_pnet_add_eth(...)
> {
>     ...
>     ndev = dev_get_by_name(net, eth_name);
>     ...
>         if (new_netdev) {
>             if (ndev) {
>                 new_pe->ndev = ndev;
>                 netdev_tracker_alloc(ndev, &new_pe->dev_tracker,
>                     GFP_ATOMIC);
>             }
>             list_add_tail(&new_pe->list, &pnettable->pnetlist);
>             mutex_unlock(&pnettable->lock);
>         } else {
>     ...
> }

I still not understand why do you think that 890a2cb4a966~1 is better
than 890a2cb4a966 even if things changed with 890a2cb4a966 which
I did not verify for myself but am willing to assume.

Is there some particular setup that you think would benefit from
you patch? I.e. going back to the 890a2cb4a966~1 behavior I suppose.

I think I showed a valid and practical setup that would break with your
patch as is. Do you agree with that statement?

Regards,
Halil

