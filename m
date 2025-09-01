Return-Path: <linux-rdma+bounces-13020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F2B3EBD7
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF054202BCE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA42EC08B;
	Mon,  1 Sep 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdZp8cmr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022862DF132;
	Mon,  1 Sep 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742640; cv=none; b=s75bFwjuFyiyAz+stlcWUp7x50taLymkMKRFiLT+MbbtUF7dy07lv45oM8v1479s6mfdcOYtPp5KtqMOD2ErPx+F46YYTswE/7HFSfO5egq7AG3UNmyDdHkA+LuODTPdJvAMcAjAXGdTkbngtt3M1SB78jzZ9LeJQnojfgdJVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742640; c=relaxed/simple;
	bh=0u0xesyk825WU8r/UbXc0szsPDP+VuJGbOKWiW0uuh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUj/hp+Wf75vgBL9UUIhEVYA/LEO+WRWbQW76RlwuryM9b3LbyfPVhK04wvJ6/xjwcbakTtO/MuTi5JlX+s0pwvWl7+zsdl/Yhk8XPYsu4pwOlB6NPFRSbs2LNioDO7cia0JDDQTgpIgv8NYIdbh5dKWmR8m3PxJE0joW+IXVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdZp8cmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23FEC4CEF0;
	Mon,  1 Sep 2025 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756742639;
	bh=0u0xesyk825WU8r/UbXc0szsPDP+VuJGbOKWiW0uuh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdZp8cmrF/4JdHPGeZ87W6WjdpKoyALWmOYhsyJAYl1BA57eF4mQTyyBUzLHOBCBJ
	 PvtB1gQ0/3bx3ETOiGNcTW+7fSIZiG+vGrBYMQv5ZhLPOxaLzcCW1s/92QQe3xudf2
	 9IkLtBmvmghACvnWbt0xZGB1UZ3+kSgdVusYjLL2cSx0p9FznXwK9S6Zgx1gvDPDmX
	 bT5rkEhtA7OsaEvGqBdLt9f/8uu+efRHzq0U3oOie9X8L4Qd3+byviZJx5cPP8eHmJ
	 Mi5U+qo1OZLHQ7yLvqzzfhZPsmaJ8DfToOKMTNM62sombT/lyKZrjdcij+Y/Jl7AUc
	 ++i6xbPCBv36Q==
Date: Mon, 1 Sep 2025 17:03:53 +0100
From: Simon Horman <horms@kernel.org>
To: James Flowers <bold.zone2373@fastmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] net/smc: Replace use of strncpy on NUL-terminated
 string with strscpy
Message-ID: <20250901160353.GL15473@horms.kernel.org>
References: <20250901030512.80099-1-bold.zone2373@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901030512.80099-1-bold.zone2373@fastmail.com>

On Sun, Aug 31, 2025 at 08:04:59PM -0700, James Flowers wrote:
> strncpy is deprecated for use on NUL-terminated strings, as indicated in
> Documentation/process/deprecated.rst. strncpy NUL-pads the destination
> buffer and doesn't guarantee the destination buffer will be NUL
> terminated.
> 
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---
> V1 -> V2: Replaced with two argument version of strscpy
> Note: this has only been compile tested.

Reviewed-by: Simon Horman <horms@kernel.org>

