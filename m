Return-Path: <linux-rdma+bounces-18462-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM9DHOJlvWlF9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18462-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:21:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E12DC8D0
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60063090EC4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6553C73F4;
	Fri, 20 Mar 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEyl66/J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CF3C73C1;
	Fri, 20 Mar 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019717; cv=none; b=G4uEnSWwdB9kdYVuIu6sah98e57wkhcdSQCu/LOcmHi9eiv/zqb24YQhrIEbNdzQGh6WhXSa6jF7rIHtnHB68QT7P+2R+iUtDm9revwLaMaaKbuQPkUYJ/AUmf201kYQ+TuFzKPwq71Fg+nAhnNJjVRRn7K5C+ocejTqUIsgL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019717; c=relaxed/simple;
	bh=qqsfIw4Zblx+z9wmF3I3LJFpIycfILgu623YMDq5QqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VPZZhbBfY8n4WDFa/aU2ilxW3qEwZ5+ynEBuL0IuhPDi4fFU+cKeou6dy7vJ/iVfebQ5eWixHNLN7+RODnIG232jVggw11Bs/PivEcESQus6KGmSMH4vQu2LUDac4/akPbNxqXv2vsyzpE8oexrYsDtkI9p4KPBOru2o70OiR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEyl66/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FFCC4CEF7;
	Fri, 20 Mar 2026 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019716;
	bh=qqsfIw4Zblx+z9wmF3I3LJFpIycfILgu623YMDq5QqI=;
	h=From:To:Cc:Subject:Date:From;
	b=cEyl66/JU643fmCk4ddKqI6aBzSUqlMs3EK7npuppWkbKeN2g4bNrCXrI2YDTHCj8
	 1zGhK2Y478apji3e6I8MCI2eRUkVPTmsOyMQpTn/mdvRVEV+bNivXTqJNcB97RrzRk
	 9eSBPNqFyCIB2uNEQcroYrgM77OAmaXe5epdjE7QjR3HroSM/oHyCAAXlQt8CRveFf
	 /14V7M8wnZfMCyY8MTGQbM64IxosXFNdhkzOGC3y7AT0g3mVGgAe76R6Zr18Fd/ABc
	 /DkueX7c5BRCm9I7AdY+uSKN1RUn/l0mvzELopHMdG2+ZXDA5XucAAEpMvAVlMelti
	 aYEZAjUeTRdDw==
From: Arnd Bergmann <arnd@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [RESEND] RDMA/hfi1: use a struct group to avoid warning
Date: Fri, 20 Mar 2026 16:12:37 +0100
Message-Id: <20260320151511.3420818-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18462-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: E13E12DC8D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

On gcc-11 and earlier, the driver sometimes produces a warning
for memset:

In file included from include/linux/string.h:392,
                 from drivers/infiniband/hw/hfi1/mad.c:6:
In function 'fortify_memset_chk',
    inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
    inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
    __write_overflow_field(p_size_field, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This seems to be a false positive, and I found no nice way to rewrite
the code to avoid the warning, but adding a a struct group works.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
resending as the patch did not get picked up last year
https://lore.kernel.org/all/20250410075928.GN199604@unreal/
---
 drivers/infiniband/hw/hfi1/hfi.h | 6 ++++--
 drivers/infiniband/hw/hfi1/mad.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 5a0310f758dc..ae17cea4e8c9 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -878,8 +878,10 @@ struct hfi1_pportdata {
 	 * cc_log_lock protects all congestion log related data
 	 */
 	spinlock_t cc_log_lock ____cacheline_aligned_in_smp;
-	u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
-	u16 threshold_event_counter;
+	struct_group (zero_event_map,
+		u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
+		u16 threshold_event_counter;
+	);
 	struct opa_hfi1_cong_log_event_internal cc_events[OPA_CONG_LOG_ELEMS];
 	int cc_log_idx; /* index for logging events */
 	int cc_mad_idx; /* index for reporting events */
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 585f1d99b91b..9154638e9ce2 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -3869,8 +3869,8 @@ static int __subn_get_opa_hfi1_cong_log(struct opa_smp *smp, u32 am,
 	 * Reset threshold_cong_event_map, and threshold_event_counter
 	 * to 0 when log is read.
 	 */
-	memset(ppd->threshold_cong_event_map, 0x0,
-	       sizeof(ppd->threshold_cong_event_map));
+	memset(&ppd->zero_event_map, 0x0,
+	       sizeof(ppd->zero_event_map));
 	ppd->threshold_event_counter = 0;
 
 	spin_unlock_irq(&ppd->cc_log_lock);
-- 
2.39.5


