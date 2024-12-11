Return-Path: <linux-rdma+bounces-6450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12899ED06D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA2188BD01
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15561DE3B8;
	Wed, 11 Dec 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1jeYqRA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CA1DE3BC;
	Wed, 11 Dec 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932158; cv=none; b=MN7fzNDuPOvejwr9XtdHf+6TRSi5t/gJ7dx9T0DZCZ+iZ9ByAMenltIXpe5Ij8plpap7nx3dNVxEnneQFxZ7jG1o8p8sP3Yq/3GeMzsxbAf4OA/NbdvvacR5iaZVLsnaymsXI/cIwL9fBoV96AStA2O/XYLbc1NBZPsNdd3EY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932158; c=relaxed/simple;
	bh=zkEdbpxTjvuEAWFKI8vkF2VyVWy5SkfSC9GotkcCuvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BD/XryUqCHRxvE6CKNk7/DlXtwxSwxLFwZqiCgbYiMm9HBrDfmd35GXbMAmWaftrCzfP6MNQtR6BJyrzZvcKO0UhJWVLpgxXEEI0MyqVnDBRgcDaHNry0rRc/FedyhxlrnJrPjS8A5VekqW6vqRISEHuKhedAGP/rsVW1jBvyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1jeYqRA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so41605425ad.3;
        Wed, 11 Dec 2024 07:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932156; x=1734536956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lC67VtD4fFVxuB+r83uZNU+8JW36bmx8Nhp3WQ4tAM=;
        b=B1jeYqRAA+132WkME2j/DoZZcoFcPtMKuM7IaaW8LQN2yIqJik8yZb15Zwey5Hy114
         Rfy3UnDPzjOIY8Y7mNSCVKofsS7QVau2vT5iF5X2snkHtPe2SFMk24TMYI7REWF4G63b
         slwT7DB3jO+5pfS8lsmZprM2eGb74g5JElgpvwRG0UoMS5zBDD4rs5XYuYSgoMZ4NHWL
         cGtkJSK4oMlqSRhoIfKHqn/xXrnu9XCuFRXNVKsHPBChPAKs7j0vuk+rdhu8CEGBEYqG
         LnX8FM4hEk1Nndmg1aIT74Q9Jyx2j3sj0IbXjMNr0fNyF88ZUws7YYRunF45LAjG+1bV
         NazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932156; x=1734536956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lC67VtD4fFVxuB+r83uZNU+8JW36bmx8Nhp3WQ4tAM=;
        b=IdDwraXLGtyHYuBVtbMkI6Ce6SyDrcwq/kxyCM7qUxYqTsu15mQP2L37KFCTKCl5qY
         ndBFIKfpBmJxLkoEnDM8tgHkZQHH5vefh5nZFs+hOdmA6f26uvog8/KRV1PjfIYshv4B
         vNiBqHJ+lxviY1h6fKOMlrllUYdY9YFDlK2ri51ZlynCKjm27utGMQyX1eMTWzxwRgtS
         lPn2ji15AQY/KjxBOjIYf7+TazYgx4mC0BXqprYvr+ws0g0DPn+SnB0ajmo7gcA4gL30
         N5kxxVfiMdUyhFjIkQxPa6/GtId1P+LU/JOJmw1rLKm8Obkwg80/A7XniY0ykRCnXKDV
         xjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb973Zubmx04RTt5woR7LYhgR8k9Ka/koGBevMdwpUH0snE680NKSjLeWynMLjsa91cbLWXx85O9fZNV9wmH0=@vger.kernel.org, AJvYcCWC+kLGecyGmt/kZcCuunWS0rEivVBoPpaZNPse+VtRWPf8A/GzRnBqYtan5h4MtS1wneFpUMu2zLhI@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFWPDtPF2ktnL1Tftw7vP2H9htpO/P7mUG/SNFGkHVUncgbpT
	/B5vrZFgt/eYImJZml/c104XnWPSTz1YUGBXjCMnnAHf8lm9toQY
X-Gm-Gg: ASbGncu3VkQETlc87V98E3OP1IEBbU9f23d6JAsw/vCbUoNS1lLp8psKKM4EymEYJQT
	oNtZxm+MiwnYFGKoxxryeGoUvUfqNFQowpFYgpsfLdIgLtPPc9QBkY6MXoQrB0NIcY9biNHe5Sz
	n9IkXQvjRXWI4d1sYjgevUO/xKxzjdIcJZSDaICo0PoUTCMFzqqD0dn6Q1rfQZA6H8KkTiyHDha
	+bfiALDOWiY88+thtHBBAxykKOtIS8vXPf9SDzuwUm+K3TwNALp+rasTadfHb+FIv4=
X-Google-Smtp-Source: AGHT+IEIO/z1IiRLnFQUxOAoeXPx2qv/BrmO6W4H8J2PEcOvAn7nRdf9JnCDAcTSg9K1CFOkkiJvGA==
X-Received: by 2002:a17:903:986:b0:216:6769:9eea with SMTP id d9443c01a7336-217786973afmr54705605ad.37.1733932155968;
        Wed, 11 Dec 2024 07:49:15 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2177fc9615asm11734205ad.273.2024.12.11.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:49:15 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] kernel-wide: Add explicity||explicitly to spelling.txt
Date: Wed, 11 Dec 2024 21:19:03 +0530
Message-Id: <20241211154903.47027-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling dictionary so
that future instances will be caught by checkpatch,
and fix the instances found.

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c                                | 2 +-
 drivers/infiniband/hw/hfi1/iowait.h                         | 2 +-
 drivers/infiniband/hw/usnic/usnic_abi.h                     | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 2 +-
 drivers/scsi/cxlflash/superpipe.c                           | 2 +-
 scripts/spelling.txt                                        | 1 +
 tools/testing/selftests/pidfd/pidfd_test.c                  | 2 +-
 7 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 25429905ae90..86bff159c51e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4957,7 +4957,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			 * states are synchronized from L0 to L1. L1 needs to inform L0 about
 			 * MER=1 only when there are pending external interrupts.
 			 * In the above if check, MER bit is set if there are pending
-			 * external interrupts. Hence, explicity mask off MER bit
+			 * external interrupts. Hence, explicitly mask off MER bit
 			 * here as otherwise it may generate spurious interrupts in L2 KVM
 			 * causing an endless loop, which results in L2 guest getting hung.
 			 */
diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
index 49805a24bb0a..7259f4f55700 100644
--- a/drivers/infiniband/hw/hfi1/iowait.h
+++ b/drivers/infiniband/hw/hfi1/iowait.h
@@ -92,7 +92,7 @@ struct iowait_work {
  *
  * The lock field is used by waiters to record
  * the seqlock_t that guards the list head.
- * Waiters explicity know that, but the destroy
+ * Waiters explicitly know that, but the destroy
  * code that unwaits QPs does not.
  */
 struct iowait {
diff --git a/drivers/infiniband/hw/usnic/usnic_abi.h b/drivers/infiniband/hw/usnic/usnic_abi.h
index 7fe9502ce8d3..86a82a4da0aa 100644
--- a/drivers/infiniband/hw/usnic/usnic_abi.h
+++ b/drivers/infiniband/hw/usnic/usnic_abi.h
@@ -72,7 +72,7 @@ struct usnic_ib_create_qp_resp {
 	u64				bar_bus_addr;
 	u32				bar_len;
 /*
- * WQ, RQ, CQ are explicity specified bc exposing a generic resources inteface
+ * WQ, RQ, CQ are explicitly specified bc exposing a generic resources inteface
  * expands the scope of ABI to many files.
  */
 	u32				wq_cnt;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 0949e7975ff1..b70d20128f98 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1810,7 +1810,7 @@ void brcmf_fws_rxreorder(struct brcmf_if *ifp, struct sk_buff *pkt)
 			rfi->cur_idx = cur_idx;
 		}
 	} else {
-		/* explicity window move updating the expected index */
+		/* explicitly window move updating the expected index */
 		exp_idx = reorder_data[BRCMF_RXREORDER_EXPIDX_OFFSET];
 
 		brcmf_dbg(DATA, "flow-%d (0x%x): change expected: %d -> %d\n",
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index b375509d1470..97631f48e19d 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -966,7 +966,7 @@ static int cxlflash_disk_detach(struct scsi_device *sdev, void *detach)
  *
  * This routine is the release handler for the fops registered with
  * the CXL services on an initial attach for a context. It is called
- * when a close (explicity by the user or as part of a process tear
+ * when a close (explicitly by the user or as part of a process tear
  * down) is performed on the adapter file descriptor returned to the
  * user. The user should be aware that explicitly performing a close
  * considered catastrophic and subsequent usage of the superpipe API
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 05bd9ca1fbfa..d46c313ceaca 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -669,6 +669,7 @@ exmaple||example
 expecially||especially
 experies||expires
 explicite||explicit
+explicity||explicitly
 explicitely||explicitly
 explict||explicit
 explictely||explicitly
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..e9728e86b4f2 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -497,7 +497,7 @@ static int child_poll_leader_exit_test(void *args)
 	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 
 	/*
-	 * glibc exit calls exit_group syscall, so explicity call exit only
+	 * glibc exit calls exit_group syscall, so explicitly call exit only
 	 * so that only the group leader exits, leaving the threads alone.
 	 */
 	*child_exit_secs = time(NULL);
-- 
2.34.1


