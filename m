Return-Path: <linux-rdma+bounces-4477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F495A881
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 01:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117A61F21FE0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6517D8BB;
	Wed, 21 Aug 2024 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCnjlK3X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369051422A8;
	Wed, 21 Aug 2024 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284192; cv=none; b=awwyX5yQIPif9LiWdHqg6bjxeJDrTD3BdO59IwOi//3XgZfcxYFMtti+RitzQ/vkpT2L1YEjO+8QKztW0a9acWlhinLyyVoDbcQGHy7tVASMIlBIFUoNVD1tYe3fXlEepOnMwJnXOQj47c26OIPJV6jUXw19r05sSN/2uuOqdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284192; c=relaxed/simple;
	bh=/bY3cMBIpekL92+/aW9JC2UUFiFB5ABm3j76VZe483g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG8zgg/Wu8bRUWSLeCHmYmq2HyIrasuOuByRwxePQfi18GOWMGeVifLCrbATDKnFRXz88hEkSw3WL8ln8JUeU6HHcoR6cUxRUueFtVW7BC6CnsQoP6rzAkP9bcaGHM0R3S2yXKjyfkLmd52uEnpxR+JopXCPfm65eb7IHHnERJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCnjlK3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4205FC32781;
	Wed, 21 Aug 2024 23:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724284191;
	bh=/bY3cMBIpekL92+/aW9JC2UUFiFB5ABm3j76VZe483g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCnjlK3XUeQm4EBZ32TMjl/0sTxMr4gdaNRbyRMd7N4Z8spIJ8+kZvccLMqrIpwCH
	 i3O1dpuoleH/+xvATCXDJMtEEzeKBYGPYMuRyGH/qNTKDNuQ78Et2Pm6Kr/mxoTrbE
	 4WP9g4ST8PQPtr4SRwy3aaqd9PrF54swhliXnlSCa3/Y5DmepW0emyAwXO2wD2l4K5
	 llsxsRCu0OAWwW9z/zYjFo+S6MnKTVX2gpI77ersQw1mR2PgUciLf1i3ct6A9bvCek
	 FMxMwQroZ3uqXnmbFTd0XcyCuLab1MOH2Vt89btStrbJwutpsE8h1k+PX0UnUqTNBn
	 KFkgPg6+YOOSg==
Date: Wed, 21 Aug 2024 16:49:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>
Subject: Re: [PATCH v3 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240821164950.486849ca@kernel.org>
In-Reply-To: <5-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<5-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 15:10:57 -0300 Jason Gunthorpe wrote:
> +	case FWCTL_RPC_DEBUG_WRITE_FULL:
> +		if (!capable(CAP_SYS_RAWIO))
> +			return -EPERM;
> +		fallthrough;
> +	case FWCTL_RPC_DEBUG_WRITE:

Nacked-by: Jakub Kicinski <kuba@kernel.org> # RFC 3514

How many times do I have to ask you to keep my tags, and to CC netdev?

