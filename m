Return-Path: <linux-rdma+bounces-8100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F9A45255
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B25217F552
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735D19CD13;
	Wed, 26 Feb 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uphFgnPo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A6519994F;
	Wed, 26 Feb 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534008; cv=none; b=Kme4QWEQNJAFSp+svlA7VufsnMhb6D3sWVpZgT2pR+GDmevdcdjhwzMO6h0Q9q+0gkpxnua/6bShyZgKLB2z6qe5J3IxRR4bfr17xggAcyHPe/SJ+BDAXd5eDx/2baJhRT/Ubikt08ZcxHJTCrYPAJHD84EVkrsCHI2dkJ8JLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534008; c=relaxed/simple;
	bh=qgHwa1uTYGNlZs1FSdv5nNpP+wTaMz+y1Oe8SjywQLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPtFExNRdXAM6ZCDM7pmZSPg1014UULUVHqC4eHHOGpukYbX3zl0kjR8gsU6adcvIZ4rruQ9sL8l1fwHihc6JlZLCEA8QwgcYgFgG3RAz5vqCEdkalo9lD+EBViQNqXvglfd3g38CsbqkoJVIIf6tef+Tw+ajYzHfMxRj2ywXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uphFgnPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA80C4CEDD;
	Wed, 26 Feb 2025 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740534007;
	bh=qgHwa1uTYGNlZs1FSdv5nNpP+wTaMz+y1Oe8SjywQLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uphFgnPovfymgldeHUGro1jxgiPCTC0ckwkZ5B7XmddbxY5yJh5GGb7Y0ma8C/+Fc
	 2jH+Bd2/9aucGnV0bcNFpIA3y/8eJMNmoVXmNV70xoWkHr19Ht0a/PMIAk/gMDcUpS
	 ejjI5yMWLqLv5FmElWjcYfHW5dDMo3k4HuOKW3ahHdadE4m9pUzugGnfqlX2FSkqL3
	 +KkcUmSFiODbvsQM2rFhaW78kTqVkurJjK5k6DfOt/7AHvX2Ery5+0Gqf3JjQBHjOs
	 PIcMUFZ+anoAuQQvvnJ0/QvxMGnSAo6d5CtAOc0/TscpSYOPf6IidRp6DkByEThdQR
	 BHglpIkEsIBAQ==
Date: Tue, 25 Feb 2025 17:40:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jiri Pirko
 <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate
 domains
Message-ID: <20250225174005.189f048d@kernel.org>
In-Reply-To: <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
References: <20250213180134.323929-1-tariqt@nvidia.com>
	<20250213180134.323929-4-tariqt@nvidia.com>
	<ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
	<20250218182130.757cc582@kernel.org>
	<qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2025 14:36:07 +0100 Jiri Pirko wrote:
> >The problem comes from having a devlink instance per function /
> >port rather than for the ASIC. Spawn a single instance and the
> >problem will go away =F0=9F=A4=B7=EF=B8=8F =20
>=20
> Yeah, we currently have VF devlink ports created under PF devlink instanc=
e.
> That is aligned with PCI geometry. If we have a single per-ASIC parent
> devlink, this does not change and we still need to configure cross
> PF devlink instances.

Why would there still be PF instances? I'm not suggesting that you
create a hierarchy of instances.

> The only benefit I see is that we don't need rate domain, but
> we can use parent devlink instance lock instead. The locking ordering
> might be a bit tricky to fix though.

