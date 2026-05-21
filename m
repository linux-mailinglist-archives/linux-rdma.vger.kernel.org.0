Return-Path: <linux-rdma+bounces-21073-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDUlNBN+Dmp9/AUAu9opvQ
	(envelope-from <linux-rdma+bounces-21073-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:37:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7359E809
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1EAA30285D0
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 03:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B08299959;
	Thu, 21 May 2026 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CKmdplC4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AEF41760;
	Thu, 21 May 2026 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334672; cv=none; b=l1cOBqp8JWDlwekowNUG7wYryf1rbN2xFBYbXxlQy0qmpCE7NzEv19bOXl+Ef0lAQOjSQnKIFoeMpguRNjuGwgbjhgFOWUKFrlLSJf9ZNIFUgyyVr5x+wjJMmSE3u2X7i8cAsMiATEF/MA7HvwrZyjwRfmNkFLrJ0/z1SxUFW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334672; c=relaxed/simple;
	bh=Mj9wCkYjJppxAWQ8gMaFIE5lfCMFDTiNm4XW2lCfClk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7c5Xabmn0AL2mWVDBF6xRVd88cGWajN0fZEYVTtM7cZpu185bNx8AHldqprOV2iUMu1IQtFCQYPIcsQkam6T5+gXYRI9VqhTluLTi91ADcMmmhhyQhBbw69znDcDxvz/pryxbxlhWPsqakjFK4DgjiC29R5fe9WyGPUhbCebc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CKmdplC4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1kR4Q2255589;
	Wed, 20 May 2026 20:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=VQO+HTmU8DQBpYcH9qlT/yIto
	wPkhtgzHbtDFVspnV8=; b=CKmdplC4wemNH/66IOhRAcdz3hbb2BTBFtrBMQfJB
	GbDvpEsQuY/HYg7FgGfEyohuqENayvqdNSjrOedtsXhHUbzEgduCl7PJPal3XA8N
	Do2GM+ifeCljp91wm1tlcowp/vnm4axC9KN3bV/9xmuZlhLP1nILDzy+OYE5Id5i
	7/o5/FgFpGgmq+zTF1QoPXR6TEk7ANsoEu/pTtPbH55pfDOkXlu3/wjZqm9pMkow
	Z90bP8wGP40XxnvLxuA4vnzBhrwyx0lGLW7YZb/7RjK9WJzUtNO73YUUWp1jS0ok
	72Zl+DCuNWnGzQY2cPBSCHaHRkaLwRGtb23KuhTL7PmiA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94eukrys-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 20:37:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 20:37:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 20:37:29 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3E38C3F704B;
	Wed, 20 May 2026 20:37:21 -0700 (PDT)
Date: Thu, 21 May 2026 09:07:20 +0530
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
Subject: Re: [PATCH v15 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <ag598KDo6M6L2SGL@rkannoth-OptiPlex-7090>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
 <20260520020939.1457231-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520020939.1457231-9-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzMSBTYWx0ZWRfXySNCXqL1KYH/
 rk6tKyYbWKygVgHIHh6/0TttPkpV+be3Eb83w4wI3rD2GcwIeuntHsB7kWW7F5xzf5PMNV+Clge
 tUxNnxT2s5s+niuTn9M/l5K+ydRq3PvsyjH9igHb4rVQRp/dHzWpTAae8FrTEr7z/AYLIJc5iaH
 d/H8Qt2KdSt19to3BsAoJEvYJYnvBDrFQDbpo65kjhDIMKhH2TuJOUirlRxqgO2wzPn2a5+fyHG
 eepuwq4oVUhfuslLE44xU7fUl7AY61/EfC8QQkHhnE/WB5fr2T7AzjciHkY6cC4oWRCTCkI2pRa
 e4Tkn4e2qjiFg8iI6LVhCFcDvGw7sE6U4/nCqenDeLDGWPO4a9nPNgft1ALL0Pd7PAPmTeFclFT
 G2Bo+SQnu0IjBN1krx5B1IhiDqN2nxHdraKritp7MLV1wYZz/1CMNbiBZi7at4F7ApkWkKym65A
 91/Xjgg29L2gbj2y7EQ==
X-Proofpoint-ORIG-GUID: UbOpu-nmWalsTyUnfne68QSZD-TY6U5g
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0e7dfb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=Ksljdq0qqdrR6CwtxMEA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: UbOpu-nmWalsTyUnfne68QSZD-TY6U5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
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
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21073-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 44E7359E809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-20 at 07:39:38, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).
>

>This commit updates the default CN20K NPC rule allocation to use X4 with a
>bank-masked reference index when the silicon uses X4 keys. It also queries
>the NPC profile in the AF flow-install path to select the correct key width
>and fails if an unsupported X4 allocation is requested on an X2 profile.
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> index 6ae9cdcb608b0..d20eb0e47d7d8 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>[ ... ]
>> @@ -1697,8 +1699,16 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
>>  	kw_bits = kws_rsp.kws * 64;
>>
>>  	*kw_type = NPC_MCAM_KEY_X2;
>> -	if (kw_bits > 256)
>> +	if (kw_bits > 256) {
>> +		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
>> +		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
>> +			dev_err(rvu->dev,
>> +				"Only X2 entries are supported in X2 profile\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		*kw_type = NPC_MCAM_KEY_X4;
>> +	}
>>
>>  	memset(&entry_req, 0, sizeof(entry_req));
>>  	memset(&entry_rsp, 0, sizeof(entry_rsp));
>This is a pre-existing issue, but does this dynamic upgrade to an X4
>key type correctly mask the reference index?

There is no dynamic profile change support.
If an application attempts to request a key configuration
(such as X4 width requirements) in
running X2 profile, the driver rejects the request outright with -EOPNOTSUPP.

>Further down in this function, entry_req.ref_entry is assigned directly
>from fl_req->ref_entry. If the reference index came from a previously
>installed X2 flow, it might be in the larger X2 space. When passed to the
>allocator without being masked against the X4 bank depth, could it trigger a
>bounds check failure and permanently fail valid X4 flow installations?

As mentioned above, there is no dynamic profile switch support

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
>This is a pre-existing issue, but could this function-local static cache
>lead to data races and incorrect hardware capability sharing?
>The pfl_info structure is static, but it is protected by
>mutex_lock(&pfvf->mbox.lock), which is an instance-specific lock. If multiple
>NICs probe concurrently, couldn't they enter this critical section
>simultaneously and cause a data race?
>Also, since the first device populates this global cache, will subsequent
>NICs incorrectly use the first NIC's profile data instead of querying their
>own hardware capabilities?

The 'pfl_info' structure caches global
NPC hardware profile parameters queried directly from the Admin Function (AF)
driver. These properties are invariant and bound to the fixed system-wide SoC
hardware profile configured at boot time. There is no dynamic runtime
reconfiguration or profile switching supported.

>> @@ -289,6 +291,8 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>>  	struct npc_mcam_alloc_entry_rsp *rsp;
>>  	int vf_vlan_max_flows, count;
>>  	int rc, ref, prio, ent;
>> +	u8 kw_type = 0;
>> +	u16 x4_slots;
>>  	u16 dft_idx;
>>
>>  	ref = 0;
>This is a pre-existing issue, but is there a potential use-after-free
>if the firmware returns an allocation count that differs from the requested
>count?
>Later in this function, if rsp->count != req->count, the driver frees the
>array via devm_kfree(pfvf->dev, flow_cfg->def_ent) but does not set the
>pointer to NULL, and returns 0 (success):
>if (rsp->count != req->count) {
>        ...
>        devm_kfree(pfvf->dev, flow_cfg->def_ent);
>        return 0;
>}
>Since it returns success, the device probe completes. If an administrator
>subsequently changes the MCAM count via devlink, it invokes
>otx2_alloc_mcam_entries(), which unconditionally reads from the freed array:
>        if (!is_otx2_vf(pfvf->pcifunc)) {
>                req->ref_prio = NPC_MCAM_HIGHER_PRIO;
>                ref = flow_cfg->def_ent[0];
>        }
>Could this trigger a use-after-free from userspace?
ACk,Pre exsting issue. it is a fix and will be sent as a seperate patch to "net" tree once this patch
series is merged.

