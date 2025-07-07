Return-Path: <linux-rdma+bounces-11944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3237AFBE15
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0367A32F2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 22:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D029828F955;
	Mon,  7 Jul 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fkg3HJpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BAC28BA9D;
	Mon,  7 Jul 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925824; cv=none; b=SXlFd9MN71KObhiixZCQL050Vek5tB8hFGmqsgRoA4LzNIhd/3heNHTUkxkW8998LuwrKyZ4JFzH4AEGjB8dFZ52YYxYijCRJYXU8GxGyREC2bUyo2ON2iRAUL77vRG71OLiIY5dxIvruJOfIGbRfyDHxq++IJtPghA6IgdjLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925824; c=relaxed/simple;
	bh=Pv3cdtRYR+8RAzNhg8UHDBTC+Z9xW3JmWHc0M2qgHMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WC+pDqXsZ2NqK0hKCJagaO9NPIhKqM28eJhjYcjtknOiC3Hjh8dNbTe7FyM8NsGY61sOwcIEqiiWP5hvO11oJE68P6cVZCMNjJhhDWz3zncmH5swB9Qcoh6C3TsHhBdhgkZMdm0h4Mvd6Y3i8JLKwD0MF8IM0oXeyQHTrmKgfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fkg3HJpF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from easwarh-mobl2. (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D9B22054680;
	Mon,  7 Jul 2025 15:03:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D9B22054680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751925821;
	bh=xNWC/0DZp7yoXd0DedMxkG7j3oORN78XzbDIgm9XdK8=;
	h=From:Subject:Date:To:Cc:From;
	b=Fkg3HJpFQ+oDhLroLbYUEW9qEZwFbYxy7oALwDyhqNw1CuuIltqHEMrQqLCyTbbn1
	 WWu4Gak8okrtXC9vo/7XmN2kWZEj7hTp5J41T3wGJft04dM70+IrwyG58vWSym84jl
	 A7eUzam1ws+s/b8AtADkPkWdwnnHpyVg6vxxi6OY=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH net-next v2 0/2] Converge on using secs_to_jiffies() part
 two
Date: Mon, 07 Jul 2025 15:03:31 -0700
Message-Id: <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNEbGgC/4WNTQ6CMBBGr0Jm7ZC2/ARceQ/DAstUxgglbW0wh
 Lvb9AIuv3x57x3gyTF5uBYHOIrs2a5pqEsBeh7XJyFPaYMSqhFSdbhSmCiiJ+0xWHyxMYnHbXQ
 BFXZGTKqpGtG3IyTH5sjwnv13SGjC9wBDemb2wbpvDkeZ/9xQsv/TiBIF6rqrtW6rVsrH7c3rZ
 y8X1s56a0Kp7QLDeZ4/OSsimt4AAAA=
X-Change-ID: 20250128-netdev-secs-to-jiffies-part-2-8f0d2535096a
To: "D. Wythe" <alibuda@linux.alibaba.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-rdma@vger.kernel.org, 
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

This is the second series (part 1*) that converts users of msecs_to_jiffies() that
either use the multiply pattern of either of:
- msecs_to_jiffies(N*1000) or
- msecs_to_jiffies(N*MSEC_PER_SEC)

where N is a constant or an expression, to avoid the multiplication.

The conversion is made with Coccinelle with the secs_to_jiffies() script
in scripts/coccinelle/misc. Attention is paid to what the best change
can be rather than restricting to what the tool provides.

This series is based on net-next.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

* https://lore.kernel.org/all/20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com/

---
Changes in v2:
- Implemented report mode for the secs_to_jiffies coccicheck script (Jakub), patch has been queued by Andrew Morton in mm-nonmm-unstable
  - Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-unstable&id=a01189aaf16e8d8d619067939ea21ea97a279864
- Drop change to netfilter already merged upstream: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4293c2baf6faa5f1a1638bcce698ed88d0d396e
- Link to v1: https://lore.kernel.org/r/20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com

---
Easwar Hariharan (2):
      net/smc: convert timeouts to secs_to_jiffies()
      net: ipconfig: convert timeouts to secs_to_jiffies()

 net/ipv4/ipconfig.c | 6 +++---
 net/smc/af_smc.c    | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)
---
base-commit: 6b9fd8857b9fc4dd62e7cd300327f0e48dd76642
change-id: 20250128-netdev-secs-to-jiffies-part-2-8f0d2535096a

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>


