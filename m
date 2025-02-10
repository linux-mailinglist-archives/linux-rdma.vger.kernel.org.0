Return-Path: <linux-rdma+bounces-7641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166FAA2EF8A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90E53A38C7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D6237185;
	Mon, 10 Feb 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmrzRNvo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD7237177;
	Mon, 10 Feb 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197173; cv=none; b=CY9btvKls66d+wfq44kAY6li3re/VSyxK1z0BUIySBHywLDz2bIjfIDonf3+JsVgklmhwv386jXoxTuQCUsngkUqEp0oU1BigpVkitfXIh5w4AGTOi7R0d2B18MW3gc8xi7FZrJ30ZgVVKIdFPQ7AmHHvSSf5Cq/qHDIuYDYobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197173; c=relaxed/simple;
	bh=tc4eeJ6oXgsOFuV3/HtEN1P7ANINGxbJ8KhoSu06eTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h06gzoyjnrrs6kxmfZVMFBW3by7GOV9cy9L2UeWFu3abHf52P/OKAkHiLCwF1n5w1XeydiUej63KcQEEpZu6pb/Il40tN5Wd2DpLIgLx5OBGJp7a+oCcTgXKvWioaG3xGHUO1lMSXZEzPojYbhTBwkPKLv11risHkgxd1+Mp0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmrzRNvo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AC7mLU016074;
	Mon, 10 Feb 2025 14:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tv4nL2
	2TJCpg9Kk+KxUkvQiLf6XNSk6aI0GzIp72GAU=; b=rmrzRNvoKd6Wi2dKcFoB/L
	BnYOj+M6lVhd84cNG8TkKVamiUFKuB1LUHjVtHqCeuWX060JI37eE/V3+zS0VFKx
	ZR4iBHAzHdbe127qZdYpQIiRldDJrd2sR7b2ycTM7vpwRqLK9NcB7yHihmEtpDoF
	fSPGk2WhQPAWDZUFyFhkEZFsko1c+rvyrnzAqhrLCJFffiRVqYRjiddfMWPteZdz
	x+qQ8TPnBl6zqtDrDEvgot9aSj/IXGYTYxZvxonQyqc7T/7lTujVLmmTLF/69XDZ
	v7D/n85OJ+QjCzWU6fruu4C2qmp2aFP5dsIYkmm3krgVoKxQdH7v5OjUGwxrPcfQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gabq04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:19:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51AED2YQ026980;
	Mon, 10 Feb 2025 14:19:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gabpyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:19:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51ACK4Iv016743;
	Mon, 10 Feb 2025 14:19:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3jxm1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:19:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51AEJKFD28574344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:19:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 111FF2013F;
	Mon, 10 Feb 2025 14:19:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE04C2013B;
	Mon, 10 Feb 2025 14:19:18 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.22.27])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 10 Feb 2025 14:19:18 +0000 (GMT)
Date: Mon, 10 Feb 2025 15:19:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
Message-ID: <20250210151917.394e8567.pasic@linux.ibm.com>
In-Reply-To: <3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
	<20250107203218.5787acb4.pasic@linux.ibm.com>
	<908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
	<20250109040429.350fdd60.pasic@linux.ibm.com>
	<b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
	<20250114130747.77a56d9a.pasic@linux.ibm.com>
	<3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
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
X-Proofpoint-GUID: yCIZ2RZbueuUY42KIuKe0GPL3TjLKFnv
X-Proofpoint-ORIG-GUID: cLrpU6az_SIFJpqqb_HRqbnlL0GKtwWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=957 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100117

On Wed, 15 Jan 2025 19:53:15 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> > Imagine the following you have your nice little setup with a PNETID on
> > a non-leaf and a base_ndev that has no PNETID. Then your HW admin
> > configures a PNETID to your base_ndev, a different one. Suddenly
> > your ndev PNETID is ignored for reasons not obvious to you. Yes it is
> > similar to having a software PNETID on the base_ndev and getting it
> > overruled by a HW PNETID, but much less obvious IMHO. I am wondering if there are any scenarios that require setting different  
> pnetids for different net devices in one netdev hierarchy. If no, maybe
> we should limit that only one pnetid can be set to one netdev hierarchy.

I wonder what topologies and changes to topologies are possible. If
changes to a topology are possible then making sure there is only one
PNETID within a netdev hierarchy can be difficult, as we would need
to prevent changing the topology if a device has a not PNETID. (E.g.
we first set a pnetid when the netdev is still not in a hierarchy
and then try to put it into the hierarchy that already has a different
PNETID within). Regarding allowable topologies, using your ASCII-art.

I think you could add 2 Pods with an IPVLAN eth0 (Pod) on top of eth1
(host) each. Those would be in a single hierarchy I guess, but I guess
you would still want to be able to set (most likely the same) PNETID
on each.

Bottom line is, this approach looks tricky to me. Maybe with a crisper
explanation on what are these upper-lower links for. Maybe I am
overgeneralizing here.

Regards,
Halil

