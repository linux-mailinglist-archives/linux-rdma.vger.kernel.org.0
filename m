Return-Path: <linux-rdma+bounces-20634-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCAHJa1MBWoIUgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20634-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:16:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F400B53D9D4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612B5304F23C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C303AE194;
	Thu, 14 May 2026 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AIThA5N+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FE3A5430;
	Thu, 14 May 2026 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732137; cv=none; b=hxyBRLBKoX4GB7HF7LnmpsepXZct9yvbo1Ox9Jn/KMp+Xr5l4pCXA7DRMZWWdvGE1CxWwiuicXgtnT7wnVg2e5VPBrvQxYL129VHwGj4+6EJo9eRI8Gis1PqmqKKjB/urVFw9kNFJIhCeMxRolkrY2/77ms6adpE17HT2Pi5PGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732137; c=relaxed/simple;
	bh=sGalwIsoY51ljJXdihYw2Tui50cE7ukMnFYT5YmTTeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyB4q0jRCy4ExK56gYmYb/bo6q5n/JzbJf0KcBN7ZtST66k23DjPX9SWSx90RzRS8srjZ9wSJR8nNPYq7gEkJdjwpr95t9ooVKtvpHi8ZsDsiMMAwND6fqgWe+pv8VCfGX7NLuhXsh82a4WOFqah2TvFQeza+Mtnnx+mJr5FypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AIThA5N+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E31RvC2549970;
	Wed, 13 May 2026 21:15:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=r3aDbYL6vUUx19NwfVVZLkh8l
	5Cd0tuMQ0CZ+Qeif40=; b=AIThA5N+Lb/YMGBSQ1bW6i0cZCZaGidy/yLW73beF
	nUT/dejZDHEy7W4DfudvF0HZRNl1g6Wxs3CeNu7DRtk9QxHitYRWb7bzls4o4W8I
	0jJUxuBFdtQeDbmvbko44+YU9XjL9a7fKvC2Vcqq+2AUBJhXT8nXauScTS23GLH0
	JdJD5u6gasG/5vGuBEG1UgVlwtFedNrx9D4x5OcnLEIpp8v3VcahrczPaidOgOAs
	Km4Nhz8g9/R3T/eBWP+O7n+APs7Rd2QQ+kcT30AvYAj7wDGBVZY8mfO33+OBv9LS
	zXnz4yn3nEheun/N4lYHAkGLHZbviOMi+rorK+It9oHMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e45ybdubp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 21:15:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 21:15:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 21:15:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 813815B6938;
	Wed, 13 May 2026 21:14:52 -0700 (PDT)
Date: Thu, 14 May 2026 09:44:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
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
Subject: Re: [PATCH v13 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <agVMOzk9WhLvgXYW@rkannoth-OptiPlex-7090>
References: <20260511033923.1301976-1-rkannoth@marvell.com>
 <20260511033923.1301976-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511033923.1301976-9-rkannoth@marvell.com>
X-Proofpoint-GUID: v01W4DoBFcy66W4jTOZ5VT9iFySjrkHk
X-Proofpoint-ORIG-GUID: v01W4DoBFcy66W4jTOZ5VT9iFySjrkHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzOCBTYWx0ZWRfX3sGxgTUqlu/4
 PIFvR1NarJGGYPyASi175bliOOTJbXvYYeHpzddXpxrtfGcVlyJdmCcnZekmHI/KJm14mkGWLw4
 SNzAitmyf+7ZiQRAJakdMVW5JyPV4d8qs1v88923mMIn0huovujWQJ3QpFbGEW5cQWM7OrbjmHB
 pJlw2uBblMej//NiUd78F2QOrcuKZoOqsAJYJuHMAO+bERCFlLPH+L76V4nFAbhnuHDTGE+oAEh
 WCgg/2FaflcpCtHBTIM3MDGeHt2/QwAVDGvgj39aSwMTnUnaoAFJ9boDbxPnjdT9CFUzC/SDPZB
 gpy8KEq4OVlYA96WhogGyqQNKXRyUTxXanDUgW0rqjH0FBkZZ8473MscQLgrTgmi03LzZmYi2Qp
 KbPEVRPcd/PTnChkMkmi5Mx0rngJwvGx/cu+dSdnp4x8Zcr2sQx/ke1oz+Bvz4oUifqxnX8n653
 1Kc+cSZQCgGkwsySUHA==
X-Authority-Analysis: v=2.4 cv=ZtTd7d7G c=1 sm=1 tr=0 ts=6a054c45 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=fCIphdZVNb5Y-s_u9r8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: F400B53D9D4
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,npc_priv.kw:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20634-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
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

On 2026-05-11 at 09:09:22, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).

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
>>
>> @@ -53,8 +52,8 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
>>  	 */
>>  	mutex_lock(&pfvf->mbox.lock);
>>  	if (pfl_info.is_set) {
>This isn't a bug introduced by this patch, but caching device properties in
Since this is not a bug in this patch, not planning to address as part of this series.

>> @@ -164,6 +163,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
>>  	u16 dft_idx = 0, x4_slots = 0;
>>  	int ent, allocated = 0, ref;
>>  	bool is_x2 = false;
>> +	u8 kw_type = 0;
>>  	int rc;
>>
>>  	/* Free current ones and allocate new ones with requested count */
>> @@ -182,12 +182,14 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
>>  	}
>>
>>  	if (is_cn20k(pfvf->pdev)) {
>> -		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
>> +		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
>>  		if (rc) {
>>  			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
>>  			return rc;
>>  		}
>This is an existing issue on this code path, but if otx2_mcam_pfl_info_get()
>fails here, or if otx2_get_dft_rl_idx() fails below, the function returns
>early without updating flow_cfg->max_flows.
Since this is not a bug in this patch, not planning to address as part of this series.

>> @@ -1174,15 +1192,14 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
>>  #ifdef CONFIG_DCB
>>  	int vlan_prio, qidx, pfc_rule = 0;
>>  #endif
>> +	bool modify = false, is_x2;
>>  	int err, vf = 0, off, sz;
>> -	bool modify = false;
>>  	u8 kw_type = 0;
>>  	u8 *src, *dst;
>>  	u16 x4_slots;
>> -	bool is_x2;
>>
>>  	if (is_cn20k(pfvf->pdev)) {
>> -		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
>> +		err = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
>>  		if (err) {
>This is another existing issue in this function. If we trace further down
>in otx2_add_flow_msg() after the mailbox message is allocated:
>    req = otx2_mbox_alloc_msg_npc_install_flow(&pfvf->mbox);
>    ...
>    vf = ethtool_get_flow_spec_ring_vf(ring_cookie);
>    if (vf > pci_num_vf(pfvf->pdev)) {
>        mutex_unlock(&pfvf->mbox.lock);
>        return -EINVAL;
>    }
>Does this error path abandon the partially constructed message in the mailbox
>queue? Would adding a call to otx2_mbox_reset(&pfvf->mbox.mbox, 0) before
>returning prevent this incomplete message from being transmitted during the
>next mailbox sync?
Since this is not a bug in this patch, not planning to address as part of this series.

>
> In the AF flow-install path, flows that need more than 256 key bits
> query the NPC profile; if the platform is fixed to X2 entries, fail
> with -EOPNOTSUPP instead of requesting X4. Otherwise select X4 for the
> MCAM alloc.
>
> On the PF, cache and pass the profile kw_type from npc_get_pfl_info
> through otx2_mcam_pfl_info_get(), and use it when allocating MCAM
> entries for RSS/defaults and when installing ethtool flows on CN20K,
> including masking the reference index for X4 slot layout.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 21 ++++++--
>  .../marvell/octeontx2/af/rvu_npc_fs.c         | 12 ++++-
>  .../marvell/octeontx2/nic/otx2_flows.c        | 48 +++++++++++++------
>  3 files changed, 61 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 88cfa6c67266..ff5baedbc122 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -4438,10 +4438,16 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
>  	pfvf = rvu_get_pfvf(rvu, pcifunc);
>  	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
>
> +	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
> +		req.kw_type = NPC_MCAM_KEY_X4;
> +		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
> +	} else {
> +		req.kw_type = NPC_MCAM_KEY_X2;
> +		req.ref_entry = eidx;
> +	}
> +
>  	req.contig = false;
>  	req.ref_prio = NPC_MCAM_HIGHER_PRIO;
> -	req.ref_entry = eidx;
> -	req.kw_type = NPC_MCAM_KEY_X2;
>  	req.count = cnt;
>  	req.hdr.pcifunc = pcifunc;
>
> @@ -4471,11 +4477,18 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
>  	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
>  	 */
>  	req.contig = false;
> -	req.kw_type = NPC_MCAM_KEY_X2;
>  	req.count = cnt;
>  	req.hdr.pcifunc = pcifunc;
>  	req.ref_prio = NPC_MCAM_LOWER_PRIO;
> -	req.ref_entry = eidx + 1;
> +
> +	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
> +		req.kw_type = NPC_MCAM_KEY_X4;
> +		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
> +	} else {
> +		req.kw_type = NPC_MCAM_KEY_X2;
> +		req.ref_entry = eidx;
> +	}
> +
>  	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
>  	if (ret) {
>  		dev_err(rvu->dev,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 6ae9cdcb608b..d20eb0e47d7d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1671,9 +1671,11 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
>  {
>  	struct npc_mcam_alloc_entry_req entry_req;
>  	struct npc_mcam_alloc_entry_rsp entry_rsp;
> +	struct npc_get_pfl_info_rsp rsp = { 0 };
>  	struct npc_get_num_kws_req kws_req;
>  	struct npc_get_num_kws_rsp kws_rsp;
>  	int off, kw_bits, rc;
> +	struct msg_req req;
>  	u8 *src, *dst;
>
>  	if (!is_cn20k(rvu->pdev)) {
> @@ -1697,8 +1699,16 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
>  	kw_bits = kws_rsp.kws * 64;
>
>  	*kw_type = NPC_MCAM_KEY_X2;
> -	if (kw_bits > 256)
> +	if (kw_bits > 256) {
> +		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
> +		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
> +			dev_err(rvu->dev,
> +				"Only X2 entries are supported in X2 profile\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>  		*kw_type = NPC_MCAM_KEY_X4;
> +	}
>
>  	memset(&entry_req, 0, sizeof(entry_req));
>  	memset(&entry_rsp, 0, sizeof(entry_rsp));
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 38cc539d724d..5dd0591fed99 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -37,14 +37,13 @@ static void otx2_clear_ntuple_flow_info(struct otx2_nic *pfvf, struct otx2_flow_
>  	flow_cfg->max_flows = 0;
>  }
>
> -static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
> -				  u16 *x4_slots)
> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
>  {
>  	struct npc_get_pfl_info_rsp *rsp;
>  	struct msg_req *req;
>  	static struct {
>  		bool is_set;
> -		bool is_x2;
> +		u8 kw_type;
>  		u16 x4_slots;
>  	} pfl_info;
>
> @@ -53,8 +52,8 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
>  	 */
>  	mutex_lock(&pfvf->mbox.lock);
>  	if (pfl_info.is_set) {
> -		*is_x2 = pfl_info.is_x2;
>  		*x4_slots = pfl_info.x4_slots;
> +		*kw_type = pfl_info.kw_type;
>  		mutex_unlock(&pfvf->mbox.lock);
>  		return 0;
>  	}
> @@ -79,16 +78,16 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
>  		return -EFAULT;
>  	}
>
> -	*is_x2 = (rsp->kw_type == NPC_MCAM_KEY_X2);
> -	if (*is_x2)
> -		*x4_slots = 0;
> +	pfl_info.kw_type = rsp->kw_type;
> +	if (rsp->kw_type == NPC_MCAM_KEY_X2)
> +		pfl_info.x4_slots = 0;
>  	else
> -		*x4_slots = rsp->x4_slots;
> -
> -	pfl_info.is_x2 = *is_x2;
> -	pfl_info.x4_slots = *x4_slots;
> +		pfl_info.x4_slots = rsp->x4_slots;
>  	pfl_info.is_set = true;
>
> +	*x4_slots = pfl_info.x4_slots;
> +	*kw_type = pfl_info.kw_type;
> +
>  	mutex_unlock(&pfvf->mbox.lock);
>  	return 0;
>  }
> @@ -164,6 +163,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
>  	u16 dft_idx = 0, x4_slots = 0;
>  	int ent, allocated = 0, ref;
>  	bool is_x2 = false;
> +	u8 kw_type = 0;
>  	int rc;
>
>  	/* Free current ones and allocate new ones with requested count */
> @@ -182,12 +182,14 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
>  	}
>
>  	if (is_cn20k(pfvf->pdev)) {
> -		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
> +		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
>  		if (rc) {
>  			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
>  			return rc;
>  		}
>
> +		is_x2 = kw_type == NPC_MCAM_KEY_X2;
> +
>  		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
>  		if (rc) {
>  			netdev_err(pfvf->netdev,
> @@ -289,6 +291,8 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>  	struct npc_mcam_alloc_entry_rsp *rsp;
>  	int vf_vlan_max_flows, count;
>  	int rc, ref, prio, ent;
> +	u8 kw_type = 0;
> +	u16 x4_slots;
>  	u16 dft_idx;
>
>  	ref = 0;
> @@ -315,6 +319,16 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>  	if (!flow_cfg->def_ent)
>  		return -ENOMEM;
>
> +	kw_type = NPC_MCAM_KEY_X2;
> +	if (is_cn20k(pfvf->pdev)) {
> +		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
> +		if (rc) {
> +			netdev_err(pfvf->netdev,
> +				   "Error to get pfl info\n");
> +			return rc;
> +		}
> +	}
> +
>  	mutex_lock(&pfvf->mbox.lock);
>
>  	req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&pfvf->mbox);
> @@ -324,6 +338,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>  	}
>
>  	req->kw_type = NPC_MCAM_KEY_X2;
> +	if (is_cn20k(pfvf->pdev) && kw_type == NPC_MCAM_KEY_X4) {
> +		req->kw_type = NPC_MCAM_KEY_X4;
> +		ref &= (x4_slots - 1);
> +	}
>  	req->contig = false;
>  	req->count = count;
>  	req->ref_prio = prio;
> @@ -1174,15 +1192,14 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
>  #ifdef CONFIG_DCB
>  	int vlan_prio, qidx, pfc_rule = 0;
>  #endif
> +	bool modify = false, is_x2;
>  	int err, vf = 0, off, sz;
> -	bool modify = false;
>  	u8 kw_type = 0;
>  	u8 *src, *dst;
>  	u16 x4_slots;
> -	bool is_x2;
>
>  	if (is_cn20k(pfvf->pdev)) {
> -		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
> +		err = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
>  		if (err) {
>  			netdev_err(pfvf->netdev,
>  				   "Error to retrieve NPC profile info, pcifunc=%#x\n",
> @@ -1190,6 +1207,7 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
>  			return -EFAULT;
>  		}
>
> +		is_x2 = kw_type == NPC_MCAM_KEY_X2;
>  		if (!is_x2) {
>  			err = otx2_prepare_flow_request(&flow->flow_spec,
>  							&treq);
> --
> 2.43.0
>

