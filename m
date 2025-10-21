Return-Path: <linux-rdma+bounces-13956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A076FBF6874
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAAB3AF3D6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBEE3321C7;
	Tue, 21 Oct 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gO/vRsv0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D541C63;
	Tue, 21 Oct 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050856; cv=none; b=LTF5qwgcOh/qfb+zPEZGiu9Z3J7EC+gxXOhM4whRlpsnNtYuV2u2g9qrV7kzUqZ/ZQTSiYoQNoOGZvNV3UjKihthmYlqkXm+lnj8/OF5XLIie8LYaVFEH5NqhOi9n2jwOxseuGzujoQ1KAZQN5z8mO/3c+4OwRYV30fKwTENLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050856; c=relaxed/simple;
	bh=nEEOvwGFoaio4Z73CGBjuz3prJe6v2U2OEU9Gw76vck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A80zrp3ufXpTEod3NOGzg02DkTAdvBp4pn6W19t20k3eC4alIc7zKnbn14UMIkkV1l8HMzH1qw4uPcEj6YqiE/ZhixlR30RCUGp+Vhtz0B8dbQ1SsWvOO9dw+/m2/pdqoAoRXPpSEE6XKKvZdQB6TkSWaaA6Pve4Q/kSd+sZBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gO/vRsv0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBHPta020537;
	Tue, 21 Oct 2025 12:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iNqoZWgWQCEkxMVzM8LaPwhvDpeQuf
	fSX5XZC01i0U4=; b=gO/vRsv0omSRvgQzH7sx+eMm/phOoih4flIuG7vFSajX+W
	o4BeByI9aVn5O2kOaoHAqMLL53fns0Kb01pTVLxQyDN8mBy8gf2Te6jMAKfnwccV
	x9sAu/qk+XJ2li7Mbq2St3vaPM4hnrBM/cBE5MTncbc6ZGti1GqZtT49QrwGnOIO
	q3Ylc4fMCnkyc2emzqjxsbR+gQ44faBJH/kk+5JCFx4/hoZOxCDu8/h5Si4ZW7Xd
	kIWoyKyuZBijyV9i/byeGiG7p5q+JhHAoqMB/flfC0OORZt50VzpQQIWvHtXOMKx
	WpQWwiPJ4NVIy1eb3NIT7bODBwaKKYxqvcrK155g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ry0c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 12:47:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LB75kk014848;
	Tue, 21 Oct 2025 12:47:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s2x64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 12:47:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LClNHZ52691438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 12:47:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B521F20049;
	Tue, 21 Oct 2025 12:47:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DAF42004B;
	Tue, 21 Oct 2025 12:47:23 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Oct 2025 12:47:23 +0000 (GMT)
Date: Tue, 21 Oct 2025 14:47:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shay Drori <shayd@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] s390/pci: Avoid deadlock between PCI error recovery
 and mlx5 crdump
Message-ID: <20251021124721.26700C66-hca@linux.ibm.com>
References: <20251016-fix_pcirecov_master-v3-1-9fb7c7badd67@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-fix_pcirecov_master-v3-1-9fb7c7badd67@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GgtonA3OlxRBJyMjgLHOTIRQx53op6mp
X-Proofpoint-GUID: GgtonA3OlxRBJyMjgLHOTIRQx53op6mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1C1I5J+HsJCj
 b3GZ6Iodpf9a7J2sgPs8hW+vwGi2GreWltw9VkbmlEoxQwdbsrunOdjehNAB78/rFwRd0Fj4U3x
 Y9f4W9bkDOkRPYls7Pui5tnB2vLH9ePDPh3rl14U/qsrxTwpCrh+eyP4z0BjnmlRtKl9TxkoIy9
 +E03IdeY/VXQnAzUEVZWqOcfUm+OAzJ2cEB0cxC8Syu+P/HBWmrHkL209Z1E1UEdBWXjumTNLzY
 Ddzt+v+dXZMdxxSU182Ph/Rx3qmYwaVO/7zv5rhXrA4yjEe+yS/U/ltsqCICOjJ7BoPwnEwTmp/
 tooBXynap4Nn9It/wuYInZBUJbLiTvHVipQzOvISNgPDaFRMG+vz6mKHDfxfdigrmGsVpb4LmZC
 FIWJTGIpVlYbuxun1U7UPgvPjoLTmQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f780e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=lAFIM-5KWFqR7GMvSqoA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Thu, Oct 16, 2025 at 11:27:03AM +0200, Gerd Bayer wrote:
> Do not block PCI config accesses through pci_cfg_access_lock() when
> executing the s390 variant of PCI error recovery: Acquire just
> device_lock() instead of pci_dev_lock() as powerpc's EEH and
> generig PCI AER processing do.
> 
> During error recovery testing a pair of tasks was reported to be hung:
> 
> mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5553): health recovery flow aborted, PCI reads still not working
> INFO: task kmcheck:72 blocked for more than 122 seconds.
>       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
> Cc: stable@vger.kernel.org
> Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Hi Niklas, Shay, Jason,
> 
> by now I believe fixing this in s390/pci is the right way to go, since
> the other PCI error recovery implementations apparently don't require
> this strict blocking of accesses to the PCI config space.
>     
> Hi Alexander, Vasily, Heiko,
>     
> while I sent this to netdev since prior versions were discussed there,
> I assume this patch will go through the s390 tree, right?

Applied, thanks!

