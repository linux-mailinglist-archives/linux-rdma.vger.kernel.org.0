Return-Path: <linux-rdma+bounces-15196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15994CDB56E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 05:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7783A301A1C3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92E286D73;
	Wed, 24 Dec 2025 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TkeRSzaW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFD1AA1D2
	for <linux-rdma@vger.kernel.org>; Wed, 24 Dec 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550985; cv=none; b=ZqdI/jxTMxq4dCi6Vg6n/jrdQO3JfYPSHxeKvPtD2bKBfxvKabJrfoXhjP39bHYLq0OtdMn6L+D7aoyabtOoofZc4zTpks5Io+ToRwl9kKI9qdBpOcevqLtH04FNfmcJe2YV9gX66etjSPuaTirATZYMx3ga6i1wJNU+EsvSgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550985; c=relaxed/simple;
	bh=n6x+cX+zNefVv5Ewp7aGkuMfDY10pMmL9zqPg0k8zpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOGwxdYpIer/U2kVB9uQZGmTcS3f+S5/2HFU7OUILOUMa6yMeWJsvQx3w9mAUxn2LDJ6ETcAEjIm9HrohyTf9vsRh6ha+uxUz17erE4iDgw0llGN7RyU5HhEPvJAUvu05yjs9jIUBtUylaaL9rp3VgLlW5STlDfLXfb9ogpWkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TkeRSzaW; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so5006817d50.3
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550983; x=1767155783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSAGW4wUAKUHD/SntoawHofeJFwo7/4XwBdT5nGf69U=;
        b=UKeAXnL+1LSckc7+INun8i6InHea18Hf3+ajgNJSBAhI5JokdvN7XFX2Sh9SI7O2Aa
         jQFw/p0xtss8SG1ekr+ztDucMuC+pgDJAbRjG914dBTkTBX5qdiNPyStpHXKNUROJxGv
         RCfJlr3j82Pvfn+0n9bzAn5yk3Lzsx/wN+y/OUHHVrwe9yEqhaItNs4YKXBXcbCOfgZW
         8KvGIZRt+N9KNnKNUKaEni6vmjZeu1J6OgZ6r970KAVJx+6uy/NfHdA0GzkTAFbO60Lx
         gG6vg0WesiuKw/LY+TowHOpCaEGL/gXf9ojidoWyAOgWl7BYD5EyEboAlNL/MlDWuxjj
         THkw==
X-Gm-Message-State: AOJu0Yyc4Nm8ecmx1Aau63zrOY3Pr+4QcuuChCl80vIHDEEdlIqblUop
	1YVtDapi9HnHb4+hERTgMg74bD076hHLqMfkOdg92tAdHBozxuU1RlElRHWzWIogYg9vq1B9sXs
	UBaZptyyQKiLw24C6LnezuOl2x4/ecTjx1sKya+6Bl2rJLQ4l9/XAgtl2myjkSJz78irtRBL1YQ
	0ZPn8kWdmjvRMrBtoO/MfsSlgMMjYspUv1DS7ITcrdwKtUNvBiXG7UYYrj/kO4sHmpFji66OovY
	CwmfDWb1cY3Md5hocNazJb5wc3H
X-Gm-Gg: AY/fxX6PQCykIwHvhpLKhxutwj83BMa/MGjjgR0CFFpG+fGdD6VDDIRGkr3QgRjA74k
	6tPhefwsbrJmoOXduY4h4qV5sjnpNazCZV7LhUO2248jmcyFJxG0ucDUauAzvUEeZ7Wb2pFZl8X
	dMQe2hCCi8z4e66uNpeOPXYMqL1i3W6SNE581PnI2cCjPoEvCYNRfj2kS9Px3QEUIOuqPo9Ji1Z
	NAlBWBwDU6cCczl4KQBlu3kvJULgMs6EQYwrGZxbbNJIjVwAX18iKLRk+EnpcnAfRLC5KwSkBlU
	d22wRc4ClkJgYj9jN49sdMBxIH6gdi3MqGc93x/l/DY8WjnSWlA/VVnEfugZUDANUtS3LRF9egw
	2Ava3WpAWwaj8ceJt1pI6Rkx0nHdTVTGXxoqf94AZnBKMYodraYPaifLqgQqnp9bAV789rbDmbJ
	usAY6eT2Yx0mZHz/leLQxXTq9Tm9byypjszYIDiMlUr0V0ATgHyKTBSvib
X-Google-Smtp-Source: AGHT+IEG3BBLNdBSYg+4zO8fBLg9CqpCPNIgogDLLg+9yLDoWOiaR99f9SwyRP7vJJRoKTYajkc75repmkXU
X-Received: by 2002:a05:690e:3c7:b0:63f:b6d3:5a44 with SMTP id 956f58d0204a3-6466a8b88c1mr9947039d50.67.1766550982991;
        Tue, 23 Dec 2025 20:36:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6466a8b1e88sm684992d50.1.2025.12.23.20.36.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 20:36:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so7066524a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766550982; x=1767155782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSAGW4wUAKUHD/SntoawHofeJFwo7/4XwBdT5nGf69U=;
        b=TkeRSzaWdU1SsjHFoTfzlNNoTYLEpvacBA9YIOfIdk+wJfouMCZ7aymTKzAsNCtjDR
         To8WK/VNyTgCaOW0kN9lqUfteVGI9gx0KZ8/qOmVXbzC8koqp1gZjLnjDLjfbnWnWaUv
         aM2DojAxVVjAnOCJI1E2LBIbhCcIDFZD/viCk=
X-Received: by 2002:a17:90b:2246:b0:34c:2db6:57a7 with SMTP id 98e67ed59e1d1-34e921131b8mr14263734a91.8.1766550981668;
        Tue, 23 Dec 2025 20:36:21 -0800 (PST)
X-Received: by 2002:a17:90b:2246:b0:34c:2db6:57a7 with SMTP id 98e67ed59e1d1-34e921131b8mr14263717a91.8.1766550981203;
        Tue, 23 Dec 2025 20:36:21 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b165bsm14219525a91.6.2025.12.23.20.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:36:20 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 0/4] RDMA/bnxt_re: Support direct verbs
Date: Wed, 24 Dec 2025 09:55:58 +0530
Message-ID: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patchset supports Direct Verbs in the bnxt_re driver.

This is required by vendor specific applications that need to manage
the HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide Direct Verbs using which the application can allocate and
manage the HW resources (Queues, Doorbell etc) . The Direct Verbs
enable the application to implement the control path.

Patch#1 Move uapi methods to a separate file
Patch#2 Refactor existing bnxt_qplib_create_qp() function
Patch#3 Support dbr direct verbs
Patch#4 Support cq and qp direct verbs

Thanks,
-Harsha

******

Changes:

v6:
- Minor updates in Patch#3:
  - Removed unused variables.
  - Renamed & updated a uverbs method to a global.
- Minor updates in Patch#4:
  - Removed unused variables, stray hunks.
v5:
- Design changes to address previous round of comments:
  - Reverted changes in rdma-core (removed V4-Patch#1).
  - Removed driver support for umem-reg/dereg DVs (Patch#3).
  - Enhanced driver specific udata to avoid new CQ/QP ioctls (Patch#4).
  - Removed additional driver functions in modify/query QP (Patch#4).
  - Utilized queue-va in udata for deferred pinning (Patch#4).
v4:
- Added a new (rdma core) patch.
- Addressed code review comments in patch 5.
v3:
- Addressed code review comments in patches 1, 2 and 4.
v2:
- Fixed build warnings reported by test robot in patches 3 and 4.

v5: https://lore.kernel.org/linux-rdma/20251129165441.75274-1-sriharsha.basavapatna@broadcom.com/
v4: https://lore.kernel.org/linux-rdma/20251117061741.15752-1-sriharsha.basavapatna@broadcom.com/
v3: https://lore.kernel.org/linux-rdma/20251110145628.290296-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20251104072320.210596-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20251103105033.205586-1-sriharsha.basavapatna@broadcom.com/

******

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Direct Verbs: Support DBR verbs

Sriharsha Basavapatna (1):
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/hw/bnxt_re/Makefile    |   2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   7 +
 drivers/infiniband/hw/bnxt_re/dv.c        | 939 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 552 +++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  21 +
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 310 +++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 include/uapi/rdma/bnxt_re-abi.h           |  45 ++
 11 files changed, 1395 insertions(+), 545 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


