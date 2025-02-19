Return-Path: <linux-rdma+bounces-7861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B910A3C9D7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91911885C07
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B923C367;
	Wed, 19 Feb 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gvUN7DSz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D11B6CF5;
	Wed, 19 Feb 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997039; cv=none; b=haw8ksHYZLrVYI22cvlnLGb1o1O0rb3ExSRJFdg9v4orjed2irtNrVHM1R2M244mgaCLbWFaw0ex1aWKav3hPFdaeZ17rLvzgvZ1l1+6BiDjaEn674iiKW9PYZ2OkR69xShCkBtPyZlyrQE+/ngsLB8q2S2d4vepzoLzL+AdxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997039; c=relaxed/simple;
	bh=iSh7RQdc/sccudkQ5pUXh58n+rYkXbgItZcBzQUVl08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TN72p9OJWNixGK0feHikei88VWG5cx0WzYtaArw6XGc2ytcAMmi8wX9SuPsNBhpBQ9lSrO6KZf9jCmsZcCcJLPT688xn6U02ZXjSpq/N0z2lCPJYbXcV4uUvdaivG4sZAEfWS2IYandK5xruQay5yl/JuW5S3py25DoYSUMUPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gvUN7DSz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id D6BF62043E1B;
	Wed, 19 Feb 2025 12:30:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D6BF62043E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739997037;
	bh=jaqtwsDQCTOG0vwdN99+rVafX0o12jqei48RbqmPu+M=;
	h=From:Subject:Date:To:Cc:From;
	b=gvUN7DSzwHUk+kj/1fUSkFixkZhvmywRnxiUbXTtsRDuz17gtreRD4wlImbxI4773
	 ZR9OBvQMtmvolFv57jeJAAN4LALcBaf0czEA+hfWAYs4sy/y/6aEKCRjRh6FCUk7NA
	 mpJC7kKu/UnJm8lsAXd5WRiPnNXiL3zvMnNVBiS4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH net-next 0/3] Converge on using secs_to_jiffies() part two
Date: Wed, 19 Feb 2025 20:30:35 +0000
Message-Id: <20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGs/tmcC/x3MwQqDMAyA4VeRnBeoGZVurzJ2KDbV7FClKSJI3
 33B43/4/guUq7DCe7ig8iEqW7EYHwPMaywLoyRrIEfejRSwcEt8oPKs2Db8Sc7mcY+1IWHILpF
 /eveaIthjr5zlvP8fMGr8bPDt/Q+d/1MVeQAAAA==
X-Change-ID: 20250128-netdev-secs-to-jiffies-part-2-8f0d2535096a
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
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

The non-netdev patches that include the update to secs_to_jiffies.cocci to address
expressions are here: https://lore.kernel.org/all/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com

This series is based on net-next.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

* https://lore.kernel.org/all/20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com/

---
Easwar Hariharan (3):
      net/smc: convert timeouts to secs_to_jiffies()
      netfilter: xt_IDLETIMER: convert timeouts to secs_to_jiffies()
      net: ipconfig: convert timeouts to secs_to_jiffies()

 net/ipv4/ipconfig.c          |  6 +++---
 net/netfilter/xt_IDLETIMER.c | 12 ++++++------
 net/smc/af_smc.c             |  3 +--
 3 files changed, 10 insertions(+), 11 deletions(-)
---
base-commit: de7a88b639d488607352a270ef2e052c4442b1b3
change-id: 20250128-netdev-secs-to-jiffies-part-2-8f0d2535096a

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>


