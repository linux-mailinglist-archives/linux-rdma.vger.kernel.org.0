Return-Path: <linux-rdma+bounces-14658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE31C74F73
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D4993629AD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237003612F1;
	Thu, 20 Nov 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kyppj42h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7223019CD;
	Thu, 20 Nov 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651729; cv=none; b=KXpg9nOdcTIwX5aGLpl+a51Pn59h8ZWxSJxhvpXTte6hOydxz8TCRbHShsX0HHGk9KV87bInw4FNfI8NwFBKrAw7LfTzoZSJVhPAb+h+lUkRAgkWOMW00OLB0/mClKGTyr2TfWA5rO89XRKyAsNkyr5zCl6sDNrsJUn+znC7aDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651729; c=relaxed/simple;
	bh=qEP5AS74tK0c7P9eQV81SfItHNGKZNPzmBQKG7ur/7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKJvCDKp3/o2WNnGdSuISYBhvRyqm/XonNVN8lsajuTpSX59xLSSFFtAw2408O40kUT/Gl2UsENsrJSQjPW9T+Ih/SsMBWSzqLROvBfbklyeHiTTJWir/dvNd78IIQfxp4F2bHdtqwQ1OpsL+28GN4ajhjXYf0CYd8nQ8YLK1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kyppj42h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3915AC4CEF1;
	Thu, 20 Nov 2025 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763651728;
	bh=qEP5AS74tK0c7P9eQV81SfItHNGKZNPzmBQKG7ur/7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kyppj42hgWuSUxfMWhoZ8Lep6FcmDhRLbE46XuoEoqUno8bac4AT3nLfyD/5qhLq7
	 HjrOMX3XwPEarxvcSBI/DfBFMlz+e2vPNHTKQu7zVb4ACSCFYXIYmRTwE3SSs/PnUs
	 RxgYjpl6xDI/PzbTnlHFgssbK2GEAjCjLnkTQe7CupjsK+8N7kCxZ3ImqELYfoLHuu
	 M2TIoIU4qosjQ98pTLzGBo2807Iwl3BKAub9xeemBH7AX/fjljFEF/gIBmRm6c6/Du
	 ZvrL5OKs80DJYH9rkJwDNee1VgT0VKDG1d63wDwCGDb2fwieWhm03cvTbfU+taYILV
	 pg9idqSQZKEow==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA/core: Add new IB rate for XDR (8x) support
Date: Thu, 20 Nov 2025 17:15:15 +0200
Message-ID: <20251120-speed-8-v1-1-e6a7efef8cb8@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
References: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Add the new rates as defined in the Infiniband spec for XDR and 8x
link width support.

Furthermore, modify the utility conversion methods accordingly.

Reference: IB Spec Release 1.8

Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 3 +++
 include/rdma/ib_verbs.h         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3a5f81402d2f..11b1a194de44 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -148,6 +148,7 @@ __attribute_const__ int ib_rate_to_mult(enum ib_rate rate)
 	case IB_RATE_400_GBPS: return 160;
 	case IB_RATE_600_GBPS: return 240;
 	case IB_RATE_800_GBPS: return 320;
+	case IB_RATE_1600_GBPS: return 640;
 	default:	       return  -1;
 	}
 }
@@ -178,6 +179,7 @@ __attribute_const__ enum ib_rate mult_to_ib_rate(int mult)
 	case 160: return IB_RATE_400_GBPS;
 	case 240: return IB_RATE_600_GBPS;
 	case 320: return IB_RATE_800_GBPS;
+	case 640: return IB_RATE_1600_GBPS;
 	default:  return IB_RATE_PORT_CURRENT;
 	}
 }
@@ -208,6 +210,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
 	case IB_RATE_400_GBPS: return 425000;
 	case IB_RATE_600_GBPS: return 637500;
 	case IB_RATE_800_GBPS: return 850000;
+	case IB_RATE_1600_GBPS: return 1700000;
 	default:	       return -1;
 	}
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0a85af610b6b..6aad66bc5dd7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -859,6 +859,7 @@ enum ib_rate {
 	IB_RATE_400_GBPS = 21,
 	IB_RATE_600_GBPS = 22,
 	IB_RATE_800_GBPS = 23,
+	IB_RATE_1600_GBPS = 25,
 };
 
 /**

-- 
2.51.1


