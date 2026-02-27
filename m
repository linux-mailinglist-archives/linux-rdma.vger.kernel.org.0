Return-Path: <linux-rdma+bounces-17272-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNhzCa3xoGm0oAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17272-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:21:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1091B17A6
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB18305D1CE
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3E255E34;
	Fri, 27 Feb 2026 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExaP9WvM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48121018A;
	Fri, 27 Feb 2026 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155291; cv=none; b=G6NmMuSisBdsABBPIfQDRUc1lf5jLaxkeaoD5eP7S6Duj5nVEmim8/mg6rjKnwZE+snfA7vwhWGACXhUCcHHuqwhsA8xHNSIf5VUMa1YzRbGeo7E73RgUb85x2mGVqKWwh80aVlbmXKX74S8aIyGa0N86AQXIaXY5rHHvngwAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155291; c=relaxed/simple;
	bh=hVNt9LgAqng5Pf1EozdibGgGKwY/NRGv3Gr32gqyiws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr8fFzkJTsRhUexvqBOBUclLFQLQH/7/VYTLm80FdcD5n4/1ZgLdN2BjcM99HKDVytkvK3Q4LkW7N6xxMcbER7NfRn1kCNAkcKYgAnjV8l5bC36L4E3M/C+hmEeYgvD9lZe7q6oJRIUsuLuntYHwyO10d6NXHphZrn7+8Zu/aig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExaP9WvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57571C116C6;
	Fri, 27 Feb 2026 01:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772155291;
	bh=hVNt9LgAqng5Pf1EozdibGgGKwY/NRGv3Gr32gqyiws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExaP9WvMoXOaE9Nv6OiKD8n5y7OzSH3X3l1B+lUo3+7AKuY6ZGfZDjwEvbTZfubZO
	 elyespivyRSUPr+CHjpa7jE3KU/norHKuZjEmBbb9lvHjyGv8IyQE9q7DkunUtn1DR
	 KOpRJdQYNlmUB3k1GmvAHuSmpTPYRVqlSS+wQwjTwRaN5sXrt09wNvuPFIX0oD04mf
	 oFOrZDk3qSGe7Bclj5rfewXzijbKCQjD2y9LnTt/99VUhknMi7D3YkjKuKzA3cRf/7
	 hLXJU/BFhlh/ZCKo/mFZFZjhdkePLI7dMxQJ73dkMhxCyCEJlxp8097oUftpqZTl2t
	 dziwOnwoSkWWw==
Date: Thu, 26 Feb 2026 18:21:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 2/2] RMDA MLX5: get tph for p2p access when registering
 dmabuf mr
Message-ID: <aaDxmGoqpjnvmVs9@kbusch-mbp>
References: <20260210194014.2147481-1-zhipingz@meta.com>
 <20260210194014.2147481-3-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210194014.2147481-3-zhipingz@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17272-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC1091B17A6
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:39:55AM -0800, Zhiping Zhang wrote:
> +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_index,
> +							  u8 *ph)
> +{
> +	int ret;
> +	struct dma_buf *dmabuf;
> +
> +	dmabuf = dma_buf_get(fd);
> +	if (IS_ERR(dmabuf))
> +		return;
> +
> +	if (!dif there's any implication mabuf->ops->get_tph)
> +		goto end_dbuf_put;
> +
> +	ret = dmabuf->ops->get_tph(dmabuf, st_index, ph);

You defined the "get_tph" function to take a pointer to a raw steering
tag value, but you're passing in the steering index to it's table.

But in general, since you're letting the user put whatever they want in
the vfio private area, should there be some validation that it's in the
valid range? I'm also not quite sure how user space comes to know what
steering tag to use, or what harm might happen if the wrong one is used.

