Return-Path: <linux-rdma+bounces-18958-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JKrFkIhz2latAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18958-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:09:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCA3904CD
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 622C2305A4D1
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 02:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D584333BBBA;
	Fri,  3 Apr 2026 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XyNuG22n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778326ACC;
	Fri,  3 Apr 2026 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182011; cv=none; b=c/+eoOU3Gpy4f1E9sKZiqihuooPxEMmD7i2sMqvKDP/5Mc6L1ssvxoSzYo1rnjqUqHo5VpOpgFdovP56bJSux/tGFD2+9yOqZwm3GfwJlXayZvdYL7N9BaqFuYR9DANPyWt6NwoHdO10ZDde0NbOgPQvU9+GJQtj8yN0olC6VCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182011; c=relaxed/simple;
	bh=zpL7Z4cA3gzqnnHLqK4mDCBgL5JiK0mvSIr2u0kx/a8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGHJoQ+w9pFVBiN3niGqIbfxp1PFrrAkC+eXwQRU9ebPCUPGIc9ZkJFmhDjyFFX3cKkJCvwVMhI5uBjBJDSIckTEkxX7tVG8hFCHI1og8quKfHfP+KXojJg37pL8HO0U7h8GZVfOX0kLJviey7rnMqOUB6z+ovvSSvtkemmVafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XyNuG22n; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Kq7Dg3224583;
	Thu, 2 Apr 2026 19:06:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=n6m0iaL6+TA+2bBA4h71kvb4l
	zO2m6LkGK4trg4oNoM=; b=XyNuG22nJtfD2e0BaMRO52qCBcx9rsfdsJNFhA4CI
	rYov4JxE22gtpzIrKu1QIQHvWbTlRHYdKYzQL7DrZj7K9DNyt9hZ6rNCFG4hySMM
	yH40uYOAOVHmsVVpc97i4We8/V5KOfrZqKTb9muuTZPp3Jpzwy2g7RTHz9jot1BU
	qxGwQnkwiHu0WnRZBivo3r/GHHkpYHjckJc6BhwqocZXw+2W6W0fk6DetmxmuOPx
	x9xlSh3vpGmSdTbg0Gqmp8YFry4CS7/ksoQCmaxTE4WciIi/0CrxaLflESfu0u30
	w2YebRtRMqPcBpTNzAOGJ5MwLRY/Te2oj4ka5/lBRz7Jg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d9d29bfya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 19:06:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 2 Apr 2026 19:06:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 2 Apr 2026 19:06:05 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9584E3F7051;
	Thu,  2 Apr 2026 19:05:59 -0700 (PDT)
Date: Fri, 3 Apr 2026 07:35:58 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <donald.hunter@gmail.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
        <tariqt@nvidia.com>, <mbloch@nvidia.com>, <dtatulea@nvidia.com>
Subject: Re: [PATCH v9 net-next 6/6] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <ac8ghrqERVKUVQTL@rkannoth-OptiPlex-7090>
References: <20260330053105.2722453-1-rkannoth@marvell.com>
 <20260330053105.2722453-7-rkannoth@marvell.com>
 <ac20d8bc-4af5-4338-adc3-01e4aac4e70e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac20d8bc-4af5-4338-adc3-01e4aac4e70e@redhat.com>
X-Proofpoint-GUID: 2yZFCoE1si0Vcn-bXoWECcXzsn-Bnvb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAxNyBTYWx0ZWRfX8txY2HQWgLwU
 3bRnsz6KY11kfqBgzdQf7HMzYukUG1KJjBEzeocmnY+crU+7waEdVlvnbrscDvISNNtMOxKNtmh
 hvd8nqF59dz6RRllJsPidc78ZclWY+k+G4GgbrpFh1oMbab3pSEvWsWGzpTAyw5B/nTosUUW5ql
 ZbVx99FA7bh5bKUjBihyebIHT9Kpq3dvqYQgIgJEAazHDkseNlycK2iWb/KGrQV1ap3WjoX5W58
 EckH55as5eZeBKB/hnroCRBQSEgHF5vGuYxHQ0ZqWcej2kHTwWo0f5yU0oSJA3e212u5yzOhWuN
 FXjkqhG6twTc10iy8Ek2mc93SI0ocANC4DQpRyfyfGmEEr3TTjktljxWeLsyla6WPFS1T96aFDq
 PnHvWKPyOIf3NKYcwwgmBzB1WjlhcSQBTZqMQovcr855HQhO0YwgKRKiiAga7qWa2UfKKjYklkr
 eTz1RiaZTkFObZBUpng==
X-Proofpoint-ORIG-GUID: 2yZFCoE1si0Vcn-bXoWECcXzsn-Bnvb4
X-Authority-Analysis: v=2.4 cv=a9E9NESF c=1 sm=1 tr=0 ts=69cf208e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=vvFVjDzz9JgP-vgauNQA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18958-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C9CCA3904CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-02 at 14:24:42, Paolo Abeni (pabeni@redhat.com) wrote:
> On 3/30/26 7:31 AM, Ratheesh Kannoth wrote:
> Also there are several remarks for sashiko, some of them looks valid:
>
> https://sashiko.dev/#/patchset/20260330053105.2722453-1-rkannoth%40marvell.com
>
> please a look.

> +static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
> +static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
> +{
[ ... ]
> +			stats = rvu_read64(rvu, blkaddr,
> +					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
> +			if (!stats)
> +				continue;
> +			if (stats == dstats[bank][idx])
> +				continue;
[ ... ]
> +			seq_printf(s, "%u\t%#04x\t%llu\n",
> +				   mcam_idx, pf, delta);
> +			dstats[bank][idx] = stats;
> +		}
> +	}
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(npc_mcam_dstats);

"Can this cause truncated output if the printed data exceeds the initial
seq_file buffer?
When seq_read() encounters a buffer overflow (typically at 4KB), it
discards the buffer, allocates a larger one, and re-invokes the show
callback from the beginning. Since the global dstats array is updated
during the first partial run, won't the retry skip those previously
processed entries due to the "stats == dstats[bank][idx]" check?
Also, since the dstats array is modified here without any locks, will
concurrent reads of this debugfs file race and corrupt the statistics?"

dtsats is for debugging. Evenif the first time it fails, second time it will
show the correct stats as live traffic will update stats.

>  free_rules:
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return;
>
> -	free_req.hdr.pcifunc = pcifunc;
> -	free_req.all = 1;
> -	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
> -	if (rc)
> -		dev_err(rvu->dev,
> -			"%s: Error deleting default entries (pcifunc=%#x\n",
> -			__func__, pcifunc);
> +	for (int i = 0; i < 4; i++) {
> +		if (ptr[i] == USHRT_MAX)
> +			continue;
> +
> +		mutex_lock(&mcam->lock);
> +		npc_mcam_clear_bit(mcam, ptr[i]);
"Could this lead to a double-free corrupting the free-count metadata?
If a VF or DPDK application manually frees a default MCAM entry prior to
teardown using the NPC_MCAM_FREE_ENTRY mailbox message, the bit is cleared.
When NIX LF teardown runs here, it calls npc_mcam_clear_bit() again. Because
npc_mcam_clear_bit() unconditionally increments mcam->bmap_fcnt++, doing so
twice on the same index corrupts the free-count metadata."

default entries are alloated and freed by kernel.

>
> Thanks,
>
> Paolo
>

