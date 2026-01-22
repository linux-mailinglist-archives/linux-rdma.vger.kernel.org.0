Return-Path: <linux-rdma+bounces-15894-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGjWHhpvcmlpkwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15894-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 19:40:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00D6C903
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E7033009B33
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5811A9FB7;
	Thu, 22 Jan 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8EEmdl3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFD37FF57
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107217; cv=none; b=jPB/tzZmrhc64LdqIjU1pW31s1FHnqWNahp3a0E9uLUHBax8wzXY5qMl/oY1OMiUdHepYEaOJcqn9ZuJrjLyv6/soLJMDKZSqUBntwt3VIqN0VnyNOTxxJwgUCl/zJCiOXH4orWOVVVhIM5u5ptt7P04xfS3sRO8SQqK+nD4ZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107217; c=relaxed/simple;
	bh=QRCHqMHUl6k4oyqDF1yNGbk00enGNL+39HiKgi93CiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XddDqpZ7vN3SrEy1abikHv4FQjJKGI+6ZKDB1lrPQllSuaMDdjAhax6fyl1Hsm2lzJKxAKZoWUR44zUXhgtBw/hGeGRoRoWgkQ1o7mcvjoxTnHLoFsm0puWXbo4nAEkkC/FVR974TCBPqlLUh6h/mE4vKhv9p0KjUJxBluW3bBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8EEmdl3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0834769f0so9619665ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769107209; x=1769712009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kwJ0a0SAodTDho6g2OsEkjwx23towh2Gp2df1yGT70=;
        b=k8EEmdl3q+xkmOq7vPovi1eGg12BR/dsLNka+NWBRzYjbTigXFTNQtYhME4rzt4l0P
         Dpqv784CW0Ae0HCM5BHpSjTu9bo4XEHGdzrxPIKlScy/LtShO4dBZMf1LGgolWdFw3mm
         vuLdwXzxcpysCWEAIwlNTFtudEkL6YFPCcTFDsGvewRNzfljVAoLnObbH31q2Kd+FXzt
         jVV1H44fsGpspgWcjgRbDbzRwC5MC2o/qNszdWw+CQVTfokxK7mObZxGiuyiQ39qDrui
         RQKrCQtuzyeZaasC1UfBl+YwBhOMUjQDibBXbnEbJGe2Q3oiIcL7COBMX4k/bA7m00l2
         RK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107209; x=1769712009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kwJ0a0SAodTDho6g2OsEkjwx23towh2Gp2df1yGT70=;
        b=ZF5ztWrW7m0AIf1eZl1fcFVgZvleDyPF/V5uD1YLnoQMHuqZzeqqPmzC7PfnK502s8
         f8k/1R8DkllQTiyAy7H+AioSkDdEdcDX7grq7FTDVARcDtYgCfcwC8GH/1cAC+fidrD+
         MNBkLpgZdnKjfEjNh8p9nWTId6UHehvW+eQuqryS3dLHdXvEqJpx6twHbzIidgWQch5j
         tW5Q1vCmy2X1kGDcSimuBSs41QZAbSo3Nmn2+Xufz0la1ZTbpcM/R18Ntva/MazdTgEE
         58lKF/8+YMIVP9yh8G7xjRsEm5JHzRYm2339viXbb1NCk5gvpHnWhgNucDFVOTOe4cJm
         8z2g==
X-Forwarded-Encrypted: i=1; AJvYcCUBQPutDbcdGq6TU4x6QSycjWtpsIMsfHm3MStgMcgqGDfxe8gLtUCS/YH5sxvWhCIW2MY3dOaELtOO@vger.kernel.org
X-Gm-Message-State: AOJu0YwCag0es4+3KB6ICypnJaA5WOEHIWSakyC0gX+KCvbnlZkr0R55
	SlCVUW2mkw0P+3blIYEcciRL2Ic6YVd2dSSVm0XDjXT3gSHFA0y4sG8=
X-Gm-Gg: AZuq6aJ75IUID1qCA8e4cRzqAzs7mAP2SNh9MOaMrOnoDJPoz9Uhiaj3ZJQ64x9eH4W
	PvvuP4zH1+r5/BshY1bLRsVuU22qF/1vh/N9S9+r1Fwf8ZwgEUVUEk47uBky5dQff6YnxKUsUa4
	ntFV41pFuUhlj9SeCTzZZAQKkVYsJ8qX2O8KcF6N+UZMqW+0o7mnGLIiFf8XrLd3QZjns8X6i5J
	LLldwjfzCdwO5bCm2qgSyaFTTbaXqfnB5IcVgWCnqMLgYNT/bjIkRXwCJWWh42/8qlPfsVTJx13
	0wtmAB5U4vbRVf53rPm4Ls90Nzi+NVK0KSGvC+vLLFZPLHNto8HcZq8RMF18vLpDRTdZpeUzoQ0
	E8W9yhssgrwhhffqextaqvKrD9rnn/6gYI3DlIkK9v63DzuuBmQ0XXZm/qcxeCEIvPTUBcL4SVp
	FdRfJxXOd5uXyUAF4=
X-Received: by 2002:a17:903:1208:b0:2a0:bae5:b580 with SMTP id d9443c01a7336-2a7fe44aca3mr4062115ad.3.1769107208630;
        Thu, 22 Jan 2026 10:40:08 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd523sm191817745ad.62.2026.01.22.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:40:08 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jackm@dev.mellanox.co.il,
	ogerlitz@mellanox.com,
	monis@mellanox.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] net/mlx4: fix MAC table total count corruption in __mlx4_unregister_mac()
Date: Fri, 23 Jan 2026 02:39:07 +0800
Message-ID: <20260122183906.2015-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dev.mellanox.co.il,mellanox.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-15894-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D00D6C903
X-Rspamd-Action: no action

In __mlx4_unregister_mac(), when operating in mf_bonded mode
(SR-IOV with bonding), it appears that the code might be incorrectly
decrementing table->total instead of dup_table->total when cleaning
up the duplicate table entry.

If this is the case, it would cause the primary table's total counter
to be decremented twice (once for itself and once when it should
decrement the duplicate table), leading to counter corruption.
Over time, table->total could become negative, which would
break the "table->total == table->max" fullness check in
__mlx4_register_mac().

The registration path correctly increments both counters:
  ++table->total;
  if (dup) {
      ...
      ++dup_table->total;
  }

However, the unregistration path seems to have a typo:
  --table->total;
  if (dup) {
      ...
      --table->total; // Should this be --dup_table->total?

Fixes: 5f61385d2ebc2 ("net/mlx4_core: Keep VLAN/MAC tables mirrored in multifunc HA mode")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index e3d0b13c1610..6d0295c471da 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -410,7 +410,7 @@ void __mlx4_unregister_mac(struct mlx4_dev *dev, u8 port, u64 mac)
 		if (mlx4_set_port_mac_table(dev, dup_port, dup_table->entries))
 			mlx4_warn(dev, "Fail to set mac in duplicate port %d during unregister\n", dup_port);
 
-		--table->total;
+		--dup_table->total;
 	}
 out:
 	if (dup) {
-- 
2.34.1


