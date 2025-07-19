Return-Path: <linux-rdma+bounces-12314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFDB0AD0D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 02:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE31E5A2AD4
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4A7260A;
	Sat, 19 Jul 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRn+v0du"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F93FE4;
	Sat, 19 Jul 2025 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886127; cv=none; b=IrcrlVeJL9BBvV5AFkECappraliS6HsRBAcpXzh27Qw5Tn6m210SEYI3ck8OgruZ9wOIlCQ4zh4BnbQ67hArJltTajATwbb1Vx6CfTluzijoBsRu1kybFPvNoxAqPGSM3TQRShR+g/rdAodlxE3idi2yIOK+/6sQ/88CglKTcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886127; c=relaxed/simple;
	bh=6dgQXljSybQMUm6Fi1nMuC1dGZk4ySO6T8l7XezcvZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/8RL8Z4kKbV+C/YlY5FG60/WhfYgO8yHVmv2mkqugyWQKeFgyop7NekwBjKTd8e3f7LJQKSota35OLEQHNCaRbhj6+/XyvvXuWZBUt2X6orYEeJqm7sabcXbE+2l3FCs7+xifZashZbr1nyhO+ZXjHweb6SX5wnZ9uONQ62CjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRn+v0du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D91C4CEEB;
	Sat, 19 Jul 2025 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886126;
	bh=6dgQXljSybQMUm6Fi1nMuC1dGZk4ySO6T8l7XezcvZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RRn+v0du7QIiWPRCfKBtIBvk//B/sECBTAJBbZpMZ/cAkX57sHJVXka3QUbfTbLPq
	 u9K9xdYVvB/1xJik/oswl+jrHqXvj8ILkEEFkE1hqq8n7L1dyWRVO5RuLXuvAEn0tW
	 NlZfUj8oKhJqnhMDe55vhLSofpezBhBPM4Grt9DsE1UFO7eOF6QRDFmQbuBwOGkGOx
	 Av8RPO7Ikn25OPKIaMX707BKInxE3O/XoTRMJn3a2hXPUxspfooodUnKLNCpfiCPuD
	 6zpK/boMpZ1CVKwEmaRnHFRuxX7d38j9F3Zkh27N3rWTLgdtbyu7zxUJUjzaVXSgiC
	 i6U1K+CLmd7bA==
Date: Fri, 18 Jul 2025 17:48:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
 <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Shahar Shitrit
 <shshitrit@nvidia.com>, "Donald Hunter" <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, "Brett Creeley" <brett.creeley@amd.com>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] devlink: Make health reporter grace period
 delay configurable
Message-ID: <20250718174844.71062bc9@kernel.org>
In-Reply-To: <1752768442-264413-5-git-send-email-tariqt@nvidia.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
	<1752768442-264413-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 19:07:21 +0300 Tariq Toukan wrote:
> +	DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,	/* u64 */

/me pulls out a ruler

50 characters, -ENAMETOOLONG
-- 
pw-bot: cr

