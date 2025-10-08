Return-Path: <linux-rdma+bounces-13798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D1BC586C
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96A6C4F8966
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA7286413;
	Wed,  8 Oct 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oHevIM8p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71D287505;
	Wed,  8 Oct 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936120; cv=none; b=AurcZYQcSbaOBrXB4mt2ldZPPdVo4jixfAZ5wy0MYwtr6AOsQ2wL/mCUWXaKfMeG4RFpWcw7ignDaSGjX4QI3El6FTNFG4n5uYfDgXRM+YArnpHh/AYIBkWkIzit/r8BVSG2YxB7OCBZ47ckpJ1VLv/3NNxKsrIEd0WCFFhmgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936120; c=relaxed/simple;
	bh=gw1n2k3bVJ4HnM5jaOKbNiYxoog8PqFFa15xtHSaS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONxxYeNAH6uQ4mUWfRF1hglj+Vm/096tGT6V6QmuI94QIxGzaiOCxUY8cngBD277B7xbMRmZV4yJ2siMWvgOkhdxrZWs19USgusl1iqcpI54S+W+JcoBtYSQZ0hxlYi42/1rw1ce3KGFyazwj4kyCaGxPtT38tar5zrNs0XGO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oHevIM8p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5985mRu5005704;
	Wed, 8 Oct 2025 15:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IXws27
	uw2P8rHXdGXnTEjb2JtZYE6gL7w+ozNAxwm1o=; b=oHevIM8pNtQ0Z0x1IWJzqW
	E9BxZczdrfEsuaGsno8xZuzbQfWrIQZ/rG+EcwDszX5ck3edbHjHDVS0u2hSZiHl
	c7un0r20XkUf8tXfqqpDRV9+SrH1v+X3gdJ5mENcIRa6FvfYtIowLbPUWUWlroZt
	FXTmu+VNAr0/ntcGRg4O2qtxvIojAHlNGBX/aqDrcpdBerYXYjT5zoPo6SwlOdlU
	Wx5JcyXX7lOumiItlJLyFlhpmvJc3qZPYhNOeKZ6VFa/CIHUDdcY08UCa8FBDAYg
	oSXIBDxXtI6iO0OiRFErndu3sBjB/AfmuBbd1sCFZBnXgINuFR4XHTzIUscMrjSw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h5xcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:08:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 598EtZoL029518;
	Wed, 8 Oct 2025 15:08:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h5xcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:08:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598E5tPY028463;
	Wed, 8 Oct 2025 15:08:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewn934e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:08:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598F8K1L60293552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 15:08:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E41C2004B;
	Wed,  8 Oct 2025 15:08:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B466020043;
	Wed,  8 Oct 2025 15:08:19 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.55.136])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  8 Oct 2025 15:08:19 +0000 (GMT)
Date: Wed, 8 Oct 2025 17:08:18 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang
 <guangguan.wang@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <20251008170818.35825f55.pasic@linux.ibm.com>
In-Reply-To: <aOZv0NmekKIgpc5M@linux.alibaba.com>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
	<20250929000001.1752206-3-pasic@linux.ibm.com>
	<aNnl_CfV0EvIujK0@linux.alibaba.com>
	<de0baa92-417c-475a-a342-9041f8fb5b8e@linux.ibm.com>
	<aOZv0NmekKIgpc5M@linux.alibaba.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX6VjEahsoUcmG
 smHgSy/AKpBINebCo5oEvoRscM2tO9XOv7LMLb1Ky/1R8nGtJUEvOJi1hN/Kbiwv2VkdQ8I8dnX
 RfX1uelw3SbTRpmoHhnkBA9i5KdvIBsHLsjZO8toToW2juiknDZ8xK8cXzDFftMmElSpwgRwLUR
 rbpKt3oFd0nFnLuQE4VqlD6ERvLVmMizpmledmUMH3uSwW0xSeW0GOITBvCkW8gkPY0eGeQs6N/
 NxWx5+Z8ln23T0+BSdLDkt4YX/Yw22tPXtPQHpt/fBqEAlfCUdnkkApecS7Md0TvmuFAhwbg3Vh
 Tc/XGXGu/FuTVMl33O6q4IptCPRaZ1ZVO2I0jXaxGUoe+1h03eSBdItNqLSA7/kdUO9TKB8o+97
 BS/DIb2WJsrT6gnb+DcYhGiMTgwFBA==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e67e6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=SRrdq9N9AAAA:8 a=akCnWnY-8Ao0MBcy0-UA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: kEXar_J4G3Eih2Gc8x4pvjM3-V64uZDW
X-Proofpoint-ORIG-GUID: r0GVS5MJD2DScOkInXjzo5VyvaqWyUXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018

On Wed, 8 Oct 2025 22:06:08 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> >I did test this after you query & don't see any issues. As Halil
> >mentioned in worst case scenario one link might perform lesser than the
> >other, that too if the kcalloc() failed for that link in
> >smc_wr_alloc_link_mem() & succeeded in subsequent request with reduced
> >max_send_wr/max_recv_wr size(half).  
> 
> Great! You can add my
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Thank you! Will do and respin once net-next is open again.

Regards,
Halil

