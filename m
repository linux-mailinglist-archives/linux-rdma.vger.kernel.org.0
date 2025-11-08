Return-Path: <linux-rdma+bounces-14318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E9C42622
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 04:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D583B2023
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6C52D23A6;
	Sat,  8 Nov 2025 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmxX7+Kd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6577248F64
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573501; cv=none; b=jkX7Fw3Aua622mOtofwGosXti3+S9t6tQ/sj4gwf/vxbzAiPBxpcXjx2CO0vgqpN8fe+THVVyo4j47nA53u4P8mzcBR7omgKohwHh/8X3xbo7cykl0UbxzCYjL7OsWzi1Yp5ggF0rwHO6CK5dLpzty0qcNb0L1+n9RktwSO/a28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573501; c=relaxed/simple;
	bh=F2fx+HzxmOVd0BPeYHQEx170LF8XktKX/4tBnnAb5ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VuBQa27h0romVOmVw1+pBnUTi7WIoq2h/7R0Oltx58YoGrHvuYJxgJFjiJ3hhoNY5PwVgGCfPkHXcZF6GTcMzWIrGs078H6iJO/wLrQJtwpdJ/QyIUvQX8znzXE1e52NEbXbXvPC+rf/jYnkYquvxFIrACIhhfxVxfhh8OFQcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmxX7+Kd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aad4823079so1277994b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 19:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573499; x=1763178299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xw52pDoAHz0z/WxrLuYi8EsZ2IV+tIXBY5PNwoamZ7g=;
        b=hmxX7+KdyYX9XqCxteAT57j0FTsRY9OO/tplM9B3rl9tiO0kkNTU+T06yr8fPMsY8X
         LOZVbUOKJmdEAFfeiT0eKGXwDcC9yCY0iw9Q3Udov76r1X8VDjKny2yNsZoSI6fTCHOO
         KDeMinT7PoafOmNOwhX9MVqR0CllEV8+GGbM+rG7BBeizodBsB7J1Ot86Z3G3dkPhrfI
         CzWS5OuXpOFalaUAMTPxJjDzUiXTYnVGpn+ifFvDN3CTKR+7voCWByDAq8y26D2nmlM2
         HJM5HhXqeyk/ModnpiVSPX57wTFa5xTbwg2S0077soPVqE6hnJW3cbVT3+vgCWpCMVBn
         JdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573499; x=1763178299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw52pDoAHz0z/WxrLuYi8EsZ2IV+tIXBY5PNwoamZ7g=;
        b=WrQ5EiYDfJefDAkPitATcLx1MuHMTKkYaHZn7jhotz3JhrAmvVLEbuGVez9num4MSa
         XXGwPus14TQPfe9gXCiicjOnVTnxNanCJYJBJz2PkmAbi23Ub2zSjVatlehYSj0M3of2
         z70lgqsn5IaO6RQnvTKEr3unuFj1Q0ifj34z6zR/q/TDvIuXoso+sFPenkFznDmdbbVW
         Z0p+whj0gIpl0DD8G0qFXPFKKo6lOLUZLq82PlUdsKgan4MKklTQ/5fhOrZYvMa+FX4j
         Eqienrus0fIVcoEJEN+2j5+CpFpztRmyS6E1widCW5thytijaJsnHPZ94UD4IGIkQ/df
         wx8w==
X-Gm-Message-State: AOJu0Ywoja1FIgJ7fSg/CfSJZ3emg+XtAGNqngiVmtytwvd2pwMwRnre
	zkCwsdnfycOwp4WFDi5thzhKxpPR04ijR0xujOm2x4UE9uxnCuvMgGpW
X-Gm-Gg: ASbGnctO2jk9q+4ewRplRl4KiR+UJUGx3bPrPl2H/WP5v5P2pJtDwawZ94z/2pRl9ss
	Hq3bERuqlRxfhbQJnesrdzlLeOb1pi+Xd+s1Cp9iGkHR6XIId/2KjEjkYMsrVKJDDU0QtCzpqKr
	hidzL4sRC1HDb1tJ4wt/xp+wncjIx8VvHWBR+MdTSUKGiPsOFf3V1DczDXz9cvqvsLhckd2ONNG
	NnvjeMDN3uqyebAoVBAwOkAEoIRzerq9IPQ5CQIXVoB3Xevun6WoUIXTUXlMtZbZ6nMOELIt/ba
	uV+pv7lQePi7eefVIoGPbsrjx1yUjy4UYLCsL9WEf2GoHG1LSGd0bUp5dThjVpBURxSni+e5wNc
	jhMrLVkRnHIhjiTnvxHFW69FLuFla9i+eBsacGFqSvPZEJKTQtbFce9URv4U/y9GJHy0OJrEg+A
	e2eAuFUDVnfLskB/6PfdQLt3YCyC8=
X-Google-Smtp-Source: AGHT+IHcQ/8zB+xoNbLUGjvnoe5rYBWJ5mzsPDX7sB5J/oExEn8lZG/37X0DJp374Kji4oF/aP+lJA==
X-Received: by 2002:a05:6a00:1a86:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7b225b58c33mr1736322b3a.1.1762573498929;
        Fri, 07 Nov 2025 19:44:58 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a956sm4506809b3a.44.2025.11.07.19.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:44:58 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: [PATCH v2] RDMA/core: Check for missing DGID attribute in ib_nl_is_good_ip_resp()
Date: Sat,  8 Nov 2025 03:43:36 +0000
Message-Id: <20251108034336.2100529-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use of uninitialized memory in hex_byte_pack()
via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
Previously, ib_nl_process_good_ip_rsep() used the 'gid' without
verifying that the LS_NLA_TYPE_DGID attribute was present.

This patch adds a check for the DGID attribute in ib_nl_is_good_ip_resp(),
returning false if it is missing. This prevents uninitialized memory
usage downstream in ib_nl_process_good_ip_rsep().

Suggested-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
 - Added check for LS_NLA_TYPE_DGID in ib_nl_is_good_ip_resp() to
   avoid uninitialized 'gid' usage, as suggested by Vlad Dumitrescu.

v1: https://lore.kernel.org/all/20251107041002.2091584-1-kriish.sharma2006@gmail.com

 drivers/infiniband/core/addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65..dde9114fe6a1 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -93,13 +93,16 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
 	if (ret)
 		return false;
 
+	if (!tb[LS_NLA_TYPE_DGID])
+		return false;
+
 	return true;
 }
 
 static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
 {
 	const struct nlattr *head, *curr;
-	union ib_gid gid;
+	union ib_gid gid = {};
 	struct addr_req *req;
 	int len, rem;
 	int found = 0;
-- 
2.34.1


