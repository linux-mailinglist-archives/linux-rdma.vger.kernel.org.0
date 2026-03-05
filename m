Return-Path: <linux-rdma+bounces-17517-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFzyCKlVqWli5gAAu9opvQ
	(envelope-from <linux-rdma+bounces-17517-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:06:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9D20F5C9
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1572C3028EA3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A5737BE8B;
	Thu,  5 Mar 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HAnZVrcP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD90347FC3;
	Thu,  5 Mar 2026 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705025; cv=none; b=ad3nlXNEB0YxkQWqV2KpXEDn/LuKbSOwbEL1vuMityZZ3CwNskULmfl6pAl/YrfL2/wPtfSYwNlC4qCVJw5iRJmyXAZiUQBFyBQ5CKmTm0ThIxp6F/J9XdZnrK/u48cmS4p/gHoWmsTkKCZIHpwpK5jUka0uu46ed76OduaDn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705025; c=relaxed/simple;
	bh=TWlYUc7mRNr9CBnHv0bzv/zBCU20gFcmj87ErRbQvKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsHK9B5tKEHGtKt8/OK3AJt4euP6rvo4nwxBv9iXTS8VQHk6aYXKGe/paMi/z0z2ubmvyDAcufM0vRo2wqe6wxeWzdd+3Z9KhDnN8aCp4xaHgITMSxfHWV0Pqex44SL0aM8VO+aJi4oDoaauSYX+lxq0g9eU2d61JUC4IZHe7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HAnZVrcP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259YAgQ674109;
	Thu, 5 Mar 2026 10:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RioBjd
	ZmCiggAVbnBuh806rY5aSJDVeG0sEVQPcCLDs=; b=HAnZVrcPTbkU1RDV0tRsw3
	Rk5suQyKsbkurrXvLMVLYFueCA9KGMhF9+XQAX7KvWEzZ7xD+RbaIufTRMXVKmYS
	y7fy9WVl4ndDqkRDXAcOft0Z0Xpf/r5ZCefSmun3iHLPaLFL7XmeQQBseEHGLqOF
	yA4nkB/Bia/ltQxx753g7U+XdDQCoXeNqq17VYFO9Lq34EbJZGXkJD7dti8YhUHo
	C7KgDVCuEheS3p/L5ArKTfdbezTThnGOvolD8r8GchKPJfVtaF7x/6Cy+GzmlNvM
	sL0oOZCQtfJgdwnC6cNYLfrVq0iCgj4oG3FIQsJLTIy+L5zuxHBfCzTrt879fyGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjb60h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 10:03:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62592oWZ016408;
	Thu, 5 Mar 2026 10:03:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpnas2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 10:03:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625A3RB946399766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 10:03:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC1020076;
	Thu,  5 Mar 2026 10:03:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F40C2005A;
	Thu,  5 Mar 2026 10:03:27 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2026 10:03:27 +0000 (GMT)
Message-ID: <f679f226162e1f987053cf0c088268398287200a.camel@linux.ibm.com>
Subject: Re: [PATCH net-next] net/mlx5: Allow asynchronous probe
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>,
        Saeed Mahameed
 <saeedm@nvidia.com>,
        Leon Romanovsky	 <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>,
        Mark Bloch	 <mbloch@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller"	 <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter	
 <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Alexandra
 Winter	 <wintera@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Thu, 05 Mar 2026 11:03:26 +0100
In-Reply-To: <d6fcf417-87b1-4bbe-9ec1-cabb2b2ed1a6@gmail.com>
References: <20260303-parprobe_mlx5-v1-1-18194f2a1a3a@linux.ibm.com>
	 <d6fcf417-87b1-4bbe-9ec1-cabb2b2ed1a6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a954f5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=H7XoTaWE-anSZDuJziMA:9 a=QEXdDO2ut3YA:10
 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3NyBTYWx0ZWRfXwIN8kTYLiooy
 18/J/NWXicqUTPqvueNfxEr1OBC1EVWUp7NmWT778BUm4kffs1xFfysvP3JyvLZaQnXZJ14VBPW
 I3XR2wO+V70JllWsNKyLLhL6nv8ii5NWJPcBfz/u8C3AvTAbicjWKM2ZxSr8d6mww1PbOcncEuc
 8YbHzD2WOo5kHskqoqIZa7B0auC5j9wQ0lMzTdk4IuqMOdlh+Pv8rV4RHl73Msx3jNUe4Wt04FP
 a3/YhpNwq115WWNCDo04IJFuUhL3dDfg1vZmDZYtmZ1WmD+fBFRJh7U+460OLK4nSnuR5+Vgsko
 kOaaEnu6iGcY/yHICTMe7YyapY2eFBGHwhhEZdO1SioV0RhOr8GoKjDI36NK2yJx/kzBJRkdSkJ
 r8aTr+D4P4MuSki0HaPVrG+9v3u8FYqxdXSQgs6yg/scqM+57GDTXHk42qD+PiCc4fDap4Sw54B
 sWXlDyHfwdG/xQVBr3w==
X-Proofpoint-GUID: vesfvqm0HlLXEPtlktGrblPjM5KyKIwm
X-Proofpoint-ORIG-GUID: k0I49wQH8nF47e57fUCv6Tt-riC-HUtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050077
X-Rspamd-Queue-Id: C2D9D20F5C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17517-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Thu, 2026-03-05 at 09:56 +0200, Tariq Toukan wrote:
>=20
> On 03/03/2026 12:33, Gerd Bayer wrote:
> > Announce that mlx5_core supports asynchronous probing.
> >=20
>=20
> Hi Gerd,
> Interesting patch.
>=20
> > Tests on s390 - where VFs can show up isolated from their PF in OS
> > instances - showed symptoms of "mlx5_core: probe of 00e7:00:00.0 failed
> > with error -12" when booting a system with a large number (> 250) of
> > Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
> > (15b3:101e) PCI functions.
> >=20
> > Turns out that this is due to systemd-udev's time-out supervision of
> > "modprobe" killing the sequential initialization of additional function=
s
> > if probing exceeds a default of 180 seconds.
> >=20
> > According to [1] device drivers could (slow ones should!) opt-in to hav=
e
> > their probe step being executed asynchronously - and interleaved. With
> > the mlx5_core device driver announcing PROBE_PREFER_ASYNCHRONOUS as
> > proposed by this patch, we've measured 275 VFs being probed successfull=
y
> > in about 60 seconds.
> >=20
>=20
> Nice.
>=20
> > [1] https://www.kernel.org/doc/html/latest/driver-api/infrastructure.ht=
ml
> >=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> > Hi all,
> >=20
> > this patch helps to speed up boot times when there are a large numbers
> > of Mellanox/NVidia VFs in a configuration. Although we've seens real
> > issues, I'm hesitating to declare this a fix of commit 9603b61de1ee
> > ("mlx5: Move pci device handling from mlx5_ib to mlx5_core") primarily
> > because the concept of asynchronous probing with commit 765230b5f084
> > ("driver-core: add asynchronous probing support for drivers") was
> > introduced only later.
> >=20
> > Thanks,
> > Gerd Bayer
> > ---
>=20
> This is an interesting problem, and the proposed solution looks=20
> reasonable. That said, this is a very sensitive area and there may still=
=20
> be hidden assumptions or corner cases we haven't considered. This needs=
=20
> thorough testing across a wide range of real-world scenarios and=20
> different system topologies before we can be confident in it.

I agree that a change like this might expose concurrency issues lurking
both in the driver instance controlling the VFs and the driver instance
running the PF. I have to admit, that my testing so far was primarily
focused on making large configurations work rather than "regression
tests" with "household configurations" of 1..~10 VFs. I'll discuss in-
house how we can increase coverage as well.

>=20
> We'll take this for testing and report back once we have results.

Thank you for your consideration.

>=20
> BTW, as you probably know, a possible workaround is to increase the=20
> systemd-udev timeout.
> What timeout is required for it to succeed without this change?

Yes, I did some very limited experiments with that, but I was measuring
the uninterruptible duration of initializing a single VF instance to be
close to one second. That would mean that for the 275 VFs I'd have to
up the time-out value from 180 to ~300 seconds. That would be ~5
minutes of boot latency (worst case)...=20

>=20
> >   drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/main.c
> > index fdc3ba20912e4fbc53c65825c62e868996eff56d..b53fc3f2566acf5a07cb8df=
649124c4a87f3e043 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > @@ -2306,6 +2306,9 @@ static struct pci_driver mlx5_core_driver =3D {
> >   	.sriov_configure   =3D mlx5_core_sriov_configure,
> >   	.sriov_get_vf_total_msix =3D mlx5_sriov_get_vf_total_msix,
> >   	.sriov_set_msix_vec_count =3D mlx5_core_sriov_set_msix_vec_count,
> > +	.driver		=3D {
> > +		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
> > +	}
> >   };
> >  =20
> >   /**
> >=20
> > ---
> > base-commit: c69855ada28656fdd7e197b6e24cd40a04fe14d3
> > change-id: 20260303-parprobe_mlx5-d10d2a746d3a
> >=20
> > Best regards,

Thank you,
Gerd

