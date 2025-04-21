Return-Path: <linux-rdma+bounces-9631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C0A94F0D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693C07A70FB
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5525D8F1;
	Mon, 21 Apr 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="poLEOiys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BA19DF99;
	Mon, 21 Apr 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745229059; cv=none; b=GbzixC7ED08w/YfyrC9q2BFK6b2tuu7ngtdhGxjXYNbIsoYfpJUIW2WOOlN7PAY5t3IZTd/rKVruGESw8/eLOPc2DpUZiXKqiVxjS4c2PVlldNo6XbYbmD4hhQrGQ/45w/xAIAfAoq0g8fxTic7AjXnIptD6CV+9bAKb0binFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745229059; c=relaxed/simple;
	bh=kdyTtW+aDnediSAQNm+CqqexrHdwy9hwbT0UGQq/mBQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=W5su1dQDNg6NPGXr7Fx5A+DUQJr7JGMEmyg+IPHjATzRCQtT50yheWeZKySb1uTF8s2goZ5hObzeaJ5f42Bvq7RVTP8RNjjvoubLv+Jy3C3GGl9WUwKZqO0a42dWNH6EvxqfHr/a2QVxS3D55Rvmn1AZ3kBRGE921Dw5ITSpcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=poLEOiys; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745229048; x=1745833848; i=markus.elfring@web.de;
	bh=kdyTtW+aDnediSAQNm+CqqexrHdwy9hwbT0UGQq/mBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=poLEOiystaKP6l4B5ifvr/g5kpozWZPt8yBSSkGM6bTI6r4bZyUzIcyZTD6BLOXd
	 onJ2N3P/Kh+pekCzcGPCc6LgT0fSmoh8klVL0SEQrSOK+geDHCBWTKgJTrfqApwB7
	 qnOwuIuuObHbvdki96rcWHeFGAAdy3cJcY2V4Y31HfuDK4QJeQQQ/8HuMoKwUuxe8
	 pk1fB1cFECzjcKL4yQ78h7opJ+CkY1t4Y5ddgiXQR2MIuGEUFnI4VD/jgpdr3l4K1
	 FYHHGUuxwx/1gROFAYHH2fmwfFUyWdxC20k76QFK5hp3OIZby5lnVwkYn3DpJ7lWI
	 BsqPQ0IO6PFsmIYsWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1uXZyj0TSb-00IrOI; Mon, 21
 Apr 2025 11:50:48 +0200
Message-ID: <834fe207-523c-42ff-8a95-4468a1e08b46@web.de>
Date: Mon, 21 Apr 2025 11:50:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <20250418023814.71789-2-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v7 1/2] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250418023814.71789-2-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1hI6MGondi0rfkI/QZ68cl7X8ZsCcgBewfSi6cWw16MOPpZRn6B
 mrR80XaR2wZDoUEZAtv8xjLbyH/fQbZzWnS1+Rgr50yGPVnEQnT6idMPCBqxHleJU59bPuA
 veexEo19cEvlMkWZrYvyPO9SMitvWKfSl+GxLBmBgn24AElmo4O+CBdr5ISq75V3pP36Bx5
 lq5tn8vkAhVr6l+StgJNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M/lzPykxPFg=;iM5VFp+xB8rXo5yUzWFMNzuo8dv
 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

> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.

* Can an other summary phrase variant become more desirable accordingly?

* Please avoid duplicate source code.


Regards,
Markus

