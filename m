Return-Path: <linux-rdma+bounces-12847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39EDB2E48C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 19:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB78726C75
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D15284690;
	Wed, 20 Aug 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fudrG+BL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22905261B70;
	Wed, 20 Aug 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712611; cv=none; b=o4//ormQSlnh51rkHFeFElrRNw7iYDkTo8e1egEnx1eW/Q9zvixCu/teceEdJCbEGgzZhefi1Uwc6vvU/qbAL9egCehWOmYJgVzG6+z4UPsLRw4A48QrydtR1Jz1ITqJbn9Rfdd1vVSSCRtIXfta+SuNknUC+x2yn7Sl3W95RAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712611; c=relaxed/simple;
	bh=ASApH1GWUpHTi/efhNeufdCGm2pBUW9xZ1TNT+zrDPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImGkwRffwwL3bFXIUB9KVu59DcoHQf0RQQR96FtSyyYw/CuxG+2eGFYMOTDkUeQrMWeYRMTog6myUptHO7a2rpQLuNhAuBZtGuzGZO6IjQQOJF75gzcOOcbrC5BdgXPUfKSxsS7VAhZPR/vUmWrjdCl/q260F4WRRQ5TFNrhZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fudrG+BL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458195495so725255ad.2;
        Wed, 20 Aug 2025 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712609; x=1756317409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUfPAIBLOMuv3VuEzD+BlKAXrUdUMjGmT3eWyIb7YrQ=;
        b=fudrG+BLfM30J8jSoQvjo3mDUG+mkIIBYeh3uyoK2LkIr0KBUxkR4QOluNr0vTwBPT
         HvYZ2cwX+KMq3bO8VV4BclXB9HQ1w/hWqpLw7uybFTVMXtik+DStQLcQA5Zn7tBfRIO7
         Caub3kUe6c4TPMGzDjiuBdACZRf2tpOMAPpaD3vPFtyeTyxIVaFsK10kR3hJ7QdFViYY
         BVobW1mncfLGzfv5MmlrusfWpPdadyPqJxYngKGS3j6P4bDZLwZ993YTnU76shAnhWMY
         SW8lnnPh+WrqU0vrjCv/hKF90EuqBVuX138EYzljlSV8BbVzIVESjI0jmOCAs7EZIvEN
         IeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712609; x=1756317409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUfPAIBLOMuv3VuEzD+BlKAXrUdUMjGmT3eWyIb7YrQ=;
        b=qlbPnHBIQ5EsWuRvH6Vxa4irUhHjh2h2AqTYB/z3A+8+pbEHRHiUB1pceabzlyeNns
         G2/auJ6eqjD6UfUO8P1R3NjKyDIsib++egZeYvmicmF0NsxLCPbL8prSMO7JbhlRn9OE
         2R8PB4pc9Iky/+AyCr27pBVNXyatraHFJAC6YxeyzlVAt+Ta8wZBNaTuWfqs3G8SxKfc
         RgUaXo2agQ4kzM7tCZzy3/u6tGnIhQ4P4+OjT+IsGJywBnhDCx/yiqM0wfQ0enk9v7vt
         cX0o3415MY+Qj1uLC3W849T3dAFi1Nav8H8nleEt6+cRNPsjOnKGCPE0AEBUKi4b7PqA
         SdeA==
X-Forwarded-Encrypted: i=1; AJvYcCVhzxzWDmnZAWT7w1JherCQPNOONpUhbp6H0/9tZO4Fl+O1LonknC3TkuZdbC7HDQVm/wZsx7AyZy/6r7U=@vger.kernel.org, AJvYcCVtXcjQtIeB4aPAZnz5RFsVPqF0UzfxDuJ8fvKddDsFxjUcAIRv8d3g8F7x7YpJejdcBDB6T6kS6B+3Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKWbTTbViKJA9gB/aS/kMDOyxTUKI92C9pFpM4iZ/pYU3Ho9g
	GTH5wztyNazE1GX8nA3T+FZQ3LVPYHX/1ILQviPY+KhImVxMdZ0dC8RiQ4BNlxM=
X-Gm-Gg: ASbGncsxpM1/rwlBuwJM6t+fAjwFB8ikoQHaA+3sJqY4/vgiyikRDKv5miUa58G4A5i
	3otSE0V7fXDetBQ0RM7y6aalYlGfhieo7942XgAKWvMf7vIm4MsZqbiBH8QrE20/Q7+dy5bttfG
	AcYdW5wvFr9qHQTncvtw/5kl7y58Nqj44epuSMIJm8v052DYFwUt/Q3SnkG7wYRPzPJBgC1Xb/v
	VcdNIyBkky8AH4o/nHkgrva9N/dBdjC6kcpYJ5svaUjJXpTeKYohOrO2UDZj59gcNxJBjDO58VS
	Jg4Qhc6omaH0Q/ShGmRhTx9ggNhEUfhhD6l98vliGNzYdMLZqouamYI50PnnBSri+7Vp7of2IO6
	BF00V26RzE4+k6PuGwZjNr3hATgW8pjqa
X-Google-Smtp-Source: AGHT+IEDVXH0aHRP4SIohfgYz+4Li9LSRgAHXtAKcAoRQGYgXrgbGMLKosDU57OSqL4UBlnHPODbkg==
X-Received: by 2002:a17:903:1112:b0:237:d734:5642 with SMTP id d9443c01a7336-245ef236c61mr43136695ad.41.1755712609326;
        Wed, 20 Aug 2025 10:56:49 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.130.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ccaa9sm32553815ad.86.2025.08.20.10.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:56:48 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH net-next v2 3/4] rds: Fix endianness annotation for RDS_MPATH_HASH
Date: Wed, 20 Aug 2025 23:25:49 +0530
Message-Id: <20250820175550.498-4-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250820175550.498-1-ujwal.kundur@gmail.com>
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jhash_1word accepts host endian inputs while rs_bound_port is a be16
value (sockaddr_in6.sin6_port). Use ntohs() for consistency.

Flagged by Sparse.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 net/rds/rds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index dc360252c515..5b1c072e2e7f 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -93,7 +93,7 @@ enum {
 
 /* Max number of multipaths per RDS connection. Must be a power of 2 */
 #define	RDS_MPATH_WORKERS	8
-#define	RDS_MPATH_HASH(rs, n) (jhash_1word((rs)->rs_bound_port, \
+#define	RDS_MPATH_HASH(rs, n) (jhash_1word(ntohs((rs)->rs_bound_port), \
 			       (rs)->rs_hash_initval) & ((n) - 1))
 
 #define IS_CANONICAL(laddr, faddr) (htonl(laddr) < htonl(faddr))
-- 
2.30.2


