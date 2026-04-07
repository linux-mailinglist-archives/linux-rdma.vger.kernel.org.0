Return-Path: <linux-rdma+bounces-19071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL5ZLMFb1GlrtQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 03:20:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FDA3A8A7E
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 03:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADCD4300AB22
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60C1F03D9;
	Tue,  7 Apr 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TltX10YM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2F2556E;
	Tue,  7 Apr 2026 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524799; cv=none; b=MEjtA2QzDd5k32e2TVYHnPqdsavmd+2qEY09ryBvN5lzooNQEX/LUPqq0oGDXOLTOFCzgtAUf4ekd5Jz4eYfAFIBrXQAFXs+jRNiTBCxuv7SgAEZ7KQWyt4hy5qGuxoIrvrIlxuXiPjzabG/Gxm782W+Sk2dCvpEyYb5/rSzzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524799; c=relaxed/simple;
	bh=PLcLg4WwUSV/6I/ub2ZtYdVWKpfYp+2/iJXwjJKaZ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOq2f/hWq/2eESQKWud66D/VhJyX7xDmDvQayi1pdb2Uy3qHNlySbYMceenyxH2KCMi2yUb7IbM+HKCC3Ir9NMUQe8zLQs1IPU1NQKBfldNmBSbQSnQ89oQJlea6r5/vPymHCf+ULDG7BHWGLF/Sa671UnHYpbyKg0gJp+7Iha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TltX10YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57285C4CEF7;
	Tue,  7 Apr 2026 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524798;
	bh=PLcLg4WwUSV/6I/ub2ZtYdVWKpfYp+2/iJXwjJKaZ8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TltX10YM+P3/+/lElWXycvjj3cmY/Og0mpBZSG39/fhyTkQVTnP+Upy4R4A+PaoB/
	 MZon6TXWwgmtY+qVNI92GRHFt5YJSA+D7outKNMQ9AR9Vn7wFqMop2KfAhskfa4nIa
	 yrxaNKAindt/rtls21MOquOEaYawnv5lwVLgiy3UcMW9aJPdsqssQ7ynDStiRpMapr
	 II8HiTMimleeidya3kvWNKpHvmk0UfK0g+cOatyxFI3jJ547RpfIglCprpAxD6O3M1
	 zTvQ1FAgLhFN4zHZWHzu39c6HjX2/WH1gTqvKtz41Ad5TkJ6kwPAta93YO5CQRZ2i7
	 E11hz6LU7te0A==
Date: Mon, 6 Apr 2026 18:19:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rds-devel@oss.oracle.com, horms@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] net/rds: Optimize rds_ib_laddr_check
Message-ID: <20260406181957.4bba8580@kernel.org>
In-Reply-To: <20260405041613.309958-2-achender@kernel.org>
References: <20260405041613.309958-1-achender@kernel.org>
	<20260405041613.309958-2-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-19071-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 48FDA3A8A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat,  4 Apr 2026 21:16:12 -0700 Allison Henderson wrote:
> From: H=C3=A5kon Bugge <haakon.bugge@oracle.com>

> Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.=
com>
> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> Signed-off-by: Allison Henderson <achender@kernel.org>

Author's sign-off missing on this patch (I sent out the AI reviews
as well, without looking, take them with a grain of salt).

