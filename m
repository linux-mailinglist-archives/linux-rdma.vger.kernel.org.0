Return-Path: <linux-rdma+bounces-11254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DFAD6BFC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DE63A1A47
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30822A4E1;
	Thu, 12 Jun 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2DHi0Nk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F221C178;
	Thu, 12 Jun 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719835; cv=none; b=kSPdHYIxksxWK8Sa4Udc66K2DZPYCcQ5UDg9jYKlXazpaGUctiQUDOlA/94LIUl83XPWYlrmHCgFF1bmANBXHY2kQzOeUNOm3tspk2FwfuF1r/JdXA+alr6fHQEG6Ajf03goCbZOVE30BoR4UcTrfRoPBpqS8uiN1P0eakshyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719835; c=relaxed/simple;
	bh=UnwHqlz0qekwpAAwZl5nqulYLQ3x/RFf6gNcTXXt8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT6xHXo9ukvbjUh+c4mWh0FXS6n3/mF7OaRb7n3dYdYB3wQT5XLvxTuld3lzBRI40ryogVWeZNwr1Yl1WjgpuOM6Hdk/j2SwAXZF8Ysa604AqEjGOZflfSU3m1I177RkiJ5IENrcCNhyqP4kbWsSiLgT3y+85rhTZbIWyACPPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2DHi0Nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C89C4CEEA;
	Thu, 12 Jun 2025 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749719835;
	bh=UnwHqlz0qekwpAAwZl5nqulYLQ3x/RFf6gNcTXXt8jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2DHi0NknaYzw8iu2oOpPza+h6z72LcxfZE+HZaKRZaCGBxU03sYAqSpnxifksu7X
	 xQh/5h/tWxkX/hIZLnoNN+MMRF2zBVZc/HCS41aKT9IU3kjafQGd0ZaeeOtEQiIEGP
	 M2UrS+kj6WQ5ZeDK78M/jI4HTgSvmk+vZPcgjsjMbBCFTwrNNAnmWHsZUvB6gYJ6Cr
	 /o9GgH7RmC8etvc7ehnys5LZ3tLh5dmA8pDdvbBOWL/GQkuoc9/I3VklZxktBw0qCJ
	 vjQK8JZgCTKOoamuwkq3gTtP0nAyT9W2N9P6UhjWSts/o1Yx5AY0kigLKwcMi+8eHk
	 yBzwvBqYLRtZQ==
Date: Thu, 12 Jun 2025 12:17:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF
 note
Message-ID: <20250612091705.GU10669@unreal>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <20250610191144.422161-2-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610191144.422161-2-konrad.wilk@oracle.com>

On Tue, Jun 10, 2025 at 12:27:25PM -0400, Konrad Rzeszutek Wilk wrote:
> We would like to have a programatic way for applications
> to query which of the features defined in include/uapi/linux/rds.h
> are actually implemented by the kernel.

If you are interested in programmatic way, the IOCTL/netlink/syscall/...
are the right approach for it and not sysfs files.

Why don't you follow standard way of doing it by creating new query IOCTL
command? Which will return declared feature bitmask, which application can
parse and understand?

Thanks

