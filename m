Return-Path: <linux-rdma+bounces-6499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B19EFF5A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA66161A70
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A391DE2C1;
	Thu, 12 Dec 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/NH4cj/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5372F2F;
	Thu, 12 Dec 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042566; cv=none; b=NGxIQ7j1Fzo0WuiurIEB+hWDRYaTHM55CShrz2z9jIP7QhXcObrLSwxQIogFzvPl8ueO9emJFC8ghkg86bR6XO1EhDNbT3iV3/2J28wLSsc4ael5arffr/YAAggPRFPV6f0VVt/iZWPuv9Rd1bLEBRoItDc4EkFupGcAb9pfppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042566; c=relaxed/simple;
	bh=hgLL+j7viOzNdukkTMbjWUP+M01pNEnqmEe4gbYyxUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldEdFliAYtEX6s0BA0/TnEtlZ8zF6D4spYxy57eU8lqf1ReCHQMs8wxE+jJ0Krr+G9Y381l6itQhRlWvi1GcrAuhC2s2yyCfmdDHjQGdkR0qff709Kpx6z4nOIR4MtSTCjV/iA5J/UqSs9zuPFicLI577CHbKj3fKcMgsOJrUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/NH4cj/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCEvO6O029697;
	Thu, 12 Dec 2024 22:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=um4mQb
	9dLa/+1MlyiZ6x7Q5vlgiEUQiPyor2NdHS6Mw=; b=h/NH4cj/HBj4VNSbeHFobY
	Tn8NL49lwgz91hCADluFQU0ipc1mbzvNjCccBGRuSbSlPpo87xcB8E+N3tWrBVPp
	5XF6on22eKMFk6EbD1ZQfRjrq5p8JjRNL3noirXYm4urw61DcawVMRdpEZ9JmH91
	9plouJYD42oCm82zOREWpopyOoICNUp1ZFq/9wgLQ8Apwz/YbBBXtcgLx6ZTna8n
	+flXwdyKuWoymDiFqGj2nqtyx4Iss8Z588/YEV8ZTgT+Xf5Aq/4TXkUCPr3fpAUz
	KkV0rglyyDmfEZIxqqNTCoZv+InI1bxo/HJfGruyTeWQf8BO4XnMOrRFbK44++Ag
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjwsxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 22:29:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCMQegO023311;
	Thu, 12 Dec 2024 22:29:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjwsxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 22:29:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCIdYHk007776;
	Thu, 12 Dec 2024 22:29:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11vake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 22:29:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCMTDbi34668920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 22:29:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611B12004D;
	Thu, 12 Dec 2024 22:29:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 769DA20040;
	Thu, 12 Dec 2024 22:29:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.23.191])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 12 Dec 2024 22:29:12 +0000 (GMT)
Date: Thu, 12 Dec 2024 23:29:10 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>,
        Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped
 ipv6 addr client for smc-r v2
Message-ID: <20241212232910.65825906.pasic@linux.ibm.com>
In-Reply-To: <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
	<20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
	<20241211195440.54b37a79.pasic@linux.ibm.com>
	<c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
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
X-Proofpoint-GUID: P6yKMqRStoWD_On5XprJpk05iFBG6s_1
X-Proofpoint-ORIG-GUID: hfe_P7LkdbcQXYWPJZoa96yFH1LLMWcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=726
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120162

On Thu, 12 Dec 2024 13:49:29 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> > Sorry for the late remark, but does this need a Fixes tag? I mean
> > my gut feeling is that this is a bugfix -- i.e. should have been
> > working from the get go -- and not a mere enhancement. No strong
> > opinions here.  
> 
> FTR: my take is this is really a new feature, as the ipv6 support for
> missing from the smc-r v2 introduction and sub-system maintainers
> already implicitly agreed on that via RB tags.

Works with me! Thanks!

Regards,
Halil

