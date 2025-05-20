Return-Path: <linux-rdma+bounces-10440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A064ABE093
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825F23B247A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF25261596;
	Tue, 20 May 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOlsDT4R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2A258CD6;
	Tue, 20 May 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758242; cv=none; b=AihDReblMOUAQKZTUuC9Bnu6zYrtof9OpWImLd4nielstQQ+N5yyqtaZvwN+KSEE+CFV1EVN0kK+5S864zQ27iY+yPPih2mTAxlrSzMRypxdWx4x1qbkWTT6HvQrvmaXj437JDGtMqnadyrNBSJsnUYtXWDHWNYJiKuRkgLDEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758242; c=relaxed/simple;
	bh=x5muKbCVzItFqAnOAT50XHNKJhDgcS8Cum8SC4y29HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hML7rz6N0W9PKicuH625d4koxpDQQCdRFxZxWpTZYwHrGMJOnzvE/7drk+DjW8sAUG2o1s8T/qKZmQOKIQSzJbGwpeZCORUP2c3hgCUBnYG0YxKNdl8qeuSFnfA7I6mMxxRNE+lUFoMfKknGea0CbUdpBv0w2wcX1h9jBTH77Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOlsDT4R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so35041275e9.2;
        Tue, 20 May 2025 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758239; x=1748363039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFb/8UDIi4+DL9YBgWv8kfPMDoQAHsOz6JPN/DZoxFg=;
        b=kOlsDT4Rwe2iCf7tXRfuu7WoCOe0HB2AaeMjLdTtXawj3Hrlm1hoxfJkc3qGPHJ5Q9
         lnMVDyAW43CKiTW+EDjKqYKKNavgIamhErZ6JF/qpmKqXEvbMRC46y1mIgcRPHgwj2VU
         bcOq1Wxo6ZvFYhLoKgarVupc1yvjZoy/r5lRHs+cy5l+eNwVM4D1uqgDAOqNxYyJyC4D
         cmXC57t5fbME7LrpnRoivWDTZbDa8gKVtkoh8XQEOMmRGvaLWUZbkpq08bDFWZjGq+o4
         1o8U70vkcjkVSyDrPojYMRKTc9B+r5eJULoKkpDVhBpgYPZuwFGWb4CWodU1PxYBQGTl
         TUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758239; x=1748363039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFb/8UDIi4+DL9YBgWv8kfPMDoQAHsOz6JPN/DZoxFg=;
        b=VNIwAuyPIKbl5Tl1REb0ox4Td4VODMiRVac5GcKTMKSTMV4vxkF4tmXS4KbLKstv93
         9KXfoOAoY0D7YtyERcAAwTvtc6dlC5SVjFProfnsvvkBsrVsANxiTBrcxPAHvmq8lOrZ
         kokM4osblEfhbL7f/A8KBW3RU/XxGMAfUUElPjFLfQCGbqNw5/MdanjvaoDz806swflk
         jNAWpB8eBma3VLdOyaOqZ9PqzkDg8vjIpwTHypoFoiaN/jRfNOXht0Oo2VCmlogLIyHM
         Fyn6/G+1O/ZQ6WEGzPqWC52JSOh6BSJ5ixx3T7BFBhqW0Bjky/4uTVRG2AkHYNa6IPWc
         5XkA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0Uu4r9KMdVeLkWgbpRUTLGQKLTZL1qKpQb7pxrei+YYClUthM2J0oWc/e80lLtBXPOIIlDiA@vger.kernel.org, AJvYcCXTchENlgOGCvKbF9TdF091QY2QG9R74YxheO/a/0VvP3/7NTc0da48YoSZVEgjLxJV9abhccoPMNMl@vger.kernel.org
X-Gm-Message-State: AOJu0YxGG8ExJEmMi9bmicznlciFz6+l+f3tw8bcK+QN1qB1xK3/IKUv
	mpMXCD5DgzjCPefYxtXw3EAkFoO3gThrsQBHGQX1eT8Sgik6d+Ga3GGS
X-Gm-Gg: ASbGncthPDPEKxHM2Dt/O+CPoINexEwjWcPbPnNgekI9CtwHpXub3vFfIIooUrlZbiX
	gT9U/E/h1lNvj+nKBzAFZdtMdRR3jtckIrFPzFGGZQaJEIyK32l0+Qe9zc+rf3OfMaqmMDwhfTA
	uS0qp5kvebbK2oXC8LxR/V5zbNQzTPAVTLPrwclJAIem4h3cNW0YGRqSMmUSxZkoWMM39oNTGFI
	zcE9f8eStHe379el8a6FZ9jR0ly7AB3zj/AHF6H/p+35O1zZyOAWtof47kcJPjA00Cf53tpt4ht
	TSMU0A3ABp4bM/Ak2psE8V1Bb4ojrPv8kXsGU+7EAMm7sW5hOCEfAht7zG/9YpQ=
X-Google-Smtp-Source: AGHT+IH6kXpxLVNJGsgmiZlcSpTl9o+5YIxQ9ZEjLWi5Fi1sIa+2ZQbjOv420DG8yIMupEturEUy0w==
X-Received: by 2002:a05:6000:184d:b0:39d:724f:a8f1 with SMTP id ffacd0b85a97d-3a35c8220b2mr15399667f8f.10.1747758238737;
        Tue, 20 May 2025 09:23:58 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d230sm16630062f8f.4.2025.05.20.09.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:23:57 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: allison.henderson@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	goralbaris@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-rdma@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shankari.ak0208@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v5 net-next: rds] replace strncpy with strscpy_pad
Date: Tue, 20 May 2025 19:23:43 +0300
Message-Id: <20250520162342.6144-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <43d0274b9e2d45f2dd81a4b8e74a6cfd247db5c0.camel@oracle.com>
References: <43d0274b9e2d45f2dd81a4b8e74a6cfd247db5c0.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory
content exposures, unbounded reads, or crashes.
Link: https://github.com/KSPP/linux/issues/90

In addition, strscpy_pad is more appropriate because it also zero-fills
any remaining space in the destination if the source is shorter than
the provided buffer size.

Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
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


