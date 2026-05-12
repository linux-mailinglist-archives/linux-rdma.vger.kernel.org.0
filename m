Return-Path: <linux-rdma+bounces-20486-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOrXDcQxA2oA1gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20486-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:57:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD05521CA3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C2EE30A2B5C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A757D39D3DB;
	Tue, 12 May 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOIzxd8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E639AD4A
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590705; cv=none; b=hsEpmmFDDgtEiEXJ+lizaHeELTRqAyW7VF0EI49t1vrrJW1Uwq1amdIwkccExN+QAYKIIYd7MMkJRKjg/K+I6Mez45PGn/J1fcQfaDcPsFh9kL6W7aMmPZdhdOe1eYRbGZVGKjXK9AVpCFzjwL6tvAE1cVSoqPmDYRqxU6mbj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590705; c=relaxed/simple;
	bh=pLY3GB/npkRWavBDYzVZGZTO+VbOpmmXpr9lI4mz4fA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0cwKn04qsigOZs8n9O4zgfEzmYwVY35r4JuPNeRyKQZariaXaKYSYxFXcAgEI4KmYoS9calesniQZ2Kg+CsC8emr2F8pjBaNQ+1tO3iy/4icoj7Mm8U7jjGfQPGZ4sQ89HKoKBhavplETRLvQWkK+yrUDVexnLSRAHj5D6CD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOIzxd8M; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so3685575f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778590702; x=1779195502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDWMnr041UI5ryil+k7XvoK/2F/EkGtTQwaeX0kDxi0=;
        b=MOIzxd8M06jLqZdVnSSn+fl9/YjNb4fjltt3R3ync0g1aVCwi8YsgnwqqEWpVN8yDC
         n+OZ7ayH7XM6XVwBPjR1+VLhNblCt+0q//YKBpjHER2l7IYfYuYOOxQ7f8ecykI7F02P
         qkpSKl184Vd6WqziVquto1rxJ8hyAXM56pR5oWegNIdo1wSO0nnxkzMeh/4dD3Wh1nVf
         nooc/ABS+gZVsfESPEkewzYXTezcopIVf1niMTLkEcyFxRmkfrARRbeksuYo94w0359A
         VfwaoWUawNdMkdyXjfVfZJEmZG/iFsEiRQH/30Eqo3ct21ffxyFsmlAAXOItNxt9+WeH
         W3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590702; x=1779195502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDWMnr041UI5ryil+k7XvoK/2F/EkGtTQwaeX0kDxi0=;
        b=A1eDa5eqwIbNEq4NySnAXHSYAZmLfgNomem5ez4iV4fQ/+OtZPUJ/XzpYS2cQ9o40I
         QJUVXwfdtfG8+Iprt7UocwHALNTJyZS86eOAISgoIDmXlZfRyiCSNW3NST+cQGe/oEvZ
         sZAgM65EtKgEYuBNyaHIcVOk/UWNdhUmAv5wdc4yGIuVnKAjlUQY+yzws4HPgjT44JCB
         Vsx4nyc7/6d1ONQKfqPO88uo2M9YVmySqMKsZesicVm/niiQSGYOKxcjUnfEOqXAMYI7
         tDXVBB6v2MKn5wZuSZT5/mEwNWhSv0aY/2Ehp1m0wmqg8PdyNbuhVxLFE0djn6Wi6fEY
         hLTA==
X-Forwarded-Encrypted: i=1; AFNElJ+VD6wvAObMDkHY7SpVeFEji7nTqwY/6uKjJMh3xUKvTD6aqnKfbXgyaSFTzQECQhq4GgEdy5xo4XQi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ntci78DsAHCcNdgiEltE2xhKmSg7HzBymhFWjI2scMyFz830
	BDeqH0hcV0M7w0mKGE4oPWpIjqhdQ031xiakpv/H8zOeFBa36Pyww7jNv2PpGAW+kEOPMh4XdaL
	pdiRedP3kev/zVQ==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:485:3aa2:da59])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8010:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48e70687eabmr216165565e9.3.1778590701567;
 Tue, 12 May 2026 05:58:21 -0700 (PDT)
Date: Tue, 12 May 2026 12:58:20 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Allison Henderson <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
	<linux-wireless@vger.kernel.org>, <kasan-dev@googlegroups.com>, 
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, 
	<rds-devel@oss.oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8FD05521CA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20486-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> This patchset used to be about switching gfp_t to unsigned long. That is
> probably not gonna happen any more but while writing it I found these
> cleanups that seem worthwhile regardless.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Changes in v2:
> - Drop gfp_t changes
> - Add correct CCs
> - Add minor fixups to preexisting code spotted by AI review
> - Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com
>
> ---
> Brendan Jackman (4):
>       drm/managed: Use special gfp_t format specifier
>       iwlegacy: 3945-mac: Fixup allocation failure log
>       mm/kfence: Use special gfp_t format specifier
>       net/rds: Use special gfp_t format specifier
>
>  drivers/gpu/drm/drm_managed.c                  | 4 ++--
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  mm/kfence/kfence_test.c                        | 2 +-
>  net/rds/tcp_recv.c                             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260319-gfp64-7a970a80ba4e
>
> Best regards,

Hi all,

Any chance someone can take these?

