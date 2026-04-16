Return-Path: <linux-rdma+bounces-19385-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFvfKkWh4GlukQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19385-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 10:43:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59640BBCA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 10:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD2C93015754
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C03932EE;
	Thu, 16 Apr 2026 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxUqOQb9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2675384234
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329013; cv=none; b=l/Ebz0NUuTksoietrzDC5VcHGHPqer5wXs1OZ2OF9UXCCYHrL5YFw+QJIcZxRpu0NNKaUDl0RxcbmrYTkYAQ6XjCPk1KGQD+4ZTEMlaEGxTaqFJ6Vd2cU++xqWZVYE0+coTGhKi7wWFWdD/O+o2EdEwdPxh/ILmu6sfG+mITdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329013; c=relaxed/simple;
	bh=jy/rxoo1p+ve/buQpTXSWcCvo/2NKUN0XefnO0bJeYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv1CtAJanEBcdaH8YsA5EPwcS4z2q4+yxraKzZAgv2+mwXvOZE2/VV80YYKpZHzlrFP6Q6Xl7mxYSgJUTMktacomrfW1ElLdnFcFwWIfEc1rZJa+GQGrH+rCRF6irXN1cEjdKT0jd44j+McT2Ncp+vlPm0Cyw/Rp2kFyUstGksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxUqOQb9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba25fd27571so118935566b.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776329009; x=1776933809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uu1RbogMjn1UvtlxIpHTcIOE9rQqKJsfEs8vLHXRnk8=;
        b=HxUqOQb9hSR2kgprFbPoLPGmAQEVFu5rStOLOMWn9UNcEszo3B+jCDaGSEu3H6l/Hi
         5gMGmr8COlvkldH6y8uGsK6rbuiiPrrWARBa5zggr0mbHw/J83bCTCQEffNcMBGarOZf
         RLgm+Yd4xpkBWOnATieXV50QUPwjdmVqOdzINowmo9fP6ArTBVnp/Jkaj7EKFAZxwrka
         b4G1FEztgmuGjR0RsIQC0e0p9GCzat8KegLhHu1+CAXWsdDpT9xEYWMp74hkhMVW4wnk
         Hzg/3qKfjRd0Ry2yeebR0GsL52A2+nbup213cAWaophXM4wnBZ4C3Es7zh2kkDDGBX2e
         hGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329009; x=1776933809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu1RbogMjn1UvtlxIpHTcIOE9rQqKJsfEs8vLHXRnk8=;
        b=U8nl7l7KaxM3Pmj+ShgbDVZHIOsLnJGzFXm54UWVKWKBkUiNKrQEu5DTf+VynzPGhN
         UqoAvo3kCGG5Y9tf9DA+oHn85mh5Zhzl9K1mgGhNyAMzAVnwZT6qhpxk7tidhDXnkuGE
         dVAncVVFTBTTMkz82ICZEEOAAicxTzq2fB4KccvSxSRX9zq2/Fv21V3+OXHen6Isn1E/
         4s7+485t2W5cTCgxdW81bGiOyy0yft7tiEMn2yFwY8tyAl0MXkq01XHLptV3kuia54Ro
         ud+SreKWZZFWoamaG7BWiXUfWHdJy966l4eFSXvpvEu5PeFZLYSUHpemKcNYHNDMcJPU
         uNiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eIgvBLeSokbJfyGi3wE2G+Me1JCRuishkGYVWZjkdWnwe7D+2Dlbq3FIDzBYzalid/Nqo5jTWpojf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UZ0gsnxGwG5WPXQ1kgaR/zCi5zRo/OiqLcy2BrR6vZ4vf1lI
	AyXA+zHlSZ0T8mkdxigXXWh713LvJ4mkmZiKk6aQrl+XoU4dASSguqw3LsEjm/+vyw==
X-Gm-Gg: AeBDies1OU5eGprsaqu5MUALWzqKFSIbJbEI7hOYIPGZaPCNOagnw/9OHn7N4tCepb3
	YlB4ON7wbOOLCJ1Bb2bqc37rP05CLWzj2lJoeCbZjGvS+KJ5dMM4KVqQI7hDqiyENn1dcGxOMKD
	SgidbHrWNeqvmsbBaEzGXIp5j9QdRasbG8am3peLsHQhfYp0ch/w0D4ygmL8b3ArnVG/44a0vf4
	zL8Q0dS0INVcW4qyY9ZL5YB1iZmUAfx6DrKzs6hBdRSLdjkDo07mYnRXUzCiG4Zqk+WaUIZHKJ6
	g66zQapvUTdXbbo8SG8whg0Ww9qwsXn6qzoH95fj7Bin1ebrlbAv9snh4gC/sVyJmUCPExy+eBF
	KC6fTJIjx3ZuRIHm/2OUDICk49qIVfUhwcGVykzsLIQA8iusTS8dejuSHUgLKRM9TtzQYrt6hZm
	kp92QIaLhBwnEZHVl2J9bnlic2fQh5CYzSQtg/pQ944YR/ols30N0/+pAvt4g0tgGgrstBBi2Qz
	lN+1KQCu+/i
X-Received: by 2002:a17:907:ca2a:b0:b8f:e98b:4952 with SMTP id a640c23a62f3a-b9d729bd5a9mr1014295866b.41.1776329008744;
        Thu, 16 Apr 2026 01:43:28 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1773c351fsm140213566b.30.2026.04.16.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:43:28 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:43:24 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH v2 1/4] bpf: add firmware command validation hook
Message-ID: <aeChLBMdLW2AEHpR@google.com>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260331-fw-lsm-hook-v2-1-78504703df1f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331-fw-lsm-hook-v2-1-78504703df1f@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19385-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,ziepe.ca,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mattbobrowski@google.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF59640BBCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:56:33AM +0300, Leon Romanovsky wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Drivers communicate with device firmware either via register-based
> commands (writing parameters into device registers) or by passing
> a command buffer using shared-memory mechanisms.
> 
> The proposed fw_validate_cmd hook is intended for the command buffer
> mechanism, which is commonly used on modern, complex devices.
> 
> This hook allows inspecting firmware command buffers before they are
> sent to the device.
> The hook receives the command buffer, device, command class, and a
> class-specific id:
>   - class_id (enum fw_cmd_class) allows BPF programs to
>     differentiate between classes of firmware commands.
>     In this series, class_id distinguishes between commands from the
>     RDMA uverbs interface and from fwctl.
>   - id is a class-specific device identifier. For uverbs, id is the
>     RDMA driver identifier (enum rdma_driver_id). For fwctl, id is the
>     device type (enum fwctl_device_type).
> 
> The mailbox format varies across vendors and may even differ between
> firmware versions, so policy authors must be familiar with the
> specific device's mailbox format. BPF programs can be tailored to
> inspect the mailbox accordingly, making BPF the natural fit.
> Therefore, the hook is defined using the LSM_HOOK macro in bpf_lsm.c
> rather than in lsm_hook_defs.h, as it is a BPF-only hook.
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/bpf_lsm.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 11 +++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c33..7ad7e153f486c 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -12,6 +12,21 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/lsm_hooks.h>
>  
> +struct device;
> +
> +/**
> + * enum fw_cmd_class - Class of the firmware command passed to
> + * bpf_lsm_fw_validate_cmd.
> + * This allows BPF programs to distinguish between different command classes.
> + *
> + * @FW_CMD_CLASS_UVERBS: Command originated from the RDMA uverbs interface
> + * @FW_CMD_CLASS_FWCTL: Command originated from the fwctl interface
> + */
> +enum fw_cmd_class {
> +	FW_CMD_CLASS_UVERBS,
> +	FW_CMD_CLASS_FWCTL,
> +};
> +
>  #ifdef CONFIG_BPF_LSM
>  
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -53,6 +68,24 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
>  bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
>  
> +/**
> + * bpf_lsm_fw_validate_cmd() - Validate a firmware command
> + * @in: pointer to the firmware command input buffer
> + * @in_len: length of the firmware command input buffer
> + * @dev: device associated with the command
> + * @class_id: class of the firmware command
> + * @id: device identifier, specific to the command @class_id
> + *
> + * Check permissions before sending a firmware command generated by
> + * userspace to the device.
> + *
> + * Return: Returns 0 if permission is granted, or a negative errno
> + * value to deny the operation.
> + */
> +int bpf_lsm_fw_validate_cmd(const void *in, size_t in_len,
> +			    const struct device *dev,
> +			    enum fw_cmd_class class_id, u32 id);
> +
>  #else /* !CONFIG_BPF_LSM */
>  
>  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> @@ -104,6 +137,14 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
>  {
>  	return false;
>  }
> +
> +static inline int bpf_lsm_fw_validate_cmd(const void *in, size_t in_len,
> +					  const struct device *dev,
> +					  enum fw_cmd_class class_id, u32 id)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 0c4a0c8e6f703..fbdc056995fee 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -28,12 +28,23 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>  }
>  
>  #include <linux/lsm_hook_defs.h>
> +
> +/*
> + * fw_validate_cmd is not in lsm_hook_defs.h because it is a BPF-only
> + * hook — mailbox formats are device-specific, making BPF the natural
> + * fit for inspection.
> + */
> +LSM_HOOK(int, 0, fw_validate_cmd, const void *in, size_t in_len,
> +	 const struct device *dev, enum fw_cmd_class class_id, u32 id)
> +EXPORT_SYMBOL_GPL(bpf_lsm_fw_validate_cmd);
> +

If you decide to stick w/ this BPF LSM based workaround, you can drop
the reliance on LSM_HOOK() entirely here.

>  #undef LSM_HOOK
>  
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
>  BTF_SET_START(bpf_lsm_hooks)
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
> +BTF_ID(func, bpf_lsm_fw_validate_cmd)
>  BTF_SET_END(bpf_lsm_hooks)
>  
>  BTF_SET_START(bpf_lsm_disabled_hooks)
> 
> -- 
> 2.53.0
> 

