Return-Path: <linux-rdma+bounces-2389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A08C1D5F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5401F234BA
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 04:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873D14A088;
	Fri, 10 May 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NYfEIs1i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC6149DEB
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314631; cv=none; b=UspcvVh2i98r44lCEacGCF3jW6J+o+b2EFAcaZTc28cqm+tHS7oU/qmB9R2KcxUcAY1x/E8oBDS2bu2O86fT3xAho5hp9Lu4DidNG3OmMuPn5d6cxXtuydp7lxdtI8ngmnLoDQUx2nbgIba6YBaOpGV+v9lyPNCfp4JdBGqnsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314631; c=relaxed/simple;
	bh=EibtQAHnFtRUSOtAKaCqEgiTG0C9qMUS/y81xVi4+lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XVF30U/m18tdkoDH9pkVwVvOgy/RsupO/X6PDM90cER2Ug0APwlXgEqXNlN7hbHu0bdDgQ4lSHtAnQ239BpUG2EClFsfho/tbz7T+bdiHoXSRPeMev/LSxTl6IY0xiR2zuOQYCsfUpOWNi8HDvvcXNxsvRNPxtHQkNbzbtYjCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NYfEIs1i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed012c1afbso13443045ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715314628; x=1715919428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXDgqThLEf+1MK7OUIb5eDMEm4b6Ug9ZOeqtANDTTtc=;
        b=NYfEIs1ibIewnfTafxYtIvDeKitVs7s0OiBdS33/3vCpvH7dbUrKA6zhjjqdDDZM1a
         cEZIsSHtulVdRaIU5BK4Lzou3OgJ/XpQV24phdhKqJrDBnQL/29Sx9mGbVIMV4ap1Wha
         vqK0Y6Wpa0RBLyUgtVJw05h7gaFvwm0EegYu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715314628; x=1715919428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXDgqThLEf+1MK7OUIb5eDMEm4b6Ug9ZOeqtANDTTtc=;
        b=ifBWcVE976wUy2PfwQgx61+oGPYdPuIsdGCoKYmfpSkLPqBscNYepQR4lBJz800aYk
         S9oNry3C0jcUjwJLagvhNyR2dmQE5OHOWF4sHG9kaShaCdaMojs2B3HquTGNZ8YsF6Qo
         8hJ1wAqUQxoTeHV16ic9zCO4gJ1u9eHBVB1KBw8uoqT1RH1AX6zoZ1Tcp6zx+lyi0Jin
         /A62iATLccbnX5eq+CgcZJQMzTSo13okR1TV2cg8H5FYKobEmYRZ5QZbTeTz0GzosvGq
         KToZreyi0mFB232rQ2EP5/VsMoqfmGk6IXPhbpjs/0AG87J9uNpOIWA5Jt2K2lS7HdDa
         GNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYx0JlwGsahQxC7MYdrJ/CDBA9b3sgefkGhSZwx3iXFS3liZHxG8Lf1PYOdUtchD2EZuWHY9ePETmJp4WfNmWoImCEkgANFHvLDQ==
X-Gm-Message-State: AOJu0YwsybHeoi/tTEZGPiNehQ4p0OOM4l8XWMxShXeROg8quIKLFfHD
	cCFj5R/q70AZ7TLp1kgUHVe5SzAl0Gx3dYV3n4X6Rk7faozPtClugSrtoxsHUwo=
X-Google-Smtp-Source: AGHT+IHIqH6sntsrOu84pPR11fW41JGaUw9sHLI7Wb0p61OYBDRv0bkJGtmOfmevfxtCMjN1PyGxdw==
X-Received: by 2002:a17:902:d2cf:b0:1ec:25d3:7335 with SMTP id d9443c01a7336-1ef4318d713mr22562215ad.26.1715314628252;
        Thu, 09 May 2024 21:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad634asm22617485ad.87.2024.05.09.21.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:17:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v2 0/1] mlx5: Add netdev-genl queue stats
Date: Fri, 10 May 2024 04:17:03 +0000
Message-Id: <20240510041705.96453-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

I know that this is only 1 patch, so a cover letter isn't necessary, but
worth mentioning a few things.

This change adds support for the per queue netdev-genl API to mlx5,
which seems to output stats:

./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
         --dump qstats-get --json '{"scope": "queue"}'

...snip
 {'ifindex': 7,
  'queue-id': 28,
  'queue-type': 'tx',
  'tx-bytes': 399462,
  'tx-packets': 3311},
...snip

I've used the suggested tooling to verify the per queue stats match
rtnl by doing this:

  NETIF=eth0 tools/testing/selftests/drivers/net/stats.py

I've tested the following scenarios:
  - The machine at boot (default queue configuration)
  - Adjusting the queue configuration to various amounts via ethtool
  - Add mqprio TCs
  - Removing the mqprio TCs

and in each scenario the stats script above reports that the stats match
rtnl. Hopefully, I got all the test cases right.

Worth noting that Tariq suggested I also export HTB/QOS stats in
mlx5e_get_base_stats.

I am open to doing this, but I think if I were to do that, HTB/QOS queue
stats should also be exported by rtnl so that the script above will
continue to show that the output is correct.

I'd like to propose: adding HTB/QOS to both rtnl *and* the netdev-genl
code together at the same time, but a later time, separate from this
change. Would that be OK?

Special thanks to Jakub, Tariq, Zhu and everyone else who chimed on the
extremely long thread for the v1 trying to help me get this figured out.

Hopefully, this v2 got it right and there won't need to be a v3 :)

Thanks,
Joe

Joe Damato (1):
  net/mlx5e: Add per queue netdev-genl stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

-- 
2.25.1


