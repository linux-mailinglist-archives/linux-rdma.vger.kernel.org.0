Return-Path: <linux-rdma+bounces-7011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC92A10638
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 13:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB847A38DC
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C1236EA8;
	Tue, 14 Jan 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Od5BoyG1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA2236EA0;
	Tue, 14 Jan 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856486; cv=none; b=gvcsJAJmSLoeaHwAPQv4LznPPJ44e3Kzwc77QKauTmx7mtmuYxM8JClvimFck4DPusHtOfQ1AV+tbRxtraQ/7lxaf1MfNnXW6a4zoa1U/Ms5E3/CBXhRyZI0cfLjrrAIeN7kpZdTTkDYnD3xENZBCGWCOrg9GJi3h0RJa+Ov6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856486; c=relaxed/simple;
	bh=E7K5+ucEOxxLzNde5L9omcNoHmPYfjSAxETqnIOd9f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Czv5cIddHTAZJoSKAPSHe6WRFv38kGOsZ8NzFpNv4joXYnunSC54jmNAQb8hGA9TMWpGHh77JMrs5neFNEWY8DULbMQvs71Dq1b7JdUNg938jNbg062mSwgyqcfEa9PEmTsyVKzKfvBFWwipzyC8aeNHnAjOf+cYFq7/PpqdC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Od5BoyG1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DNaPv2029115;
	Tue, 14 Jan 2025 12:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fwTij2
	ekY4eOUpHpUeqaLb4dfZJ894J/4jBa+HW2Gpc=; b=Od5BoyG1mEUerNtsSw3GhI
	L3T5VxdFw7lnWq5sWm+FqenT9qRsJoSx1eNGAydxTv2yHdQ2a2tkxPhc4y4YtcIV
	WoMD7DsM0bPilrG9kUvCqolegSMUOUolP71dIWJ10CTsqbPWCLc9vetnt3iHaXQr
	2W3UtyX7fF8Fq/A7eRDIZZ34sHS4Ro71EsLMI4PRU04u25z2wSX3FsvFBdlX7K+h
	VQuEFS1+1k75LWulpGmZEXK17+w1nePDAlw0HGEMv6dilNgnx6aP2sSOH3dOYD1w
	4MaNZaFAjmXDaBxZ9SNpJC9m/nCtsjkD13zV3VjcONCHKCCCvdI1/lmCUNwTRc8A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb2eye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:07:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EC2RWl021303;
	Tue, 14 Jan 2025 12:07:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb2eya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:07:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50E9DlAZ007994;
	Tue, 14 Jan 2025 12:07:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yn320v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:07:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EC7rVt56164760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 12:07:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3352004D;
	Tue, 14 Jan 2025 12:07:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE88120049;
	Tue, 14 Jan 2025 12:07:51 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.1.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jan 2025 12:07:51 +0000 (GMT)
Date: Tue, 14 Jan 2025 13:07:47 +0100
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
Message-ID: <20250114130747.77a56d9a.pasic@linux.ibm.com>
In-Reply-To: <b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
	<20250107203218.5787acb4.pasic@linux.ibm.com>
	<908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
	<20250109040429.350fdd60.pasic@linux.ibm.com>
	<b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
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
X-Proofpoint-ORIG-GUID: La3Kt6Pb6dzkxsSAPs2g_oXn96nOHPHN
X-Proofpoint-GUID: 8Qyqk-B7VwZ54CB-4xRmRm3inUSaX0id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=641 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140100

On Fri, 10 Jan 2025 13:43:44 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> > I think I showed a valid and practical setup that would break with your
> > patch as is. Do you agree with that statement?  
> Did you mean
> "
> Now for something like a bond of two OSA
> interfaces, I would expect the two legs of the bond to probably have a
> "HW PNETID", but the netdev representing the bond itself won't have one
> unless the Linux admin defines a software PNETID, which is work, and
> can't have a HW PNETID because it is a software construct within Linux.
> Breaking for example an active-backup bond setup where the legs have
> HW PNETIDs and the admin did not bother to specify a PNETID for the bond
> is not acceptable.
> " ?
> If the legs have HW pnetids, add pnetid to bond netdev will fail as
> smc_pnet_add_eth will check whether the base_ndev already have HW pnetid.
> 
> If the legs without HW pnetids, and admin add pnetids to legs through smc_pnet.
> Yes, my patch will break the setup. What Paolo suggests(both checking ndev and
> base_ndev, and replace || by && )can help compatible with the setup.

I'm glad we agree on that part. Things are much more acceptable if we
are doing both base and ndev. Nevertheless I would like to understand
your problem better, and talk about it to my team. I will also ask some
questions in another email.

That said having things work differently if there is a HW PNETID on
the base, and different if there is none is IMHO wonky and again
asymmetric.

Imagine the following you have your nice little setup with a PNETID on
a non-leaf and a base_ndev that has no PNETID. Then your HW admin
configures a PNETID to your base_ndev, a different one. Suddenly
your ndev PNETID is ignored for reasons not obvious to you. Yes it is
similar to having a software PNETID on the base_ndev and getting it
overruled by a HW PNETID, but much less obvious IMHO. I also think
a software PNETID of the base should probably take precedence over over
the software pnetid of ndev.

Regards,
Halil

