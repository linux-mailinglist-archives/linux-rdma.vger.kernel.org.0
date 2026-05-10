Return-Path: <linux-rdma+bounces-20326-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP9sG10IAWrVPwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20326-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:36:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAEE506B55
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BEB13005A87
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1435F61A;
	Sun, 10 May 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="LPHcRNQp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE82F8E95
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452013; cv=none; b=sBm6eFCBx48Dk0R0iE+bO5NUX8OoeEuxu7Er4EynxpklEIahfAeqZZZb7msio5LqS66xP7A1w/74zumgdrPNmVT25OWqFznOgFGAZ9JeoKYSYhCU5wZ4bx6zTLXB/xiqRPO7UmWdu8n4pit2rt3R/LoXyl0FRIq1TIP/ETM7Nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452013; c=relaxed/simple;
	bh=bRTtC/Y15xDEtxte9f/6vRbkFyBjJbqPWN5T/9gK6dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzRdTO7E/PbHvw1H1ogQnzTF6ZXM+8FeNfnOqi4/BL0RC33RwwCQvZa+TaqTmpDCae8HBspxf4A9HoksSnSENwpI5e6y/13DTgjfrvnixcduLsjk91nNzG8AugQFGTh4jv7IFDPwy4iECSGRvw1MG/fs2xGDMowwqcp8ijQaXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LPHcRNQp; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3756197eec.1
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778452010; x=1779056810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7jw5q6CV7UA5J8SrJGgRjMCaga/xFBXiIaTtBtIkq8=;
        b=LPHcRNQpyA8LHU0CD4BSba/AFLiUCtkxJozbnzrEHCxUCAa3Jt2rRDOkHVMcewCRgK
         dHljdlQ0IaBJOUGstUuI+9mR9gxE1xCjGnnJxhLUB9EyTyyjBs2scdZElAEnPauVJtgj
         v9LF1RjJ34FqWKhpHbIXFH+DUNw+Ko3E3MlUAG3Ok8Xh/jr+aGOrDiRSTLjzZubxcJ5n
         7UGTVEIPD7pJK1itWfm6o27iNJrn3gpF+Li2h87gxFixzcKrM+DB+lxyNvEybQzDV8k9
         iIfaXeRgDFv89hBfgpVfkFne2n9ZEFxQ+wiVwudLw0yt44rixeaCcK8q6aDSbfSynefP
         nBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452010; x=1779056810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7jw5q6CV7UA5J8SrJGgRjMCaga/xFBXiIaTtBtIkq8=;
        b=jjRzBxH2UuwoHsMjHHNSZXu2EG/M3RK0RSRBFs7pppWJch8G7gujwMYsn/KjLOBC+Z
         uil6fJILl5QOp2BITl387PfvmQ8WJziU6zRhRPuG0s+onDEhpb3BwU6Zd1XZuLdiRH67
         GnOIguRo67UhtxmhGAn/WA4uGDzHrEOkfjJKn+7qOkUU6zmyuNTVHzW8ntdTQUWkek0H
         DpBqf5/BIUmiKCErVw+s53Cf/XMWl9URWvPh51qnj3ljaYxfFC3ZzdrfTS/5cW5ydIrD
         tSdJF9RN6XasIAyaagdNEvegi23sN2T7UgFSKT/L9TqJUS0BA1glTPf32atVlW452UxN
         9hOw==
X-Forwarded-Encrypted: i=1; AFNElJ8Xvt5iBoYh0v4EmPX/Qiz7ZroD8ojNJOGyO+c3rOJ393ntb12lecksGJe61FJy8j1BWGvSdcmMYNwe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmz77yhH8+IlWXIG4BDm+oC+WDRAtfSIry/VfcW/SEsPLPVoON
	Im8bz/27cw6r/2oHyGU6A23Eq0Z1Fk8kX0DoUvxiZaSq/rFtxzMOaR6hlKEjlr2O/Q==
X-Gm-Gg: Acq92OH7ctwDtrrTSfOQHvglkAusFxWdUnf7+StZvqhMnsFWIl5hJavTChdaNCWdd6d
	0idhRR0nFL6eyQ7JiaNzNgNCr8oasvy9JrWNs4+6M11gp7uc9370CwKM340eb1074rWmoABQmi1
	xQTXbYTxJa59Knhje1pms72J4B630CVH4JWxRuzuK7lUkl8u0btksOJfr5M/mNcv/XliGOt9fXs
	uHUCDlwaQY93XSV1iP5WzYIYv8GTJaNIZSfwP3i4M5C6UcIrFbO97lsfxbkdRhNsLHLrin+gH+l
	BezViSlzEKSzOgylUWYQ+p9Tm+W51/S/o8BC3otWZvSOJ+Untok+OA9zuLxU4hqYeK6jwiqTlJA
	bms9mwWvmHItldYee5Hl0+5wpUn3t/ag24RD+LeuyNLWpU7COuCtBX0XCPtviPHdd6ag+IRnNOK
	H2Q+tTM71eGRTNADHYoIZbTLxM29kg2GH7uywYt3NDWewwmP/5x3ANtQ==
X-Received: by 2002:a05:7301:578d:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-2f5482684a9mr10241346eec.5.1778452009918;
        Sun, 10 May 2026 15:26:49 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d429asm11143902eec.12.2026.05.10.15.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:26:49 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	wenjia@linux.ibm.com,
	sidraya@linux.ibm.com,
	tonylu@linux.alibaba.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
Date: Sun, 10 May 2026 15:26:40 -0700
Message-ID: <20260510222640.1230720-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0EAEE506B55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email,asu.edu:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	DKIM_TRACE(0.00)[asu.edu:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20326-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.189];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Action: no action

The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:

	__string(name, smc->conn.lnk->ibname)

conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
these paths already handles this (e.g. !conn->lnk in
SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
sendmsg()/recvmsg() on an SMC-D socket crashes:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [...]
  RIP: 0010:strlen+0x1e/0xa0
  Call Trace:
   trace_event_raw_event_smc_msg_event (net/smc/smc_tracepoint.h:44)
   smc_rx_recvmsg (net/smc/smc_rx.c:515)
   smc_recvmsg (net/smc/af_smc.c:2859)
   __sys_recvfrom (net/socket.c:2315)
   __x64_sys_recvfrom (net/socket.c:2326)
   do_syscall_64

The faulting address 0x3e0 is offsetof(struct smc_link, ibname),
confirming the NULL ->lnk deref. Enabling the tracepoint requires
root, but the trigger itself is unprivileged: socket(AF_SMC, ...) has
no capability check, and SMC-D negotiation needs no admin step on
s390 or on x86 with the loopback ISM device loaded.

Log an empty device name for SMC-D instead of dereferencing NULL.

Fixes: aff3083f10bf ("net/smc: Introduce tracepoints for tx and rx msg")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/smc/smc_tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
index a9a6e3c1113a..53da84f57fd6 100644
--- a/net/smc/smc_tracepoint.h
+++ b/net/smc/smc_tracepoint.h
@@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
 				     __field(const void *, smc)
 				     __field(u64, net_cookie)
 				     __field(size_t, len)
-				     __string(name, smc->conn.lnk->ibname)
+				     __string(name, smc->conn.lnk ? smc->conn.lnk->ibname : "")
 		    ),
 
 		    TP_fast_assign(
-- 
2.43.0


