Return-Path: <linux-rdma+bounces-6382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3539EAF8E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C58A188C40D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCD2080F2;
	Tue, 10 Dec 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EYnDuM1i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743A198823;
	Tue, 10 Dec 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829072; cv=none; b=Ltto2eyJ3S0M7V7KIm06yIQqSq4QWIiVhVdcK2q8Wzk3zLoIYPfhGbFCw6bdi2PhEfTz+owEK6RnamwWRZYH6w7UPERxSIJF50C8N1qR6otomNhUBGBwoKktleIwZ7TMQsfs0sFddzz6vR7fmrKLHYtMozB1cYJ1cu04XB6+S/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829072; c=relaxed/simple;
	bh=WmM56rWaA+ibYBICkRPOFNZVIlUsUbLa9mtToOsDnk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6AmrLuefqaB5UQ/tT6jV68IVH27f4f5JYmLRBrIlo2CP/yS5pRVeymWuXimcS2Qzwnne8ML13Ju0R6/PmlDYv8TkOUmze6zogIFYXGHtjPttiW6EgquoWWPxiduogIMTweI4A9Jid+vL4p5gyPqFmzjaaHeWAAaehh0nUI6oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EYnDuM1i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1jC1n026166;
	Tue, 10 Dec 2024 11:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YRWuaf
	W8QJmSyZR5XykB7q2JyYMIHBo/0XTJs51UPrA=; b=EYnDuM1iAb93Gi23DWUQaB
	oFri/azhKA6aF5b2QfGNOVQIJvcwZvu8xlgbi/ChyRbkoZX82Zk8uMj+SP0V8D1a
	W3G5l8+PwZp7jhueSOOW8QroMbto9UailKaq/sjxwVW+nuS4mmPm6J3Z/Hy01Vj9
	vJg63zXuo8JqKsjnqa9g/FxOt4A7PApndgPWmJx3SPn/j0DGBbK/NPeecYDRkLLb
	d4tzCoW0Vs/vlH25qiDC1ukEOlhxdod6WNkPmnLQDYHfVpFJMhONVKFv+74g5fk7
	2iuzeB5gF4jeAeFBZd70YS6ej+pHz73v6zDVoxGgXXsVoKTPa1oq+hUT1+Gwbolg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8pnh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 11:10:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BAB6eLL004753;
	Tue, 10 Dec 2024 11:10:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8pnh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 11:10:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA7SM1T032590;
	Tue, 10 Dec 2024 11:10:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn399h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 11:10:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BABAq4L57213196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 11:10:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C673E20049;
	Tue, 10 Dec 2024 11:10:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 729AD20040;
	Tue, 10 Dec 2024 11:10:52 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 11:10:52 +0000 (GMT)
Date: Tue, 10 Dec 2024 12:10:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dust Li
 <dust.li@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next v3 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
Message-ID: <20241210121050.760b8693.pasic@linux.ibm.com>
In-Reply-To: <20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
References: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
	<20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
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
X-Proofpoint-GUID: HzZCdnvSlYq8Pe7LIUi0ijqNtBFtMUaM
X-Proofpoint-ORIG-GUID: uFmtwOwdKp8UUdBtn5APXoizY2saBQ-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=493
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100082

On Mon,  9 Dec 2024 21:06:49 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> AF_INET6 is not supported for smc-r v2 client before, even if the
> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
> will fallback to tcp, especially for java applications running smc-r.
> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
> using real global ipv6 addr is still not supported yet.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

