Return-Path: <linux-rdma+bounces-14809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1CC8F437
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 16:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945CD3A4914
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F60733555C;
	Thu, 27 Nov 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAkoVyDW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71132D0F9;
	Thu, 27 Nov 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257294; cv=none; b=OquUMo/v4Z0lgfH0rgXbWDv5XFzfsMlKMAG5q9aYIXjv7UDWUUqKSMjLt8FAwHyYZSy7QMdDBRVyu2ASbbIFMP/YfZFsceVBFY38dM7zPu5XBXaV20EwLOBL6hNa1gz825QqONl8CfVXaQzkodTLzY4snYxlji6pQ8+W906sWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257294; c=relaxed/simple;
	bh=cLVmFsV6D+vpjUnuiLqhRPKKYefuGVtgibjdcOZHVAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7ZnbElN24xxxE2MCvDjTTKv6YXBg0hvxfMeTn/yMw3evz6uETqokq9IEd9cVXYjCT2gL6J6JLVuBWV+PiByiGboXDTAVR75w9aKLTMA0MMgFC9B4ZaWoBJwSd39HZt189FqG9JMQuJ8Qc7CEPONzNSvKIfLEmRXAwBzPWp5MkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAkoVyDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC68C4CEF8;
	Thu, 27 Nov 2025 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764257293;
	bh=cLVmFsV6D+vpjUnuiLqhRPKKYefuGVtgibjdcOZHVAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAkoVyDWb4czhvURqf5+8xTJ+VhYYculljPZQDNu9L6Ju426bcMbaYuDg12eD2Guq
	 Dc+i+fN9dZuTw0UdyB1ooQN2Z3+LEA1BU/MYIZ+gUj4ZZsi3Fam+VwCiJ+P7RJlapg
	 TMThb6taqNQoCZLqU8p5bMqY6Mmn4BnREbcQ4qMEZvNQ/jg2THa8b3eQEBkFYWMXCI
	 U7vkgpEN9c5Z0TmqnjQBYou+Z1AVzpB7G85w33kQq9NkG0+iG4QSIM9rTcI9c9uTR8
	 0o6sKSvDusDKmSqCOez7q9R+lDkdcqpFwouo3NTiJwGp5szcBzYf0pQ6dMNJNXVr0G
	 J4yT/rXx+vEQA==
Date: Thu, 27 Nov 2025 15:28:07 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 06/14] devlink: Add parent dev to devlink API
Message-ID: <20251127152807.GA719673@horms.kernel.org>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
 <1764101173-1312171-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764101173-1312171-7-git-send-email-tariqt@nvidia.com>

On Tue, Nov 25, 2025 at 10:06:05PM +0200, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Upcoming changes to the rate commands need the parent devlink specified.
> This change adds a nested 'parent-dev' attribute to the API and helpers
> to obtain and put a reference to the parent devlink instance in
> info->user_ptr[1].
> 
> To avoid deadlocks, the parent devlink is unlocked before obtaining the
> main devlink instance that is the target of the request.
> A reference to the parent is kept until the end of the request to avoid
> it suddenly disappearing.
> 
> This means that this reference is of limited use without additional
> protection.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  Documentation/netlink/specs/devlink.yaml | 11 ++++
>  include/uapi/linux/devlink.h             |  2 +
>  net/devlink/devl_internal.h              |  2 +
>  net/devlink/netlink.c                    | 67 ++++++++++++++++++++++--
>  net/devlink/netlink_gen.c                |  5 ++
>  net/devlink/netlink_gen.h                |  8 +++

Hi,

I think that the updates to netlink_gen.[ch] belong in
the following patch rather than this one.

You can observe this using

tools/net/ynl/ynl-regen.sh -f && git diff

