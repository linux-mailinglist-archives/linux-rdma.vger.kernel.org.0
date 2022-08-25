Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC45A1896
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiHYSNJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbiHYSMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F70E76761
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riJHOBdNMmZs8GX2vslyzCJQoAgfFKh7Rz4UoMtS+DE=;
        b=CbF02DFDKHKw1mk8QdaSJ/+u2pFQ5AyAaQO8hGt0DylT3cJ4o+MRbHAD3WacJjXGH+i6ki
        TRDvVwgPhk78Xy4coU+xqAcaUsgzZxeH9Mq5b/2e8juS1S5Btfjz6zUn+MQyXKUo97BumT
        bbuEMKcrc1qA7IOb+e6ECCrfGf52utE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569--tGJvWW2P2OWUmjWsL5rOQ-1; Thu, 25 Aug 2022 14:12:44 -0400
X-MC-Unique: -tGJvWW2P2OWUmjWsL5rOQ-1
Received: by mail-wr1-f71.google.com with SMTP id n17-20020adf8b11000000b0022536079ef1so3337484wra.0
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=riJHOBdNMmZs8GX2vslyzCJQoAgfFKh7Rz4UoMtS+DE=;
        b=EniAsNlcLIzBaecQW7l44z2cg3ADgYNfNyD9f+mouKSyckCS04Tra1svBDnAUcwmy0
         vxPHOYBYPVrV7kfAfhajtLer7CFwKDbK6YBie3DQ/VsyvOeaEFEJwI5C7Eauaz4kQFy8
         CDena1FKzplPqBehXyq6nrYWbgB1r8IlQ366lYeD0Y9lxLW+JZ2HKFYRsh907HPlxM2j
         b9BIhGLwfgOQcIZjzbNYgKrDotes3VsohRU8R1Iz2YK00F0Biw2sysH6xG9tnVvyhnpl
         LCroCwhxuxWI65+uZ4j/Ij9nFkZcOdqUrKKno4A3u3/wEMculL7avB1KqrSMPeFUw9en
         zt4g==
X-Gm-Message-State: ACgBeo2VuUaBxA+mQzRfe+NneJeTKRb3x+doGRDzWLznTRBEnxzVBk1Y
        dKqDjBy3w4F6gZX/uKaHrA01Xg7Rk5booDykZt9XR3NmlR+hjr2QXp+f4gfJlIcgclaiAWFqyQg
        g13F/MlVQzqWP6wzySrY4SQ==
X-Received: by 2002:a5d:4012:0:b0:225:283a:8273 with SMTP id n18-20020a5d4012000000b00225283a8273mr2943768wrp.8.1661451163278;
        Thu, 25 Aug 2022 11:12:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6JYTLUh9FypHhvAKJFPhVhQ2keQoaiGdrhdEB1pT+zv7XCZYmsLHFf3yeX34S4q77Fazv6cQ==
X-Received: by 2002:a5d:4012:0:b0:225:283a:8273 with SMTP id n18-20020a5d4012000000b00225283a8273mr2943735wrp.8.1661451163060;
        Thu, 25 Aug 2022 11:12:43 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:42 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v3 3/9] bitops: Introduce find_next_andnot_bit()
Date:   Thu, 25 Aug 2022 19:12:04 +0100
Message-Id: <20220825181210.284283-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220825181210.284283-1-vschneid@redhat.com>
References: <20220825181210.284283-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation of introducing for_each_cpu_andnot(), add a variant of
find_next_bit() that negate the bits in @addr2 when ANDing them with the
bits in @addr1.

Note that the _find_next_bit() @invert argument now gets split into two:
@invert1 for words in @addr1, @invert2 for words in @addr2. The only
current users of _find_next_bit() with @invert set are:
  o find_next_zero_bit()
  o find_next_zero_bit_le()
and neither of these pass an @addr2, so the conversion is straightforward.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/find.h | 44 ++++++++++++++++++++++++++++++++++++++------
 lib/find_bit.c       | 23 ++++++++++++-----------
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..a195cf0a8bab 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -10,7 +10,8 @@
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+		unsigned long start, unsigned long invert1, unsigned long invert2,
+		unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -41,7 +42,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -71,7 +72,38 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0UL, 0);
+}
+#endif
+
+#ifndef find_next_andnot_bit
+/**
+ * find_next_andnot_bit - find the next bit in *addr1 excluding all the bits
+ *                        in *addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_next_andnot_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, ~0UL, 0);
 }
 #endif
 
@@ -99,7 +131,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 0);
 }
 #endif
 
@@ -247,7 +279,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 1);
 }
 #endif
 
@@ -266,7 +298,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 1);
 }
 #endif
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..c46b66d7d2b4 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -21,27 +21,29 @@
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
+	!defined(find_next_and_bit) || !defined(find_next_andnot_bit)
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
+ *  - The "invert" arguments, which are XORed with each fetched word (invert1
+ *    for words in addr1, invert2 for those in addr2) before searching it for
+ *    one bits.
  */
 unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+			     const unsigned long *addr2,
+			     unsigned long nbits, unsigned long start,
+			     unsigned long invert1, unsigned long invert2,
+			     unsigned long le)
 {
 	unsigned long tmp, mask;
 
 	if (unlikely(start >= nbits))
 		return nbits;
 
-	tmp = addr1[start / BITS_PER_LONG];
+	tmp = addr1[start / BITS_PER_LONG] ^ invert1;
 	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
+		tmp &= addr2[start / BITS_PER_LONG] ^ invert2;
 
 	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
@@ -57,10 +59,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 		if (start >= nbits)
 			return nbits;
 
-		tmp = addr1[start / BITS_PER_LONG];
+		tmp = addr1[start / BITS_PER_LONG] ^ invert1;
 		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
+			tmp &= addr2[start / BITS_PER_LONG] ^ invert2;
 	}
 
 	if (le)
-- 
2.31.1

