Return-Path: <linux-rdma+bounces-22676-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9cSWCKEaRmpDKAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22676-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 10:00:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E56F484D
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 10:00:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YHesv645;
	dkim=pass header.d=redhat.com header.s=google header.b=hs9gKVEx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22676-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22676-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37AEA3149DCF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74652393DF1;
	Thu,  2 Jul 2026 07:42:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5313B2FF6
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 07:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978120; cv=none; b=tGajXCaQI2lkG7lOWwGofkNf6fNxnXsGD2VaEebwzn/PGFEbCXjachOUqlihN4gyjIQ1cpUrIcDu44VUJb61fnmnuBHci6c78OFyLJtzooLubgTSD5mrK4MscKdPZq07j1/NK8hzv9cpfnZ1HSLPBU4A4ah1EXX/GpSciOvgDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978120; c=relaxed/simple;
	bh=Jy7te9F4JzjiJ24kXaDzZA0x2YkjrWkIuXyfcffXSNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwUtpwCmbcs/gsolZE5iCaSuDiVgzDNUiehn4q8cxaxSGdek+xcpnv8XWfr6dh4kQNs+RkjopXUaOnWUrVJ1E6Uqf+FiH59R83+8wbAfT3Sc7HCG4V9xggHyFcCNbtUEfYc8FkrWksWH4qylOM06fwoikVYEgI9tcAzYLdTiKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHesv645; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hs9gKVEx; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782978115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfJYqrcmN2j5NYMZu30t1ga7TK1DhGbiNFDYQD6B84Q=;
	b=YHesv645QvJR2VpGIbaAgQEkurXUIumca+EuEVjVRkohQSc2LD+5VH274e203B87swZri9
	Z2ViBo9BtdkNhIFm/niwAj5rbEmwpps60g4IPFCR1JIE4pUGm3x0tfKT3SjYO05AFITdbg
	hvCSmTtAlACQexwKiyQm6+jF4TOFeQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-PUnQN74CMh2__VpTeJnHlw-1; Thu, 02 Jul 2026 03:41:54 -0400
X-MC-Unique: PUnQN74CMh2__VpTeJnHlw-1
X-Mimecast-MFC-AGG-ID: PUnQN74CMh2__VpTeJnHlw_1782978114
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso9675565e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 00:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782978113; x=1783582913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfJYqrcmN2j5NYMZu30t1ga7TK1DhGbiNFDYQD6B84Q=;
        b=hs9gKVExnvSis062Ar9tXMTNdD22HQOGQSwfUnQ0WYd6z3thW8f5O9lC+ho9k6OsX6
         4TBT3ads+oNnd9iB6RJ42GQcXnZAyX8O9qOFtl/127dP9OpUIcE6jQMEIN5GtxPln4IF
         VYuvWm/16+O+W5thcbB+wV/6GuyCRtoB/wK9vB3c3X61zm5J9ZJu9T9qYq2WaGH79WVf
         HLSCxfKTgUYBzt0J28dmXFQ/xLlrnYDNT8hmiZPiMLv0AP/S2E6/l4z+/r8PkQ1vqytG
         415rB6p0QD8JzVVZzFcuRb1r75j6TtX89Ns2qrnPP9JjO/wt1604hx8mYDtGVARpTNYM
         WTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978113; x=1783582913;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfJYqrcmN2j5NYMZu30t1ga7TK1DhGbiNFDYQD6B84Q=;
        b=Wzb+s33TFO9Sj5tOYhalKxEBR9N3Pc7frgKPuIDOfREILf1UJ+IzgHJhKvVLHS7SoS
         YpIl/3+kYCkFt70kGIyqyup1bs7vPm2Ck0f/SftLRze6rH2LAX1wQ5m2ZSabh/kULNIx
         gOts5cIpfJWEcM5aezoIyTVQjAAcUFT6aYCXMdMlIk7RBhaYjkJIK5Cy26aoY66CVBy2
         O/QDSL9SU1VQKE0+7zyCt3EL97q6hJR3d/pvIcyH4Z/GWL/cOtDzniYIwwoMnYHsBgkr
         1DoSIrQKvYjIqsNrU3KSEugZb26dznC79IOoiGmziupiypTrayZTwOnW6m2G3taYfZtK
         hXDA==
X-Forwarded-Encrypted: i=1; AFNElJ/E8CUVFGZFkT5Kr1nieanE88uQjrxpuaBuGT8+tHlNzAZgGKzEZrvJEdkzcw00BJE2vcaC8csq4p/D@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2aJiPtLQovuTT9LzLbHyYcmJ7fgTcYFkIG8PgnEbQy780mvXi
	UZ+zLHh2GJSgafmQklAsN7BSUnkwtK9zYJ/YD+eX+d3gh1Vno4ZC4e2Web3xHG1dJ598ieg2Y8F
	D21o7hNn2CDYZiR5mKVFjgv9YVoK1aQsGYd/HLCnMBF0nXHqUM6EJFxZeteSYeP4=
X-Gm-Gg: AfdE7ckLicprokfZp0S2LCNzNXHESADzZPq/N8cWKTjpYNEzoQA/GhpBUIMkd3BzWUB
	WIAfw48WgApxWXfKsM8btz1AxtLsUaGXVOatWkZzpag0YCjllwnSmrlDICAdtDwc/oYb/QZRlIT
	lFNep2SplO5S0YzdFT9BGIszaWMq5XseB/af4HDKjl8zNCmmUXjgWw5g87aZl/4l6mnCxih2Xwr
	CwmHrOMUQOeS5fTtm1ueftqQWp9rki/s4dwTkfvLfvrk77/mQFN+/Ny/Bd158DG2KHiIiwN/4D4
	NHQs/SWXHwXwSkbrgB4vlrkH5MOlcAfWxyFRSMjmfURjwpiPrz5o6fYhOzviPGfXFOqVMNp5agH
	3D04PuKT4npgi86wjv33ushh+kkaWa4b7PUbeazH/taSuixPgOdSB45uDN6cL3sQAfEAZ/JMO/H
	vgQ7ziCxQuQQ==
X-Received: by 2002:a05:600c:810b:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493c2b99c43mr64303535e9.32.1782978113456;
        Thu, 02 Jul 2026 00:41:53 -0700 (PDT)
X-Received: by 2002:a05:600c:810b:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493c2b99c43mr64303185e9.32.1782978112913;
        Thu, 02 Jul 2026 00:41:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6377479sm28151965e9.15.2026.07.02.00.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 00:41:52 -0700 (PDT)
Message-ID: <b8ff6104-790e-441f-a095-d50843d241c4@redhat.com>
Date: Thu, 2 Jul 2026 09:41:50 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
To: Mark Bloch <mbloch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629182102.245150-5-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22676-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 583E56F484D

On 6/29/26 8:20 PM, Mark Bloch wrote:
> Apply parsed devlink_eswitch_mode= defaults after devlink registration
> and after successful reload.
> 
> devl_register() may still be called before the device is ready for an
> eswitch mode change, so keep a per-devlink delayed work item and pending
> flag for the registration path. Registration queues the work, and the
> worker tries to take the devlink instance lock.
> 
> If the lock is busy, the worker requeues itself with a delay.
> 
> For successful reloads that performed DRIVER_REINIT, devlink_reload()
> already holds the devlink instance lock and the driver has completed
> reload_up(). Clear pending work and apply the default directly from the
> reload path instead of queueing work.
> 
> If a user sets eswitch mode through netlink before the pending
> registration work runs, clear the pending flag so the queued default does
> not override that user request. Cancel pending default apply work when
> freeing the devlink instance.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  net/devlink/core.c          | 198 +++++++++++++++++++++++++++++++-----
>  net/devlink/dev.c           |   6 ++
>  net/devlink/devl_internal.h |   5 +
>  3 files changed, 182 insertions(+), 27 deletions(-)
> 
> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index 5126509a9c4e..998e4ffd5dce 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/jiffies.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -22,8 +23,12 @@ DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
>  
>  static char *devlink_default_esw_mode_param;
>  static bool devlink_default_esw_mode_match_all;
> +static bool devlink_default_esw_mode_enabled;
>  static enum devlink_eswitch_mode devlink_default_esw_mode;
>  static LIST_HEAD(devlink_default_esw_mode_nodes);
> +static struct workqueue_struct *devlink_default_esw_mode_wq;
> +
> +#define DEVLINK_DEFAULT_ESW_MODE_APPLY_DELAY msecs_to_jiffies(100)
>  
>  struct devlink_default_esw_mode_node {
>  	struct list_head list;
> @@ -166,6 +171,7 @@ static void __init devlink_default_esw_mode_nodes_clear(void)
>  	}
>  
>  	devlink_default_esw_mode_match_all = false;
> +	devlink_default_esw_mode_enabled = false;
>  }
>  
>  static int __init devlink_default_esw_mode_parse(char *str)
> @@ -192,14 +198,113 @@ static int __init devlink_default_esw_mode_parse(char *str)
>  		return err;
>  
>  	err = devlink_default_esw_mode_handles_parse(handles);
> -	if (err)
> +	if (err) {
>  		devlink_default_esw_mode_nodes_clear();
> -	else
> +	} else {
>  		devlink_default_esw_mode = esw_mode;
> +		devlink_default_esw_mode_enabled = true;
> +	}
>  
>  	return err;
>  }
>  
> +static bool devlink_default_esw_mode_match(struct devlink *devlink)
> +{
> +	const char *bus_name = devlink_bus_name(devlink);
> +	const char *dev_name = devlink_dev_name(devlink);
> +	struct devlink_default_esw_mode_node *node;
> +
> +	if (devlink_default_esw_mode_match_all)
> +		return true;
> +
> +	node = devlink_default_esw_mode_node_find(bus_name, dev_name);
> +	return !!node;
> +}
> +
> +void devlink_default_esw_mode_apply(struct devlink *devlink)
> +{
> +	const struct devlink_ops *ops = devlink->ops;
> +	int err;
> +
> +	devl_assert_locked(devlink);
> +
> +	if (!devlink_default_esw_mode_match(devlink))
> +		return;
> +
> +	if (!ops->eswitch_mode_set) {
> +		if (!devlink_default_esw_mode_match_all)
> +			devl_warn(devlink,
> +				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");

Not a very strong opinion on my side, but I *think* it would be more
consistent to emit this warning even for devlink_default_esw_mode_match_all

/P


