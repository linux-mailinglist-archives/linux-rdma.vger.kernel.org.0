Return-Path: <linux-rdma+bounces-19078-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKLuMl7V1GnuxwcAu9opvQ
	(envelope-from <linux-rdma+bounces-19078-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 11:58:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F53A3AC68C
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 11:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 904AB3005793
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CB3A6F1C;
	Tue,  7 Apr 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyssR791";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9+bc5Vk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE93A6EE9
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555899; cv=none; b=o2nlDT1FLrW6mXuuQd1ptvZYmRt7d3aR7GA/N7Tc7Xck8RRCWI70CKIb6eWJYi/x+CgM1xgPrqzzlKq+EGmmCLHdyLkHR9afp9of/SZtvLX9HdWmEIrqDtocqgJg54XHczlG3bF80UmwhS1GkqEtzrAoc28+ckvigyyGoIVvLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555899; c=relaxed/simple;
	bh=wEAMNlkQCnRjouKyWtNgJ7sl+TnyCZUrhRB11EHBhnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJP8g3cZe48gCXJlZnb3BJ2pw+RW7rnG0hxKCB1tRztxvuo2eLanYQ9wC4r5lqUWoxib2+0Cac2V3Ti02jMQ4UmaRNtyuwLFiRlODIN1mzKAn/vVAW7ymLNkutTB4Qjw5XX6naXKbqz5jNJvQoudMjHyulYT5CVs5+HUKLSvgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyssR791; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9+bc5Vk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775555896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLREW3RimYXp6pMWCsCdtY17DI2aIBPhZJcOYp3npp0=;
	b=WyssR791vEhS8s8Gk7/aKfruD1XLKSyL8RRSFY8MH6uSjAx+YU80dL6Qp++HlmksFdn7L3
	ZqnxNEWmfG9/om+FIBcgZSCr2aRRvUWR2tvO3t+OUijv/Do2+w1EiIUj6bM6gzf8vkJovO
	XY7+LYaZH3XIbHOpg4sFyVoBdwv811c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-W4c7qATRPKO461kjFmBjKw-1; Tue, 07 Apr 2026 05:58:15 -0400
X-MC-Unique: W4c7qATRPKO461kjFmBjKw-1
X-Mimecast-MFC-AGG-ID: W4c7qATRPKO461kjFmBjKw_1775555894
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so4939180f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2026 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775555894; x=1776160694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLREW3RimYXp6pMWCsCdtY17DI2aIBPhZJcOYp3npp0=;
        b=O9+bc5VkAeIjaquLbEG7G3BsVTWLtCoXOv7g3Icp4rmDUfoR/0Jke6bmpHGAgUnoSz
         44g2XlTdi6MstQXTdi96wAMgYmrpfs7wPUINwvJpXE2M3QFP7CqaUVw8KYbKHVOKfXc0
         S/b6k+w9Ujfo4mkuG3YcP9IOqrvXS3fFoEXW1dkaN82ToJNdjavzsZtkRogC39PCWdUu
         LqQOUTNTTACWBHVILxquQLcxwS61ATUqRkdQkYeJiQYpqSKoPIIhIWgyzm2SySTG4+Cs
         eQqQHR++blmrXeP9vGPC6/tMSxK+rQxPwyB1F3br3O3MQvl2O0O/jGo0bHp2po8Q5Svz
         fC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775555894; x=1776160694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLREW3RimYXp6pMWCsCdtY17DI2aIBPhZJcOYp3npp0=;
        b=lLo4imslPDgywZjzgP+C4gL25lLf5QRPd9RntIZViUFXIIzRiDxoJ5uUJcpIt3UcYL
         BBx1VoCdFAi8pNj1eHO57s8UV1qAvprEfZ0vYmhvZyYNzG//FD/iE2kEA+Mk/tJmdiY1
         I1zuLanAz67gpyjMJdUqkbamrOJKYBIUElTL0NnZnHq04MDK4b0g7/7rVpKLjFhr2Fxb
         P+QdkMzVC7fIsMC7XhGDPNEW6TjsDZrmGxSfeilmWwFzHwa0oLWrUUHAkJq1nZVH7Vv5
         qMRBhUp+BpHWSAIEPlJ6RmM3TQ75FVKmvlFDaokhQCxltlcgk8cW5ztTtcLKC3rAdzdF
         lHzg==
X-Forwarded-Encrypted: i=1; AJvYcCWIcQ8iI7/lGe81JcGFSGcUZoykcMfjfD6UcFgvNJKicpjrfMeCXAVZIM6QnzpLnYHXdO+zulDDUe8f@vger.kernel.org
X-Gm-Message-State: AOJu0YynKOgOcuFbVirRXy/BSECn3fXxZrjh6UOGrrO3IEz6ckxUKUlY
	ZKyyO1LQiMOf5s/42kOVo528rXjS6GLRA0ppB+0kTuHEiScXCfOd7VD66TIo8QqIFq48KQJ2KnG
	gYkPXC/SYlSER/RM0kcGs9Su61sOnAERGzQhmJmpCdQPEhdxZJBs2vzmwB570xbY=
X-Gm-Gg: AeBDieui3+XeaB+ZVgxOJIRYGkVkA0YfuJtpeviZwTVGwPOMKMARjXn7u5VQ0hlTNdN
	FvS6/Y3ySFozOvFNibSSV8o2dIzK03WdkNzDAWPTy8dtUYsGWq367/ATet5jC/LXYysR0ZpQr05
	s+JpoTjGEab00Qi+DivRZ0Eh5nMpB1aRbcK1JPe7rBgNYBsYtJQQqo/ElyxfPWzQyOyWFgp/fki
	jdI7nCk2wZBJoAmJfPjDXcHGSngwgGxk5EvKKFoURaYwvwKt7cj4uFSAZ8l3ipDTyoA+Z06iRAQ
	ayNwkvmB9Jdgli5lIOqkSpW3TZcW7iZxrHe/sF1hWoQTxwZ8X9R+zbnRJi1/UGFTFmJeuoT0c2y
	JXv989rtZE8ST7Q4ZZgEOk/zWzM+Y0JzI1KV2r1gz5pMOdgYQGXb9F4k85Q==
X-Received: by 2002:a05:6000:230c:b0:43d:2581:3053 with SMTP id ffacd0b85a97d-43d292ff9c6mr22013868f8f.45.1775555893726;
        Tue, 07 Apr 2026 02:58:13 -0700 (PDT)
X-Received: by 2002:a05:6000:230c:b0:43d:2581:3053 with SMTP id ffacd0b85a97d-43d292ff9c6mr22013794f8f.45.1775555893076;
        Tue, 07 Apr 2026 02:58:13 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm46955754f8f.37.2026.04.07.02.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:58:12 -0700 (PDT)
Message-ID: <c14a0783-a69f-448d-a464-2d802e6d0ec7@redhat.com>
Date: Tue, 7 Apr 2026 11:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 3/6] devlink: Implement devlink param multi
 attribute nested data values
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, donald.hunter@gmail.com,
 horms@kernel.org, jiri@resnulli.us, chuck.lever@oracle.com,
 matttbe@kernel.org, cjubran@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, dtatulea@nvidia.com
References: <20260403025533.6250-1-rkannoth@marvell.com>
 <20260403025533.6250-4-rkannoth@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403025533.6250-4-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-19078-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2F53A3AC68C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 4:55 AM, Ratheesh Kannoth wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
> 
> Devlink param multi-attribute values are considered to be dynamically
> sized arrays of u64 values, by introducing a new devlink param type
> DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> 
> Implement get/set parsing and add to the internal value structure passed
> to drivers.
> 
> This is useful for devices that need to configure a list of values for
> a specific configuration.
> 
> example:
> $ devlink dev param show pci/... name multi-value-param
> name multi-value-param type driver-specific
> values:
> cmode permanent value: 0,1,2,3,4,5,6,7
> 
> $ devlink dev param set pci/... name multi-value-param \
> 		value 4,5,6,7,0,1,2,3 cmode permanent
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  Documentation/netlink/specs/devlink.yaml |  4 ++
>  include/net/devlink.h                    |  8 +++
>  include/uapi/linux/devlink.h             |  1 +
>  net/devlink/netlink_gen.c                |  2 +
>  net/devlink/param.c                      | 91 +++++++++++++++++++-----
>  5 files changed, 89 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index b495d56b9137..b619de4fe08a 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -226,6 +226,10 @@ definitions:
>          value: 10
>        -
>          name: binary
> +      -
> +        name: u64-array
> +        value: 129
> +
>    -
>      name: rate-tc-index-max
>      type: const
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 3038af6ec017..3a355fea8189 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -432,6 +432,13 @@ enum devlink_param_type {
>  	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
>  	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
>  	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
> +	DEVLINK_PARAM_TYPE_U64_ARRAY = DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
> +};
> +
> +#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
> +struct devlink_param_u64_array {
> +	u64 size;
> +	u64 val[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
>  };
>  
>  union devlink_param_value {
> @@ -441,6 +448,7 @@ union devlink_param_value {
>  	u64 vu64;
>  	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
>  	bool vbool;
> +	struct devlink_param_u64_array u64arr;

Sashiko as a couple of relevant remarks here, specifically:

---
Does this increase the size of union devlink_param_value from 32 bytes
to over 264 bytes?
Looking at existing functions like devlink_nl_param_value_fill_one() and
devlink_nl_param_value_put(), they take multiple copies of this union by
value. Passing two of these unions by value consumes over 528 bytes of
stack space, and combined in a call chain this pushes nearly 800 bytes
of arguments onto the stack.
Could this create a risk of hitting CONFIG_FRAME_WARN limits deep in
driver notification contexts? Should the signatures of the internal
functions and exported APIs be updated to pass the unions by pointer
instead?
---

>  };
>  
>  struct devlink_param_gset_ctx {
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index 7de2d8cc862f..5332223dd6d0 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -406,6 +406,7 @@ enum devlink_var_attr_type {
>  	DEVLINK_VAR_ATTR_TYPE_BINARY,
>  	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
>  	/* Any possible custom types, unrelated to NLA_* values go below */
> +	DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
>  };
>  
>  enum devlink_attr {
> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index eb35e80e01d1..7aaf462f27ee 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -37,6 +37,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
>  	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
>  		fallthrough;
>  	case DEVLINK_VAR_ATTR_TYPE_BINARY:
> +		fallthrough;
> +	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
>  		return 0;
>  	}
>  	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index cf95268da5b0..2ec85dffd8ac 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
>  				return -EMSGSIZE;
>  		}
>  		break;
> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> +		if (val.u64arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)
> +			return -EMSGSIZE;
> +
> +		for (int i = 0; i < val.u64arr.size; i++)
> +			if (nla_put_uint(msg, nla_type, val.u64arr.val[i]))
> +				return -EMSGSIZE;
> +		break;
>  	}
>  	return 0;
>  }
> @@ -304,56 +312,78 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
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
> +	ctx = kmalloc_obj(*ctx);
> +	if (!ctx) {
> +		kfree(param_value);
> +		kfree(default_value);
> +		return -ENOMEM;
> +	}
> +
>  	/* Get value from driver part to driverinit configuration mode */
>  	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
>  		if (!devlink_param_cmode_is_supported(param, i))
>  			continue;
>  		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
> -			if (param_item->driverinit_value_new_valid)
> +			if (param_item->driverinit_value_new_valid) {
>  				param_value[i] = param_item->driverinit_value_new;
> -			else if (param_item->driverinit_value_valid)
> +			} else if (param_item->driverinit_value_valid) {
>  				param_value[i] = param_item->driverinit_value;
> -			else
> -				return -EOPNOTSUPP;
> +			} else {
> +				err = -EOPNOTSUPP;
> +				goto get_put_fail;
> +			}
>  
>  			if (param_item->driverinit_value_valid) {
>  				default_value[i] = param_item->driverinit_default;
>  				default_value_set[i] = true;
>  			}
>  		} else {
> -			ctx.cmode = i;
> -			err = devlink_param_get(devlink, param, &ctx, extack);
> +			ctx->cmode = i;
> +			err = devlink_param_get(devlink, param, ctx, extack);
>  			if (err)
> -				return err;
> -			param_value[i] = ctx.val;
> +				goto get_put_fail;
> +			param_value[i] = ctx->val;
>  
> -			err = devlink_param_get_default(devlink, param, &ctx,
> +			err = devlink_param_get_default(devlink, param, ctx,
>  							extack);
>  			if (!err) {
> -				default_value[i] = ctx.val;
> +				default_value[i] = ctx->val;
>  				default_value_set[i] = true;
>  			} else if (err != -EOPNOTSUPP) {
> -				return err;
> +				goto get_put_fail;
>  			}
>  		}
>  		param_value_set[i] = true;
>  	}
>  
> +	err = -EMSGSIZE;
>  	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
>  	if (!hdr)
> -		return -EMSGSIZE;
> +		goto get_put_fail;
>  
>  	if (devlink_nl_put_handle(msg, devlink))
>  		goto genlmsg_cancel;
> @@ -393,6 +423,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
>  	nla_nest_end(msg, param_values_list);
>  	nla_nest_end(msg, param_attr);
>  	genlmsg_end(msg, hdr);
> +	kfree(default_value);
> +	kfree(param_value);
> +	kfree(ctx);
>  	return 0;
>  
>  values_list_nest_cancel:
> @@ -401,7 +434,11 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
>  	nla_nest_cancel(msg, param_attr);
>  genlmsg_cancel:
>  	genlmsg_cancel(msg, hdr);
> -	return -EMSGSIZE;
> +get_put_fail:
> +	kfree(default_value);
> +	kfree(param_value);
> +	kfree(ctx);
> +	return err;
>  }
>  
>  static void devlink_param_notify(struct devlink *devlink,
> @@ -507,7 +544,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
>  				  union devlink_param_value *value)
>  {
>  	struct nlattr *param_data;
> -	int len;
> +	int len, cnt, rem;
>  
>  	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
>  
> @@ -547,6 +584,26 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
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
> +				return -EINVAL;
> +
> +			value->u64arr.val[cnt] = (u64)nla_get_uint(param_data);
> +			cnt++;
> +		}
> +
> +		value->u64arr.size = cnt;
> +		break;

Sashiko says:

---
Does this make it impossible to set an empty array to clear a
multi-value parameter?
If userspace provides 0 elements, param_data will be NULL. Earlier in
devlink_param_value_get_from_info(), there is a check:
	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
	if (param->type != DEVLINK_PARAM_TYPE_BOOL && !param_data)
		return -EINVAL;
If the parameter is a U64_ARRAY and no data is provided, this check will
immediately return -EINVAL.
The kernel can successfully emit an empty array on a GET request if the
size is 0. Should the SET path similarly support receiving 0 elements to
allow userspace to clear a multi-value parameter?
---

There are several others NIC-specific remarks, which IMHO are mostly
pre-existing issues, but please have a look:

https://sashiko.dev/#/patchset/20260403025533.6250-1-rkannoth%40marvell.com

/P


