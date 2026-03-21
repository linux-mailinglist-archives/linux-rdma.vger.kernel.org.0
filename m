Return-Path: <linux-rdma+bounces-18493-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKWDLHp7vmm8QwMAu9opvQ
	(envelope-from <linux-rdma+bounces-18493-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 12:05:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFA42E4EC5
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A2553083DFF
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82D36C5AC;
	Sat, 21 Mar 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="Xu5LMT5n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6536A023;
	Sat, 21 Mar 2026 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090762; cv=none; b=kFbaauiUWUDuFv3rtxWcgh7xV74bn9tzxzxGlj7xLb2WyxzZtCkleDcHA+eWeVf9XnkLd+GlNTXOEeUH/Lo1JwDi3fkl5ZuNCo1JR6rAqDJTM6t40/oO+VVNlxfoRlDtJSm1tps/RGM9g22QG9hHjaAD1+F2Jj4YugYz+6AtdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090762; c=relaxed/simple;
	bh=PA5sWXArRLz3ZYeWWCBmsgNOowaJ63gCLWcd9t8/uNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wln8y4kCU8pGokB1wZa62M9bdJxKM0tRJOAfaS1bLs19NCLiNcQWgxl7SSOT/BotifP1W0d7u984fa+j2vGu3/NLhHT+EPulrKmDCvJGNAdVYoFnA4XlxwBu/0rOZIbMpthPpqNRD0iISeo978PvNx3dr4yDuSEAf2PEs7VUIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=Xu5LMT5n; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090734;
	bh=CLQdePZyrmssrlINvYExIWJm2CzCXQ4oKVoSBzxI4iI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Xu5LMT5nBUQ9LtVhFmHWRijzIX12m5tW8OCKiPVp8joCAnc7G4MESjK9UeyqHIOkb
	 3//XOKV89C5S2obB2NpIC7lgv8850nlsKujNHEfqseUxo1WPhwJVE24W5YQ3ii4j1P
	 yrWnMABOBZYDAis305U5mSCSfn8MSlZ/YnRG6ya0=
X-QQ-mid: zesmtpgz9t1774090733tba5f8f41
X-QQ-Originating-IP: fYhucm1zUykIwGMTKiSmNswVblya67qdh8q7jXGZm1k=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:58:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6442523220461579557
EX-QQ-RecipientCnt: 10
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] RDMA: update outdated references to hfi1_destroy_qp()
Date: Sat, 21 Mar 2026 18:58:51 +0800
Message-Id: <20260321105851.7556-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MbmjVFFpQnDJPYtcDZM8NhDfp8s3gY1+zCQl7aS/6wBLlsndfiD7IRax
	/gECCNsD9BaEjW6h7Owlwt9l12yprB4Vzv+qFDrGtdDjtSj7hvtBPaFwcZHKQMsKUNDnDPC
	TRLpmsjUhICIWzRjloyIFiKUdKGOJJjQaz6W0frxPX0zp2DWMUuFDqEUudcV4xEPgRHpXGs
	YLDH9YYVkSYE/0iEFTWiB7UDHl212aYywuLbHTL6pVNwXSAvPEPT8w/hAX4dFFVRPPnA3r4
	2DJNAfYrVbDW3AG7scl6rdSWK0Y8SXX8Xpnq1/Qhm1SudXlFhMsQxteQHIPYqNVEUS6tcxC
	gCaYMXo0J7o755mQGYP0nruBA/KylN840Zev/rqU8ZvjLCxnaRldHlfNF4aQSEk6Oe8H+nM
	+/Saer2M0QWUpSBmTqY0x7+CSnZnvXwSqaALwSU/r5dboo29CeYiXj4MVy9l+Mhoicbw2yK
	WWfthty8RjCOskft++R213hH84JcGjNfG/qfsYSvV5QsbE0bQjXkSGCDuiWdPt9i2zIY9eK
	m0xNmggOjd8qfhB82GByaTkAV1jxsxlfon/eUs7Uz9nIwREvaMRI8COTj7EFdw1NdXgjEHK
	2fUOcIKvyG3j0K6MBq5HTgv3sFqx8/uQQutL5N5LTW9qUaEmMy5YWJ5M4Ua+KNaHTfAtB9+
	zrL/myuuV6gjzLJtxBK+ZxCp5OWQhgPNFO6HHwtOjWSLlxki1mdcTj5YYKGCoSBOuFOQ3BG
	y3i+fB6+kwJ9YGa2TnYCsrx3tCLd6uiX9j5OJYS+qziR30YUl0rHhy81seMeoKcDmAgy4Tg
	uLAKrXIBpCu5bZuH0lNgNoupAbXtfUhMo92hi7l75SW1Rak0ikiAGjwrj/lBr7bScKgF0e7
	fafM0Yh9lhPsIBb5J5/DOTWGz1Qn5/8jLh8k23j2QsWIO7JIpnB8l2SW/ReYsH1ZICdTgFJ
	xBD/Ig4MtcuFI76CWv1fRzMpy3w/k8M33PhkX4yvJr0BmVfv9FBlEewt1zEQRf3DoMYcqK0
	swUcHUsBoCfvhD31E5hIO/gZZwl5Vn7MAgpC9KWAwL4rS4Zo4LJTM1DLWQ8Wgaif76LUORs
	ERFBgaAU3Sjv/vseCMsyzbtd2uZuXAyJw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18493-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid]
X-Rspamd-Queue-Id: 1AFA42E4EC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function hfi1_destroy_qp() was removed in commit
75261cc6ab66 ("staging/rdma/hfi1: Remove destroy qp verb") in
favor of the rdmavt generic rvt_destroy_qp().  Two comments still
reference hfi1_destroy_qp() as the waiter that rvt_put_qp() will
wake up; the actual waiter is now rvt_destroy_qp().  Update both
references.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/infiniband/hw/hfi1/qp.c      | 2 +-
 drivers/infiniband/sw/rdmavt/mcast.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index f3d8c0c193ac..bbb23c0386ee 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -404,7 +404,7 @@ void hfi1_qp_wakeup(struct rvt_qp *qp, u32 flag)
 		hfi1_qp_schedule(qp);
 	}
 	spin_unlock_irqrestore(&qp->s_lock, flags);
-	/* Notify hfi1_destroy_qp() if it is waiting. */
+	/* Notify rvt_destroy_qp() if it is waiting. */
 	rvt_put_qp(qp);
 }
 
diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index 1fda344d2056..c75be2c53b2d 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -49,7 +49,7 @@ static void rvt_mcast_qp_free(struct rvt_mcast_qp *mqp)
 {
 	struct rvt_qp *qp = mqp->qp;
 
-	/* Notify hfi1_destroy_qp() if it is waiting. */
+	/* Notify rvt_destroy_qp() if it is waiting. */
 	rvt_put_qp(qp);
 
 	kfree(mqp);
-- 
2.25.1


