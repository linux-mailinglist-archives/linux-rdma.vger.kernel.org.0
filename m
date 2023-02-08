Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630B68FB20
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Feb 2023 00:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBHXZ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 18:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBHXZ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 18:25:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103031350C
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 15:25:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u9so957176plf.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Feb 2023 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0M2E7/02dlvJiZTVnIWyTeiMgvIxEtCuzBBJQtnX/JM=;
        b=Kd9X91L6aWl2C3IzFAJHT8vpU0II3tABmPdCDH04pU/uxfCFwSa5tkFhGGB5PhDCDp
         +k/qHRN10g97J7gf+YNa+8elgTJi5pXXGs8Mu4qnhlM5t5IkP6iwW10whdguunezqGri
         DevJn+KBLyJ4SSCRG+EOWDHZk57IPnjTS4lvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M2E7/02dlvJiZTVnIWyTeiMgvIxEtCuzBBJQtnX/JM=;
        b=XlPg9l3SkFwUye+ItQOIZIggt9c4vhS/IxsBXMAfXOmIezOdx+ff4MQsk5uftx/bEP
         tXVQwjieI4mP5PMCwgTyFNFl4MOGTmOCTZuO70IS++MU1ysESth0jMF/op02wZa70gji
         WjLEzQRYINhxKIXRIMTd2U/ouI28gaGP0seP2LJ+/2HnSfrVqF+ea99hYQ12vqTIIUsB
         DpKEoULDKvMCgrMRWMc1xcDO0GV1FpeiYG14cSq+dtdW3j0aiiLE5OkrDvwTU3kWm05r
         Cc5af5rcH45mdZ7uTlywDRJfoGWmi9IUNuGBksV+0LOdEc7COCGncTDLvuCFKkeb4lhT
         8h3w==
X-Gm-Message-State: AO0yUKUIYgaVoUBMtRArgCPprmULXqiPes9JpvcqT89Bui+QeQZHoQ8N
        r2i3+bmK0WGqv5RsXU5TPRK3HQ==
X-Google-Smtp-Source: AK7set8SetsuX6rbiBZxlHxYNn9FBxyZwIzOoKbjerCb50EmBWaeirDi/oDkDvepCt8g5slk5CyDfQ==
X-Received: by 2002:a17:902:e807:b0:196:8d48:8760 with SMTP id u7-20020a170902e80700b001968d488760mr9818064plg.31.1675898755570;
        Wed, 08 Feb 2023 15:25:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b0019937ea86c1sm3530plb.143.2023.02.08.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:25:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/cma: Distinguish between sockaddr_in and sockaddr_in6 by size
Date:   Wed,  8 Feb 2023 15:25:53 -0800
Message-Id: <20230208232549.never.139-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; h=from:subject:message-id; bh=S5Y2WqgnxK+dD2vZwFfFa98eG26CHb9Bq4BbhYiNp8M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj5C+AQcHckxweuEWNyvark/PYjLKlD6QPhLzpFhW2 //P+xfOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY+QvgAAKCRCJcvTf3G3AJkaXD/ 0Q8vmWdNfRbhG7QjCOcU5RLk01tCzr6qK2z1IjOYKHSQah3XfBTRyJZZ6vdhRyO33/vPn+wg8g1ixe v8iVPQSpq9MtHlf16dKbjUBL8LAJT2JmJw4I9Mwzu8m0/Pt7PmmtqhydIHOrwNjXy099XMFTWVhNNl OcylAZWnoHIgfY7yGkCSlu59hc3DltyZIwJywxmAMV1CtrciasjEmk3yYduudNO6/m50OvgL439gF+ ckhKNrLD60fhgVLXIa20QbjsOPOIVoVDYirEbTR7Ju3j4gh2YfLfinNlDVKkN1Afshh0iRqBtQUP1k XI313gn/kog5bX+i8KYpn5GPPCy5psYt3CGa9HS0lrWemsFl1jAW64WCTFviA5jYPIjwqdvADQPigk ugy1yvXLa9EZfqFur8+9xZ2fOQXUNcvRaAiInxTOih5NJCVcS+d6qBP0kq01iGxbmytAYmRwM0Xr7i QQvv8UpTELf+EjmUo44tM7LmG6/otUaqBAw9xbLfM7zt11cDzcegecfShJmC9BQuzmjTnljOM1f814 hv6ldPRxbT4KWgwtFuhE8G/bzGWqTZvRXXUTKQG/EM0rJR3tq1HziF1hvD8FY0Q7huXzjGZgCGjoQq kthAUN+/dyo141RIa3xqY9ZyXr79CLSYcjl89NEWOwbnCBCC6wWnaz3hY1oA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Clang can do some aggressive inlining, which provides it with greater
visibility into the sizes of various objects that are passed into
helpers. Specifically, compare_netdev_and_ip() can see through the type
given to the "sa" argument, which means it can generate code for "struct
sockaddr_in" that would have been passed to ipv6_addr_cmp() (that expects
to operate on the larger "struct sockaddr_in6"), which would result in a
compile-time buffer overflow condition detected by memcmp(). Logically,
this state isn't reachable due to the sa_family assignment two callers
above and the check in compare_netdev_and_ip(). Instead, provide a
compile-time check on sizes so the size-mismatched code will be elided
when inlining. Avoids the following warning from Clang:

../include/linux/fortify-string.h:652:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
                        __read_overflow();
                        ^
note: In function 'cma_netevent_callback'
note:   which inlined function 'node_from_ndev_ip'
1 error generated.

When the underlying object size is not known (e.g. with GCC and older
Clang), the result of __builtin_object_size() is SIZE_MAX, which
will also compile away, leaving the code as it was originally.

Link: https://github.com/ClangBuiltLinux/linux/issues/1687
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-rdma@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/core/cma.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1d2bff91d78b..308155937713 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -479,13 +479,20 @@ static int compare_netdev_and_ip(int ifindex_a, struct sockaddr *sa,
 	if (sa->sa_family != sb->sa_family)
 		return sa->sa_family - sb->sa_family;
 
-	if (sa->sa_family == AF_INET)
-		return memcmp((char *)&((struct sockaddr_in *)sa)->sin_addr,
-			      (char *)&((struct sockaddr_in *)sb)->sin_addr,
+	if (sa->sa_family == AF_INET &&
+	    __builtin_object_size(sa, 0) >= sizeof(struct sockaddr_in)) {
+		return memcmp(&((struct sockaddr_in *)sa)->sin_addr,
+			      &((struct sockaddr_in *)sb)->sin_addr,
 			      sizeof(((struct sockaddr_in *)sa)->sin_addr));
+	}
+
+	if (sa->sa_family == AF_INET6 &&
+	    __builtin_object_size(sa, 0) >= sizeof(struct sockaddr_in6)) {
+		return ipv6_addr_cmp(&((struct sockaddr_in6 *)sa)->sin6_addr,
+				     &((struct sockaddr_in6 *)sb)->sin6_addr);
+	}
 
-	return ipv6_addr_cmp(&((struct sockaddr_in6 *)sa)->sin6_addr,
-			     &((struct sockaddr_in6 *)sb)->sin6_addr);
+	return -1;
 }
 
 static int cma_add_id_to_tree(struct rdma_id_private *node_id_priv)
-- 
2.34.1

