Return-Path: <linux-rdma+bounces-13664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896A7BA1B04
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 23:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD77BDEF7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F53271459;
	Thu, 25 Sep 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gIFat5Te"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64833FC2;
	Thu, 25 Sep 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836814; cv=none; b=Ie++Wtf/qI76eS/cKKbZg1DeCfcsPy35KmeXXCIA7RmJewN91uwt0zJ2vaYDVzLdByfuPQ+mUHEPRKZT3aNTQpsFwh09XCU7iXlnr08Hy8GJ7dvTz064juV+tVL6DoY//v0rwQ2CdERYI5zF1pfjNNAfa1vJLVR4FmuAclSbN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836814; c=relaxed/simple;
	bh=WKpoc9+9K5GGgKrOubiqmZ+Fm1Kf3gzxbsj2jNle1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLB7vIW/XX8p5qXcY5+GA5Pw7+KaInx/QPG2qW895yi0pwJR/VBaA96PVChWKntGU5czilngurvLb6XnNEAebMlVYZDI+TfezlEoIntL1+eawZGaaCivE9ulnuDbnjAWkBKfe/iIPrhs05Fz9lGiUvrwBnIF5MyoeULEjJPrOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gIFat5Te; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImZPZ018041;
	Thu, 25 Sep 2025 21:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hm9hP/
	63NIlAC2AM2rcR859l86G4CCxgjB4jsqGxKe0=; b=gIFat5TeP6kCBAolsemnoC
	RLgO309c6OhZN0RrnehSUq9Nu32vZCuhE80nGR7YO2WWDZJGMHXq0tr0rrQ320g1
	jakFWiEUMKXm/dHNZs2XjH3tnrWpNeHRPG+Ic8voAUm5fcowBhYYbPOJo++Qh6Q2
	OtUaWyX1WNXApiqWqqq7WhJQ2aUwAsOjqBGL64R3NxgDaOcgejnUcJG/dkvkXwiR
	/VDATYdmKYOPtyA+BUaBvGScHILNFPg5K003X4cFNV+t+8dIVOpeReeJwkoCNiqp
	pTgtgRWGo7cqEV4RbbHnu0drIQaqJExug+E/rmHdlWyLiC3R8bk3AwqpH9vnIqYw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbd8u3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 21:46:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PLkfVV028392;
	Thu, 25 Sep 2025 21:46:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbd8u39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 21:46:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PLdq9F006428;
	Thu, 25 Sep 2025 21:46:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawpgvyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 21:46:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PLkaGK43778482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 21:46:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7391620043;
	Thu, 25 Sep 2025 21:46:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8966720040;
	Thu, 25 Sep 2025 21:46:35 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.151.15])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 25 Sep 2025 21:46:35 +0000 (GMT)
Date: Thu, 25 Sep 2025 23:46:33 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        "D.
 Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <20250925234633.3f0db19c.pasic@linux.ibm.com>
In-Reply-To: <30a1dc4e-e1ef-43bd-8a63-7a8ff48297d2@redhat.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
	<20250921214440.325325-3-pasic@linux.ibm.com>
	<cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
	<20250925170524.7adc1aa3.pasic@linux.ibm.com>
	<30a1dc4e-e1ef-43bd-8a63-7a8ff48297d2@redhat.com>
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
X-Authority-Analysis: v=2.4 cv=F/Jat6hN c=1 sm=1 tr=0 ts=68d5b842 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=gcIiauuOHNroVWZtbkkA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX1UaTgoUMjRDy
 AAalRIIPJZ0fRvRVZp8FA/ouqDsLpQ+3HLpf/XofMIOO2zjm/gylEWzrZClbujy9TjBY1yYVtxv
 hP/KDkMCasCWhd+GtNUcyzbTkvtpmeFKZHs1DM+ZJtXUVs3C5EySoyY4v7GtoA3VZJu3HwnEkXz
 CZI/ZTwkEGK93uErxDgIsIWa7dM946fVlwTmyIAx5fWMkzOhm/EWPFjKNKIrIcDjYsGm3ccxl47
 AJm0ikpzFAdCCx5SRLgdNOT4q4K2FAZtZEDWwaX9OWgOAilE7VDcShm/T3Y0aRj9CkZMvJKPw9p
 L9NmT//8oDaWbZEVfIYDMrjwlXowNtdUYSKPr/TeLbMYlSuroQOTrowPiYhrOqZji443fjarjRW
 WMOqd0mEvrmOir39DFfDjfDCVyqypg==
X-Proofpoint-GUID: 6ZFowF36Cau9lYzkJEqovgmnubqUtIbW
X-Proofpoint-ORIG-GUID: JSD8DgPPMK9RnzsH7PPWtR66_XcfgGw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Thu, 25 Sep 2025 17:41:29 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> > So I would prefer sticking to the current logic.  
> 
> Ok, makes sense to me. Please capture some of the above either in the
> commit message or in a code comment.

I will make sure to add to the commit message that the ratio is preserved
when backing off and spell out the old values the 'we give up condition'.
Maybe add some more words on possible implications for v4.

Thank you very much for your review!

Regards,
Halil

