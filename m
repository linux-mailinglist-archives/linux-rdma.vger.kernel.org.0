Return-Path: <linux-rdma+bounces-20335-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OHKEgxAAWprSwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20335-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:33:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D8507396
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5E8300AB19
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 02:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79026B756;
	Mon, 11 May 2026 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cWnRH0+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2C1E885A;
	Mon, 11 May 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466819; cv=none; b=lB0Wo5zVT0SrUDJovq7Rl6dvFOFYr/ZcRnsHQCqYG+x/ySznUVq3N2QQrj33ZIGAB+M3Mnl0yqdJyDpoc5iw8NWvJ32T2kLvcj8UPN1Z1vacCPuLI33E2uNpq59FVF+iMos8iV9HaAJz20jMCmu+8iot9mNUfr+WO0bcaSOmxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466819; c=relaxed/simple;
	bh=fKVL3GCZ53TEZ1gLpCOFyYvEvWiau8B5Evv95ax0Nak=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDDQsMa9+FqhnV1laMxMvDThRbBoHKa70F1k+UX6s5ud8pm3Y205gl/bNHnsV454Ihb9v5F2GOoVSrw3ZBpeQI/XlEc8FgH86bQAvEumIrP8SCYCdLzXWRvIsqbXov/ZqkAJESBqOGWPlBwkevcMpkSMt3Hevt62d46G59MDzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cWnRH0+k; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B0TFmF2107588;
	Sun, 10 May 2026 19:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=E7k1SiMTgddEdvS+o9JlCHlnm
	x+uBEUCgdVe3wPU5FI=; b=cWnRH0+kcI9w0jTeTW3+dg3JAaIKVyvLFiT/JXkZv
	3zA1PpvDCnvkDWvZOXtd4OY2XnO2J+ODZA/d4qMhdIXPC3aZrgw2SYrQ8TmdwGxa
	Xjfzw1ACUaAqFWEWQaMI+L/5uG/UgKgnL4mBLULq8LJT9iz3ZKYx2ODNfp0JAX8x
	IxtLQYHiRemAKXhY1Ku6uaF20bYxpCMLeIP065j+ivW/9yleHo+49VqiJnqt5Z/S
	w3Z0E+sJtdqdO9l/EjW1vpBlBnVwa7C96Q33Vw5i3RzuXpHsm1xHseWIPOwA/xdG
	xfJlWiq9EOJKsHg7i87qw4fKRhgJHTWwM9iaEUfk1uuKQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e34kn85hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 19:33:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 19:33:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 19:33:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7D0E03F7088;
	Sun, 10 May 2026 19:33:00 -0700 (PDT)
Date: Mon, 11 May 2026 08:02:59 +0530
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
Subject: Re: [PATCH v12 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <agE_2zKOIiAwE1JK@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-6-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: aqMU2B7iCyHO4pdckuR03Oh6pTHnF-Ks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyNiBTYWx0ZWRfX7dGaMBetBX3V
 x9pMLFr5YvFpFreUEn3cPqPf7KQ+GMH1m9PeE7Q+xDc3SODdq6ZEzqApJunCFgP9WVF8keRWKqJ
 +55s61oOxSo2/h9mnZ8V8+SERJB1S0ctL45W7m9TmSyyENyZL+1op4+MwHVSH1EGggLXwl8h4+i
 DS4C1rlDYz6wV+mj195Fd5mnF0LejPW+5y1hgv1JzId81pa3z3YvyVVl1z9+U6PPFSqzX79OAZA
 TF551jRAOtru6VVvOOv7cGzEKcOqdlRW1JyoKmx4yL2i7R+VH9CV9Xsc17QaEPwSRssW8VNE3y/
 kurZPknaBF1qic4cob0elwssVTVqybHv4Ca3q8c/gO//rybJatfBNupuXQoWGdLNVSAj3Dq9NKB
 CwEYC2mp6XlJpWgQ7iZE7O02huchsTPnOxcfZnvYU4lH38ygKjN488Xq3/qThUEigcYo/8IMU0D
 kA1sqTD5Tk/fsnsmjsg==
X-Authority-Analysis: v=2.4 cv=cNfQdFeN c=1 sm=1 tr=0 ts=6a013fe6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=DhIbuZXnhKx70xO1yFEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aqMU2B7iCyHO4pdckuR03Oh6pTHnF-Ks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: A76D8507396
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20335-lists,linux-rdma=lfdr.de];
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

On 2026-05-08 at 09:19:08, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
pw-bot: changes-requested

> +	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
>> +		sb = &npc_priv.sb[sb_idx];
>> +
>> +		xa = &npc_priv.xa_sb_free;
>> +		if (sb->flags & NPC_SUBBANK_FLAG_USED)
>> +			xa = &npc_priv.xa_sb_used;
>> +
>> +		sb->arr_idx = narr[sb_idx];
>> +
>> +		rc = xa_err(xa_store(xa, sb->arr_idx,
>> +				     xa_mk_value(sb_idx), GFP_KERNEL));
>If the new index assignment swaps indices between a free subbank and a used
>subbank, is the old index in the original xarray ever overwritten?
>Since xa_erase() is not called on the old arr_idx, this might leave the
>subbank mapped at both its old and new arr_idx if they don't overwrite each
>other.
>Can this result in stale duplicate entries?
No. npc_cn20k_search_order_set() is only rearranging indexes in free and used subbank.
indexes wont move from free subbank to used subbank.

>If xa_store() fails (for example, due to -ENOMEM from GFP_KERNEL) and returns
>an error, the code jumps to the fail label. Are the successful modifications
>made to previously processed subbanks rolled back?
>If not, could this leave the system in a torn state where restrict_valid is
>false, and some subbanks have updated indices while others keep their old
>ones?
ACK, but, There is no way, we can gracefully rollback, as rollback can also fail due to memory
pressurem while reinserting old index using xa_store. This is fatal error, will add
a err print to alert user.

>> +					     union devlink_param_value *val,
>> +					     struct netlink_ext_ack *extack)
>> +{
>> +	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
>> +	struct rvu *rvu = rvu_dl->rvu;
>> +	bool restricted_order;
>> +	unsigned long w = 0;
>> +	u64 *arr;
>> +	u32 sz;
>> +
>> +	npc_cn20k_search_order_get(&restricted_order, &sz);
>> +	if (sz != val->u64arr.size) {
>> +		dev_err(rvu->dev,
>> +			"Wrong size %llu, should be %u\n",
>> +			val->u64arr.size, sz);
>The size field in devlink array values is a 32-bit unsigned integer (u32),
>but the error message uses the %llu format specifier.
>On some architectures, could this cause printk to consume 8 bytes from the
>arguments and read garbage from adjacent memory?
>> +		return -EINVAL;
>> +	}
No. %llu is used for val->u64arr.size, which is 64bit.

