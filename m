Return-Path: <linux-rdma+bounces-14900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A5CA6BE3
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Dec 2025 09:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0428E301E4D8
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Dec 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0D316907;
	Fri,  5 Dec 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0NiX5yV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641931AF1D;
	Fri,  5 Dec 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923061; cv=none; b=edyy3AkP2L+I4y4/1qvOHS21anetPIAn1tWqedBAenkTdaUnzMbc9pFs9bqcF6SzrMmZxeucvgHfjueistBa+HeEVgdYa4DOuK12pmqdYroE5+twaBTFJwtvG3NFsaXGQWnrc4B/uf7R7JyQqqCAkqftypY0X4Qq5zn+g6CBu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923061; c=relaxed/simple;
	bh=9vP47oLCw1RtzDds1FS7AFmXMKeCAIulIP1WYbkq2Oc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NM91RC3rVBYTyoXiFHdI2fyNiH5xrecGpmcpxL6JYAVpO6hh8sz694aAuD4oYL/HXEEnRnoj1nSRF/hkWKezZ1YXvvL2E2hs4OGoH+RvSzJLRs62Vudo00+mSVtLdIF+UjDZWF5BpyAAbc/LYEM59wma1W0BjxSJSx6g/wEM570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0NiX5yV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4N2E7S001393;
	Fri, 5 Dec 2025 08:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RhMstk
	u0nqy7N1IclbBOGtkEPP4UWjRAtuZ8gpeiK1Y=; b=F0NiX5yVJnaHEJkKDA1zxl
	XeYsR6oClxyG+pMD/gOBsS6mB+Wvx/DrJ/0/ZxtSGuz3860uWuwA8gjlfmEWyiQd
	rF6FkKWTsoNYk8SJycAZNYhQKO7ZyUxafip51V/Dtcm1WhEyqvL3swtUq9gWHf3V
	NZB/18DQxMAB5CIkV3YYoGkO3UD2Eg6ZW2o7E/WyDZbmTj2B5hL+OTvThxmxQm/s
	4DhnrCb830S1JIP8JLP/2ZUrsK0kN/HitgC6YUniIURE1/UrB3SkLOUzbZog+2Z0
	1SVZhlKr+dqzWn8AerY2XQziPIl3urBRonNP8r6UlgAHYWADOKhxd2IB4NXb9l7A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v404j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 08:23:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B58GECL017907;
	Fri, 5 Dec 2025 08:23:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v404g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 08:23:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B57X4f9010237;
	Fri, 5 Dec 2025 08:23:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnkm7q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 08:23:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B58NjYO19792332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 08:23:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB8220043;
	Fri,  5 Dec 2025 08:23:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563D520040;
	Fri,  5 Dec 2025 08:23:44 +0000 (GMT)
Received: from [9.87.132.26] (unknown [9.87.132.26])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 08:23:44 +0000 (GMT)
Message-ID: <ee27de5e81e4545d697a8c78b88e3590e8849817.camel@linux.ibm.com>
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky	 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Mark
 Bloch	 <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller"	 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski	 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory
 <shayd@nvidia.com>,
        Simon Horman <horms@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 05 Dec 2025 09:23:44 +0100
In-Reply-To: <1bef8fd9-e9b8-4184-98be-98d016df20d0@nvidia.com>
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
	 <7ae1ae03-b62d-4c49-9718-f01ac8713872@nvidia.com>
	 <502727b0ad4a9bc34afb421d465646248c69f7d4.camel@linux.ibm.com>
	 <1bef8fd9-e9b8-4184-98be-98d016df20d0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ntzkUzJrCDLvH1vmukWEsCOlq0HNJf1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX2Q28eqZi4Xa6
 6oSDXmNMvzheKPKgr7KrXjBrwzfp4Js2kzztjRGmBpKQou3ZEDDEzakBBGIYxLx55T+FyceWnDO
 hPUSJy/CfMeY8qKky6SaF52RnVGxdKPm/PqwlhTj5w6mHPAMqBJLSYvTpzybkHDH6Fay8cce7JF
 n45allhJKUs6N9lnZ48SErGexTRToV6IbklQ+AM8DSRQw6CLq32JWCYaT0br0Me2Nn94os4GPgO
 FCwTIBVzhhORKDz80cKQ67mR3heql5xVGIJtmGMFLh+8GwyyVLPxhYteEKh/rn/Ht/80QQHBhPC
 hwiDUtbes2hlVLI+Q/tEGhLKOOdHVVDh0oIwJtjkKl2cWWM7n9efkvxj3CQCrfRZOZnA17mSqXt
 5nLm9Hm4dTImx5zklHqwPmNlpmZV0A==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69329696 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=V3l9L5bX4ASNRFpQsxoA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: hWJND_K9tjRBx8p2s4M8FXMy3ZhA2tU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

On Thu, 2025-12-04 at 19:07 +0200, Moshe Shemesh wrote:
>=20
> On 12/4/2025 11:48 AM, Gerd Bayer wrote:
> >=20
> > On Wed, 2025-12-03 at 17:14 +0200, Moshe Shemesh wrote:
> > >=20
> > > On 12/2/2025 1:12 PM, Gerd Bayer wrote:
> > > >=20
> >=20
> >    [ ... snip ... ]
> >=20
> > > >=20
> > > > Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LA=
G layer")
> > > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > >=20
> > > Reviewed-by: Moshe Shemesh <moshe@nvidia.com>> ---
> > > > Hi Shay et al,
> > > >=20
> > >=20
> > > Hi Gerd,
> > >    I stepped on this bug recently too, without s390 and was about to
> > > submit same fix :) So as you wrote it is unrelated to Lukas' patches =
and
> > > this fix is correct.
> >=20
> > Good to hear. I wonder if you could share how you got to run into this?
> >=20
>=20
> mlx5_unload_one() can be called from few flows.
> Even that it is always called with devlink lock, serial of=20
> mlx5_unload_one() twice caused it. I got it on fw_reset and shutdown. I=
=20
> I will submit also a patch for calling mlx5_drain_fw_reset() on shutdown=
=20
> soon.

I agree, serialization through the devlink lock does not help if
mlx5_unload_one() does not clean up all the references.

>=20
> > >=20
> > > >=20
> > > > I've spotted two additional places where the devcom reference is no=
t
> > > > cleared after calling mlx5_devcom_unregister_component() in
> > > > drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
> > > > addressed with a patch, since I'm unclear about how to test these
> > > > paths.
> > >=20
> > > As for the other cases, we had the patch 664f76be38a1 ("net/mlx5: Fix
> > > IPsec cleanup over MPV device") and two other cases on shared clock a=
nd
> > > SD but I don't see any flow the shared clock or SD can fail,
> > > specifically mlx5_sd_cleanup() checks sd pointer at beginning of the
> > > function and nullify it right after sd_unregister() that free devcom.
> >=20
> > I didn't locate any calls to mxl5_devcom_unregister_component() in
> > "shared clock" - is that not yet upstream?
>=20
> mlx5_shared_clock_unregister() in=20
> drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c

Hah - my fault! I was searching through the indexer's parameterized
cross-references, and w/o CONFIG_PTP_1588_CLOCK that file was excluded.

>=20
> >=20
> > Regarding SD, I follow that sd_cleanup() is followed immediately after
> > sd_unregister() and does the clean-up. One path remains uncovered
> > though: The error exit at
> > https://elixir.bootlin.com/linux/v6.18/source/drivers/net/ethernet/mell=
anox/mlx5/core/lib/sd.c#L265
> >=20
> > Not sure, how likely that is...
>=20
> It comes on error flow but after successful=20
> mlx5_devcom_register_component() in sd_register(), and that error leads=
=20
> to error flow in mlx5_sd_init(), which calls sd_cleanup() too.
>=20
> >=20
> > Thanks,
> > Gerd

Thanks for you explanations,
Gerd

