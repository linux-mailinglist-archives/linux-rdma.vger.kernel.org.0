Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D919E303531
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbhAZFhH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbhAYMOI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:14:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB05722DD6;
        Mon, 25 Jan 2021 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611576333;
        bh=9zR/uFaXO3dFF48sbFxwC61okNjnl8PVhd1PNDFy/Uk=;
        h=From:To:Cc:Subject:Date:From;
        b=e2kA+XPoLJ1i/o7wc2stKHPMhJ3wuVNraSBd7V1D0+j31FUayqw59YfpB2HB8zbGG
         TPZzNnTziRKK55X5haeWxfC3vdFdHObPZBLlJ9kbtvlSvt/roZw9xbqLjsmFfovn2z
         g55BCgMzcrNKDXa4nijaZQpZwXjeHhvaedslTGvgEE7xwrhiD6lWJu4enKk8VQMot/
         Y+dENxMeBLeFLnB5tnxFKt7KOV7KsWGrmjHI5HNQJf2gYygyEUIatWdfIbJqUatx0h
         5tBfNO1T+0aVbknMBIjq9EZNKz1YzZfzJLST+ZCfG2l7TYnyBrHimac4XRFdLvucoI
         YOwlxdNe23omg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] tools/testing/scatterlist: Fix overflow of max segment size
Date:   Mon, 25 Jan 2021 14:05:27 +0200
Message-Id: <20210125120527.836363-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Because SCATTERLIST_MAX_SEGMENT was removed and replaced with UINT_MAX,
the test overflows the max_sgement variable. Remove this case.

Fixes: 7a60c2dd0f57 ("drm: Remove SCATTERLIST_MAX_SEGMENT")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 tools/testing/scatterlist/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/scatterlist/main.c b/tools/testing/scatterlist/main.c
index 71c960dcd8a4..652254754b4c 100644
--- a/tools/testing/scatterlist/main.c
+++ b/tools/testing/scatterlist/main.c
@@ -55,7 +55,6 @@ int main(void)
 	struct test *test, tests[] = {
 		{ -EINVAL, 1, pfn(0), NULL, PAGE_SIZE, 0, 1 },
 		{ 0, 1, pfn(0), NULL, PAGE_SIZE, PAGE_SIZE + 1, 1 },
-		{ 0, 1, pfn(0), NULL, PAGE_SIZE, sgmax + 1, 1 },
 		{ 0, 1, pfn(0), NULL, PAGE_SIZE, sgmax, 1 },
 		{ 0, 1, pfn(0), NULL, 1, sgmax, 1 },
 		{ 0, 2, pfn(0, 1), NULL, 2 * PAGE_SIZE, sgmax, 1 },
--
2.29.2

