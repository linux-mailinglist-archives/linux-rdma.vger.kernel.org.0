Return-Path: <linux-rdma+bounces-16321-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMqrHu8sgGlZ3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16321-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E87BC839A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 307D13013873
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 04:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9D22F16E;
	Mon,  2 Feb 2026 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SSOtYy6Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9162C11CD
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007758; cv=none; b=TWiUXTeHbK5uxoQik3SqyIkPL10Uey1mQCnOuVIoGf2a0DbQ3HMRh/WoIL93VwmZgy4himjDsFoQYQEPXafOo2xsWSfh96SHiHY/+/2Y/I6du2kQsUEW2bE/dDtLcykUBcgiSqKyBRdvq48Jf8g6T1poazOVzLqljIEsN3zHEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007758; c=relaxed/simple;
	bh=ov8clyLfqxNEBvWRpGujN20ZfaTjVz3FzH/hPrH5x0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbAiXGk8GoT7q8z6D7ua2zKjbEALkzpwdjW7+6HGCBVmnCnH+oef3CrZSALDpGkNXQ7gHvqBDrN5fLQHJ2SjhMjqw8T4yJYufVg6rBQIg9UZAHJlbTU7nw4l3UysH6J23NrEd0RUM2ZcDriPAaFv1nQn6ccJDW0O0qoFrRvBL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SSOtYy6Q; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c61342a69b9so1566348a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007756; x=1770612556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=AXFBLRcD2tdW0imBjmE1QvfRRZkCbcExs0JvepZADvDcA7LXSxoUojiNiw9dSfgzod
         IjqFSEL4Q5MBBAiVZgoFRBpNo3u8Yj3lIq56Y755ikMmYVJXQQOspt+vTmSx9w9LzXnz
         lrIpg2EzjbKn5EeBcRjh+3iu8V/ZwjoUG49yCBVStGwiiMixWjhYAni40Bllsxr3R2qd
         PW9SxsAqtKq1k7JwTgDZX86d45bp8HcFGKlLYQWL58yPf5Pf3nLpUmQhdX43dqFmeAQc
         E9wjIqjoeTmXKZLNlUbyFyxt1wWyq7cCslj3QpP0zGjGCJGnZvorotXWS2rkTCksR4Qm
         MwDA==
X-Gm-Message-State: AOJu0YxE1CC551Bs9fGfWnOMt/t7nnjVqIW8fhU2rT+Ob5rd8kMpt0op
	3xzbGDA0GmdadcWdv6TH4bjwMSkq7mHgoBt3mwBrIAiDtVoM/EwInHegPRxTg4A21UlBuXfoa4i
	jZkS2IFXEus6ExfeVURyGPWKTxLDUnuHhO7I9mOorPpyTVJfSbeEi9wp9Wyku1T2pExcbV171TG
	77pKW32+he2Tw2smqsuZde03137f1kyDqFDYTlL8hO4sFEA9XGEvo59cdp6T2lYa8s8QkAHaK+6
	BlV6/vJogGO70YjDyCDicRKC9hIdQ==
X-Gm-Gg: AZuq6aL1V0YttMltQfmnl+akXTSKLWsRybPbeI1GuumWsKHTmn0pdJ3JBEYxEg57KmV
	ek+5YHKJz1hzjp7uzkrMnyQZKEPFO+00P/OwcucspMw5ddx+pcYWrE1oS8ydWMYa2wnjGflqFGx
	HieJ+SEceQVfw5Al5fSOXP55QL2gJ1kF2W0SJLkM2R0SYl3TpDv9gMOfRVnj7lTe1ZRT22ZuFLf
	IC3SoXqV1mtIGOpElfa1ixSTQs4EVrjELe6gqrDjAAMtfIAD87yzQY0A5rPoFGXUleBZr06nyNS
	f+da8cwt/uuGunqTP3LFTCM8HJQm+EX0aovLYk1Hd3tJrvK5HOKSt6xHDmfdGtJZw/s/zoeta7B
	7w0EBY5CpgndCmwogoOBLJLm5nU2Uej4W9T3lgRhjSAHi5Q6ePsPrAapGeyN6OPPtsLJcD7QyqY
	5qoaSH9WZpmsI3IA9BKe9POZkGFMQWMXHsPpDoIQIQrT+Cml5SRAGX/iMapg==
X-Received: by 2002:a17:903:2347:b0:2a1:1f28:d7ee with SMTP id d9443c01a7336-2a8d81b73ebmr97997885ad.57.1770007756384;
        Sun, 01 Feb 2026 20:49:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b3eed9csm19889705ad.1.2026.02.01.20.49.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:49:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354601967f6so662885a91.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770007755; x=1770612555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=SSOtYy6Qoi+/BoRrycV2ZyhArfmqmXwfvIjV6HyC6vgyNIqRpSnGXKAwsCzyOS/GO9
         RhqBTe6/5Haj1tdsjFWnT+CWipgKL4MaVlNle2xjmhhFryiA9WbhgHFU3GGtk//8FOx1
         kNReTsXha3vS1tIIPc2yMqKmEijTXN/d2oCoI=
X-Received: by 2002:a17:90b:3b41:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-3543b3c84f0mr9043882a91.32.1770007754687;
        Sun, 01 Feb 2026 20:49:14 -0800 (PST)
X-Received: by 2002:a17:90b:3b41:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-3543b3c84f0mr9043864a91.32.1770007754308;
        Sun, 01 Feb 2026 20:49:14 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm20282135a91.9.2026.02.01.20.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:49:13 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext V3 5/5] IB/core: Extend rate limit support for RC QPs
Date: Mon,  2 Feb 2026 10:21:20 +0530
Message-ID: <20260202045120.3139712-6-kalesh-anakkur.purayil@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-16321-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 0E87BC839A
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


