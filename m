Return-Path: <linux-rdma+bounces-6454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0D9ED610
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 20:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289E72817DF
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FE25948F;
	Wed, 11 Dec 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LdjFUTiu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913B23FD2E;
	Wed, 11 Dec 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943299; cv=none; b=u2pV4sS6kGCSC2LRdUilvUYurekHJII9AB8Iq0/yTzdutGVtOT84YkCngbdxjEsmzf2bAnUT7AnqfgFuWoskZsdZ35XOOOs32CIBLtxu6rjEIosPdUkG4nJJOFRrg87buNpJSMTfQ7xnrSLCVSqEy2nTL05InhHIWWeV5o779yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943299; c=relaxed/simple;
	bh=VsLFDWRcpPe3Dn5zdglydGPNIzRwNv5JSeTvfZ/Qy2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssXZkk9aB4BD0zEVRqrCx8iih1KNcP1uuyt0i5yzrtVasaohs6Iy7M1Q4w2dJtBXh/6a844fbKLwnKeMUQzR5HN1JBgezpI0ENR9t7xjiEBCa/VVK5x+3DgpT+RVw3a6ku2mnZ1qXOHSKlvLF5/l4jmDISsri+6HYSKpy9nvIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LdjFUTiu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBvEqW025841;
	Wed, 11 Dec 2024 18:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tbLHFR
	PDkwEfVtwHNEpSw/kwG8L4VWUBxBNMVuE96VA=; b=LdjFUTiuXWUKZ6mM4O9XLG
	gmwtrZbGjjVytZHNRMRohvR+Zfz8GsPFggEzvHP/gTlainJ2H1QGiXNv2u/JS1+3
	iWO64eJk1mc4ja/LBD2oaNu7RX6lRoqxzD4rUgpVPpm1OQCKWfr1Dh4+fp8AJ2gb
	TbOcZaXlMhBN9A43H8/KusFR9nkye2v+/QMSEwqvTbLdwxxYWl1eWqQ2pl181gUJ
	H/zkbXgsbDS9UfREoXocjOQxsEIYLIiFlln04LZTjt96WYA2dOoJYwzJYiY9Kdop
	2261Lu8US03fyDY0VRbbDK5kAktE75WFB1wDiZsC2FDZi7bnnvC6/ytMx/BsdZ/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqej7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 18:54:51 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBIspac005666;
	Wed, 11 Dec 2024 18:54:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqej7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 18:54:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHIF9B017421;
	Wed, 11 Dec 2024 18:54:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1u0qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 18:54:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBIskpJ62456262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 18:54:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D37E220043;
	Wed, 11 Dec 2024 18:54:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC09520040;
	Wed, 11 Dec 2024 18:54:45 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.81.50])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 11 Dec 2024 18:54:45 +0000 (GMT)
Date: Wed, 11 Dec 2024 19:54:40 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dust Li
 <dust.li@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped
 ipv6 addr client for smc-r v2
Message-ID: <20241211195440.54b37a79.pasic@linux.ibm.com>
In-Reply-To: <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
	<20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
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
X-Proofpoint-ORIG-GUID: ojddAGxzXGN6xT6MqxVDlPPu-LDffvjO
X-Proofpoint-GUID: bIA3QC9xMxVzuWVB8X2EzXkTV9ipzQ-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=639 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110133

On Wed, 11 Dec 2024 10:30:55 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> AF_INET6 is not supported for smc-r v2 client before, even if the
> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
> will fallback to tcp, especially for java applications running smc-r.
> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
> using real global ipv6 addr is still not supported yet.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Sorry for the late remark, but does this need a Fixes tag? I mean
my gut feeling is that this is a bugfix -- i.e. should have been
working from the get go -- and not a mere enhancement. No strong
opinions here.

Halil

