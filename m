Return-Path: <linux-rdma+bounces-10801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B906AC5FEF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD41BA4762
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CD1E1A3B;
	Wed, 28 May 2025 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUtdmK2x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2E12CDBE
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402240; cv=none; b=Jh6DQ5FAgzEbBOh2GmMfCnr+sMbDXAorMZjNfAyHoXsUrtqCUYoLgadJl6r18aThzHd6IiY8UYNA1BXtgCzgm3pTZvw2ydJcqJFDCInYc3e1VA5kV0WzZr/5r3U0/liIi8L4SSpZ/9zSuI91XmFVGx/kWHJqz2sfaU7rszA3mJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402240; c=relaxed/simple;
	bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeGN6QaLJmje6nSZHiVSNiAcjMqlS//AWiAiqFdHigSYZ85NwFrSgMTypAIRYgVNmaliXhxgnLsncEBgGCIoIj3czpyp9/xgGI4c8snFHNsXcRJF3uTmYfu9fcrIPU6fmn6EbaZ8VJL6oSpu63prFbivCASVyQeBOGrT8fJnfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUtdmK2x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2349068ebc7so134715ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402238; x=1749007038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
        b=AUtdmK2xipN+sZQV7Qo76/sOfDnoWKgEgP2v40hWsmGmrGxbr0cc9D7EiPHGOS0cXm
         Wz7EMFD9xV4B3CEUWPGwsIjks/X3EGkJcQql3y/mdnouEwwiaEh8hbthGBlwH2hF6jCP
         75Xr/+7z67Ad+8aw1BqRB7LxgGX7bcnc399qs4I09LOw+fhcU42bGj2mcluoqmaSv6wD
         +CsOAqPniJcsIMR2WPzdtjvu7sk43omgmglDfG3e/cDRk0YGqqAIGIAWRjNNbmhmNe5c
         P2aJH7/rRCZvSVi61dAQYUsgqd1vtEcPXsWdwMFTir3OclYupZU2USsXwEdmlPKCTjPR
         w2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402238; x=1749007038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
        b=PZOOFIfbvn5pysZ/NutH/cReyVhbm3QvM0C2CbzAZ5PsnU6JH0+LZnQILGT/TMDQaM
         lKJTAF38bDOS3Qy4k+vXH+qWhuu2NjW0VeD5JY9JJMd2/bw6dCl0ALXs9qPSvcaUtczu
         GGwb8Z9RY7YbhVFpULMQmkTKOn3DMDOz/ok7lWLttlO8NnXNV8IsAyom/I5vYZqOrKkv
         mE4bP2fkr5iGJG+dSUMNK/ikG+SWTCAuElZVd0oEEGsxfdFu/kZU7rpW/L5XhUbzagni
         uW4zYQY51QjOyz3/BS68yYnfEjHAc5Hs50tvZw1ahoblehEkHmPAZzJU/FtFrL5qmReg
         lKnA==
X-Forwarded-Encrypted: i=1; AJvYcCVcTsQdlqSmhNpnyvNJ0DJTR7oDBqdPLir1qgFi519DdrT8vGiENHaxFZY6Xr7xKnumLn7sOR3rj9bV@vger.kernel.org
X-Gm-Message-State: AOJu0Yykb5tW3D963fRMCQXX0mQp1M/JmpB+IRbq3jxDQp01TTcU/R1U
	7sGbGpl9WlURSJ983AE+WtncIjPOZi9LPO5svwoQHQOZ7N2YEvUOSsiKcdFpwxBInhZg9qOodAR
	n9/QcUSOcdF8cndjgxrihhEN1pjZIg8J6o0XEUdv0
X-Gm-Gg: ASbGncsBHf9+CJxwQ4e9zQ0feUWmORnzDqLPwgrs8qnmgVVE1A2AYsQt25BK7FRdyDi
	rtEWJtjyIVKcojmi7zcNN5Xl+YSEtGtA6vlwTCzjDv8X6cOWHEnctOlTgPsPccG22f/F2my5TtP
	EPbzkiPzfFJr3iNyWJes0RrLNxvPOoA6OONczrEqn3Y/7EkuBp9xPfpzg=
X-Google-Smtp-Source: AGHT+IEnczAUe8aSvzmzngQXQGk0N5lF0CakBmamAAAHOTmJuCP9XYZrHm/qfHgB3Xi0bVS+4KeIoprZZQQkQB9JjsY=
X-Received: by 2002:a17:902:ea0b:b0:234:bcd0:3d6f with SMTP id
 d9443c01a7336-234cbaf560cmr1132885ad.1.1748402237697; Tue, 27 May 2025
 20:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-6-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-6-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:17:04 -0700
X-Gm-Features: AX0GCFs29uDSGIhRSaJWQiNCOlbuHKz4cCZioyPrXBBoYFAI3Cxm46scEROF8Bo
Message-ID: <CAHS8izOVbJZfS0r+A1Pi_ZxmrJBfUBZR4fApbd=GWj0AFQ8vcw@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Use netmem alloc/put APIs instead of page alloc/put APIs in
> __page_pool_alloc_pages_slow().
>
> While at it, improved some comments.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

