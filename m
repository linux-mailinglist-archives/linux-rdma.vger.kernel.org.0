Return-Path: <linux-rdma+bounces-21656-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M7j4CKhTH2pJkgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21656-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 00:05:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B763255E
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 00:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cg3+yDVc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21656-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21656-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD2A300E250
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C000390618;
	Tue,  2 Jun 2026 22:05:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0D38B12C
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 22:05:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437924; cv=none; b=jtRzxQOXkv8bTzZ3OlAD2PAM5XZqAj7WOoNI3D6F0HxM56Y8csc2jL122+Ac/eIRVFR57+8L/xzyJLguJnLnuOEdxPO1+zF3/SaIen/0GonvXz/0eKahnN4AbWBZxXIk2Sm+/eX7AuCh4D6Ovu2QOaphbbbedpd2mGgHw5siUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437924; c=relaxed/simple;
	bh=XC0KcaNw7SDbvUWq1bVjwUuRSHFM10TeVlcpU63KBBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VznL8Xi+CzdH3U2Xvl7KHJ2j2AqJmpmHst0E72of3FWlxylZRbOfJ8CFd71vb+kvq+HZgGSJzu2wAMuuzDkOnl5L8FxfKomLdq8/WnjO42JuPJ3gILm7cFuAg49eshr44/VrQ9VKtFFq3iJshb51rhuXvtI59xRMrH91DSGlw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg3+yDVc; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccea53f35cso53187126d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780437919; x=1781042719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOc/r8laH9Q5rcV75Dpu9RWLNtUdzZsvgQiYjPZO9Lo=;
        b=Cg3+yDVcsU3UFOt5poogMKMOikHzJmoDrq4QcM2v3R8cjQH6Q78AuInUP8CKJOd3Q+
         mdCL5ib9B2i0xtsDLLJXSvdRBkr36gmM2RmzWeCl5hhQpP+yQaXEu1bv2sIp9vDGzjUj
         nKFqvU8vxOu2bOlscGNjbTtp0VpTTBiJyYdgGruav9Lg/0s8Edq3F3I4ECCfe1iKsIcf
         Wtsq3lHz3vhRLn30n6uxmCxYnNxEP23chnemkYzFz/oshj5MZI2QHftIVyjJiVlnOtyz
         3Fd2OyaWtBs8zH80T3Ny6jjQvFHX772ludmQXOhaPW1xI1ffdBx/0klk8JezlvUTMG/d
         tr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437919; x=1781042719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOc/r8laH9Q5rcV75Dpu9RWLNtUdzZsvgQiYjPZO9Lo=;
        b=ZV7io5+7BHNPVXne9SK3II9q1HzVxhr458ODGD2LXLJlI/ozukWSkUiy45O9B83VVd
         I3DaMdV6gE+8fvelLDgS0q9c3y2Y1XfKZpa50OYUoOxwO1zTkPNyHfmaGpq4tKIKIRVi
         ZAKlXv5V3rADJNf/3daCLY73RfSHwBOiWYXlJXYj3M1I11BG1einzwNMoLY0KOaNJreu
         YeNGzr2fF+YVNn/sJw/i+BZtq9EFDM55ZeX4+01b+O+W0XAtumIJ0Gy37VY0qWnt3fKh
         F4I3GJH0yjtv/r1kOsDKkaUSTxs6qgXnZIN2rBo8Xstq3PXAuAdg8vW7hIINoJRl6wEr
         nrkw==
X-Gm-Message-State: AOJu0YzctGtpZ4y2EyftY3lzgpYt+8TTSrY4zLAeDVwPJ4ywATDev/hq
	Z0EfTxpVRJLLZ0jM9ergdFoeSv/2ITLxFzGgC4DD33lZdc3Iuu32mpjI
X-Gm-Gg: Acq92OH+JqM5ye1oyj5u0X2/fIDGji3GcBMGCMTNWoAchiEUJpi8INJxWlBUjL9NnOm
	PIXXDQEjuYwGlydddooTYkQauhEjYDLlXCMFG2BsPUJZFTf1VPuzpg1xTY4j6d3FQC+w78kIcRR
	R7NqTLKqnBVYs9kZ/RUOJuIUW+klb+BEZNsELfiJATFLGy212vLQeHd0TK17DmEfhqaoFEeRRus
	GxKsYmXcduPqA3NbPqYURepjYmRB6zNupp3toA97rrfdQ1Pg7HOJVho9P3G/u8MhSOqFtQn/E83
	KZ9Gvs7FVPzCkVCNGx79GIAbXuBU5Vk5AjAaKszjnaGiGK+HqwfYps9W6sR0g5PmHVo59EO2Da5
	eqe0hHP/wM4MmYze4GZCuVZFgtoBgfAFlQGCGmcCI+ew68Dr/ePuvwAK3mPLjZc1a/QiA5yjx7N
	ORKfe7VdTyrw10M7J/VJF6Jt5T9njb+nXvkGIXA8sz/QE6LdB2i+uWaE9V6EwIzfqFNVeSie3Zg
	A3bkoP5Kxw/u+lGGxN1HnoqJgQdPxk=
X-Received: by 2002:a05:6214:4905:b0:8cc:f30b:642c with SMTP id 6a1803df08f44-8cecdd243dcmr7627236d6.43.1780437918693;
        Tue, 02 Jun 2026 15:05:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm3480026d6.40.2026.06.02.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:05:18 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/srp: bound SRP_RSP sense copy by the received length
Date: Tue,  2 Jun 2026 18:04:57 -0400
Message-ID: <20260602220457.2542840-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21656-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D8B763255E

srp_process_rsp() copies sense data from rsp->data + resp_data_len,
where resp_data_len is the full 32-bit value supplied by the SRP target
and is never checked against the number of bytes actually received
(wc->byte_len). The copy length is bounded to SCSI_SENSE_BUFFERSIZE, so
at most 96 bytes are copied, but the source offset is not bounded.

A malicious or compromised SRP target on the InfiniBand/RoCE fabric that
the initiator has logged into can return an SRP_RSP with
SRP_RSP_FLAG_SNSVALID set and a large resp_data_len. The receive buffer
is allocated at the target-chosen max_ti_iu_len, so the source of the
sense copy lands past the bytes actually received; with resp_data_len
near 0xFFFFFFFF it is gigabytes past the buffer and the read faults.

Copy the sense data only if it has not been truncated, that is, only if
the response header, the response data, and the sense region fit within
the bytes actually received; otherwise drop the sense and log. The
in-tree iSER and NVMe-RDMA receive paths already bound their parse by
wc->byte_len; this brings ib_srp into line with them.

Fixes: aef9ec39c40c ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Impact: a malicious or compromised SRP target the initiator has logged
into can trigger an out-of-bounds read in srp_process_rsp() by returning
an SRP_RSP with SRP_RSP_FLAG_SNSVALID and a large resp_data_len, faulting
the initiator's SRP completion path.

Changes since v1 (all per Bart Van Assche's review):
- Commit message: state that the sense copy is bounded to
  SCSI_SENSE_BUFFERSIZE; the unbounded value is the source offset, not
  the number of bytes copied.
- Describe the dropped case as truncated rather than oversized sense,
  in both the commit message and the log message.
- Guard on the full sense_data_len so the truncated-sense log message is
  accurate; the copy stays bounded to SCSI_SENSE_BUFFERSIZE.
Link to v1: https://lore.kernel.org/all/20260602194619.2272486-1-michael.bommarito@gmail.com/
 drivers/infiniband/ulp/srp/ib_srp.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b58868e1cf11c..42eee27e6b2a1 100644
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
@@ -1973,10 +1974,27 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		scmnd->result = rsp->status;
 
 		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
-			memcpy(scmnd->sense_buffer, rsp->data +
-			       be32_to_cpu(rsp->resp_data_len),
-			       min_t(int, be32_to_cpu(rsp->sense_data_len),
-				     SCSI_SENSE_BUFFERSIZE));
+			u32 resp_len = be32_to_cpu(rsp->resp_data_len);
+			u32 sense_len = be32_to_cpu(rsp->sense_data_len);
+
+			/*
+			 * The sense data starts resp_data_len bytes past the
+			 * response data area; both lengths come from the
+			 * target-controlled response.  Copy the sense data
+			 * only if it has not been truncated, that is, only if
+			 * the full sense region fits within the bytes actually
+			 * received.  Otherwise the copy source would run past
+			 * the receive buffer (sized to the target-chosen
+			 * max_ti_iu_len), reading out of bounds.
+			 */
+			if (sizeof(*rsp) + (u64)resp_len + sense_len <= byte_len)
+				memcpy(scmnd->sense_buffer, rsp->data + resp_len,
+				       min_t(u32, sense_len,
+					     SCSI_SENSE_BUFFERSIZE));
+			else
+				shost_printk(KERN_ERR, target->scsi_host,
+					     "dropping truncated sense data (resp_data_len %u sense_data_len %u, %u bytes received)\n",
+					     resp_len, sense_len, byte_len);
 		}
 
 		if (unlikely(rsp->flags & SRP_RSP_FLAG_DIUNDER))
@@ -2086,7 +2104,7 @@ static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	switch (opcode) {
 	case SRP_RSP:
-		srp_process_rsp(ch, iu->buf);
+		srp_process_rsp(ch, iu->buf, wc->byte_len);
 		break;
 
 	case SRP_CRED_REQ:
-- 
2.53.0


