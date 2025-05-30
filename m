Return-Path: <linux-rdma+bounces-10910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1AAC85CC
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 02:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B453A249F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 00:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF560DCF;
	Fri, 30 May 2025 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5yTMsUX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F68AD5E;
	Fri, 30 May 2025 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748566589; cv=none; b=VMsPbteKLiaclB44YiADWoblI/tTxZ2/yC+Yg4glal7KCM8tjC3iNcHToZ3yCPG9mrOeqr9I5YBj3wfF8GwRUr7Xgedfyzj/FoPKLu2w8QHBBD3NJZd+htZcCOYEnFAm168K3pUqm8MU2mKM9y1zk+bPVNd8NmFJfAeaoWzm9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748566589; c=relaxed/simple;
	bh=yg6Wh8XDP53XOaEfOboKxLKTBHVS/nUo2gmPowtLxbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY9x/DbKqMFpWfvtpuXq8fsC0a6PvNmX1YlLQFvA3MIpQ1qZzfDSKcNOR0kSThWfvgex26A9wAmFr1CXFarHk23DaqlQ+TFRjj32OEM/L8hIw663pcWNVxqm9Xxi0rqMXQES/51qFu3GVy+OPl8aztxE3ZLaueholW7wa+ypCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5yTMsUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CDEC4CEE7;
	Fri, 30 May 2025 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748566589;
	bh=yg6Wh8XDP53XOaEfOboKxLKTBHVS/nUo2gmPowtLxbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5yTMsUXYJkXKA/3AcLLVZtYKMkrbG7yBjq6Hz2CnCLmzDpTU+WuwJY/phWaP7LWK
	 DH4sGRZP5sNjiuZI2lbzQ42iNVCv7M0Lqom0Yvd9yfFjLlLPun+tW5laqn3p8EPiO6
	 VhGLVjm8KUzTfHtQPYo9eDBQnBW6wmwRx5MTcO3HPFAmIWG/wBR2Tn7rVV4fgCHfUF
	 buiRCeXTUvQPm9FWsgGuzQBy2kAfzGJAMk+NYCX5cWZivNmpmV7UDFhsAFL+3BQwo6
	 gsjjyQFKCMLAJ0P8cRIkGgi58XLvnhBBxXbrTn0iq0kNZELtg4Aj+XGs1NTiEORLZN
	 Cx4g/jqxeB+WA==
Date: Thu, 29 May 2025 17:56:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v4 2/3] dpll: add reference sync get/set
Message-ID: <20250529175627.4e6a3b07@kernel.org>
In-Reply-To: <20250523172650.1517164-3-arkadiusz.kubalewski@intel.com>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
	<20250523172650.1517164-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 May 2025 19:26:49 +0200 Arkadiusz Kubalewski wrote:
> +static int
> +dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
> +			    unsigned long ref_sync_pin_idx,
> +			    const enum dpll_pin_state state,
> +			    struct netlink_ext_ack *extack)
> +
> +{
> +	struct dpll_pin_ref *ref, *failed;
> +	const struct dpll_pin_ops *ops;
> +	enum dpll_pin_state old_state;
> +	struct dpll_pin *ref_sync_pin;
> +	struct dpll_device *dpll;
> +	unsigned long i;
> +	int ret;
> +
> +	ref_sync_pin =3D xa_find(&pin->ref_sync_pins, &ref_sync_pin_idx,
> +			       ULONG_MAX, XA_PRESENT);
> +	if (!ref_sync_pin) {
> +		NL_SET_ERR_MSG(extack, "reference sync pin not found");
> +		return -EINVAL;
> +	}
> +	if (!dpll_pin_available(ref_sync_pin)) {
> +		NL_SET_ERR_MSG(extack, "reference sync pin not available");
> +		return -EINVAL;
> +	}
> +	ref =3D dpll_xa_ref_dpll_first(&pin->dpll_refs);
> +	ASSERT_NOT_NULL(ref);

why the assert? The next line will crash very.. "informatively"
if ref is NULL =F0=9F=A4=B7=EF=B8=8F

> +static int
> +dpll_pin_ref_sync_set(struct dpll_pin *pin, struct nlattr *nest,
> +		      struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
> +	enum dpll_pin_state state;
> +	u32 sync_pin_id;
> +
> +	nla_parse_nested(tb, DPLL_A_PIN_MAX, nest,
> +			 dpll_reference_sync_nl_policy, extack);
> +	if (!tb[DPLL_A_PIN_ID]) {

NL_REQ_ATTR_CHECK(), please

	if (NL_REQ_ATTR_CHECK(extack, nest, tb, DPLL_A_PIN_ID) ||
	    NL_REQ_ATTR_CHECK(extack, nest, tb, DPLL_A_PIN_STATE))
		return -EINVAL;

it will set ATTR_MISS metadata for you. Not 100% sure if Python YNL
can decode miss attrs in nests but that's a SMOP :) C YNL can do it.

> +		NL_SET_ERR_MSG(extack, "sync pin id expected");
> +		return -EINVAL;
> +	}
> +	sync_pin_id =3D nla_get_u32(tb[DPLL_A_PIN_ID]);
> +
> +	if (!tb[DPLL_A_PIN_STATE]) {
> +		NL_SET_ERR_MSG(extack, "sync pin state expected");
> +		return -EINVAL;
> +	}
> +	state =3D nla_get_u32(tb[DPLL_A_PIN_STATE]);
> +
> +	return dpll_pin_ref_sync_state_set(pin, sync_pin_id, state, extack);
> +}

