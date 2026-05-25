Return-Path: <linux-rdma+bounces-21222-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKpzKJ7vE2qmHgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21222-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:43:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F05C6ACF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED425301DC08
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 06:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945293A9619;
	Mon, 25 May 2026 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WzXg0N9I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390F3A872C
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691377; cv=none; b=QjZ/UQP7r3avzwmN+6sdF6vMC3VvT4vaOIVUYnQMh2emW7EBfvjbcv2/gAkZDCuBcZXG7rejzutq1lecj6XR30nsmhLgVWBem1uK1Q1oag+EzPmYkPhPTpzNEkeTqDNhiEO7DubimKTDLO23pp6+nUzNjWKBQCBXTI7B2e+vi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691377; c=relaxed/simple;
	bh=JbLaP6fcvKubuL+zTJcUy1Ym67MrJo66/BluyL5zcsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbOEwCmP63emNyVtyjnl5tQNDy/eU5tZ5CEhOy/4x22BAuKspFQJWwBu6L6saFX31n8dMgAYAvh8OBG4d1qAdpjJGuRMvVi2yuE9DCgeQ4ZsdjnzO+96GGbNJdY2ieFfWDat6VuvaL7QE8RjVZB3UQDCM0I0S6h00N/hDVkNRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WzXg0N9I; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44c350a5b87so5469594f8f.3
        for <linux-rdma@vger.kernel.org>; Sun, 24 May 2026 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779691370; x=1780296170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEZRj2571b7ZAcO7kVJkp53O1mFYjo1HMv8D+CFT+gA=;
        b=WzXg0N9IKqi1lFC84xXyvdJULlCUIVDba14nAJGbIe1wgF3I4GF+JEvvfk+F0YxOpi
         a2YPqA/aJlHIFnhpRck0HHziPQhjPO9+Ak/xSWFThejVxazYn7oU4Qi5upo5tWvTQ9IF
         ctext3tHAFGf3uuhNRoTyIyj9gPSku0zR9d2f8R/ePKEQnHM2VPGCzr14ClTp7dDhJ3a
         VuDUiOYpfpDepCwMQGGqcYysmy4WfSs5PhYzKEyYqo+TAopKS9s5P99TRD8yfS1eVi1Y
         NbvZRPhXOQfyMDZWbkLdrTgv0gUOaUAoCv9mIAtjUW6Ge7+hRnbjJA6mBhOmps/LU9zf
         frQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691370; x=1780296170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEZRj2571b7ZAcO7kVJkp53O1mFYjo1HMv8D+CFT+gA=;
        b=M33+Zy0eilgtKOa0iYUJvjtf3Lzo9NF3NJmP/h4AUer7AnFj6PyzglDmJqWqHUntSW
         Zq1J3wCArCEsOIwZyk6S8mEdDf0M7uew6ffKb7h+SA9ZJxIUP4xQP56rr86d3tEgIDGv
         s7A6w+UF6LSwK2yvuYU7bdPhV+wi3ONuqQQ9Q3YX01PuzWrjdJmcF00J0/6mylgUThpv
         PnozpxN8jB4nmUJNdxTGR4HRj5wbsH+kegc2EDPL0k06IvenvTz0+pEtDZhVocYjMDsP
         m0tKyJj+ySz3M8yG7f3+UuWrxaoCI5LcUCCFISVXhP+gekHO9Go4aUy/2Dqx3bzhikCF
         uJ/w==
X-Forwarded-Encrypted: i=1; AFNElJ+Z7VOvT1E+j7XjKAVDqADxHxnCCTRFcMVAdMcUUWUseXmm9JzfheRm8I4nbE5+rwrTaiHKCbdUS8hW@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIKFeeZgPV37F0xkcEOmcWGeY1GEVnlY8oWxgC+F26avCOdvu
	QKowx40ehWFbhl6hc82BbStxFx3azy8HROExGNf+c3j1RQ+sz3EzBUfQyrkqNyInNmI=
X-Gm-Gg: Acq92OHmWT4sLMkFrIRLc1JY/5Wc/iATn8t8KUI0DUOAXXG5DuTLTngn9AGRrXXfLFB
	NbTnEK63GYfvZ/Y0R+5IN81sYeq2DhSTM1u+asCekdEei/coaqX/Mgzx2gj9cBsf/Wf8JXnpTRU
	Tnj8pfT8JdiRDWjtmDhfOMnOa+qpn5/IHBBW9iO5LHv27YBZ3T52Wpcd5nOE7+4bBqCpKffzC+M
	S+GD3o5CTvlaeTrsq4IqZnKG9dxHRfDTrgK5KJW407+D/D/9JOh8mCupffs1cP0zA7ih9RpddmO
	TG507Phv1rlUhem9zoCSCasRTbAz1aw5M9c78lyeh+RhD/e/4IKshizZ6MQo6sJ4XGpVNjeylzp
	/zcUX+M5m8acGgK+0ZwjPBaF5/BpGRzZe9zluf3UMjpCmC7bAVYb6nB4hsUWcUYKU+mCMSSVQMT
	3XXYs4YPd11lPY+7JCF6AhghAa+QyBKNLOMI9DIuwrzpAw1HUUGTdulwRCyhjagYCNAj8WoHEx5
	2w=
X-Received: by 2002:a05:6000:25fd:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-45eb38a66f0mr19783111f8f.22.1779691370111;
        Sun, 24 May 2026 23:42:50 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4903bsm23009377f8f.21.2026.05.24.23.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 23:42:49 -0700 (PDT)
Message-ID: <5470aa87-fa5f-4713-9199-b6297308973a@blackwall.org>
Date: Mon, 25 May 2026 09:42:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/2] net/mlx5: implement max_sfs parameter
To: Jakub Kicinski <kuba@kernel.org>, tariqt@nvidia.com
Cc: edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, jiri@resnulli.us, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, vdumitrescu@nvidia.com, aleksandr.loktionov@intel.com,
 daniel.zahka@gmail.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com,
 jiri@nvidia.com, nikolay@nvidia.com
References: <20260519200436.353249-3-tariqt@nvidia.com>
 <20260522181943.1495576-1-kuba@kernel.org>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260522181943.1495576-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21222-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:mid,blackwall.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 442F05C6ACF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/05/2026 21:19, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: implement max_sfs parameter
> 
> This patch adds a generic devlink permanent parameter named max_sfs to
> the mlx5 driver so users can cap the number of light-weight NIC
> subfunctions via devlink instead of vendor tooling. The setter rewrites
> non-volatile firmware fields in nv_global_pci_conf and nv_pf_pci_conf,
> and a reboot is required for the change to take effect.
> 
> A few questions on the implementation below.
> 
>> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>> index 4bba4d780a4a..f5e2dccafa5a 100644
>> --- a/Documentation/networking/devlink/mlx5.rst
>> +++ b/Documentation/networking/devlink/mlx5.rst
>> @@ -45,8 +45,13 @@ Parameters
>>        - The range is between 1 and a device-specific max.
>>        - Applies to each physical function (PF) independently, if the device
>>          supports it. Otherwise, it applies symmetrically to all PFs.
>> +   * - ``max_sfs``
>> +     - permanent
>> +     - The range is between 0 and a device-specific max.
>> +     - Applies to each physical function (PF) independently.
> 
> [Medium, Medium]
> The documentation states the range is "between 0 and a device-specific
> max", and the entry says max_sfs "Applies to each physical function (PF)
> independently" with no "if the device supports it" qualifier like
> total_vfs has.
> 
> Looking at the implementation in mlx5_devlink_max_sfs_set(), there is no
> read of any nv_global_pci_cap field to obtain a device-reported maximum,
> and the registration uses NULL for the validate callback:
> 
>    DEVLINK_PARAM_GENERIC(MAX_SFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>                          mlx5_devlink_max_sfs_get,
>                          mlx5_devlink_max_sfs_set, NULL),
> 
> Should there be a validate callback analogous to
> mlx5_devlink_total_vfs_validate() that reads the cap and rejects values
> above the device-reported maximum, so the documented "device-specific
> max" is actually enforced?
> 

I don't know of such cap, if there was I'd have added it.

> Should the doc also include the "if the device supports it" qualifier
> to match how the setter behaves on devices without the relevant
> capability?
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>> index 19bb620b7436..eff3a67e4ca0 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>> @@ -68,7 +68,9 @@ struct mlx5_ifc_mnvda_reg_bits {
>>   
>>   struct mlx5_ifc_nv_global_pci_conf_bits {
>>   	u8         sriov_valid[0x1];
>> -	u8         reserved_at_1[0x10];
>> +	u8         reserved_at_1[0xa];
>> +	u8         per_pf_num_sf[0x1];
>> +	u8         reserved_at_c[0x5];
>>   	u8         per_pf_total_vf[0x1];
>>   	u8         reserved_at_12[0xe];
> 
> [ ... ]
> 
>> @@ -93,9 +95,11 @@ struct mlx5_ifc_nv_global_pci_cap_bits {
>>   };
>>   
>>   struct mlx5_ifc_nv_pf_pci_conf_bits {
>> -	u8         reserved_at_0[0x9];
>> +	u8         log_sf_bar_size[0x8];
>> +	u8         pf_total_sf_en[0x1];
>>   	u8         pf_total_vf_en[0x1];
>> -	u8         reserved_at_a[0x16];
>> +	u8         reserved_at_a[0x6];
>> +	u8         total_sf[0x10];
>>   
>>   	u8         reserved_at_20[0x20];
> 
> [Medium]
> The on-wire field total_sf is 16 bits wide, but the devlink parameter
> is registered as DEVLINK_PARAM_TYPE_U32 (max_sfs uses
> DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE, which is u32) and the setter writes
> ctx->val.vu32 directly via MLX5_SET(nv_pf_pci_conf, data, total_sf,
> ctx->val.vu32).
> 
> MLX5_SET masks the value with __mlx5_mask(typ, fld) before storing, so
> any user-supplied value above 0xffff is silently truncated.  For
> example, "devlink dev param set ... name max_sfs value 70000" would
> persistently store 4464.
> 
> Without a validate callback, is there anything that prevents this
> silent truncation, and should the setter or a validate hook reject
> values that do not fit in 16 bits?
> 

This is benign but I'll cap it at 16 bits for the next version.

>> @@ -755,6 +759,76 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
>>   	return 0;
>>   }
>>   
>> +static int mlx5_devlink_max_sfs_get(struct devlink *devlink, u32 id,
>> +				    struct devlink_param_gset_ctx *ctx,
>> +				    struct netlink_ext_ack *extack)
>> +{
>> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
>> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>> +	void *data;
>> +	int err;
>> +
>> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>> +	if (err) {
>> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
>> +		return err;
>> +	}
>> +
>> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> +	ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_sf);
>> +
>> +	return 0;
>> +}
> 
> [Medium]
> Should max_sfs_get() mirror mlx5_devlink_total_vfs_get() and consult
> nv_global_pci_conf.per_pf_num_sf before reporting nv_pf_pci_conf.total_sf?
> 
> The setter explicitly conditions the meaning of per-PF total_sf on
> per_pf_num_sf:
> 
>    MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
>    ...
>    MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);
> 
> But the getter reads total_sf unconditionally, so on a device whose
> firmware was previously configured by another tool with per_pf_num_sf=0
> and a stale per-host total_sf, "devlink dev param show" would return a
> non-zero value that does not represent the active SF policy.  Is that
> intentional?
> 

No.

>> +static int mlx5_devlink_max_sfs_set(struct devlink *devlink, u32 id,
>> +				    struct devlink_param_gset_ctx *ctx,
>> +				    struct netlink_ext_ack *extack)
>> +{
>> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
>> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>> +	void *data;
>> +	int err;
>> +
>> +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>> +	if (err) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Failed to read global PCI configuration");
>> +		return err;
>> +	}
>> +
>> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> +	MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
>> +
>> +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>> +	if (err) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Failed to change per_pf_num_sf global PCI configuration");
>> +		return err;
>> +	}
> 
> [Medium]
> Should this path first read nv_global_pci_cap and reject the operation
> when the device does not advertise SF NV configuration, the way
> mlx5_devlink_total_vfs_set() does for SR-IOV?
> 
> mlx5_devlink_total_vfs_set() rejects with -EOPNOTSUPP and an extack
> "SRIOV is not per PF on this device" when sriov_support or
> per_pf_total_vf_supported is clear, but no equivalent
> per_pf_num_sf_supported (or any SF-related) capability bit is added to
> nv_global_pci_cap_bits or queried here.  On hardware that lacks the
> feature, the user only sees the generic firmware error "Failed to
> change ... global PCI configuration".
> 

I don't know of such bit, if there was such bit I'd have added it.

> [Medium]
> At this point, a successful write of per_pf_num_sf has already been
> committed to non-volatile firmware storage.  If the subsequent
> mlx5_nv_param_read_per_host_pf_conf() or the second mlx5_nv_param_write()
> fails (for example, transient firmware/PCIe issue), is there a path that
> rolls back per_pf_num_sf?
> 
> Because these are permanent parameters that "require a reboot to take
> effect", a half-applied state (e.g., per_pf_num_sf=1 but
> pf_total_sf_en=0/total_sf=0) appears to persist across reboots until
> the user issues another successful set.
> 

sure, that is expected

>> +
>> +	memset(mnvda, 0, sizeof(mnvda));
>> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>> +	if (err) {
>> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
>> +		return err;
>> +	}
>> +
>> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>> +	MLX5_SET(nv_pf_pci_conf, data, log_sf_bar_size, ctx->val.vu32 ? 12 : 0);
> 
> [Low]
> What is the meaning of the literal 12 here, and why is it correct on
> all supported devices?
> 

It is a sane default, some day we can make it configurable as well.

> Elsewhere in the driver, the SF BAR length is computed from a
> hardware-reported capability rather than a fixed value:
> 
>    drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c:
>        sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
> 
> Should log_sf_bar_size be derived from MLX5_CAP_GEN(dev,
> log_min_sf_size) (or another cap) rather than hardcoded?
> 

Interesting, I'll check this out.

> The commit message says max_sfs is to "control the total light-weight
> NIC subfunctions"; the BAR-size side-effect is not mentioned, and any
> previously configured log_sf_bar_size is overwritten on every
> max_sfs set.  Should that behavior be documented or split out from the
> count knob?
> 

It should be documented when it is split out, at present time - no.

>> +	MLX5_SET(nv_pf_pci_conf, data, pf_total_sf_en, !!ctx->val.vu32);
>> +	MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);
>> +
>> +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>> +	if (err) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Failed to change PF PCI configuration");
>> +		return err;
>> +	}
>> +	NL_SET_ERR_MSG(extack, "Modifying max_sfs requires a reboot");
>> +
>> +	return 0;
>> +}


