Return-Path: <linux-rdma+bounces-11870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2002AF7ED1
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5796A1C46EDE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC3288C9C;
	Thu,  3 Jul 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Gvub6eNy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5D288C8E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563606; cv=none; b=Tkf7TfPF0mpAWnqMWs2R5Aun954SvdemwG/0LZM0cZddfqpOHJ5xla1+CXYctAD7P8pFd0yL00nYYGBev1+La2FtHxg2DSkIjyCAG/wBrXKIybFI7Cvtqu77W5+F2InA3IUJmf+ulMA/exmDmzpBfGsY5XU//tleED+utYreDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563606; c=relaxed/simple;
	bh=lTjFmTektsvhaNYZJWaAaII/0KyhBqDEJb/cGnc4jKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2WkENkDEBxR73Oc57H/tU2t/9t+j8PSl3N2IEVhyhQj3RSRZ1/jnlOJRsz2yAO3nscyvMChQeMUNNhSm9ZH0ZRXLANHVGtQBo5ZY/ntqkScy+87EbV+/wgobogV7RcPde6hrQRm7eOx/y6Pz4TgblPROEPpBj+EtwkF4onmByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Gvub6eNy; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=Tmf9aGoW6DPkvpnNmK7IPmq1OTaQgNk6b0qaASJMNzY=; b=Gvub6eNy+daP/dVOugtVE1AGyl
	bbLjIjIPubfov7PSFDyxiBQmSD8ndUKyjkFH7au2fqQ6dVgJw+b3RhHBgVi+vdF//U02PtYqUuU1l
	5+QyCanGoJhrbC4E84HobIYxwgB/lKk9g+MdilmZGNENEpED/WhhKnvJzzKo1zA4eSml27hU1Bf01
	QcGAvaqut7ozUVNmJ2l613uQwQCVNlpkTw+sLM9W/XXr17McZHBgfW/qVHOLzR6+9bvZJ/89kL8TT
	7CBXRTOn5WyvibiXUBXJhOwARsQxJJ0Ruajp2v+A+o2aX4MnxSeHCgp3Gi6RoCv/5S8V3Psuld2Kc
	uNkZyu/PGSRP3cQyB0xeAW8wywYSdl9QV25v2nntm1Un2mOep7RS4VjEbbu4kGjBNlt2Sy+f8pJoq
	hpX0bXUjQdzDp8ULlRJiUJ9SOutWa8tTH5VaKgzRdGxXVczNrKvQ712vdq1XxPqy5mv9J5RyXAGG5
	sMhDqYA/AnPdNO+s6I3mQPGx;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNhp-00Dp24-1P;
	Thu, 03 Jul 2025 17:26:41 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 0/8] RDMA/siw: [re-]introduce module parameters and add MPA V1
Date: Thu,  3 Jul 2025 19:26:11 +0200
Message-Id: <cover.1751561826.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on smbdirect cleanup I'm using siw.ko for
testing against Windows using Chelsio T404-BT (only supporting MPA V1)
and T520-BT (supporting MPA V2) cards.

Up to now I used old patches to add MPA V1 support
to siw.ko and compiled against the running kernel
each time. I don't want to do that forever, so
I re-introduced module parameters in order to
avoid patching and compiling.

For my testing I'm using something like this:

  echo 1 > /sys/module/siw/parameters/mpa_crc_required
  echo 1 > /sys/module/siw/parameters/mpa_crc_strict
  echo 0 > /sys/module/siw/parameters/mpa_rdma_write_rtr
  echo 1 > /sys/module/siw/parameters/mpa_peer_to_peer

  echo 1 > /sys/module/siw/parameters/mpa_version
  rdma link add siw_v1_eth0 type siw netdev eth0

  echo 2 > /sys/module/siw/parameters/mpa_version
  rdma link add siw_v2_eth1 type siw netdev eth1

The global parameters are copied at 'rdma link add' time
and will stay as is for the lifetime of the specific device.

So I can testing against the T520-BT card using siw_v2_eth1
and against the T404-BT card using siw_v1_eth0.

It would be great if this can go upstream.

Stefan Metzmacher (8):
  RDMA/siw: make mpa_version = MPA_REVISION_2 const
  RDMA/siw: remove unused loopback_enabled = true
  RDMA/siw: add and remember siw_device_options per device.
  RDMA/siw: make use of sdev->options.* and avoid globals
  RDMA/siw: combine global options into siw_default_options
  RDMA/siw: move rtr_type to siw_device_options
  RDMA/siw: [re-]introduce module parameters to alter the behavior at
    runtime
  RDMA/siw: add support for MPA V1 and IRD/ORD negotiation based on
    [MS-SMBD]

 drivers/infiniband/sw/siw/iwarp.h     |   8 +
 drivers/infiniband/sw/siw/siw.h       |  21 +-
 drivers/infiniband/sw/siw/siw_cm.c    | 268 +++++++++++++++++++++-----
 drivers/infiniband/sw/siw/siw_cm.h    |   2 +
 drivers/infiniband/sw/siw/siw_main.c  | 173 ++++++++++++++---
 drivers/infiniband/sw/siw/siw_qp_tx.c |   3 +-
 drivers/infiniband/sw/siw/siw_verbs.c |   2 +-
 7 files changed, 395 insertions(+), 82 deletions(-)

-- 
2.34.1


