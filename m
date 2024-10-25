Return-Path: <linux-rdma+bounces-5517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030A9AFD60
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26661C21038
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A71C878E;
	Fri, 25 Oct 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RV0bibb/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA21D4149;
	Fri, 25 Oct 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846704; cv=none; b=YR7RVXwkdU+P4rwz/gThU1ld8VZ3MBxWY+5/5v77cFAHj+yPD34hzkPGCYI8szVMwgmOFIAizCeNw5ArfWhFgm3an2225HOobOGnWe1BgeKjOeygStTimYGnF6Zk7Mp2O8nz/PqWcIUiBsam3jKkjteZqexdTGHSdG8t6EQQIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846704; c=relaxed/simple;
	bh=AeW+o/f9NYE9ekcoFPDFqxlQ9UwHYaVBT4bYruRdyCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDNuUym67SagMazQRvTYWTNNd3CTrIozNZkaqeUV1lTRyD2vnrnIZwbOXG9MzZwZUei8KbKlEaD8hq2ffBLR5I3lhvvjdrIJ5FeOYDYbw5tC4h51Ay8uFEGf7qk8y/ZlDwnfr5lrDv5veMNpCBOiTddG/Xa2vLH5MznGDythuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RV0bibb/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P37Von027510;
	Fri, 25 Oct 2024 08:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jX0jSV
	EriRCS5xfstK1lXTLo+F5tZFq+q6ts4KjMPPE=; b=RV0bibb/+tt557O54LYyVU
	smwDlkseTek1pBiuSJuP2pOVr0cDIFqlg7cJSiDHHJZyvKwEM3rvAGlo2OxwzT6U
	e4tkntH7jjftKYBKd34o+PCFRaX6U4TzHUd8CQLZMckNUtOsfGcvPNYcPfb0mdR4
	6Mw4thnHYh1R/eukUqX8hNrxhyg/Y/Y/hIJ9fixKquvaHJ0KiLuWI6w3M6ClZ8zS
	EdaxGSvyRKs2jyK0FaMQjsheEB66lhC/+RpWOaumb/adV9BHxjznGDdqdyc+7Jb2
	hD+l+LwxdWvMeHWiAJspbB2M50DVEkmQtzm5QR9NJHyrxZMMcnWMdzqE/bySoxYg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf50t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 08:58:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P8wF3p023302;
	Fri, 25 Oct 2024 08:58:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf50r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 08:58:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P6N3o7008769;
	Fri, 25 Oct 2024 08:57:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkavuh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 08:57:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49P8vmLb31130040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 08:57:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DA4120043;
	Fri, 25 Oct 2024 08:57:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 435B520040;
	Fri, 25 Oct 2024 08:57:47 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.11.253])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 25 Oct 2024 08:57:47 +0000 (GMT)
Date: Fri, 25 Oct 2024 10:57:45 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Wen Gu <guwen@linux.alibaba.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Jan Karcher
 <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
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
Message-ID: <20241025105745.332b8dc6.pasic@linux.ibm.com>
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
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
X-Proofpoint-GUID: nQLNtMopXz0-7mDYIbJyC1jpAHgm-aLw
X-Proofpoint-ORIG-GUID: NOjmmwRbKdBplwGlrg63A6r97hocyEpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=697
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250068

On Fri, 25 Oct 2024 09:23:55 +0200
Wenjia Zhang <wenjia@linux.ibm.com> wrote:

> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

