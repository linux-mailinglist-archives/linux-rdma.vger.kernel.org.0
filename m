Return-Path: <linux-rdma+bounces-8253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DFA4C351
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F4B188A4FB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5379212D66;
	Mon,  3 Mar 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qx4mJq2d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4E139579;
	Mon,  3 Mar 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011865; cv=none; b=D3s4m7yFdO1hHASIY+u1SfKbJNoE4X7QMZQUDwwoI7J26zhUhh4wR8sjltahzWpFnUBnTIrmXWGEwBUn2qE67PkqsBxkQ2nypZQWiNWkLWv5t/FgmzbaFX2jyYpJF4FYMtFETnpxx/o8Oc7oTy5xaEC1fVFU4tp2j6LdPUblbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011865; c=relaxed/simple;
	bh=DrHNOzIsPRePDm/wjoDsR7p+0haWMn2qBTkIdsFQd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8YWT4v6DB0YsaTeZ1nTIqRjg19kD4WyEftXQ/+XCAYAlXyIOjbVCeZdUW3F6CkEdnKINPt7UorGofyMFtAIj7Qj0+vcr6stR9jP9BGMLOsXAjTBQc+3pbT3CZcfehke0EC8EbWOhhObUsj8rcRTyacLFSU9HM8H3fxG4g+srKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qx4mJq2d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523A2ubC005420;
	Mon, 3 Mar 2025 14:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5soQLA
	3rzECWcYaHao77moD1krGP9rLVyf+EVXfymzk=; b=qx4mJq2dVUXJXiijYPonu9
	8tEM12QLo1QZHhJLjXu7vzRDKgbvXGDtJ84eq5SZoltyS/H+lRR6TBmeZiNOR+lL
	t0wuIzpuDd2h6GiUFO057bR2Z3wzZ0ABDLyvXJZvwgEBVXmbxnn03rMUi0Lcg0Um
	d+0yieGItjbMX3A7EjIlp+0a8B59Eeeby9S0xdFhw3ebBRYk7mKzgwMXPY1lONid
	jPK9r82nrVjEJr3oDlTPaXCJom1Ql66/wL7f4bxmkxWfZgad99f8HO32kjEcC4oF
	b6m0aO8kk3duZ5unGBOSY2GsshHZDIcVJw79YnuYP2izl/bpM9i8nJvJhmRhh7yA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455aapsj7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 14:24:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 523EMIem030395;
	Mon, 3 Mar 2025 14:24:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455aapsj6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 14:24:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 523C3XIS013720;
	Mon, 3 Mar 2025 14:24:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kfu7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 14:24:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 523EODQt17498470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 14:24:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13A8C2004D;
	Mon,  3 Mar 2025 14:24:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4707620040;
	Mon,  3 Mar 2025 14:24:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.68.89])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  3 Mar 2025 14:24:12 +0000 (GMT)
Date: Mon, 3 Mar 2025 15:24:10 +0100
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
Message-ID: <20250303152410.31f5e3df.pasic@linux.ibm.com>
In-Reply-To: <4eb38707-1a93-4c5c-aa65-14adfd595d14@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
	<20250107203218.5787acb4.pasic@linux.ibm.com>
	<908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
	<20250109040429.350fdd60.pasic@linux.ibm.com>
	<b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
	<20250210145255.793e6639.pasic@linux.ibm.com>
	<4eb38707-1a93-4c5c-aa65-14adfd595d14@linux.alibaba.com>
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
X-Proofpoint-ORIG-GUID: MnLozmkxJvNEnJJwCFY4BYBYX0s8lRLG
X-Proofpoint-GUID: O9QXNJNcB1yAxDfIhxTSvMaTixZSEB9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=995 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030107

On Tue, 11 Feb 2025 11:44:32 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> > Can you please help me reason about this? I'm unfortunately lacking
> > Kubernetes skills here, and it is difficult for me to think along.  
> 
> Yes, it is also a problem that not being able to set eth0 (veth/POD)'s PNEDID from the host.
> Even if the eth1(host) have hardware PNETID, the eth0 (veth/POD) can not search the hardware
> PNETID. Because the eth0 (veth/POD) and eth1(host) are not in one netdev hierarchy.
> But the two netdev hierarchies have relationship. Maybe search PNETID in all related netdev
> hierarchies can help resolve this. For example when finding the base_ndev, if the base_ndev
> is a netdev has relationship with other netdev(veth .etc) then jump to the related netdev
> hierarchy through the relationship to iteratively find the base_ndev.
> It is an idea now. I have not do any research about it yet and I am not sure if it is feasible.

I did a fair amount of thinking and I've talked to Wenjia and Sandy as
well, and now I'm fine with moving forward with a variant that
prioritizes compatibility but makes the scenarios you have pointed out
work by enabling taking the SW PNETID of the non-leaf netdev(s) if the
base_dev has no PNETID (neither hw nor sw).

Regards,
Halil

