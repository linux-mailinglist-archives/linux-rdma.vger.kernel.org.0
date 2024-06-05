Return-Path: <linux-rdma+bounces-2905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C078FD1DE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EFA283C95
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F9261FE7;
	Wed,  5 Jun 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ5yTugN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457119D891;
	Wed,  5 Jun 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602087; cv=none; b=dit7B4pS07/ZC3VwF7upbAoFB3qVyo5V6xAjCAkGhZMJ7UFedsNThZLKO6A/iBkLLdrq7mhGZg9FAOTM+ruHM3PSJud8bzQJRX9c0fhx4A/bX0c0e2Uo6Pl7KrpiGD1+exA77BaIrWEjjBt1tW7hFMSmW2NbuHyMXUo/98NWgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602087; c=relaxed/simple;
	bh=xWIFlsgTXg55GQa/cajK0o7zrAKmzP8cpu3iJhL5kCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDEmEFr4KDAXtw4zwQoQyzGXQ+O/Wr6uXxQl6clJFZYA7TsRap8QYsKVTL+90lCex5IhQLYxj0A+jMIXTrlUGjZckJRyqlTF/s/lTXVYOlSq/TdJtlPegfTtNaF+Oqefht94xnx5VImxYFZjXUlN+aYFbYzlj8VGdnJ+yFPo140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ5yTugN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F9C2BD11;
	Wed,  5 Jun 2024 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717602086;
	bh=xWIFlsgTXg55GQa/cajK0o7zrAKmzP8cpu3iJhL5kCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZ5yTugNOJhxXdVpHMeQJNO04oLdgZDjcPFZhcYGmfbWFkb6cbjAuD5NCx2ytId/M
	 ope3I7BpydORxjgcE2zIpQgYzbIiQyEwcbvvyffDQSvBjGah6X1NPMKQnLDGMLXbmM
	 rSW8Unz9AT1mmRhuu5vZFrn7ZlGNDE1Kxgq2ntob28CLO3r9pPN2vw+A8EOMVPgd4Y
	 OQrnku6IRI8UHGiMFw206SBG5nfir6NELwgQHuJrjL22RujGPg2cB7PIJn9/IN++qg
	 Uk7/yEVntaZRovfdfMjc9iwM+zxRlOn9d66+GEqzrBNXQafwTQ5zXI5sCwhUKcXdis
	 QkbzVt+TqcgVQ==
Date: Wed, 5 Jun 2024 08:41:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, David Ahern <dsahern@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Dan Williams
 <dan.j.williams@intel.com>, Christoph Hellwig <hch@infradead.org>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240605084125.3ec93783@kernel.org>
In-Reply-To: <20240605145039.GU19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<Zl-G5SRFztx_77a2@x130>
	<20240604153216.1977bd90@kernel.org>
	<20240605145039.GU19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 11:50:39 -0300 Jason Gunthorpe wrote:
> On Tue, Jun 04, 2024 at 03:32:16PM -0700, Jakub Kicinski wrote:
> > On Tue, 4 Jun 2024 14:28:05 -0700 Saeed Mahameed wrote:  

> > > No, DOCA isn't on the agenda for this new interface. But what is the point
> > > in arguing?  
> > 
> > I'm not arguing any point, we argued enough. But you failed to disclose
> > that DOCA is very likely user of this interface. So whoever you're
> > planning to submit it to should know.  
> 
> This is getting ridiculous. Did you disclose in your PSP cover letter
> that all that work and new kernel uAPI is to support Meta's propritary
> user space, even to the point that NO open source implementation even
> exists yet? Let me check. Nope.

There is no Meta proprietary implementation. Some Meta folks who are on
the CC of the submission are working on extending Fizz, but it's not
ready. Fizz is here: https://github.com/facebookincubator/fizz

