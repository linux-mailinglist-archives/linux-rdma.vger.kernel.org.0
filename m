Return-Path: <linux-rdma+bounces-6891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFFA04A48
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA41623D6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62571F37DA;
	Tue,  7 Jan 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZ/7FOy/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4432225D6;
	Tue,  7 Jan 2025 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278353; cv=none; b=E27vbIh/V7P3+4X0AvLN03eZeHVhXkULf/SDnWPjIBtxPQmoGP4npX+HUo7hcSjFgOl/JFzA7QYeS14Q+BNkWKxsMaeceGHlpVtDGnDNMYNAyDjSM3cs7wdUbQyzqFPj53enAmpBfaL98s1Ks9pGbKJ71nz0wExnIMA9/aLjEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278353; c=relaxed/simple;
	bh=s0YldtqzqbhN3mnnNbjLbOomfNAV4bF3Tjs0LQUIsaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHSN+StoTX5ju4h8JQz/qSNlGobT9AlnmfWfOzkeZZV0Tn+DoXGAX6vw+eXzm7Lf6DrY+SG63HoHz3+cESfAZTIAxmsaaIZF1INR2GTVy9bb1c9QFaaiPBBznTM8aO+1pemKiLpBhuACMA5vjgdmYVoDFpCnMxJTzU5VOV1/MH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DZ/7FOy/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Ipb36011134;
	Tue, 7 Jan 2025 19:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iF/oq9
	rCPDy5cr303B9skRy+pKENfF1mYuCG0k0w2MQ=; b=DZ/7FOy/sB+CBIKtnPWw9y
	jegfqnLaTUztmgwonZanFSlEpArvhGqcGZKiWccgFaRGO0vxTF+IPbSJGEdbjtz9
	7O4A0qMzFVoIWxBBBw2Von73MGQ5KO6jYjs1G2nAKJmHNPP8yxxCCxHo58UTDy9/
	6nkB5LNGjhh3lWKgN9jhxFVKXZXH08akxe6oHqTBl3Byi6TUyjZrBoDkvqqCRZXP
	EbYj1nZBDZqsVWwokIixsksyxTgSHyBE4NfxVT4NGGDzbMTkdMCGbATRzQHMRjwF
	/FOShBVZuzPPmZBuBEiQ0uywjuZp7OLYTjOOoEhxdJqeSOhAP8WEhEI1Lsylw92A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrjc6gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 19:32:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507JTEoA031084;
	Tue, 7 Jan 2025 19:32:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrjc6gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 19:32:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507HP0bV028054;
	Tue, 7 Jan 2025 19:32:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk3xv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 19:32:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507JWL7X34275602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 19:32:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B55920049;
	Tue,  7 Jan 2025 19:32:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E3B20040;
	Tue,  7 Jan 2025 19:32:20 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.35.152])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  7 Jan 2025 19:32:20 +0000 (GMT)
Date: Tue, 7 Jan 2025 20:32:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, PASIC@de.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
Message-ID: <20250107203218.5787acb4.pasic@linux.ibm.com>
In-Reply-To: <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
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
X-Proofpoint-GUID: GZpKE5o1etaHGNxUpFN6FXjkpGxtMF96
X-Proofpoint-ORIG-GUID: L5T7SDNFmMKrkjxMSgX8h8hMRI0w3v2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=859 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070159

On Tue, 7 Jan 2025 09:44:30 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 12/27/24 5:04 AM, Guangguan Wang wrote:

@Guangguan Wang: please use my linux.ibm.com address
in the future.

> > The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
> > to the pnetid table and will attach the <pnetid> to net device
> > whose name is <ethx>. But When do SMCR by <ethx>, in function
> > smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
> > pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
> > use of the pnetid seems weird. Sometimes it is difficult to know
> > the hierarchy of net device what may make it difficult to configure
> > the pnetid and to use the pnetid. Looking into the history of
> > commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
> > that changes the ndev from the <ethx> to the <ethx>'s base ndev
> > when finding pnetid by pnetid table. It seems a mistake.
> > 
> > This patch changes the ndev back to the <ethx> when finding pnetid
> > by pnetid table.
> > 
> > Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
> > Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>  
> 
> If I read correctly, this will break existing applications using the
> lookup schema introduced by the blamed commit - which is not very
> recent.

Hi Paolo,

sorry for chiming in late. Wenjia is on vacation and Jan is out sick!
After some reading and thinking I could not figure out how 890a2cb4a966
("net/smc: rework pnet table") is broken.

Admittedly I'm not really a net guy,and I'm mostly guessing what that
lower and upper device stuff is, so please bear with me. All that said, I
do think that going to the lowest netdev in the hierarchy is a sane
thing to do here.  I assume  that lower and upper devices are applicable
to stuff like bonding. 

PNETID stands for "Physical Network Identifier" and the idea is that iff
two ports are connected to the same physical network then they should
have the same PNETID. And on s390 PNETID can come and often is comming
"from the hardware". Now for something like a bond of two OSA
interfaces, I would expect the two legs of the bond to probably have a
"HW PNETID", but the netdev representing the bond itself won't have one
unless the Linux admin defines a software PNETID, which is work, and
can't have a HW PNETID because it is a software construct within Linux.
Breaking for example an active-backup bond setup where the legs have
HW PNETIDs and the admin did not bother to specify a PNETID for the bond
is not acceptable.

Let me also note that if ndev is a leaf (i.e. there is no lower device to
it) then ndev == base_ndev, and the whole discussion does not matter for
that case.

Again I have to emphasize that my domain knowledge is very limited, but
I really don't feel comfortable going forward with this without Jan or
Wenjia weighing in on the matter.

Paolo thanks for bringing this up!

> 
> Perhaps for a net patch would be better to support both lookup schemas
> i.e.
> 
> 	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
> 	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))
> 
> ?
>

Hm, I guess the idea here is that if ndev has a PNETID then it should
take precedence, but if not we should try to obtain the PNETID of its
"base_ndev". I'm not sure this would make things better compared to the
original idea of caring about the leaf. Which makes me question my
understanding of the problem statement from the commit message.

BTW to implement the logic proposed by you Paolo, as understood by me,
we would have to use "&&" instead of "||". The whole expression is
supposed
to evaluate to false if a pnetid is found and to true if no pnet_id is
found. smc_pnet_find_ndev_pnetid_by_table(ndev) returns false if a pnetid
is found. I.e. if not found we would just short circuit to true and not
call smc_pnet_find_ndev_pnetid_by_table(base_ndev), which is not what I
believe you wanted to propose.

To sum it up, please let us wait until Wenjia or Jan chime in. Copying
Alexandra as well: she is more of a net person than I am, and maybe she
has a more informed opinion.

Regards,
Halil
[...]


