Return-Path: <linux-rdma+bounces-9274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4D3A815F9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 21:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583544E2913
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE22451C3;
	Tue,  8 Apr 2025 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY9emM/Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51023F277;
	Tue,  8 Apr 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141327; cv=none; b=Ok+jOnyIYqhcsmImgKN25i9wFU7lgdqdNRnVypPT1j1VUnZkzG3SxVDKjQ+xtADu//63f1HHWzH9XKiztTtYfViSD0+7VCOLB0E+ec0h0qzmlIEISEQe7x/rYxLt/gaEyWWCTpDnAy2XAM8VSjA+GtwMDa/tEuB3y/jZ6oOxA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141327; c=relaxed/simple;
	bh=ML5jTR/jlM3ju4JbP3B3GFhZX+5zbRJpfOEkQaeoad4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6Ww82NLNCRlE6iCNufl7unfkn0xJ8m5EbXnent2MITFuZs9OHZnpBVnP6ZGHowP3CE4P21BqIe41mlD9iMQmNA0ymXBV1MVZDvys3x3gGNIYDgrp1wPP3n0HOY2D00IxfaFcEr8P05aYTaRkyqC0lXW52ZjfrUb5vOT4QA6lyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY9emM/Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227cf12df27so296185ad.0;
        Tue, 08 Apr 2025 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744141325; x=1744746125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoerfLnXPhCno+Wn+g+z/uR+iR+JqTaweh5qhXG3rP0=;
        b=MY9emM/QVteQYvIXOtqiI1hRSiNpEUa2sG89FcmbAtMDFP9BA677MhHfvd9YpbhSrA
         YxK4lbtf4ETk9ImDv2hPOy6el3iz6ZU/9Xdk/VeiyWzpHeqKTkkans16L2iSm7hYuYZ/
         sx3CJLABJtUcjmP+0nC7qefmjIXEc6GuC7ja6rOpL2A+vEUiVPMUNF1DOJ0YyDw1nqBD
         i4h+XpBeMBr8eb12apoUsiY4Qwl3AbHYGAhCt1BA5+S1eMHBfaMByTNVhW8SeH0DmAvR
         V+nWpSzolKydbkdWTLCDDUKVMG5Jz2xdBxiLtt6TUCGRTR9oLeAuJdlCkxP3+W159c3r
         4ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744141325; x=1744746125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoerfLnXPhCno+Wn+g+z/uR+iR+JqTaweh5qhXG3rP0=;
        b=tAFKFvUICrcj8DwXc63jPR05xOWlIxjQes3NnxHWg5Mh5W1JEJLfxTvOogYtplwepA
         +S3eVz8w9ElfFb2Vro0UEHut/f4ZPeepJL4+Woa8Y+M6pbbAePyEp9BsBnLV7r5ZggFt
         tL9tawhKl9J/Ft0jNwU+mfjVMfKXlcBZhjgr2Sz0ldmKgsJkfkztYiQopFsv9lZOZJHB
         ONoh6JXFy9H5oaSjuDL6RLlOOXaYAkHmDepWTixsKZQTwnepheHgiw13xbYVN2UIkc5b
         SgIbfgWfBExXL7KQ6Uk034JBpqg0ORsw2Rw7vvyiJ1sWwsTUcbdpvqFeyhbBgdnpxvi6
         73zw==
X-Forwarded-Encrypted: i=1; AJvYcCX9VPpgrzud0DAa4SrqYiPCqfVf3v/PtgQdSaZWS/sII/t5JJLUMFY56hsYHuIv2OhDpYyWXaUvglrRaoo=@vger.kernel.org, AJvYcCXGDdd2KuYPGMPUFb8839Lo9/IIH9ilMkwFTNV5z9IvCFhH7Txr6XpHkZ0iALG8jcZAbK2le22z@vger.kernel.org, AJvYcCXQitCEQyg9ClPei+VkeT30v6bVsV3x5B64R1ALAXx3xibsS4Y7IP5F/SE5HAbWzpVj5D1jGgWd6sXwmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwewpKb1nfaSn5plm7dII+PpJdwMDoinM0ZKxj9dGo6e9+R9uIo
	KkFAObbuCs40XAqQC2zl/x+9dxTPVAjhCXe7bH4K9jYicTRByhLe
X-Gm-Gg: ASbGncs92EesN3izJfFcE8L0suHSXSUf8rvOvTC42vHMtPAaL0YRU+WeWD7pvV+325g
	EeTFvQ9sePFHWmYPx6W+95ciyZLFfMekzAOJ8lrbVhSxLZgKgGT/excHOqsRAd9luo5420/O31o
	0aE7+5txpaPAk/oWylm1pgH9bV5wFvq5jBcFDgt37Z8y5F6J+CMI/LneLrBSEqyc4TjEJo5Ce1O
	h3aMFmUkOvmrtn3SGMPZQFbiBlMdYJT1x+oH3N1RUG8kp89NRMfPeDbgw7P13v2PXcxWW0wpBPd
	ELNHYb7nSO0wsROd69cd4HlHDTK0PRxvvf1ZrY2sOtxbIemRK21exKqqhR+RizCFCXs=
X-Google-Smtp-Source: AGHT+IGD4qjnb5n6rpbIvJUo7pSYRQIkDOxI0kExKtXGHcmuxeefdh6D5u4OcO5X1n4R15pQkmZSCg==
X-Received: by 2002:a17:902:e809:b0:21f:98fc:8414 with SMTP id d9443c01a7336-22ab5ebee9amr54755945ad.26.1744141324758;
        Tue, 08 Apr 2025 12:42:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e093sm104796895ad.132.2025.04.08.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:42:04 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	skhan@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] net: rds: replace strncpy with memcpy
Date: Wed,  9 Apr 2025 01:11:53 +0530
Message-ID: <20250408194153.6570-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated strncpy() function with memcpy()
as the destination buffer is length bounded 
and not required to be NUL-terminated 

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/rds/connection.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..3718c3edb32e 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
-		sizeof(cinfo->transport));
+	memcpy(cinfo->transport, conn->c_trans->t_name, min(sizeof(cinfo->transport), strnlen(conn->c_trans->t_name, sizeof(cinfo->transport))));
 	cinfo->flags = 0;
 
 	rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
@@ -775,8 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
-		sizeof(cinfo6->transport));
+	memcpy(cinfo6->transport, conn->c_trans->t_name, min(sizeof(cinfo6->transport), strnlen(conn->c_trans->t_name, sizeof(cinfo6->transport))));
 	cinfo6->flags = 0;
 
 	rds_conn_info_set(cinfo6->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
-- 
2.49.0


