Return-Path: <linux-rdma+bounces-10802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E5AC5FF4
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8381BA4994
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701941DE8BF;
	Wed, 28 May 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKWeyXcV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44F79FE
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402301; cv=none; b=DCAdLP7LkkhJ3DKqJRZS1ZZcCGCmMampjYW7eg12mmftJgxIE0mH1oTP57sRn7Kk7n1MC0HrCASPJxpPAcUfownQjCkbrg6Mcd8GDcuuRB9Y0rYOM1YT9KkAYUqCvyg4QgxXPhrZKcXpzHx6tMRw008TV/U5Qzbcu4/oxIEqw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402301; c=relaxed/simple;
	bh=p0o8H/ZWP5ajJApvc49pdLseFqRSuUwEFayifU1/9TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLDZLhFKht/KjdwJRegVUe3/QPBfauHhautNz1XsOrNDhMtH7OodrIkRBso9WlKVkmi+ONfMw7vJqs6F7Ct4dSRKG6OnN7dBgyHwkwJAVHjn4pqUdJHYHWLJjoVF6rw/RWf4Bkn4HEDD1h4U4+fJaD+ovJVUbj1HsSvC3+shjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKWeyXcV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349068ebc7so134825ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402299; x=1749007099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0o8H/ZWP5ajJApvc49pdLseFqRSuUwEFayifU1/9TM=;
        b=tKWeyXcV8oOs+KloJ7e/InmbmldtWw13daPs2ZPSgyoqOiBmiqh/D5edX0e11kji94
         V7fs3TEXa7t6jSFckZ772r/ck3dKbrwzwS1kgxHAzveHubzMbNEn3TPj0kJxhIg0Ukzc
         57EDiJNKcHDzMpMF8+bHyY4Q2mTYUPTarM4pzAsQGesgelmhzscUmYqnDE2PccGTKXJ3
         v3phCkZvMmMnMkRb5ifY1J/MQjANNpPTnnYGgG5pOt6pKfpD4TbRBVruCS18pvqzSecw
         51ePgPWk20yBx+pERMOLQ8aljbc3mtncN3bMlKXWa8acnsgPiGADIOdgIQkKK6nzn29f
         swYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402299; x=1749007099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0o8H/ZWP5ajJApvc49pdLseFqRSuUwEFayifU1/9TM=;
        b=X4VICbYyHTCEaxdvu7HbnyaYWn3FLStu9tnAXRKEZshAGDNM8Ir+79RrSRgn5cRbry
         hRc4fNwYXDh5KauFrTPUIE8RkSThv5L8ZF2A0LkK/+lgAANjGX7RZzwZQqy9zSFgrCv8
         ZGH/Jt98XwPGW/KpQvKCUaAV7fU74F4IclgFAbE4WUca3N2AzCxCZNnKApv8dZX4jEzi
         fD/xUxVDZSV4eKLiE9/y5AXBdXe7xEt7SauS35fA5cOElX0vJ5l/o21qJa6eX2OlCTLB
         jBvPXbEjQjAKb79DwUvUeQ41kACz8v27Oe4PN4U/duIFcjasJ0lo7uYlcqlPUIgyuHE5
         IpCw==
X-Forwarded-Encrypted: i=1; AJvYcCU2CXqkQIz+0u09iwKhB+RJKO18/L3oWNyUoEqmxN0BuGRLWlZ4S1A4U78DNTGYDRNb3VrMfHkP4htZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjCZYdmcROLnxMsZDp1aUB0CJ57uZ6LWM/0NFM0PtjiZf02Ym
	fW5SyZ/ktuFfYvQHuY987vgM6sY+fprrfngCCTT3liMxsEx/430aD+/AuOkmwvUzG8vQ3VGizbb
	EJkCltk/cCw7IhYJ8GzVV4iU2OZQg2cx1KpjxD6Ws
X-Gm-Gg: ASbGnctiTZJZ5Uyp2EVyKaE3iHGFZp/k42xsY+ZjV4h7WR760O2Rn40WATQtXPwuv44
	htnfgC4++mlsGwWgegbJB/DeAuiVnBIVfz/vZLalv3barxH0kN6KXXmK19rr9P1whxlN5FpkWOH
	fxSoQYB554AFO0UgPUr6GP7IQpZ1zZkVsfr5byFC9aM3P1
X-Google-Smtp-Source: AGHT+IHyBASOmSpQ6jrt38akPkcyDz5ZPwdAwA+jYpxd9Nbay9v2Ysdq8wuVjVilze9WFqafdNaHLI6g1ELAifk2Rao=
X-Received: by 2002:a17:902:e845:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-234cbe2892cmr1015255ad.13.1748402298919; Tue, 27 May 2025
 20:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-7-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-7-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:18:05 -0700
X-Gm-Features: AX0GCFs9-vI-xN4yFg2bdl4ceoAUrTj04uXSI8vFV9kuA2D-mWZq_A_MtCFBCAU
Message-ID: <CAHS8izO8fqvXV2_83MVLCxo5z7DepRVaPWS6rymqputuhcrk5A@mail.gmail.com>
Subject: Re: [PATCH 06/18] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
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

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

