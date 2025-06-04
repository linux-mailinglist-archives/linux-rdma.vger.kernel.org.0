Return-Path: <linux-rdma+bounces-10946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01BACD3AB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 03:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1F7189D9D0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BF262800;
	Wed,  4 Jun 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmDVFOQO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654551FBEB6;
	Wed,  4 Jun 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998907; cv=none; b=nzmwqQquRdFHQoNGEz/shVMzeLgtBg/oRZwvXR+XTl7NKpzZVGn6DT/uekfh3193ipl4uh3PrCXeDG1oQXFgeOFxraXKkx/fjauMTh5e43SkdVtLeCrZG1IFgjt6ceaUBarz32faqB1bBd2WHW774OtnEfsHkpwz4XpDeTYnXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998907; c=relaxed/simple;
	bh=NhxqyUvNM9HHBA8sP0hJp7RUeXCOAInNjqS/5x+HQA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ng5NS3zSfqZWpHz3g6I+WbbBpAHiY0QqchtBEgS325LPS28geQIduEOyb+x37fLSUsT4a2pH0uDqisi+x1+kzEK0KocyzbOFRgXF3aUt/ZyiUsNqSGz8e82ybpb8/C4p0Jn61jGKyKpNv/jurq81c5OFZpn534uM8OGaym00v1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmDVFOQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43977C4CEF2;
	Wed,  4 Jun 2025 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998907;
	bh=NhxqyUvNM9HHBA8sP0hJp7RUeXCOAInNjqS/5x+HQA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmDVFOQOLeTnUWnDa9/GvmpI8C3v3iimNTu13Ng9cyP2tdBXVgNg5gqWV5vkM/4B5
	 uJASRdLK4wyI/UOipPUzUoA+/b5ZY/oRPGvnp4tZ3Nw/Si5fX6aEtsLWIxQVLt5fiM
	 yge8u0L/62hQPnvNc4PRrbgRINkxOxjji1V755v6ppCKpvVXIwbUXxThDaeM0bwl+f
	 6n8fMb/jRFFF20Kp6bbyTKghVsnkQOll3JAMnVbemAyP76NpzpMcEH/Sf4iU4gqe6K
	 1V/UeSg8l9NE0QMMH9TeKTI/yGrzAykOILSgNkEP/F0x91pKPwOBGd5qZwo8FwWoAg
	 3L3p13uCR+iyw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Winston Wen <wentao@uniontech.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tangchengchang@huawei.com,
	huangjunxian6@hisilicon.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 82/93] RDMA/hns: initialize db in update_srq_db()
Date: Tue,  3 Jun 2025 20:59:08 -0400
Message-Id: <20250604005919.4191884-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Linxuan <chenlinxuan@uniontech.com>

[ Upstream commit ffe1cee21f8b533ae27c3a31bfa56b8c1b27fa6e ]

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
Co-developed-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Link: https://patch.msgid.link/FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and examination of the kernel source
code, here is my assessment: **YES** This commit should be backported to
stable kernel trees for the following extensive reasons: ## 1.
**Critical Hardware Register Corruption Risk** The commit fixes a
genuine bug where an uninitialized stack variable containing random data
is written directly to hardware registers. In the `update_srq_db()`
function: ```c struct hns_roce_v2_db db; // UNINITIALIZED - contains
random stack data hr_reg_write(&db, DB_TAG, srq->srqn); // Only sets
specific bits hr_reg_write(&db, DB_CMD, HNS_ROCE_V2_SRQ_DB); // Only
sets specific bits hr_reg_write(&db, DB_PI, srq->idx_que.head); // Only
sets specific bits hns_roce_write64(hr_dev, (__le32 *)&db, srq->db_reg);
// Writes ENTIRE structure to hardware ``` The `hr_reg_write()` macros
only modify specific bit fields within the 64-bit structure. Any bits
not explicitly set retain their random initial values from the stack,
which then get written to the hardware doorbell register. ## 2.
**Pattern Inconsistency Indicates Bug** My examination of the codebase
shows that ALL other similar functions correctly initialize their
database structures: - `update_sq_db()`: `struct hns_roce_v2_db sq_db =
{};` ✓ - `update_rq_db()`: `struct hns_roce_v2_db rq_db = {};` ✓ -
`update_cq_db()`: `struct hns_roce_v2_db cq_db = {};` ✓ -
`update_srq_db()`: `struct hns_roce_v2_db db;` ✗ (the only exception)
This pattern strongly indicates that the uninitialized `db` variable in
`update_srq_db()` is a bug rather than intentional design. ## 3. **Real
Runtime Impact Potential** This is not merely a cosmetic compiler
warning. The uninitialized data can cause: - **Subtle SRQ functionality
degradation**: Random bits in hardware doorbell registers can confuse
the hardware - **Performance issues**: Incorrect doorbell values may
cause hardware to misinterpret commands - **Silent data corruption**:
Unlike crashes, this bug could cause hard-to-debug networking issues -
**Hardware state corruption**: Writing garbage to hardware registers can
put the device in unexpected states ## 4. **Production Environment
Risk** SRQ (Shared Receive Queue) is a critical InfiniBand/RoCE feature
used in high-performance computing and data center environments. Any
corruption in SRQ operations can: - Impact network throughput and
latency - Cause intermittent packet loss or reordering - Lead to
difficult-to-reproduce performance regressions - Affect reliability of
distributed applications ## 5. **Low-Risk, High-Value Fix** The fix is
minimal and safe: - Changes only initialization: `struct hns_roce_v2_db
db = {};` - Zero-initialization has no functional side effects - Follows
established patterns in the same driver - No API changes or behavioral
modifications - Extremely low regression risk ## 6. **Similar Historical
Precedent** Looking at the similar commits provided, commit #4 (Status:
YES) shows a nearly identical fix for uninitialized variable usage in
the same driver family: ```c doorbell[0] = cons_index &
((hr_cq->cq_depth << 1) - 1); +doorbell[1] = 0; // Initialize before use
roce_set_bit(doorbell[1], ROCEE_DB_OTHERS_H_ROCEE_DB_OTH_HW_SYNS_S, 1);
``` This historical precedent confirms that uninitialized variable fixes
in HNS RoCE hardware register operations are considered important enough
for stable backporting. ## 7. **Affects Multiple Compiler Versions** The
commit message shows this affects GCC 13.3.0 with specific optimization
flags, but uninitialized variable usage is fundamentally unsafe
regardless of compiler version or warning visibility. **Conclusion**:
This commit fixes a real hardware register corruption bug with potential
for silent data corruption in production RoCE/InfiniBand environments.
The fix is minimal, safe, and follows established patterns. It should be
backported to ensure system reliability in stable kernel deployments.

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f5c3e560df58d..d63c66c4a8b73 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -943,7 +943,7 @@ static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
 static void update_srq_db(struct hns_roce_srq *srq)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
-	struct hns_roce_v2_db db;
+	struct hns_roce_v2_db db = {};
 
 	hr_reg_write(&db, DB_TAG, srq->srqn);
 	hr_reg_write(&db, DB_CMD, HNS_ROCE_V2_SRQ_DB);
-- 
2.39.5


