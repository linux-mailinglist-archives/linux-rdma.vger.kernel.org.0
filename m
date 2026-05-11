Return-Path: <linux-rdma+bounces-20337-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAhALN9LAWqnUAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20337-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:24:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E2050796D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB6C300A633
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8AD37BE95;
	Mon, 11 May 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bGieu43T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EB376BC5;
	Mon, 11 May 2026 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469841; cv=none; b=ivYUkJvwU/azldxekHsmf0jGQNBKWICSfY3SCMDfik/aA1SvS6M/yziaiAz7IDAtE+w4pnLkC6b3UgHhr7bGX49xbpOOjIWXgNodhcPyylcTyuzTASdu/U147vP+OW3qu+V87NqykRXgG4R2eqQSf74qSNyakhO1mczuZKFYvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469841; c=relaxed/simple;
	bh=z28QR04hweuh0CCEJIc4ueduDk+exK8o0mblFI6n3zE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STlY6CS2P+2jDeOQU82+NyeBBA1nr6NkKCS2YRQgWY3cYoJ1l5OD4brIlyMNGzRZRyqY5LPxZbfUvXxoTLS53/0ui94rtrciW1b4qTHt/4sZJaYxq1rJWZ4ozooVdIZ3pC9jIpaJFUd3ZVu6ZhQHaHnvfCXof73+a6oYtdWl+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bGieu43T; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B0uvZ02153582;
	Sun, 10 May 2026 20:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=l6gfg54IftcEb6QLIMve9bgrh
	XIY6NVvWV2lujfC7xo=; b=bGieu43TqXXuAc4WLceNG1yoDZDQ1Wc6cHVbiZR/R
	3pMI75N0df24gXovAEYMKW398HMQkiPAEGLkDzdYqu7ZhOgbO5qAKCaXldtapQlR
	Or6Zp7xx0m4ZsNGr/3FDHiqulmRl/qPMop1PRtoFAq127vKLMDJW7tI7iLhNbTmR
	Ma/wgZCxX+O1mH8UC0eHv0njP5DIW0SYl00VvBP5a5CwKrjcycz2gE+4MnEFs6ye
	nc4gPybiuB0PG3gSszwhBsLxWU6j/VcngApbVfPj7fWFryTJ6Jb5x5OBsVl8GBYF
	Si7NXiXbzdJuo45iwL1XuwjEggMdrgtxZ4ZSsrJZFRnTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e34kn87rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 20:23:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:23:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:23:32 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DF55A3F708D;
	Sun, 10 May 2026 20:23:23 -0700 (PDT)
Date: Mon, 11 May 2026 08:53:22 +0530
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
Subject: Re: [PATCH v12 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <agFLqlZCNOjhb2mW@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-8-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: _57bHlIqKkCet3bb_N40MVmAu_AE1zby
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNCBTYWx0ZWRfXwJmaH3Vy2nIQ
 Gc88x7OtcYVwqLUffFwEhtqMS/u//4p5/UX5DY2kGtzhgFn8L4bA50dVKAIe1ccnLyn+pI8cNyl
 H0gPMuKYLD62Z7/M2dlohYbLR+WtVvXa/ZUppOj0lz6uh1HnDNb0cv1uUAvR4lLRMrhHUSylzry
 7KHHZeIBhI+KXgJWR5Rl4aCNvLVfA6+kNyntvvESGoZNYNfYMWxJUNVDgmJkWJ1o7Wci7x181ii
 aF2sRsRjPTI30kvU2dkg/UIx8MVmN8crKz2dYrrJzs6eq828JsTvtufIS9jVcmcHegAeoLtl3kq
 LYIpsPCy/+5FxR8jMEKcR07e6pK4P57wu8t2Q07kSBNbe1H7ROQcWa/9kOkfSpNu2AT72SyrD8W
 mT01VAxnDueEa9KImWHeZRabFp6YbeYxndIW5yOvnvM91Lyc5G6CB16QOIzLk1r05hg9zf4HTtO
 DUiuAYqaGOJMSY9SUdQ==
X-Authority-Analysis: v=2.4 cv=cNfQdFeN c=1 sm=1 tr=0 ts=6a014bb5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=6Uc7TgH-81yiOY1GMCsA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: _57bHlIqKkCet3bb_N40MVmAu_AE1zby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 16E2050796D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20337-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-08 at 09:19:10, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in
> npc_config_kpucam when profile->from_fs is set.
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

