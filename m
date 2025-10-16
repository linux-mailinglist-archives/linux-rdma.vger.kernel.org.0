Return-Path: <linux-rdma+bounces-13882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F439BE2304
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 10:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1FD19A62E8
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77830B531;
	Thu, 16 Oct 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="blksfxaI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81063054F6;
	Thu, 16 Oct 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604021; cv=none; b=GJUYJZE1p4zynBBm92MXmCq+NUogfG37PuS0V4pbdrXIQf6FQD4hCNoJ01QuE0A9yeBkodPVCWlq8vvq2J3Vec3Q+7v8FfbHlEjGIP1vpRs7qJD9C8kpNlkZontH7tZdn5p4t5h8Nk5u4gRHlBizYbps5VG8ySDrn2vuB5WFeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604021; c=relaxed/simple;
	bh=3AWrDtmV1JGxPTVWPOgARlJPPLjkXwSKEbROH0L2i+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gflWBAlTZLKQP/UHPWcL+IM8Y7yvz3vF91PXLE1wTcRL9j6R/9s83fPTZnsd/orAF5NX1Uqhifq9c8Bc6kmeJ1Eonwd8Tx3TDS+yOtuNomNqm1IIOiEBJisMBSb1ZAqrnenS9bkQS0scAc5Rmm5DmWzOwSr+VgdLR5y40vZUaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=blksfxaI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6Vtst023503;
	Thu, 16 Oct 2025 08:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3AWrDt
	mV1JGxPTVWPOgARlJPPLjkXwSKEbROH0L2i+Q=; b=blksfxaInlRDg2OhbPedPA
	zj4DZT4v/nHljm4QgW+sLzkpPMA8jnDs5K4/B31TCEH4BYOPDMljxZ7jyc4IK22d
	x3dL10KHGHlDdp++SBGxw0/rBSKDUc80FG560jcHgGMP+8/fDM+Y4WHmN1fic3QH
	bU/4fNuczwo7cOMmcgpXAGifgpZhu7neU4DjjoG5V1VsNGrwcVlPLgW2ps3FR2ul
	mDVMWxcLQPM++Vng//nIkIVDv+toIzUNA0MQlbhEwfleGM1iMfhw6gPKJUjlJcFS
	LNmat/E7WsxLebN3dWq5Iq+c/6CtX4GJX3dIiZ09QeQwGmrkLC1k2oIVA2aiAs3Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpk95y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 08:40:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G649MZ003663;
	Thu, 16 Oct 2025 08:40:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy4v4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 08:40:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59G8e7uq55116284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 08:40:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC21020140;
	Thu, 16 Oct 2025 08:40:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DBD420146;
	Thu, 16 Oct 2025 08:40:07 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 08:40:07 +0000 (GMT)
Message-ID: <ba6bf792162213fd4a1085b1c157e3c5e4996133.camel@linux.ibm.com>
Subject: Re: [PATCH v2] s390/pci: Avoid deadlock between PCI error recovery
 and mlx5 crdump
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer	
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shay Drori	 <shayd@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky	 <leon@kernel.org>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Pierre
 Morel <pmorel@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Date: Thu, 16 Oct 2025 10:40:07 +0200
In-Reply-To: <358e3a7a1e735d5b1e761cf159db8ae735a9578d.camel@linux.ibm.com>
References: <20251015-fix_pcirecov_master-v2-1-e07962fe9558@linux.ibm.com>
	 <358e3a7a1e735d5b1e761cf159db8ae735a9578d.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QDsrJC5RMRKIqG9CaXi5okcG_yOi1Vcy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfX4ltVL7ge9Vu6
 iyOzSkTXhUzBNEJ2+AzNnZ5F4ekwsIQPhMliNTQCX/1AzL+ar6ivA8bzC9AT7Hh0GnY4ayeFXCu
 0GcxjTamNUqfImLXtpjRpafCzBc5NvEBJ9e3ayzL8MnWqwcO/1pWpNN4yrx7FS9BCZhdOhwBSUg
 Qpi2H4wyVzlhBgpWbnCvYxdkPElncrSPEPJvPjUfpotNjx4FO8agTumdjZsshLuonQPfvrnXyH5
 hLxpVYchlN8t2tSs4IBLfJTewBC7NJGtgwEISX2zT3ODYxcUjiAeEvdyVIAI7UADDB9TYqj/UVT
 SZSONB9bYtHtiZUvYR7v3hpBrXlhh2qpWOHPWCh9v0HlOBUuTzWAbv9TqHwQUyAODj1yHvlVXov
 vMNqbjz1ZlsB44v7n4Xv01UKL6F5LA==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f0af6e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=97ZeUEOCl0Sx5TDpsusA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QDsrJC5RMRKIqG9CaXi5okcG_yOi1Vcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125

On Wed, 2025-10-15 at 16:10 +0200, Niklas Schnelle wrote:
> On Wed, 2025-10-15 at 13:05 +0200, Gerd Bayer wrote:
> > Do not block PCI config accesses through pci_cfg_access_lock() when
> > executing the s390 variant of PCI error recovery: Acquire just
> > device_lock() instead of pci_dev_lock() as powerpc's EEH and
> > generig PCI AER processing do.
> >=20

[... snip ...]

>=20
> Code-wise this looks good to me and I've confirmed that EEH and AER
> indeed only use the device_lock() and I don't see a reason why that
> shouldn't be enough for us too if it is enough for them. I think I
> just
> picked pci_dev_lock() because it seemed fitting but it probably was
> too
> big a hammer.
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

I'll send around a v3 with your suggested changes to the commit message
included.

Thanks for the review,
Gerd

