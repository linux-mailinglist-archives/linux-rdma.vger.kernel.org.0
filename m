Return-Path: <linux-rdma+bounces-15712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E4D3AF43
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 16:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EE483016F8F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19938B983;
	Mon, 19 Jan 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y6behdOw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BF329C79
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836998; cv=none; b=KcDmtVJCSnDgvUExoATg5GFDGjVPUZKcIL+fcw9DHbj+Gv8xLIV1VOQiU1VyIzLdKpujoX6H6NNF1N6WRVT3wpYokFqMFcZ++Z8KxjpjHQFqW4BVf6tjekOw8NQD0qkJZFywwm0/F54lnfPjcvW61vmz6wuwKbDCbFVEivjqCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836998; c=relaxed/simple;
	bh=e88EAJWlPwazHImhiAb0XFQNxdwL8O9wnAEVl5EVpDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPocCtpRgL+an/FGmjE80zHCsm4UwhnKpyI0Ot5Cb/jLp5cpimQM42wZuH26BcFiNK+cdVEXwNRB3b8Rc5z7oIew/rAoM5oYy512lVcISOmF2sbNqtHJdwFkX3NKf7jU4e/YPBSPRtoOHXwM6eH/et0pdX4Gmp5x/P4A3hpZeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y6behdOw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1B7DA4E420D8;
	Mon, 19 Jan 2026 15:36:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C710660731;
	Mon, 19 Jan 2026 15:36:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69AF310B6B147;
	Mon, 19 Jan 2026 16:36:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768836993; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e88EAJWlPwazHImhiAb0XFQNxdwL8O9wnAEVl5EVpDQ=;
	b=Y6behdOw9Tape1gyqVI8+dOtAddglnwZP/wAIEjt38AZDN72qmzY1J0hjo6HxqENO+0CY4
	DjF24GLVXRsJQZFyQYaSatGbICfmSf8IanPVBSPjO5y1QAnS9avpFt97gju8+/q9iX+7UE
	eEL8f0gdLqpD22oNWlQX5ahCbM5X0mZyKfONRlXRzyUk+6G0pIZw0bFKmYvg4EVowyoiFH
	x4MO9PlAu89Po3wyWUC6WOoh2/GME51ixbHO31BAx3LaSr7Ilnwim4CpTlfmqo27c2dbep
	jZUzCDk8GCfo/zAQbHMzW0CKEzDaK5c+l5+ikBIcBKQezAF/UWE+9dCDikgkxQ==
Date: Mon, 19 Jan 2026 16:36:29 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
 <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: remove legacy way to get/set HW
 timestamp config
Message-ID: <20260119163629.2e626ec8@kmaincent-XPS-13-7390>
In-Reply-To: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
References: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 16 Jan 2026 06:21:20 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> With all drivers converted to use ndo_hwstamp callbacks the legacy way
> can be removed, marking ioctl interface as deprecated.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

