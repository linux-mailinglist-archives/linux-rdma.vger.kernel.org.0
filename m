Return-Path: <linux-rdma+bounces-5877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB19C267C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 21:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50614282843
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905C1F26FB;
	Fri,  8 Nov 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7eN4L2e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28701EABA2;
	Fri,  8 Nov 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097556; cv=none; b=hQcs8E+OFVil9I7Q+wIj7SoTKhC2WtcqB3jVjU6aBgSM7HJRA6HoEdDmDwyo1jv9ooF08XqHMEuEpPRxhxwlT3SADdz4ddhZSY74xpxP5U3PvZ9c6zXGFfMxfOPCxvsh7CEvTw59DQAh0gOHhmyXV+hNuIpgB1dNrXLCZApXA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097556; c=relaxed/simple;
	bh=SW9sqs7q/nfSn6SZFdJrxHOxVhgt7idMNp23czW+ZzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TeVJjBsQl2P3YfsKemC8BUZiolAYqdQU/pmFTWcHEm9BiiBN5g7C5AY9yyjVGJZtEuPxQCzVYtAF/sNPSYbD/OaiWkSnywDA2BxT09WH1OJGd9rYNBGTpGSrnYRf9FXaVU1RBzBioVqWmYHB/iTGT9GocdVv3IW/lTHD3KA9xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7eN4L2e; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2251387b3a.2;
        Fri, 08 Nov 2024 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731097553; x=1731702353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HjsnjJkvFk70FIP+kt5SypebIuFSVyDViD7ncvBNOtM=;
        b=M7eN4L2eJeuC8o38PBsuXGz2kfy2AYKYacVZBPrUrLWS3bzHsdjAW5UAbM3Hd8b6iw
         37n4jS1Hmlc7qnGEEsABgkeNZVrOuqIChJIZ/smFVzIJ7RKaONHeddyw9qNp/DOkbPag
         PM22QnCbVQunQJTZIjQxX2uTLm2peSW41Zvwopo7rV+auvp122SSl6YX2BTAXcBKh1vB
         RRpptjyEcoWyc4KCuv5SZTp2tMr0OCEteM4455vVkRRRPb00lgvW6di4mpYDC8RHk9Xc
         fBTGLqb6zBWu8g1FUZx6MlBDsoEJ2UJShgrOpbzwJvYfJwwgmQx+Tb/PSKLkFnoQouTA
         C5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097553; x=1731702353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjsnjJkvFk70FIP+kt5SypebIuFSVyDViD7ncvBNOtM=;
        b=MSRZ6bn/0cmmcZJYbWR0vf2DPDi5aE3n+11OnpuVbAJty/miBUNMYIBTb1Ziy83WKo
         y2gRrMYfmY2xcLdiCjvUHm6FwMsZeHDfFYz7I54DSwZIz2fZR4Rc6uwlVezkQrxULxij
         OuirL8/qAYkeNSP2smFffa9k84fNd0zECZm+ywxwiYZngJoo76ttHXemygzIxtwzL0kH
         aaDRNhzPLwDgkvHywOiYYvNW6rW9tIemvM7vQ72niYd/XW1bu7p6Sxfu+QN+mFBCm1A5
         eEPfQGVkKRaYnemM+D43R/rWmG4Yl7HLoayw2xVUbmKP/37ulJV8cMQDpsK8/qTCcW+B
         a+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSkdJJ72VhSDlYDOZoq0dzEfq646CCXmLou1LaP2FAi/w9pGHvMtjNlcc58ku+K/YyNI58nigkuGI=@vger.kernel.org, AJvYcCVJjqpFDy6oG4MhYOtkz+hDrn914DGEN11UKCdNWe9NXTiaB7FXcjV2yM+hB9QjaKRPo2vhyHaWzUqo0zgR@vger.kernel.org, AJvYcCWiVHRZLFe+Ap5An8r8MJwcmpguOsew3k43HHOCXOVumMc59RZu88ucerz/fsaWiRxO1EMaXdwpFq8LvA==@vger.kernel.org, AJvYcCX38ph0e6aWdiVyd8qM/0WpOEUUSSoEoji/X3q5Y0dqXHg02fC+pFQv97L8a9Y7n0aEM8opUPfj@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOYOG/zVGbAh1trsYUL18PuWyGeSlwyi8+RGosGxIXRymNOd9
	A5Dpl6ZYrMr7ZnE47RFxOH7DlV8gdZExeiyVcVZLJAvQ4fEzT7nD
X-Google-Smtp-Source: AGHT+IEqu6hYITG3CTRQf4ojcYGFShTgO4TAJ9wD/3E0BVbXGMBR2cq9fgn6Jmxx9FvlAPL57EqxTg==
X-Received: by 2002:a05:6a00:2388:b0:714:2069:d90e with SMTP id d2e1a72fcca58-724133966b8mr4742841b3a.26.1731097553013;
        Fri, 08 Nov 2024 12:25:53 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ef5sm4342095b3a.63.2024.11.08.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:25:52 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Russell King <linux@armlinux.org.uk>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH 1/2] docs: net: Fix text in eth/intel, mlx5 and switchdev docs
Date: Fri,  8 Nov 2024 13:25:47 -0700
Message-Id: <20241108202548.140511-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix various issues across networking documentation: remove duplicate word
in drivers/ethernet/intel/iavf, fix quote formatting in mlx5/counters,
correct typo in rds.rst and improve wording in switchdev topology doc.
These changes are purely documentation cleanup.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst          | 2 +-
 Documentation/networking/rds.rst                                | 2 +-
 Documentation/networking/switchdev.rst                          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index eb926c3bd4cd..73ce04c05071 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: 'channel' with 'hw' set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 99d95be4d159..b23f36a2d28c 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -1135,7 +1135,7 @@ like flow control, FEC and more.
      - Informative
 
    * - `rx_pcs_symbol_err_phy`
-     - This counter counts the number of symbol errors that wasn’t corrected by
+     - This counter counts the number of symbol errors that wasn't corrected by
        FEC correction algorithm or that FEC algorithm was not active on this
        interface. If this counter is increasing, it implies that the link
        between the NIC and the network is suffering from high BER, and that
diff --git a/Documentation/networking/rds.rst b/Documentation/networking/rds.rst
index 498395f5fbcb..955afe0567aa 100644
--- a/Documentation/networking/rds.rst
+++ b/Documentation/networking/rds.rst
@@ -339,7 +339,7 @@ The send path
   rds_sendmsg()
     - struct rds_message built from incoming data
     - CMSGs parsed (e.g. RDMA ops)
-    - transport connection alloced and connected if not already
+    - transport connection allocated and connected if not already
     - rds_message placed on send queue
     - send worker awoken
 
diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index f355f0166f1b..df4b4c4a15d5 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
 monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
 bond will see its upper master change.  If that bond is moved into a bridge,
 the bond's upper master will change.  And so on.  The driver will track such
-movements to know what position a port is in in the overall topology by
+movements to know what position a port is in the overall topology by
 registering for netdevice events and acting on NETDEV_CHANGEUPPER.
 
 L2 Forwarding Offload
-- 
2.34.1


