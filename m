Return-Path: <linux-rdma+bounces-14198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA54C2B98D
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 13:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B372E4EF9E9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A130ACF3;
	Mon,  3 Nov 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tpZA6tcQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED2151991;
	Mon,  3 Nov 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172210; cv=none; b=iWaX5mH+w7h5YclUpYZxcED9j/1tpFbzMgc+o0t8VXpADin+5KruBimK0wJRySFxDY1chXU7gqcG0WlWbZpmo04MLiQDy02ebzwHCBVfbIRn1HiKtc2d60c15urIwBXJ34QHmeVWsmb93Aik2s707MVSg5VstUEJ8Ey4G93Wt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172210; c=relaxed/simple;
	bh=MWje19xK/BNi/w3R0P48lIor/CzXFrLeBuO4v2zoANU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Twl2UFMTjYmn4kCOCg8KwqQGvKQw1q+MQ7OFOLVb5Z4RV1uUuwHomCP5/RKDxc8Q72l2oa5yvIalX4/y1O42Qn3ON9mFDz/1jnQSyjQMXIqOeqlxg+rWkn7re820pejDCbha2lISkK3Mn/j8HF+2aqYcqZbwRyaa2yUH7taEhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tpZA6tcQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2MujYG008806;
	Mon, 3 Nov 2025 12:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MWje19
	xK/BNi/w3R0P48lIor/CzXFrLeBuO4v2zoANU=; b=tpZA6tcQ8ckT+UqlC1FZPh
	FXS2cP0z3cUisL++wRs+C5AKreP1AqSJCeUqiBxCB3Ver+p12GLx37KcY28d9gvB
	is2UR2d50ogR1elzUnCRfEdQoT9jc03NPB6JOoikQVExNcGNfZxxJLNOS4J1ENII
	dUAc9WGYH1djWAS7lzIB2reZaUgEmPjQ1ylL4go3JGewtSzEGeALW3APs3v/9mAe
	WcQ0zdZ9McvfA9gOZiVS9HNDTRD2zTm2p4ayrc9WRPDQKznSPwhoPUsFyaYuIuH6
	N7kBNJxQ3aQDhNohJoeIa2y7cHNO3TbGXb5Eqa5yMCU1tkXdujvpIQvCWYLgK8HA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8pfma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 12:16:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A3BpXab015501;
	Mon, 3 Nov 2025 12:16:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8pfm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 12:16:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3A3Tm2025582;
	Mon, 3 Nov 2025 12:16:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsdqam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 12:16:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3CGfFf47448484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 12:16:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DE2520040;
	Mon,  3 Nov 2025 12:16:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE0C92004B;
	Mon,  3 Nov 2025 12:16:40 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 12:16:40 +0000 (GMT)
Message-ID: <9c7c4217171fb56c505dc90b8c73b2ce079207a9.camel@linux.ibm.com>
Subject: Re: Q: Usage of pci_enable_atomic_ops_to_root()
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt	
 <alexs@linux.ibm.com>,
        netdev <netdev@vger.kernel.org>,
        linux-rdma	
 <linux-rdma@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Gerd
 Bayer	 <gbayer@linux.ibm.com>
Date: Mon, 03 Nov 2025 13:16:40 +0100
In-Reply-To: <fbe34de16f5c0bf25a16f9819a57fdd81e5bb08c.camel@linux.ibm.com>
References: <fbe34de16f5c0bf25a16f9819a57fdd81e5bb08c.camel@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=69089d2e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=NhfhhuvIOumIP2zjjAQA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ZN17-7YZVGaLtNLVDUnB2OaiJz3xyAVx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfXy3E9mF+d+g66
 aEuwz09GHh5GnSbtWUsVsnLvDxGeqn2djLnEC2aTN5lQyKmCoR35KvH7DhiycCKqT1IcSjAko95
 DHQAoYMiEGEV8sVrg4Fbh6XZrSsxm4RnXc+LYJncLsrHom8ZIG6HyFlaLx2B9jxGlVLE1cH6dZ2
 KJ6eNKnH0ZvRZc03qI+DGpC8DCf0jpsmhjM4Rt/vF8tLKNyypGzZiGkFPqg0m871LpSvTec4No/
 iYnQcqqnp8rHUhbG/VWWoG6YYRMPv+0cfIOkWBd7XUQCCZdl1qT3XZQelk4EOlYbtCXtx96XxC5
 drskjcFxxRz93m371OxgfeN/YA8pla/hmPwgn04egz2zhVYI8MJkWpCu43o9hnsJJEsdSCvjLY6
 sVB0QSpDo0Xdn5AzHjKqcjehueZ3Tw==
X-Proofpoint-GUID: 3hC3jq9j6BMtjqmiq1P1VOSq5wwiUkex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

On Fri, 2025-10-24 at 19:18 +0200, Gerd Bayer wrote:
> Hi all,
>=20
> I stumbled over mlx5's usage of pci_enable_atomic_ops_to_root() at
>=20
> https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/net/ethernet/me=
llanox/mlx5/core/main.c#L937
>=20
> and was wondering if its repeated calls with the 3 available sizes gave
> it the intended result.
>=20
> I assume the intent was to enable requesting AtomicOps only if all
> three sizes 32/64/128-bit were supported at the root-complex. However,
> pci_enable_atomic_ops_to_root() would enable the request at the PCIe
> level, even if just 32-bit sized Ops was supported at the root-complex.

Looks like I might just send out an RFC patch for review by the
Mellanox/NVidia folks? Not sure if I can find a test-setup for this,
though...

> So I checked other users in the kernel and found an inconclusive
> picture:
> The AMD GPU that this was originally introduced for [0] checks for a
> combination of two sizes, while a few infiniband/ethernet and the vfio-
> pci driver do variations of sequential checks (potentially enabling
> requests that they don't want to)
>=20
> Now the PCIe Spec Rev. 7.0 has also a mixed bag. Section 6.15.3.1
> mandates for Root Ports:
>=20
> > If a Root Port implements any AtomicOp Completer capability for host
> > memory access, it must implement all 32-bit and 64-bit AtomicOp
> > Completer capabilities. Implementing 128-bit CAS Completer capability
> > is optional.
>=20
> While this is specific, marking the CAS Op Completions in the 128-bit
> variant optional, the Capability bits just specify 128-bit AtomicOps
> (all AtomicOps: FetchAdd, Swap, CAS). Strictly interpreted, this would
> require root port implementors to announce all-or-nothing of 32/64/128-
> bit AtomicOps - which kind of makes the size-granularity of the
> capability bits useless - and leave the endpoint device (and its
> driver) attempting to use 128-bit CAS in the dark...

I guess I need to ask the folks at PCI SIG?

> [0]: https://lore.kernel.org/linux-pci/1515113100-4718-1-git-send-email-F=
elix.Kuehling@amd.com/
>=20
> Can anybody shed some light on this?
> Thank you,
> Gerd


