Return-Path: <linux-rdma+bounces-16468-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDN0Nn4fgmlIPgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16468-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:17:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD02DBC65
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C4A3120470
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D543D1CAD;
	Tue,  3 Feb 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmGSAn8b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F73D1CA2;
	Tue,  3 Feb 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135101; cv=none; b=PSVYjw4JdnmwQaV6EqTHISEp9+UIZ/03ukkL0jBjwfAiKDi0KqCnOtEpW7HxRT1jlB05WxLmcQTyJQt/p6aezPFVer1heTq1+8NS8TTry2mesGDMd5TnkPYDBwo10DR+41swwHmhKQflaCDFBMRm7PMU6KWGCBGMp+yJRbMXS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135101; c=relaxed/simple;
	bh=8AFrNtNyxouFp5sBXSOwVYkSaZGYEOX6ETwIRjArO5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPeKx7Qlovzj918J+O/hAQW9qAvWe7OtnivOSHa0p/ID84k5nFQn+u3h+iF9bNdAWrHcGSWDYToNAorAKFJHEx9Xk0pl5FdMHnXpmnUVBp8YARyQLR8jkHGSLwS/tsFPIXb2DdBkC5sSdK14Sati7MW6flwX51DyvPk1fNyvlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmGSAn8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E6FC116D0;
	Tue,  3 Feb 2026 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135101;
	bh=8AFrNtNyxouFp5sBXSOwVYkSaZGYEOX6ETwIRjArO5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmGSAn8bXBxp2dUl7h9K+p4mf6wV+mAZZ+woQdoM0nkc8Eiv3qrfCC6BDYHdtSGn/
	 mpahJma3SVnJBszur6Qt1XrbnyuvPhyR2fWTmLXWSNth4RAPZjmK05c5FTy7IhM7Yj
	 zBiMf5a9tDPrBhTCMnljx2xufa+UA2sOPRs9OgV3SPCQxeQPTxXbrG4QWXRmC9pefM
	 tFC32AY2jiEERUVHjSkkcmbxXs2n2Yma8jFtrizDTH/GiUfsfmSVsVdRaSFE2Rru5V
	 +ASQJRIJBh5sIGXQzAKDyKh8b++zTjOouiny8xq9B5IwlBx4UheYDycQP9iqcqZ/Mz
	 rWev/pJs7rVyA==
From: Simon Horman <horms@kernel.org>
To: ivecera@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	richardcochran@gmail.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	kuba@kernel.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org,
	grzegorz.nitka@intel.com,
	poros@redhat.com,
	davem@davemloft.net,
	vadim.fedorenko@linux.dev,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aleksander.lobakin@intel.com,
	jonathan.lemon@gmail.com,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Prathosh.Satish@microchip.com,
	leon@kernel.org,
	edumazet@google.com,
	mbloch@nvidia.com
Subject: Re: [net-next,v4,9/9] ice: dpll: Support E825-C SyncE and dynamic pin discovery
Date: Tue,  3 Feb 2026 16:11:20 +0000
Message-ID: <20260203161120.1894163-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202171638.17427-10-ivecera@redhat.com>
References: <20260202171638.17427-10-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,lunn.ch,redhat.com,nvidia.com,vger.kernel.org,davemloft.net,linux.dev,resnulli.us,lists.osuosl.org,microchip.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-16468-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CD02DBC65
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: dpll: Support E825-C SyncE and dynamic pin discovery

This patch implements SyncE support for the E825-C Ethernet controller
using the DPLL subsystem, with dynamic pin discovery via firmware (ACPI)
and asynchronous registration using the DPLL notifier chain.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 4eca62688d83..a8c99e49bfae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -528,6 +529,92 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>  	return ret;
>  }
>
> +/**
> + * ice_dpll_rclk_update - updates the state of rclk pin on a device
> + * @pf: private board struct
> + * @pin: pointer to a pin
> + * @port_num: port number
> + *
> + * Update struct holding pin states info, states are separate for each parent
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int ice_dpll_rclk_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
> +				u8 port_num)
> +{
> +	int ret;
> +
> +	for (u8 parent = 0; parent < pf->dplls.rclk.num_parents; parent++) {
> +		ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &parent, &port_num,
> +						 &pin->flags[parent], NULL);

Is it safe to pass &parent as an output parameter when it's also the loop
counter? Looking at ice_aq_get_phy_rec_clk_out():

    int ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, ...)
    {
        cmd->phy_output = *phy_output;  // Read as input
        status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
        if (!status) {
            *phy_output = cmd->phy_output;  // Write back from firmware
        ...

The firmware could potentially return a different value than was sent,
which would be written back to 'parent', corrupting the loop counter.

This corrupted value is then used as an array index:

> +		if (ret)
> +			return ret;
> +
> +		ice_dpll_pin_store_state(pin, parent,
> +					 ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
> +					 pin->flags[parent]);

Both pin->flags[parent] and pin->state[parent] (inside
ice_dpll_pin_store_state) could access out of bounds if firmware returns
a value >= ICE_DPLL_RCLK_NUM_MAX (which is 2).

Would it be safer to use a separate variable for the phy_output parameter
and validate that firmware echoes back the expected value?

> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -3239,8 +3683,8 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
>   * @d: pointer to ice_dpll
>   * @cgu: if cgu is present and controlled by this NIC
>   *
> - * If cgu is owned unregister the dpll from dpll subsystem.
> - * Release resources of dpll device from dpll subsystem.
> + * If cgu is owned, unregister the DPL from DPLL subsystem.
> + * Release resources of DPLL device from DPLL subsystem.
>   */

This isn't a bug, but there's a typo: 'DPL' should be 'DPLL'.

