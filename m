Return-Path: <linux-rdma+bounces-16319-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDBHI+IsgGlZ3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16319-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB92C837C
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2134E3005646
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 04:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A02C0F84;
	Mon,  2 Feb 2026 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LcemYfU3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFE274B35
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007751; cv=none; b=ll0uaEASyby4PeD/Dcv1BwMi/vSSrx6T7gqbNdoj4of0watHlnIWk2B+bqPVXmGvYNraIiRgPaBK+AQfDQsrpR1Dz8AQPyKV6DHSdnIt5bFGp67RmdewrbvEbvW3KvwtJrSRFoFptjI7Qww77lxnFUflJtFtiEy/6j/tEU79fLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007751; c=relaxed/simple;
	bh=r2TIpfuTp14pc0lk1Ay4wEFTQ7reAzTn6BdBxZbRAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3KDxOIIDRzQJjpdJ+1k1ALmhYfdhnHegPGuSBLuQqaequng2iUoG/aQoCvkIiUTlOUfofyFpiOGZf+29QdU53YtY+ZulMDzWSLg1FsTIvzooqlvGVBFiIcZ89VAbcTLDN95Tr0vCS8u+AHIUx8JDxYdzs854ICzq8g6v/+mVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LcemYfU3; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a91215c158so3150485ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007750; x=1770612550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=FiYHuagWikJGdQnyVci0FofdBzwyalIPcY3D5zdMLBOIlAa8dPDvUh/Uz7llLY552i
         9T869/mBx5GcOw+DeP1T76wj6LbVQvkKG7slctD6GSha7SHHBWWr/1SEfQqkqKjeGFnm
         l1q3yoUShWSyukiecjl8IamgVTnmmVHj323DNuUahJrfFQYzcpYYmKZg8QRp3uPK2v7G
         DvbbW+8DIUH3ZAQFVfJGC1m4w5m3cz5QfhnHqeEBixvoFoase+6oH+ruTjwr4Xd54UA9
         znsCu1pJOtKQMnjhwTw3W8bFzVQA8S44bu7piZbgKg4uoBe+5YgGHwzRN5h5w2K8vJxu
         t+wg==
X-Gm-Message-State: AOJu0YxtHKtQsOuOawPhjIDsopwyRIE9TrGux/m8jGW7wQHrOo5cjMOr
	RAWMjKaZyAKOaVvEPK30SiHhwV2DRYv9/wWprErn16sX9KKmED6xvragDOJ2/UZy2RZqdmVrW3I
	kMQfoB1WXZ/3EAZpT9q/1snQq0awdc/vwdGG6s9WIE4MZuA59bzajql0Gha5oOB9b3uLQDLgRTT
	w6E4if8bfKyq3H1BmDYrpuXnbJlaI3YfodU/JvqaxYSpJTYI5sk7faaATQip3XnZt2RADlwLZv6
	CM9mD2AlGqTCIROD0o/bIrZgTyzVg==
X-Gm-Gg: AZuq6aI04ZwFj/fmk16N28vKNgpFizWZdT5VI+3+pLne/UXa+n9dSQGYtj27CYZ63wu
	ddCO93nG/3pO/ARMnqfuCB2hEPBfZjA35wo6fhigDi8SlZxO962zi11PiTj44JLj8PCto33xxUS
	hS7XCtOL3jQXrQvz8q3ksEO4tG34ulbSaKiadeKaeF0FntzebvUUuuEAIv9Y9SYAKTCeekQlLKq
	aRgONSqZfrOJkMOrTQO418ZQVEsID4oxFdgUEUbEmWHtDR+PbF5y2iIdsPMxkH3N1jWh2cPgADL
	XE5/E/nCeCCNYKk9iTvzH46SIWIwZe+Jh8sp2Amm64MviuRhegdW+1xR7yGh0XfUmoj6019vrBP
	ZXCq1RsRRT7w5VbeR6jSlmy7HqpMONfZ+QzxOInAALKej9PKeNFKl+HUNarZ6a8gcetGI0XuSrT
	HmjqiyJVBEpNddDRoef+UTixoi5TNU+fXNerua8eyaUjcPDHjS935nE0tEqg==
X-Received: by 2002:a17:902:c952:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a8d8176d76mr105090195ad.41.1770007750000;
        Sun, 01 Feb 2026 20:49:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b414a94sm20601345ad.19.2026.02.01.20.49.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:49:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3545dbb7ee6so720490a91.3
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770007748; x=1770612548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=LcemYfU3nIDzLG0EZ+TgISqgzTJPRS8WjozT213xx1JBfXfxRLIzRXxsAW7xhZpLf5
         307eut8/ILAyLriud/jdlNJ7ur/0hvU/m/+5hIYS9RIrRbzV7OzE2cMvJvm/FyX+/9Z3
         1Q1BapjHE3iyQihoGgw7ywYlGisjmNL6o1x+8=
X-Received: by 2002:a17:90b:1e02:b0:340:bb5c:7dd7 with SMTP id 98e67ed59e1d1-3543b2f3240mr9601234a91.5.1770007748296;
        Sun, 01 Feb 2026 20:49:08 -0800 (PST)
X-Received: by 2002:a17:90b:1e02:b0:340:bb5c:7dd7 with SMTP id 98e67ed59e1d1-3543b2f3240mr9601218a91.5.1770007747881;
        Sun, 01 Feb 2026 20:49:07 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm20282135a91.9.2026.02.01.20.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:49:07 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext V3 3/5] RDMA/bnxt_re: Report QP rate limit in debugfs
Date: Mon,  2 Feb 2026 10:21:18 +0530
Message-ID: <20260202045120.3139712-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16319-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EEB92C837C
X-Rspamd-Action: no action

Update QP info debugfs hook to report the rate limit applied
on the QP. 0 means unlimited.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 88817c86ae24..e025217861c2 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -87,25 +87,35 @@ static ssize_t qp_info_read(struct file *filep,
 			    size_t count, loff_t *ppos)
 {
 	struct bnxt_re_qp *qp = filep->private_data;
+	struct bnxt_qplib_qp *qplib_qp;
+	u32 rate_limit = 0;
 	char *buf;
 	int len;
 
 	if (*ppos)
 		return 0;
 
+	qplib_qp = &qp->qplib_qp;
+	if (qplib_qp->shaper_allocation_status)
+		rate_limit = qplib_qp->rate_limit;
+
 	buf = kasprintf(GFP_KERNEL,
 			"QPN\t\t: %d\n"
 			"transport\t: %s\n"
 			"state\t\t: %s\n"
 			"mtu\t\t: %d\n"
 			"timeout\t\t: %d\n"
-			"remote QPN\t: %d\n",
+			"remote QPN\t: %d\n"
+			"shaper allocated : %d\n"
+			"rate limit\t: %d kbps\n",
 			qp->qplib_qp.id,
 			bnxt_re_qp_type_str(qp->qplib_qp.type),
 			bnxt_re_qp_state_str(qp->qplib_qp.state),
 			qp->qplib_qp.mtu,
 			qp->qplib_qp.timeout,
-			qp->qplib_qp.dest_qpn);
+			qp->qplib_qp.dest_qpn,
+			qplib_qp->shaper_allocation_status,
+			rate_limit);
 	if (!buf)
 		return -ENOMEM;
 	if (count < strlen(buf)) {
-- 
2.43.5


