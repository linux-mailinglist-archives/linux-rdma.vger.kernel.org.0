Return-Path: <linux-rdma+bounces-1568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E9588CB28
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AC930828D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B121D539;
	Tue, 26 Mar 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMmzSYHD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A863A95B
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475062; cv=none; b=igS/knUNDdpvYyu7XkpJWm+AYF1n9SYAGeEr7m8VnZenDe0S0Z1NND7mGErl6FC6TYL3JsUVjdU+G0y1DKiVTacE90be0CJCToXEC5OfboJY/RiYu1uzQd0gFRjNo4SU8ScMtAUfMit0Ar9b7FccIJ4Jmvr+OcRcnGcJNYDTnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475062; c=relaxed/simple;
	bh=Rg7gJ5ajGgP7K5w260P9fa6TYNqVorpBMweHxhdkPJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMYp6CtKR1UwrRGHKQ1uDP/YAwVJaHsXMKE6xtrzCY2M6OgCUgl3e/Pa69FMRG1dlq2s3eGU4dMWgGdgZa0IKnIYwdsisyi+KMZnJor0tEXBJYH8sLWINN0iCMd1aiUAyyYytUQ0bR6L3EyaqMMM3C/cOke9cgq2LljpItbjpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMmzSYHD; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a56a5f597dso855715eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475060; x=1712079860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sf43KXUljxu5cL4W38O9YvJEryB/seqy3jiGezHopDc=;
        b=TMmzSYHD4oaU4aijz+r/ZA+U/3W9HgAH3lnpcJYlf1zHGXO0k+q1FBBIlXlpdLfu5E
         SAIYRBSv8eghSFRzeZoYudLKKG5yjIBqMrClT6v8EqvPZh56kSMvyKfldq4osg8t3wMa
         D9qaQIuNKPqMXhE92w46U9Wp23KMeXCLskNf0fVhVIZmuQI181AhjFsnjeTGMoEdFySf
         5pp681eruGYmulOZWOkbOg9we0M9D4ZTrEba6m9qzPMnfA0rQ2rUb1DaYQgpC7KZv101
         taz3YA4eHp/47wISkiVSL2HJ2d/vD2Q/4ViSUg/Da7+inEqhqs71UYGynRzzrV8+tvie
         aUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475060; x=1712079860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sf43KXUljxu5cL4W38O9YvJEryB/seqy3jiGezHopDc=;
        b=KRggg2PBVsLP8tB9MtNrEU4A2vvqsj4pN1FqNZ2AaPhcPYpTLayxglOH0Fr6B/zio2
         iVVzwC/CAGQMdS6+CExiccbgdVmsWeqcKFKuPCdy2MObo31SWr4ghUh2VPBn8xU6qZ9G
         o0oYJodCCl2XIE6IhqfvHNuzPsng2SkOyZNsggZIvyxS+CEY1n2ol+jwts7vllZPZAAZ
         R1bETWMb763/AODQa+Z8jeNqduyC9be/WxYV8Ay7XmkSOlHGxniu/qSjrZYc4DoaUhqe
         DoqLtX/yUX4lMXUJdCmEYzZ7NSctv2yp8kTNTd9zJiuFi1LjHDV60B+3x024nvcbmeCm
         W49Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbw3bjRkHOG4PxADyRILwFfaAGJeSCexErl5nZccakx3+WqcN20Eu+0gaKnLmTyfagIufd5GdNXiNXs4tVuw602DaWsJy4eRo3WQ==
X-Gm-Message-State: AOJu0Yy8+a2hnv+lHIjCEm/y9pFpJz2jcy5wLvMrt3BeSrgyFZcYoh1l
	zMn0Cg9UvXBALEosyqHIHNKnBvH9f3MksYwJmnBtAHJicWRtNm7K4OSsmWI3bKg=
X-Google-Smtp-Source: AGHT+IGKpdfY6o2tUTjtXaNHtmhAE9J9TVA96NLsmuTOjiS/zNgj2ULmRu8FoEGfIqfY06MnSMlw0w==
X-Received: by 2002:a4a:e205:0:b0:5a4:75f2:54d0 with SMTP id b5-20020a4ae205000000b005a475f254d0mr1416710oot.9.1711475060231;
        Tue, 26 Mar 2024 10:44:20 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:19 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/11] RDMA/rxe: Various fixes and cleanups
Date: Tue, 26 Mar 2024 12:43:15 -0500
Message-ID: <20240326174325.300849-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches is the result of high scale testing on a large
HPC system with a large attached Lustre file system. Several errors
were found which had not been previously seen at smaller scales. In
this case up to 1600 QPs on 1024 compute nodes attached to about 100
flash storage nodes. Each patch has it's own description.

Bob Pearson (11):
  RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
  RDMA/rxe: Allow good work requests to be executed
  RDMA/rxe: Remove redundant scheduling of rxe_completer
  RDMA/rxe: Merge request and complete tasks
  RDMA/rxe: Remove save/rollback_state in rxe_requester
  RDMA/rxe: Don't schedule rxe_completer() in rxe_requester()
  RDMA/rxe: Don't call rxe_requester from rxe_completer
  RDMA/rxe: Don't call direct between tasks
  RDMA/rxe: Fix incorrect rxe_put in error path
  RDMA/rxe: Make rxe_loopback match rxe_send behavior
  RDMA/rxe: Get rid of pkt resend on err

 drivers/infiniband/sw/rxe/rxe_comp.c        | 34 ++++-----
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         |  3 +-
 drivers/infiniband/sw/rxe/rxe_net.c         | 22 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c          | 44 +++++-------
 drivers/infiniband/sw/rxe/rxe_req.c         | 80 ++++++---------------
 drivers/infiniband/sw/rxe/rxe_resp.c        | 14 +---
 drivers/infiniband/sw/rxe/rxe_verbs.c       | 17 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  6 +-
 10 files changed, 81 insertions(+), 143 deletions(-)

-- 
2.43.0


