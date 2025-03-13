Return-Path: <linux-rdma+bounces-8678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8168AA5FA54
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4091619C46DB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6839268C43;
	Thu, 13 Mar 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LUsvDzCq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D251EF0A5;
	Thu, 13 Mar 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880569; cv=none; b=cax4rt9CmXteWbU6AEvEH1MOga8uUQkMkUB10iKi4C+fv6i7lLMjzFDk3/6JOFVZOKvhQZydWBPtVKokXvrCphiYwgTOHsK7C2PBGIrjXlSUP/QCf8qlqjcQy1K68r7pFM0g43hBZmpdaaHnpMA37YJhM08L7BwmwbWLPi0+Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880569; c=relaxed/simple;
	bh=wM556SCM6EUBbCrqz6qCafPwSg7V69QwdRfb8370hxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwmMuThgxkhnZxS0mLj92xr/qB1Xz3xSMpxssRXEuyJBJLzl4JHB/znrCUJjs8pY/wU+7dX0X5vMDdKL/ytZinrwHtoMDXGyaJxKxrrXFycFyOjs8BXCHP64Pq2Hfm4KdL5P3XA7my826gTg3xuJpbOroFqSr/yz8lhqn9Jupe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LUsvDzCq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DADlNv012055;
	Thu, 13 Mar 2025 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zLwBs8
	CJL7NfCxCwpTspKraeOlev5xmMUrR1jCAxbQk=; b=LUsvDzCqTKCv7KQ+aAL8Ml
	nayXhOJd+KSDpLAONnhOebs+ST5jrXFrDxJTJQJdg6Pw5Us477y3AgHPHTt72dwB
	y/4GF/w6O+e0suh5unfEkiu0f2vcvRbILh7+MG8O5y4i47w/qTgu6L8Hp1G0OYZf
	VABOEa1obq73XG90fH3ZVMk4fntBQg50d7y4rz3mXXfRQSXTLSSKusC/7B63PLSx
	L7W7KUhClOQHsbM4sbsvGLtJzH8j0Kf8ZlHbGika8OgZp4afQGa1whUw5NL3KoZk
	j+bX8SohHf71MyZoCz37xMBEYA8ybrXd4o7xCd+EHbtSWrwilbB4wFWdiGmFrzhQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhg0cpqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 15:42:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DEsgow015127;
	Thu, 13 Mar 2025 15:42:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhg0cpqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 15:42:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DCCN44007406;
	Thu, 13 Mar 2025 15:42:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsraf86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 15:42:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52DFgakg52429070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 15:42:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A695820040;
	Thu, 13 Mar 2025 15:42:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6AF2004B;
	Thu, 13 Mar 2025 15:42:35 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.18.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 13 Mar 2025 15:42:35 +0000 (GMT)
Date: Thu, 13 Mar 2025 16:42:33 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find
 pnetid by pnetid table
Message-ID: <20250313164233.3a974c6c.pasic@linux.ibm.com>
In-Reply-To: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
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
X-Proofpoint-GUID: H-6ivajfkRXP0g2SWga-elmsMVXrMOay
X-Proofpoint-ORIG-GUID: zky_qqhXq3BfkNdxbxJodXOqBWY-Ktrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=686 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130120

On Tue,  4 Mar 2025 20:43:04 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> To resolve the problems list above, this patch extends to search user
> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
> in the base_ndev, and the base_ndev take precedence over ndev for backward
> compatibility. This patch also can unify the pnetid setup of different
> network choices list above in container(Config user-defined sw pnetid in
> the netdevice can be seen in POD).
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

