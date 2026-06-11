Return-Path: <linux-rdma+bounces-22132-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Ko4CgPuKmpPzgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22132-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:18:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB8673EAC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=daZDmSNh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22132-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22132-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07FE8302F25B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202C4963B5;
	Thu, 11 Jun 2026 17:18:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2B481FDC
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 17:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198298; cv=none; b=XtXwDsZuIRuZ9ZbauXrRWvLvO3MkAfD26QK9JHnOFi3C3/axBHVCYaP78cK5RwB3xNNZp8k6ez+3LdIvkIYrFa6gtIcgJzLRPCs5d14xeH2E38iSvZm04DUIvtq/ZIRIVXHjIgwLPpdoWrPRq9RSaEk3qNDbcrmOFl0XWL9ZO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198298; c=relaxed/simple;
	bh=MpwzlKCxNvprYG6nGm+I8C1iP9aryXlPg3HlDXV5TIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AzMFlzoZLkVsrpXBS79Ydis6FGr4KM/vfQmOAGPgOLuF+2FsqMXZXHnT+t0jqT+BGDx+XgfYY8n++gNNAIuiy0z7WafEScY5p18IaklcvU+r49AqmaKdUvFgDrdLtHMAxazaszLMKmSwCYEMcDF1Bbhb2ebVRlBTQddAXTWlx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daZDmSNh; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f869421so134939b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198291; x=1781803091; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwqBiB1V3FALHX4MUot7lj1fa4juan4nyiLVjCQIClc=;
        b=daZDmSNhMkePX4XxL+GvSa3/ghWAAD90qQU6FTE27QU9j8JgZZIv1Esw18cMi73Ewo
         ktx2+7GnZ7+41YuSanm/1n9FyG+mepcNmlox7xVXVuZrBRP5nPVf2YhpX+EEHoJunXkh
         RrDKbTm0A6QYgXhoVDXbYmsOrHt5ivFlYqaqlb6EsqrpaTG3OYl5UxPkBlMbXbc8Jl8h
         espvSIdobdwqGB1NncmzwAt+A0qO07JQ/ckcUE7DwW37kjAcawmNpiP2r7K+p5MK13kc
         yLCLTaJOLWg3tA1O6YGdRQkfZoTiT+4h+0nKfbFnTHnof4QIcLiuk5NmyKm+W6nSNytR
         i2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198291; x=1781803091;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwqBiB1V3FALHX4MUot7lj1fa4juan4nyiLVjCQIClc=;
        b=kKISAwRNMm0L6Zx1u7QbZSPEA6p8b+/gc4YaltIAlJE/Wfvj+VET+RdqqsnagvA2kt
         532rF+J9DDy3wiQ4GwW6Vuvrwto3Rw2iVENALqbVaTbFbzcd/FoToO/lCijbUVvq8Zfz
         e70UObdC/uS0AiL+5k2GmHNFsB3vbRSCNga3oCrMS9iXRyIalaM9v2aR07ZUYuhbUoCS
         H/jq83GkYmKrotv9L7QFi6N/nEsrg6roAS5pt/PMTr65eMmHbuxjAIi7pm7i3Mvasv52
         lwQcGt8KcUv/trN0MaYia1geGJGJKEnhiVdmuMKR1nwKEjKBbxD4V+zd4OzSn7ONKwkH
         QjPA==
X-Forwarded-Encrypted: i=1; AFNElJ/Qbd1mLFmBnOQKIksa9H9O8zpBnZkLGtEA9IVyRR+J3pPbC8v7BucgtOKyZwsYXGDSDhnqZ0nMQfPK@vger.kernel.org
X-Gm-Message-State: AOJu0YzwFKS+KZxdJVsBoUXpFMxt31vp8F/oFq308PpNZb4tsSHNsoX4
	S3+uL8a16UX1orrSWucv1tmgyyd0QRWlMZCk6yJ9J04hXBJT2BjRU1Jx
X-Gm-Gg: Acq92OEldFr+jaX1Yvvi/+qhAcgqzFwDqKIsj7zyxMZCxNFrc/FkmiylqqoHDpQX0OZ
	3Z1KtDLtKYnVj8mhZ6Rv2pETWLwP0llbJ6J6XQ2PUnHEjL0kqM8uN+X94W8jTev/U9Ndi4pVnqP
	ky8TNq/F9vj9TpTjLq6CEQe92hVX+fmXiCnrtSYlSNSI4S5Q05QoiJS/Nsdf8CPBHwwOC6DcuBh
	L0UIxj8JcRTWGpKVhIsZ6eZ+dJvnV32G8ftlepdXOI1V+COkm1+N8GxSQ0df35dKp2b4WTwqpcu
	Ibq4TsNePcAQE31UyCGs+XVopbnZTIv5ctOuaWjUCeeUJw/NdUR2+PTABwooTzf81mVD3GJ7kyi
	2mZNZqsI2kjp1wEEptz7DbTr/qxaJcU6mlhRbcZ2pEBupB5bw9AN0dP/Dmm/PTdU0+UNNnsCaCx
	NQyudoyIWZz+UDmkzYyrttMEEz33PAeKjxZJi41iOu
X-Received: by 2002:a05:6a00:a01:b0:842:459b:d61b with SMTP id d2e1a72fcca58-84336ba88b2mr3976561b3a.32.1781198290589;
        Thu, 11 Jun 2026 10:18:10 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([36.21.199.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8433831a89bsm2967346b3a.56.2026.06.11.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:18:09 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 12 Jun 2026 01:15:54 +0800
Subject: [PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in
 rdma_write_sg
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAErtKmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Mj3dzE4pLUIl3z5KRkQ1OzlETDNAsloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AexEWc2oAAAA=
X-Change-ID: 20260612-master-7cbc156da1f8
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, 
 Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781198286; l=2840;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=MpwzlKCxNvprYG6nGm+I8C1iP9aryXlPg3HlDXV5TIE=;
 b=ol0mkn6Z2NuzQW6U1P4SFHZoz7NQAV7dQugAAv2T/oUjuuQaWdhsvbax7JjJhlDZlkHfRm5ds
 tC0ADZLAkbbDbHtj2N8gN/w8zoO0cjfOs561TAYsi2VAyr53sPuBSIu
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22132-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cloud.ionos.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[whi4ed0g@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:danil.kipnis@cloud.ionos.com,m:jinpu.wang@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,m:whi4ed0g@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[whi4ed0g@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3EB8673EAC

When the server answers an RTRS READ, rdma_write_sg() builds the source
scatter/gather entry for the IB_WR_RDMA_WRITE that returns data to the
peer. Its length is taken directly from the wire descriptor:

  plist->length = le32_to_cpu(id->rd_msg->desc[0].len);

rd_msg points into the chunk buffer that the remote peer filled via
RDMA-WRITE-WITH-IMM (rtrs_srv_rdma_done() -> process_io_req() ->
process_read()), so desc[0].len is attacker-controlled and, before this
change, was only rejected when zero. The source address is the fixed
chunk start (dma_addr[msg_id]) and the source lkey is the PD-wide
local_dma_lkey, which is not tied to the chunk's MR mapping, so the verbs
layer does not constrain the transfer length to max_chunk_size. msg_id
and off are bounded against queue_depth and max_chunk_size in
rtrs_srv_rdma_done(), but desc[0].len is a separate field that was not
checked against the chunk size.

A peer that advertises desc[0].len larger than max_chunk_size can make
the posted RDMA write read past the chunk's mapped region. The resulting
behaviour depends on the IOMMU configuration: with no IOMMU or in
passthrough mode the read may extend into memory adjacent to the chunk
and be returned to the peer, which can disclose host memory; with a
translating IOMMU the out-of-range access is expected to fault and abort
the connection. In either case the transfer exceeds what the protocol
permits and is driven by a remote peer.

Reject a descriptor length above max_chunk_size, mirroring the existing
off >= max_chunk_size bound in rtrs_srv_rdma_done(). Legitimate clients
do not exceed it: the client sets desc[0].len to its MR length, which is
capped at the negotiated max_io_size (max_chunk_size - MAX_HDR_SIZE).

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859bd1..f81e122a3ccb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -225,8 +225,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (plist->length == 0) {
-		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
+	if (plist->length == 0 || plist->length > max_chunk_size) {
+		rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
+			 plist->length);
 		return -EINVAL;
 	}
 

---
base-commit: a48671671df5158a0b8e564cd509e04a090a941b
change-id: 20260612-master-7cbc156da1f8

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>


