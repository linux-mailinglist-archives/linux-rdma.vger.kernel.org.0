Return-Path: <linux-rdma+bounces-21256-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFPpKai6FGoiPwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21256-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:10:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2F5CECEE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D8593017015
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D633815C2;
	Mon, 25 May 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TihYrZW8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559730C371;
	Mon, 25 May 2026 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743393; cv=none; b=oK85V3hxpykg1VCthvTaxHl2kU+sM0o1as0LC15ITwK+wuGKW6VluHL/wNN857I5qvKSNhzI6qXykaHheGRfCF4juyPBk8olOqQ88fTlsG3BFG0600W/KuOP4bGUBxA8DGb9oRwEezbx1O9uelSj9IFcHwxMDnpn7JHXeF1mV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743393; c=relaxed/simple;
	bh=/xYmC0F1r/G0vhtFk4QqxRRRrD5vvJvYIa4MINZvR/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqAC/+u6x190ythWlVJ285tHuBp0C8rLhCgffM+P0Bm5BjiaH7LjkoKh3oYH/kSKDs0Niuh2sUYK59pV0cCMHpZ7QMYwOupCqJbg1Mxuqi1N3IHRRz0vYIPyeye5ie1gEL7u8UDcBR/2aDTNXbvKEDqMhen7Jok14gHtJ+hLvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TihYrZW8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAA91F000E9;
	Mon, 25 May 2026 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743392;
	bh=18u4KIJFG/FGlDDbOxnHj9dWhrDn5wztIGKAiz2Fya0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TihYrZW8bP14POQyR7rxRNh2oCwolKTDzzGEk4yWuemeA19V0T3Igl5LTwR/wxsTw
	 0AwpFE3cSvtNeMoY7BT6/Vdj9XW6nHgEXC59EMpm92U8GhtEAN15uRNTruBmOD0LxU
	 T5QDgJfTKZ/fint3AVyPwzzDNhpQuZRKjAkPpvtcAlm8ZumIUjq41C/egvnixHfnOe
	 IFgXGb/P3Vu3F1qSqFgUZ2fWVZwQru3/1NLfQxpgxXoKMjCQOad/VecAIdC7YnBaK6
	 z6Tzr+ZqlraqbT8FGJd+pTnoiwTauW3MJnvtlUhShF8B0Udz0fCY8wXTzlCfpONwYE
	 /TdFkZi1PvGvg==
Date: Mon, 25 May 2026 14:09:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <netdev@vger.kernel.org>, <oss-drivers@corigine.com>, <akiyano@amazon.com>,
 <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
 <arkadiusz.kubalewski@intel.com>, <brett.creeley@amd.com>,
 <darinzon@amazon.com>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
 <edumazet@google.com>, <horms@kernel.org>, <idosch@nvidia.com>,
 <ivecera@redhat.com>, <jiri@resnulli.us>, <leon@kernel.org>,
 <mbloch@nvidia.com>, <michael.chan@broadcom.com>, <pabeni@redhat.com>,
 <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
 <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
 <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v16 net-next 4/9] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20260525140950.7e5cac5e@kernel.org>
In-Reply-To: <20260521095303.2395584-5-rkannoth@marvell.com>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
	<20260521095303.2395584-5-rkannoth@marvell.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21256-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 51C2F5CECEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 15:22:58 +0530 Ratheesh Kannoth wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
> 
> Devlink param multi-attribute values are considered to be dynamically
> sized arrays of u64 values, by introducing a new devlink param type
> DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
> count of u64 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> 
> Implement get/set parsing and add to the internal value structure passed
> to drivers.
> 
> This is useful for devices that need to configure a list of values for
> a specific configuration.

> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index 1a196d3a843d..6e0e48696f4a 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -252,6 +252,15 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
>  				return -EMSGSIZE;
>  		}
>  		break;
> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> +		for (int i = 0; i < val->u64arr.size; i++) {
> +			if (i >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
> +				break;

Why not check this before the loop and return an error if someone tries
to dump too much data?

> +			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
> +				return -EMSGSIZE;
> +		}
> +		break;
>  	}
>  	return 0;
>  }
> @@ -304,56 +313,78 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
>  				 u32 portid, u32 seq, int flags,
>  				 struct netlink_ext_ack *extack)
>  {
> -	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
> -	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
>  	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
>  	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
>  	const struct devlink_param *param = param_item->param;
> -	struct devlink_param_gset_ctx ctx;
> +	union devlink_param_value *default_value;
> +	union devlink_param_value *param_value;
> +	struct devlink_param_gset_ctx *ctx;
>  	struct nlattr *param_values_list;
>  	struct nlattr *param_attr;
>  	void *hdr;
>  	int err;
>  	int i;
>  
> +	default_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
> +				sizeof(*default_value), GFP_KERNEL);
> +	if (!default_value)
> +		return -ENOMEM;
> +
> +	param_value = kcalloc(DEVLINK_PARAM_CMODE_MAX + 1,
> +			      sizeof(*param_value), GFP_KERNEL);
> +	if (!param_value) {
> +		kfree(default_value);
> +		return -ENOMEM;
> +	}
> +
> +	ctx = kzalloc_obj(*ctx);
> +	if (!ctx) {
> +		kfree(param_value);
> +		kfree(default_value);
> +		return -ENOMEM;
> +	}

The mem alloc should preferably be a separate patch for ease of review.

>  static void devlink_param_notify(struct devlink *devlink,
> @@ -507,7 +545,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
>  				  union devlink_param_value *value)
>  {
>  	struct nlattr *param_data;
> -	int len;
> +	int len, cnt, rem;
>  
>  	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
>  
> @@ -547,6 +585,26 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
>  			return -EINVAL;
>  		value->vbool = nla_get_flag(param_data);
>  		break;
> +
> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> +		cnt = 0;
> +		nla_for_each_attr_type(param_data,
> +				       DEVLINK_ATTR_PARAM_VALUE_DATA,
> +				       genlmsg_data(info->genlhdr),
> +				       genlmsg_len(info->genlhdr), rem) {
> +			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
> +				return -EMSGSIZE;
> +
> +			if ((nla_len(param_data) != sizeof(u64)) &&
> +			    (nla_len(param_data) != sizeof(u32)))

NL_SET_BAD_ATTR() would be good here

> +				return -EINVAL;
> +
> +			value->u64arr.val[cnt] = (u64)nla_get_uint(param_data);

Why the cast? Looks like a leftover..

> +			cnt++;
> +		}
> +
> +		value->u64arr.size = cnt;
> +		break;
>  	}
>  	return 0;
>  }


