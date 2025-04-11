Return-Path: <linux-rdma+bounces-9372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77931A85AAD
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A133ABC11
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA073238C0F;
	Fri, 11 Apr 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UspNZreF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A233238C09;
	Fri, 11 Apr 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369005; cv=none; b=d/rnmknTBZ0cIW+Nshd5DLo7Vf+1OwCpbwvLjMu+AAAptBiM9EwWtqQxHEpKsPBBmGmMj4HobffgVB4hfHYFp8DCUtPnV8ORkaQn3zn9Ag7/WQQjR1VtEkZF41hRj617gRqUWZwnsKGi+ViRYdJiQCl/v/r+q2QZ0JlDsfXuKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369005; c=relaxed/simple;
	bh=oy5d/S4pW5MASgYEOTGgUSbVs+pUxqnQeCfcjnI416o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEH2FKgObPLbRUmv+Tr9jjfGGmvMMrV2A8WM5D3jjN6w+Ah/KwnAAEkrjjRPXwyEfaNfV2IWYQxtnqOz/F/xCg1SE+J1wLMRz3P4KnSILmLfrOi+FFiTagZqCak6UAOKscOxKRVQiarBQlhaKXJPaHrz326YOIpvWWetw5IFVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UspNZreF; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744368988;
	bh=g48Qtb2HgrJLkqkNBpiJ1SxVJhJHuhOOWJNEegE8LW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UspNZreFEoDVooUaoW8dbiO13tV7z8eDKK+4rco/RDwLbLhghTFObAMB70fyChXiI
	 R4YsEsK+i8LPLeC0hC/XuwSn5Q6H27/WqVTO/hNb9YtyDKjHn+w48Vf+WWZw4TRSWX
	 snW80FC/G5+evua+4sa3OF9i7TkiKgi6C+UZO8SQ=
X-QQ-mid: bizesmtp23t1744368963t53fc982
X-QQ-Originating-IP: 2fxz1gLvHhLKZ3VuxioAS5pWAz4jebflTDRToLk4ZBA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 18:55:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 402799742258955829
EX-QQ-RecipientCnt: 8
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Winston Wen <wentao@uniontech.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] RDMA/hns: initialize db in update_srq_db()
Date: Fri, 11 Apr 2025 18:54:53 +0800
Message-ID: <FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250411105459.90782-1-chenlinxuan@uniontech.com>
References: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
 <20250411105459.90782-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OAj1qrjhA85AfHsK+j36bU99pHpvKn9xm6f++7FHQ2suVasozllnp2XU
	OiLmm6z+ScOETPPNgheUFvkn6YEZZafvtnDRKsBt/6Ra2bJ2XyGVguQmgPYUul2YmVRkTVp
	hwfGXISY7XaOlpPNR/Jzsae/zbBhkQWbenWC4vbYfpV7/4MOJCsWdJ5cRMUHpj/ylKKtk7U
	YQnfS601mfeOP6gW/DjXbe0e3yg0ecTBxxGWkSeN6dqVQUa2njETm/mRpNKl5DRKnWY1Ier
	Zwb6Ck06WUhqMOhA+ZzXGj9meWECie8q8fvFsX/TvVuJARcEBgVJb8jwmjtIfPcl914r26P
	10YynOm09utG5NuAGKBVteQnBYRiDL76hUGWIlz7FuO3C+WDeSGSJdWl3guMLskj8cPdaC7
	+Bk+dbX/SUyPvUdKzXitSurVWh/jUsgczZ+D5dRMYsfO6VjPUdtVpzSYgS6Ix2nwtXhCwqV
	ttKokWkr6QV02owuSe8DXhIEfopKYaDh/RGi9K6mNDezD6/SQrfIF7ie8SqdC9F3g+jeq5y
	wVQip7dUJxG3cj1PiE2j+BnnDvDLhwvdzSMk2maiDqz9wM3ZPasvgvMpcTCXeHNtVY8l/CI
	NrGK4hqEQIq3fNTSlCgOupJecIEAZ6pylStQdi2g+KTCGJOkGhxh+Lsa3QWeYu+dYw9TH3X
	6QY9uSRK0qhi1mrUDd6lJar8lqByn0Dz8CHl46M5JpqELocPQihSn9gDUJ3gth2WRLr0wVb
	YQ2SZR0YAcSRLJkrZseJPrdfrGODKNbWlt4ZkIKYj+HtlgvTXD2hYl/jGHH49y6vV4V1+oS
	weTYriFQi7+DbQD7MVjLnzIhtFdAUJDaSFeRUEw4xwe44ZwleEI/ltJZ7MRmXKNCYX7w8YE
	2Zms2Tpz3sNhJTDAkONnP8GcsY3BpL+hqZfhX+NaEx0PZnKPfT92NMOnvg6FovGFOP3aD5q
	WDEIZD3pXsby/IhyDEXSDL0cLyp9UBANSm4mGO8EIr2LZGns4UYHb7u1H80frosZXmmgVFl
	6KadT0Rg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On x86_64 with gcc version 13.3.0, I compile
drivers/infiniband/hw/hns/hns_roce_hw_v2.c with:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_COMPILE_TEST=y
    echo CONFIG_HNS3=m
    echo CONFIG_INFINIBAND=m
    echo CONFIG_INFINIBAND_HNS_HIP08=m
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
    drivers/infiniband/hw/hns/hns_roce_hw_v2.o

Then I get a compile error:

    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC [M]  drivers/infiniband/hw/hns/hns_roce_hw_v2.o
  In file included from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:47:
  drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'update_srq_db':
  drivers/infiniband/hw/hns/hns_roce_common.h:74:17: error: 'db' is used uninitialized [-Werror=uninitialized]
     74 |                 *((__le32 *)_ptr + (field_h) / 32) &=                          \
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_common.h:90:17: note: in expansion of macro '_hr_reg_clear'
     90 |                 _hr_reg_clear(ptr, field_type, field_h, field_l);              \
        |                 ^~~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_common.h:95:39: note: in expansion of macro '_hr_reg_write'
     95 | #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
        |                                       ^~~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_hw_v2.c:948:9: note: in expansion of macro 'hr_reg_write'
    948 |         hr_reg_write(&db, DB_TAG, srq->srqn);
        |         ^~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_hw_v2.c:946:31: note: 'db' declared here
    946 |         struct hns_roce_v2_db db;
        |                               ^~
  cc1: all warnings being treated as errors

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Co-Developed-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 160e8927d364..7d6c0cfa1ded 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -943,7 +943,7 @@ static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
 static void update_srq_db(struct hns_roce_srq *srq)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
-	struct hns_roce_v2_db db;
+	struct hns_roce_v2_db db = { 0 };
 
 	hr_reg_write(&db, DB_TAG, srq->srqn);
 	hr_reg_write(&db, DB_CMD, HNS_ROCE_V2_SRQ_DB);
-- 
2.48.1


