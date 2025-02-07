Return-Path: <linux-rdma+bounces-7499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59FA2B75B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AD93A34D7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91F200CD;
	Fri,  7 Feb 2025 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnwS/NA+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142DD26D;
	Fri,  7 Feb 2025 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889092; cv=none; b=gygwVf+oDzY5nE36uWdEt3wfo5JVd3OTtvmXIebb9OCdLJeslJ/GcI/mardO8EA2RlUSCUXJjYhcK7qAxNo1jH29hvd4aBJm2oucn4BW/0c5BgUtio6vv8ExwWvgPpmKBDi46rF8ipJBxDdh53hWelWBecXXKCDjG+dcZLm8UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889092; c=relaxed/simple;
	bh=DIzS8u8JKTrGRGUXt+tZDeWDR4wryvU7XgL+jy/f7nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh4MQUjz/fguNFM7UcE8TabeYijfum+zxvIHkIzAkrxL3QLFvTvDcVYQ0WCErpgiWEkKBNmCwnrD71KMIwFMwh43YOk7VoCwmFHAaccw0OYAqxqsWphvkw+hXJVbrydxpwUu96VUa7EAcAT6EG/Mkbo/cC8kyzI0qb1Dz7LOWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnwS/NA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB26C4CEDD;
	Fri,  7 Feb 2025 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738889091;
	bh=DIzS8u8JKTrGRGUXt+tZDeWDR4wryvU7XgL+jy/f7nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnwS/NA+XgR86Zn4gAdl04yK6uCMMo/bN+czOoBp7UvnsdV3AT9rik/Uusacy0fCZ
	 V6NrEO63wQtV+V1XoN0Wp4TgRzUMlqLWjiem384RDpasg36q2J45/ujBX89aa8JPvn
	 SOXFpbtiHa3HBTVSnE9wv8WZ8AE4besYtBF0JFfN8A+bgBeX2qq0aGN6pL2NQQX/mX
	 MCP5yyw2x8kazG7aXN6K1PxvnrdzoP/7Mbq6iO+nXJ0iY26AXeY1YmMR7tATz7zntP
	 2I8GOdBUJF+e8V2xptzsmTY95dvEGQkYOEoHV5QlhY6C+bQUKUi9EyAwB3yHPKNke8
	 WELtRJQnPxYsw==
Date: Thu, 6 Feb 2025 16:44:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for
 fwctl_bnxt
Message-ID: <20250206164449.52b2dfef@kernel.org>
In-Reply-To: <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
> From: Andy Gospodarek <gospo@broadcom.com>
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

This is only needed for RDMA, why can't you make this part of bnxt_re ?
-- 
pw-bot: nap

