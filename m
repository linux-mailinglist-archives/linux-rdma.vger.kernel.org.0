Return-Path: <linux-rdma+bounces-7819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE4A3AF8C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 03:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DDD1898C79
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BE176ADE;
	Wed, 19 Feb 2025 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyuuiCyr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9435953;
	Wed, 19 Feb 2025 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931692; cv=none; b=CyL5hXY7iede0i3+dhhptH99iX/5FWvyXXnfYBGsJWfOkSpB5ZHWBKD+7POeeJIYpgX0NMHysgqB3S54DQDuu69hwM9sjPDAU9trb12EnIXZHlH9sQxXAE8rjISnM74SEmD7hm9mxMT1nx7cR6c8nNU7QbTnhMHlfq3pH3LtvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931692; c=relaxed/simple;
	bh=XCg+HFXg8G/7UErPkHwbpxI9yQdsASnPzjA2vlPAjG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVRYtZgnspuby1sK0znrg8j4LnpUTN6XyI69dlzuQkeMtE/4GG4Cjp/VLbm/CkgHPLKUitqtpbD7jMR3RG4mZ06vsg1HkHaUygw5J1PPACCAUzmFp6Z9921D2hwtXyqmMMBav0cRGtu7uxGYPoGY4jWNQboonr03omt8ZsBsKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyuuiCyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC6CC4CEE2;
	Wed, 19 Feb 2025 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931692;
	bh=XCg+HFXg8G/7UErPkHwbpxI9yQdsASnPzjA2vlPAjG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UyuuiCyraaJ3RBFeLCP7vqL8tYaTdXcF7MHcbSiI9SJPa6BDPCUIu1i80BW4gcF4+
	 9yOB4ZdardNg9zjt4R8Kmr4gzT5KtK0rGS93utfj/xVSOfp0dTnjT43nuD610wtRdR
	 QfAZvAFvOuOgYLaJtFHvTWQEBiJVvic4kYUy8Fmw4Px9MBSaIrlHM1v2yic20CUcMl
	 CTpkZxSxtljvQN/PtOpQsAzW5O2ZHYOUMiarGqc0PUSZsvRsHxEXur49lQTWCGR6zX
	 KTi4Wo2UodccJOtN6SEWoTqF9cZQWMez6dBmCLZVxrGM/Bsym6WOYk3M3iIU1Ffq3m
	 2MYdVReOFY36g==
Date: Tue, 18 Feb 2025 18:21:30 -0800
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
Message-ID: <20250218182130.757cc582@kernel.org>
In-Reply-To: <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
References: <20250213180134.323929-1-tariqt@nvidia.com>
	<20250213180134.323929-4-tariqt@nvidia.com>
	<ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 13:54:43 +0100 Jiri Pirko wrote:
> For the record, I'm still not convinced that introducing this kind of
> shared inter-devlink lock is good idea. We spent quite a bit of painful
> times getting rid of global devlink_mutex and making devlink locking
> scheme nice and simple as it currently is.
>=20
> But at the same time I admit I can't think of any other nicer solution
> to the problem this patchset is trying to solve.
>=20
> Jakub, any thoughts?

The problem comes from having a devlink instance per function /
port rather than for the ASIC. Spawn a single instance and the
problem will go away =F0=9F=A4=B7=EF=B8=8F

I think we talked about this multiple times, I think at least
once with Jake, too. Not that I remember all the details now..
--=20
pw-bot: cr

