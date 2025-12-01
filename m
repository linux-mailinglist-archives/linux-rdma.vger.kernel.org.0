Return-Path: <linux-rdma+bounces-14850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE0C99415
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 22:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2F7A4E03D6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289A27AC41;
	Mon,  1 Dec 2025 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFqHOOIb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A242AA9;
	Mon,  1 Dec 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625797; cv=none; b=IwNzEbO2JsfuvqjSqwY3zVhuHGokC/jItF0WBo1X8uch8fcVw9h/owJ92Rm20ftryLJHGKzUI+b8puiCUtpFuc1mMw7TC93NshpMPolT3wkAfFJp40OT26nkFn1eahvX4UWiuPJB4f1ksMbodt3ALi//5JKvZ60ibGS4cvqtouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625797; c=relaxed/simple;
	bh=Q9XtxSLd1rGac+cMYRtu+RfRV0V9DsrRe1YEZEWkg7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZIQggAHGrNWeC4pYuCc/P8Ixa1KcU2w9T6SnRFJTktgDqNhtjSKib9REqu0ZPbm0GPqi1B/iS7H1kjSoysX3ntitrOMvtQJgOERUgpoxxHeHk9kLqFRZp28zyBKjqHm4r+V6G5A01oDLHeOgkUuYiEpI90AMTBq5OucGVawuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFqHOOIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3957C4CEF1;
	Mon,  1 Dec 2025 21:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764625796;
	bh=Q9XtxSLd1rGac+cMYRtu+RfRV0V9DsrRe1YEZEWkg7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFqHOOIb5o6yJOFl7lHQmbj6GnpI0itWZmYPfKoZ/b/zUawWr8ATXpz5yEPvh05iG
	 8J3TpYGeHSJHncImg5AjGFSm/HApLKPF/a0YWVg4RfAjI7kts6B0pgIBDZfnfl1Tx8
	 /N8WdFjzII0IDjcSXpGB9MpMJ5l9ZUkz8eKQn7yQbrXfirFcWuXtrsyN2dN6bJo+Df
	 WSrt+9fgEabudvQp2mIdRbpUtUQTQZoRDiIbXl4Cn32xdstZIEoHG/PH3tJenmpAlt
	 5iu8L1XWfGxhKCxtPG7yKr3nZPeUdTk8N0At6u4p4pLCTP1b9yffRJLluvkPe00FE1
	 jyiAG9Rwe3Yvg==
Date: Mon, 1 Dec 2025 13:49:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20251201134954.6b8a8d48@kernel.org>
In-Reply-To: <n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	<1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
	<20251127201645.3d7a10f6@kernel.org>
	<hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
	<20251128191924.7c54c926@kernel.org>
	<n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Dec 2025 11:50:08 +0100 Jiri Pirko wrote:
> >> I'm not sure I follow. If there is only one PF bound, there is 1:1
> >> relationship. Depends on how many PFs of the same ASIC you have.  
> >
> >I'm talking about multi-PF devices. mlx5 supports multi-PF setup for
> >NUMA locality IIUC. In such configurations per-PF parameters can be
> >configured on PCI PF ports.  
> 
> Correct. IFAIK there is one PF devlink instance per NUMA node.

You say "correct" and then disagree with what I'm saying. I said
ports because a port is a devlink object. Not a devlink instance.

> The shared instance on top would make sense to me. That was one of
> motivations to introduce it. Then this shared instance would hold
> netdev, vf representors etc.

I don't understand what the shared instance is representing and how
user is expect to find their way thru the maze of devlink instanced,
for real bus, aux bus, and now shared instanced.

> >> Well, the mutex protect the list of instances which are managed in the
> >> driver. If you want to move the mutex, I don't see how to do it without
> >> moving all the code related to shared devlink instances, including faux
> >> probe etc. Is that what you suggest?  
> >
> >Multiple ways you can solve it, but drivers should have to duplicate
> >all the instance management and locking. BTW please don't use guard().  
> 
> I'm having troubles to undestand what you say, sorry :/ Do you prefer to
> move the code from driver to devlink core or not?

I missed a "not".. drivers should _not_ have to duplicate, sorry.

> Regarding guard(), sure. I wonder how much more time it's gonna take
> since this resistentance fades out :)

guard() locks code instead of data accesses. We used to make fun of
Java in this community, you know.

