Return-Path: <linux-rdma+bounces-8751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A842A651F5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 14:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142257A6DC4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082B241669;
	Mon, 17 Mar 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N9Ic8yF1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93336241129;
	Mon, 17 Mar 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219836; cv=none; b=XAicYnvG0PFNaaHPD4SX/pf8oVs295vZjSsYlXE282XeT+zhFbMYiWsK2jGaazeOXDLNQkVzXlIUwJsFjsk5Eq0aNLtqCWjmYOJR6IJBeXstVP//nlK28WIk6lpztfeRl1K9Rav/Nf5bh6WKrJLragqNt6YwUdCv8o+YS2Goqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219836; c=relaxed/simple;
	bh=sSjPqbu9OFPuvQnENGQoGhHTGaKcRFEGnMtAb/gleBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8isn9OSlw9M5w9si5h0zEv0w4eiaaJdKxHdGU3IYY1qfB+6SvIi5UtU5ysWWnYEDTfjV87kcbYGjwwO6GoFcOQ7WTqTOyOpmuHazMxf0j6RQTjPKiSWIljlJv/GNuUvj1rHcvTP8zKhY5GKw4g6ZC3X1W7tx8ZiF0uWJSXHtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N9Ic8yF1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDa3Zn018184;
	Mon, 17 Mar 2025 13:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GUH8cm
	mKancpQH41aPR1l9wcULwXArnAHaNi/ZU5n4c=; b=N9Ic8yF13L5elng7ZY/pKj
	Nuw0eIJsxnhhHCew2nnnm9/iYnfYoOxLaAA7eTSbUoRmjsRmRYyCiQv97CPlt4D3
	b/AwoqOUIBO/hZ3mRbfDvz8YqE+cRlqFdqu8Q2qkIPXIgJWmYdbMOyjX5KTBxxQZ
	5Bo4VFC2966+tYGVgnIHoYfjYdJ864lDLFWOmFFRSobFOAOxdsyCpTt5RV3CxZgC
	NDxF+Q87J3lw7xm91xzgFq5EDnlCU8E6PxIjoZQ1CkaChJjtk4nyGPG8JEezQnJ4
	GLsWGPnRn6BRzSdQMaJpA2ICrC2azsCmJWR7jL2KJd03gbic3Mnl1nU4vq1s7D7A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v03rfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:57:05 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52HDa4dE018418;
	Mon, 17 Mar 2025 13:57:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v03rec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:57:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDqkRI005742;
	Mon, 17 Mar 2025 13:56:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk264tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:56:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52HDuYWO52101546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 13:56:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2222820049;
	Mon, 17 Mar 2025 13:56:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 289F72004B;
	Mon, 17 Mar 2025 13:56:33 +0000 (GMT)
Received: from osiris (unknown [9.179.24.138])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Mar 2025 13:56:33 +0000 (GMT)
Date: Mon, 17 Mar 2025 14:56:31 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, alibuda@linux.alibaba.com,
        jaka@linux.ibm.com, mjambigi@linux.ibm.com, sidraya@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        jserv@ccns.ncku.edu.tw, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net/smc: Reduce size of smc_wr_tx_tasklet_fn
Message-ID: <20250317135631.21754E85-hca@linux.ibm.com>
References: <20250315062516.788528-1-richard120310@gmail.com>
 <66ce34a0-b79d-4ef0-bdd5-982e139571f1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ce34a0-b79d-4ef0-bdd5-982e139571f1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NSqFDVsAl9mx0PzomBeGQR0XnQ_batOr
X-Proofpoint-GUID: NSIGZDVbzXe3CNF4ynR9y7mDwn94_QbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=979
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170101

On Mon, Mar 17, 2025 at 12:22:46PM +0100, Wenjia Zhang wrote:
> 
> 
> On 15.03.25 07:25, I Hsin Cheng wrote:
> > The variable "polled" in smc_wr_tx_tasklet_fn is a counter to determine
> > whether the loop has been executed for the first time. Refactor the type
> > of "polled" from "int" to "bool" can reduce the size of generated code
> > size by 12 bytes shown with the test below
> > 
> > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-12 (-12)
> > Function                                     old     new   delta
> > smc_wr_tx_tasklet_fn                        1076    1064     -12
> > Total: Before=24795091, After=24795079, chg -0.00%
> > 
> > In some configuration, the compiler will complain this function for
> > exceeding 1024 bytes for function stack, this change can at least reduce
> > the size by 12 bytes within manner.
> > 
> The code itself looks good. However, I’m curious about the specific
> situation where the compiler complained. Also, compared to exceeding the
> function stack limit by 1024 bytes, I don’t see how saving 12 bytes would
> bring any significant benefit.

The patch description doesn't make sense: bloat-a-meter prints the _text
size_ difference of two kernels, which really has nothing to do with
potential stack size savings.

If there are any changes in stack size with this patch is unknown; at least
if you rely only on the patch description.

You may want to have a look at scripts/stackusage and scripts/stackdelta.

