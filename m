Return-Path: <linux-rdma+bounces-5638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87F9B70AE
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 00:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963CA1C20A4C
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 23:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C5E215008;
	Wed, 30 Oct 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju76Edax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA319CC24;
	Wed, 30 Oct 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332089; cv=none; b=WC9ADJCEzGypMags45DqcnwFsZFByX0OmOGH5TmnQOp7WqRFIxZwC0ssXSYLDEoK9Q/DHe8YpWVztI1szE6jD/Z/YENGeqpom27WKa/Mv4vtXj/hs49w4H3fLWcHrZa6K2DeLh54iPTHquqVexI+75jdHomkl69UtHRUuSTyE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332089; c=relaxed/simple;
	bh=Q0wXyQGBlYip/F0j6/woGSioAXOUzqyfPJJC3tkOLK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elIlq3jrMuXnU4PN1FknX7VQtbi4ib0J8euyl4s+xf+N/WvCIL9jT3NYKDzX22OpLMfWjzPmR2k5T7xL1YZ0G0LH9Zo2hs3GLQ+50l46HmZ2eaXiszdPOAHZ6eVvKrRyG+3ldibAO0Jn5i/SNVok6fzUlsc36M34ysaKtdq8mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju76Edax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA34C4CEF0;
	Wed, 30 Oct 2024 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730332089;
	bh=Q0wXyQGBlYip/F0j6/woGSioAXOUzqyfPJJC3tkOLK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ju76EdaxYrc2VgAjivV0KVt2GMgCCgQhkFEfaJJ6/pgDxTefM1lg4Tf1OWyD6kJF1
	 KPs45HSaTf/dlBDXadIlmKLrd/PTXlvHaEPFN+6htEnDe9la3DhVDjvzJ08pFbHCu1
	 Mi9Dcrl+rhMsrI94lHkbmm+ltjVTd56lvqQYX2iMsa9T1VhTsDaczRIlDIIrjNFfwV
	 BJFkhdoI7ChFFbj0fL95fN0enUv6F2jgu70AtVwj6XP/DlYWjcgdm+p8m6To/KCBGH
	 7u3hKM5vMU2n1gcpbXdQJ1gi5+guUy9KsxG9mMUy4fX4yx/ByjRBAgjJViZhPyf2di
	 YfF8DVjTLFaVg==
Date: Wed, 30 Oct 2024 16:48:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Tal Gilboa <talgi@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shay Agroskin
 <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
 <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
 <saeedb@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Michael Chan
 <michael.chan@broadcom.com>, Doug Berger <opendmb@gmail.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau
 <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Louis Peens <louis.peens@corigine.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Roy Pledge <Roy.Pledge@nxp.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, virtualization@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] dim: pass dim_sample to net_dim() by reference
Message-ID: <20241030164805.40408945@kernel.org>
In-Reply-To: <20241030194914.3268865-2-csander@purestorage.com>
References: <20241030194914.3268865-1-csander@purestorage.com>
	<20241030194914.3268865-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 13:49:08 -0600 Caleb Sander Mateos wrote:
> net_dim() is currently passed a struct dim_sample argument by value.
> struct dim_sample is 24 bytes. Since this is greater 16 bytes, x86-64
> passes it on the stack. All callers have already initialized dim_sample
> on the stack, so passing it by value requires pushing a duplicated copy
> to the stack. Either witing to the stack and immediately reading it, or
> perhaps dereferencing addresses relative to the stack pointer in a chain
> of push instructions, seems to perform quite poorly.

Looks like patch 1 didn't get CCed to netdev. Please repost?
-- 
pw-bot: cr

