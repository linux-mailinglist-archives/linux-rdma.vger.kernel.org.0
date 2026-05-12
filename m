Return-Path: <linux-rdma+bounces-20445-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFY9GMmMAmrzuAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20445-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 04:13:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EFD518C14
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 392593045DD3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 02:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9033002A9;
	Tue, 12 May 2026 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LCu5a9nd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7C23372C;
	Tue, 12 May 2026 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551933; cv=none; b=jKAclcdWrdmdnVJPPfm3ZVIsjJ0OvDGYmlSOdk9EyRudXmTpPLWr9Yp8bQa7iySab5bWYEqe+KcusMDLnfgfZAeC6XEk+EUB38tNFYRuHINZyYVcQQS6Gj3sSjhmTggwbO7Ql3VVGfWPq+tIZiTX/pVElA6JJQJVaW8xQal/TjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551933; c=relaxed/simple;
	bh=dB7wodfmYyeBFfuqu+fr434xZE8Ot/avf0LWfJL+7BQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTvDqVYfJzo7NozKqP85ACM0+L/jUSHMGyuJUaRZTeBHhjS0nc+MFHHXlQ+QaTU25l6MOe7YWx5am2kKM4vSpNt2ioEYhtZ+bBjdsssT28h9avGLuNESwLjyosl8a2loSqYhNeert7Pu4BnTLqx6xh4CqI8gAMiTgEKfRwXCKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LCu5a9nd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6DVB032171;
	Mon, 11 May 2026 19:11:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=kydP5WknIupnQ7Cl8mM2hf5vz
	PgtnylcpjlH8tHygDs=; b=LCu5a9ndT6GNVPD9r1S7V6ioRuIyUytYM/+2IofFP
	XlaK/ke8SVSvK8wbj3flcefPQeVDfoTjs9GFgjpTujkyKOXc1ZIrMyn2zt0uDziq
	kknzirxt1lD6sH9xHGiBDh+qjMIMqfrAbxAJzcbyIOpDWDzXV9tVtKZN0uqOGtZC
	YSYo+tbbaSIubK2ts8TKLEKAH4WyTpX9s3bjPtsxmILONI6xstG07uNbtIYAjDpN
	ga/0JExhRSaBaDpB9eU3QrixI2ONgKLYFeCLfkirLuelND+SXK+k/aFOFwG/Puaf
	O8eUrkbK2KlGmw4GzVSDbrs9qjGogz/zhf6dnA6iKaAJw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e3nus8wam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 19:11:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 11 May 2026 19:11:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 11 May 2026 19:11:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 21D513F7075;
	Mon, 11 May 2026 19:11:38 -0700 (PDT)
Date: Tue, 12 May 2026 07:41:37 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>,
        "akiyano@amazon.com" <akiyano@amazon.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>,
        "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>,
        "brett.creeley@amd.com"
	<brett.creeley@amd.com>,
        "darinzon@amazon.com" <darinzon@amazon.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "idosch@nvidia.com"
	<idosch@nvidia.com>,
        "Vecera, Ivan" <ivecera@redhat.com>,
        "jiri@resnulli.us"
	<jiri@resnulli.us>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>,
        "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "tariqt@nvidia.com"
	<tariqt@nvidia.com>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 7/9] octeontx2-af: npc:
 Support for custom KPU profile from filesystem
Message-ID: <agKMWQFXv0SSJxL4@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-8-rkannoth@marvell.com>
 <IA3PR11MB89869B60A745F66E6C43A9E4E5382@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89869B60A745F66E6C43A9E4E5382@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Proofpoint-GUID: 8xLNq5TTRN-1K2Jb4SPu1xHQkXFGL-wG
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a028c65 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=aGKvhz9Wq4K746KUVQ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 8xLNq5TTRN-1K2Jb4SPu1xHQkXFGL-wG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAxOSBTYWx0ZWRfX8AI24YLKmyME
 2k1u+fu0wkPvbb+n09jl9KvYYSsAUD8Bp9cF6zDKkTJXBzJVGdXDV9bIJWnGiifmATzHgPFZ0FN
 5OhCrh2+CC7TNU8+/Kd7gIz5+2LEEIt9u6i8o9sTwAecid0WOQWarfa1kxiLwarlOSX8QB8HWcj
 0swfhqo5+vG3PvmpaNwyecOmqsta1m/zEpRNl2ONUiAfZgmsrvFHZuApILBjlHF6XvkDDCUkVmt
 /9XJ+50gMYS2cacokcE7b2Xq49LxCrG2Rksgl/wVUR5sfQIOKqJ5FxPqyF+Y9oH2o0giGmlM3f5
 pyesgoLh6abiuiNkH4V/zO4zoWO3E6LoIYErVBOqHqcTnBfcLuJLoJbFV3BHgKeYT8OhZT1plx+
 9CEIiYXDQB87zc1LxIVUzfzew47BcRInAqPUP4EINyfPASjVc80uuvcduS/ybq+bmVL4OQTUiCJ
 Yf2phWlSLfgmze9vt+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: B9EFD518C14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20445-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-11 at 17:25:39, Loktionov, Aleksandr (aleksandr.loktionov@intel.com) wrote:

> > +
> > +	npc_prepare_default_kpu(rvu, profile);
> > +
> > +	/* If user not specified profile customization */
> > +	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
> > +		return;
> > +
> > +	/* Order of preceedence for load loading NPC profile (high to
> > low)
> > +	 * Firmware binary in filesystem.
> > +	 * Firmware database method.
> > +	 * Default KPU profile.
> > +	 */
> > +
> > +	/* Filesystem-based KPU loading is not supported on cn20k.
> > +	 * npc_prepare_default_kpu() was invoked earlier, but control
> > +	 * reached this point because the default profile was not
> > selected.
> > +	 * No need to call it again.
> > +	 */
> It looks like comment contradicts with the code below?
> Isn't it?

No, there is no contradiction. Let me clarify the intent of the
comment.

npc_prepare_default_kpu() is called unconditionally at the top of
the function to ensure the hardware is always initialized with a
valid baseline KPU profile.

The strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN) check that
follows determines whether the user has explicitly requested a
non-default profile via the kpu_profile module parameter. If the
default profile name matches, we return early -- the job is
already done by npc_prepare_default_kpu().

However, if the user has specified a custom profile name,
execution continues past the early return. At that point, the
comment is clarifying that even though we are in the "custom
profile requested" code path, we must NOT call
npc_prepare_default_kpu() again -- it was already invoked above
and the HW is already initialized.

In summary: the comment is not describing what the code below
does -- it's explaining why npc_prepare_default_kpu() is
intentionally absent from the non cn20k-specific code path that
follows.

>
> > +	if (!is_cn20k(rvu->pdev)) {
> > +		if (!npc_load_kpu_profile_from_fs(rvu))
> > +			return;
> > +	}

