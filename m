Return-Path: <linux-rdma+bounces-13410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC4B5964B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 14:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290EE2A23B0
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106552DBF78;
	Tue, 16 Sep 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy5uNtuC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD5469D;
	Tue, 16 Sep 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026056; cv=none; b=DyuGsGUqr6r8AN8CovGZt/g8RpMxQjj4Wcma/tOSUvpWdcAVDwAR5E1B7au953vYXSE5vVlxeyyMsoMC14dEh/MgWERpjtpmJWezl36w0A/PlA3JtyeGKby70t65tZHsvA6wmZnRq1z7iXMF2UD2P4yhdT4Rbb2+CiPKPd+jYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026056; c=relaxed/simple;
	bh=LkVC7SOF1ecwe4fjNrM/LffIi1MGAwKsiw8rXf3dpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6lmdR5OyvSUklmMfVQlW0N67Rg+FY5l9fJat8HWii3cibnH1OiANg4M6pNfxCswHbql2ybcKgSXKcB0sFBd4yyoJ+jE5GqZ/sV6Oi8x9c0ul7SIwmeT7rjMK0+vYjoyTbp3/eoIoK2RaNYesZO+BtVWqDAsMtFaKtH4IUNSGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy5uNtuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C676C4CEEB;
	Tue, 16 Sep 2025 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026056;
	bh=LkVC7SOF1ecwe4fjNrM/LffIi1MGAwKsiw8rXf3dpnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oy5uNtuC+vXnJWcFRK31VNoVAveH3bBQqFLGlZsn4wVJB3dIS+bFCbsy/KNe9ZIMZ
	 3/T3Bm0GxEfOIDcEw7mrFMHX/3bwtUTDu24absed3pPYLdbxc75x8or2pE1/JP8lV4
	 wcLfXs7KtzZqrXlnv9FG+R520jSiAvb6THg18xRowowv1JZDjSz6a1Qo+RjUllfcih
	 XYL7cNYk8hulxYCQyotssPBQVhaQ0cy0XJGOT8utWeRFchTwlpnOkjJjSxOuYQwuDB
	 KfSEvWcR9iVzdA97BulN0pJYVM24pXsb7cACng0CKolegK3DAeFp6qZ/bt/bNJEuhJ
	 lFJhbt65yu32Q==
Date: Tue, 16 Sep 2025 13:34:12 +0100
From: Simon Horman <horms@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com, anand.subramanian@broadcom.com,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: Re: [PATCH 2/8] RDMA/bng_re: Add Auxiliary interface
Message-ID: <20250916123412.GZ224143@horms.kernel.org>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-3-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829123042.44459-3-siva.kallam@broadcom.com>

On Fri, Aug 29, 2025 at 12:30:36PM +0000, Siva Reddy Kallam wrote:
> Add basic Auxiliary interface to the driver which supports
> the BCM5770X NIC family.
> 
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>

...

> diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c

...

> +static int bng_re_add_device(struct auxiliary_device *adev)
> +{
> +	struct bnge_auxr_priv *auxr_priv =
> +		container_of(adev, struct bnge_auxr_priv, aux_dev);
> +	struct bng_re_en_dev_info *dev_info;
> +	struct bng_re_dev *rdev;
> +	int rc;
> +
> +	dev_info = auxiliary_get_drvdata(adev);
> +
> +	rdev = bng_re_dev_add(adev, auxr_priv->auxr_dev);
> +	if (!rdev || !rdev_to_dev(rdev)) {

Hi Siva,

Sorry if somehow this is a duplicate, it got stuck in my outbox somehow.

GCC 15.1.0 says:

  .../bng_dev.c: In function 'bng_re_add_device':
  .../bng_dev.c:54:22: warning: the comparison will always evaluate as 'true' for the address of 'dev' will never be NULL [-Waddress]
     54 |         if (!rdev || !rdev_to_dev(rdev)) {
        |                      ^
  In file included from drivers/infiniband/hw/bng_re/bng_dev.c:8:
  ./include/rdma/ib_verbs.h:2812:41: note: 'dev' declared here
   2812 |                 struct device           dev;
        |

> +		rc = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_info->rdev = rdev;
> +
> +	return 0;
> +exit:
> +	return rc;
> +}

...

