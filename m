Return-Path: <linux-rdma+bounces-12844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36BB2E479
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520BB582179
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF812765D1;
	Wed, 20 Aug 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDhYH/b3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8F27057B;
	Wed, 20 Aug 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712581; cv=none; b=b64//OiptBI8zewwX5SI9cU+qaO/NRfQpMSEP+osz1btSneExkgp+NuEHa5RFD+fL1bSTLemPp7t7K8GvUA0t+tNvquXtljDkGMp9vLVAA+zRKr2l34dwyBVTaiTnJGrJyKOuTPq6o2uk7h3L/KJv4dw6YzJjT5vJvVLP3Z1+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712581; c=relaxed/simple;
	bh=jGdY+XlkdSM3yt6Aoazxzypn69809S2YpVHdfUFsk7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGunouGDKD2dJc+conQRk38URem8+OISf6R2TzjHZ2oH6UPtqyWqiqJZ4vXJdhAXK868Odn09r9M3dTomdxCUrzn1mDHdRyrcuSqhr4ZeGroqKU+j/tAM070Wcz0OlbCTAXjNqk5M33p3z/iRss6qhrvbtJvjKsmlPxRkoGuBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDhYH/b3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so247195b3a.0;
        Wed, 20 Aug 2025 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712579; x=1756317379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNB2CrqWtsjiP7tsNyF0vHX9zkfr5BLz9zt8kKx4s2A=;
        b=cDhYH/b3O1KqjbYaxxR5uGu7GT2iuc88ZomGsr+5YNg1ztvWfGobNF4MRx3YFudNNr
         9YT6efjLWYvaPXolKGRz444HL2jceOvnYvGoR7HfwG3C8f1du2BumtwWDW8G1xJoxd68
         5LhdwpSI/rSXXUddBNxD8ReAt/UklV0/4OPFuluqPF6n4yi2PJNdRrIU1x/eWREvaYSY
         UQwVMmvxB+ExpeXxkkJMWJ9Q1SuMoCN69lN4T0z0LTiFxd9JVxP+ZwP+JBxJkcEYi1L4
         ioA3Zq79LgnxF/QnA6Y1Si/VsKrmGjnA/sKj7re9Hipv6RbkGp+Pa+l45u8BQ0/uQkIP
         X1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712579; x=1756317379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNB2CrqWtsjiP7tsNyF0vHX9zkfr5BLz9zt8kKx4s2A=;
        b=XLXX+okAx7qgGafYRvwBa7fz8P7Qkt/E3Gitp/Eg6WWSmfRD8S3bV8s+yHyuGydMQF
         TxCyFaEd3MUdkih+ySSsVK7N6nS7sGzZu2gFWF/IcLNJi0JAFbPi+IrVjjJOfthd66HH
         bJ+vH7Lsb3JpD8dbT0YGiAHjuz8srYY0XF1rkZuHMbPfUCjt+tTD0LVrXEKNiRsJOA/w
         2oAjwtG8a7wK1S0XL8yWtPkaKWQf78suSrI8equG0/qpv2OchZ+eAs6BQM0/D6v+uMR+
         IncQ68PL5zyU+YzP4FBOrchaV2ptxWjncPohgEqvq3M2vTT6SvINOOpfgfhQK9X3VpFe
         Damg==
X-Forwarded-Encrypted: i=1; AJvYcCU4TpaB0GHupNus7VPgGPCVWJ267ypNABZNUj/SwQyX8Z6Uf8VmqsWo1ppupI1wlG+PBGC5rB1YvPPP0IA=@vger.kernel.org, AJvYcCW2jqKynQL5SFy8UvH7tHIH/9RdB7Q831IKHhtwJ03lXhKtkakg27qKKz7yiBvfL59R1TEu6VtpvrkJJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/R+99iVh0afQ4rfoH0ft0WaAusC8dANHK4xwQUM62oCSsQX7
	9VZGKDJIW8tyAPPxrfQYNYJw7XlfeKg5fiX+b7TThmaZlpRSQCAgvnA=
X-Gm-Gg: ASbGncvn1Rb4ZbEM1bCwkXTudS9XmcuxqCVKysDrglXhd2Rh047Nbbmc0xU/rjabt86
	wWoTlkjo/yJWYNNzueuZ5mKveUdWv82tQ+WcdNsCiRKit77w7fyx5z1ZCDqJFsq7oWDMBa9Kqom
	/sPfy3Ulj1cOlTvo6Uv/UwC3GUuQwTdK+i0ioF2hBTzvI7aUyfVFUd0M+xwg1vvu2Fbxfs/V0QU
	N124oWUVaRn8IHeNQYGf6jLYudyK+Cp/LdHfhYvzvlTunf1eD9DdZASeDDRLbuTlLpEDCVyxRJq
	UwqO5YeCE0iRkIZ7olh8Zm5j9J2+YJofwMCUyjQc0UF6dw6Z/5dLxuhvwfovX7VhDpO6CqIY/bb
	5utFCedw7o8JBNJ7pGL/j2jwzIlSN/kEB
X-Google-Smtp-Source: AGHT+IGF8ILzjEPGlCmGVMO/tO+HPfoKuFdeOEBPrhGoP67CgwFRsjqvn6uJxe22BQIKRc2gDn5bvg==
X-Received: by 2002:a17:902:cf0f:b0:240:770f:72d1 with SMTP id d9443c01a7336-245ef165ec6mr56142485ad.24.1755712578979;
        Wed, 20 Aug 2025 10:56:18 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.130.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ccaa9sm32553815ad.86.2025.08.20.10.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:56:18 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/4] rds: Fix semantic annotations
Date: Wed, 20 Aug 2025 23:25:46 +0530
Message-Id: <20250820175550.498-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset addresses all semantic warnings flagged by Sparse for
net/rds.

v1:
 - https://lore.kernel.org/all/20250810171155.3263-1-ujwal.kundur@gmail.com/

Ujwal Kundur (4):
  rds: Replace POLLERR with EPOLLERR
  rds: Fix endianness annotation of jhash wrappers
  rds: Fix endianness annotation for RDS_MPATH_HASH
  rds: Fix endianness annotations for RDS extension headers

 net/rds/af_rds.c     | 2 +-
 net/rds/connection.c | 9 +++++----
 net/rds/message.c    | 4 ++--
 net/rds/rds.h        | 2 +-
 net/rds/recv.c       | 4 ++--
 net/rds/send.c       | 4 ++--
 6 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.30.2


