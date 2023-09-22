Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C447AB741
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjIVR3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjIVR3N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DACC3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1859897a12.1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403744; x=1696008544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+fG/1IUZcjxNvMlyP56fbg8HR7JVnjt3riwCi0wfhY=;
        b=J/+k5jsAmIx4bdTb3V8uyh1rGB+L9KfD5cv+cgSCFbnWoaDnNaiNgkFLhtM61PH467
         aLZMY4X2BNfN9jeMDjnITDn1Ur9ZDSBXYVOPXb9N1kGtdW3L7q4GRNwhhzjsbrjXHdZe
         kkT4ggSAQoj3iVDQ+4siAXS/gLXbwnKzYJskc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403744; x=1696008544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+fG/1IUZcjxNvMlyP56fbg8HR7JVnjt3riwCi0wfhY=;
        b=jOa4H3UifDBC5GywXNTBjHxVBpZcJZeFhg4vuDw2CTCcKMCghNqrCOVhUBpw0ELFI+
         QdxHqmYEdu2CN36AAZkywX2LGUFrfjOiPdwn3pHQOjScReKFV8Es2oZVIW5aY68sf06f
         C4TpuC1dFwmLJOya0xoAcXOYYkPlI2m/HZUgXABNnqih1Dm6q5Bj8NrnG34oK8msLUST
         lxEFdPZMsWNLUD6zUbTXY1/b7nU737t+AYACkxVnUjV6Nv8VbFv0jYXwQ+/vniw+OS4R
         zJ8YyiLvnyShTFH48b43v0V0KG5AdGItUdS8ZAh4bww3c3yBceWnj7IOelkJ2NvnxJok
         LZKw==
X-Gm-Message-State: AOJu0YwTqPG6u6M6yPwKmuBAh/mjkYPAWut765UMVBz2j4jH/cFhzR2U
        /4zTrEw3rKgCJGT8hwMYPphYOQ==
X-Google-Smtp-Source: AGHT+IH6S8Qm5OPqgsDQKauIPObSxBk1dvTlx5l1M5gkLGsn8Dxuo+qpskJS1TC+0k22q1ogPLtjUA==
X-Received: by 2002:a17:90a:fb8c:b0:274:4fb:360a with SMTP id cp12-20020a17090afb8c00b0027404fb360amr385633pjb.16.1695403744652;
        Fri, 22 Sep 2023 10:29:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gq7-20020a17090b104700b0025bd4db25f0sm3544485pjb.53.2023.09.22.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alex Elder <elder@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, dev@openvswitch.org,
        linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 07/14] net: mana: Annotate struct mana_rxq with __counted_by
Date:   Fri, 22 Sep 2023 10:28:49 -0700
Message-Id: <20230922172858.3822653-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=keescook@chromium.org;
 h=from:subject; bh=ZdDX1htO5g9RU0JVxl8E3nenoSp50ETWGlk5dSjb3Pk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7XhV+304GTOyf/fNFFzA18xiqgiag6BHBkU
 r6QL6lj+iGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 JttUD/4nw3GnIK/006QbQZGOylTpwCOUiis/9zO+cYuRhscdH8v/ABtugcRwPC6Cn46YyRhmelJ
 I2EjfW+CUaswbO+4XodbsNw1MP3/9Rh2Z9hxWJp/ixVY+9Gr/Xso37A3Kx7yx/j9g7cJ5G8FsHR
 BhADK3SY0PK+fm8vEQHbU47FLD+SDObsUZwCTiQppe3Qyj4rtHRPkpvlP8Xtnc3oktAK9NfjPO4
 BYX4lmas+XoVTX/BFSYNV+dbtgn9PgTb5cIcrf+KYs1b21rtyLu7FAM/T0PHhS5lrEfGjiDqIXO
 0HnCVEXXW+bGsbCUW5vcgJX0NOpM8VO45dmzonA+kMLxzbeOr31HUL+vx9F41U6UFLiosKhC35X
 QKeQKslSIwT9mFn9vcACY3wusuQlm2dm5Gb6CJ6xJhihRmK+yH+a6EZadQqvSoyBI1jX/P4o4cg
 sNTuPs+4n3fXOjGWHI1inrX2o79utjzSj6NnfBHfWaSsJwBy5DLPBUA7QEk5YnSa0PpkGZXbZov
 542ytPJTcKvRQlZRIwvp7bbD6cF+jq/ZtXo/ut0guz7iB3rUVKztN8ninv86elhhA7yicM598rP
 JLBjpJsix6aeD9dFf7JzIxn3ZYFhogdNT5fm/Nauo9VfLHWZCflPIDWW1LOXoXjv/A12uH/gUeb k+LcfI33E0wxohQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mana_rxq.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Ajay Sharma <sharmaajay@microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/mana/mana.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 9f70b4332238..38441be68592 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -338,7 +338,7 @@ struct mana_rxq {
 	/* MUST BE THE LAST MEMBER:
 	 * Each receive buffer has an associated mana_recv_buf_oob.
 	 */
-	struct mana_recv_buf_oob rx_oobs[];
+	struct mana_recv_buf_oob rx_oobs[] __counted_by(num_rx_buf);
 };
 
 struct mana_tx_qp {
-- 
2.34.1

