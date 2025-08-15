Return-Path: <linux-rdma+bounces-12779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4FEB2865E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E001CC1333
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1316285061;
	Fri, 15 Aug 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPzsPUfJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC6221D87;
	Fri, 15 Aug 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285989; cv=none; b=hGbM4+PPRwOz8sVIKrXuE/KYZ81TRm+5CW8EnSJC7EeRjWZZk8xZQJaMJwiwuSrs0ohhsWiky0mnCB645sLn9kGWneTIfNDFAtByp6eL0s7lcuxggdwhjaLOST8pZEMWPr6ya6Rg7ogmIP7pIXvUBx07kp6HKgxmcfTe3MXNIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285989; c=relaxed/simple;
	bh=XThlV1U6bmBUoCCBTZhniQaFumiomKJglFZyqJ8EKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpoPwVUwJJTKcbEsjf/hxdVvCA+qshOxZRkrXUc+Zcv0oe4GVvMquLBpR0YPX3zuAvHLjrhgqaGmjk/W/hQHD5UwWsm5GIisZfbH4qh1qSDuzQv0QYY6Sg97MsMdmvLKfQvl9iqL20txCriXriPmcVNQJmTJZ57GQ5rCERmRanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPzsPUfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234DAC4CEEB;
	Fri, 15 Aug 2025 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755285989;
	bh=XThlV1U6bmBUoCCBTZhniQaFumiomKJglFZyqJ8EKMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RPzsPUfJBr5q5p+iF9vGtPAIahYFabs9abdt4JCY7KxS1BzGSCe6yRc539IhK5VBn
	 BHJH/IQp4gyfnkPd1YC/dKSq0GM/dU83SnnwkOxSYvQ4TUUPUuV0CoMUlKZANeCulU
	 IXM7O4rn6DuC98dxd83wIL7+Z2YA1qUbe6SKpFDZ796B1oaIbDtehNXYrQJ3NyjTB8
	 ThvxZ/TZ1RZHfqz1s2dV1biJs0NzcmsQg3rroH2ODMZvpYx7eLoaDNpgmShfEcB0P1
	 15fyszyNz+4TOiZQtxl4cn/2BGzPyxDkB2ruCyy84Yo8ioH+1EZGfD3XjmVyTDdNMw
	 8Qx3qtsNsZypw==
Date: Fri, 15 Aug 2025 12:26:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Brett
 Creeley <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai Huoqing"
 <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>, "Gal Pressman" <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, "Shahar Shitrit" <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next V3 4/5] devlink: Make health reporter error
 burst period configurable
Message-ID: <20250815122627.77877d21@kernel.org>
In-Reply-To: <1755111349-416632-5-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
	<1755111349-416632-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 21:55:48 +0300 Tariq Toukan wrote:
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index bb87111d5e16..0e81640dd3b2 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -853,6 +853,9 @@ attribute-sets:
>          type: nest
>          multi-attr: true
>          nested-attributes: dl-rate-tc-bws
> +      -
> +        name: health-reporter-error-burst-period

the "graceful-period" does not have the word "error"
in it. Why is it necessary to include it in this parameter?
What else would be bursting in an error reporter if not errors?

> +        type: u64

could you add a doc: here?

>    -
>      name: dl-dev-stats
>      subset-of: devlink

> +	DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD,	/* u64 */

The _ERR here won't work if you used _ERROR in YAML. 
The naming in the YAML spec must match the C naming exactly.
-- 
pw-bot: cr

