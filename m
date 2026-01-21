Return-Path: <linux-rdma+bounces-15788-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB40Aq8bcGkEVwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15788-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 01:19:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DDB4E717
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 01:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52F274A82FA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 00:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8E27B50C;
	Wed, 21 Jan 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOs9JzpE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D727A10F;
	Wed, 21 Jan 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954737; cv=none; b=rBlx0WNYcJq1qfXqztQRZVwLcnfwkFicMtquNlM3Ttha/ocBDMLADsThql2pRslOz12eCPr2eMeikWBQrUdzlJVZLD7rSxthknHhtitD/yH2Q6Qs3bYAAr1I2xWHcruMfIrRaLlWsDReim2bIps0taM50OSYUzSSERkCkgbKXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954737; c=relaxed/simple;
	bh=0HGVVeTAHwzSzLFOpdIyNRyTdHYdyUOMXgvp4PSevFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX27hmgCW/8elPlwGQVG5e4IVAVbOkfT0NMncAW9a9X8eRDFOc4O65eJmxFLcfTgfdOFDHfaOgL2Vp5kNeZiM7IzMSNx0JVyk8qBMoRrV39nsLtCgvsKCt+ZfdBXkDzkVYS4ymg7/PWspwtatovfyspLYPGqm+rfmXmnUUXG3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOs9JzpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0FBC19424;
	Wed, 21 Jan 2026 00:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768954737;
	bh=0HGVVeTAHwzSzLFOpdIyNRyTdHYdyUOMXgvp4PSevFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOs9JzpEXQU9eIhdVdrnpwlJd0Lx0KFCd8ly+f79aar8QjwM2HCTDp7T2RDQX6+ob
	 Ef9GBFn5ZqaGH2OJ6HKk2NRVk0s19bpGE0qROw8XqoLaHrl2MbUSfdXv34sVf+DUBb
	 iymuRI1xM9TuNJtGFlFnZ19X2vWr4c9tNa4QGmfzht+9hEMLeD0ymHhGU6jsqT13Mh
	 5vSV+8CWuQp5z++nE3yV/gFB8Xkafkx+HVPMcvclMjBddewvQqcLVsOIlQFdW1EKkz
	 xb2OLPuFdNV0gCfKRAW6XMmlONmiLocH+s3wChGXAFZTlkeKRDBO4kN2xoU7xIF4hH
	 Au9H717kdzrig==
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
Subject: Re: [net-next,v2,12/12] ice: dpll: Support E825-C SyncE and dynamic pin discovery
Date: Tue, 20 Jan 2026 16:18:54 -0800
Message-ID: <20260121001854.1905391-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116184610.147591-13-ivecera@redhat.com>
References: <20260116184610.147591-13-ivecera@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-15788-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: A0DDB4E717
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: dpll: Support E825-C SyncE and dynamic pin discovery

This patch adds DPLL support for the Intel E825-C Ethernet controller.
It implements dynamic pin discovery via firmware nodes, asynchronous
registration using a DPLL notifier chain, and hardware configuration
for CGU registers.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 4eca62688d83..9d82748810a3 100644

[ ... ]

> +static void ice_dpll_pin_notify_work(struct work_struct *work)
> +{
> +	struct ice_dpll_pin_work *w = container_of(work,
> +						   struct ice_dpll_pin_work,
> +						   work);
> +	struct ice_dpll_pin *pin, *parent = w->pin;
> +	struct ice_pf *pf = parent->pf;
> +	int ret;
> +
> +	switch (w->action) {
> +	case DPLL_PIN_CREATED:
> +		if (!IS_ERR_OR_NULL(parent->pin)) {
> +			/* We have already our pin registered */
> +			goto out;
> +		}
> +
> +		/* Grab reference on fwnode pin */
> +		parent->pin = fwnode_dpll_pin_find(parent->fwnode,
> +						   &parent->tracker);
> +		if (IS_ERR_OR_NULL(parent->pin)) {
> +			dev_err(ice_pf_to_dev(pf),
> +				"Cannot get fwnode pin reference\n");
> +			goto out;
> +		}
> +
> +		/* Register rclk pin */
> +		pin = &pf->dplls.rclk;
> +		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
> +					       &ice_dpll_rclk_ops, pin);

Can pin->pin (pf->dplls.rclk.pin) be NULL here? Looking at the init
order in ice_dpll_init_pins_e825():

    ret = ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
    ...
    ret = ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC, ...);

The fwnode pins are initialized first, which registers notifiers. If a
DPLL_PIN_CREATED notification fires before ice_dpll_init_rclk_pin()
completes, this work handler will run while pf->dplls.rclk.pin is still
NULL (the structure is zeroed by kcalloc). Passing NULL to
dpll_pin_on_pin_register() causes a NULL dereference in
dpll_xa_ref_pin_add() when it accesses pin->parent_refs.

> +		if (ret) {
> +			dev_err(ice_pf_to_dev(pf),
> +				"Failed to register pin: %pe\n", ERR_PTR(ret));
> +			dpll_pin_put(parent->pin, &parent->tracker);
> +			parent->pin = NULL;
> +			goto out;
> +		}
> +		break;

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 4c8d20f2d2c0..0eb8a9e29a52 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1341,6 +1341,35 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	if (pf->hw.reset_ongoing)
>  		return;
>
> +	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
> +		int pin, err;
> +
> +		mutex_lock(&pf->dplls.lock);

Should this check ICE_FLAG_DPLL before using pf->dplls.lock? Looking at
ice_dpll_init_e825(), if initialization fails the mutex is destroyed:

    err = ice_dpll_init_info_e825c(pf);
    if (err)
        goto err_exit;
    ...
    err_exit:
        mutex_destroy(&d->lock);

But ICE_FLAG_DPLL is only set on success. If DPLL init fails and a link
change event occurs, this code will use a destroyed mutex.

> +		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
> +			enum ice_synce_clk clk_pin;
> +			bool active;
> +			u8 port_num;
> +
> +			port_num = ptp_port->port_num;
> +			clk_pin = (enum ice_synce_clk)pin;
> +			err = ice_tspll_bypass_mux_active_e825c(hw,
> +								port_num,
> +								&active,
> +								clk_pin);
> +			if (WARN_ON_ONCE(err)) {
> +				mutex_unlock(&pf->dplls.lock);
> +				return;
> +			}
> +
> +			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
> +			if (active && WARN_ON_ONCE(err)) {
> +				mutex_unlock(&pf->dplls.lock);
> +				return;
> +			}
> +		}
> +		mutex_unlock(&pf->dplls.lock);
> +	}

