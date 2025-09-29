Return-Path: <linux-rdma+bounces-13722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB14BA79CA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 02:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F1C17638C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 00:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74031DA3D;
	Mon, 29 Sep 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KZj9gog/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D3A31;
	Mon, 29 Sep 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759104231; cv=none; b=Mi2DaC2oPsXolByluvLohroAGnb/yqwPt1EMXzAss2m14vWJleGQ/EtrSxQvSbaaYXAPJR2sOZL9ZqET3etSjam6/g+6+vjFhwt9eQCAvVQaVorfizJW1M0AdN1nU/UEIbKPC03y2V16VQhkPsfGOpOadC6OLyoYOoIom2TbBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759104231; c=relaxed/simple;
	bh=2Pnhd4bqOpAnsLtGzi43eQxPxY7LlAnI4G8Lz//HLGU=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anxK4dqvGYbtmb2sYsGqLBtFuMlIbFs1exqV/rxiOWkIgNwAzp1TXD6cw7dQpt+ItHMoA1Ib9c7bS+fSW8zUsyiCWF5xrsgIsQVeP+2aLH4VH3dCcfeLthtySFzD2rqIT+Enui+ZFuHwRkNYR2fygXkhRWqUqU48T9XzGGYRpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KZj9gog/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLBTFI018505;
	Mon, 29 Sep 2025 00:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hEDbue
	cocGak3u455hv0BV6NYmMihSenXh2jd6eT49k=; b=KZj9gog/MB1nzHdMf5aC77
	2FXZSd+Ydne3wvGSwsEgF/+kiE+r+ZPa+vdMHV5n7BDp4aKvI9BUIiNNyZ+WzozF
	DrK/ywp8R2FglPpsivzd6CQuSXW9pQIb1jtYHYb4Tkabub6KvBEdBVptaFXYJOei
	emTiUgpoImOMjRrNCLNugoSPliG5sZiDgCtfVTxFcM7UbflOqsF/wLN5pK/lbFpo
	wY7yNT8Ufc//zWNGmB4dxARxkQ6tR5iIRd0aBXQc5Ccsqf64vncR5lr1be6YR8ar
	+sBMKArtwyG5RHm6lIWEOohgiVw+8WOfoQceHDH88FCeLoC9JWbmZ3z5zNSyCczA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh7bvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:03:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58T03hX6029208;
	Mon, 29 Sep 2025 00:03:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh7bvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:03:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SK6mPJ024191;
	Mon, 29 Sep 2025 00:03:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0u90s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:03:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58T03c4l31326470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 00:03:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92C8820040;
	Mon, 29 Sep 2025 00:03:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B91A2004D;
	Mon, 29 Sep 2025 00:03:37 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.130.219])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 29 Sep 2025 00:03:37 +0000 (GMT)
Date: Mon, 29 Sep 2025 02:03:36 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
 <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>,
        Guangguan Wang
 <guangguan.wang@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] net/smc: make wr buffer count
 configurable
Message-ID: <20250929020336.676cf667.pasic@linux.ibm.com>
In-Reply-To: <20250927232144.3478161-1-pasic@linux.ibm.com>
References: <20250927232144.3478161-1-pasic@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d9ccdf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=op-23MdDUTri6H3QIeUA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX3GeJa51zjNhg
 Q8t1u9HZO4HhjmRcmqfhllJ4I2rHExcGKcma8fA0HpMWcIWTP1TLw+sSa/6f6byvd77cCbczKtv
 pisnAlni5v2qUNEoqHgXDNHhhHKU1hhR2PWxcO8zo/bjsqSw3rj+un5IRmrlh8GjlxlZWwXkdPN
 AkD+NIXDkBcQGtwKWC0iz/9FjWCuI2eu7zA65X1CceAcd9InB3BFK0qFGTVbWSDANsonc3KwebD
 Z4LvbzpFGPcfEk77/RT2W77zcMV1CvIBIElD6FJoW6sg4RGOmjXrnuhKTrs21iTChf6GsSemUjo
 Gj/IcP61A4QqfVj9oJCQwRZTzUlTvX0LAGum7GtaRjQvQAGUDbNHrZnarJ0+hjLLRsuabwW4aah
 E8x2evNZCBOxkt/MeAcxijavKUkRrw==
X-Proofpoint-GUID: Wpg0JrabT47BXoVPfBO1ZvaQR_pKPbk0
X-Proofpoint-ORIG-GUID: fnM5jGg5GKIW0tKNHUuaB05Yp5Ymwf4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_10,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010

On Sun, 28 Sep 2025 01:21:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Changelog:
> ---------
> v4:
>  * Fix ungrammatical sentences in smc-sysctl.rst (Paolo)
>  * Remove unrelated whitespce change (Paolo)
>  * Add comment on qp_attr.cap.max_send__wr (Paolo)
>  * Reword commit messages (Paolo)
>  * Add r-b's by Sid

Based on comments from Dust Li on the v3 thread I have sent out
a v5 just now. So this is now superseded by v5 although the above
change log may still be of some interest.

Regards,
Halil

