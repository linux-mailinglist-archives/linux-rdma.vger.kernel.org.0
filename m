Return-Path: <linux-rdma+bounces-19964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOZsGIMf+Wlw5wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:36:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044DB4C471F
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75425302171E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1C386561;
	Mon,  4 May 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUaCOBo3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE03386567
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934149; cv=none; b=OWsfbvuJXsKYAsYGlKEsVYml8wVjAbIaqEdi5hrI7KlGK7yUi70y9S+jLe56xK4xLeYyjdOtHFr7C+NRC+PocK63KBG9tcmFUpJyE8uz7ryOfZ4Te9IwTmjqmieByNTvj15Gb+itd0oyFMYnyhXZfOM/8PpHP82Va+Cv4fZPBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934149; c=relaxed/simple;
	bh=053J+k+T3qlqygZGjMWRpvpwj73ZalGKJrYZu+NUK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sML2dvSe/iH+ttopar0mXHDYWk9jDKR3KtBi+KjhUPIRSEZ+zJB6146i/tza8VwmfiCCl3506I6+Z61bo9YJ1GQsOei/pDeeeC4FDC4FuMs5EwXHUzm6YLcpbGiFGBrsyoy+41y114ssJrhn6Mt/ejNczLLumNXTXnLBJ39mBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUaCOBo3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7973f67f4dso1489258a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934148; x=1778538948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQ3tNPMFkM7QrJ5Q+mR4uTB1pqSv2OnkcWUNEBkdVs8=;
        b=gUaCOBo32sIC5Xy0u8Jwox7KkqYuM8Saf4HXhvj8cCNhQ+enMJ21rEWaazHjDmEZ3V
         rYf1PMP3l2KagKvbEAZiwtu6yEuP2yV/SxjwwR9xrj4WaJJTbFdIHu/yGIqxqQAYroME
         tUpLIwWCUvHMxDVEVOp6rIcwn69yvS9tV+VxUNDPGecbAVyZdaYtpgF1LhlSeWsCZZjR
         dSG+IQBVZq8z3k4tfWnUXiMaAqI95VnC+0fNbrQoIf0MVs7m2gdC+cdCBfyQo9W4Vxx4
         pn2zSV/9uT6qAj1vLTXCgkRtZ46kMUCFSlaLpTt8b3zLYmx1McVBZhrng5QrMVFuUo8V
         hsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934148; x=1778538948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ3tNPMFkM7QrJ5Q+mR4uTB1pqSv2OnkcWUNEBkdVs8=;
        b=ZZfk3aZLpD8q5FxdGYX18xJQFYBKe91v1WPCPBL4M+Rg0jKE/t248wC53Kp3Nmam3t
         iwZYuOwz1QKZWs5LDvpkdb0wsWOoG88nTqyiuMAIfhH47xhxxLWQip1W2+L05Do+SM5B
         0J3QdG8CoaYsasW//ZQiEz0PSvm1w7jJTIhTAbgdYr/qQruOVzD1eQ/kkpHPUJKYBE4k
         AoxOFat91Fi6e03tk2+xAlWEW6nnQOsTHHTgqd1/tU/SJ3iLtsEZTbwkrHECnboni92j
         RSTLViSzuOFvUI0y2bmBN61HMIExModTTCceYFok7H9K64cQUxbcU0e9ehVDbPf26fWq
         //Kw==
X-Forwarded-Encrypted: i=1; AFNElJ9ErZwuVz5Achp89z8lxLUang/FMQrn0+4FR9k6XMcYtzgS4d+UuBM3qnGx3lsP+nyKOrKSzSst6YCT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb36X3EJiOLZkqQJ9UcO7/cLj5e95+1k0i4E0uWbl6AgiGyOQW
	naQ4v3uNKGnpTrfa6ZugzEr8urnN1Fexpv5TLK0NjbVkgc7iyBycMuX0+P1t/NDyiA==
X-Gm-Gg: AeBDiesy/ukITnN89ZIaLJcDQPcpunTxbe7JY8T45ZFM1SMrpwS/SdJ2heYyqfvR+7G
	M1KJBCmtH6uVTbcyrSnkzLhoABefbifQq/R8ou+azP9LSPOAbEQnJjYLkE9Cb5M3rNBXZUzqxai
	wzIKtK287Dnz3YbZZ9oDudZaYCPbjP9p3XxX4oy3FGJdfBTUko+oXskOFSZPckdaHOFsOak66QF
	cQ+4OnOQ8qEgrM3wiKCMxWf2CUW2xT1MSpGunKRu/M1xeq8NP0dZ/WD5VdgW7AOb4fMnKEg55Ma
	tti87mLHVzAlHC8mZU3jRgYMDhdOTw60CelQ2NF0R+YFYVdKuZ184u6WSpM96aHy4pgsEGLUFGw
	Ioj1ByA0giBVuNKaXOMyuSAYuF0/SfYW7fWCNOtAGu44OwQ9AQhGWiN2EsPGjW1A7omydyNVtK2
	vQCVydQ9AdDdHDBcqBm+a9/QmkQKeiToESQgOgS6tA6FtyeI4rIWP5pIF3eA3o28yM/B/VF+jqJ
	nMTHw==
X-Received: by 2002:a05:6300:210d:b0:3a2:cbd1:11f with SMTP id adf61e73a8af0-3a9ea589e46mr1260508637.5.1777934147330;
        Mon, 04 May 2026 15:35:47 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbcaa477sm10680045a12.31.2026.05.04.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:35:46 -0700 (PDT)
Date: Mon, 4 May 2026 22:35:43 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <afkfP-8UHaoyLd5Y@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: 044DB4C471F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19964-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:

> +/*
> + * Driver state — overlaid on device->driver.region.vaddr.
> + *
> + * Contains both software-only state and HW-visible DMA buffers. HW buffers need
> + * strict IOVA alignment.
> + */
> +struct mlx5st_device {

Can we do s/mlx5st/mlx5/ on the series?

I assume st is for selftests and that is already implied by this file
being under tools/testing/selftests.

> +/*
> + * Probe — match mlx5 devices by PCI vendor/device ID.
> + */
> +
> +#define PCI_VENDOR_ID_MELLANOX 0x15b3

nit: Use #include <linux/pci_ids.h>

> +static int mlx5st_probe(struct vfio_pci_device *device)
> +{
> +	static const u16 mlx5st_pci_ids[] = {
> +		0x1011, /* Connect-IB */
> +		0x1012, /* Connect-IB VF */
> +		0x1013, /* ConnectX-4 */
> +		0x1014, /* ConnectX-4 VF */
> +		0x1015, /* ConnectX-4LX */
> +		0x1016, /* ConnectX-4LX VF */
> +		0x1017, /* ConnectX-5 */
> +		0x1018, /* ConnectX-5 VF */
> +		0x1019, /* ConnectX-5 Ex */
> +		0x101a, /* ConnectX-5 Ex VF */
> +		0x101b, /* ConnectX-6 */
> +		0x101c, /* ConnectX-6 VF */
> +		0x101d, /* ConnectX-6 Dx */
> +		0x101e, /* ConnectX-6 Dx VF */
> +		0x101f, /* ConnectX-6 LX */
> +		0x1021, /* ConnectX-7 */
> +		0x1023, /* ConnectX-8 */
> +		0x1025, /* ConnectX-9 */
> +		0x1027, /* ConnectX-10 */
> +		0x2101, /* ConnectX-10 NVLink-C2C */
> +		0xa2d2, /* BlueField integrated ConnectX-5 */
> +		0xa2d3, /* BlueField integrated ConnectX-5 VF */
> +		0xa2d6, /* BlueField-2 integrated ConnectX-6 Dx */
> +		0xa2dc, /* BlueField-3 integrated ConnectX-7 */
> +		0xa2df, /* BlueField-4 integrated ConnectX-8 */
> +	};
> +	unsigned int i;
> +	u16 did;
> +
> +	if (vfio_pci_config_readw(device, PCI_VENDOR_ID) !=
> +	    PCI_VENDOR_ID_MELLANOX)
> +		return -ENODEV;
> +
> +	did = vfio_pci_config_readw(device, PCI_DEVICE_ID);
> +	for (i = 0; i < ARRAY_SIZE(mlx5st_pci_ids); i++) {
> +		if (mlx5st_pci_ids[i] == did)
> +			return 0;
> +	}
> +
> +	return -ENODEV;
> +}

