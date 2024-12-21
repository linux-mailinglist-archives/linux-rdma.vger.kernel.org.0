Return-Path: <linux-rdma+bounces-6693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7C9F9DCB
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8191893081
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9813A88A;
	Sat, 21 Dec 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TQuegl27"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEE1E89C;
	Sat, 21 Dec 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734745234; cv=none; b=PHCosQwzYXjrD5uYp+fLTVc24y8ErH8S71XBBZWoulo3O8IIrlba51nT9E7AKZY62n89ruljn11oorHNJDCR/eCebfeLH7fye7W/iDtxRlUMuC1QHA2J4QNccOjWCPpRUhdjmM0vdWNcTrpKkx74FMpD54d2Z6R02tS5+BQnJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734745234; c=relaxed/simple;
	bh=AmNVM5IWh2Kce00IvhmYlzFrv98WbbkAXRoqyqh5SSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxoXYqPHT6nt2WHW/F+NRUToSHLh3h5Ax6hoIEHgM7AWCljnMYq8cgx1x+SS3SWRq7kIB1kRKvq5CAg2mQQA8gtF5h6xlXQk7i7QNtq6IZCiH3sk3oh45OCHa9X8rUBxhOVlJ6kZO/R4OtQcBOXEap07bAfJNGx2MMn2y2boqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TQuegl27; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=T//G2rCd97TI1u3JSZ4/q5jOgTeoWPeGWz1x8NI4gFw=; b=TQuegl27a7dLmBaf
	300grBg46IKqLMDdN7Zol2TJNfAADLSgTcp9xqrIyh8RYC20mUwC+sDGsI4mDGSmnLMkIbcuHfu4n
	ZiAQmkZbHFIGKFw+mqtPKc4l5T1ajiLLDgQZymgdzgGfAadaE0RttZcc0YjQhzNbaKQtxSSmTC7aH
	zc7vCgCuiX9WGq3WXGGgzaozVXJNTjplYIEpJT5N+cD6Rlz5Z3754YIqz0Z6sY6elPhMbp0XEOyDI
	BvE4gbF2ZdFa1Xgl+E9z0l5udGkoW0s9C3QS59aw36CaYb/gl5d2NiMdhReKtqmUtytycS8GHPahO
	suPbf4/4BpCRFdRZsg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tOoTj-006dmT-16;
	Sat, 21 Dec 2024 01:40:27 +0000
From: linux@treblig.org
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/4] RDMA/core: Remove unused ib_ud_header_unpack
Date: Sat, 21 Dec 2024 01:40:18 +0000
Message-ID: <20241221014021.343979-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221014021.343979-1-linux@treblig.org>
References: <20241221014021.343979-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ib_ud_header_unpack() is unused, and I can't see any sign of it
ever having been used in git.  The only reference I can find
is from December 2004 BKrev: 41d30034XNbBUl0XnyC6ig9V61Nf-A when
it looks like it was added.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/core/ud_header.c | 83 -----------------------------
 include/rdma/ib_pack.h              |  3 --
 2 files changed, 86 deletions(-)

diff --git a/drivers/infiniband/core/ud_header.c b/drivers/infiniband/core/ud_header.c
index 64d9c492de64..8d3dfef9ebaa 100644
--- a/drivers/infiniband/core/ud_header.c
+++ b/drivers/infiniband/core/ud_header.c
@@ -462,86 +462,3 @@ int ib_ud_header_pack(struct ib_ud_header *header,
 	return len;
 }
 EXPORT_SYMBOL(ib_ud_header_pack);
-
-/**
- * ib_ud_header_unpack - Unpack UD header struct from wire format
- * @header:UD header struct
- * @buf:Buffer to pack into
- *
- * ib_ud_header_pack() unpacks the UD header structure @header from wire
- * format in the buffer @buf.
- */
-int ib_ud_header_unpack(void                *buf,
-			struct ib_ud_header *header)
-{
-	ib_unpack(lrh_table, ARRAY_SIZE(lrh_table),
-		  buf, &header->lrh);
-	buf += IB_LRH_BYTES;
-
-	if (header->lrh.link_version != 0) {
-		pr_warn("Invalid LRH.link_version %u\n",
-			header->lrh.link_version);
-		return -EINVAL;
-	}
-
-	switch (header->lrh.link_next_header) {
-	case IB_LNH_IBA_LOCAL:
-		header->grh_present = 0;
-		break;
-
-	case IB_LNH_IBA_GLOBAL:
-		header->grh_present = 1;
-		ib_unpack(grh_table, ARRAY_SIZE(grh_table),
-			  buf, &header->grh);
-		buf += IB_GRH_BYTES;
-
-		if (header->grh.ip_version != 6) {
-			pr_warn("Invalid GRH.ip_version %u\n",
-				header->grh.ip_version);
-			return -EINVAL;
-		}
-		if (header->grh.next_header != 0x1b) {
-			pr_warn("Invalid GRH.next_header 0x%02x\n",
-				header->grh.next_header);
-			return -EINVAL;
-		}
-		break;
-
-	default:
-		pr_warn("Invalid LRH.link_next_header %u\n",
-			header->lrh.link_next_header);
-		return -EINVAL;
-	}
-
-	ib_unpack(bth_table, ARRAY_SIZE(bth_table),
-		  buf, &header->bth);
-	buf += IB_BTH_BYTES;
-
-	switch (header->bth.opcode) {
-	case IB_OPCODE_UD_SEND_ONLY:
-		header->immediate_present = 0;
-		break;
-	case IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE:
-		header->immediate_present = 1;
-		break;
-	default:
-		pr_warn("Invalid BTH.opcode 0x%02x\n", header->bth.opcode);
-		return -EINVAL;
-	}
-
-	if (header->bth.transport_header_version != 0) {
-		pr_warn("Invalid BTH.transport_header_version %u\n",
-			header->bth.transport_header_version);
-		return -EINVAL;
-	}
-
-	ib_unpack(deth_table, ARRAY_SIZE(deth_table),
-		  buf, &header->deth);
-	buf += IB_DETH_BYTES;
-
-	if (header->immediate_present)
-		memcpy(&header->immediate_data, buf, sizeof header->immediate_data);
-
-	return 0;
-}
-EXPORT_SYMBOL(ib_ud_header_unpack);
diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index b8c56d7dc35d..8266fab826a7 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -283,7 +283,4 @@ int ib_ud_header_init(int		    payload_bytes,
 int ib_ud_header_pack(struct ib_ud_header *header,
 		      void                *buf);
 
-int ib_ud_header_unpack(void                *buf,
-			struct ib_ud_header *header);
-
 #endif /* IB_PACK_H */
-- 
2.47.1


