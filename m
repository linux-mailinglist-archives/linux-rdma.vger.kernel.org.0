Return-Path: <linux-rdma+bounces-15787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH3RDYMbcGkEVwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 01:19:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12A4E701
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 01:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 868BF78E182
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA1D255248;
	Wed, 21 Jan 2026 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvXaxdYG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55E20DE3;
	Wed, 21 Jan 2026 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954735; cv=none; b=LDuuddYKHm4r+PgORBOI0bg9BujX9eHNcNfcXLxY/I1TtAej0JHwcW91ubgdw5ksdKSc7Zo0rkq4K0XzNiuueZfE+tRauKjakeQY7Zv2whlaedbb65vEmxyNmGsO+439wNFnNVkjODNMHE1RzMgjV0I2AiXvpIJkbBpmfBmNBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954735; c=relaxed/simple;
	bh=nIteDBTn2kAmgBvtRuDy38cJr4xlonSC8wjke3vr638=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhV/ijtdh3DcFDeP5PX/XsbIasyyxJegR4Lrzgeol3ZlvjFxyEz5x70igI5oVycPx64Qap8JJKabOOxFjW4I0PRx+n404nxyovnC60VCYG+nvzgjDTswHKANiRYa0yqC5cjeylnja3KpJUk8UVu2oHvb2b8/OQmeVv7b3jE+jLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvXaxdYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ABAC16AAE;
	Wed, 21 Jan 2026 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768954734;
	bh=nIteDBTn2kAmgBvtRuDy38cJr4xlonSC8wjke3vr638=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvXaxdYGqxzhDl4dlVgxDbHwn2ArnJYr1SHXf4bO+g9xDUPPXzUwTzGch79P8hiAm
	 vJRWW0Q27ZnkuqCa8D0+e4oC6WIvAlaGbHoWoqeY6ecYlNW+bT3LYKjcxlH9EgbNo7
	 MKA/0HmG2iU3dVeBqcbYUlqHCvlVue37XUicvgeU5587Q9sFqomwXcYPx1hthyeqOd
	 kfMfFTl/8qonrKdrVPRydWSMVMJrcnyypokRo0BHIKoUjnHMxK7xtLkGtKrU6GdU1i
	 ttYt2SvGkYb6SjMlZZb78IfxzoHK1QNbGO61ACekjv0iTQNgHhN+EifBPEuvYD+Y5I
	 PnvLP5a3+70Ew==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	conor+dt@kernel.org,
	poros@redhat.com,
	anthony.l.nguyen@intel.com,
	linux-rdma@vger.kernel.org,
	tariqt@nvidia.com,
	robh@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aleksander.lobakin@intel.com,
	mbloch@nvidia.com,
	jiri@resnulli.us,
	Prathosh.Satish@microchip.com,
	krzk+dt@kernel.org,
	saeedm@nvidia.com,
	devicetree@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com,
	saravanak@kernel.org,
	aleksandr.loktionov@intel.com,
	mschmidt@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	vadim.fedorenko@linux.dev,
	grzegorz.nitka@intel.com,
	intel-wired-lan@lists.osuosl.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,08/12] dpll: Enhance and consolidate reference counting logic
Date: Tue, 20 Jan 2026 16:16:51 -0800
Message-ID: <20260121001650.1904392-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116184610.147591-9-ivecera@redhat.com>
References: <20260116184610.147591-9-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,intel.com,vger.kernel.org,nvidia.com,resnulli.us,microchip.com,davemloft.net,gmail.com,google.com,linux.dev,lists.osuosl.org,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15787-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9D12A4E701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch.

Dunno if there's a reason for having this fixed by a later patch,
if not let's fix. I'm sending the review mostly because of the
comments on patch 12.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dpll: Enhance and consolidate reference counting logic

This commit refactors DPLL reference counting by introducing centralized
__dpll_{device,pin}_{hold,put}() helpers and updating dpll_xa_ref_*
functions to automatically manage references when adding/removing entries.

> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 156f95de8e8e..f2a77eb1b991 100644

[ ... ]

> @@ -155,6 +194,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
>  	reg->ops = ops;
>  	reg->priv = priv;
>  	reg->cookie = cookie;
> +	__dpll_pin_hold(pin);
>  	if (ref_exists)
>  		refcount_inc(&ref->refcount);
>  	list_add_tail(&reg->list, &ref->registration_list);

The new __dpll_pin_hold(pin) call is added here for the success path, but
looking at the context above this hunk, there is an early return path when
a duplicate registration is found:

    reg = dpll_pin_registration_find(ref, ops, priv, cookie);
    if (reg) {
        refcount_inc(&ref->refcount);
        return 0;
    }

This early return path increments ref->refcount and returns success, but
does not call __dpll_pin_hold(pin). Meanwhile, dpll_xa_ref_pin_del() always
calls __dpll_pin_put(pin). Could this cause a refcount underflow if a caller
attempts duplicate registration and then later unregistration is attempted?

Note: This appears to be addressed by 934c22045c2a ("dpll: Prevent duplicate
registrations") later in the series, which changes this early return to
return -EEXIST instead of success.

[ ... ]

> @@ -236,6 +277,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
>  	reg->ops = ops;
>  	reg->priv = priv;
>  	reg->cookie = cookie;
> +	__dpll_device_hold(dpll);
>  	if (ref_exists)
>  		refcount_inc(&ref->refcount);
>  	list_add_tail(&reg->list, &ref->registration_list);

The same pattern exists in dpll_xa_ref_dpll_add(): the early return path for
duplicate registrations increments ref->refcount without calling
__dpll_device_hold(dpll), while dpll_xa_ref_dpll_del() always calls
__dpll_device_put(dpll). The same fix in 934c22045c2a addresses this.
-- 
pw-bot: cr

