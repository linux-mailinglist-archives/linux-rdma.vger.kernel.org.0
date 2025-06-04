Return-Path: <linux-rdma+bounces-10960-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC6ACD5EE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 04:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B6F179438
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 02:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B9238142;
	Wed,  4 Jun 2025 02:53:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434251F9406;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005591; cv=none; b=i8iz8DLRhXi7fo8OXHvZYA427csb1nVYTQ1vSu91yBmgcVB8vubzV+mQ9C8fik5VQXa5I+/W2lFWbe2TWPEIV4MfqvLlo+laYJgSRlm2FgATH52InnVq05DmL4dGV0F/nUPsztuwMnDR5JxXcERdOXDyvWXnK1RBCikLPum1Hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005591; c=relaxed/simple;
	bh=e+j3xrBXRj8Ktfrm+ZoxGku00MV5+M4/mCibmEIzce8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VCseYQ0jzA54nBAWFp88krWQFWtAmpmYhNYFJdC/v0ZUCbsjHTfTon74WAonziabtYKS4Lxc0Gji5UDFECHlFLANq6u9oRURJhpv1ndaJI/8FgD1WW1s7X6tynrUfrF8WwwhVvwvxhxBrZI+sMSIP/nJUm+YeetoW+rb87PqEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-00-683fb50914d1
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [RFC v4 07/18] page_pool: use netmem put API in page_pool_return_netmem()
Date: Wed,  4 Jun 2025 11:52:35 +0900
Message-Id: <20250604025246.61616-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHfXfenZ0tF4dldTJIGllkF7NmPHSPIl66UVlfNMiRJzeaSzYz
	jYpVdhO1yEKxRTMt543FnLpqWM156QKa1ZppGpMJURp5y5xoTunbj+f/+/+/PAwlc+FQRq1N
	4XVapUZOS7CkL7hwlbh6q2rNRd9GMFoqaCgfTYOSb3YhGMtqEAz97RDBoKuJhqLCEQqMLRkY
	hi1jFPgavSLoftyLwXGtlgLvzWYasjP8FFyymwXQWpMjhDtjjyioNXwTwYdnRhq6KiaF0OvM
	xvC6oBRDd842aDTNg5G3PxG4LLUCGMm6T0Num4mGnoxuBG31Xgz3LuYgsNR5hOAfNdLbFhNb
	abuAPC34KiIm62lSZY4gmZ42iljLbtDEOnBbRDrdDpo05/sxeWofFJDsy/00+e37gsmvuk80
	sdg+YfLO5BKRQeuiA2ysZFMCr1Gn8rrILfESVbFtCCUbpGl9X9wCA/ohyUQMw7EK7v2fOZlI
	PI3f3RN0gGl2Gefx/KUCHMJGcYPeJpyJJAzF9gs5n9EvCARz2ENcqa1mWsJsOGcuqscBlrLR
	nPetHc+MhnHlT15OO2J2PdfZnzfdlU052faPVGCUY/tEnKNpQDRTWMC9MnvwLSQ1oaAyJFNr
	U5OUao1itSpdq05bffxUkhVN/fbx+fE4OxpojXEilkHyYKm9c4tKJlSm6tOTnIhjKHmINGz5
	1EmaoEw/y+tOHdOd1vB6J1rIYPl86dqRMwkyNlGZwp/k+WRe9z8VMOJQA1o63rHVMDZ7R8Pw
	51fPXScKoq/mLo3NW9S8vbOhJLFrpeJPSur44T0HLQ/Ee4uVP3RxivhCd8y5Hic+u2vD6C/3
	krnoYeP1/FmhF7IaKquu7Nu5P7jdj46E3H3xenf+96DJitDK3jdxE5WbtJp2R3XvCtwa3nY0
	OZFEmn2+dZtjW97LsV6ljIqgdHrlPxV/+c7XAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+5/bzk6OjkvroB+0AxEJeQG1FwyTCDr0QaM+qPXBndqhLXXK
	pqJBsFSwxFlmoNmEmZe8MltTjyESU7ygkHhjeUmZKaVlF028UanRtx/v83ufLw+Nq+sJP1pv
	yJCMBjGFpxiCiY3KO6NsO68LtRQEg9XeTEHTZja8nJdJsDa2I1jfmlbAWm8/BdVVGzhY3+UT
	8Mu+jcNin0cBc3VLBHQVdODgeTRAgSV/B4dcuR6DnspBEkbai0l4ul2LQ4d5XgFjb6wUfGj+
	Q8KSy0LAYEUDAXPFMdBnOwYbQ18Q9No7MNgoqqSgdNRGwUL+HILRHg8Bz+8XI7B3u0nY2bRS
	MbzgbHiPCZ0VswrB5sgUXtcHCYXuUVxwND6kBMfPJwphZrKLEgbKdwihU17DBEveKiX8WJwi
	hG/dE5RQ/ek7JtidE4QwbOtVXPG+zpzTSin6LMkYEq1hdDXOdZRuVmV/nZrEzGiFKURKmmPD
	uc+Tv6l9pthTnNu9he+zDxvGrXn6iULE0Di7SnKL1h1sPzjKXuUanO0HEsGe5Oqre4h9VrER
	nGdIJv6VBnBNrW8PHCUbyc2slh38qvccizyOP0aMDR1qRD56Q1aqqE+JCDYl63IM+uzgW2mp
	DrS3X9293RIZrY9dciGWRryXSp6J1qlJMcuUk+pCHI3zPqqA03snlVbMuSsZ05KMmSmSyYX8
	aYI/rrocL2nU7G0xQ0qWpHTJ+D/FaKWfGYkG5R3NRekF6U0GulYO88FDtXmNHUV5N2JjlgtZ
	pubI/LOEa60tcxa1HLgQXjmb6NWeW1ugvYlaSh60eZXySYk2qjI2UhOhjYpZPjFsjns1XlM+
	Pp3E0h9DZrl41bAv7ns21bmVW9XJjshlS34b/slxW6H5u84LXQm8W8sTJp0YFoQbTeJfU/fv
	DbsCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Use netmem put API, put_netmem(), instead of put_page() in
page_pool_return_netmem().

While at it, delete #include <linux/mm.h> since the last put_page() in
page_pool.c has been just removed with this patch.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b7680dcb83e4..dab89bc69f10 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -20,7 +20,6 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
-#include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
@@ -712,7 +711,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 /* Disconnects a page (from a page_pool).  API users can have a need
  * to disconnect a page (from a page_pool), to allow it to be used as
  * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
+ * page-allocator via put_netmem()).
  */
 static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
@@ -733,7 +732,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 
 	if (put) {
 		page_pool_clear_pp_info(netmem);
-		put_page(netmem_to_page(netmem));
+		put_netmem(netmem);
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
-- 
2.17.1


