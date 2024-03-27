Return-Path: <linux-rdma+bounces-1592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5F388EA05
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02911C30252
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB012F585;
	Wed, 27 Mar 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epUcvsP/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89812DDAF
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555061; cv=none; b=qvRaBArUYA7Rpe5jZX6y3Z/B4n9SxcSaSGlqlhBQVBzf5k0OKa7B/Qe7nVLLLypV0OA65BUBVEVJYqHJRCz9u4QJ0wVNMp1T+EpS+oRDpv5dglWs1CIuHXMaGT23uGOPaU+5qkMFY/hHoygNbjatxbYa5FUaLkOfla3kiCy0Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555061; c=relaxed/simple;
	bh=caDVwPtv4am9rcSbm5vU3LYH9tj3RMgdneu8aS9ABHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cx7Jkk1uWkElrBLMvkHynvcf+YFayyA8fjcKZ+o3s4TlBrRoOIcUgap4oCrQEYHwsE69jMb5fsg/WiQjQw9Mz/QIuilKjldNzK2rJ5Auj1ivBykHXy3ZNMx+FwOs5uJvo+oHn7XqI/3bjUZcCl6rx6646fTvUZMchNUKaQqrcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epUcvsP/; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e67b5d6dd8so3795687a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555059; x=1712159859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoXNcwO4BGUDgapSzUC/bShD/++4e3y+6cEprq5LRMM=;
        b=epUcvsP/yK0aUyYAzojsUGQ4dXFO+WCSHL3chK36xUYd2Q332PhXCtsR/oXRZ1hOlZ
         O2w/1t2wpKPt7Pwr3oyRIqN/Q+YGHWOeuBlsMQ89xmpbiIn9xWxu4e45L2IXfJr1di+z
         dtyZ1tv6+/VHFfJDmd5AQTTERV4s7F7UXVFd2Qj4y3eN80w7B3RxUSYPf12w+09Hyk/2
         dHb10MQPq1uTadZDgLVrq9pV8+pNGC687SmyASd+INAc7h/0bJKmfLZAlqlewHhZ4eoY
         BsENalv258Ey7UHT2lTXcZ5OypGmraFB7bQIVm4sQFNP5azWWfv1J7FjBpd2qfH59MNE
         ZXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555059; x=1712159859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoXNcwO4BGUDgapSzUC/bShD/++4e3y+6cEprq5LRMM=;
        b=TZA7ozHBxjoW1NkmJFwh9YCJ5YXjevTiBCD926ZvOd4Mxd3Uyv4pPJMG40CyEofHVP
         BBbLrWg0a9BC4S87nk3LU/oI7F8Qvq38GUCAEPHai/0iyGeQKVw0gOR2Bdk1L94GxNjY
         gRlfD37pKdABpu+SOZynkGNrsXEB8/zbgLodRnvbXOVO7O7emHhR4hmg5T1rb/DMnAUu
         ioqq4TvLhbHYF5qGHKUzLf2P7WZaMYCyc3BOsKHZ1byMQEeL0xAujmF/4pKoIfBpGrcD
         xDEDyq6QDWze7Vkbvcf0x0q3iVOTARsxq1ezpZRfYaAx5hzUTY2BfCJCX92itG5TsfI5
         FpEw==
X-Forwarded-Encrypted: i=1; AJvYcCVuh2ckigHf2ErddIGN9UQaCc6al2AhSsULqSapo+8PP6hJwZ2FzNUfjXZPIk8aVejVwA+ybojVwNBA/jOhQme2WkC5zW3XdmuUCQ==
X-Gm-Message-State: AOJu0Yw19r9Iw8hv4J8UMXuljCxqEs0sOfmKMJ0BkwaVhae0ncRN6OHS
	ArsinwPVxKKFnfAxS7DPHiCfMafxyCLMD/ynHoya0vgK8yGbqyQn
X-Google-Smtp-Source: AGHT+IEqDJEpvsQmXatHYP9OyD9rGJB+tA/qpZ7dsrJNlEWE4T/Q61O/RvzitdvwnNsxDJdjXd4TKQ==
X-Received: by 2002:a05:6830:1281:b0:6e6:cd51:e87f with SMTP id z1-20020a056830128100b006e6cd51e87fmr402826otp.8.1711555058720;
        Wed, 27 Mar 2024 08:57:38 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:38 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 00/12] RDMA/rxe: Various fixes and cleanups
Date: Wed, 27 Mar 2024 10:51:46 -0500
Message-ID: <20240327155157.590886-2-rpearsonhpe@gmail.com>
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

v2
	Minor edits to some of the commit messages.
	Added a missing change to "Don't schedule rxe_completer...".
	Added a missing change to "Git rid of pkt resend on err".
	Added one additional commit.

Bob Pearson (12):
  RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
  RDMA/rxe: Allow good work requests to be executed
  RDMA/rxe: Remove redundant scheduling of rxe_completer
  RDMA/rxe: Merge request and complete tasks
  RDMA/rxe: Remove save/rollback_state in rxe_requester
  RDMA/rxe: Don't schedule rxe_completer from rxe_requester
  RDMA/rxe: Don't call rxe_requester from rxe_completer
  RDMA/rxe: Don't call direct between tasks
  RDMA/rxe: Fix incorrect rxe_put in error path
  RDMA/rxe: Make rxe_loopback match rxe_send behavior
  RDMA/rxe: Get rid of pkt resend on err
  RDMA/rxe: Let destroy qp succeed with stuck packet

 drivers/infiniband/sw/rxe/rxe_comp.c        | 34 ++++-----
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         |  3 +-
 drivers/infiniband/sw/rxe/rxe_net.c         | 69 +++++++++--------
 drivers/infiniband/sw/rxe/rxe_qp.c          | 46 +++++-------
 drivers/infiniband/sw/rxe/rxe_req.c         | 82 ++++++---------------
 drivers/infiniband/sw/rxe/rxe_resp.c        | 14 +---
 drivers/infiniband/sw/rxe/rxe_verbs.c       | 17 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  6 +-
 10 files changed, 112 insertions(+), 163 deletions(-)

-- 
2.43.0


