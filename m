Return-Path: <linux-rdma+bounces-19284-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCp0CczN3GmcWQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19284-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 13:04:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280DA3EB10F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51D25300E484
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790933BE145;
	Mon, 13 Apr 2026 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P1XypkgU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16C318EDA;
	Mon, 13 Apr 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078039; cv=none; b=RmSI+ZTRn0GM3dxZX15eZXVWYCS4Dpxd9NCo1bR+r2sNW4CpeE8pbYqBvupGdnhY7HI14Tfeuk2hCAqc6OxSWJ9NuxT0FbynMOZknbYUHv48Ek2UUqQHza3RSNKPiaysFAo265lgH7sro4A3Vjf/Yfljq4c4Mg9r6Kwxop/1clE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078039; c=relaxed/simple;
	bh=n6dnNNSI4e88eDikuxGwDJcwTsuH1VbgE3phSAFdzFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUAd5W3VkYmf4zM6Mt41KskLSmxroxFR1rxN8Dm9ggjzEScS+wAmeMsBYcLaOhSY+32BpMbM4nONG4tR1NGDJiVLJQfqiTI40A3VNLEIklS05cC1bNCDLjfkGOQ5ih3e+0B+nHHSbB9qhBZPnJOFciH0DR5maCX64+BFx/n/VTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P1XypkgU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D2IWi63996852;
	Mon, 13 Apr 2026 04:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=eZ6cOdd746/9RpWlBI+Qa8/06
	9H3roFVjc3HrN8FPiM=; b=P1XypkgUMl6iJQRQJdSfAH1SGYYOe8xwx6nPuWQeT
	jBOg/Bm1iLO+QYDLnDzm503uLbor59iZVQL8gwvmATmNTJPoIew4EU9lO7nLREw+
	Vk+ihwn/Ebg/esE9a/rCIiqg97HBXJywxESTezQcfz5X86AYKqR8VeIc2WLIHzSj
	sjIlrkK8zPf+LvJS78QzwXYbT8liW0WAKpFrTpdc+jhw+27+B6i8TMOGaKViZ0sk
	1YOyQIipURuiTSfzlWq8O2ZDQUwO6qOQUkWoMv1j1CrCuTjbLfoidpvLeBrbNoeV
	e0QiQ7tqZC+qIubusbZrIpYcUY7PHd3qU3CLZ13xeMwHg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dgqjaruws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 04:00:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 04:00:23 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 04:00:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Apr 2026 04:00:23 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id E7A333F704C;
	Mon, 13 Apr 2026 04:00:16 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:30:15 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <donald.hunter@gmail.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
        <tariqt@nvidia.com>, <mbloch@nvidia.com>, <dtatulea@nvidia.com>
Subject: Re: [PATCH v11 net-next 4/7] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <adzMvyIr7-uBtGlI@rkannoth-OptiPlex-7090>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-5-rkannoth@marvell.com>
 <b52ce943-18f7-4402-8b6a-3d9f69bf7d19@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b52ce943-18f7-4402-8b6a-3d9f69bf7d19@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwOCBTYWx0ZWRfX1PrxP9GDcSSd
 p0pgA6jOLyHi23z9A+YFZYBJizpniNRBTrgyoumbQi3BpaXm/SL48tYsR86j+kj1tsXpyctKj9R
 KyNJnXWvBZwDk5qwturJGi9kg9CWjn4IMR0jYssC3NIsuODaRtTJrDG60x6HiuJ6stI5sT9jb+5
 eX665bbnLMtlZnLTOARm5dZ6s9jP/mocRPZnVm0t7ue2UaqEX3yihNMZ1IbxZ1aUr4E16oD5v+H
 Ypj+uNfpiIrQt4MyJ8EDBJe+LOMtojoa0gSIpP1jNjAVlLaplOIwt+RkB23j1OJP6w96T7PJ3jr
 kgbPdmcs7+gpnw7qBej6sFldv3ZlieAatA7YnvmDhLaurDGUt+gKZrwdFzrQ7F5T2S0TDxVS4gM
 aQYtkBvLoxESZUwiXP/ZNKrUyUyae8LjeC+n8spbOMnknrThxh5sy6fDSp7Y+tMKxH1jDbgjQd1
 g1gTv4clms31fq+O8rA==
X-Proofpoint-ORIG-GUID: hweeKS6qICl4RCz2NEFftlZ1Ckp5m1nY
X-Proofpoint-GUID: hweeKS6qICl4RCz2NEFftlZ1Ckp5m1nY
X-Authority-Analysis: v=2.4 cv=M9p97Sws c=1 sm=1 tr=0 ts=69dcccc8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=J8eLg_BmoFaBhDuSrmQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=JSVlQr4fib6YhFFKv7Hz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19284-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 280DA3EB10F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-13 at 16:24:41, Paolo Abeni (pabeni@redhat.com) wrote:
> On 4/9/26 4:50 AM, Ratheesh Kannoth wrote:
> > @@ -441,6 +448,7 @@ union devlink_param_value {
> >  	u64 vu64;
> >  	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
> >  	bool vbool;
> > +	struct devlink_param_u64_array u64arr;
>
> You mentioned that you intend to handle the possible CONFIG_FRAME_WARN
> with a separate patch. IMHO such patch need to be part of this series,
> or things will stay broken for an undefined amount of time until such
> patch is merged separatelly.

Patch no: 3 in the same series.
https://lore.kernel.org/netdev/20260409025055.1664053-4-rkannoth@marvell.com/#t

>
> /P
>

