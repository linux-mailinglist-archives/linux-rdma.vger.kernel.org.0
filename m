Return-Path: <linux-rdma+bounces-12484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BFDB12231
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185EE3ADD89
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61962EE99C;
	Fri, 25 Jul 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iexTPIGI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AE3BBF2;
	Fri, 25 Jul 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461672; cv=none; b=TmVFIAnjBizJyMsrNRIImE98kFHNj1i4IaiUUNYaMvi8mvk7uiOZ1lmjCjVMs2fppglMmurH3RBegnV/80rUrbny4UaEBZmFPZWLlyKIQxKPZhqv+CrKa7dRaojrZjiwI0hBX6u/eGK4AatPNVEHp2dw3yCtsK3h1x758sgg474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461672; c=relaxed/simple;
	bh=+dn6kR5l0+iBlWJDGE+X3wOpJqP16In+19yWwfuvOXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA49YfQwmWsm3qn2yiVZsGl9B0ZLtBtu2Cg2WIa0zIn9fUE8z1Jmfp+qZiuGW0pmH28IBThKJV1Cyq5mC9XZiK4i51TzvIyVj+9iCT2O9uV37OstgK2T284f9u+lkzr1PCzWM91iyFG3bF2BzYTVtI4Rbwq04bq1HtAcEogsjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iexTPIGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0533AC4CEE7;
	Fri, 25 Jul 2025 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753461672;
	bh=+dn6kR5l0+iBlWJDGE+X3wOpJqP16In+19yWwfuvOXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iexTPIGI6sf5i4M49WzUR/f188G1IgLsRU9y93Rrgp+zcQqnJtt6X5AiZwKeJlapI
	 2gmyrmC3hXOqqM+Eu00ds49GM+ObZNO4oZ/q/HmwTlUwXtRd9QPbh85+jtEXGvYVPu
	 Dp7noayYIlmgcUQpz7Q6T7t6HZD/awZAPY+MoHaCy5A/GMZfmHUpuWIo2EC7Gztr2V
	 dByuwrrkY0GEjezSTDepuDKpWEKbO1toxACBcXEuI+FMt0+VJjcYAtGkl1V6H8Cpmc
	 pP0Cpg+WQj/5u+MsyG6MuhgfzDt0sYqffj7QV2axnXI6FfxB5mjHkv636ZcU0HfnGx
	 cg0Hgrl6/UUnw==
Date: Fri, 25 Jul 2025 17:41:06 +0100
From: Simon Horman <horms@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/14] net: ionic: Export the APIs from net driver to
 support device commands
Message-ID: <20250725164106.GI1367887@horms.kernel.org>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-4-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723173149.2568776-4-abhijit.gangurde@amd.com>

On Wed, Jul 23, 2025 at 11:01:38PM +0530, Abhijit Gangurde wrote:
> RDMA driver needs to establish admin queues to support admin operations.
> Export the APIs to send device commands for the RDMA driver.
> 
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

Hi Abhijit,

Perhaps I misunderstand things, or otherwise am on the wrong track here.
But this seems to open the possibility of users of ionic_adminq_post_wait(),
outside the Ethernet driver, executing a wide range or admin commands.
It seems to me that it would be nice to narrow that surface.

...

