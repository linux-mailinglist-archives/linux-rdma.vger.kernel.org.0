Return-Path: <linux-rdma+bounces-1669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3940892010
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC0C284B09
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B214AD0A;
	Fri, 29 Mar 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtIR4B1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946244C67
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724144; cv=none; b=VmH6vh717P0oT4XaWX+JhYXGbs1R/r5BjysuQLntp6n245KzY81jCKmsYqMqhulhUSeymhodS/OzWxthIrQw+udSRWJUGQYmuisKr1GCO8C+YvpDggb+MJwjdIKRpRpHiuJfjoMX4B0AelDP4DHlL53VqVd6Qyc3zZWhkNqzYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724144; c=relaxed/simple;
	bh=MRXbppMVBbpEAWNpzEFNIaf+OsjyNFYv7VQxdJVCYGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URPDC/Er1EPYSzDH2FJeh8cPQUwqNwaiokak4bGp3Qd1OjkC3dGpdvEvp1SlLQSSz2CEDFDa92x7uHR8RpWMN+nWTmKBR1pmniURXKHN8iTRQrugCu/V6nGb381jOjVFZFTjt42h0gHnezHc+sP0tWp1v8Wemh/I3iO1ft2+Cj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtIR4B1s; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a46abf093cso1338765eaf.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724141; x=1712328941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRbVFFazYE9cEW7lFjMY2HghdW9S2LiyYVss0XO3lx4=;
        b=NtIR4B1swPPfZ5KknxupNGB4XCztISOqrJtOVFVkr3tiIAF1xNbGMlveV8ObNGLGfV
         b9i6BFjGcFC+oQ6jXcCMVEc+/zoeZ3kPb8P+GQpkSTyq0/0D2Iy34KbmECz8OweT9fi0
         cpnu3t2POiIa5z7YzWGL/5VaqmsGfezc9ou9tp8j6wTU8lAXopZ00et/2RhYdZX1H9mT
         AwzZ7lqnPoFnTJrBLp17cyP00JUK4gXWzQnxC7ARCYOOja0WDLBqYt2rQ5Oi1BAjrIZT
         f9iucRX8zoewfIVRBbUJfkDb0ICmcT+TfR16nzVZ0gsBnfmv0T6vRkP8OvvTHo0ZpOwA
         ER/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724141; x=1712328941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRbVFFazYE9cEW7lFjMY2HghdW9S2LiyYVss0XO3lx4=;
        b=bYJUMEVGSshPYipNo5dPdR9a0XJnf9pdttoYTAmOqM810VWnQhOl0piji8EJzWlduN
         dY3q9EmkvHOqzWgBejrGwnm8Hv6kPJQmWCqgZhms8T8X77zdnkvwUoaEJfmbTLO9U25J
         tHaFT+1ZV8kghEs+8PzVrb1+vQR8KU+iiZqcMcmd3totbSmaKOAI05FdbPKa2KVMEDYc
         iF2QDCPk0+2jrruNPFQWgpl8XqeLnqKqyFy5h51vNDWANnYHbDeaKp0lnS/prjra14A9
         Axz9UeJhNrquh+94fA+A7hPGnLt6/Fa44o+MnFlWWyxlXS/0vJUw11mx37MBYlCK0psv
         wknQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvKV4zdKsRXmXCcT7jHUgcIyr9EeG9fFcpO+ksHL6Ec9/NUzH6HI+8dY8AX3rKta970UO0XvdiNEKVl9xZduSN6Fozzq3EzwNofA==
X-Gm-Message-State: AOJu0YyCOlXNAjrRCVUVy7ucOppVZLXKzAEnTBEoufQ7FILEb7ENvWfX
	GXGvyYQFrgSecmk8P//nUcllR4+CnTne/I2axxEM2K8WR/ZiQvA2
X-Google-Smtp-Source: AGHT+IFRdpB1tvoEWA61XCo1PzgpRULjKU266dEzWWAENZtHafGGfnQ9dXUSRY8yZusHHgEYCcT7gw==
X-Received: by 2002:a05:6871:54d:b0:221:3c64:fbb with SMTP id t13-20020a056871054d00b002213c640fbbmr2521994oal.30.1711724141618;
        Fri, 29 Mar 2024 07:55:41 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:40 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 00/12] RDMA/rxe: Various fixes and cleanups
Date: Fri, 29 Mar 2024 09:55:02 -0500
Message-ID: <20240329145513.35381-2-rpearsonhpe@gmail.com>
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

v3
	Fixed an error in "Don't call rxe_requester from rxe_completer"
	Moved run_requester_again from a global to rxe_req_info.again.
	The control parameter has to be local to each qp.
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

 drivers/infiniband/sw/rxe/rxe_comp.c        | 32 ++++----
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         |  3 +-
 drivers/infiniband/sw/rxe/rxe_net.c         | 69 +++++++++--------
 drivers/infiniband/sw/rxe/rxe_qp.c          | 46 +++++-------
 drivers/infiniband/sw/rxe/rxe_req.c         | 82 ++++++---------------
 drivers/infiniband/sw/rxe/rxe_resp.c        | 14 +---
 drivers/infiniband/sw/rxe/rxe_verbs.c       | 17 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  7 +-
 10 files changed, 111 insertions(+), 163 deletions(-)

-- 
2.43.0


