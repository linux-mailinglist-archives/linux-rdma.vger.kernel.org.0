Return-Path: <linux-rdma+bounces-6692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D09F9DCA
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 02:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6087E7A2B8D
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB742BD1D;
	Sat, 21 Dec 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="j6GFY9aN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E412AF16;
	Sat, 21 Dec 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734745233; cv=none; b=YRqzuEaKeIbO5E8/zvO1ZrzHntID3s+NE3UrOXTHIFqZD7WqeuOQL9BgflD345Sw1ovUM8F9mlErEYQ0nB8uKYMTQQLL94w67j3KaZ+WnQ2Wtc1dyxgypMgkixaIWPJWSBH9GYxjm5gf9XJDzR+862oUBMw1OcNapoVllHGGTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734745233; c=relaxed/simple;
	bh=bbUHuIIiJDY1be55IxLZHg2oplHHF6t2SmPC6Qqqgho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX2cRXzgj4mQTcNpP9YVX1vZ+TaYKnLKVLtHRaSv/TRSKQGf7nkuBskIPblQ5Hw4Ti8eodf6UsGgDVribXOcmSUIhd0134CyWqTjQsUPLX/dCc8vCqc/l/OfObUegvGSH0AW4p3iWozGjiDJ0HXgOVx7SoFfC1gMjNRJddsnpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=j6GFY9aN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7mvzulzb+HhH+BBqrE2pES0KkxiCmlF0e03o5S4f2/0=; b=j6GFY9aN33KHHLCj
	ldsORg1cTXD220tC4JsmO3riCIqyvDvPBuatGIWkXJ2EvbQ6a0IGoU59yZXHkO97Gwfr/cpRnurhU
	3JDWt59ykUHZrKXiZiJYaCOQXWYwPfHhzKuJVGrl241ovmdKKeVS007zrsYA36BJmAXNW5NW6rtFY
	lQQdTnuurSSopgqZZsaZzGn0YoO5b0zHsxDTJHPWNx9Jo66Trv98ScedMsZQf0hU1aUM4rJUjxCE7
	QIeES5E7bhsVkirMp7PrF9DqouuKYrQtdwdBVTPFoo3NxY1ikCoGwj7lovdpdIFO/DkT7Pm5jJsir
	LJOXpxnMnk8SD1KDiA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tOoTl-006dmT-0Y;
	Sat, 21 Dec 2024 01:40:29 +0000
From: linux@treblig.org
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/4] RDMA/core: Remove unused ib_copy_path_rec_from_user
Date: Sat, 21 Dec 2024 01:40:21 +0000
Message-ID: <20241221014021.343979-5-linux@treblig.org>
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

ib_copy_path_rec_from_user() has been unused since 2019's
commit a1a8e4a85cf7 ("rdma: Delete the ib_ucm module")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/core/uverbs_marshall.c | 42 -----------------------
 include/rdma/ib_marshall.h                |  3 --
 2 files changed, 45 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_marshall.c b/drivers/infiniband/core/uverbs_marshall.c
index 11a080646916..e803f609ec87 100644
--- a/drivers/infiniband/core/uverbs_marshall.c
+++ b/drivers/infiniband/core/uverbs_marshall.c
@@ -171,45 +171,3 @@ void ib_copy_path_rec_to_user(struct ib_user_path_rec *dst,
 	__ib_copy_path_rec_to_user(dst, src);
 }
 EXPORT_SYMBOL(ib_copy_path_rec_to_user);
-
-void ib_copy_path_rec_from_user(struct sa_path_rec *dst,
-				struct ib_user_path_rec *src)
-{
-	u32 slid, dlid;
-
-	memset(dst, 0, sizeof(*dst));
-	if ((ib_is_opa_gid((union ib_gid *)src->sgid)) ||
-	    (ib_is_opa_gid((union ib_gid *)src->dgid))) {
-		dst->rec_type = SA_PATH_REC_TYPE_OPA;
-		slid = opa_get_lid_from_gid((union ib_gid *)src->sgid);
-		dlid = opa_get_lid_from_gid((union ib_gid *)src->dgid);
-	} else {
-		dst->rec_type = SA_PATH_REC_TYPE_IB;
-		slid = ntohs(src->slid);
-		dlid = ntohs(src->dlid);
-	}
-	memcpy(dst->dgid.raw, src->dgid, sizeof dst->dgid);
-	memcpy(dst->sgid.raw, src->sgid, sizeof dst->sgid);
-
-	sa_path_set_dlid(dst, dlid);
-	sa_path_set_slid(dst, slid);
-	sa_path_set_raw_traffic(dst, src->raw_traffic);
-	dst->flow_label		= src->flow_label;
-	dst->hop_limit		= src->hop_limit;
-	dst->traffic_class	= src->traffic_class;
-	dst->reversible		= src->reversible;
-	dst->numb_path		= src->numb_path;
-	dst->pkey		= src->pkey;
-	dst->sl			= src->sl;
-	dst->mtu_selector	= src->mtu_selector;
-	dst->mtu		= src->mtu;
-	dst->rate_selector	= src->rate_selector;
-	dst->rate		= src->rate;
-	dst->packet_life_time	= src->packet_life_time;
-	dst->preference		= src->preference;
-	dst->packet_life_time_selector = src->packet_life_time_selector;
-
-	/* TODO: No need to set this */
-	sa_path_set_dmac_zero(dst);
-}
-EXPORT_SYMBOL(ib_copy_path_rec_from_user);
diff --git a/include/rdma/ib_marshall.h b/include/rdma/ib_marshall.h
index 1838869aad28..b179e464e3d1 100644
--- a/include/rdma/ib_marshall.h
+++ b/include/rdma/ib_marshall.h
@@ -22,7 +22,4 @@ void ib_copy_ah_attr_to_user(struct ib_device *device,
 void ib_copy_path_rec_to_user(struct ib_user_path_rec *dst,
 			      struct sa_path_rec *src);
 
-void ib_copy_path_rec_from_user(struct sa_path_rec *dst,
-				struct ib_user_path_rec *src);
-
 #endif /* IB_USER_MARSHALL_H */
-- 
2.47.1


