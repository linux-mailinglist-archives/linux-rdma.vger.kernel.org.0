Return-Path: <linux-rdma+bounces-6022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA59D0B2E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2024 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52CBB219E4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928C1547E8;
	Mon, 18 Nov 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qiwcj9hr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F423A9;
	Mon, 18 Nov 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919599; cv=none; b=sdGggm3Up77p3sKD0XxEYNRFTlyGleofhFfyOsvX1+XeUVmVKByqtyIx2JVMQWa+wi63NLYkgta1uThkwYaBdxOp2lQkdhn1o36UA6Igur0Y9RFk3vqmefaE3HzZa9/TCqP6HlkwbTySJAj2r84/Y79omn/p6J3viOXhwkZAKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919599; c=relaxed/simple;
	bh=sMCWvKB7WkMax+URJGEcDgswx+LT/PidQgFP62KmMEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6bMBecHSgs+N+iofBwa4mZa6IRa5En6kHLGw0ycyUD5DFtfDqTIjidwTPtPIBbjMS1UtnATjwKC/9UEjSgjXqXtDn/kz+TBgR+iM1NM+ZRTSt6KNr4Tca97h9FHt/JRMxEGlZUbwx6e39EtayleT8VFW9JIRfNTA66wtbmF7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qiwcj9hr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1XUfm002666;
	Mon, 18 Nov 2024 08:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kekD6b
	px5PSVlj02oWh1qCXrsMNq8i3soFV5V/stK+Y=; b=Qiwcj9hrxaBUfPNe0e6n98
	oohk2hID97IXTJaSv958RHIluuqB93BAUqJDAGWsu/ptP82ECBXGCKVusX9jtJig
	0OOxmWGacDq1M6ZLMvuFvwVRSoqGe3i3KDUcqfQnxErZZdWrtXWrJXTPBdvGsZsM
	/ihUmVhXb+UHVYXeqkruFGK6PY29luAU8+mkwxA6aocyypq915KJGQZKPHIVhfvQ
	rJlirUFq1xvPy/j0Jwh27m/E4agMua02RyjZK2DjiIV6iyupz3xBOlaoFu2cHM1y
	AVwWZCNl0vXtBcAQvTK0N111va/cXnFrGTIpzi1MKrANGQ4BjudRRjaW8eo3PNxw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20r3tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 08:46:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AI8kY1B004109;
	Mon, 18 Nov 2024 08:46:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20r3tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 08:46:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI3U5Mi012123;
	Mon, 18 Nov 2024 08:46:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjj6va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 08:46:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AI8kTKp57541084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 08:46:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6382004B;
	Mon, 18 Nov 2024 08:46:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD07D20043;
	Mon, 18 Nov 2024 08:46:28 +0000 (GMT)
Received: from [9.171.68.3] (unknown [9.171.68.3])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2024 08:46:28 +0000 (GMT)
Message-ID: <bd8e196839281fd324721650c5974db35b7990ec.camel@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: Run patches also by RDMA ML
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-kernel@vger.kernel.org
Date: Mon, 18 Nov 2024 09:46:28 +0100
In-Reply-To: <20241117100156.GA28954@unreal>
References: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>
	 <20241117100156.GA28954@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e4S5HiYg4CSEK4rcWnjIw9htUagIIPmv
X-Proofpoint-GUID: Ut3Vn0GMU5dT5deJG9o1G3B4ot23WnUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180070

On Sun, 2024-11-17 at 12:01 +0200, Leon Romanovsky wrote:
> On Fri, Nov 15, 2024 at 06:44:57PM +0100, Gerd Bayer wrote:
> > Commits for the SMC protocol usually get carried through the netdev
> > mailing list. Some portions use InfiniBand verbs that are discussed on
> > the RDMA mailing list. So run patches by that list too to increase the
> > likelihood that all interested parties can see them.
> >=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 32d157621b44fb919307e865e2481ab564eb17df..16024268b5fc1feb6c0d01e=
ab3048bd9255d0bf9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20943,6 +20943,7 @@ M:	Jan Karcher <jaka@linux.ibm.com>
> >  R:	D. Wythe <alibuda@linux.alibaba.com>
> >  R:	Tony Lu <tonylu@linux.alibaba.com>
> >  R:	Wen Gu <guwen@linux.alibaba.com>
> > +L:	linux-rdma@vger.kernel.org
> >  L:	linux-s390@vger.kernel.org
>=20

Hi Leon,

> Why don't we have netdev ML here too?

since all smc code resides in net/smc the filter tag F: net/ in
"NETWORKING [GENERAL]" provides that. My first internal draft contained
an explicit L: tag for the netdev ML, but I dropped it to avoid any
redundancy.

>=20
> Thanks

Hope this helps,
Gerd


