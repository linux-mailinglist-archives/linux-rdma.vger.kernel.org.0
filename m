Return-Path: <linux-rdma+bounces-20503-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDmcGuBVA2qP4wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20503-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:31:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6496524B87
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1001303D7F6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DE3CF942;
	Tue, 12 May 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iL3Wnq4P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA93CC338;
	Tue, 12 May 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603311; cv=none; b=JUKIHpcMisZJgACsVEBpCl37xVs704/e0C3n1D+8FL/yEujr3LnpJRTG8VcRfxaWZTGhQ+6ULeC/9wjrwCv3/90tRD4H/6ykozd54P+Tt0LIwncsoY5hOfe4epiUTIdzJStbq9uWITyU3fJHQN2UZkqjJfXHk0oRHqueK5NTP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603311; c=relaxed/simple;
	bh=y47bLhuB3bbwOu6OG3ySuxnv0TFonWNvzbA3pv9b8JY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbdpZY0a3jXrozxrkqGo/Vlswk2e1gXHHGFfot3aJD5rJw70WCn2rdR2iHtztYDsXLG73ty0ci06UANYaZAd5XzpXiX4D9GqJGEI3wsDeNI1kcIwgRQJ6PBhUwf8qy3jRpX2LSMoAZIZ8x5Xzd1lpICNGJTKVP+KGBuHenJnJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iL3Wnq4P; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CEwdVV2086045;
	Tue, 12 May 2026 09:27:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=xXulHHw/MC7noVVIykDiuU4TO
	Uml7RgT8BW3cOD1fXI=; b=iL3Wnq4PetcbvpMOMDHDpWlzfDkaZivaglBSpx/Ic
	h0kyCPN4i6VpSjgnjyFDC7uhisXzsPUebKCIED9dBOYlU343kUAusm0EnDpiuKEC
	1n2RcR0a+u8Km4WbjsVMDWnTZG/63aLaIuATddZb81v/RGauEI49KFqEkcMq9M1s
	Kai3cNa/0IvI4sCQz/oQnXqd6UpGMn09F4hAPArA4YVLUZuKpbm57U1orH4gVyrB
	jK/qomHVV132DGQ2rnLxxhCi3ERL4TYtEfWBwl074BTbVkGiBVKIi6W/tjCJUN/S
	4CpopW3hD0rQ/UijqNeRwNc8lQfrwj1O4/AEKSgSP90Og==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e46epraqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 09:27:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 12 May 2026 09:27:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 12 May 2026 09:27:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 40A6C3F7062;
	Tue, 12 May 2026 08:54:41 -0700 (PDT)
Date: Tue, 12 May 2026 21:24:39 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>,
        <jiri@resnulli.us>
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
Subject: Re: [PATCH v13 net-next 4/9] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <agNNPy2FoA1CFGrG@rkannoth-OptiPlex-7090>
References: <20260511033923.1301976-1-rkannoth@marvell.com>
 <20260511033923.1301976-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511033923.1301976-5-rkannoth@marvell.com>
X-Proofpoint-GUID: 9uqlHyOr9Gzw71SII3R8MQ23GPKDmXcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MSBTYWx0ZWRfX3I6zMTQdlafd
 VzS7aYDP7tweiv9GiPNxLqo7w9RyGk6z5wl+/uUeIjsHYNZdQhjDrA1pR+ZbpkVu54Uw5euMZD6
 zAU4umbIWjftrbYegrjEAHDGjKv81uPyqqwQ/2rDGYqXoH3WYuDgbbbhskvFVpYWTqdpGWDqKc3
 O9UJRlAsk/+kJYc58VMAR2o3S4z4CHli5sQAiMvuTdlHlrJ1tGIz7O1erQp9aZktfJ/mHO3QJN7
 u4fBCnVazPTgoIwq9/ASUo47WZANxrZlONlQm3f8wFDg+47gDgZfmcx5315GWdy4e+ay5kZhkNS
 VD3Oz2AUzMOnRJRKkqD7AFqqrbAWmA9M7f0obtj9uSDIaqoBRenDIW5BATRf0VY42YCG7lotdL2
 Y1vTDxnWr61FfI5U/sUNcMp8vdrm1Ln25qqEt8Abo8FYH5x+UPxprQY6B6FZPk2axoNfQxmcMFc
 4aTVy0ydzWzWPjNzDRw==
X-Authority-Analysis: v=2.4 cv=ApDeGu9P c=1 sm=1 tr=0 ts=6a035506 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=Ikd4Dj_1AAAA:8 a=qnsy3ciE5cuyejZEVdQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: 9uqlHyOr9Gzw71SII3R8MQ23GPKDmXcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: A6496524B87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,nvidia.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20503-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-11 at 09:09:18, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.

Jiri,

Sashiko raised below issue.
> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index 1a196d3a843db..4cc479bd019fd 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -252,6 +252,11 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
>  				return -EMSGSIZE;
>  		}
>  		break;
> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> +		for (int i = 0; i < val->u64arr.size; i++)
Can this loop read out of bounds of val->u64arr.val[]?
There is no bounds check against __DEVLINK_PARAM_MAX_ARRAY_SIZE. If
val->u64arr.size contains garbage or a maliciously large value, this will read
past the end of the u64arr.val array.
Could this leak adjacent kernel memory to userspace via nla_put_uint()?
> +			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
> +				return -EMSGSIZE;
> +		break;
>  	}
>  	return 0;
>  }
I had modified in v12 as per https://lore.kernel.org/netdev/3pk4hkzgwy3a55zveapgmk23bsevru55xv75vhkzbpmzkfofcx@rlnkrvynofig/

Is it okay to incorperate the sashiko comment and modify as below ?

@@ -252,6 +252,15 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
                                return -EMSGSIZE;
                }
                break;
+       case DEVLINK_PARAM_TYPE_U64_ARRAY:
+               for (int i = 0; i < val->u64arr.size; i++) {
+                       if (i >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+                               return -EINVAL;
+
+                       if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
+                               return -EMSGSIZE;
+               }
+               break;
        }

>

