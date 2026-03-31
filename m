Return-Path: <linux-rdma+bounces-18819-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCU0Hjgjy2kMEQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18819-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 03:28:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D8363147
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 03:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA3C03034CB4
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC295146A66;
	Tue, 31 Mar 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsSJ16AM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCC31B114
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920499; cv=none; b=PR2Vzv6NPbKgTrJRm+FmpLcjOtO7KXisk1wO6cGW7iO+WbsAV198Cd/NAkPKYNMvRjS6Xw/NzSaRc5bWnQ4DU9GH0yK1TNWzv54ZRHfAvhhaQzn+y0B7POcdKskR4D8EEVtF38HVTg9Gae2NkKbM0S5JiJRw3JxalKk/NYcLyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920499; c=relaxed/simple;
	bh=+UHXiq3DLk4wG7vRu6ui8cu/yolDDZqVCrRLt7ViiDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2YYziqV6yFblPYnX2GDXN2WcXuwikFeh30VjM6265a5Haa68IKzEnVQUwfhlJzNOyvavNCvTEQpX+sdXAqXhmDd+NB24eQ360oDd63hDjGZVyV7xPYXoSP1BDgOLTs3ny94l6wkZwLtjoF7Y+UyT/nS56TvhXckv5clYBztRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsSJ16AM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so63368545e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 18:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774920497; x=1775525297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YPDvpyXCOzDlJuFgaLMvn1tDHlKgpSaFsJD9t6aMh4=;
        b=PsSJ16AMWOs8k6VrJWRuu03zqXXMRZqwLXjl0TPnpwMubA1GwTvOKMOTb1zG7U4/FC
         Dvw3Lkv9g4DWt0w9Kp21NFezItc5KiqXPNOdghkJl13P2lvvGYj8GLTzZl8MJ0kd5uGx
         VX2I9/r13LqqMWIeI2Pov6AlxagANfAmJz9nWw2XW3pjjeoWvW1Uzoj/HqvV5bZl5deX
         zVmJY3G7cPl8kz0glALErbLbgg0abBnQ2iLC7F6xJI+wPTSbcLy5v0iHyvohutjX6fXY
         yE4vIIdZrNRgQByTXoFqjcYeBBFOKmNBgNPKXe36eApiZKX8zBNZ0GT0QFOj5DBxik9i
         scxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774920497; x=1775525297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YPDvpyXCOzDlJuFgaLMvn1tDHlKgpSaFsJD9t6aMh4=;
        b=Zp2kTpGIELgi9ieUmtPdKr6TFFvlsEFUU7qdKz8WzY+2Fd7DjOrlQ/SBq2yez1JqG6
         yqkRjkFZmg59KTmg+gW+QfxF5xSgQ6uqsAXg5e3BCTFh4GTsEd8ngCSn8DmhJapsP+hu
         lmiE355nG0g0IkOfJGKmRrIqv/kaeayREGjdK4VVyN+IiACIvVYEtVNW7ROq4n7w/+pM
         B+E+Vq/8Tes7nGgC4O08Nz2/NZirgVZdW+MegNYwtemC+FsGltyOHZgVp6eOluDWeI30
         gpZ8iIggUnIjWq6QsSfOcDxBukwtC2oomVOrZsIi/wbNs1GylLIzS8eUbJ7cWhBcaapb
         uLlw==
X-Forwarded-Encrypted: i=1; AJvYcCVGcLbXoZHOBAXBTzAyiHW4OY3vKx/C6WFutOzD58j2aSUwl1tXpyqNdI05ponI0opRC5RLrdIlWs4T@vger.kernel.org
X-Gm-Message-State: AOJu0YxBblj8n8zjSU5Jps4w6jCiS8HSqTbEUt1HE8dXEC7m0NX25Gd+
	ht1VTNkXEJWsElwZe2VYluVK30s33hBLmYcmEuc/gy3UruCp73CvKHkK
X-Gm-Gg: ATEYQzyNt9QhPb7YzCxF+yTCqvGO5lG+E7EIiIoM+jx8ZR1MauJZXxQCNFf19JydnbJ
	Vo+l8L5y77oOgvzi5jJ8VlDxHeuwMZwf12QWO/wkY3UyBEf6rCZGQfvLixc3zm4JquMpI9yMeXV
	qjca61T/8EvvJGVHr+ZhdmLT1UCRpdRl3Cgx7Fw/fut+pLWTXj4/CIdVmQeC1WWzjHvT7USXsGB
	UPufdkToXu8C8fkng3+LfwFGAOJT7chDyq5+ASI0BOFy2MMka+2FhY+d+ANTpsqAAdqfRc6VTGV
	/rEHpnKkA+Iqk73FcKCm6J1XfhwkYkI2tBh/L36fQz8WCIbg0pGK8GCUzxuWXzXgnYXXdBRgKCk
	J44pKf0EQ3yQWe3PqkHiwGQ61j76ZJ/ZSM8ChVvObH8eR2qTlIpiT6oyha6TGkTQULEL77VvLmb
	55eA7gNhNbsXJ2NPI/xpd70QHXGQV+YNzyHeOkYsG790fiBEyaZh4CjbqLA/zpc2x//qllRA21o
	+dQ18ew9TPaSkCoBds9DdDgVHcbjLjKia5l7so7D3gWrsci
X-Received: by 2002:a05:600c:1d15:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-48727ee9a7amr246419515e9.16.1774920496841;
        Mon, 30 Mar 2026 18:28:16 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873bbcac33sm118488235e9.15.2026.03.30.18.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:28:15 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Haggai Eran <haggaie@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH] IB/mlx5: Clarify success return path in mlx5_ib_alloc_transport_domain
Date: Tue, 31 Mar 2026 02:28:06 +0100
Message-ID: <20260331012806.10077-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mellanox.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18819-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA6D8363147
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ib_alloc_transport_domain(), the function returns 'err' if
loopback enablement is skipped. At this point, 'err' is always 0
because the preceding transport domain allocation succeeded.

Smatch warns that this is a "missing error code" because returning
a variable instead of a literal 0 in an early-exit path is ambiguous.
Explicitly return 0 to clarify that this is an intentional success path
and to improve code robustness.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..ae4c8ed1c87d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2068,7 +2068,7 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
 
 	return mlx5_ib_enable_lb(dev, true, false);
 }
-- 
2.43.0


