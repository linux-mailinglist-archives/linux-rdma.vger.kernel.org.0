Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A115E7BC8
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIWN0T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiIWN0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 09:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4D145CBA
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663939557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v7UUwoj2z6XyTFhjMkkxJBC5oQ9g5/RV9r887kLcjk=;
        b=QHcBH+zGrluJ8OwYL1j5obuUMPWVDkSc9LI0HCJOmugqV+5/6f0j9gAjxyzTAxzNu7Ebwt
        y2gF88ogPzBmkUAxxiMyosTpdM+PSweavVa8SqaMzK4PQN5km1mgN34DkZiKm0LoS3DaEe
        v9j+kbTl8rwNrK2i3G9EFP2TtEFIyZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-158HFahzPOyxg81OqdWHvQ-1; Fri, 23 Sep 2022 09:25:54 -0400
X-MC-Unique: 158HFahzPOyxg81OqdWHvQ-1
Received: by mail-wm1-f72.google.com with SMTP id h187-20020a1c21c4000000b003b51369ff1bso736053wmh.3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 06:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3v7UUwoj2z6XyTFhjMkkxJBC5oQ9g5/RV9r887kLcjk=;
        b=D5n9HhZNBSGYu6uutg75qs0nC5BJjYH2VuQuehl4ImbsPMUsh52dvb6byzqjKbziKx
         ZHJvZvoY1iuWLh3BnnxwrpWyRVqA8R1YR1LxpJHTaXl1sPVj+ZINGdll1P61fG22CtAx
         PSikNGVrYTnvpld3DUBdifhSjBrD/IiPhw26couPmyYoIoub9ViYKa7rW3k0mibniEDV
         j2l8X4rv/w6r3SBPYbIvknaNed4fWgBuoJ7pP9Fn6vE+w+BHS8lUgSpGoVwyUmGvxEh5
         Gfhv4MA5Ez//iEihVVx1iVQfFgzTZRVxZAvQLdM+BRukujHOBCMNXnJb19346Tgk+qqM
         cgJg==
X-Gm-Message-State: ACrzQf07GD+5PP4Y/f6Hjv6oxcYxI8cNlegcwtWo6mJxlnOdOJSUFJVO
        tdjDBCv+LXpXJ20YzT4MRVxvo7HEi8+VjkYcPcui0+7B8UHNkjBt8c1/6glw0xWJj6DUaAQxBvD
        b8Uq90HdS8VA4/svq+2QsPQ==
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff1:4fcc with SMTP id m6-20020a7bca46000000b003b47ff14fccmr13250195wml.47.1663939551503;
        Fri, 23 Sep 2022 06:25:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7G6JjOLCwT6f+/rhD9fsfQaNjJBH3cpQyFzkJ5Y39WRlDbzFautTo6dP0A7bA2xxxc1pNi1Q==
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff1:4fcc with SMTP id m6-20020a7bca46000000b003b47ff14fccmr13250179wml.47.1663939551281;
        Fri, 23 Sep 2022 06:25:51 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0022add5a6fb1sm7067306wru.30.2022.09.23.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:25:50 -0700 (PDT)
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
Subject: [PATCH v4 1/7] lib/find_bit: Introduce find_next_andnot_bit()
Date:   Fri, 23 Sep 2022 14:25:21 +0100
Message-Id: <20220923132527.1001870-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923132527.1001870-1-vschneid@redhat.com>
References: <20220923132527.1001870-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation of introducing for_each_cpu_andnot(), add a variant of
find_next_bit() that negate the bits in @addr2 when ANDing them with the
bits in @addr1.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/find.h | 33 +++++++++++++++++++++++++++++++++
 lib/find_bit.c       |  9 +++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index dead6f53a97b..e60b1ce89b29 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -12,6 +12,8 @@ unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
 				unsigned long start);
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
@@ -86,6 +88,37 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_andnot_bit
+/**
+ * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
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
+	return _find_next_andnot_bit(addr1, addr2, size, offset);
+}
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index d00ee23ab657..53b02405421b 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -120,6 +120,15 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 EXPORT_SYMBOL(_find_next_and_bit);
 #endif
 
+#ifndef find_next_andnot_bit
+unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_andnot_bit);
+#endif
+
 #ifndef find_next_zero_bit
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start)
-- 
2.31.1

