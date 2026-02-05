Return-Path: <linux-rdma+bounces-16578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPU4IdSShGk43gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:53:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87003F2D7A
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0B9E300682E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD43D4113;
	Thu,  5 Feb 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKOaL5ZA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79C3BFE25
	for <linux-rdma@vger.kernel.org>; Thu,  5 Feb 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296014; cv=none; b=GmtnCLzAWVu4Bt7ClnBHabsNLrrRoP6ZZrcTTdDRStGCxELZQkhOHwkskeKdTeNFDrauT+DeGmhmjLiHP4KVXAU1Ve6tFkarkUZFVQVOnhCFcUP5wfMs2mf2k5Xhpeng9P7nDfnlq6VV30zS8VCziKlb2L31/GzEhPnBwQOiHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296014; c=relaxed/simple;
	bh=sI/aDC3E3FWKW5N8Epic65ns5r/w6vBS2C2aS+Ovq8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IP/hNRZLbGGmKXLRtzTw6/tebMExx/f12wZwtSWW9RaHT8R3G3qTXm0mXqnow0DeB1fh1iDpv+ifMTo7L1dpkzLRtKkJKDodmI+bKqwP6ogp67U7Hn2Z9xZ2n4q1iefDbPcgvizxiE6+v4nhAubWLGOBnLBqY+X8Abo2o8ZBKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKOaL5ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCA4C4CEF7;
	Thu,  5 Feb 2026 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770296014;
	bh=sI/aDC3E3FWKW5N8Epic65ns5r/w6vBS2C2aS+Ovq8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eKOaL5ZAtAHZ83Idmr2twAohovMDTfKQTZmsqNvlSnh4bSOkcDIu4WOBwEVzfcS4+
	 HKSD9L6Mu0l+FmcH4Y/O1LTiTgB9aTcNrgNC3caHm6Jl+Osq51syMus8HjViL0TZBD
	 Y8Kr2A8Dcr8ZJ6sDI9ReGXphkfpuBjViAPIHFLzQ45WdFqhnUQABnZ1DmEYEdYr4iC
	 yrgOkRo/8f4UHq4P6e1OOzNJSGikJh/ZQbFg48VEyiXPkDWCJg08NbomJMfwizgCcJ
	 bilThREx9B9x+ovSnKtL/6rHDyt4xtcGu/RIrjVRIdKYTkNAgIpg9r/3bi/m9TBbgm
	 Q4fbQjf2DWI8Q==
From: Leon Romanovsky <leon@kernel.org>
To: bernard.metzler@linux.dev, jgg@ziepe.ca, 
 YunJe Shin <yjshin0438@gmail.com>
Cc: joonkyoj@yonsei.ac.kr, ioerts@kookmin.ac.kr, linux-rdma@vger.kernel.org
In-Reply-To: <20260204092546.489842-1-ioerts@kookmin.ac.kr>
References: <20260204092546.489842-1-ioerts@kookmin.ac.kr>
Subject: Re: [PATCH v2] RDMA/siw: Fix potential NULL pointer dereference in
 header processing
Message-Id: <177029601179.954009.17261371577867393713.b4-ty@kernel.org>
Date: Thu, 05 Feb 2026 07:53:31 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16578-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87003F2D7A
X-Rspamd-Action: no action


On Wed, 04 Feb 2026 18:24:57 +0900, YunJe Shin wrote:
> If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(),
> qp->rx_fpdu can be NULL. The error path in siw_tcp_rx_data()
> dereferences qp->rx_fpdu->more_ddp_segs without checking, which
> may lead to a NULL pointer deref. Only check more_ddp_segs when
> rx_fpdu is present.
> 
> KASAN splat:
> [  101.384271] KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
> [  101.385869] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Fix potential NULL pointer dereference in header processing
      https://git.kernel.org/rdma/rdma/c/14ab3da122bd18

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


