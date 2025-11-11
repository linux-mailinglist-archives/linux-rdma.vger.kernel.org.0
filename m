Return-Path: <linux-rdma+bounces-14404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E576C4ED0D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7EB4F41B4
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BB36654A;
	Tue, 11 Nov 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C387oCWR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C4365A06;
	Tue, 11 Nov 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875255; cv=none; b=TPxu5dET8f3kYB7YV1Y9SxvaD16nLyhv58vZsEmZcPYbaeBeT+d0l1Q84YCNv2dSpJSbPygMZzULZNhIxiVu6M0La6ZVwVqjtsRnG1YnaUSbHWnP8RHJqavTs/W255DWN6jhpmafoPKMmts52kfdfauxPVgUqqXsw0vHO+XZz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875255; c=relaxed/simple;
	bh=/IiWVNswHcrotcXImuZbhDizvXR5f83IzztpfhJsS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLKAWweeh5j/iv63qxagdlvb1eBWEfm5iEQZvl7ZqgM/OVUdCEfzNJAfVO24QnFon9frnmbQzITzfvCQe0JfyM2GQF402TD3/qiG0EJxtYYDS+EbEGRB7YtoluCN0+Xl1ShRNjxaSdks412V5VLgdDTkKtYTRd8OEyrCGYznRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C387oCWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F987C4CEF5;
	Tue, 11 Nov 2025 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875255;
	bh=/IiWVNswHcrotcXImuZbhDizvXR5f83IzztpfhJsS3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C387oCWRJx0kXDCxVdceMrAw7Xp2ONrwf4fzsso3ilHBN5eUDEfDZc5gln26HIGHS
	 QREeK2eYI5DB0V23P5YE8svKzYb0H0AfOXgoYultzhBBFQiTNuKRdO+ACLwEiqbOKy
	 vFXuH/7UdT7zdJsvrSeDbmZNG7p2v0YmZOXzVdxc1ejFVQmXzaTVfQB+CL4ky9CiLP
	 XkADHhMZkYQsAmvyySufJL72zovyGm+I26vbA/NJmxqPjzNLCA7O/HCSG9hLnQ0h3T
	 1sR4//vn0OwcGa60PW9qgnyqkXWU9IY7XQADFO6bAuP8DOdUZyRkBfYhAVf8i0zu+w
	 3DOhKUCwD9ZsA==
Date: Tue, 11 Nov 2025 07:34:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
 <schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Tariq Toukan <tariqt@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
 <olteanv@gmail.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode
 via devlink params
Message-ID: <20251111073412.5aa12e38@kernel.org>
In-Reply-To: <aRKu0Iknk0jftv2Z@x130>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
	<20251107204347.4060542-3-daniel.zahka@gmail.com>
	<aQ7f1T1ZFUKRLQRh@x130>
	<20251110150133.04a2e905@kernel.org>
	<aRKu0Iknk0jftv2Z@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 19:34:40 -0800 Saeed Mahameed wrote:
> On 10 Nov 15:01, Jakub Kicinski wrote:
> >On Fri, 7 Nov 2025 22:14:45 -0800 Saeed Mahameed wrote:  
> >> Plug in the err, NL_SET_ERR_MSG_FMT_MOD(.., .., err);
> >> other locations as well.  
> >
> >Incorrect. extack should basically be passed to perror()
> >IOW user space will add strerror(errno) after, anyway.
> >Adding the errno inside the string is pointless and ugly.  
> 
> ernno set by stack. err set by driver. we can't assume err will propagate
> to errno, this is up to the stack.
> 
> And not at all ugly, very useful debug hint to the user, unless you
> guarantee err == errno.

Not propagating errno should be fixed, if that happens.
We need clear expectations to avoid the messages being all over 
the place. Historically we haven't included err because formatting
was not an option. So I think we should continue this way.

