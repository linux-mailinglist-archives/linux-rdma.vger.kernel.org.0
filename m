Return-Path: <linux-rdma+bounces-18957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HG4AQMgz2latAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:03:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648D3903DD
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8713028B33
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3234676D;
	Fri,  3 Apr 2026 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC3C2lkq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB312D1F1;
	Fri,  3 Apr 2026 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181742; cv=none; b=q8GpJeSJ96W/ldXHEl7V2DbJuEnEdVcAyD5rNNLeSi6/EzqMKPS+aOsS5m3bIM2cs1Qx6WM2ZJDjjYGwtHZIQjir9VFDWWbdPPTkEr3Y/MV/dQsgBzeNRVwbjZcsecWBTLc6TOTl3FYwj64uGj+tDARtOtXGxLezIcBNAUtvyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181742; c=relaxed/simple;
	bh=hBW6F4YpD0yqJIg2zZyuPH27KccORAZiNhePtVabi0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsyH1ZoA8cGJzTle7HlmRVp4z0+enCLRkrhzLF5rNP1kbbcHIwljg9yvVG4DJoanHPFC7cX9ChJUr5zIbIph0ny9pcr8uKYmBSc5EorMHYTJOr5qA7vKdEHCOQUc+LpDZfBdhl7/twQNE8QbQBG7qA0esGztKAsoBOXNKSKMkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC3C2lkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA79AC116C6;
	Fri,  3 Apr 2026 02:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775181742;
	bh=hBW6F4YpD0yqJIg2zZyuPH27KccORAZiNhePtVabi0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EC3C2lkqB7Bn7bQ13mLQk3s218ldUKnOv1X1OS96uBO7lAItMT5JQ81T4hrEQbgzn
	 H0eOjqKOQkH4V0XESx9AT3gO8Wwdj6cGmmVASJFcE8KmNcL/CwQ5bbmXlcrzvH/uJr
	 HS5uEJrjsZyMqa811+KxUJmatz0EcxgRhXzI0X6eq/x3ivhj9bG0DUBnHNBpQEjgKw
	 Y0lOtlEmeRUbaXULuYsJLqBZ3teeFWcCjRGgkm75SLtenoGilEAWEEFZXwbvk1Uugd
	 VFJDMCkc2zdOLpKUrWL8yF9zCMtr/cjqtDU3SS57ImJA0Whq1LjyWDt5IKMdNIOm/1
	 65jg+CGIITnaw==
Date: Thu, 2 Apr 2026 19:02:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka
 <daniel.zahka@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, Cosmin
 Ratiu <cratiu@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shay Drori
 <shayd@nvidia.com>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, Kees
 Cook <kees@kernel.org>, "Daniel Jurgens" <danielj@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V4 10/12] devlink: Add resource scope filtering
 to resource dump
Message-ID: <20260402190219.61ea7da1@kernel.org>
In-Reply-To: <20260401184947.135205-11-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
	<20260401184947.135205-11-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18957-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9648D3903DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 21:49:45 +0300 Tariq Toukan wrote:
> @@ -873,6 +881,16 @@ attribute-sets:
>          doc: Unique devlink instance index.
>          checks:
>            max: u32-max
> +      -
> +        name: resource-scope-mask
> +        type: bitfield32

no need for a bitfield here, this is a simpler selector
bitfield is for cases when we need to update some persistent
state, in that case we want to indicate which bits we intend
to update:

	cfg = (cfg & ~bf.mask) | bf.val

scope is a straight attribute, there's no updating of anything.

u32 or unit would do

> +        enum: resource-scope
> +        enum-as-flags: true
> +        doc: |
> +          Bitmask selecting which resource classes to include in a
> +          resource-dump response. Bit 0 (dev) selects device-level
> +          resources; bit 1 (port) selects port-level resources.
> +          When absent all classes are returned.
>    -
>      name: dl-dev-stats
>      subset-of: devlink
> @@ -1775,7 +1793,11 @@ operations:
>              - resource-list
>        dump:
>          request:
> -          attributes: *dev-id-attrs
> +          attributes:
> +            - bus-name
> +            - dev-name
> +            - index
> +            - resource-scope-mask
>          reply: *resource-dump-reply
>  
>      -
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index 7de2d8cc862f..e0a0b523ce5c 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -645,6 +645,7 @@ enum devlink_attr {
>  	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
>  
>  	DEVLINK_ATTR_INDEX,			/* uint */
> +	DEVLINK_ATTR_RESOURCE_SCOPE_MASK,	/* bitfield32 */
>  
>  	/* Add new attributes above here, update the spec in
>  	 * Documentation/netlink/specs/devlink.yaml and re-generate
> @@ -704,6 +705,22 @@ enum devlink_resource_unit {
>  	DEVLINK_RESOURCE_UNIT_ENTRY,
>  };
>  
> +enum devlink_resource_scope {
> +	DEVLINK_RESOURCE_SCOPE_DEV_BIT,
> +	DEVLINK_RESOURCE_SCOPE_PORT_BIT,
> +
> +	__DEVLINK_RESOURCE_SCOPE_MAX_BIT,
> +	DEVLINK_RESOURCE_SCOPE_MAX_BIT =

do we need this? it's not an attr enum all we care about here is 
the mask, really so just a trailing value which is max real value + 1
is enough for all users?

> +		__DEVLINK_RESOURCE_SCOPE_MAX_BIT - 1
> +};
> +
> +#define DEVLINK_RESOURCE_SCOPE_DEV \
> +	_BITUL(DEVLINK_RESOURCE_SCOPE_DEV_BIT)
> +#define DEVLINK_RESOURCE_SCOPE_PORT \
> +	_BITUL(DEVLINK_RESOURCE_SCOPE_PORT_BIT)
> +#define DEVLINK_RESOURCE_SCOPE_VALID_MASK \
> +	(_BITUL(__DEVLINK_RESOURCE_SCOPE_MAX_BIT) - 1)
> +
>  enum devlink_port_fn_attr_cap {
>  	DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT,
>  	DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,

> +static u32 devlink_resource_scope_get(struct nlattr **attrs, int *flags)
> +{
> +	struct nla_bitfield32 scope;
> +	u32 value;
> +
> +	if (!attrs || !attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK])
> +		return DEVLINK_RESOURCE_SCOPE_VALID_MASK;
> +
> +	scope = nla_get_bitfield32(attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK]);
> +	value = scope.value & scope.selector;
> +	if (value != DEVLINK_RESOURCE_SCOPE_VALID_MASK)
> +		*flags |= NLM_F_DUMP_FILTERED;
> +
> +	return value;
> +}
> +
>  static int
>  devlink_resource_dump_fill_one(struct sk_buff *skb, struct devlink *devlink,
>  			       struct devlink_port *devlink_port,
> @@ -400,16 +416,27 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
>  	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
>  	struct devlink_port *devlink_port;
>  	unsigned long port_idx;
> +	u32 scope;
>  	int err;
>  
> -	if (!state->port_number) {
> +	scope = devlink_resource_scope_get(genl_info_dump(cb)->attrs, &flags);
> +	if (!scope) {
> +		NL_SET_ERR_MSG_ATTR(genl_info_dump(cb)->extack,
> +				    genl_info_dump(cb)->attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK],

we have genl_info_dump(cb) 3 times here, let's save the pointer 
on the stack to make the lines shorter.

> +				    "empty resource scope selection");
> +		return -EINVAL;
> +	}
> +	if (!state->port_number && (scope & DEVLINK_RESOURCE_SCOPE_DEV)) {
>  		err = devlink_resource_dump_fill_one(skb, devlink, NULL,
> -						     cb, flags, &state->idx);
> +						     cb, flags,
> +						     &state->idx);
>  		if (err)
>  			return err;
>  		state->idx = 0;
>  	}
>  
> +	if (!(scope & DEVLINK_RESOURCE_SCOPE_PORT))
> +		goto out;
>  	xa_for_each_start(&devlink->ports, port_idx, devlink_port,
>  			  state->port_number ? state->port_number - 1 : 0) {
>  		err = devlink_resource_dump_fill_one(skb, devlink, devlink_port,
> @@ -420,6 +447,7 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
>  		}
>  		state->idx = 0;
>  	}
> +out:
>  	state->port_number = 0;
>  	return 0;
>  }


