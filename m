Return-Path: <linux-rdma+bounces-13803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E4BC6119
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759FF19E2ABC
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E85C29B8D0;
	Wed,  8 Oct 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="loF5tc75"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463334BA37;
	Wed,  8 Oct 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942024; cv=none; b=heHhgcEsucL4Z/yn/S7k6DLJ4ynKWw0VhfBg0lZdmIWpLwCYV5YvIzqRZRLNCJp8L6KShfjRF32uxGH5FxBrjK3Cx7Tax+1OvDppvyed0gGjWZzsCkHzBG4sO0kvxI0NCJe8nFID30dESR9yCa5MnsMMZNr/nmwXJ9rJACSmLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942024; c=relaxed/simple;
	bh=sUAOA/IBa+lkw44AFYiluGm/5g1Nqe7GtQYjOUL/0oE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1hNMMMZeoUrl2yf+/HbS/x+6DBzDKlVSip3MXMoh/efI01KcKt3oDbPx5l07zZnWxe3TeDIbJqT+wDM3ToK9Eer1GXSCzDQl9pRCiyjcBEpgSpkSfhRuAh0l8AXOEPF9xjc4i5/X08qlVf6mR+y4nQzD2Wa5RHgR3F9Mq+uNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=loF5tc75; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598ERYWF004103;
	Wed, 8 Oct 2025 16:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sUAOA/
	IBa+lkw44AFYiluGm/5g1Nqe7GtQYjOUL/0oE=; b=loF5tc75JjyZSHEazZg0UY
	uljJFCdm3+Fem3qrbc8w1OUi4J5FEpEYPCks6hxILnLdZR0di5eXRZ8KNh+8CzVO
	WC6gkuY4ob7k/gTZ0K6Zo09QCPMpYV6UH3eiJBHzGPYzbu5zyLmCaZ+ilUvrUUXu
	+L0CkvWFz4UpTlecIDTm6UDjAk70b4fIi4rh83WdHoCSwnALk3FXiF3hXx/6Vo/w
	KJRPVZCehY50ullJ6s3ks4INi40+c0tbg0yqV39B9FHsEmkl/kPKdeLx11584G0q
	a8L7GrGc0PkKhPza47pJCnw5OPn9fuPG6h4KUZN4FRm8xGnSFdTT7JILEyRkZGHw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93p9bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 16:46:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 598GivXH007354;
	Wed, 8 Oct 2025 16:46:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93p9bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 16:46:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598FMBjv021174;
	Wed, 8 Oct 2025 16:46:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1h72d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 16:46:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598GkkVw57541076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 16:46:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5F72004B;
	Wed,  8 Oct 2025 16:46:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 162FB20040;
	Wed,  8 Oct 2025 16:46:46 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 16:46:46 +0000 (GMT)
Message-ID: <3347624899623b430d62d94abcf870dac7354e0a.camel@linux.ibm.com>
Subject: Re: [PATCH net v2] net/mlx5: Avoid deadlock between PCI error
 recovery and health reporter
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky	 <leon@kernel.org>, Shay Drori <shayd@nvidia.com>,
        Mark
 Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni	 <pabeni@redhat.com>, Alex Vesker
 <valex@mellanox.com>,
        Feras Daoud	 <ferasda@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org
Date: Wed, 08 Oct 2025 18:46:45 +0200
In-Reply-To: <20251007162111.GA3604844@ziepe.ca>
References: <20251007144826.2825134-1-gbayer@linux.ibm.com>
	 <20251007162111.GA3604844@ziepe.ca>
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
X-Proofpoint-GUID: Phe3voxxbRgWCwOaE2LqipcgUurPzTL4
X-Proofpoint-ORIG-GUID: nodxo14OBXlt5oq5Mf0FZnrlSx_MN3Jk
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e69579 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=sWKEhP36mHoA:10
 a=8rYLgKHLPXpmBGOn9vIA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX2zqBAiGGyVq1
 1+x5aX+19fyFz4r2BIyMMIdnb+/fjuQz8ljwKjju9KDQHsxuGWEG69ZHWavV56rDaYi6gmQShPw
 E6K15JbobZuietunR6x/52bQyJ5bm3k2t3s5OCyHctlih5x7nSp9C9Bf7k6Sg7/Krrmx1FLZ3zG
 1goLuVTg6xVx7Ng5R6I2O8NgPMMAZt2RsB4Z8xFLTPw5qjcwQbTfOByR0slUEjtNRHcM43bveA3
 A04Oju+GlG1gJU8mbKbv2dQJFKB0/Y1K9LOmn9YBFibLySGx+cA32JUeLfJPTYZWR4X9xh2ZDIF
 /pEqBThN/lIvK1jQvdVXkBKT/ydwKq+Fk96esRxj0sb6i4ivHSXyT94k1LSFjca1iVx4dY7hhQV
 DnP1EQC5uyY0ZYUNBdC/XWmowpD3DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On Tue, 2025-10-07 at 13:21 -0300, Jason Gunthorpe wrote:
> On Tue, Oct 07, 2025 at 04:48:26PM +0200, Gerd Bayer wrote:
> > - task: kmcheck
> > =C2=A0 mlx5_unload_one() tries to acquire devlink lock while the PCI
> > error
> > =C2=A0 recovery code has set pdev->block_cfg_access by way of
> > =C2=A0 pci_cfg_access_lock()
>=20
> This seems wrong, arch code shouldn't invoke the driver's error
> handler while hodling pci_dev_lock().

Seeing how powerpc's EEH is also just acquiring the device_lock while
executing the PCI error recovery call-back, I'll be investigating that
route by "demoting" pci_dev_lock() to device_lock() (i.e. not including
the blockage of PCI config accesses)

Initial tests look promising, but I need to do more experimenting and
want to check the AER path in passing, too.

> Or at least if we do want to do this the locking should be documented
> and some lockdep map should be added to pci_cfg_access_lock() and the
> normal AER path..

This change of contract sounds a lot more intrusive to device drivers -
so I'm not actually pursuing this.

>=20
> Jason

Thanks, Gerd

