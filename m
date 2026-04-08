Return-Path: <linux-rdma+bounces-19132-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HUsNBUx1mlZBwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19132-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 12:42:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4FB3BAC89
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BADE301B900
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E53B6BF9;
	Wed,  8 Apr 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MDoe75y2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04038389113;
	Wed,  8 Apr 2026 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644918; cv=none; b=mGA5PNP1wrBYfVOiNEvdl6dKYeRwUfP7Q4iXPIOywXdENv0UZJSQCs9dWuijgeNJPdsbU8ACqXSHLLop8TmtMWSJhB3TqSU3U+LIoMiube3lAEd6CK+iDqoXhmetJ60lucEbHQInlaBw7Aihpo6fwiPx4g771z18Nb6wfJdKKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644918; c=relaxed/simple;
	bh=amPzCv3+48JYjGfxqBP68xhdKm3kza/U93mR5lPHx6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnmPNC0LriY1oZLtbfO7OdEv1XAHqCA5avPPNmgk/vMyi8xLkZfHFUbEnjtAqcEyhCsPDfyXECN6M63SiX7hCygym2L0Xnc8WmFw9UnqwDEedrKV/WhGMbUZzJw+BA4ClSnayZEikmBws4IF4fQ8BSSPByZW9ZM8TU1NWn0gyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MDoe75y2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6388Q99M979821;
	Wed, 8 Apr 2026 03:41:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=z2jAza8v+7rUGgECI+gLP90vS
	dE77+In1yL8gP0aYdE=; b=MDoe75y2I167dsvgC9uA0Fgy8ReTqA1U6F5cZwB02
	Q/EmRYt1tg5YxhaT/WG7lHcqFp79Ug0mkHibC0n1aVcyOlwF8nHal29NQ5d27FJ3
	l4AlZNuxy7qy/yxnM579O0uvmXeKEMnZSdjGLkleYtttBkM31TJ8GedbKE9Mkfki
	cc/3MMdIR1CHs2nbz+dhLJR5aOd9sCYJrVDhoBQ2n05S5Cka6mnK/Rqzopg4y6RL
	NeP0Y8wyLVvtwNe6tlTmBL5uHhAuSMiPt1qXY3XMBwRoYhrrM3PaVvCnehjNdKJp
	FpNl+uowoN0xQdrgc5gXrWw044m7Apu7wX7CULRes7vYg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dcms9m9yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 03:41:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 03:41:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Apr 2026 03:41:41 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 037BE3F7040;
	Wed,  8 Apr 2026 03:41:34 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:11:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <donald.hunter@gmail.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
        <tariqt@nvidia.com>, <mbloch@nvidia.com>, <dtatulea@nvidia.com>
Subject: Re: [PATCH v10 net-next 3/6] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <adYw3SeHoj43Xs2S@rkannoth-OptiPlex-7090>
References: <20260403025533.6250-1-rkannoth@marvell.com>
 <20260403025533.6250-4-rkannoth@marvell.com>
 <c14a0783-a69f-448d-a464-2d802e6d0ec7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c14a0783-a69f-448d-a464-2d802e6d0ec7@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5OCBTYWx0ZWRfX0MtDxYJ0D9d8
 xZKdIL2YrJg5cjBeyOz9CrWrWNdVIPa9CDVZOUZA0bdQdvk8wefTlQjeXyzzna0PNsfrdbI88G6
 yBTW1NnBsoYVD9roueFeQ2gP9GUGgfeIKsj2HfyZHZvAAdOxshB6Dc1TwFiVFxgNFzdWkESUGmU
 2/qc6M9xB1/4RBxAabYzh/swOim0Q/wXQJPMFCxHLTeH3OSn8QL3LSHZOZ8UIaL0XGm7RAK4gtU
 m4Oj1A3GnGujXZvhXVUZG5NmrcdSjuNAwNpCzT1zn4iyK8kl8ue/3HWnnWt1NMr2s8f9FULUnCN
 QWLvVIGDKJ7upDmZ2PXNRO20mj9QxxRwF5Cn27oj70al+0Tsx0rHXBUgnLEzE35YhOJpnWR+R92
 pXCfXqWgwHt/iOH84eqL8juaCVhi8WAnGMg5z7aBgx+dkYfuceoo7w639bP3srgZPIKAQNY5Mgr
 Rhgc9NegvSxroPtO51w==
X-Proofpoint-GUID: rqenu4AcQd4hSJYHcGLCCxWf7cjMf2Gp
X-Authority-Analysis: v=2.4 cv=FuY1OWrq c=1 sm=1 tr=0 ts=69d630e6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=eWhMO9woqBMS6peCcvsA:9
 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: rqenu4AcQd4hSJYHcGLCCxWf7cjMf2Gp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-19132-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3B4FB3BAC89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-07 at 15:28:09, Paolo Abeni (pabeni@redhat.com) wrote:
> On 4/3/26 4:55 AM, Ratheesh Kannoth wrote:
> > From: Saeed Mahameed <saeedm@nvidia.com>
> >
> > Devlink param value attribute is not defined since devlink is handling
> > the value validating and parsing internally, this allows us to implement
> > multi attribute values without breaking any policies.
> >
> > Devlink param multi-attribute values are considered to be dynamically
> > sized arrays of u64 values, by introducing a new devlink param type
> > DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
> > count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> >
> > Implement get/set parsing and add to the internal value structure passed
> > to drivers.
> >
> > This is useful for devices that need to configure a list of values for
> > a specific configuration.
> >
> > example:
> > $ devlink dev param show pci/... name multi-value-param
> > name multi-value-param type driver-specific
> > values:
> > cmode permanent value: 0,1,2,3,4,5,6,7
> >
> > $ devlink dev param set pci/... name multi-value-param \
> > 		value 4,5,6,7,0,1,2,3 cmode permanent
> >
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> > ---
> >  Documentation/netlink/specs/devlink.yaml |  4 ++
> >  include/net/devlink.h                    |  8 +++
> >  include/uapi/linux/devlink.h             |  1 +
> >  net/devlink/netlink_gen.c                |  2 +
> >  net/devlink/param.c                      | 91 +++++++++++++++++++-----
> >  5 files changed, 89 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> > index b495d56b9137..b619de4fe08a 100644
> > --- a/Documentation/netlink/specs/devlink.yaml
> > +++ b/Documentation/netlink/specs/devlink.yaml
> > @@ -226,6 +226,10 @@ definitions:
> >          value: 10
> >        -
> >          name: binary
> > +      -
> > +        name: u64-array
> > +        value: 129
> > +
> >    -
> >      name: rate-tc-index-max
> >      type: const
> > diff --git a/include/net/devlink.h b/include/net/devlink.h
> > index 3038af6ec017..3a355fea8189 100644
> > --- a/include/net/devlink.h
> > +++ b/include/net/devlink.h
> > @@ -432,6 +432,13 @@ enum devlink_param_type {
> >  	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
> >  	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
> >  	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
> > +	DEVLINK_PARAM_TYPE_U64_ARRAY = DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
> > +};
> > +
> > +#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
> > +struct devlink_param_u64_array {
> > +	u64 size;
> > +	u64 val[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
> >  };
> >
> >  union devlink_param_value {
> > @@ -441,6 +448,7 @@ union devlink_param_value {
> >  	u64 vu64;
> >  	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
> >  	bool vbool;
> > +	struct devlink_param_u64_array u64arr;
>
> Sashiko as a couple of relevant remarks here, specifically:
>
> ---
> Does this increase the size of union devlink_param_value from 32 bytes
> to over 264 bytes?
> Looking at existing functions like devlink_nl_param_value_fill_one() and
> devlink_nl_param_value_put(), they take multiple copies of this union by
> value. Passing two of these unions by value consumes over 528 bytes of
> stack space, and combined in a call chain this pushes nearly 800 bytes
> of arguments onto the stack.
> Could this create a risk of hitting CONFIG_FRAME_WARN limits deep in
> driver notification contexts? Should the signatures of the internal
> functions and exported APIs be updated to pass the unions by pointer
> instead?
ACK. will make as seperate patch.

> ---
>
> >  };
> >
> >  struct devlink_param_gset_ctx {
> > diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> > index 7de2d8cc862f..5332223dd6d0 100644
> > --- a/include/uapi/linux/devlink.h
> > +++ b/include/uapi/linux/devlink.h
> > @@ -406,6 +406,7 @@ enum devlink_var_attr_type {
> >  	DEVLINK_VAR_ATTR_TYPE_BINARY,
> >  	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
> >  	/* Any possible custom types, unrelated to NLA_* values go below */
> > +	DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
> >  };
> >
> >  enum devlink_attr {
> > diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> > index eb35e80e01d1..7aaf462f27ee 100644
> > --- a/net/devlink/netlink_gen.c
> > +++ b/net/devlink/netlink_gen.c
> > @@ -37,6 +37,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
> >  	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
> >  		fallthrough;
> >  	case DEVLINK_VAR_ATTR_TYPE_BINARY:
> > +		fallthrough;
> > +	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
> >  		return 0;
> >  	}
> >  	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
> > diff --git a/net/devlink/param.c b/net/devlink/param.c
> > index cf95268da5b0..2ec85dffd8ac 100644
> > --- a/net/devlink/param.c
> > +++ b/net/devlink/param.c
> > @@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
> >  				return -EMSGSIZE;
> >  		}
> >  		break;
> > +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> > +		if (val.u64arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)
> > +			return -EMSGSIZE;
> > +
> > +		for (int i = 0; i < val.u64arr.size; i++)
> > +			if (nla_put_uint(msg, nla_type, val.u64arr.val[i]))
> > +				return -EMSGSIZE;
> > +		break;
> >  	}
> >  	return 0;
> >  }
> > @@ -304,56 +312,78 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
> >  				 u32 portid, u32 seq, int flags,
> >  				 struct netlink_ext_ack *extack)
> >  {
> > -	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
> > -	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
> >  	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
> >  	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
> >  	const struct devlink_param *param = param_item->param;
> > -	struct devlink_param_gset_ctx ctx;
> > +	union devlink_param_value *default_value;
> > +	union devlink_param_value *param_value;
> > +	struct devlink_param_gset_ctx *ctx;
> >  	struct nlattr *param_values_list;
> >  	struct nlattr *param_attr;
> >  	void *hdr;
> >  	int err;
> >  	int i;
> >
> > +	default_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
> > +				sizeof(*default_value), GFP_KERNEL);
> > +	if (!default_value)
> > +		return -ENOMEM;
> > +
> > +	param_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
> > +			      sizeof(*param_value), GFP_KERNEL);
> > +	if (!param_value) {
> > +		kfree(default_value);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ctx = kmalloc_obj(*ctx);
> > +	if (!ctx) {
> > +		kfree(param_value);
> > +		kfree(default_value);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	/* Get value from driver part to driverinit configuration mode */
> >  	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
> >  		if (!devlink_param_cmode_is_supported(param, i))
> >  			continue;
> >  		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
> > -			if (param_item->driverinit_value_new_valid)
> > +			if (param_item->driverinit_value_new_valid) {
> >  				param_value[i] = param_item->driverinit_value_new;
> > -			else if (param_item->driverinit_value_valid)
> > +			} else if (param_item->driverinit_value_valid) {
> >  				param_value[i] = param_item->driverinit_value;
> > -			else
> > -				return -EOPNOTSUPP;
> > +			} else {
> > +				err = -EOPNOTSUPP;
> > +				goto get_put_fail;
> > +			}
> >
> >  			if (param_item->driverinit_value_valid) {
> >  				default_value[i] = param_item->driverinit_default;
> >  				default_value_set[i] = true;
> >  			}
> >  		} else {
> > -			ctx.cmode = i;
> > -			err = devlink_param_get(devlink, param, &ctx, extack);
> > +			ctx->cmode = i;
> > +			err = devlink_param_get(devlink, param, ctx, extack);
> >  			if (err)
> > -				return err;
> > -			param_value[i] = ctx.val;
> > +				goto get_put_fail;
> > +			param_value[i] = ctx->val;
> >
> > -			err = devlink_param_get_default(devlink, param, &ctx,
> > +			err = devlink_param_get_default(devlink, param, ctx,
> >  							extack);
> >  			if (!err) {
> > -				default_value[i] = ctx.val;
> > +				default_value[i] = ctx->val;
> >  				default_value_set[i] = true;
> >  			} else if (err != -EOPNOTSUPP) {
> > -				return err;
> > +				goto get_put_fail;
> >  			}
> >  		}
> >  		param_value_set[i] = true;
> >  	}
> >
> > +	err = -EMSGSIZE;
> >  	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
> >  	if (!hdr)
> > -		return -EMSGSIZE;
> > +		goto get_put_fail;
> >
> >  	if (devlink_nl_put_handle(msg, devlink))
> >  		goto genlmsg_cancel;
> > @@ -393,6 +423,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
> >  	nla_nest_end(msg, param_values_list);
> >  	nla_nest_end(msg, param_attr);
> >  	genlmsg_end(msg, hdr);
> > +	kfree(default_value);
> > +	kfree(param_value);
> > +	kfree(ctx);
> >  	return 0;
> >
> >  values_list_nest_cancel:
> > @@ -401,7 +434,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
> >  	nla_nest_cancel(msg, param_attr);
> >  genlmsg_cancel:
> >  	genlmsg_cancel(msg, hdr);
> > -	return -EMSGSIZE;
> > +get_put_fail:
> > +	kfree(default_value);
> > +	kfree(param_value);
> > +	kfree(ctx);
> > +	return err;
> >  }
> >
> >  static void devlink_param_notify(struct devlink *devlink,
> > @@ -507,7 +544,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
> >  				  union devlink_param_value *value)
> >  {
> >  	struct nlattr *param_data;
> > -	int len;
> > +	int len, cnt, rem;
> >
> >  	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
> >
> > @@ -547,6 +584,26 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
> >  			return -EINVAL;
> >  		value->vbool = nla_get_flag(param_data);
> >  		break;
> > +
> > +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> > +		cnt = 0;
> > +		nla_for_each_attr_type(param_data,
> > +				       DEVLINK_ATTR_PARAM_VALUE_DATA,
> > +				       genlmsg_data(info->genlhdr),
> > +				       genlmsg_len(info->genlhdr), rem) {
> > +			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
> > +				return -EMSGSIZE;
> > +
> > +			if ((nla_len(param_data) != sizeof(u64)) &&
> > +			    (nla_len(param_data) != sizeof(u32)))
> > +				return -EINVAL;
> > +
> > +			value->u64arr.val[cnt] = (u64)nla_get_uint(param_data);
> > +			cnt++;
> > +		}
> > +
> > +		value->u64arr.size = cnt;
> > +		break;
>
> Sashiko says:
>
> ---
> Does this make it impossible to set an empty array to clear a
> multi-value parameter?
> If userspace provides 0 elements, param_data will be NULL. Earlier in
> devlink_param_value_get_from_info(), there is a check:
> 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
> 	if (param->type != DEVLINK_PARAM_TYPE_BOOL && !param_data)
> 		return -EINVAL;
> If the parameter is a U64_ARRAY and no data is provided, this check will
> immediately return -EINVAL.
> The kernel can successfully emit an empty array on a GET request if the
> size is 0. Should the SET path similarly support receiving 0 elements to
> allow userspace to clear a multi-value parameter?
multi-value parameter is to set values. if some one wants to set to zero
they can set all values as zero and pass a "size" array. we can ignore this comment, right ?

> ---
>
> There are several others NIC-specific remarks, which IMHO are mostly
> pre-existing issues, but please have a look:
>
> https://sashiko.dev/#/patchset/20260403025533.6250-1-rkannoth%40marvell.com
>
> /P
>

A. Patch 1: [PATCH v10 net-next 1/6] octeontx2-af: npc: cn20k: debugfs enhancements

1.

"Is it safe to use a global static array here?
Concurrent reads of the dstats debugfs file could race to read and write to
this array, leading to torn updates. Additionally, on systems with multiple
RVU devices, wouldn't they share the same array and cross-contaminate their
statistics?"

The purpose of using "dstats" is to identify which rules current traffic is hitting.
We are not particularly concerned with overall packet statistics, as those can
be obtained through rule's stats register. Each rule hit will display the corresponding
rule during 'cating', so this comment can be disregarded.

2.

"Are the hardware parameters read into npc_priv->bank_depth and
npc_priv->num_banks guaranteed to fit within the static bounds of dstats?
If the hardware reports a bank_depth that makes mcam_idx exceed the
pre-allocated array dimensions, could this result in an out-of-bounds
memory access here?"

static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS are maximum possible. So above case
wont happen

3.

"Could this cause data loss if the output exceeds the initial seq_file
buffer size?
DEFINE_SHOW_ATTRIBUTE() uses single_open(), which will discard the buffer,
double its size, and re-invoke this show callback from the beginning if it
overflows.
Since dstats[bank][idx] is updated during the first execution, a
re-invocation would see stats == dstats[bank][idx] and silently drop all
previously processed entries."

The purpose of "dstats" entry to find live traffic hitting rules. It may be showing "wrong"
value for the first time, but second time onwards, it will be okay. Usually user runs 'cat'ing mutliple
times to find "htting" rule.

5.

"Similar to the dstats array, does this code overflow en_map?
If the index provided here can exceed the compile-time bounds of
MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH due to dynamically
read hardware sizes, it could corrupt memory.
Additionally, is en_map explicitly cleared during device initialization
or teardown?
Since npc_priv is global, if the driver is unbound and rebound without
unloading the module, could en_map retain stale state from the previous
session?"
MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH is big enough to hold
for all SoC variants.

B. Patch 2: [PATCH v10 net-next 2/6] net/mlx5e: heap-allocate devlink param values

1.

"Does returning -ENOMEM here trigger a redundant WARN_ON() in the caller?
Looking at mlx5e_pcie_cong_event_init(), it checks the return value like this:
drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c:mlx5e_pcie_cong_event_init() {
    ...
	err = mlx5e_pcie_cong_get_thresh_config(mdev, &thresh_config);
	if (WARN_ON(err))
		return err;
    ...
}
Since kcalloc() already prints a warning and stack trace on allocation failure
(unless __GFP_NOWARN is used), wrapping the -ENOMEM return in WARN_ON() will
result in a double stack trace in the kernel log.
Is it possible to drop the WARN_ON() in the caller to avoid this redundant
splat?"

Existing code issue.  i believe, i dont have to fix this. correct me pls.

C. Patch 3: [PATCH v10 net-next 3/6] devlink: Implement devlink param multi attribute nested data values

Replied above as part of your comments.

D. Patch 4: [PATCH v10 net-next 4/6] octeontx2-af: npc: cn20k: add subbank search order control

1.

"If xa_store() fails and we jump to fail_used, doesn't this leave the device
in an unrecoverable state?
The code previously erased all subbank entries from npc_priv.xa_sb_used and
npc_priv.xa_sb_free. By aborting without restoring the remaining subbanks,
the erased subbanks appear to be permanently leaked, which would permanently
break subsequent hardware MCAM allocations. Global state is also modified
before the insertion loop, leaving the driver's internal state inconsistent.
Could this be avoided by pre-allocating the required XArray slots with
xa_reserve() or by building new XArrays and swapping them upon success?"

We are doing this operation underlocks and there wont be repetitions of slots in
the array. This above condiition is very unlikely, if there is some issue, we
flag the error thru print. This means that there is some other deep issue which
caused this error. So we can ignore this.

2.
" +	if (bitmap_weight(&w, sz) != sz) {
> +		dev_err(rvu->dev,
> +			"Duplicate or out-of-range subbank index. %lu\n",
> +			find_first_zero_bit(&w, sz));
> +		return -EINVAL;
> +	}
Does this error message print the missing index instead of the duplicate
one?
Since find_first_zero_bit() finds the first unset bit, it will return the
index that the user failed to provide, not the one they duplicated or
provided out of range. Could this lead to a confusing error message for
users?"
I will change print error message to   "Duplicate or missing or out-of-range subbank index. %lu\n","

E. Patch 5: [PATCH v10 net-next 5/6] octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries

1.

>  	u64 cfg, hw_prio;
>  	u8 kw_type;
>
> +	if (index < 0 || index >= mcam->total_entries) {
> +		WARN(1, "Wrong mcam index %d\n", index);
> +		return;
> +	}
Could this cause kernel log spam due to unchecked negative MCAM indices?
In npc_enadis_default_entries() and npc_enadis_default_mce_entry(), the code
queries the MCAM index using npc_get_nixlf_mcam_index(), which correctly
returns a negative error code if the entry is not allocated.
This unchecked negative index is then passed directly to
npc_cn20k_enable_mcam_entry(), which checks if (index < 0) and triggers a
stack trace via WARN(1, ...). This means that a routine NIX LF teardown of
an uninitialized interface (or a VF without multicast support querying the
PF's missing BCAST entry) will repeatedly trigger stack traces.

We have checks in npc_enadis_default_entries() to check for default entries and bailout.

       /* only CGX or LBK interfaces have default entries */
        if (is_cn20k(rvu->pdev) &&
            !npc_is_cgx_or_lbk(rvu, pcifunc & ~RVU_PFVF_FUNC_MASK))
                return;

will add the same for npc_enadis_default_mce_entry() as well.

2.

> @@ -4024,6 +4041,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
>  	void *val;
>  	int i, j;
>
> +	for (int i = 0; i < ARRAY_SIZE(ptr); i++) {
> +		if (!ptr[i])
> +			continue;
There is variable shadowing here. The variable 'i' is declared at the
function scope, but the loop re-declares 'i', shadowing the outer scope
variable. This triggers -Wshadow compiler warnings.

ACK.

3.

Does this code use virtual MCAM indices as physical indices, potentially
causing massive out-of-bounds memory corruption?
In npc_cn20k_dft_rules_alloc(), default MCAM entries are allocated via the
mailbox handler (rvu_mbox_handler_npc_mcam_alloc_entry), which returns
virtual indices (vidx) in rsp.entry_list for CN20K hardware. These vidx
values are inserted directly into the xa_pf2dfl_rmap xarray.
Later, this code in npc_cn20k_dft_rules_free() retrieves these vidx values
and passes them directly to physical index APIs: npc_mcam_clear_bit() and
mcam->entry2pfvf_map[]. Because vidx indices are structurally shifted
(starting at npc_priv.bank_depth * 2), they are guaranteed to be larger
than mcam->bmap_entries.
This causes rentry = mcam->bmap_entries - index - 1 in npc_mcam_clear_bit()
to underflow, leading __clear_bit() to perform out-of-bounds writes on
kernel heap memory. The vidx values should probably be mapped back to
physical indices using npc_cn20k_vidx2idx() before accessing software state
arrays.

virt field in npc_mcam_alloc_entry_req structure is not set for while calling for
default mcam index allocation using rvu_mbox_handler_npc_mcam_alloc_entry(). So
this comment can be ignored.

4.

Is there a race condition here that could lead to MCAM index corruption due
to premature lock release?
The mcam->lock is held while calling npc_mcam_clear_bit(), which
immediately marks the MCAM index as free in the software bitmap
(mcam->bmap). The code then explicitly unlocks mcam->lock before calling
npc_cn20k_idx_free() to release the index in the firmware/hardware.
Releasing the lock creates a critical race window: another thread can
concurrently allocate this exact MCAM index (since it appears free in the
bitmap), assign it to a new interface, and configure it.
When the original thread resumes and calls npc_cn20k_idx_free(), it
instructs the hardware to free the index, silently destroying the newly
allocated flow rules of the concurrent thread. Should the hardware cleanup
be performed before the software bitmap is marked free, or should the lock
remain held?

These alloc free request are thru mbox messages and are processed one by one (serially)
So ignore this case.

5.

int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
Is there a software bitmap leak and multi-free bug in the error path of
npc_cn20k_dft_rules_alloc()?
If xa_insert() fails, the code jumps to the err label to free the allocated
entries. The error path executes:
	for (i = 0; i < cnt; i++)
		npc_idx_free(rvu, mcam_idx, cnt, false);
Since npc_idx_free() takes an array and a count to free 'cnt' entries,
looping over it causes the exact same array of indices to be freed 'cnt'
times.
Furthermore, the error path fails to clear the software bits in the core
hardware bitmap (mcam->bmap) via npc_mcam_clear_bit() and does not
invalidate mcam->entry2pfvf_map. Since the allocation handler successfully
marked these entries as used, omitting these steps permanently leaks the
software state for these MCAM indices.

dft rules fail means a critical issue as this will affect system operation. Theere is
no point in recovering cleanly from it. But anyway, i dont find a clear 1:1 with code, am
i missing anything here.

6.

Does this early return skip the cleanup of user-defined flow rules for
non-CGX/LBK interfaces?
While the intent seems to be skipping the disablement of default entries
for interfaces that don't have them (like SDP or CPT), this function is
also responsible for disabling ALL user-defined MCAM flow rules associated
with the pcifunc by iterating over mcam->mcam_rules.
By returning early here, all user-defined rules are left fully active in
the hardware parser, pointing to a NIX LF that is being torn down and freed.
This could lead to hardware DMA faults and context errors when traffic
matches these orphaned rules. Should this check be exclusively inside
rvu_npc_disable_default_entries() instead?

ACK.

7.

Can this cause a permanent resource leak of default MCAM entries on PF driver
teardown?
otx2_free_hw_resources() unconditionally sets the NIX_LF_DONT_FREE_DFT_IDXS
flag during NIX LF free. While intended for cases like suspend/resume, this
function is called across all driver unbind/remove paths.
Consequently, when the otx2_pf driver is unloaded, the AF driver skips
freeing the default MCAM rules, leaving them permanently orphaned in the
AF's xa_pf2dfl_rmap and hardware allocation bitmap. They can never be
recovered or reused by other physical or virtual functions, causing a
severe leak of globally shared MCAM resources on every module detach.

These default mcam indexes are freed during rvu_detach_rsrcs mbox call.
rvu_detach_rsrcs() ->npc_cn20k_dft_rules_free().

F: Patch 6: [PATCH v10 net-next 6/6] octeontx2-af: npc: Support for custom KPU profile from filesystem

1.

Can this corrupt global state? In npc_prepare_default_kpu(), adapter->kpu
is initialized to the global static array npc_kpu_profiles. By assigning
kpu->cam2 and kpu->action2 here, this modifies the shared static array with
device-managed memory (devm_kcalloc).
If the device is unbound, the memory will be freed, leaving dangling pointers
in the global array which could lead to a use-after-free for subsequent device
instances.

This memory is part of "AF" and is initlaized during boot. AF memory will be freed when
device is shutdown. There wont be any case of af getting freed and come again on a live system.

2.

> +
> +	action = (struct npc_kpu_profile_action *)(fw->data + offset);
> +
> +	if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
> +		return -ENOMEM;
Is -ENOMEM the correct return value here? A malformed or truncated firmware
file would cause this condition, so -EINVAL might be more appropriate than
indicating a memory allocation failure.

ACK.

3.

Could this cause firmware compatibility issues in the future?
ikpu_action_entries is an internal kernel array. If new entries are added
to it in future kernel versions, sizeof(ikpu_action_entries) will grow. This
would cause older firmware files to fail the size check above, or miscalculate
the offset for subsequent entries.

There could be a chance, but there is not field in "struct npc_kpu_profile_fwdata"
to indicate sizeof ikpu_action_entries. Adding a new field will break backward compatability etc.
Anyway In future if more entries are planned, we need to come up with a new design to address
this issue.

4.

 +
> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
Does this loop have a bounds checking issue? Unlike the firmware database
path which checks if fw->kpus is greater than profile->kpus, this path only
checked if fw->kpus is greater than rvu->hw->npc_kpus earlier.
If the hardware limit exceeds the size of the statically allocated
profile->kpu array, this could overflow profile->kpu.

ACK.

5.

 +				 "profile size mismatch on kpu%i parsing\n",
> +				 kpu + 1);
> +			return -EINVAL;
> +		}
> +
> +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
> +		entries = min(fw_kpu->entries, rvu->hw->npc_kpu_entries);
Can this result in an out-of-bounds read? The size check above only ensures
that the start of fw_kpu is within the firmware data boundaries. It does not
verify that the entire fw_kpu structure fits within the remaining space before
dereferencing fw_kpu->entries.
> +		dev_info(rvu->dev,
> +			 "Loading %u entries on KPU%d\n", entries, kpu);
> +

ACK.

