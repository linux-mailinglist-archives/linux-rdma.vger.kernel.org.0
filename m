Return-Path: <linux-rdma+bounces-17154-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOVZHj/wnmnoXwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17154-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:51:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8B1979E9
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79AE530160E3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C183396B68;
	Wed, 25 Feb 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPfNdIYM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0F395260
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023868; cv=none; b=KrQA3EwI5nLCSOVp6fjJ0Z/7iOpHqS4a1V3ui7nKo5aF0xqzctLRNkaMdvRoPyHd7WJoAT6mu9dnjvnsFNp2CAzEtdHl+ITwPSHH9tc//ACn8rquADQa5w7bxH7OaE7ywDedPC3BrCj87EKW+ZGJHjIDmCvN8JhCuyN5qeuHY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023868; c=relaxed/simple;
	bh=5yDvrH6oHX1X01Fh/OLMqi2I7hCj6AQ8yeMSOLnTmH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pt08YZvllnAa1aj0y1czLTB0Lf6umXfDq9TG1sWMBCTA61c0UVlSRaspCmoN0+EfEUQ8hHS6zE5iBDls2cZeP+OiV+sl45NFjru+O1xW/vFmQnJRtWB6WEtFpPB9NYU2ke+kvwCL8TEdJTXzEByMol5tzeaNmsUxmF0ukXaRYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPfNdIYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13269C19423;
	Wed, 25 Feb 2026 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772023867;
	bh=5yDvrH6oHX1X01Fh/OLMqi2I7hCj6AQ8yeMSOLnTmH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZPfNdIYMu9pf7cxsCxU30bAjvcX2yYjq/j725Ba3B9FcKb827tAuAclIzD68XbDhw
	 yMbfD5k3KDtVO72P7/JSC+Wje4aeEZAotw3mvLOK2DGnmaoOKR704oIo3sOJaTNzPb
	 2Y053WwNsrTDt01DazhyO7FUK/ic6+rQ9K7TIlk1poFpLivVabXNF8viw7XsPQ68qp
	 2LUeyx8k4aBMBjs1Kp/r/eM0tSde7Agj7hRKGdPbzAeFXI7FfDeUcugMEzeGgxeFGG
	 IgA7GZWVYwjG43sr+TC8jD9ssFXvnRbHX/G+PiJGUpzd+CLbqpTRi3FsyDk8x1+vsu
	 FVXEkyR0t71FQ==
From: Leon Romanovsky <leon@kernel.org>
To: galpress@amazon.com, jgg@ziepe.ca, Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260224234153.1207849-1-jmoroni@google.com>
References: <20260224234153.1207849-1-jmoroni@google.com>
Subject: Re: [PATCH v2] RDMA/umem: Fix double dma_buf_unpin in failure path
Message-Id: <177202386448.50295.8343357605381519811.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 07:51:04 -0500
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17154-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFA8B1979E9
X-Rspamd-Action: no action


On Tue, 24 Feb 2026 23:41:53 +0000, Jacob Moroni wrote:
> In ib_umem_dmabuf_get_pinned_with_dma_device(), the call to
> ib_umem_dmabuf_map_pages() can fail. If this occurs, the dmabuf
> is immediately unpinned but the umem_dmabuf->pinned flag is still
> set. Then, when ib_umem_release() is called, it calls
> ib_umem_dmabuf_revoke() which will call dma_buf_unpin() again.
> 
> Fix this by removing the immediate unpin upon failure and just let
> the ib_umem_release/revoke path handle it. This also ensures the
> proper unmap-unpin unwind ordering if the dmabuf_map_pages call
> happened to fail due to dma_resv_wait_timeout (and therefore has
> a non-NULL umem_dmabuf->sgt).
> 
> [...]

Applied, thanks!

[1/1] RDMA/umem: Fix double dma_buf_unpin in failure path
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


