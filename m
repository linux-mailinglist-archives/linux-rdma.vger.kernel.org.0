Return-Path: <linux-rdma+bounces-4451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFE959A79
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E511C21977
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2881C32FB;
	Wed, 21 Aug 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="L2SOrYqk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E81ACE1C
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239401; cv=none; b=pOY+7QXawM9vfOzBwyw35JgJZ/COfsaIEhPH2ZypggaeICpNdpFhZq4HgbnDHp6JWiv7sMmaEmShlfWveQmLDTEbYx+UCa7Zh27l/LfXkeF4gh8iuoNWgpDLU2AcQEqwRZcPtmcHwJBo5ooUPpBSfMuh8e0lAWRHjeGSvfqPPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239401; c=relaxed/simple;
	bh=ZIAoT7g1y1cViOO+W7jwMZxFtD3eJwLA4YAcW9I8qZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DiVexc1QtOIDojafegPRjgr1wwICgkR9GKSzZZvPVrrkF+IZ1qJ1EJoks/+7POv4SUiiZAq939OW41zA4Zx8E+upC1i4FYom8JXa7EzKBrq0FuzqiIXrIUO8Mysx8rsCdV/QMAC+v9Ek4YoyxXFsk/gcnZHLe5/7+Muh6m3PRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=L2SOrYqk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso63845851fa.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239397; x=1724844197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gGrzKbh0LQkyi8yzRF8/W507vfxGql+BaOxaJqaTIk=;
        b=L2SOrYqkJcbL+TCtI5mVW+BRKmErIUrrv25RSt2Y3cL+fD4IxMAVP3wV2d4sQnj33J
         Q5T5M3rtJwg02CGmqrbIrjeB6hacywbbhQR8i26lfH2KEH+sFU0MD4G/o65p5ejdr8mS
         llQEfeQHUYUkTW07mPS4EVoulPD6oIs9YQ18/Xaio41k1mY/OfYZmI4JVs9sMdB/iIH9
         T6wx3dLkb30AJwj9GgW5IJRsYAkHLFlEHU/oEtOnyQrnVSpSQKBl7bi0K2JoVExsaDVQ
         7Nqt0FEFHjYkODvZfvRE4118ichgbE2SuOUU9VgcDftCVaoyeZh2taETZjCpNJchsK/1
         06Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239397; x=1724844197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gGrzKbh0LQkyi8yzRF8/W507vfxGql+BaOxaJqaTIk=;
        b=I60BTu6CGzII83wsExgQJ6mY3ZkTIt62FNWZg7QpGhMlciwTZuY798p+zZf0XW6hvg
         MIHlY8Vg6ccV8+1Q40mCmFFXg8Xwk8+Pu375IQvsk1G+p9vvXVDh877bfNc8n0qEwxGJ
         NpHI0ak/kBzPFnMPyWQFNg7mRd4D08KlRxIHvfy9rozLEA4frxlZTODVGa5G3TNJMVlu
         LKVP7aA4UJ2FKXzyTfAY95CnTDdICarEFIDpbWf21GVw0oN4Na5HR1ZsyOpO4ES9l5Eh
         SUCZR0QLDxohT6vHjICqRkQGFGO7IqAl1bkczrXD6vA8ViUjYNISx7PDHemqYKMUo413
         CUng==
X-Gm-Message-State: AOJu0Yz6TVllUPK4WjwAdLlXfvMKti3EZvX08/2sQHgJ9a6Z4CNX+Um/
	K3M5leX7bMFw6tM+7VBmZswmC+LJmHIve25n1Yu0iAEXAPzCdABRY4RVoiafmej2eyovxbDr/9K
	VdR8=
X-Google-Smtp-Source: AGHT+IFdzXM/pLXrgWime650Yumvkv5JwG8arV62W4/B29tiIPIYcLH8ljX/LHwi49rmiWaAEQNVrA==
X-Received: by 2002:ac2:4e09:0:b0:52c:e11e:d493 with SMTP id 2adb3069b0e04-5334855e774mr1177890e87.26.1724239396209;
        Wed, 21 Aug 2024 04:23:16 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:15 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 00/11] Misc patches for RTRS
Date: Wed, 21 Aug 2024 13:22:06 +0200
Message-Id: <20240821112217.41827-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

Changes in v2:
	Dropped 2 patches as discussed.

Grzegorz Prajsner (1):
  RDMA/rtrs: register ib event handler

Jack Wang (7):
  RDMA/rtrs-clt: Fix need_inv setting in error case
  RDMA/rtrs-clt: Rate limit errors in IO path
  RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
  RDMA/rtrs-clt: Reuse need_inval from mr
  RDMA/rtrs-clt: Print request type for errors
  RDMA/rtrs-clt: Do local invalidate after write io completion
  RDMA/rtrs-clt: Remove an extra space

Md Haris Iqbal (3):
  RDMA/rtrs: For HB error add additional clt/srv specific logging
  RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
  RDMA/rtrs-srv: Avoid null pointer deref during path establishment

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 92 ++++++++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 51 +++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  2 +
 5 files changed, 111 insertions(+), 39 deletions(-)

-- 
2.25.1


