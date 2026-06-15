Return-Path: <linux-rdma+bounces-22239-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6mBnBngHMGpAMAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22239-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 16:08:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E9686F1D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 16:08:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=B5mTTDDW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22239-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22239-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 636B5309F022
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582373F4DC6;
	Mon, 15 Jun 2026 14:05:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4735C183
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 14:05:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532348; cv=none; b=rqr2A7j/0r0xip6pBB6b+dDx3CBF8G0WE7iH5QnvjH/8iCkt+nP5rIaJ+NwROCiLlts5uY9dwAanZcXYflA1dUblYhOU9cnM1shFOeuB9TWTFoVyfuwevNB0eAvh4K2vpV8rrJPbM+un7dLVy5oxaDe0j4a9uYZFQbS0bcMiTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532348; c=relaxed/simple;
	bh=sti5Jiq+zf2c5nD7digmzH9DCz+UDe5i9vlPytyemk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpBtdLHKTgsBX7gg82gjAWHXZDUndAJahE+Uy6bYsTJyiLpj3V/iXOlh2YVgipdpkpHmhfs7/KeX/G0Dh1uSFLgmyoAPpmGukPX5EMABleZMII2vrdDIcdWXEqpwNo9sihVflF/eC+VgpxbHVb8fcpdi8g5pDEtdrj6bBvJHUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=B5mTTDDW; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b7866869so35384585e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781532339; x=1782137139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyI4pG06qj9OsAcBatlXpkpRpnZN2jeAS5FUIDcJdlk=;
        b=B5mTTDDWq8OgrNn5ogSKE7gTXl60jHNlyQzOu7iqJ+/H59fXDoLXMBrCmqAu/6dsgY
         cj+qAB44XKYf5Q/D7SP1NfaGJLF5AkDchPdiYhSVERNNGO37hOhN+xbZs8Q2vvCAl0cd
         6O8dQSPgj13CA6RXFVLjMXOlZydw34kkfsHr/SVJoJIxCa9ftbQ/zXd5ppl0cGth/nJH
         Zi+JIHk7kkWtmTAkW7RGvfZE7yhb6On0T4r1yg+6ys2fSLHTxLR7gQ1oa0D/beXGST7m
         1CJR2tsJUWnmfo6vjFIqnTdwxsLGGMKifYs+JbO0L8FVGQcEmrGrikRMVx2OMYE4Q10J
         lasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532339; x=1782137139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyI4pG06qj9OsAcBatlXpkpRpnZN2jeAS5FUIDcJdlk=;
        b=q3fvmKAh+KHMHhqP9ntocbbGHwWDGjPSWs0YOK+3rgQupDSoFZG/R9YM4xbZ6/cTl6
         F2xQ59rxrplaE4Owj4kUBmyasd/3EP2BJk5AHP2JRnmtVJ/DNMToGRnCyc7t9NykaN3G
         emRczwGPgZZGhedPqK5XtAsgBMp9YTTfJPYxD5ajtXTlQZCKIPEW6reosIuJQ95ExVXM
         FRBH73x4FmZ4vq8CKH554zvU7XfYn6ztN9q7UlbWedFfKhPh3PyGsOjzUWpXnKubNUFv
         XStd9PQH99L/7JEuSsdsy6pNHGx+ExjDKXJdm0Yl4PVXWiqwL2jlDtCHoumPoR8kFr/S
         FXIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6j8NJDqDLmSSsvjlSFZwMOUPI4dIDboXvjVdLFH2ayup/ghtnSocI11dpnuLc+JSrCYbCPBo443XJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyivNe7+HCLw7rZXv1Vr395vyrmjo8tX5OcFHdnecUHPn82uhBm
	E1Bw+Q2LaNbQjQDPXkeSss9PILWcO5/Zd9GwS1qiwTf117YI+chA15Jte8LNyye6OQet
X-Gm-Gg: Acq92OHS9OXsd0o9fq8KH6EF0UvjLqdlNNyIJlVRv3pT0cCjJ8OrdzmjbZHndLc4rTt
	uzH+/5KwYYQUCz3nmN+z7j7U6hz8DcbbHvXehWXGJyPzIHhGNMnZPnMcmUix6yUTrcjMyZ3xGNL
	usO21PnWm28mH6Cm9FX+XAuuSoMfnQdwJqWsIG5EFufunf1xn+uZ1KMRSc0ZbPRJbVDkSN7l7j/
	10Qs1Dh8azUCI10MrXKPvYSvlaOzU+SMiGQ/aQw/ckLp5jk52wUNwMI9rAlzuZogYf3fP59FYal
	Vh983ULYj231guKaqU1CeG20GqN7BTnU3gYFa1/cC+7wZW7tovW/8xa7C8+RL4Desj5ZW0Aru26
	ymGEqkDSrn4pKwv4BN8hnIkP84cyaOmsZzCK7FAsrW1FQAcnmWSnTfOEKpg58qCEjYIoJlyAALT
	eOuQ6Pjxq4NAg9ubZSijrtJvElGT/ukqm/0W1vzg0uqSheB3FPbKrEeroH6LZJwMX9uz2Je2i+f
	HPM5jIRYNvLDRIOid1CiHUBghgFF617EFJDtPusVEsigQ==
X-Received: by 2002:a05:600c:3f07:b0:492:1e36:bafc with SMTP id 5b1f17b1804b1-4921e36bb41mr143543765e9.36.1781532337618;
        Mon, 15 Jun 2026 07:05:37 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203dd0b9sm249125435e9.15.2026.06.15.07.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 07:05:36 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: borisp@nvidia.com,
	sd@queasysnail.net,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Mon, 15 Jun 2026 16:05:34 +0200
Message-ID: <20260615140534.52691-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-22239-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:sd@queasysnail.net,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 793E9686F1D

macsec_del_rxsc_ctx() frees the RX SC metadata_dst via
metadata_dst_free(), which directly kfree()s the object and ignores the
dst_entry refcount. The MACsec RX offload datapath
mlx5e_macsec_offload_handle_rx_skb() takes a reference on this dst with
dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
is still in flight when the RX SC is deleted, the metadata_dst is freed
while the skb still references it; the subsequent dst_release() on skb
free then operates on already-freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst is
freed only after the last reference is dropped. The dst subsystem frees
metadata_dst objects from dst_destroy() once the refcount reaches zero
(DST_METADATA is set by metadata_dst_alloc()).

Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
nft_tunnel: fix use-after-free on object destroy").

Fixes: 9b9e23c4dc2b ("net/mlx5e: MACsec, fix memory leak when MACsec device is deleted")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a059c964..2a4e7ed76d31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
-- 
2.43.0


