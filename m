Return-Path: <linux-rdma+bounces-18852-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJOAI1Xqy2myMQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18852-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 17:37:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24936BD98
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ED58306908E
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD02421883;
	Tue, 31 Mar 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM6e041D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9E41B341
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971186; cv=none; b=RBTVPBZbfFQbrj10NUX6BK/UTPr7FtQ1p01TdSLuPiJrtbX72DkNqcihU8BeNeunIz+Esmofb/h23jCqQLKH2SyLw+hcKxRNvSa0UUhfrQgqmRdVBlf+qsgE+ssGGHuMSab94XHopU6DNSfL864zjGToO7+jLFD+w9ihz33x4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971186; c=relaxed/simple;
	bh=sq6xb1uQpPCxAKf1n02HR0j56fcBej+bOep9xHO9y90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2xF8+KaPDGKoiSV16fSx65w+E4Ycg2vx7cMxUpKSJPHCQRrlp/20Gde9Ou4OfSei061duGhoNzGxU4hnrF6VQpe5yW1BPjlV0JFhZ1bcEZhJcBd7HbT5oX0G7AQsw4nNkkZwKkULq6lSKACRLxH2o73JB2HAEka0qgyMHWHmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM6e041D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fe655187so76388205e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971166; x=1775575966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwR2mxqLujSdr9bI9JYKZsbivVm2a+2JAgTiRA8SLEY=;
        b=YM6e041DX/x3aGnUHEZb6REb6VQLiLuyvjnmD1UtNbB/QwfmURMbyScTo/ehcm5VAH
         jHMO2IDt95mSfCuObQReB3uNDNF6nMexi17XcOjFCRaUOfq3Kw0v081BCAeGCPghLD6r
         XE1/kBs7NyuUPn6cGEpoYyezdFYwNXnScxomiyVtUDkhTxZaDPhbrsXiL/0/qkF8c1LY
         brM4LersWeNvHLlWzqf8S8xHGzSMMA+a86KdJF5g3AJGLWaIL1ZuiuxscRlcDJfvP3x1
         KL3IvM9fkfJLFN6tpE20Z+ylf7YOtDzhSvmRF5yFRTBLMH0puuomJaCtkeZCDklpg1lw
         mKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971166; x=1775575966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwR2mxqLujSdr9bI9JYKZsbivVm2a+2JAgTiRA8SLEY=;
        b=ZD3dUaQk6WZ/G3/BKU4tdz7fhIpjS9QGml74061LXVXvwFo2vyzWwf1sJ1L523tpC2
         LJ9XJkXO6qFTQ+mb8qPdJypEkxtqYRX1kpoF+6snHTKctviHX6zW62sjpARhA6/ut6r2
         6Dr4esqsQdaK2uwmcOiL1SwdIrjaO3K/r8bZW1dVVczJm9EJCTca4Ayxsi+DLBE5EKMZ
         SbkdRPMskRmcS0FwD5tKMHDk9F8AMW3eFq0EiLGDSE+HdON3IWYYcbm6m5qk+uSpZd9f
         EzOa0Mu9eY1dNj9/REnNOpIe3UM69qPg356LrFZ430/rDsX6Q1Z8tLGfLyjm6qDr9E1/
         r4mg==
X-Forwarded-Encrypted: i=1; AJvYcCWzFA3e326g5wGbm0UMuZzPV5rU8arKeMzANIYIjKFthvKe/wqUqKjQ+bHYF9pBv0NowfFN7VT1QVn9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UdK43HRc0lDXYnlTAr9Y0bzs7dTSJ4Rt1I6PJVp7S6JiaQTD
	GRD9OyFdP8Nw78Ggxc+Scjg+RsNSSFl4txZ5dI1M4iE9A20GpKuwoqKH
X-Gm-Gg: ATEYQzyTElsHU6PuqbTXrk0JZvZh1TX7G09oDU98u0rXDRDsC/gZ1feMvySlXVZ8sDp
	fmsMKPSW9Hu9xm2V/JFg7C+/LU1DS0i8RWr35+y4yk84OTB56V+mbzjqob6DzAN7TWnOzldie3e
	7gF5VAOVBld9G9AezKdXvWvus1Qz4yDp+GAm8df/UyQCoMJCHOlYdKK90nRiReatMp4DVwNwtiV
	1+yvF8qovT60Kh+nkcZwgagYarCuZ10CskyqvJadu5SfLiEHy1ofI0itlm6uIP4yjzIpuX66L8U
	j+4dtcamTpn4vP7cGuf0Tqq+hwWNsd2czyMM4Y79eCrJX7FdsxqzawjQk9ntRYUwaGSDUI4T+Mf
	8d50f9h+SQuk3mpTKgXGEwgXfTBWbsf1w1n1j+nCRD3RvMs+VLbBgQ0JukP9vleJktKjLfm8cSD
	bt7Ohk22hgElvfmC1uWTptYHrecXzry+P5tgSVfAXk7aBroi6KXd8A2XXxg7DdnQgSCy5xJQgvb
	ZUHw9yfgJxhRW+PFksYD2tOzRmRL3ufB7bAbW9KRBgXtzqa
X-Received: by 2002:a05:600c:5303:b0:487:2439:6266 with SMTP id 5b1f17b1804b1-48727ee5445mr282184885e9.30.1774971165955;
        Tue, 31 Mar 2026 08:32:45 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c769841sm23908335e9.7.2026.03.31.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:32:45 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH] net/mlx5: Fix potential NULL dereference in PTP event handling
Date: Tue, 31 Mar 2026 16:31:51 +0100
Message-ID: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18852-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F24936BD98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ptp_pps_event(), a TODO comment correctly identified that
clock->ptp can be NULL if ptp_clock_register() fails. However, the
code proceeded to call ptp_clock_event() with that NULL pointer,
leading to a potential kernel panic.

Fix this by adding a NULL check for clock->ptp before calling
ptp_clock_event(), ensuring the driver handles failed registration
gracefully.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..9e9f844935b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1185,8 +1185,8 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		} else {
 			ptp_event.type = PTP_CLOCK_EXTTS;
 		}
-		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
-		ptp_clock_event(clock->ptp, &ptp_event);
+		if (clock->ptp)
+			ptp_clock_event(clock->ptp, &ptp_event);
 		break;
 	case PTP_PF_PEROUT:
 		if (clock->shared) {
-- 
2.43.0


