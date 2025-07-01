Return-Path: <linux-rdma+bounces-11788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB13AEEC0A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 03:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D157A59E4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49C153BE8;
	Tue,  1 Jul 2025 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCY6Hm/T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D74C97;
	Tue,  1 Jul 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332729; cv=none; b=CFcvXcn7h1sGUe6p16r3ISVCdt+uM6KgLX2ZFlFemTqNxwPzsPgrlkKThJAe9pSFoHIxhJh6Ye7vFh/PGvOskAxtllrr9JCrBwxJLO32UnMezdjGgtCpPTGdRE8bY7CgyIhBGSUTF29QSy0eVoJ5paPUOfUllOO6blMpITFpW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332729; c=relaxed/simple;
	bh=06FSA2GbRH98qBYMSlW7ZEdKQ9P2SIJ2zTS/zEFQLdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcQRBZPIUJ6klmfEZtlJWtQe+hHCcW1ADSlsmcAmicCY+9ofTQh/Al3FR/qUADZuRudaWzyyl1wLrbBqMiaarE+JHZkxsg5dv3tK3E7VwOcS/2/L94QxXBauKzHjFudDjWHo3re3eCEg2glUR8el5N3UBrZ/OT/t/pSdgHC02ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCY6Hm/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2554BC4CEE3;
	Tue,  1 Jul 2025 01:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332728;
	bh=06FSA2GbRH98qBYMSlW7ZEdKQ9P2SIJ2zTS/zEFQLdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BCY6Hm/T0dbYzDdaiHAMtu+V3a+qYdklZhdM4pQtlMQETD9cpqMowvcJ2epuynOZD
	 67bkV1roMuUexBdkHfzJTAMEn6ADH3Hc/zuOdrqXP93ppXQC/hatbxLQf7rB5gk1H0
	 6RN76bGBkLmkzCWWDQPv0qYkaCAY7w7KcDCpZDgacP1/K4w5oNNzZE1BzH3mYhSDA5
	 N3tQrlesX2SAwQ5C5z+XALhGGg4N6UVxeNZxOgxAVoNuWF8VEWLWXfBK/+yU1lVbOo
	 wkw2CbAGVnKf1tzdcTM+CrffnJEerCup7Im74tJFZ+qRJBp6HNbOzGjFFj/6kxZhF/
	 knWis36TGcEYw==
Date: Mon, 30 Jun 2025 18:18:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Ayush Sawal
 <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Wenjia
 Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] net: Remove unused function parameters
 in skbuff.c
Message-ID: <20250630181847.525a0ad6@kernel.org>
In-Reply-To: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 10:33:33 +0200 Michal Luczaj wrote:
> Couple of cleanup patches to get rid of unused function parameters around
> skbuff.c, plus little things spotted along the way.
> 
> Offshoot of my question in [1], but way more contained. Found by adding
> "-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
> skbuff.c warnings.

I feel a little ambivalent about the removal of the flags arguments.
I understand that they are unused now, but theoretically the operation
as a whole has flags so it's not crazy to pass them along.. Dunno.

