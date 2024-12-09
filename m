Return-Path: <linux-rdma+bounces-6350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6033D9EA085
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011801667F9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55919C54E;
	Mon,  9 Dec 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NsEiG5P4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DE19AA63;
	Mon,  9 Dec 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777103; cv=none; b=Ystwp/me8+yGN/0vjQCmwSfpsttr+zOo75LFXvtzfERD0LQ4s10br63zNnU3Rza5sEjAgE3w6WlfUiAzFi2WBOHrfdw651ieNS8dYKfMpARXWtrq0HIFiE1gDB/qoEGx8PujzCJgOd2DX+SfmamNl9kJI2XkkoKhGMNep7uW1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777103; c=relaxed/simple;
	bh=jhxh0GPSjK8+EnaM5LvNvrm1hv0enVhcDVUUg6eu/g8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq9QTy+AYMrMADVRt4Zfwpx/2KUQPPG59icm0nZpEhaouyqowhchOdR0YFlyPHg+/UQLEcHsOZgqAuLNu7w7tm3KpnLSGpxnAG2+YWYJXSy6x5vnSMFEWR66S0I/hL2Or8RRXWrTkOM8qMuooKTtjf/qLQQ7Osrrl2XwRfTiV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NsEiG5P4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Bm3Vo016757;
	Mon, 9 Dec 2024 20:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gtTn5W
	Jb9iF1yBcBK3vMIpLwV6sxqwNJMMcnkzyphvI=; b=NsEiG5P4wtngsKuyZZE7St
	JV1/RbPKt23DdhV6g2Uonu3G1ZGrqgcrVbv9GnNpGWElAADHwYObklrks96O2Jfr
	ViLLC4u/NSvPBkQ8km4KhZliXxi1Jc1A7CtV/0UNVyjmGIay2ximJBkbMd8CSOgB
	PCOmS21VxvI542ThJPGO4OABRS5HzlFoJIvhRbrQEnj97LPC2cLuVbhBCCL7WBGp
	QudCx+DJObx3nZ4cqPQUAQONjzGsG0ZwYgji7jMikbA0vypPeTDmiZx+L4WgDD80
	wx2fMuLdk7HElGM7L6rPdU2sqB/e9JW1PFOF97WLKZPKkdjVCpITQiBMMQEe1QIQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjamd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 20:44:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9Kd0a8025990;
	Mon, 9 Dec 2024 20:44:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjamcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 20:44:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KGX0F017428;
	Mon, 9 Dec 2024 20:44:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1fyh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 20:44:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9KiqNu9503012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 20:44:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BE7920043;
	Mon,  9 Dec 2024 20:44:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F8E20040;
	Mon,  9 Dec 2024 20:44:51 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.14.202])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  9 Dec 2024 20:44:50 +0000 (GMT)
Date: Mon, 9 Dec 2024 21:44:49 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
Message-ID: <20241209214449.0bb5afce.pasic@linux.ibm.com>
In-Reply-To: <85d1c6e1-0fe3-4c71-af4e-8015270b90dc@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
	<20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
	<894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
	<20241205135833.0beafd61.pasic@linux.ibm.com>
	<5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
	<7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
	<3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
	<d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
	<868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
	<20241209104647.5c36c429.pasic@linux.ibm.com>
	<85d1c6e1-0fe3-4c71-af4e-8015270b90dc@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H7xn_dMYCA51XqPbCsgs4_lN0vkABEu2
X-Proofpoint-ORIG-GUID: uoPbzmDQSfFOTXJu1jL75VzgpE1BkcHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=714
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090159

On Mon, 9 Dec 2024 20:36:45 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> > I believe we would like to have a v3 here. Also I'm not sure
> > checking on saddr is sufficient, but I didn't do my research on
> > that question yet.
> > 
> > Regards,
> > Halil  
> 
> Did you mean to research whether the daddr should be checked too?

Right! Or is it implied that if saddr is a ipv4 mapped ipv6 addr
then the daddr must be ipv4 mapped ipv6 addr as well?

Regards,
Halil

