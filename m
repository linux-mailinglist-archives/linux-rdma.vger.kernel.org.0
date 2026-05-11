Return-Path: <linux-rdma+bounces-20336-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CgTIudCAWpwTAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20336-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:45:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35565074C9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945B2300DDF3
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 02:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEEB30BB80;
	Mon, 11 May 2026 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DAuzAf/f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007573043D5;
	Mon, 11 May 2026 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467514; cv=none; b=f7Vrh8DWxuvRJxwQstfnKh2Z785VSqScJcHbcgq8RVSFDMUhPL0lplGnX2l+CTz+OUAcUXsopXcEiq0iWSfl3F4hKdbHV4kWJJQqyQHW0w8I5zlb0i8H5KsNKC7MDLTnFe8Us6VkMaqRRNgb2cHAqYEZHV/KTKOI1MX2RmXtD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467514; c=relaxed/simple;
	bh=uDBGpNXR7xfRIM9KaaQyUSl/DTnHJD0R4Q6E5syiWts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMyO1JxvqUEHSZp1/Au5cXFgUZPPaGRrFvt5WRThqz61+Ssh2HL4hJJAV6Y5z+O5kUfU0qqokSKVW0pzdyHxNtiHnZsrUKtbwYlmFEyzpVoz1bHw2QRXb/GHGofwGYJk3SWt2il8Ul4RiQk2Es0yCRtw+9aOjDf1KQc7pwpFQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DAuzAf/f; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ALxVgx2886655;
	Sun, 10 May 2026 19:44:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TCZGVfP3PrygTPQur+dOCeAnW
	SnlOU1PSYLbzVz6oog=; b=DAuzAf/fA+i+JrocE+oizKuLJFWYUn5VYzKQatIJv
	NQJ6lgOCmIMllRbzNQQNBSQ2l4cK9BXg0CSYVHpa0ktDtWIg5U0JgC9/JwwsAl6E
	ng4rV0aAv/Tv7r1OY5y3KQLFkQaHosQ6ujK8zffgotGTpk7c27BGMyXBQwFFdbHh
	KmBGM6B0JongvK3KEPdwE5k9XtphT03VvoTh+D0csJnNHyjbjwdehuuhUjXuUl8X
	3Libo5zoZuIxzJwIbkMnvosUgtxtnfDohSsK6yPKw8YjrgyW3vsV09oCHKoYo4sl
	NGWcgwh6cZxCarSjhLFh/Qi3h/EJ/RFUM24tZoXrgQ22w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e229jkf6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 19:44:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 19:44:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 19:44:32 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 818CF3F7088;
	Sun, 10 May 2026 19:44:23 -0700 (PDT)
Date: Mon, 11 May 2026 08:14:22 +0530
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
Subject: Re: [PATCH v12 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <agFChlSIxsYM3wj6@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-7-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyNyBTYWx0ZWRfX1qoSKKDXVfQe
 d/r/S0T94RPFTYaLXpKupzlTPMGqs3OgPqAvfOCm6SjnHKX9Wd6Y6fzU3Af1hass93NXqIIp2XT
 mRvXGGZM5JjKrm7FUPuIJBYS+enYINIQYRD3NNehYCxSThZ/3tHDzxhoXtUHmP4S+Uo7Zo8pIw9
 svxyFgkJzcEXCQNEmW/VUWWr1QGbve7sN1zBYu8WeRMRnZG3Dduo/Yy5esTZJR/4lfXtwTq9/85
 Tep1WJ/sz3df/bSOqhmcy5dqxk7U2YcYwcqklx/Q2jGm0R2tpg3fhugD2YKU2U7s4F121FGyZaj
 pl3Y3zYXN0mwRdO6c1c4rICqH63oQSO3BGMjMGrXJ9hMV6YF7JvX8Wq3OIvjqsc76swLRkewVJs
 ue3l9V4Hb3XY6g4GSeH7SI+vsHHSKOYWd7pv4AXX1uuZRiyvxzfjhsG2vuwM5AdAtKrWkEez5Pm
 aveea3RoCkHHYLimLaw==
X-Proofpoint-GUID: oIDeRa2Cm1H1BBu9O7kBRp-tgSNu22Ge
X-Proofpoint-ORIG-GUID: oIDeRa2Cm1H1BBu9O7kBRp-tgSNu22Ge
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a014292 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=hBA3f-BUjflL6dYasosA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: E35565074C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20336-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-08 at 09:19:09, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
> reinit or teardown without the AF freeing CN20K default NPC rule indexes
> while the driver still owns that state (otx2_init_hw_resources and
> otx2_free_hw_resources).

pw-bot: changes-requested

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> @@ -990,7 +990,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
>>  	u16 vf_func;
>>
>>  	/* Only CGX PF/VF can add allmulticast entry */
>> -	if (is_lbk_vf(rvu, pcifunc) && is_sdp_vf(rvu, pcifunc))
>> +	if (is_lbk_vf(rvu, pcifunc) || is_sdp_vf(rvu, pcifunc))
>Is this logic change intended to be part of this commit?
>The commit message focuses on coordinating default rules with the NIX LF
>lifecycle, but this silently changes the condition from a logical AND to a
>logical OR. While this appears to correctly fix a bug where the condition
>could never be true (since a device cannot simultaneously be both an LBK VF
>and an SDP VF), including an undocumented bug fix in a patch about a
>different topic obscures the commit's intent.
>Should this be split into a separate patch, or explicitly mentioned in the
>commit message?

ACK. This is a fix, i will post as seperate patch after this net-next series merged.

