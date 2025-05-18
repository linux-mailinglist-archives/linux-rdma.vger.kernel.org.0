Return-Path: <linux-rdma+bounces-10400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD68ABB179
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046EC166C8D
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209521F5842;
	Sun, 18 May 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHKdBjPL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446101D63FC;
	Sun, 18 May 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747598046; cv=none; b=S76CFnKXSImEB9hcsNC8c3tEd1qhaSFdJKF8/65KrpYa3ogvwCI6YQuY3zTxicbVJZx9oj5ztPX91TT9VpGJMpF0RriyZ0TRW9LuchFSAcoSkeMJoUJbhFPr4ko2o9Qjy0aQv6avuZR9vBy6pqBF6WdfvVG3zsxuVV+TOC+gTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747598046; c=relaxed/simple;
	bh=GjyQRxDj/zHB3ZABsXLrupJYo0+DVNEsnoP0kXv4Pg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bpec2tzTdkXxJrYtAJqWO+NSuL3F3p4iBbGx0Ajs6Q49bg58qzMbKy7Nm5CfArpr5kQc1IXUdk21raaBw9ftaMqt1ANITDdeCnq3AyCnMMIrQGs4p3KVncwD2sR5JyZT66C3LyE0vpeHPvfdOl4MXxGdlzcPLROssCJ/1l3J5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHKdBjPL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a36e950e41so253609f8f.0;
        Sun, 18 May 2025 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747598043; x=1748202843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QEmH00c1v4Apy/bHp47nFjmBVfuKI/Ra2tULl3wUHo=;
        b=FHKdBjPLv5E2gjWO7RZlIRJhsjeI3fBPZZ0VYru5+IKNiy+LfZRlZ5m3Zfo3JgzBE1
         iz5o2QNwJ5xUHqH7ABvTixDSmGrEF/7H0x8j9A8uO2ny43tbR8qSpB8B1zDXH+P33PnT
         z2gjF2ziDjE2Mi2Tbj8i5W4bw+Oc4Cg2lDEf9Ac3UTuncswD0UF8vsTE7qv0uBIUtjl1
         0qG0u/hnJhwgf4J/xy/NlYP5m6CAoT785TvhFRWZWSO2m2vEoiXrjTAAmmVfNmQGs2pU
         0287agkmD3xil/q5ZNFfl4K855GR/Mo9eJfpioScMKvboqCuO9J+1TZyg07obr4pykoj
         m/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747598043; x=1748202843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QEmH00c1v4Apy/bHp47nFjmBVfuKI/Ra2tULl3wUHo=;
        b=TprzQ/OQjruQi+w7itZiVwCSgV5NOm5QhMGa/a4AbWy/0BlTkJBr2JEC/flAhVChVe
         APzMBhONdIuTNqRvYz6S4NtE6U06vYz69+4qzAG1gEQc1xvzekYTUbmK7GhpwvAgMfei
         ay4UPwN9T1I9ccSBZ4R+ikP01ks/u0kV+qjJvIkqSnFIQoNqnDZwRC6y1/RJ6D44vVVi
         5Ffapz9t9V3PSMDaXeMrbBxD1uzSCjuNRYQ0wLCzCxbl83BFsmOuE7wCxARePOsdUCS7
         nvQpC3XIfsSS/2Fvqi5oCgdcSyZI2oMH7skNRQpDt+SXGHMNJHYHITPIyqHADGFX6Vev
         t2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWQozBzAc/TyOY8fwvdvAv5yeCx7vM2t2tKui73+PchyrFVBixwYcNe+l6OKkung4bpcW+BAaGei/qx@vger.kernel.org, AJvYcCXxBQ4mZ1xREHHB5R7nm7kub9E20mK+bdV7n0x8sZJ4u89i/G6m6DSgcDiqwAB5vbmTS4c1fMBn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jC6ZwIkl0VyT/Bn7HH+VcHz5tEb5igvT8elm/JIzRj6rDAd+
	NJeRYLC1UvMjx55K4VQorndG0cgy3gdeq16Frj5RNQwSI6U7uL8QK3UC
X-Gm-Gg: ASbGncvGk0xe7g1xTwh6P7s7W6mwh3/W2y5eAQWhgHdQ1Sl11J+CJVbJR/XO5jJO40I
	4OIQJT78MQ5cZZJQjFo+/29pa0GY1g4pX9ilwKHgWFYDxRI1dTmayVIHdfl3p6MSVUiL7Q97UI2
	HBxWygM6ef9sQiv52rRsilzVhxrUsi4mUbd5MFjrL7U+eEgBJTims16qMIqNm4v+I6DU9S7RNFm
	NqF9XgQX3fNHfgWBrH+LuSnE9ZM0uEWI/o4LWQse+CZiHDoFzffn7TcdCmscAU/X3CS4QKINCmm
	kmuApRwQLP52tRmF25eq6/OcXDdFULzHecCFQj8oTtVY3cg+SvtgG663d5hDT54=
X-Google-Smtp-Source: AGHT+IGi9WjH9VBaLdl7h7A0PKGH1Vs0ohzHfGw4txAo+2SK3nGed6P8+JltaEnWPPj1/DOajVDYKg==
X-Received: by 2002:a05:6000:1a8d:b0:3a3:6584:3f9d with SMTP id ffacd0b85a97d-3a365844b33mr4415691f8f.41.1747598043371;
        Sun, 18 May 2025 12:54:03 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm10429231f8f.11.2025.05.18.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:54:02 -0700 (PDT)
From: goralbaris <goralbaris@gmail.com>
To: horms@kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	goralbaris@gmail.com,
	kuba@kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	shankari.ak0208@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next: rds] replace strncpy with strscpy_pad
Date: Sun, 18 May 2025 22:53:29 +0300
Message-Id: <20250518195328.14469-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250518090020.GA366906@horms.kernel.org>
References: <20250518090020.GA366906@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory.
Link: https://github.com/KSPP/linux/issues/90

In addition, strscpy_pad is more appropriate because it also zero-fills 
any remaining space in the destination if the source is shorter than 
the provided buffer size.

Signed-off-by: goralbaris <goralbaris@gmail.com>
---
 net/rds/connection.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..d62f486ab29f 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
-		sizeof(cinfo->transport));
+	strscpy_pad(cinfo->transport, conn->c_trans->t_name);
 	cinfo->flags = 0;
 
 	rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
@@ -775,8 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
-		sizeof(cinfo6->transport));
+	strscpy_pad(cinfo6->transport, conn->c_trans->t_name);
 	cinfo6->flags = 0;
 
 	rds_conn_info_set(cinfo6->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
-- 
2.34.1


