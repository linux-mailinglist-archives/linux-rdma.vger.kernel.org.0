Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8C3D8E77
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhG1NEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 09:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhG1NEa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 09:04:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CED5C60E09;
        Wed, 28 Jul 2021 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627477468;
        bh=zKOZTbUMp5AJtaPv27GbCPX8qdvMV2ASVi06hUCJP+8=;
        h=From:To:Cc:Subject:Date:From;
        b=tZruiOoTZmHXzwfF0tB3I4HNztJBnhsBBCOsiYb7lOeeFZRW5h5wg1caGMHV6wSHs
         YztWu8l/5D18CSSbBwwgNiF43EQbyKcNq1RuCW11yv4lVFFsjHIzkFV2AZMhXhpx3q
         cQ0tWsgNUWeSGNMU21nvpB0Q+KBCkbyW9mAm6XvaH+PThBFCwW/77nMQ3ulxSalWgC
         fANuZyYlXOVGoU6I7eXtzjRzti+ZyNWAHmFur4iCuRrCt0S3gNsfq82ufIiEHlQFfV
         ojHlLBRpsBtnaGCRgwEaBRRtuHzA6Dymj/DJGDv+I0GzW9z47JchAQMBQD5imtNtrp
         L087WKnxNNQVQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next RESEND] docs: Fix infiniband uverbs minor number
Date:   Wed, 28 Jul 2021 16:04:12 +0300
Message-Id: <bad03e6bcde45550c01e12908a6fe7dfa4770703.1627477347.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Starting from the beginning of infiniband subsystem, the uverbs
char devices start from 192 as a minor number, see commit
 bc38a6abdd5a ("[PATCH] IB uverbs: core implementation").

This patch updates the admin guide documentation to reflect it.

Fixes: 9d85025b0418 ("docs-rst: create an user's manual book")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
RESEND: https://lore.kernel.org/lkml/YPrJorr7r9Kd2IzA@unreal
---
 Documentation/admin-guide/devices.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 9c2be821c225..922c23bb4372 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2993,10 +2993,10 @@
 		65 = /dev/infiniband/issm1     Second InfiniBand IsSM device
 		  ...
 		127 = /dev/infiniband/issm63    63rd InfiniBand IsSM device
-		128 = /dev/infiniband/uverbs0   First InfiniBand verbs device
-		129 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
+		192 = /dev/infiniband/uverbs0   First InfiniBand verbs device
+		193 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
 		  ...
-		159 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
+		223 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
 
  232 char	Biometric Devices
 		0 = /dev/biometric/sensor0/fingerprint	first fingerprint sensor on first device
-- 
2.31.1

