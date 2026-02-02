Return-Path: <linux-rdma+bounces-16336-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL/RMyKpgGmeAAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16336-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:39:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE7ECCE04
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D0CE3066428
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA881369234;
	Mon,  2 Feb 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eh3SHtSN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561B369964
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039133; cv=none; b=XQOzxUAY2NLP54kDMs9eZrIhWBJHzYwvqiF/us6J3AaAaUc4JHnLxgiAzfCS2dBWijHiskeTo4VGkHwgQowXk+dyXwY7uz2um9EUzRKWV9K6Pgc0vG1bTbpmTlxI9WraZw+iK8fX0h5pfGWknmGPoN0tNv0bSLlDs2VYwIZLd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039133; c=relaxed/simple;
	bh=ov8clyLfqxNEBvWRpGujN20ZfaTjVz3FzH/hPrH5x0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3CAu/ctFvg2MPaokT8LhsUx+NiIuCQm8oBEyK4twOO1kF1FC5UNYqQu5fN8W3y8jVwnQkMCo+TALxFlXN1GFuBXeCGVCEDdKzmfB3RFMXRJrFghquGWkPW4KXfzMIzSmx3IBLBh3NVWhT15e3lPfZXqWU58mS9FkQU/hkVpELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Eh3SHtSN; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so32857576d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039131; x=1770643931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=ivgAZwr+JMmu5+EXTkVNJJipMXnvFbj5falJPknriuVjtbJy60zQmNpzTPmyP6E/Xy
         JHKyM9elUZ/gwj+G/7dcj6b1h8DsOBbSmeh3h3K6JA5NMllyfxqv7VEWZvN+xu9/g6wN
         uOGpMxbHbkyPs8nvqBsF3rgHbS1loqjisgPmvG04L96sVV2W7rXk8kZ14LPPMg9TILEK
         Zq/DwspEIVdhee/lTmiV5wxp3R8Cn+G1oc9+xWfuPzOZPPpqbFW+xB4ZbEg7f4d53Qa2
         dhe4SArpY1ootlrZZfmlHiKuDUEGDK+aRqvE2iXecGNLtGS1MzA8RZnV6pOHlh4OiTkp
         tssg==
X-Gm-Message-State: AOJu0YyQy9GMKJ+utU/sPO0g5F7FkVk5N6LHVK32eVTA0Kgh3U1YFDne
	k119yIUdoNDtkvok9Fe03wc9zJeDLmi95yYFN0YVryaBvdjVcExPprTh0/319Vm85W+bFMs+xk8
	0ZZc9jAxyuj76vk+cr8WLLjSTTDGVAh/lPNqRgarl+UHL0K+WeEh1RTDq9mIWnryGc6/VzA7xR5
	y2Czpj8WVwRSgF71yLVhVKaPSdbnrUA4Be1wQYrFnMKyVveB78/eBwla+frGGshr1eB6l16Zx68
	Pwlva549qTqfbM5z6E2rwVjbikByQ==
X-Gm-Gg: AZuq6aLqbdt8KLSKK1zwga8Y590HNLwNphHEiRBrMRjonfPk3BbHndLalTDUIgR1xGJ
	7+Yyv4dgovpcc3urmlX30X2OUwYDn9zFAXnadJs75INrP/EH4dI1KYEyJAB4CI6r9ApQgJ4IPSB
	FKzUFbezcpwaJG+LDCKS3d8Eieckx39ovqAEb2TGSbFKJDfdWefqLhLvqNy8F6+jQewhuZr6UAE
	Uzmu17Cf7raOzuStjSql2qUqIEYPDRAM+c3DdYnQWAK7qF8TXg9hDeYSthSO+Xun+Y7Fc/u0P/7
	2/lm0IT1MZfoTfrnRDDH6xKMUNDkHtgrduc7kz9aBpxIYpFgZ4g9QM6XlshMg5eYwYojMafUzha
	DPKdaBYZn7+nLm0nGFCyVK8yGI4myAIg3j2PS0EH58fKP6b5RW2f6XZ7XfySmNDij+C7rZIOmju
	6uDZpQq4TPUI3HRDvd5Ozk9DuI5t6T1xooMDEqhmXWqcqCWIEZJEe4Aprgpe1Z
X-Received: by 2002:a05:6214:4009:b0:894:3cb7:28a6 with SMTP id 6a1803df08f44-894e9f83d00mr158700696d6.16.1770039130867;
        Mon, 02 Feb 2026 05:32:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d36c2f01sm23097886d6.13.2026.02.02.05.32.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 05:32:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso10465036a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770039129; x=1770643929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=Eh3SHtSN2B2QLjea6RsWeYZ7dUZZM02NqzOMdV52R6tkU4H8dEuL29y96Hw11m46nj
         xCw1NO8qNTW3nAWtXRIp/YKH/fnWKRjsjam7dMYNEiVl+nvuLJnEmArpIcvPIoPV/4cO
         aEgVh7PYUCEA2CX2fmYvAZFUQNIWaLqRPsbqo=
X-Received: by 2002:a17:90b:4a89:b0:34c:9cf7:60a0 with SMTP id 98e67ed59e1d1-3543b2e00d8mr10681349a91.5.1770039129653;
        Mon, 02 Feb 2026 05:32:09 -0800 (PST)
X-Received: by 2002:a17:90b:4a89:b0:34c:9cf7:60a0 with SMTP id 98e67ed59e1d1-3543b2e00d8mr10681336a91.5.1770039129261;
        Mon, 02 Feb 2026 05:32:09 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm18859382a91.12.2026.02.02.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:32:08 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext V4 5/5] IB/core: Extend rate limit support for RC QPs
Date: Mon,  2 Feb 2026 19:04:13 +0530
Message-ID: <20260202133413.3182578-6-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16336-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3BE7ECCE04
X-Rspamd-Action: no action

Broadcom devices supports setting the rate limit while changing
RC QP state from INIT to RTR, RTR to RTS and RTS to RTS.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
---
 drivers/infiniband/core/verbs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8b56b6b62352..02ebc3e52196 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1537,7 +1537,8 @@ static const struct {
 						 IB_QP_PKEY_INDEX),
 				 [IB_QPT_RC]  = (IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
-						 IB_QP_PKEY_INDEX),
+						 IB_QP_PKEY_INDEX		|
+						 IB_QP_RATE_LIMIT),
 				 [IB_QPT_XRC_INI] = (IB_QP_ALT_PATH		|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_PKEY_INDEX),
@@ -1585,7 +1586,8 @@ static const struct {
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_MIN_RNR_TIMER		|
-						 IB_QP_PATH_MIG_STATE),
+						 IB_QP_PATH_MIG_STATE		|
+						 IB_QP_RATE_LIMIT),
 				 [IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
@@ -1619,7 +1621,8 @@ static const struct {
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
 						IB_QP_PATH_MIG_STATE		|
-						IB_QP_MIN_RNR_TIMER),
+						IB_QP_MIN_RNR_TIMER		|
+						IB_QP_RATE_LIMIT),
 				[IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
-- 
2.43.5


