Return-Path: <linux-rdma+bounces-12663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1653FB203D6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82AB16D870
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108A21C190;
	Mon, 11 Aug 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nAVbP5DY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA972624;
	Mon, 11 Aug 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904914; cv=none; b=RDRyRLHZ62/FTTGQWvyR0Qleminn7e8dI5GYDhV+cPifEX5br91JxBvKsqXfsBobGTe2MeS8GuCwLVK1TVt/DmV6Qa8IgrGV19PT3PRDtqlIvT+5LHPyGSxx96kALJGMbAoN7CeiuKqAQ6B01bTsUQuCzzgauH+oNGC/IWovdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904914; c=relaxed/simple;
	bh=2ZwxylsB2Cwq/rvyoSTDwCTj2j1ikXNbgKvfQtzfiIM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Khr9OSXBMxkqFGqP15P20MZo4iXgf3w74WWu17fjrs2Lhr1izR0yRLtYtqaby2UCIJqxaDLJxe3BymYGrjT4OS4d/uCAHFYMambCnfKObSCQvDrBi0t3EKWCjNmTeWWn+/Rm1Vz2gv9/GhnX0rAQpkyrkKJNOC+N1grvA8ll6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nAVbP5DY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ALLNoK029952;
	Mon, 11 Aug 2025 09:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U9zuCk
	9a4CIQxDbpkwJyEPUlSTdQtCQi9qS3qt6IsBE=; b=nAVbP5DYod1gSp3wPYwypP
	pn1A0jycqfztbzTb+M9q3iXpzAfUi9Yu56MPE5Ehgdc3l/G++UwTjEA7XMrObiO4
	8RvS5pJIPHO8M+6wp+05xD2yikC4/9LQkpWc5rdXpiMKboRDMyZHhMeGraEB+AXX
	fOWLuR4ga9gE6o4JuFQaSfURE6M2BGaA0iHOs8A9/dRBJvQDl5atOxTzDxpqDRCy
	TNJP34dmomxwh/6uu2JFbFmJU5SVcP46Q7b+pKEIBjtdy8cnLUejnRSAcSqyLQck
	XLl7Msj5aNx+nsS+BiEUZE2SyFnh66HK7uP/FXBFu19Bmw3Fqq56UDVRvLW82iaQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwud0k4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:34:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B9YtHl004330;
	Mon, 11 Aug 2025 09:34:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwud0k4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:34:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57B6jXVD025654;
	Mon, 11 Aug 2025 09:34:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm50j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:34:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57B9Yoau23069100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 09:34:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D349020043;
	Mon, 11 Aug 2025 09:34:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3201420040;
	Mon, 11 Aug 2025 09:34:49 +0000 (GMT)
Received: from localhost (unknown [9.111.3.65])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 09:34:49 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 11:34:45 +0200
Message-Id: <DBZHV2Z3T4M5.1G8HW0HFP8GLO@linux.ibm.com>
Subject: Re: [RFC net-next 15/17] net/dibs: Move query_remote_gid() to
 dibs_dev_ops
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Alexandra Winter" <wintera@linux.ibm.com>,
        "David Miller"
 <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Andrew Lunn"
 <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        "Dust Li"
 <dust.li@linux.alibaba.com>,
        "Sidraya Jayagond" <sidraya@linux.ibm.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        "Julian Ruess"
 <julianr@linux.ibm.com>
Cc: <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        "Heiko Carstens"
 <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Thorsten Winkler" <twinkler@linux.ibm.com>,
        "Simon Horman"
 <horms@kernel.org>,
        "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
        "Tony Lu"
 <tonylu@linux.alibaba.com>,
        "Wen Gu" <guwen@linux.alibaba.com>,
        "Halil
 Pasic" <pasic@linux.ibm.com>, <linux-rdma@vger.kernel.org>
X-Mailer: aerc 0.20.1-89-g2ed71ec4c9b9
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-16-wintera@linux.ibm.com>
In-Reply-To: <20250806154122.3413330-16-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2MiBTYWx0ZWRfXywnBeQ0XHwDl
 hmuPWPtAAEM2SQixHHoQ5fsvDse7vTMzrC/2Q846CfxPP2CnGxab7FYurfgxDZFTdYAkpMa8nbQ
 UaHwjcM7y9bkK0hMxhbwVnq61eScEtIr0TrO068kGhLxF9WqJsqEt+YmoWd+Gg7FlUQLJ9kXkqR
 LKUEw/q2z34xEb53WsYg4q7jYQ66oabQyAf/p69Ex4y+SCSpH8KtxpkBXH2TRDndLmHw5nlJ+Gj
 dDuZ/u2qmlGMpYPIyQJP6YByWYSGxXAsepFcsYsTnSRhy52xAQET/FqLcBiciEgLt6ifpLh5H2d
 PGzA8Eu7NUD5rEJvj0c4z2cEMDhuI9eqyLFmcxCZtN5uXsGUArIGToLcxbe1MFQtE1UlJiUgwE7
 gHAWW9OW1RTSwIsmcN1ZgLt3qN7THRyjMsQSFrjDcySxuGOgBq0HbCt3nrP+PeuzuVdidjRM
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=6899b940 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=jCXx2w3Ciln4EzbrpMcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nzGxTHx6airBsFf8-a7MLiG6oquhhpt4
X-Proofpoint-ORIG-GUID: bAGj4ybGNeTeedoc1_sO0gOPQD2F6qwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110062

On Wed Aug 6, 2025 at 5:41 PM CEST, Alexandra Winter wrote:
> Provide the dibs_dev_ops->query_remote_gid() in ism and dibs_loopback
> dibs_devices. And call it in smc dibs_client.
>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  drivers/s390/net/ism_drv.c | 41 +++++++++++++++++---------------------
>  include/linux/dibs.h       | 14 +++++++++++++
>  include/net/smc.h          |  2 --
>  net/dibs/dibs_loopback.c   | 10 ++++++++++
>  net/smc/smc_ism.c          |  8 ++++++--
>  net/smc/smc_loopback.c     | 13 ------------
>  6 files changed, 48 insertions(+), 40 deletions(-)
>

-- snip --

> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
> index 10be10ae4660..d940411aa179 100644
> --- a/include/linux/dibs.h
> +++ b/include/linux/dibs.h
> @@ -133,6 +133,20 @@ struct dibs_dev_ops {
>  	 * Return: 2 byte dibs fabric id
>  	 */
>  	u16 (*get_fabric_id)(struct dibs_dev *dev);
> +	/**
> +	 * query_remote_gid()
> +	 * @dev: local dibs device
> +	 * @rgid: gid of remote dibs device
> +	 * @vid_valid: if zero, vid will be ignored;
> +	 *	       deprecated, ignored if device does not support vlan
> +	 * @vid: VLAN id; deprecated, ignored if device does not support vlan
> +	 *
> +	 * Query whether a remote dibs device is reachable via this local devic=
e
> +	 * and this vlan id.
> +	 * Return: 0 if remote gid is reachable.
> +	 */
> +	int (*query_remote_gid)(struct dibs_dev *dev, uuid_t *rgid,
> +				u32 vid_valid, u32 vid);

Shouldn't this be 'const uuid_t *rgid'?

-- snip --

Thanks,
Julian

