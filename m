Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F8179C48E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 06:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjILEL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Sep 2023 00:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjILELW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Sep 2023 00:11:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A76A3B5
        for <linux-rdma@vger.kernel.org>; Mon, 11 Sep 2023 18:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D5BC116A6;
        Mon, 11 Sep 2023 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694469484;
        bh=4jslLwnb4aVlaUbuasbbDrgXSdPURe68fHtS82jMkRk=;
        h=From:To:Cc:Subject:Date:From;
        b=DP3XdF5qXryxAvzUIY1oAynkT85++ELTAsYf/Xrujfe13bbU4MgrEVGYpngoq5V11
         jjK7dNJjmnlpyYBIPyWL/PxRodqlfSu9U8IC6ILdDVXGolLa99LwV3PZ7DT18Ekw1Z
         E9bvcqbaqWFFMZyhfblsw2XjepPguv38kmXDyk32VV3EHOifAsoqbhnKpSZw1SwRaz
         XydJZjKnJqcLflCZAldAXlqyJUUiFb9mwSaNH6wzBFA772cGE0b1N53jOTF4oZPaIo
         FH4KInFNmieRFjBv3rJaqJaJnca86CKJzX62e2ri61h1ahGIspNdRAVjepAIgSS/mz
         nA85EP1Yi8s6w==
From:   David Ahern <dsahern@kernel.org>
To:     linux-rdma@vger.kernel.org
Cc:     David Ahern <dsahern@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH] hfi1: Remove open coded reference to skb frag offset
Date:   Mon, 11 Sep 2023 15:57:53 -0600
Message-Id: <20230911215753.12325-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

frag offset should be obtained from skb_frag_off; update the code.

Signed-off-by: David Ahern <dsahern@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index e7d831330278..8b9cc55db59d 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -217,7 +217,7 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 		ret = sdma_txadd_page(dd,
 				      txreq,
 				      skb_frag_page(frag),
-				      frag->bv_offset,
+				      skb_frag_off(frag),
 				      skb_frag_size(frag),
 				      NULL, NULL, NULL);
 		if (unlikely(ret))
-- 
2.25.1

