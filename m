Return-Path: <linux-rdma+bounces-17114-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMLeL/5/nWk/QQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17114-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:39:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A802218580D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43C39305AEC0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2795378D95;
	Tue, 24 Feb 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evZFb7Jk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E737883C
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929588; cv=none; b=muc24NG32lwy1lPAjU8xkO9KlCsuODyxegC6xN5NvvGzHI3NfepgA04ZDysWr6fogg8h92YGYEX7lLd6pX7biCd/v+TfW61e8KB8vJiBze2MwQsyRc1m5pykNdDm1GIBLLL2SttwuFULM0iV7LOVjJlDGfOfDv7RkjTnhcvGPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929588; c=relaxed/simple;
	bh=ZboV9o4AAr6EPA1vRYNUJeKds1GMO5TzXUJHXohaOA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IC9EPvnlGVjnmaa+OCFx03Eip/LtqJvqDfyxQs7qHFPAD0ZUv/dThH531cBqdnMN5XDE6r5ZwFPqHxBugGBEtGQs2Hw10MKIQulGTVNZugBmVgfaAwm/u+uxhUCzdK/f4AyAQNPaPJW2GARxTrrKa1QAKawZYW0ofi0jW1JHB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evZFb7Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36967C19424;
	Tue, 24 Feb 2026 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929588;
	bh=ZboV9o4AAr6EPA1vRYNUJeKds1GMO5TzXUJHXohaOA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=evZFb7Jk9pDdbgEx+YH1c0fYNGi0LBEdOnV48QvGQODsAXHB2o3WLn6y3hEVQwzxY
	 syWxJd/F/4qj3QW6MrftDdm5HSErO9FOLhwjC7aRZud2KfTTOD8d/piT16uXSltGhV
	 cNc6SKXaV87bRY643eQTERSKn+V0PWGRUMItZBU95jdPvgblFLTA95QDXp4YaK/DEk
	 H1zBmMAcFar/8Sp4rx5Mlqq8VN3Yhr2QebH00x2GtgOI6Lt9w/NoK9RtPUf/TmPFrn
	 s9l1LUBZfB3NadQUs0Hd590JtB3ZIVkY9d3JyZ/gFICfTdc9jjDUj+FPFABX23wlvG
	 2j2T1PeqNX7NQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20260224003120.3173892-1-rdunlap@infradead.org>
References: <20260224003120.3173892-1-rdunlap@infradead.org>
Subject: Re: [PATCH] RDMA/umem: fix kernel-doc warnings
Message-Id: <177192958468.751672.7329781340238889549.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 05:39:44 -0500
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17114-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A802218580D
X-Rspamd-Action: no action


On Mon, 23 Feb 2026 16:31:20 -0800, Randy Dunlap wrote:
> Add or correct kernel-doc comments to eliminate warnings:
> 
> Warning: include/rdma/ib_umem.h:104 function parameter 'biter' not
>  described in 'rdma_umem_for_each_dma_block'
> Warning: include/rdma/ib_umem.h:140 function parameter 'pgsz_bitmap' not
>  described in 'ib_umem_find_best_pgoff'
> Warning: include/rdma/ib_umem.h:141 No description found for return
>  value of 'ib_umem_find_best_pgoff'
> 
> [...]

Applied, thanks!

[1/1] RDMA/umem: fix kernel-doc warnings
      https://git.kernel.org/rdma/rdma/c/ff46d139275044

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


