Return-Path: <linux-rdma+bounces-7642-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB88A2EF94
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 15:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE890188883E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D523CF09;
	Mon, 10 Feb 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJtorG6y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A402397A4;
	Mon, 10 Feb 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197246; cv=none; b=CKpPdAtnLQAQghDFFNZE22P955QLGRzgLHVv1UJtFAPXpFGeSFX0s0crQ/PA62xXHqMvH8BgAnVP5Qwe9pBLSMBhY+Oo+mihOfJuVvJ4DjB7lfStgX+H8vJtSc3by2AcQ+fDwFNXeKx2MxJ4bvdMc7+WePLUJYZgzi7y/NwlGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197246; c=relaxed/simple;
	bh=eBtv4UDSmOiOWCVBy0HWEuU6sdZHpTFYvVdUlDLYKKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0KwSGXwS+fQNmw81FEcUpisHcXbGCIWnNCg4j3Cm58udpPxhK6WItFXH0Rlh2tp06c3mPrhmK8l6R6sX/5+km81XHOcl4/+bDORR34vSwx+MojAG2NXE34hsGnFq04xPO/y+dISn5yHhgNtCwqFhMRI2GJKbFbPH3HK30v3Ls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJtorG6y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ABcdZn016939;
	Mon, 10 Feb 2025 14:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BZy/gA
	s6656JwACPvb9IK7Ym3N9S+XutWLuG3Spl+r8=; b=qJtorG6ygYgt2bSmfz6YTH
	iCAymoJUMZIQMNfwcT5SHBnq/VCd52XpdvaGmYkqiih9nzweq55i3/IXEN2/n7Ax
	BS9237mZJerywCRbd9OY5KIMkVDC0ifwZrHKYFUAP2uaC9WmsIfXpBSyIgoEFcnO
	CpqiuVCBg/BIJrrIIjaCZVkEInK84GE5yLLw/L/vs3Th/K409oHRnmEsbYQsKaec
	Dxh+hXb8RmqXvkpGSV5LXxxLZDg9se0FpHIOjJ3W0fTXQgiqXYRq/6wVPAKSViW5
	dPAm6rl6IeDL3ssjvxpJKhchrndu7WTEmK0QcM7ZHrkYvQ0vBZOfGBevSBUvL+vQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gabq5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:20:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51AEGvvl007641;
	Mon, 10 Feb 2025 14:20:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gabq5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:20:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51ABVm3u028244;
	Mon, 10 Feb 2025 14:20:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyy6trr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:20:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51AEKXCN60490140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:20:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 982E2200E8;
	Mon, 10 Feb 2025 14:20:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0FF200E7;
	Mon, 10 Feb 2025 14:20:32 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.22.27])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 10 Feb 2025 14:20:32 +0000 (GMT)
Date: Mon, 10 Feb 2025 15:20:31 +0100
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
Message-ID: <20250210152031.0ea34ab2.pasic@linux.ibm.com>
In-Reply-To: <4339aaa1-f2aa-4454-b5b1-6ffb6415f484@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
	<20250107203218.5787acb4.pasic@linux.ibm.com>
	<908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
	<20250109040429.350fdd60.pasic@linux.ibm.com>
	<b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
	<20250114130747.77a56d9a.pasic@linux.ibm.com>
	<3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
	<4339aaa1-f2aa-4454-b5b1-6ffb6415f484@linux.alibaba.com>
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
X-Proofpoint-GUID: lutC1Ym4XPERnID7o5lKKVqKtrCc8OnS
X-Proofpoint-ORIG-GUID: _7XY_yvL9Rzt1r5FtIwdVBuuvo1g3LeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=678 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100117

On Mon, 10 Feb 2025 19:16:57 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> Hi Halil,
> 
> Are there any questions or further discussions about this patch?

Hi Guangguan!

Sorry for taking so long. Yes I have asked some questions a couple of
minutes ago.

