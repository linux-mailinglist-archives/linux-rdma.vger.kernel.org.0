Return-Path: <linux-rdma+bounces-9954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4E9AA80DF
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514E4189FBD5
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7778279798;
	Sat,  3 May 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN0SGWtL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204EE194A59;
	Sat,  3 May 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746279794; cv=none; b=q9C/IDuzjiATGXrt6Pfm9ge2/rwpUJND8WoMhHSdEd2e1bH/fjJbtp0pjG1MlkEyaGaeuccaILTOl18HYu7BlRvks57qr/pgH0lHrRxqtTVoUqWOWVpj/IGzJLqdCJyqgoM4v6+5uuOAbstw9RSh/WRelgJkb5tpxYf4XI4qW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746279794; c=relaxed/simple;
	bh=TksLf5bS4cDwASVoWKhGuI200DaiWyfCbIGgZVlps/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiDUntHd2qL/PRTt2GPOf6nrQv5BYnXpQ+TDdAJFiVbFlLMSaUO0Mla69y42y2ghbXH3StlTLjuSCNr2GvPLbB9KYJvh5wqa9nNP7Hxxo3P0pVQrHIImEOK/QIt4V8MwqktFlZkRhNRg7LaRP6f6VhrtYT+vIG69lETUqJmN8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN0SGWtL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3015001f862so2314042a91.3;
        Sat, 03 May 2025 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746279792; x=1746884592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+aBAE4E5Z6GkrNwFJ7Ke9demvrPPuBn07vQWF3n+iE=;
        b=CN0SGWtL/LgRk3WzDHUeQ9W1aF6SYjnVAoApz++TeW6N4b1rSevwBM/cvnENq0aPzX
         5NaOYWP70+GOpnZk2EjkTniqtZONi2/E75oeWu3gBfx7ssxs5Ty8VykPto96Y629Af1y
         gpKqH/QHq44HPGTJiqYjm5IuUkbrrwYSwkurNRxj6O4A2FyQx7FMQJJKY2dR17W3Cn8W
         Sky1UpBKQcPD7vLRJ22Aei7baegM/OFZDvxygpW0bLQMOyuX70OoInVJqVxlRJPpYQvS
         NVkA6EaATN4Ly80+ICJB8rS/YEo4dCbLEy+C73aHrwsx4pIY6oYjf2Hf1IEqS54ifRkD
         DYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746279792; x=1746884592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+aBAE4E5Z6GkrNwFJ7Ke9demvrPPuBn07vQWF3n+iE=;
        b=bs9vhH4JKYvIpWKOAo2I9ZgrWsXmct9iArL0FCdPxV6FWRFdkhZl8yJOmIq4ozlo7M
         jDgHRUQ0EIhQnB6Z5zEBQV1lYHpykI816uhvUS6JSOErE6lyQoO7v4mZLSFleHJa2je2
         s+gMk4Taij6lgCNMVwnr42BPuhCEaOeKRf5LibxtkQcFXhmPazwFLYax1vvFG/2Td/Th
         aSeqjLFVsFb9pnzlRT+MpmmxrZA1kd1GLCde7RssnUkiY68uIpjuNAZJa4STvkMLy9yU
         m9bQWYYD5Jo6k4Me0kVdrAm7AWBmD54/m6sNh1r9v5EBZWyhQbXUZEEje3gDNq/i1atn
         woMg==
X-Forwarded-Encrypted: i=1; AJvYcCWh9kWF+wsAG5wXZ8B5QOJTu+KqWFVKP1HtDri/5P1zMNMOsN2NYZGLciFJ+b4h5B8Uou6a9fvBomX3@vger.kernel.org
X-Gm-Message-State: AOJu0YyLC6sv7vG+BGNZ4p9h6pq9N39BWgpHjY+NX5xk1OTaIQuTvLYC
	Gph/grwv5J36qFS2k2F6jMgQUNYo9/hLkvl2DxqvJInjPemCGHy06/wAC5Lk
X-Gm-Gg: ASbGncu+rxDIx21Qwb3M4WTm+8cpCuX7gIR9eQqrLkrkRKYXCWlCMuCQghBVGbXtWsl
	dpAtZvgfCNEPHN42+6RiJWU3IXogIjjqb1EN5BPNHKo4+mmxVnSgArOpsyEbDktHi8RG7+Iv0/H
	PWrXcMyA6QHCZI4XIII2p/4r4sRqLyw1VhVuR6wB0HT6DEYAeffM/x0SnKB/IbeMX1jcfWxTey5
	cGnUoA1pbltYEqirvuYoDwSulpDCVyU5l0M92fJ0AUg4pf20KHI3tlZeXYcLhsOyWrXVAxadqHP
	qQse+u3cd9qKCnpExHOSgdPbMm0uoYt3mDFqbMvLNlSRhuDmCU87O0EnrST06OLAdsGumuA=
X-Google-Smtp-Source: AGHT+IHt08TO8cQiy8c6bfQR9oD1Lbn1aaXPJfrD/SpTZrgLgTmhLH1qpg2ALR8lPuEC+pYSDJDHWg==
X-Received: by 2002:a17:90b:274d:b0:2ff:7ad4:77af with SMTP id 98e67ed59e1d1-30a5ae58143mr4724680a91.20.1746279792286;
        Sat, 03 May 2025 06:43:12 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4762679csm5561696a91.34.2025.05.03.06.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:43:12 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v2 0/2] RDMA/rxe: Prefetching pages with explicit ODP
Date: Sat,  3 May 2025 13:42:22 +0000
Message-ID: <20250503134224.4867-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is ibv_advise_mr(3) that can be used by applications to optimize
memory access. This series enables the feature on rxe driver, which has
already been available in mlx5.

There is a tiny change on the rdma-core util.
cf. https://github.com/linux-rdma/rdma-core/pull/1605

Daisuke Matsuda (2):
  RDMA/rxe: Implement synchronous prefetch for ODP MRs
  RDMA/rxe: Enable asynchronous prefetch for ODP MRs

 drivers/infiniband/sw/rxe/rxe.c     |   7 ++
 drivers/infiniband/sw/rxe/rxe_loc.h |  10 ++
 drivers/infiniband/sw/rxe/rxe_odp.c | 165 ++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)

-- 
2.43.0


