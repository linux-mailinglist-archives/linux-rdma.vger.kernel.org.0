Return-Path: <linux-rdma+bounces-1723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83908948FE
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 03:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379431F230B5
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA5DF71;
	Tue,  2 Apr 2024 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CTG48LGu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7FDDB1;
	Tue,  2 Apr 2024 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022590; cv=none; b=JqEuOyJfh9quP716unrbxc1DiY8w1VbG02P+RFLJ+6kv6BVBeG8s147PZBeQkKbBjMhiJNNP/TMZyIbLDyqou/VYKYK6O8UBGNlgwfONE9tcCKroRBf74z3Iw0mZALFbCv+e2PepDc6UZWP/u5w71VvyRWCfBaqCPSqrajFkTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022590; c=relaxed/simple;
	bh=xwgKT4QWg7PYY2MgtNiuW0lK0ZdOIRwkOV/Mdj/hbpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaBj/RViLPHyjaEnpn4EmM0e5/sZo8Q3gybN9aPH4TnMGOkabEP1pm6z0Im+a3+Xq95XU1aSS1uUVeT1AZiAjBbGN32aNEhlZ7P2cKS4FKDXCXjIXF8kUEiu4NdLfBjB4+NvZij/li5Tiz+LiCofDUQXUw4o3lPCPpBw/8z2BfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CTG48LGu; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431IKCQ9009659;
	Tue, 2 Apr 2024 01:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=L9IxItlvqA1yIzQ1+sVrLHxRvr61/Tb3C75G4rmCcAQ=;
 b=CTG48LGug34c6CkHKet8GhYB1nQVJyps9stIGiL2hqvslsOCRAnbCUzpzFEWEM18EoXs
 EB9+H+zbmdhOpo6dbXmJIKRAg882F7RZFi6eEjeKnpCBouaOCBa4tckN470B1QAIvSy6
 T9Rjy1wb38hRO/bXH+5oKDyqbHgajqQolR94I6D/dlIyKltmAGBPbfO7WO3BRTgruUA8
 AGgI3GOFll2Qo/cwy70tT/yq80qBikDcnhfAd96YVhvW+QJS+JE1JX1ZM0cEaRiAr5C1
 s81LKqWNXX7K4nSvYdTOaS0jY3QC5uNlzmudLs0vOK6xtHptVIFZWFKHXb15w8vOCIfL OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9sjps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 01:48:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4320lCLT018692;
	Tue, 2 Apr 2024 01:48:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696cd6c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 01:48:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4321mkN9030130;
	Tue, 2 Apr 2024 01:48:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x696cd6bp-1;
	Tue, 02 Apr 2024 01:48:46 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: llvm@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hannes Reinecke <hare@kernel.org>, Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org
Subject: Re: (subset) [PATCH 0/9] enabled -Wformat-truncation for clang
Date: Mon,  1 Apr 2024 21:48:35 -0400
Message-ID: <171202249144.2135322.4411557752324466054.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020012
X-Proofpoint-GUID: LNUyxeCija5WK7SmvL47CZEEitUJovRX
X-Proofpoint-ORIG-GUID: LNUyxeCija5WK7SmvL47CZEEitUJovRX

On Tue, 26 Mar 2024 23:37:59 +0100, Arnd Bergmann wrote:

> With randconfig build testing, I found only eight files that produce
> warnings with clang when -Wformat-truncation is enabled. This means
> we can just turn it on by default rather than only enabling it for
> "make W=1".
> 
> Unfortunately, gcc produces a lot more warnings when the option
> is enabled, so it's not yet possible to turn it on both both
> compilers.
> 
> [...]

Applied to 6.9/scsi-fixes, thanks!

[7/9] scsi: mylex: fix sysfs buffer lengths
      https://git.kernel.org/mkp/scsi/c/1197c5b2099f

-- 
Martin K. Petersen	Oracle Linux Engineering

