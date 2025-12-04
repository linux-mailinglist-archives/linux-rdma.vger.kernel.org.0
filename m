Return-Path: <linux-rdma+bounces-14884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4DCA3130
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12BF230231A1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3CB335568;
	Thu,  4 Dec 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g+hjvLbk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995823EA8B;
	Thu,  4 Dec 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841716; cv=none; b=G/WzGi3sjI0oKToCjRYeP6VMtUod19kjKveNhVk26dQWQCDLIN+YE3PP4Zkz5NEGVMsvXRA82kaVaKV9wdMVqvhvFIciR4Nmu5CUsAmivP7Y3aFAkZgUMUtzOly0kNR70uEcY4A1ANvhcjca88bKdIFgWKGn6U7e8bYu7CBLDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841716; c=relaxed/simple;
	bh=iV9twZbY3TkcSLCeoHXIgzu/v5cRoaIRH64xXhx5gnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bf7ttytADC2nJ4Xvk4p6cA/mlYp+FiTmC1c6Ox+at5ImE6UJ+WtwtuVJ7cGRJEaIWxbAR9rln1obABVRZ+Lmv2AMiHlK0gy7rgQhCEP5T9bR4qifWp2y/COtxQEj/cG+Lb5Ydx9eQBmTl2knE7e146l3s7VG5Nct7XpKTYMHddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g+hjvLbk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B43gdRW012481;
	Thu, 4 Dec 2025 09:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XOM4sv
	zLMvisUsoB3nUABMFovFe+7g2COBGqy+Qh/GA=; b=g+hjvLbkjdZaXSNlffG/vR
	BsY63Va+T5bXVupLwVO0PHmahnmyI6dk7fURxmSguC2mKe5Hakmuo+ojTp1f+yYo
	Kb4qerLbovogkOxsEG4KkvIgNiA3Y1hH2/y4e5pnazwcQECm0lL8Hk4BV6XZEd1R
	ACWOq7WSB+P3rZDCIBs2ErQNOZsHdmie78zAcBEy3rzXwyFidSusl0ZoebSFImE7
	uXh1VMQnBERZBgeu0YJgpco3DmYHQFgY00Vq/oCqstMZGtWD4yJW2hLCYZEy16MD
	uimYOC/3DdrMLc2qmuqp5eWzHjkw1KJOOzmls7qngSpitgrRu+WhxaLyxiPBCsyw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5q0nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:48:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B49XlEZ013734;
	Thu, 4 Dec 2025 09:48:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5q0nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:48:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B47VCBj019133;
	Thu, 4 Dec 2025 09:48:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy73kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 09:48:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B49mHMg20185402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 09:48:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F310B20043;
	Thu,  4 Dec 2025 09:48:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D36F20040;
	Thu,  4 Dec 2025 09:48:16 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 09:48:16 +0000 (GMT)
Message-ID: <502727b0ad4a9bc34afb421d465646248c69f7d4.camel@linux.ibm.com>
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
Date: Thu, 04 Dec 2025 10:48:16 +0100
In-Reply-To: <7ae1ae03-b62d-4c49-9718-f01ac8713872@nvidia.com>
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
	 <7ae1ae03-b62d-4c49-9718-f01ac8713872@nvidia.com>
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
X-Proofpoint-ORIG-GUID: JJSND5uVGuc-Yy0807UaM-DeeUylZ_QY
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=693158e6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=OJPCkwSMBkLYAhJ8JKsA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX41ZGyV7J5+Wa
 yw50YFUfl08xts+vRD7keIZwd5ly4a22CjXsuCBVslm6S6DHmiOvk3Wrt01ldNKZkZ+YkEVsEPO
 H6EJnVy288wsG85cnW956xgqN0OfyFUFTVDCtLgQmpQwTqSjoT3sTYIIi/U5mpE/xkAs4Vs/XUz
 X+wCF56x0Io+mXBsHHbLVo6HoetQWXPV9SafYH1PtZlAA3yB7BY6p0ljkDqbMNIESfP5G+KNzPa
 4yUBS5imfmvQ2qJi/E09twb7lHeu4sga/eK/bvnlKzO2WPpk93Z4kZ7kk5zTEwtNxIWX89f0fb1
 O9iLEieMmq6M0BATM6QjjWvp28McGhTDTFTGUTh/y/pmeKicWr8oh930BtC+aQRET7wErAvip8/
 rVMhPXdG1Pc1HLxzM30E1Q6VXBjZSg==
X-Proofpoint-GUID: HcopXBNN5_rUn80shxyC5RXmAxRB7BIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

On Wed, 2025-12-03 at 17:14 +0200, Moshe Shemesh wrote:
>=20
> On 12/2/2025 1:12 PM, Gerd Bayer wrote:
> >=20

  [ ... snip ... ]

> >=20
> > Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG la=
yer")
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>> ---
> > Hi Shay et al,
> >=20
>=20
> Hi Gerd,
>   I stepped on this bug recently too, without s390 and was about to=20
> submit same fix :) So as you wrote it is unrelated to Lukas' patches and=
=20
> this fix is correct.

Good to hear. I wonder if you could share how you got to run into this?

>=20
> >=20
> > I've spotted two additional places where the devcom reference is not
> > cleared after calling mlx5_devcom_unregister_component() in
> > drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
> > addressed with a patch, since I'm unclear about how to test these
> > paths.
>=20
> As for the other cases, we had the patch 664f76be38a1 ("net/mlx5: Fix=20
> IPsec cleanup over MPV device") and two other cases on shared clock and=
=20
> SD but I don't see any flow the shared clock or SD can fail,=20
> specifically mlx5_sd_cleanup() checks sd pointer at beginning of the=20
> function and nullify it right after sd_unregister() that free devcom.

I didn't locate any calls to mxl5_devcom_unregister_component() in
"shared clock" - is that not yet upstream?

Regarding SD, I follow that sd_cleanup() is followed immediately after
sd_unregister() and does the clean-up. One path remains uncovered
though: The error exit at
https://elixir.bootlin.com/linux/v6.18/source/drivers/net/ethernet/mellanox=
/mlx5/core/lib/sd.c#L265

Not sure, how likely that is...

Thanks,
Gerd

