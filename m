Return-Path: <linux-rdma+bounces-20630-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMuQEfdIBWp0UAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20630-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:00:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9253D7EA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5372C305C4F8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 03:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CB43A9628;
	Thu, 14 May 2026 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZiIeu+ym"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0831D759;
	Thu, 14 May 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731144; cv=none; b=TbSukSlYlDCGNQ2hUzgXP8Hsaokm71VD+MjRFz2rW6TKgHz4/iWGPiPZm4j1E4WieeFe+t5aGTXWDxObzM8TBbI765gHHhyu5nEpfl2wEnX8t6SLYOaMycV/ZwzAjERIj5yFORBgtmG8fZCUq0WMZh5GgRVt8okY/83iN+u8NG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731144; c=relaxed/simple;
	bh=707ToHkAtnay1+tOLV5hQd+6Ofofy7/ryPkfxztuHLw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1wxoj+huWpu57ozE+z6INIjYnSb6GgJr3D84Cc0/FnkCnlyjsVcS8IAVtU2ZIpjz8ZtBd7c94fo9ES4mwAh/cart1MiZnohV+b5MkaEovA4nj01zIy/GE5niSGo9NldMc1OgOYnIMhsH4FDJmUToM5RP4EgbSWUKws8UdHhAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZiIeu+ym; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DK6HO71320187;
	Wed, 13 May 2026 20:58:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NW6CcXYmS5kH1VcPhmhhkE2VQ
	lhEWf3Ve4oP4zd511I=; b=ZiIeu+ymh7O7UXXxAkTlcYal9wzo+lzoZYk6zH2FC
	OdF9fpwls2NTB+QMG5gtBsxVpPCxaFN3dsweiS0S4oY1ry3kSX9P8LNjABg40O4d
	iXc01p7VaH209BSTqPyjqnV3SQTZnp6jUym0K1YXYgrXFTMMhHzJhwpXx5bhkkO/
	rFFYF3LijVwqQ975yUJwg9mfGF4MVHl9EKvPiQk/nrO46MeEf/8dhbe2/MYA+IbS
	AqEEQ2fmf//7YjJaub+rjhzWo4q8+Id3v2sx3WV9bfl3KmAriH0F7RUWn3LGyaeN
	cU8Pt1GX6gi+/FsM+9polng2n4X5q1HQiqG4HjVDnayGQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e4neu32qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 20:58:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 20:58:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 20:58:22 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2CF695B693A;
	Wed, 13 May 2026 20:58:13 -0700 (PDT)
Date: Thu, 14 May 2026 09:28:13 +0530
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
Subject: Re: [PATCH v13 net-next 4/9] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <agVIVZFmVAltTiJI@rkannoth-OptiPlex-7090>
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
X-Proofpoint-GUID: iEC-JO1ucsV5tWv5lO9KT5azLXkmKUNR
X-Proofpoint-ORIG-GUID: iEC-JO1ucsV5tWv5lO9KT5azLXkmKUNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzNSBTYWx0ZWRfX6k+MOcSjzQJv
 YISPoQoYhQSu6uDyDpM75+KfHEIkGdfpOMdOLioOS/rhGn6rmawjZrWq9n7AjhHCMQd1nd1OE1M
 zFg6kboOOEKnNWbyap3NGi2hPc5Jd1/Aw6G2NHQLegzIzvqBNgNjB6+ylt7TNrvj381LBjwvDbo
 v/9Bw4YjwyPCFmh2OgqySJzQZvw4wkZmA/Fcv4GnDL7gQdnscFO24OCJI+MVHUj2oiS6XpXnIXX
 Q7756EjWgzPFAvuN7THbqitCfNPmoVJu5dH5ZyR0z31LmNLRYDHoEhR8xdHldynSgMnUC0prUXd
 VDh/b4z524Zcx6bwvcUbsVg9dsjBiAqgvWrKi1zoralY2Mh84UNbS4+xcIiMZdKi09MC2xpP5lP
 RrFAvjod8wPzRDvLUhW3BjcU4wtIEUJdwXwd+kXOc3RrfJukJHRJzM+Ud7LeDjUcL+IaiHiOy0G
 MZMN8Sss4Wy1kTMXTQQ==
X-Authority-Analysis: v=2.4 cv=f7p4wuyM c=1 sm=1 tr=0 ts=6a05485f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=Ikd4Dj_1AAAA:8 a=PiZxuuqVe--FpxX1MskA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: E5E9253D7EA
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20630-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Action: no action

On 2026-05-11 at 09:09:18, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
>

>> diff --git a/net/devlink/param.c b/net/devlink/param.c
>> index 1a196d3a843db..4cc479bd019fd 100644
>> --- a/net/devlink/param.c
>> +++ b/net/devlink/param.c
>> @@ -252,6 +252,11 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
>>  				return -EMSGSIZE;
>>  		}
>>  		break;
>> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
>> +		for (int i = 0; i < val->u64arr.size; i++)
>Can this loop read out of bounds of val->u64arr.val[]?
>There is no bounds check against __DEVLINK_PARAM_MAX_ARRAY_SIZE. If
>val->u64arr.size contains garbage or a maliciously large value, this will read
>past the end of the u64arr.val array.
>Could this leak adjacent kernel memory to userspace via nla_put_uint()?
>> +			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
>> +				return -EMSGSIZE;
>> +		break;
>>  	}
>>  	return 0;
>>  }

pw-bot: changes-requested
ACK.

>[ ... ]
>> +	param_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
>> +			      sizeof(*param_value), GFP_KERNEL);
>> +	if (!param_value) {
>> +		kfree(default_value);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ctx = kmalloc_obj(*ctx);
>Does this allocation need to be zero-initialized?
>Since kmalloc_obj() does not zero the memory, if a driver's get callback
>successfully returns but fails to initialize ctx->val.u64arr.size, the struct
>will contain uninitialized kernel heap garbage.
>This data is then copied into the param_value array and eventually read by
>devlink_nl_param_value_put(), potentially causing the out-of-bounds read
>mentioned above.
>> +	if (!ctx) {
>> +		kfree(param_value);
>> +		kfree(default_value);
>> +		return -ENOMEM;
>> +	}
There is no issue with these uninitialized kernel heap garbage.

