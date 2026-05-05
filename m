Return-Path: <linux-rdma+bounces-20010-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAiKIJ3W+WmDEgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20010-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 13:38:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB64CCC7B
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 13:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E46A330556CF
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8AE3246E8;
	Tue,  5 May 2026 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="SvqKre5n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96D3537C8
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980714; cv=none; b=is+6297G3Z5sD1YfV0c+xX6ucYrT74UBHPwfLnt4PlxXLLt5kKh4OKNTqvPGL6kRn4z4HNzbSBlsN7CGwbdNRkQAx/6gXlRNV1XhGDfB7OcDSbTSdaSEiEWsffwpqiF2Z3/7VhpUMO9+UkwEeP/Iy350sufmHBjyhwQ15Z8JxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980714; c=relaxed/simple;
	bh=5QmGK/sRe6CLN82FEAV+S1ZkmL/I+KPUOLTHRhQAkbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbCBhsX1eC5VcJ3b8W83UE2WSZGUaM2EF4EMvyXZ1yrHiJbRUdIJexoY6nURIH+ai3EZxDNwIUZcdE0N8lUQnwH1Lmj8xxr5z+Eu/t5TuUFxdljUIzIaQ7XtmNBQk6PBOBq8DPOzFdbm2af2tpMqcLMjnRRryKWgG6ZuzlQ5UpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=SvqKre5n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so66394455e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777980710; x=1778585510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QmGK/sRe6CLN82FEAV+S1ZkmL/I+KPUOLTHRhQAkbU=;
        b=SvqKre5nkPPIQAo74IbS+p5NJ8s4lfqqeQbU7UWCz2A9Pdg3va78F+BNhWjh1a3WeI
         paPdsiR23i8PtQam9vtpI2u7fWOZjyyOLyEUVso7ZEB7GSdWme1X+QZpbscCylCipY4C
         lM9nZWD03w5kC9GeKuE0ikmDOv+l7M5n+HxABxL7S4WHs3sgAmtZRF6Ej6eU2IymjI32
         GLMMhzZGbyy7HX/6flNx0hwX+9ew+HvQ6IS+rCUNUFarFI74CQDoQG2It2p9qzMIer6E
         yKA+yoZksL6OElZLnS4xNWgYltulFu7M1ngML9X9dJruWamNk8o8Tc46PA5ffVIfTY27
         na3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980710; x=1778585510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QmGK/sRe6CLN82FEAV+S1ZkmL/I+KPUOLTHRhQAkbU=;
        b=SgxJ+444aq5PIMLtlet3KKN4+AYgbSngt7+/ujr2+/uGIrGiYVcWCimPlczRBjszfV
         kcvLJj/d09XonEwV/2OLG81mJzHO3080RmRZQDmad4gmyNT/L6oJ8n0KBUwJqnT2EugW
         quK4bhPjspPDv58YMYnTLpEdaqy7jhCkKQLcOFYvTjrylFnc+vgg9WE1yTO1QwBeyQmp
         n0PazNLyFx3EYIrjlfUgfQ3Do7rDid2QizaAR4pKBjlD61T4OH9LL1Cz6XurbmMLifBn
         RKADsGq3+hXVGz7gKwzHIDM3G5D/WHr39BuJPTVDUnE4pE8LOVXiZeAjnNpGanLgH9Qi
         yaWA==
X-Forwarded-Encrypted: i=1; AFNElJ9Kgx5cCVSItNHRAidjC391tNju4TK8hkz+zZ0HWu9UdpfLF3DJtPexpTOQWIR+kdvIAG70mO8qkc+/@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbkYny4DKnGERxhs0HPUQywgEOC1juq7MUw9GZMAKvsAP13Yc
	93gHTIkLfr8mDcS6rsaRck0X1pEJ728NoPC46LTKo35zV7mfQYL0YghVirH8I3kvwzw=
X-Gm-Gg: AeBDietC0+TCDoTfZV4zBSFMTSePdNfac9/Qt4b4hYZE8SI4z3ZDdr1Ex0VueZaXD4L
	u++mNZh96hi30tCGvWiW886Z+8hJ13o/Kh1TYC/2SAtQ1WCpKJT4XDlKvIGh6nZZhYA0ISCm8KS
	wLR835Ixf6m5PqrTwku9lWfuxwBWXt/475+BfwU+ohNbUq3vgk2aC8Lh8pdODT5WsYnOes7srmh
	1pnaGGWyiWhsjUxqEYvoMiaSucx4L77QJFVtqASHYkw7y4OhsdTxHSZAW1xjf7DeyyJvUV88duC
	aQ2fc7PjNfTP/VZwp4jSfdLadfZJuunH3vO387A4wVoKML7PQCEhyD4IbTeLRzhPMHOWry4X86K
	hiq8YRU9QIcOilPovtVhrj+N6B0cOb9Cu0NnUFNBMCVn6sQIp5u9To22oNfwleZiBU40zp8YzZ2
	iXHfM4WLw8I2To9kGgDAlHKPm+NW45/TD3H7TouZtoZe7QVA==
X-Received: by 2002:a05:600c:4445:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a986380ecmr220325785e9.11.1777980709810;
        Tue, 05 May 2026 04:31:49 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d184ed090sm14936015e9.33.2026.05.05.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:31:48 -0700 (PDT)
Date: Tue, 5 May 2026 13:31:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dpll: add fractional frequency offset to
 pin-parent-device
Message-ID: <afnVGPD5sjpSXz--@FV6GYCPJ69>
References: <20260504155340.411063-1-ivecera@redhat.com>
 <20260504155340.411063-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504155340.411063-2-ivecera@redhat.com>
X-Rspamd-Queue-Id: F0EB64CCC7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20010-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]

Mon, May 04, 2026 at 05:53:39PM +0200, ivecera@redhat.com wrote:
>Add both fractional-frequency-offset (PPM) and
>fractional-frequency-offset-ppt (PPT) attributes to the
>pin-parent-device nested attribute set, alongside the existing
>top-level pin attributes. Both carry the same measurement at
>different precisions.
>
>Distinguish the two contexts in the ffo_get callback by passing
>dpll=NULL for the top-level call and a valid dpll pointer for the
>nested per-parent call. This allows drivers to report a different
>value per parent DPLL if needed. Update mlx5 and zl3073x drivers
>to return -ENODATA for the context they do not yet support.
>
>Add documentation for both FFO attributes to dpll.rst.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

