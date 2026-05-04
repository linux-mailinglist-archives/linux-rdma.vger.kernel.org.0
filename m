Return-Path: <linux-rdma+bounces-19955-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKYZLkcU+WkY5QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19955-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 23:48:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33D4C437A
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 23:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A0A301C8A8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B5366DB9;
	Mon,  4 May 2026 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adKnOEFo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40501D6195
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931329; cv=none; b=dhajcBhX5cALMyoyWHCkkdZROES//itbeRvFGSTW+BM9l9RHgGgmH4GT/f4EfRy6cc7GGX9wAn56/cvG3bQNJdTf7RTtIZ1KCjajJ2Y3r8dMASMquKCxYBfE7L7tpmjbNI20nib1Q7yjgYq94B1nQ1aFjO54fUQYWlSYtAoFQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931329; c=relaxed/simple;
	bh=LEfOvRpQYcrDqT5+S4ih49Shh2djX8a2POcizZgtyEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPcS2S8Swk1kQHtBN5AD2/4Ftj2timGVRTvoq9nlD2Fi78kDmozafx9V/yvf0HnrZ3PXcvKmiVX3HY2XbPfYiB/qOycxMEwlgyjdWNoml+Vai2ycul4qXFWr2JbrKnavLQKs8g7kCdYp/AjzOJdP7aLTcrncS+44rV3a40YnL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adKnOEFo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9f316d68so18105935ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777931328; x=1778536128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vleGyxmKxeO4GNIP1qujBMrg4IEFuG1bs35WPUgfDlk=;
        b=adKnOEFoXz8qKyDlRnCzuv19P42xuHX1j5IMWit1iPOaACz58vLrro7+KtChAqMHi4
         NN0kxyh6ALYhlQPMtHP5elg8BDhKa/STk1m40G4b1+uyyDWrFybAu4s0AKgUWN+Iu+gv
         7drE30Tz3QjQmQj85S9V3p9GxoQd1iJUfjXgMZAmOYsI+0Sb76almUULwwTvJk+ZOfo+
         vJynjbc3R+DgLb6ACaqfjvG62vFHcwsZ6Uv+NEVai6jqefs3VdFCDonF83jqLhSAabkN
         BiK3rPc2fD6Gva8X7ep67gmyVKygxwyPymokKyKyPqKDCQmPUQ1yxsQ5oZHhEakGEH/q
         8ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931328; x=1778536128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vleGyxmKxeO4GNIP1qujBMrg4IEFuG1bs35WPUgfDlk=;
        b=ULb3IDjkhLQDJH8HDSPw1ADwSITBtYM6AVf+SIIm7ldK6KdzI+NFiuCD96Wf3zRdv/
         EC8fDRI+0lEzo2bNxxZ5rhm5yWv8B3/7iLELn0/dGp7WXLC83xnwN6CaThGE+iix++p7
         2hACUkTQl75VdCKngftkhUHLuncJ/nMk+lh0XfZbe2SMbvU8Lwd+ZFMifHlhEIVjbhwg
         s+zDjIcaWqnp59NcxiN8+50P0XY9JyR0vmvVVIrQ+jHGWBc6hoVoE/lwZ7Ji/UMvykUh
         X1W5TU+IwW+uShMasAyMcerYaq+fR1GzHq3elyDPgcpIUSh8oMCXhASSZVUCCG/8tysf
         FH9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/jTgoPYHLO/rjgiSoaAC9bnCcZgeWfxWzBLSpfBHd6xHgq3ORLSTw2raH5mB9m7lGK0b5T0qQqWQgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAihS81EBNZ4tajYW/qsuOiYQ82479Hvcc91I55eL+9MDzLTI
	KRfEGURXXMAfnNlbTC6Y+H2lIJdxcygpjIj10549s4OOOKKc0InvcpWCeOpyCbKEvA==
X-Gm-Gg: AeBDies7rsMjy5DNO/ZBiiuajXxK7INb3OcNTl4bQ9gGOfe9iUiDlI343zvv5tEp0qa
	sBl8eGSzd9/icXWFHXXk25TkDlJDZC1rIbr7xZ56p71ZxeYoYlBf7vVcTlnMlGRKf6qkQ6qdXWf
	eics1jAs7Olbr5wC2qQIHWHSDh508kX5z54sqYg+aqHuEBGCcetWz9ohDTXC+OD+6bt2tQwSSGe
	nqvgjfPP1vuI8wlCgzeAx4OJztSFxWVS87ReqKs8nluSefNPGh/RI5WlQaN0yL6taTszXSBVl5i
	2htv1bfN2svapjF7q5gBjDYTvfpBdp8EvzsiGyt1K7S1d3gVtqDzb5uva6fEDGC8GJoOHmmJbCy
	lJA6o4t2eZfxKernUXIMLPx0NlGiw9U8IB6uIx9dnCz7RgSZkxr0gnZ+1ZE9go+yoi0sfHNI5wg
	ft2rLIWbwJ+pRZGlF09AtRsMryv7We3jODmeLobjULjIvkyu/o7Xq/70jKyayk1gb3U322iehpH
	6pPjw==
X-Received: by 2002:a17:903:40d1:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2b9f260b4a7mr121673915ad.30.1777931327578;
        Mon, 04 May 2026 14:48:47 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ebc6sm115903505ad.5.2026.05.04.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:48:47 -0700 (PDT)
Date: Mon, 4 May 2026 21:48:43 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <afkUO56H6KPy5afA@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: 4B33D4C437A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19955-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> These are needed by the VFIO mlx5 selftest in the following patches,
> which includes some headers from mlx5 and also needs a few more
> MMIO-related features.
> 
> - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
>   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)

Is this needed? I don't see it used anywhere.

  $ git grep DECLARE_FLEX_ARRAY tools/testing/selftests/vfio

