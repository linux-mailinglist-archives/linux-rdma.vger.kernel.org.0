Return-Path: <linux-rdma+bounces-22060-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pJZQGjnsKGo/NwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22060-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:46:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E45665CE1
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:46:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="Uo8ZM/on";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22060-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22060-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1113300B85A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742792EA72A;
	Wed, 10 Jun 2026 04:46:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316523392A
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066806; cv=none; b=FF06kwF1DkuGs7VjJdqxaDHvKQh2uw3hS6Rr7g/wf8/Qj68X84eD1HzjJdKdKcSG73wCoKonOBj/aEOt+/51FzcikerfqQfwbzfHv+SmCZYoBqaY60KMNr8UHKl9r2dAzzu7CKF1LQW+6Oijhe408Tp0gGLspNk8YFBQQFdfgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066806; c=relaxed/simple;
	bh=f8jONAVlckiy03pP1rD+EilcTKvAShDupVfgb6lJYZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhkbMRyH9raeJQc1MSNlyEyYzzMJGKdgNBAegucPGdFQqMayHTYl2TL45SiB//SkOCDdaF46fVDzZF/0G9Wbf8lJBeffNUeg+gA16d9hs2MyTAlV0jopgoizZTxw9TD8WwcdjrozWSXPw/pQDcSsoxAJsoLLDurobsXntwqqLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uo8ZM/on; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-660512d80b4so6728542d50.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066804; x=1781671604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGcXuj3nlyneGEpiiqVuQN6r81o+FCRVrT9ACFevYSU=;
        b=gtqYx6NjfOmaE9Pa2QmWlOh46OzshQH475xWIiW2893DSShZPR1LkXYv2Lzm2vjYls
         QU2fdl6AouaIIhzSHGdYfpXuGjQZ9idFdci7h2NzeldDK+J38OWm6XtZo0++i2TWIHGB
         UP0apDosIf32C8sYnm+thicbRuU1zrCIcloqodw/H+T3D7RiJYOV1rAU9BYic4AFPg5x
         PtZBF6poa73671wgWxIby3a8idfDa1AcdN/F/P2l926NlJCdIsi02rS8HCON74XgeWIr
         yogRokQqTcYEk4fSpMuVM4mooi6zzhSl1MntRKT2FFHkQ5i7kMi2U2XYD++VI6hI2ITC
         ZWxg==
X-Gm-Message-State: AOJu0Yxzowd1wcYnKX2brtQJZVEg6zz1kcpb7nKckMbSal0A1pxRSYj0
	VaBH7a56CsMQujU3fBH8iSD3zC04pX1x+PTVDeQ3Ku/A7eZ0ZsrKvuvSjNnRlR0hv016AXOk75N
	JPiXB3dJf4cycmM9IMaxNcGqYVWWYCyKj+X8ZuJE9SWt8Ep901uXVGAaJXEcAfssTXbxDp9m0gj
	pigvAG3q4Ss7mfViyy4D95w+YGfryZU6OZs5yien219fDd6sAhjJBr2jfauNcmnyxcQ99umXXDi
	1BmjOwM/ZLfnGX6Wg==
X-Gm-Gg: Acq92OHvuK3kagePKJp1Vi2XN/8LgSgH47yz49kyx8IHR+r6vvSPhH/4Oj3tjrF84R1
	g9oAckfxmFWMD4rSYPtuKOBjqQrJuhh7rvA/dn7IcA9RFFZrasVxWjLeHwwMlVMJEB30UWLtO85
	bbTQeNHxxvYpkxZOunrvQ+fHK5zExCIEp/TYou/2r1YkywaNGjOrLdDJaqLA9Yh5slL1+6EycvU
	6gVvW4D6IjZuy01rATOnnmy2VfS7X9licEFUNCw/XVnf59RYFFM3gxnML5ekkfTjvuUqXhrFFy+
	hrvXdpHB/T5K/dvwWOS3rFcYN2QAxfrILComNmuY8zk6KP2aRnbhBS+HRSvuHbLfuAq7F4XYim8
	GApmZQmU8B1ibDrCH3GfP6U+ecxvqmtpGZwd4CMAIaKI7+HiZITEOMJegZDsCP3sVXov9fApl1J
	vo/aLtmHkb6jQAR7ViOolprg2VrwA3m+VvbSY9dW+osIssCgePjjoS9k4phI2YU3b55jDM0bo=
X-Received: by 2002:a05:690e:1905:b0:660:a652:2913 with SMTP id 956f58d0204a3-6610a60c2camr15199202d50.3.1781066804000;
        Tue, 09 Jun 2026 21:46:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-660d5fb6678sm1882786d50.10.2026.06.09.21.46.43
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b9106b0fbso5059298a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066803; x=1781671603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGcXuj3nlyneGEpiiqVuQN6r81o+FCRVrT9ACFevYSU=;
        b=Uo8ZM/on3aYiD0Oq+RWqj7EShEKrbqJskZIa+bviNDMgt3W1otOsswF/vbiVJ2tMAQ
         dFArN9FbTHERbjbDUr7CRTFY3J8thkSsCkft1DtZI4EA66lWL7EqkRc07YX4WTtXnQ4o
         V4gb5CwEMe/UGVz5L9Wys6V2T+/alls8Tzrx8=
X-Received: by 2002:a17:90b:570f:b0:36b:877c:42e5 with SMTP id 98e67ed59e1d1-37133372f4emr17148248a91.17.1781066802734;
        Tue, 09 Jun 2026 21:46:42 -0700 (PDT)
X-Received: by 2002:a17:90b:570f:b0:36b:877c:42e5 with SMTP id 98e67ed59e1d1-37133372f4emr17148222a91.17.1781066802271;
        Tue, 09 Jun 2026 21:46:42 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:41 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 05/11] RDMA/bnxt_re: Add a max slot check for SQ
Date: Wed, 10 Jun 2026 03:08:49 -0700
Message-Id: <20260610100855.64212-6-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260610100855.64212-1-selvin.xavier@broadcom.com>
References: <20260610100855.64212-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22060-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4E45665CE1

The variable WQE mode must be validated against
the maximum slots supported by HW. The max supported
value is 64K. Adding a max check and fail if user
supplied value is more than the max supported.

Fixes: d8ea645d6984 ("RDMA/bnxt_re: Handle variable WQE support for user applications")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index eed918b9cdf1..eb428d2409d6 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1748,6 +1748,9 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (uctx && qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE &&
+	    ureq->sq_slots > BNXT_RE_MAX_SQ_SLOTS)
+		return -EINVAL;
 	if (fixed_que_attr) {
 		if (qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
 			return -EOPNOTSUPP;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 9fadd637cb5b..c4193ae75b54 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -369,6 +369,7 @@ int bnxt_qplib_destroy_flow(struct bnxt_qplib_res *res);
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
 #define BNXT_VAR_MAX_SGE        13
 #define BNXT_RE_MAX_RQ_WQES     65536
+#define BNXT_RE_MAX_SQ_SLOTS    65536
 
 #define BNXT_STATIC_MAX_SGE	6
 
-- 
2.39.3


