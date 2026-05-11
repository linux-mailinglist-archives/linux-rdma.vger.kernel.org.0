Return-Path: <linux-rdma+bounces-20334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOr3LL4/AWprSwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:32:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A6507370
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D603007673
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C351E885A;
	Mon, 11 May 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eNmJTldL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DB2F8E8A;
	Mon, 11 May 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466747; cv=none; b=Dvu9qP8hKePEZ2JvZhXG7aP4KkjM4QPmVdA3nHVc+2Ixif/X3XSe7ilIIlslb2+FT1iGYnxPmNXAcA5x2WKIpFzKwWQAjb/ZbvF51cCr4dIvlUEZDTIrtpA/LorTdbEoDTbIBYxsgmGteTNeJqXmrZ7PucRlTo74iWp1tEdUrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466747; c=relaxed/simple;
	bh=XhjGTrZ118imXVFCPYnRIvkEhIQUuRZDWCoAooXfWk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+apohmdIMLiD7k60VjFkj+q6sFQEv60MxAObm9RidVdIejFIQkA3p/+U6Pb3NAjrmxy0HVzFA+wjkdyggdIdrOtpdzXu2duAZXo6qwIGJvj3D0aFrecTHM1f31cCVgrXECMXidRxLEAAVQRVqzyhLOQESa+gtagw2MHG35Uif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eNmJTldL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B0ikgR2133290;
	Sun, 10 May 2026 19:31:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Fx4jM/eCLSzhdCMRG0qXyGASn
	2dR9UyyBS199+OF+Og=; b=eNmJTldLKIHjwuVR6oM2wTAMns30Ug6V2RH0qnHsB
	QBN0U4u0avNWSPmhX3dfcRdUChOSrQg2mBLwa3bB7sR43OFqdxhShg8+RxVmL2A8
	WJ3+gDg9V9PpWQ4XhT+kqsddTco59Mn6cPoL1bYkVQIJ49NMj4Oko66/j/Jt8qCV
	9GPIfQ53ultM4H/JGiaYLLlAiHQfkdwMqB/MNI9vNDCfpAAoSTZZTL66zjRcbILn
	1XdnzzNq/aoOAgxZMwn+htzFhyiN6TKUHlWQ13TXnQb6Q8HWG5SiAefpxU3/4qKj
	2lc+YpMXPb4MSypna4vKI9pAqUfQA/5RYkaT5rs6kvQSw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e34kn85fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 19:31:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 19:31:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 19:31:41 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 241DF3F7088;
	Sun, 10 May 2026 19:31:31 -0700 (PDT)
Date: Mon, 11 May 2026 08:01:30 +0530
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
Subject: Re: [PATCH v12 net-next 4/9] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <agE_gvJUphZOQ4vY@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-5-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: TfGtu6GAkrw2IK-s1tUzB-SiCHQPXzyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyNiBTYWx0ZWRfX8FjbBl3JgtHy
 DPNeWbSICECBwrvNpirTC01k4ai0hlghDHrECh6PluVOPhbILWAkaNGXGBBvN//eMjkaDAzcIPQ
 GvUZcJ2HTu3TPmQVw2ei4BLz4xIH0FL6tIRdmIUzodeWKs6+z6UzqLRFQMZgamCgSt0QhWklNS1
 dhN/4pOPQna6nrvu9KhybQ0pPG+Ptm1rWYo9IW7aio7pPipQAhagNcjGSGVXoh9yqbsKIQ2ibhd
 +e4hh5yo74CO/W+Qrjqd7rf2Tve+M8057eCSmp0y9jfIUnMWmDW2Oiq/XmQyiC4bd0uUCq92gjM
 cuiCvm2l0r/r34RvAvfI8c1b0oopQ5qcDDBmdYN0xOP46npPHdfuQ2rwX3IHnHSebjTjAunor21
 uxku1fU/JptjfykJiOVZ6TjoGbxOCOmQbt7p/CALB7kdijb/UY0zQ08/dJw/UMHjTNiSe0BTFTh
 lwCxV12AdrxcsQwyzMQ==
X-Authority-Analysis: v=2.4 cv=cNfQdFeN c=1 sm=1 tr=0 ts=6a013f8e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=Ikd4Dj_1AAAA:8 a=3myhGO0DrLiAD-WPr5oA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: TfGtu6GAkrw2IK-s1tUzB-SiCHQPXzyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 2F0A6507370
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20334-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-08 at 09:19:07, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>
>Separately, the commit message justifies this new UAPI type only with
>"without breaking any policies".  DEVLINK_VAR_ATTR_TYPE_BINARY already
>exists and can carry an arbitrary-length payload in a single
>attribute.  Could the commit message say why BINARY (with a small
>in-payload framing) was not sufficient, given that a new UAPI enum
>value is permanent?
This is for array of UINT32 or UINT64 types. And commit message clearly mention the same.

>Also, the 32-element cap and the fact that elements are encoded as
>repeated top-level DEVLINK_ATTR_PARAM_VALUE_DATA attributes (rather
>than nested) are not mentioned anywhere userspace-visible.  Would it
>make sense to add a short section to Documentation/networking/devlink/
>covering the encoding, the per-element width rules, and the maximum
>element count so that iproute2 devlink, ynl and third-party libraries
>can implement this without reading the kernel source?
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY defined in include/uapi/linux/devlink.h, which is uapi.

>Does adding u64arr to this union bloat every instance of union
>devlink_param_value?
>Before this change the union was dominated by char vstr[32] so it was
>32 bytes.  With struct devlink_param_u64_array { u64 size; u64
>val[32]; } it becomes 264 bytes, and the size is paid by every union
>regardless of the param's actual type.  struct devlink_param_item
>embeds the union three times (driverinit_value, driverinit_value_new,
>driverinit_default), so every registered devlink param grows by
>roughly 700 bytes even if it is a bool or u8.
We did modify to alloc from heap to reduce size in stack frame.

>Would storing the array out-of-line (a pointer plus a length) keep the
>cost on the users of U64_ARRAY only?
I dont think it is a good design. We need to contain every thing from userspace to kernelspace
(and vice versa) in this structure itself.

>Since the in-kernel cap is 32, is there a reason for the size field to
>be u64?  A narrower type (for example u8, paired with a
>BUILD_BUG_ON(__DEVLINK_PARAM_MAX_ARRAY_SIZE > U8_MAX)) would
>structurally prevent the put path from trusting an out-of-range size.
but there is no saving as such by defining only size as u32, as each array element is
64 bit, due to alignment padding another 32bit is lost. So we made size as well 64bit.

>>  	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
>>  	/* Any possible custom types, unrelated to NLA_* values go below */
>> +	DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
>>  };
>This is a permanent UAPI addition.  The name says U64_ARRAY but the
>kernel parser accepts either u32- or u64-encoded elements per-entry
>(nla_get_uint() in devlink_param_value_get_from_info() below).  Is
>there a reason to keep both widths accepted under a name that promises
>u64?  A single message can mix u32- and u64-encoded elements today,
>which is surprising given the type name.
This is a design suggested by maintainers, as it allows to pass both u32 and u64 size
arrays from userspace to kernel.

>Is __DEVLINK_PARAM_MAX_ARRAY_SIZE intended to be visible to userspace?
>It is defined only in include/net/devlink.h, not in this uapi header,
>not in the yaml spec, and not in Documentation/.  As a result the
>request above 32 elements is rejected without userspace having any
>way to discover the cap in advance.
I followed __DEVLINK_PARAM_MAX_STRING_VALUE, which is also defined in devlink.h.
So i dont think, we need to do it.

>> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
>> +		for (int i = 0; i < val->u64arr.size; i++)
>> +			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
>> +				return -EMSGSIZE;
>> +		break;
>>  	}
>>  	return 0;
>>  }
>Can this loop read past val->u64arr.val[]?
>The ingress path in devlink_param_value_get_from_info() caps cnt at
>__DEVLINK_PARAM_MAX_ARRAY_SIZE (32), but this put path loops to
>val->u64arr.size with no equivalent clamp.  If a driver's ->get()
>callback returns 0 but leaves u64arr.size unset (see the kmalloc note
>on ctx below) or sets it above 32, this loop indexes past the 32-entry
>val[] and emits those bytes back to the requester over netlink.
This is okay, we can send as many u64, which can be fitted into msg (skb).
If this reads past u64arr.size, it is an issue with the driver.
Please see jiri comment- https://lore.kernel.org/netdev/3pk4hkzgwy3a55zveapgmk23bsevru55xv75vhkzbpmzkfofcx@rlnkrvynofig/

