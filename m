Return-Path: <linux-rdma+bounces-14369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA3C49AEE
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 00:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489193A6B50
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8C30216A;
	Mon, 10 Nov 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8HLZtN4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A419CD05;
	Mon, 10 Nov 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815697; cv=none; b=llwHYw98LDg1jEgohKHiOpmQatWxrCuEx10oFAHmUIFYZy52yQCk59pTB403wQABkHRBEpjow2laKD+jmI//U6+xZbzDu8HJjzG+eyW+oiLhNJmfuLGLXRsoCmEQe1f9VDiw75YmpKeFdBPpW316fi800gUlCX+X5Sz4Z1GiX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815697; c=relaxed/simple;
	bh=pw8l6QAhWfbgalj/rdjn7/vFNJjdaYWZBrq9g5kSPg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XARdjfXo6dpk1lZ4kBTNqrmZtWjEEnyQTJPd3yH/pMFFWVD+XwdZeIPI8QOlQPIB01VcYrdpwycHsB9YoAKmYICZama8Td268l9qyaf9Smrdf20PFjrkkowwdPNmhIMimFcBd0vWO0zNm443/ErB8499Dqc9j4MBo9HWbqcSrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8HLZtN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF72C113D0;
	Mon, 10 Nov 2025 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762815696;
	bh=pw8l6QAhWfbgalj/rdjn7/vFNJjdaYWZBrq9g5kSPg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8HLZtN4P9lQykfRX66OjCW5XNx3EB4nqyUYkr1K6qVFAiH/1B2WuyT6Xhr1zrk3/
	 ExH2jrpU7zVP87t7kjXI3Kt7IahNaP4FHi9dEbWmkOfhcNkjbdFjYkvn4BLSd1EO/T
	 mW7RS3pOB4sk39x+S77N8ZE2JAcYlWzhiXk3H/uSO91rQ9fRt5JYiPOs+MVIHezx3p
	 x9hl9uOQ1E29htlhgUjiKxDmue8SYA7DhtwxpT5AFCPuGOlVR6hlAxRLWDHkZVinqY
	 BGjV1lxESgN7GVwIwfb+L72Fky5jmzzbLAUnbIGEkRxFXZVmRVflMaGWkr0kgqrKoi
	 I+5wpEmr7hZzw==
Date: Mon, 10 Nov 2025 15:01:33 -0800
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
Message-ID: <20251110150133.04a2e905@kernel.org>
In-Reply-To: <aQ7f1T1ZFUKRLQRh@x130>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
	<20251107204347.4060542-3-daniel.zahka@gmail.com>
	<aQ7f1T1ZFUKRLQRh@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 22:14:45 -0800 Saeed Mahameed wrote:
> >+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
> >+	if (err) {
> >+		NL_SET_ERR_MSG_MOD(extack,
> >+				   "Failed to read sw_accelerate_conf mnvda reg");  
> 
> Plug in the err, NL_SET_ERR_MSG_FMT_MOD(.., .., err);
> other locations as well.

Incorrect. extack should basically be passed to perror()
IOW user space will add strerror(errno) after, anyway.
Adding the errno inside the string is pointless and ugly.

