Return-Path: <linux-rdma+bounces-6113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E799D986C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 14:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B805B2C29B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD7B1D432F;
	Tue, 26 Nov 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgkqtAQV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B01CD219
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626640; cv=none; b=EHTM3wp1HuVGRlnOha2rloxvrV5X4xz4zg6BPqZoMLpVxc5eSS/WpOS3Gw/Cf12lLfyB3BPQmYai2D4Oi2rrwgAeWuJOdKNbW/ihYh53UAnPpCNRbEcRDl6jZquRNodZnF+d8IreibdcE/bvYSviFJAGjI7oHQfYqir4eNF8UDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626640; c=relaxed/simple;
	bh=chLLMlgUzdMMD+Q24oy4wJzQ5COn0RRQw0ecdIZgbpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePlfmt+wpQbdLd8/4tIAQ8S0DpQmCoVv1yx5y/mZb2lPOF8aoOVXioEH3g41L4txtObkfjewwQWtw9VOobUAatLNDXX4YTV9m2IPitTHFGpWHQIgNaGvvf2+ka2vTnMp2lH0/b5Tx22t+X2iUKHpS0V2R/B0uvgXg3I7GTKHL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgkqtAQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E80C4CECF;
	Tue, 26 Nov 2024 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732626640;
	bh=chLLMlgUzdMMD+Q24oy4wJzQ5COn0RRQw0ecdIZgbpw=;
	h=From:To:Cc:Subject:Date:From;
	b=PgkqtAQVT3Dcbsfkv9eGxnYcE7qNhsn5PPOACtH9CscBDlVHuRQfnfcSrs2UaYUdc
	 zvNig2r/qEfkpfnZhTEER6Pv/L6U/pZ44XT3iJmk/3xmy5Vdg7WrvriWDd7EIlqgKE
	 nr+/DPfrxG/37dJCLjqsFyAMDhWZCNQ1P17KKHLH8getH2IYcxzWJDN6mwVLmaBLkk
	 vxY9R+mWcuE7lzFLgVezgtKUUUz1cxeBl6WuWMzXiSspQT3QiTziOasil/Q6WOE78G
	 d+24gj0UC04w/cO9HZfAHzYuXYTtlvCxVL0mX0xJ7WwGu41QlRW/7B0HVXsFgw9NFD
	 LD6baCl7N+O0w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	kernel test robot <lkp@intel.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Remove always true dattr validity check
Date: Tue, 26 Nov 2024 15:10:31 +0200
Message-ID: <be0d8836b64cba3e479fbcbca717acad04aae02e.1732626579.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

res->dattr is always valid at this point as it was initialized
during device addition in bnxt_re_add_device().

This change is fixing the following smatch error:
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp()
     error: we previously assumed 'res->dattr' could be null (see line 985)

Fixes: 07f830ae4913 ("RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411222329.YTrwonWi-lkp@intel.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 256c4379ab7f..90e4faebef09 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -995,9 +995,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u32 tbl_indx;
 	u16 nsge;
 
-	if (res->dattr)
-		qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
-
+	qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
 	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP,
-- 
2.47.0


