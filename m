Return-Path: <linux-rdma+bounces-6435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438539EC8F3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC8A283773
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CA623691B;
	Wed, 11 Dec 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uZIPBO73"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011801EC4F7;
	Wed, 11 Dec 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908902; cv=none; b=hki+r2vtdp5/UrH+CKrNRvm/w3Gmzr/Q+EqSryKXR+QWJDlwTHxY1NYT+Xs2g1jPa9xHWCLrzYBI9e+AK1/6VZk+gIZJeq4WABp0Q8uccbxi6VAZg6Jp6P7xD5q32vQSZH54tZsasuNKXRq+hAjQsq//e+sg8BxeM0PoF8SFTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908902; c=relaxed/simple;
	bh=7cNR9sPKjlv74hVDIAta6WaRBItnKamKOO+1+0PELeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDcv7zzHbs4rnVbTzwjVmmwElBBUmx2rFLRM7e3lI4TUooyN+WSnEQY5PFQLfTIS7uOAzCAO+f8vhPiGbzIgh3dTNlp0lr0bfUBZtkLa4YXC1pXI1sjFG1O9CvUcpt1LUqCkzmJIjfMpD+//IYW6fRhwKV9nsgkTyi4zs4n9czM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uZIPBO73; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733908891; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wmGAcTq5MjmsZbKOqge4Pnbx9JraZR20R/WgEzVghQY=;
	b=uZIPBO73IE35V2AYQl41n1tnckUf98/rO2wtanbi4bFszlKD1YpRJjvjZnDZaPcEVIfDCB+1PiB2WfMQwYpTgxjB/mzpMK4drusTd0zJyx84gOtxcX4C9FIeXWJZ2xZauorKkyF86oeuXYYM7sOfnLHAQ4IfpgzEo0w+efkHLn0=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLHtOmX_1733908889 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 17:21:31 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/6] several fixes for smc
Date: Wed, 11 Dec 2024 17:21:15 +0800
Message-Id: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 -> v2:
rewrite patch #2 suggested by Paolo.

Guangguan Wang (6):
  net/smc: protect link down work from execute after lgr freed
  net/smc: check sndbuf_space again after NOSPACE flag is set in
    smc_poll
  net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving
    proposal msg
  net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving
    proposal msg
  net/smc: check smcd_v2_ext_offset when receiving proposal msg
  net/smc: check return value of sock_recvmsg when draining clc data

 net/smc/af_smc.c   | 18 ++++++++++++++++--
 net/smc/smc_clc.c  | 17 ++++++++++++++++-
 net/smc/smc_clc.h  | 22 +++++++++++++++++++---
 net/smc/smc_core.c |  9 +++++++--
 4 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.24.3 (Apple Git-128)


