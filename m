Return-Path: <linux-rdma+bounces-18867-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DRLD0tVzGn/SQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18867-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 01:14:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F39372A49
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 01:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF191308EB51
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200E2DB794;
	Tue, 31 Mar 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef6I03y9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69F3321AA
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998607; cv=none; b=k2nSVXd6GIBgOBeUlUlb10jlzh4GlCK0fLkT7odlilNbYeYoaJl2tehWRng5G1YJ/LY5ONxbTrZCEeni5xQ5yG7kFmI0CxHRbKMLyYxnGFh0tbHwpmZmtOFzhtFQPDX7OpiiTUicP2rFEGx5KAJWIYreTfm/1ME8RdyqjikaGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998607; c=relaxed/simple;
	bh=jIYhy3Tr0zd/R9FJ4AlgvBQGYKaVjQcbo5TfKhfQCv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGior+Hw0Lu5e5LqntwsNdJjrl+dD+GvhWr3ARjBAeyP5wl5WwpW85Na0D7G4054EY4EKCIHXgQUw0j8bbLJZr5EdI5AMLJnb+3FefV04I91pxQyEzGvcZ7HBEvZVEDUCqyl/wLdoTJ5X82FMvJ8Uca2lSqzjTE3japu4XNFYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef6I03y9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so56809275e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998605; x=1775603405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgA94iSrqf5CYeT8sU7RxuKb13syh7O6QAZ63AzV/UQ=;
        b=ef6I03y9fBPVTyy5c1cVu6k4cqYqMY4dZRj1IFbCz47W/WtOark59Fpv+NASGLV9ZW
         +KaboPvcMjsP+uGRQ0DCFHFBkghf7i4rCIkmEWW4kT9+aD4DkXX3bGEfepFOXcdiu6xC
         uzA1eFaL+PsLznvpMYt8yVWA4BOFoYwYW3mYa08hGPhD/3jurqdHtck8/LvLZvknoPIr
         R01vFRHdAAmQqWfypBnxD04TOjz0UOV/laqsO0BO3ZoRGuoT3/AECfNF0Ff1f6zOJLyY
         OW5IogS7FS9zNMJK11OP/OK4HM9jQwgvwfuHezg9Zp19UGIYCG9nUhKd3ZZwyuJ6CGcj
         vUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998605; x=1775603405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgA94iSrqf5CYeT8sU7RxuKb13syh7O6QAZ63AzV/UQ=;
        b=CiUIFSQC9+m/EEBd2AG8M1Tryh57MqYVzJxwQruBAzmu6xcu6A0vxCzJcFolvtfl08
         QpnNZgKXaGwnjBpMCnPjrVeptmFty+hEM14UrKwliMm4qdE/PECEcWVqeE0vo9TZiBIb
         bob8vCuHvj7C35ZZUUMIDxS6Ma1CKRP6gQoHWhKSkTVNL6wexreP4eM0SIpO3lBBCOOJ
         ypeymWqHW9wyOKmoyHV6Vn0mguxOOWNhmSMhWDSmRrbKkX8B6H7O3L71JMckV/MuMm+D
         cAcUoGtxZR0YLCSZABevPV3JkJRPL2JIiCpPIqrSkAxsz1WUzfHors1zWGwdw7U5xhyJ
         5Uwg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Z1578s8SxNa9Ov8ng3xz1432Ham55qe05ZKO8Iw1jM2mGDG6FKN3ERjVimIKCxDZgKlq7UKybpq0@vger.kernel.org
X-Gm-Message-State: AOJu0Yywib/gbFWPFAqrUgSMHyfI55xpIeudW0XW46dDBERfIUx90U0j
	CFDTh/Cm9KTsBHCVc0WLwQJux2dMjyv2R2Zu2AM0YBk4DeT6lEmyCxsP
X-Gm-Gg: ATEYQzwNWIl0vM5Qp2pv/fn81JBJoYya3PH550qcVFcMuFHNVnC8ss9xqbk4dKt+zKx
	qITwhUG1qFSXuAo3Q3IsxAHg+0ZxGSYM9IteizBBLZs8F/YsvoJeALlDzMX4UbxXo0D1xB7ONvz
	n6v3wDM+712yR1m9B0J6Ff0/hfqNDwYBnH43vuxq1gzjv31CoIrsBkOERw7C00g7b8TCFhHjI6i
	lsHFN551tgDtldzbyjvvJa5WvCkohc5x3dUbxm1BZX2+CNXZPLKNasmm5uP0kFWTOtLydM3B0P4
	C+0+bAh2IoP9uqq9bx5460IAkZ9JjBZRXsdgeMKkind6hFqxkaqnveQxjia8eJM+SkRilwjv5HI
	0kQEh9ec+p3a3d5gQC7GPAVZid1IgYv9fw6uzeCqYHVwCOniFVlHL7Vf+lQMa2ZODvGutiLUto6
	U1ae2Y84D2yFaBA/gt6G0aDx5EGyVTP7fYcVLVYAbyHer89puB30L/vzuVM1C08rglWGh+LtHyO
	ceMLNWF1ENVG9A0759Z9TXYSH5trqrBFL6diuUXi7Enodl4
X-Received: by 2002:a05:600c:8b85:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-4888355e6bdmr20363485e9.1.1774998604467;
        Tue, 31 Mar 2026 16:10:04 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e82e262sm68486775e9.10.2026.03.31.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:10:03 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: leon@kernel.org
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	prathameshdeshpande7@gmail.com
Subject: [PATCH v2] IB/mlx5: Fix tdn leak in mlx5_ib_alloc_transport_domain
Date: Wed,  1 Apr 2026 00:04:54 +0100
Message-ID: <20260331230852.18479-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331134813.GE814676@unreal>
References: <20260331134813.GE814676@unreal>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-18867-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,mellanox.com,ziepe.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6F39372A49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ib_alloc_transport_domain(), an early success path was
returning 'err' (which is 0) instead of a literal 0.

Additionally, as identified by Sashiko, if mlx5_ib_enable_lb() fails
at the end of the function, the previously allocated transport domain
(tdn) is leaked because it is never deallocated.

Explicitly return 0 in the early success path and add error handling
to deallocate the transport domain if loopback enablement fails.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v2:
- Added deallocation of tdn if mlx5_ib_enable_lb() fails [Sashiko].
- Reworded commit message to reflect the functional fix and credit the tool.

Hi Leon,

Thanks for the feedback. I've incorporated the fix for the tdn leak
identified by Sashiko into this v2.

Thanks,
Prathamesh

 drivers/infiniband/hw/mlx5/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..c48dd78491eb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2068,9 +2068,13 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
 
-	return mlx5_ib_enable_lb(dev, true, false);
+	err = mlx5_ib_enable_lb(dev, true, false);
+	if (err)
+		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
+
+	return err;
 }
 
 static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
-- 
2.43.0


