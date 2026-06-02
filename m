Return-Path: <linux-rdma+bounces-21638-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V26CA38zH2qXigAAu9opvQ
	(envelope-from <linux-rdma+bounces-21638-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:48:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96163183F
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:48:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LFFkA8NZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21638-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21638-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92DB1305F558
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8DF277818;
	Tue,  2 Jun 2026 19:46:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5481CAA65
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 19:46:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429594; cv=none; b=bMITSW/MzOCnbrWpi5YGZCXwZUD3DZS1j3vYK4R589wetaCsoOgNXmutkcSCqbxbRoD7/u83nKI76CXcwWgZPWyhotpeTa9Tg3bgFKvDFO+VatjMS27+LtAQV/S6Kdqtqep2jflwKc2zFXEbnq3+Tn8xCnhIff6dBenhvpsqSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429594; c=relaxed/simple;
	bh=b+0YgwUydQjZjrpamhzotWudWw/kVj/S8yOAVkMV3Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvd8SEKp6vsNh/exhrX0Rpl63GSOrzoyAcdLxoPANC/CYEwr04/YIP9WI7WGhCTS0pjdww5zTsjma3BfeOfA4zREdve7ycVFdG+TnZB70m7UQ9MOj7bA2PBpGmCRRNKiuBP/y6oN7M3u4/oMilmGmXaP0DK2/4yYRnVr62esP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFFkA8NZ; arc=none smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccedaf0b54so25812306d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429592; x=1781034392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXg9CW0RL7u3WIt+O2J9TMuOUmzIWnGIGXEco+AdElc=;
        b=LFFkA8NZeG4dXfHAWf7L0C0npkiMUs/hVzyDKrRFptGcXNPr8y3dio5ZmsRCZWivVO
         GS/vzRqJn/N7f2sWlVbQt/X2qI/FmwNe3hVf37h/nd8/fMfibt6tBaQs9as+kN9kH7E/
         leXnfD19LBS5OhTzV7yqY/jiemGHuZj2z1wl9Xm7MlJxbgsqGE23MS+RwqzMqGLavl5e
         gNILghx9hfKhgmHI25NYMdnk1mkzpSa3L47vGlmvVOIIIzc+U9jqEFkU98QKi+SWd/O9
         m86KnWVM5QgWVHPud6MsgDrYGF2PAKzVNu5D/r2Tr4TdWRfcN8ajXT95TriKu+cYLyRa
         LxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429592; x=1781034392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXg9CW0RL7u3WIt+O2J9TMuOUmzIWnGIGXEco+AdElc=;
        b=m9qfBEL65YB4mdxn3zxr15XnfdCk53AvjBIojmLpSPJWYZxfsJRmIecVM10twFEwmK
         WiXnvBTlA74x0/pp+PFiAWjej+7ztUZoCCZxrff1C0utmMB70gSftsXCfQt6Upv54F1f
         HYl/OsPjyPoStZXeo/qeI2eFw2dtB7nlwf2zw/3aJhptC9nJELTQqDHZglRk0v0+eHlN
         aE6KdUZoyTxMy3VC/E15eMR7F/RJ/CnlMllMGN/9nt6F0sJ6tusAgL60a8VHUcgXPOOj
         uA9nwx1FmwdzJXIg7u+BFs1i4M49c37zv1IQarpdRIPRyYWGbskXTeZKuYDN4U6YO2WJ
         IV9A==
X-Gm-Message-State: AOJu0YxmtBJ9/M87Q6lTnH+brNdOyXm5BKy3aR0TFwAVWSLS1aza0Dhk
	KRoKI57mNt1losrry++1jxcp9IxkxquU2Nhv9lZgEf0y8DtGgbbIlOtiqogz8/Yt
X-Gm-Gg: Acq92OHDU6xWmrQAEHJcTXRcPEmO9s0kt0wJVRYvQr6s7vFsi+cVfDv0bZF8jcDo4P0
	XPgeVT1P/lMR2jTTLwBO/VQQCm5RBFwHRRIoMV6zgl5m0kYJtw/Sx+8bVpLoiBa2jyRvwvpHRrJ
	hCrwKmuZb4FaooNfJu1/sRoxknU2k0+LdDpvHRunp8lyCoRicR6uBrby34K0BsY8ZJewPBlMUQU
	I2pWrmegS9qKllf/yEZQ6IIs46ETg+hGYjKbiZKolNbmHK7t/4sZakVg6WJB1TYrE3wXi9qIApm
	kWKBlZC5hyBAeDf/Cjzwn75vZ0RKw9k/RZi+1RT12+LDTB4x5K1YuU50g+wNM2NY1p9Wmc14pED
	03ZPOAz3Yt83z2+VsQMtgptw6iSy7M+vWUkBiAH9TrOcyshUX6I5fmhNPPAOYbJAcdc4tc8+Trv
	yeqGDr04xZu6wR8SI1Bs29Z9lygKIfs2QU9WkUQObcTK10a+U8RZCbumK1lx2pKOAYTp/g+vIrI
	wQ4RXub8OSZFC+HOtSAuVJJQuU5cqM=
X-Received: by 2002:a05:6214:3213:b0:8cc:e6fe:c77 with SMTP id 6a1803df08f44-8cecdbfd592mr492756d6.7.1780429591829;
        Tue, 02 Jun 2026 12:46:31 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb93d8sm1059326d6.16.2026.06.02.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:46:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/srp: bound SRP_RSP sense copy by the received length
Date: Tue,  2 Jun 2026 15:46:19 -0400
Message-ID: <20260602194619.2272486-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21638-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E96163183F

srp_process_rsp() in drivers/infiniband/ulp/srp/ib_srp.c copies sense
data with the source pointer rsp->data + be32_to_cpu(rsp->resp_data_len),
where resp_data_len is the full 32-bit value supplied by the SRP target
and is never checked against the size of the receive buffer or the
number of bytes actually received (wc->byte_len).

A malicious or compromised SRP target on the InfiniBand/RoCE fabric that
the initiator has logged into can return an SRP_RSP with
SRP_RSP_FLAG_SNSVALID set and resp_data_len set to a large value such as
0xFFFFFFFF. The receive buffer is allocated at the target-chosen
max_ti_iu_len, so the copy source lands far past the allocation.

The memcpy then reads out of bounds of the kzalloc'd receive IU; with
resp_data_len near 0xFFFFFFFF the source is multiple gigabytes past the
buffer and faults.

Pass wc->byte_len into srp_process_rsp() and copy the sense data only
when the response header, the response data, and the sense region fit
within the bytes actually received; otherwise drop the sense and log.
The in-tree iSER and NVMe-RDMA receive paths already bound their parse
by wc->byte_len; this brings ib_srp into line with them.

Fixes: aef9ec39c40c ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Impact: a malicious or compromised SRP target the initiator has logged
into can trigger an out-of-bounds read in srp_process_rsp() by returning
an SRP_RSP with SRP_RSP_FLAG_SNSVALID and a large resp_data_len, faulting
the initiator's SRP completion path.

 drivers/infiniband/ulp/srp/ib_srp.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b58868e1cf11c..199d46fb12146 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1932,7 +1932,8 @@ static int srp_post_recv(struct srp_rdma_ch *ch, struct srp_iu *iu)
 	return ib_post_recv(ch->qp, &wr, NULL);
 }
 
-static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
+static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp,
+			    u32 byte_len)
 {
 	struct srp_target_port *target = ch->target;
 	struct srp_request *req;
@@ -1973,10 +1974,26 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		scmnd->result = rsp->status;
 
 		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
-			memcpy(scmnd->sense_buffer, rsp->data +
-			       be32_to_cpu(rsp->resp_data_len),
-			       min_t(int, be32_to_cpu(rsp->sense_data_len),
-				     SCSI_SENSE_BUFFERSIZE));
+			u32 resp_len = be32_to_cpu(rsp->resp_data_len);
+			u32 sense_len = min_t(u32,
+					      be32_to_cpu(rsp->sense_data_len),
+					      SCSI_SENSE_BUFFERSIZE);
+
+			/*
+			 * The sense data starts resp_data_len bytes past the
+			 * response data area.  Both lengths are taken from the
+			 * target controlled response, so reject a response
+			 * whose sense region would run past the bytes actually
+			 * received rather than reading out of bounds of the
+			 * receive buffer.
+			 */
+			if (sizeof(*rsp) + (u64)resp_len + sense_len <= byte_len)
+				memcpy(scmnd->sense_buffer,
+				       rsp->data + resp_len, sense_len);
+			else
+				shost_printk(KERN_ERR, target->scsi_host,
+					     "dropping oversized sense (resp_data_len %u sense_data_len %u) in %u-byte RSP\n",
+					     resp_len, sense_len, byte_len);
 		}
 
 		if (unlikely(rsp->flags & SRP_RSP_FLAG_DIUNDER))
@@ -2086,7 +2103,7 @@ static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	switch (opcode) {
 	case SRP_RSP:
-		srp_process_rsp(ch, iu->buf);
+		srp_process_rsp(ch, iu->buf, wc->byte_len);
 		break;
 
 	case SRP_CRED_REQ:
-- 
2.53.0


