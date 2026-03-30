Return-Path: <linux-rdma+bounces-18782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA40Ah9TymkQ7wUAu9opvQ
	(envelope-from <linux-rdma+bounces-18782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 12:40:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91849359886
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37C093035896
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBB3BADBA;
	Mon, 30 Mar 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoesIubE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F13B5840;
	Mon, 30 Mar 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866857; cv=none; b=qhP+mDSvia5lcY1MwDLi5WZWVtxk4QRIEgPQ/nkplX8Uf7B16SDPYVifwF/vn/1z7XtQ+mf/otgry2YDW++GPNjG09nCMTsDj3TDN65XLSWoqUq31QdZF0tQXglbyKRsO3wqCKifcGSx5ko3wgh1YoZJKter19p4FxuqZ4TnToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866857; c=relaxed/simple;
	bh=sLEC/t54ohP5GpB79TBB7Jg6jk+rDwNg8TUVbkY6P1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PsFXRjooclDLCFvAoNCkPJTKu300qPAwCIKLkxwuskn5Fpw170rClCnln5w9n/ipFVNomXq4PbhQXKmHnaYWbcAhXH/rWKTUqKP4B1euFfwr4Re0D0icw7ZInQnsqKJZdcysIkccL5qLHUmW8pq3HYUW61HkUtSqkwQXodMoZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoesIubE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328DC4CEF7;
	Mon, 30 Mar 2026 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866856;
	bh=sLEC/t54ohP5GpB79TBB7Jg6jk+rDwNg8TUVbkY6P1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EoesIubErzTJI0fwv29cuCP7OdiWXEmoaXWU7ne3KZ6pIy00gycbvxBkF/yrrGs1w
	 mY1JLcVZen+XbLm4iFnlcSImqsETSbqSQxb5Q2CQZteaJkR6d3iJic+UMdrXzakuT6
	 LIxfaYg7ae6y4OSXHRtwq7xFSDmcdJ7/bHsdqrh8/m0l8842kKkIUkN8Jp6gEnNJDJ
	 ZPxUekfXKcZIWdREHU3MVdIiZ5wrLiJFKuXsTWgqwgIH88Yk0Buk2eFV5Xhe0BL4AQ
	 RiKswwX7t/ARPFUYIW/ziRoY0uhIzXH2n/dSoBjg45JiDY48HWYPxx+tDJOkbKonFM
	 w5vDEgnywA+0Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Guralnik <michaelgur@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260323-umem-dma-attrs-v1-1-d6890f2e6a1e@nvidia.com>
References: <20260323-umem-dma-attrs-v1-1-d6890f2e6a1e@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/umem: Use consistent DMA attributes
 when unmapping entries
Message-Id: <177486685365.3787384.18151233008605317373.b4-ty@kernel.org>
Date: Mon, 30 Mar 2026 06:34:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18782-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91849359886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 23 Mar 2026 22:10:18 +0200, Leon Romanovsky wrote:
> The DMA API expects that mapping and unmapping use the same DMA
> attributes. The RDMA umem code did not meet this requirement, so fix
> the mismatch.

Applied, thanks!

[1/1] RDMA/umem: Use consistent DMA attributes when unmapping entries
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


