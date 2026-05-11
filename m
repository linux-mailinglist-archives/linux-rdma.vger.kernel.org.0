Return-Path: <linux-rdma+bounces-20338-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK4jMXFMAWqnUAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20338-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:26:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAB5079B2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B46963001A45
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4337C907;
	Mon, 11 May 2026 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KIg5/r9G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC8376BC5;
	Mon, 11 May 2026 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469996; cv=none; b=FIPX6L8+YWggJWEmZvtrS4N56JEhG1akgJNhDCh3k7LyrOWvgAY9dP2YCCkAQd5cN0D8ySJp0JP3ZSk196rYQ7lyow3O6VowrlG8OhGcFk9pklqi8kJkwv6PpyZamZSvN9CzZHF2v/7QmdL9PiDJj4gwml/U4a5b96jYbF1sxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469996; c=relaxed/simple;
	bh=RDz0JGXij31fUhGekIoWHDKWcEFj2scwiyQcQvo/0Sw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5WJ5/6ErETd5Q7W3tyRF2abCYdRlWCXMLofTvGAa5Y7hGTyFKIeFTD3mCC8sBeWYm0aGZ0GJ9GmQLL+H4VNuZf/1bBPj4o6YHk8Wd1dP8+lnNPUxT/xJoJFlHcMxsU3EfDU3RZEb3fBIkQgBJdN/RJQorVizwrShQrWuEfnRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KIg5/r9G; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANCPSt2550148;
	Sun, 10 May 2026 20:25:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=+jpJjWzU5up/MkuKjfkXcw0CV
	nj1Cm8QQOjebWfq+KM=; b=KIg5/r9G3D/iXLA4LCoEdeEDoou9Ff/1Z8RphAaPW
	WisjlyOa2jYbD/gxGKn5x1WqUSGX4NOl1t9tT548s9495q+gySVxXHHDv96hzi74
	aaDaHjYEIRmbRmkDIccmxPeFYjeHuqRVnHv6BvfxMi/hisFjLHyD7IOtnNOejSes
	YjUihggSRANXUIsSz8/NMINg6it4mFEaaFfJLxGOsCU0oPCzK7O6fLbflyb1Yrb+
	Bk5hTXGox1eSsDUxVcVpVGEuLZSDLzOrKZw9GpEsTSXO3pUn4LhcVJZZoifJU4z5
	Q4okHL8/+b9jZjvAdTmraxgZczCh7D3dJxZzxwXvNXKlg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e24ejax87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 20:25:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:25:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:25:57 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 834F83F708D;
	Sun, 10 May 2026 20:25:49 -0700 (PDT)
Date: Mon, 11 May 2026 08:55:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v12 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <agFMPMSmDjoQ_nT-@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-9-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=c5qbhx9l c=1 sm=1 tr=0 ts=6a014c47 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=8cwE4-lyzN0HC8lYIv8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: tfHeb_flF7O6OOb2RJRYK50BpkOxdIGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNCBTYWx0ZWRfX1H5cRY+nfc0A
 oCSZ5Job+iznDjPoGbfNLQe9UEeNFQUefSn2z/1Bvro1fxf7CTx/4CaAv42AhY8H+JFQL6jnKC0
 s2HiNVBaBikQUJVms86axsOY8GI/0AMSx/oNgOLFuZziSt5YjCBCCzKrWmkkB9NmxmJ6VRXYrVE
 l2LFtzm8dld+jPN1h3wdM7YF0TBZHYYlMokFA7ytSoNe/tL8N3FKRzAQmRMgyqhfOq+LXP3MkqZ
 +7xkLVdIag93t3F/1y8tEG0p7LG8kQJgQ/cnOLK/NrBEcB9WCgWwxk8e3LEjSlLI8LO2UHvYgQZ
 47HkY7jWCxmWjd+zcNXgzrwOEaALjfo6Qlg1AR6TNDl3oCb8SFpQ5C6aZQcoiTe6Bshmt3iifMI
 V2uRgh1zxWGfL8VfhmYLXv2tKrkFDslxxXLxhT/0+SxoJeA5/IsRudYFiWiSrJUkcbF3ihrrZrK
 Sqh2/p3o9N4864mCv2g==
X-Proofpoint-GUID: tfHeb_flF7O6OOb2RJRYK50BpkOxdIGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: BEBAB5079B2
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20338-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-08 at 09:19:11, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).
>
> In the AF flow-install path, flows that need more than 256 key bits

pw-bot: changes-requested

>> -static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
>> -				  u16 *x4_slots)
>> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
>>  {
>>  	struct npc_get_pfl_info_rsp *rsp;
>>  	struct msg_req *req;
>>  	static struct {
>>  		bool is_set;
>> -		bool is_x2;
>> +		u8 kw_type;
>>  		u16 x4_slots;
>>  	} pfl_info;
>Does caching this profile information in a static structure cause a data
>race across concurrent device instances?
>The accesses to this shared cache are protected by mutex_lock(&pfvf->mbox.lock).
>Since this is a per-device instance lock, multiple network devices could
>concurrently acquire their own independent locks and read or write the shared
>pfl_info structure.
>Could this lack of synchronization lead to torn reads, such as reading x4_slots
>as 0 if the compiler reorders the write to is_set before x4_slots?

PF request as thru mbox, and mbox message handling is serialized in AF. So there is
no scope for race.

