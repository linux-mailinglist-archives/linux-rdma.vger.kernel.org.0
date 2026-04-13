Return-Path: <linux-rdma+bounces-19275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMLlJ9eq3GlfVAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:35:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26D3E92F4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 524E6300869F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD73A6EEA;
	Mon, 13 Apr 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leYuFPxn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44B2264A9
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069321; cv=none; b=bHfF5TlGkPai03soBsGGlD40hDqwFJZDcb7YlbTLjURU9J3r5ndhfuJziM+0vLNyVM3OQ3hr+kJNtH9Gq6XS82cTPQbbuzIUx6MOMLS79iTx9PD2GqaNcWM8HEdK4h57xkPC70bxnbRYluchyWmY/pCDlE53xaaZ+aGCTyxZhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069321; c=relaxed/simple;
	bh=lM5cWrBh6iNwoVJRMpQl6SEsmsq6U2OeXqCYyDLCmOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwxXcWxTCtp/OSt37aFHbL8YgSoKn5saTCioLSgb6IYL9J0hMrTCkq/1ZjnqfGDJj6v/jpK8fmQSwXAUzKWhh5HXr3gheThoFUaWxQATcIkJT16k2i+Hi5d1AVvzJiHThN8MC4DQTWJwdR5dI9GwkFNRBUCAsl5Lr7qsR0nTe/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leYuFPxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F50C116C6;
	Mon, 13 Apr 2026 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069321;
	bh=lM5cWrBh6iNwoVJRMpQl6SEsmsq6U2OeXqCYyDLCmOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leYuFPxn4yDyweh9GuIOKxfrD65B+jfN9g1SU0IqNP+Nb6PkBUsXlqBn7RvmtEYE2
	 8ki2fUF/ZWx0WhPwgNT4goXYpOJB1MoCldI+xOuOdbPYCwJ5YFTUCEd9tGNRvY0nS0
	 LI5Zpu7v3ZCMytn2w355CUkEJ6dTFbj1HtxMfsyj0KhXwPbQDnHk06aDqr5CAOnXRn
	 AgeVUE3nBiUT95lxsQ8+d6llPbgU+4CGe90UvIg+W3LL3dGk3RGGA8lXY4DoPTWWU0
	 9PsxkZNXh7cgEUsOynCFVfF+gneYaGSun93X0i/9r7Y+o9IQ/FxozSv+ore0NWO2xe
	 8UZW9GMsXXE2Q==
Date: Mon, 13 Apr 2026 11:35:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add checksum support for admin
 responses
Message-ID: <20260413083515.GF21470@unreal>
References: <20260409074905.3126023-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409074905.3126023-1-ynachum@amazon.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19275-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC26D3E92F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 07:49:05AM +0000, Yonatan Nachum wrote:
> EFA devices added support for CRC16 checksum on admin responses and to
> expose it to the driver the API version increased to 0.2. Add a check
> for support on device init and if supported validate the checksum on
> each admin response the driver receives. If the checksum validation
> failed, drop the CQE.
> 
> Add the CRC16 module to Kconfig to have the in-tree dependency.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/Kconfig             |  3 +-
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  3 --
>  drivers/infiniband/hw/efa/efa_admin_defs.h    | 15 +++---
>  drivers/infiniband/hw/efa/efa_com.c           | 50 ++++++++++++++++---
>  drivers/infiniband/hw/efa/efa_com.h           |  4 +-
>  5 files changed, 55 insertions(+), 20 deletions(-)

<...>

> -#define EFA_ADMIN_API_VERSION_MAJOR          0
> -#define EFA_ADMIN_API_VERSION_MINOR          1

<...>

> +#define EFA_ADMIN_API_VERSION_MAJOR          0
> +#define EFA_ADMIN_API_VERSION_MINOR          2

<...>

> @@ -954,16 +990,16 @@ int efa_com_validate_version(struct efa_com_dev *edev)
>  		  EFA_GET(&ver, EFA_REGS_VERSION_MAJOR_VERSION),
>  		  EFA_GET(&ver, EFA_REGS_VERSION_MINOR_VERSION));
>  
> -	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION,
> -		EFA_ADMIN_API_VERSION_MAJOR);
> -	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION,
> -		EFA_ADMIN_API_VERSION_MINOR);
> +	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MAJOR);
> +	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MINOR);
>  	if (ver < min_ver) {
>  		ibdev_err(edev->efa_dev,
>  			  "EFA version is lower than the minimal version the driver supports\n");
>  		return -EOPNOTSUPP;
>  	}

This change breaks all backward compatibility. Are you certain that every EFA
device is running the correct firmware, including those currently deployed and
used by customers? If not, they will stop to work after random kernel update.

Thanks

