Return-Path: <linux-rdma+bounces-11505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12456AE232D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261153B78C5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5E22E3FA;
	Fri, 20 Jun 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol+pZni+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781B1E47B7;
	Fri, 20 Jun 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449536; cv=none; b=R64PEHLgxiJ2aqPoss7T+kbRA1LEGrkP3b3bXU8ZHFaqd2jptJsh39W5yTZCr0/0+I3YtfFg/+tM+pgaKZ2j4qtaxXakILFlLaLb+cyNsLdUerqgNdgMQhD05N6mpc2bKYO091dzfKFDN2O8WOaJfjloKIgeKKYcScnhiWd/E00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449536; c=relaxed/simple;
	bh=pK/h+JSgPhpByI86IHHzGQd+nBIYNF7KxQrBvveWVu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkBfXdCKtynnH0nAy1U8apcVeUP5bYQdINWSMEVeArVo8IjK3vwooE8UO7P0s/4W42kUrAwKxHYjAGwwh40TZYutSfM0Ddzp/4IRZml5YijoaKDzs/PBTi9a1ST0iFmVH6UTY38DdeVVDDt8O/yRETEeWc6Sks4xkLER5sOmrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol+pZni+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E405C4CEE3;
	Fri, 20 Jun 2025 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750449535;
	bh=pK/h+JSgPhpByI86IHHzGQd+nBIYNF7KxQrBvveWVu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ol+pZni+J2T8bAWRtcOO7oJetCxDentWbCN47I0aXs7slvtwNuXbxAD4x6yabxWDu
	 CPV8NFovMwTFb3gOvoZ+90AIHb+yXegbD8iOeVjYfmsSeqbyz/axojqmPttIBNgA/F
	 QKlVlDpagJzqOG+zxVWqEGjLGiEWosZ9qS+mTuUPc+OkjmauPvc9EHcLCdFOWwL1lW
	 rh3CE6f9CBUtIbAiz6XBOz+Zt7XUDTifYLj/ZHfAEMfsWyhUphv5BhjzjR618cCXm+
	 L3hlyPaDBA08m70H8Aw0YGFbdULx4yKZ9o27BdYbDypEewVBzIaMOQbUUpHRr+wkFP
	 GmjtQ9jp3NUDg==
Date: Fri, 20 Jun 2025 20:58:50 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] net/smc: replace strncpy with strscpy
Message-ID: <20250620195850.GB9190@horms.kernel.org>
References: <20250620102559.6365-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620102559.6365-1-pranav.tyagi03@gmail.com>

On Fri, Jun 20, 2025 at 03:55:59PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with two-argument version of
> strscpy() as the destination is an array
> and should be NUL-terminated.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

