Return-Path: <linux-rdma+bounces-6077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D59D61BC
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 17:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538D1B233BC
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E81DE89D;
	Fri, 22 Nov 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ze2Erkro"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE481A0B08;
	Fri, 22 Nov 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291941; cv=none; b=m/Y8grCV+hWdD1+H+Ns4l6srZ8xHYbTOoOJfMrLyAovSWwSsGdde0dVy4PyaMByJPJutzd/bCzXcnnRMdUHjvgX+B5zQyFbJhecfZCIQkeBeO3IW+64CExp8Y9Ag4hVOejQDM71hLjDnp+eL7oudz8Vd/UUHTlETDHEN1Jn5C1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291941; c=relaxed/simple;
	bh=INNK5KK3UuRA5GcNclHcPW4I7+x8oaAUCR1kTHBh5Y8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wm1o3vNeFquXyRt9jnoEOcX9kd5YPRyhcAHVfEtpTcOJOz5Uw7ah5euW9GkhIH0q15VnavEQloaOYYNz2b9tGfkXa/Ay78Y41j9XqhFWotd19EFvgduPUiG9Y+Xgawdjf5UqB/iGFeVvZuO4OaQ7k/rYbpErhsO3Iy4n8d+CvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ze2Erkro; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCGVBL029202;
	Fri, 22 Nov 2024 16:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=INNK5K
	K3UuRA5GcNclHcPW4I7+x8oaAUCR1kTHBh5Y8=; b=Ze2Erkro25yXl7D+sgabQK
	tZTQjoLjhEyThy+ReUb9J2GhJNhKiTB/ImtzyIV1Jw+Wvk1QJCfUOppT9vZDphkP
	nQYyn7j4/xF5J3+m9jGiwuDG1gtP2SvFzH0OCZnLJnKFmx14ZtoU5GgbdOl/N4N9
	fbaY7zf1hCWo+ATE9eKw5vXz44WNr4L2jo7eiw1qnqeCYJUlBi/srvCxZMq7rky3
	aLv1Gh0oVHLXMPr4qB28Qf9YbBYE+rvlmUECBeQFEkyKH23SHLU7mS+nisHbW82a
	S7s7sZl/FY9i70qWoP3jBFaZyJzORysmHNOsXtr2pk405JAptv6by38rTCevVLlQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk9ye7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:12:05 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AMFpsUO008432;
	Fri, 22 Nov 2024 16:12:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk9ye4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:12:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMC3W7K011847;
	Fri, 22 Nov 2024 16:12:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjuasu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:12:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMGC03w54395328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 16:12:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA2F82004F;
	Fri, 22 Nov 2024 16:12:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34FD32004E;
	Fri, 22 Nov 2024 16:12:00 +0000 (GMT)
Received: from [9.171.57.248] (unknown [9.171.57.248])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 16:12:00 +0000 (GMT)
Message-ID: <1e153fb1-d4ac-4c25-ab76-94361a118a37@linux.ibm.com>
Date: Fri, 22 Nov 2024 17:11:59 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
 <5688fe46-dda0-4050-ba24-eb5ef573f120@linux.ibm.com>
In-Reply-To: <5688fe46-dda0-4050-ba24-eb5ef573f120@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RaB_LUJ6qfKX7fPFrzDXyZSkbUGCpUHU
X-Proofpoint-GUID: Ku0T1gJ09cdr3zvjtpaJh2Q4zJfqn-77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=312
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220135



On 22.11.24 17:03, Alexandra Winter wrote:
> Are you sure that all callers of smc_conn_free(), that are not smc_conn_abort(), do set the socklock?
> It seems to me that the path of smc_conn_kill() is not covered by your solution.

My bad. smc_conn_kill() is called under socklock

