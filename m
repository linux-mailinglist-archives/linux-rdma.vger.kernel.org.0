Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B841D8152
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbfJOUs2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 16:48:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7061 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfJOUs2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 16:48:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da630a60000>; Tue, 15 Oct 2019 13:48:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2019 13:48:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 15 Oct 2019 13:48:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 20:48:23 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 15 Oct 2019 20:48:23 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da630970001>; Tue, 15 Oct 2019 13:48:23 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Date:   Tue, 15 Oct 2019 13:48:13 -0700
Message-ID: <20191015204814.30099-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015204814.30099-1-rcampbell@nvidia.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571172518; bh=ZZhSB0WUUPUDrnLD8z7rnTwiKESqFNFJ5aP7cjGYBUM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=LwMNe2T69HkSLJ/twKlK4kzxORRo81qG6LDqYO2uEVo/VCQEPM1TjYti1gw61Cd+L
         8lU/he1F1x5aC8JIgjT88YgiHBT4aCh8UB5uMGjwfQKYUYH2mFrLDsenAl97s0wfcX
         KWsJWNihcNbfCUJF8G3y3pOlcnj1ynG3aivkz2YNFKfwqxlOYZngfyu6aPJB+h3Rko
         LZu8PbG16sKYVPbMkGgnt1bGD02FcicMq22NcCpE/im7ewmWnB/A+ZiXIJvCQLFP9a
         JA62eMOV5kR3WAbZHtsq3lxVuZtKx+9VlpGPmpK+GCMtQ6u9zdxD2K15aio5M6TVwC
         4F05tiUUYW8bg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow hmm_range_fault() to return success (0) when the CPU pagetable
entry points to the special shared zero page.
The caller can then handle the zero page by possibly clearing device
private memory instead of DMAing a zero page.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 5df0dbf77e89..f62b119722a3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -530,7 +530,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, uns=
igned long addr,
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		*pfn =3D range->values[HMM_PFN_SPECIAL];
-		return -EFAULT;
+		if (!is_zero_pfn(pte_pfn(pte)))
+			return -EFAULT;
+		return 0;
 	}
=20
 	*pfn =3D hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
--=20
2.20.1

