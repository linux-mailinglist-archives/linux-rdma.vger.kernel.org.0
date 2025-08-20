Return-Path: <linux-rdma+bounces-12848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D475CB2E48E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 19:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621945E4285
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4805285CB8;
	Wed, 20 Aug 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7xEiV2q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEE261B70;
	Wed, 20 Aug 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712616; cv=none; b=KgBBeQyUkfRm9mqA6ex2ppgcgtDiOQAI3UqPpmrOL++lv5euoZpsrOCj+oJRN9jJBnv5Hs5kFTWm/VZNWGoHAT/H5ubq7PZNm+k6tpdDwWWqHg9gbWhvQJuGL4vmjiiHzjmaC6EVw2MFcuasyR6jC/+A+jfyI76st+HKbSRU7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712616; c=relaxed/simple;
	bh=aTVe6zIx9eeEkQY2Ki1hCOn4/af5y00QBLtcbdjCizk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pf49sOZnoacJ++q5aiYgJT0FsJ1thhE7fG0kJ5GoXVRp0OobuaAEFiDYGIegMv8RABLfK8zzWSX3wd0tMwrpB7Ctsmr84fgE7TnisaWVWeaNqbl1sc+E6DjsCLtvE9CD7xWu7ILGASAGNvlphTLHmZ5ACNszjlQ/PaVPlCYahTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7xEiV2q; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471738daabso78190a12.1;
        Wed, 20 Aug 2025 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712614; x=1756317414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h15eIxqdIwCof1MRCBcz3fgygqELtVuk+XlaIGTeo3U=;
        b=S7xEiV2qBMEc2bcKEAmB6MBjhZjhIrvT0ByINR3cU0dpUsDb787PTi99lt2M0ATSA/
         8ak7Cuiby7847hWr+sy9t+9RZf6XRfFpAU7PguAXki6EV0PzihaJ1pMTANfye4b17d6m
         0XjmVgqi6R/GoGTJrAohdEXxlOWw+5InDK+BkMZZPcg96Xjq4ucEwshCwhoZpTYadwYn
         ch02zgPUWPWMafzZGtCkCfa2uNTsGhMHN9S3d1KYGY1OXuFHTg6x/zlV+L5W9+JphR2k
         jVRikL9LhVLDETmvjVlDuUrzlG0PEyCm/Pgt2xhtxFVPEYVaE3FzaN8rGd1m+t6OqNgi
         oRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712614; x=1756317414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h15eIxqdIwCof1MRCBcz3fgygqELtVuk+XlaIGTeo3U=;
        b=Xi6jQipHQKYaAkzBqEIrX8b7ndYVEOYMSfdeQ67KUd/5OfrijF3MgbZsUCNb0e6F7d
         Mkr3H8ooZuMtkUZKJP709P6H5MavwgFAueyBb+WGGs0EWX7RF2x7xqGOXCXzdv/RERQF
         0CzkI64frcy12NzXnFvurJBc/odm2N5aPSftGclVUbYeDQBRM5xR10rW7VH0+c7bHVzP
         WdT+SnPllSyKsrCpEfPnKXh7g2m3FbahWaxvK3rBxZvOJ8BWirdzpS/EPQQG+dL3BCgJ
         QuARRoFccjUb0BP7rcZRH5qtRLp3YzqzXA6KEphZaQmmUfw5X7JMHKpqbMHJf1kkJp+Y
         Altw==
X-Forwarded-Encrypted: i=1; AJvYcCUrkDUNZgPmz/Q07L2qesycpdkNymCpGFWtiCwvR3oqnpHfQnIlYk+YWuLuDtrOVh6acYRnc3z7Y6KQsDM=@vger.kernel.org, AJvYcCVQX6odNSShV2CzON8N4H7JkF2wsz7sPDJJCVyj3IeouY8EpHy+afzHs25L+HKhmggj9YF9Ojs2RzCx3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPRY6o9k58wa/MQ0J8ZQ93lsKQIgZ81x2Eda+oDyE1oSeFdAL
	mjeyp8tU/BsI4TvRI814UTVjDn9i0dud14XGqgaGuUMhRMLYHNov32g=
X-Gm-Gg: ASbGncvWr6suprcwvy0kbcPxyTGMN+Wc/LkJYrt09+ogrDeG3SbqkodJdic2CkZefSf
	Jkc0S4bGr+cMBKrWt+SRpdQLJmZvORu0Ok90+PgsBB5vhxI9p/8w6dL+8hSs/VFqQwt5rwItu6J
	/9Y0EqOkd+40ObqHO02FHaaymXh7NTKS7t42gxTjHnYCnul8hmnzmpIHSZEVxtw+Rc3pZ96pbe5
	NNaQhKLkzSJtelqhY+ORZU/w3lmaRW47+8qH3GPJsFBWGWHLDt214nqklkH21BKbAnCnCDAtGjr
	MmKwUxVdbX3OV0f9YOBOFj94a/R+a6EqhkWD3yxTTdsnA+ADQ9sfu6C40O6bEwgRZijGDH0msfk
	MsmZVkyfYNmf5/mb9bc8ffkGtUHPgrZZe
X-Google-Smtp-Source: AGHT+IGgy/Kot7C/NrIwHPLLQwSrbwouelo5AZzvdNv+3H683amHQAwYeqAU87DjfEX2ZQIbjOCjtQ==
X-Received: by 2002:a17:902:ce01:b0:235:f078:4746 with SMTP id d9443c01a7336-245ef25bb33mr44825635ad.42.1755712614298;
        Wed, 20 Aug 2025 10:56:54 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.130.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ccaa9sm32553815ad.86.2025.08.20.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:56:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] rds: Fix endianness annotations for RDS extension headers
Date: Wed, 20 Aug 2025 23:25:50 +0530
Message-Id: <20250820175550.498-5-ujwal.kundur@gmail.com>
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

Per the RDS 3.1 spec [1], RDS extension headers EXTHDR_NPATHS and
EXTHDR_GEN_NUM are be16 and be32 values respectively, exchanged during
normal operations over-the-wire (RDS Ping/Pong). This contrasts their
declarations as host endian unsigned ints.

Fix the annotations across occurrences. Flagged by Sparse.

[1] https://oss.oracle.com/projects/rds/dist/documentation/rds-3.1-spec.html

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 net/rds/message.c | 4 ++--
 net/rds/recv.c    | 4 ++--
 net/rds/send.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 7af59d2443e5..199a899a43e9 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -44,8 +44,8 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_VERSION]	= sizeof(struct rds_ext_header_version),
 [RDS_EXTHDR_RDMA]	= sizeof(struct rds_ext_header_rdma),
 [RDS_EXTHDR_RDMA_DEST]	= sizeof(struct rds_ext_header_rdma_dest),
-[RDS_EXTHDR_NPATHS]	= sizeof(u16),
-[RDS_EXTHDR_GEN_NUM]	= sizeof(u32),
+[RDS_EXTHDR_NPATHS]	= sizeof(__be16),
+[RDS_EXTHDR_GEN_NUM]	= sizeof(__be32),
 };
 
 void rds_message_addref(struct rds_message *rm)
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 5627f80013f8..66205d6924bf 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -202,8 +202,8 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	unsigned int pos = 0, type, len;
 	union {
 		struct rds_ext_header_version version;
-		u16 rds_npaths;
-		u32 rds_gen_num;
+		__be16 rds_npaths;
+		__be32 rds_gen_num;
 	} buffer;
 	u32 new_peer_gen_num = 0;
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 42d991bc8543..0b3d0ef2f008 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1454,8 +1454,8 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 
 	if (RDS_HS_PROBE(be16_to_cpu(sport), be16_to_cpu(dport)) &&
 	    cp->cp_conn->c_trans->t_mp_capable) {
-		u16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
-		u32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
+		__be16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
+		__be32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_NPATHS, &npaths,
-- 
2.30.2


