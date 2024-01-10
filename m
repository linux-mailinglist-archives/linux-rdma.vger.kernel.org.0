Return-Path: <linux-rdma+bounces-574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715F828445
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 11:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0584B1F2511F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1337169;
	Tue,  9 Jan 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FwE6pRuy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0ED3715E;
	Tue,  9 Jan 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 6373F20AEC8A; Tue,  9 Jan 2024 02:51:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6373F20AEC8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704797491;
	bh=Qh4vCcMbs6V3VMTJ7hXH2GEKRppPqxUeLFTB/Ig1nok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwE6pRuyaI+HJkDB3Afk1M4hhFkZwSOQlWfPwZXinmuveNFMzrjnBbyvhUeNLDXdE
	 N7NHLkaiU/olpqoZ2mqgwZMV5emDY4NEb3+rDHQ4ihr8HG7ZnsASjlOMz/CNEOLQU4
	 qRgCuvSHZq6rV52WdrNTpoXf4wp8WyW1BQ5LrM1s=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH 1/4 net-next] cpumask: add cpumask_weight_andnot()
Date: Tue,  9 Jan 2024 02:51:15 -0800
Message-Id: <1704797478-32377-2-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Yury Norov <yury.norov@gmail.com>

Similarly to cpumask_weight_and(), cpumask_weight_andnot() is a handy
helper that may help to avoid creating an intermediate mask just to
calculate number of bits that set in a 1st given mask, and clear in 2nd
one.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/linux/bitmap.h  | 12 ++++++++++++
 include/linux/cpumask.h | 13 +++++++++++++
 lib/bitmap.c            |  7 +++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..5814e9ee40ba 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -54,6 +54,7 @@ struct device;
  *  bitmap_full(src, nbits)                     Are all bits set in *src?
  *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
  *  bitmap_weight_and(src1, src2, nbits)        Hamming Weight of and'ed bitmap
+ *  bitmap_weight_andnot(src1, src2, nbits)     Hamming Weight of andnot'ed bitmap
  *  bitmap_set(dst, pos, nbits)                 Set specified bit area
  *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
  *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
@@ -169,6 +170,8 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 				 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
+				    const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -425,6 +428,15 @@ unsigned long bitmap_weight_and(const unsigned long *src1,
 	return __bitmap_weight_and(src1, src2, nbits);
 }
 
+static __always_inline
+unsigned long bitmap_weight_andnot(const unsigned long *src1,
+				   const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return hweight_long(*src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits));
+	return __bitmap_weight_andnot(src1, src2, nbits);
+}
+
 static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..228c23eb36d2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -719,6 +719,19 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
 	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
 }
 
+/**
+ * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
+ * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
+ * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
+ *
+ * Return: count of bits set in both *srcp1 and *srcp2
+ */
+static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
+						const struct cpumask *srcp2)
+{
+	return bitmap_weight_andnot(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
+}
+
 /**
  * cpumask_shift_right - *dstp = *srcp >> n
  * @dstp: the cpumask result
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 09522af227f1..b97692854966 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -348,6 +348,13 @@ unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_weight_and);
 
+unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(bitmap1[idx] & ~bitmap2[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_weight_andnot);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
-- 
2.34.1


