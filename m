Return-Path: <linux-rdma+bounces-12752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDCB26414
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1354F188A7D4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE14318156;
	Thu, 14 Aug 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gSazGnJ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0203318138
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170393; cv=none; b=s8CWSJhC1rZlONxdX4pxV8lm1kgpc7neyq+imDD0XEgVpLA3PQ689Op8d5zilMfSpRR9jQztFAJRV69s2gmEDHWoQElkeKotVHvPF6qAidGVhp+NCtS4i+rbSY7k3kEzKtanGFiVK8TkFXIkbJHLkNTEVWrHU6bcGMRfsqUWZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170393; c=relaxed/simple;
	bh=9eW2aWHhd2MRO1FTRM7oSnQAva4hDvOU56LMCUlJ34E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H44jSrgz5/++IzA2HMkLtonW0A5z1YQpveJl1uTfyBv7ifcqmoAEr1JV+bkn3UMozIAHjOq0Od2VLsJsAMDWurvGnqWvB3maFhobXk0G0aF81O0R3GxbS7soCyDzqWOcmzV+oBMPxYj4gORZfTzgr4mL5gs6hdQLliv0RNf7DUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gSazGnJ7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47173a03ffso448413a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170391; x=1755775191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XM1F2B20uc+BPPUNiJTsdFrO6bKg9lASXis2/F+bbM=;
        b=gSazGnJ7nNZ1duk5uaYfdb1tHt9y3A52yIfg1j/ZVYNXOGCr+obnOY7pR5AmvCzNEA
         wjuHZ7lyDK5bc6YJ1XQO4ar8Bc4HNEUU72vVXENep2yvuyohvwcCuYomeoMn4z/BVh0h
         +v7CW2pv1V2zXO5o68ThUVgYSnupGlBVzBQdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170391; x=1755775191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XM1F2B20uc+BPPUNiJTsdFrO6bKg9lASXis2/F+bbM=;
        b=IY/Eo0aYuYixXF5eFXvsiTP8Z5cQPhbsAS/TyNWqhgumcQeOuoV1+f8FKNU8VKmnUx
         lSRoZM27fDITMQfwGpujOjhz0qBhR7Xw1p0rtpTGfwWuG+IzwctYfQ0ueOWUZvVxiYZ6
         KeyoI6n0IRA37hWR7x7zudlpah6DeADEU/qFnDlSRP81GeIl8KblLHngZskFA75yurMb
         1aB4dlWaLV1lrn5gKzAc9itcqF0EZG79R3l0ULlQ9tWKTOM0XIOhySJOJnGU1WkJ+V4F
         gNauFqSUZMovw9rEbRo1pXZmMw5q5gY6llAGmn+YUuLf3+vHnqkfgO54A5NJQ0bYDHtk
         +oKg==
X-Gm-Message-State: AOJu0YxDC4Y2PQZYCUKC+mk23IeDt0Qe2M0cYiZR9ujaNccY9eQ30zVz
	4Bmks0933gtp7Hf3hA9TJX6uwgWeA6bemmRYf6+rbWpuH0vzp8T56Ww/oRm4RC1LVg==
X-Gm-Gg: ASbGnculaNuAfCZCG8xHY1xq3r2RKnNcdqGXq4khzLCq7RNyqW4RCah6S0rAyac8YzR
	1HogCqIjQtH59jmmGB4RIoBhRdvZ057/qmXC987Chgg8Ur7eqAanTGUqt4qkzbS93uIv4YEgmUs
	b98YN0JwEEQHrrX2HjHUr8xRVk55HcqIk+8IuV/jIMsfkgIbUFbXkHFSCAfQD+jSMkiCMrUjH0F
	4kwPRWbuFa7dT0OIvzCmGA3FRNyQSftzrDGuAcvg9bCsBBK3SenzzOYfe6yHodzmXXeqRNR7MYq
	b8Ya8aWESXfZj7S0hv1VgR+U6ExfwTZ0FuSvZuOGoqNT6oqpWCgVXYgnH+C8KwycKplT6E5wGkN
	mJLZFQGAQIiAT6ePBNEI1OLk4Nqw25WPbOQRnUZSNWcmdBOBADR+QGyhFlmDjAb5UsMKw+VDIws
	gwf/3ISbwL6S/ZQVhywE7YpWWK/xOruw==
X-Google-Smtp-Source: AGHT+IGoaKrC0LVftVCQLC8sipvpInELUr07YU6pe97wteCzqTTLgHE/jPyNmaj57l1Qxvo+Il2JkA==
X-Received: by 2002:a17:902:f54b:b0:240:6766:ac01 with SMTP id d9443c01a7336-244589fd923mr46750535ad.2.1755170391188;
        Thu, 14 Aug 2025 04:19:51 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:19:50 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 0/9] bnxt_re enhancements
Date: Thu, 14 Aug 2025 16:55:46 +0530
Message-ID: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset contains few enhancements in the bnxt_re driver.

Please review.

Abhishek Mohapatra (1):
  RDMA/bnxt_re: Report udp source port for flow_label in
    bnxt_re_query_qp

Anantha Prabhu (1):
  RDMA/bnxt_re: Update sysfs entries with appropriate data

Chenna Arnoori (1):
  RDMA/bnxt_re: RoCE Driver Dynamic Debug for HWRM's

Damodharam Ammepalli (1):
  RDMA/bnxt_re: Optimize bnxt_qplib_get_dev_attr function

Kalesh AP (2):
  RDMA/bnxt_re: Delete always true SGID table check
  RDMA/bnxt_re: Enhance a log message when bnxt_re_register_netdev fails

Kashyap Desai (1):
  RDMA/bnxt_re: show srq_limit in fill_res_srq_entry hook

Shravya KN (1):
  RDMA/bnxt_re: Avoid GID level QoS update from the driver

Vasuthevan Maheswaran (1):
  RDMA/bnxt_re: RoCE related hardware counters update

 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |   2 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  51 ++++---
 drivers/infiniband/hw/bnxt_re/hw_counters.h |   3 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    |   4 +-
 drivers/infiniband/hw/bnxt_re/main.c        | 151 +++++++-------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c    |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h    |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  55 +------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |   1 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h    |   3 +-
 11 files changed, 108 insertions(+), 166 deletions(-)

-- 
2.43.5


