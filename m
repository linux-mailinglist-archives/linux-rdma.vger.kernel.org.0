Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9B6063F1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJTPOJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJTPN7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 11:13:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACF70E61
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 08:13:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sc25so154487ejc.12
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5y9spvLNFinyF7NYlx3aS8AE/WU1r8r1oXTRxhQFQ=;
        b=PdO9UyQnwijQXbc8OO3irsgTV0m5ZyJLhQFTarY4xdE6FEIcrhiIOoizWamo7DgqVV
         F6unN/3C8CyJCHGnc9mcQHXxaAg4ZJrgo6MwW79GQAcsU22Q/U+T/N+79qEUy3w5Ix0T
         Mzb8IDbMqra+hRSrzEJub36xWBj+8xgjRm5Jg7+C/ah/+JnNRDupJVTHjvkSESC7V1Yv
         2bnxUDlqUdVmMNFhz8KlP5wfpp04AW5d1Ye+FJXzcAw4ZofMoiRU3w09nuLjVtO1we8H
         /qy8UmdoANJsyriXWveuEw2PsfRXkqLSelTo7F1EPJdYXa5MGRb7JAEyOKyhjHs7PE3M
         DsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w5y9spvLNFinyF7NYlx3aS8AE/WU1r8r1oXTRxhQFQ=;
        b=j6bYjfgIA8EhGho0fG3i1RG2EvQEZfnsiUqb9aKWSBwfGpOLdprNAuM6WFUDobx0MZ
         9ddKLuC/XEvaCEj4V0Z6sDC+eN3pW9lCstOU1wbXEB/gFWQmL07o7BFpqI8/sESvRptJ
         PsJt86Foifyln4n3BbRxTl9SAKAgmbMym4dGu4IaGOA6WbCai9Uj+3Elii1W1MI1bZhz
         Ceigm2/iaB1qb6snqsXpnBg2ozLsJaUhNK5Y5fb+W6Xo++MQhGP3G9Hko9uWC8tYFLYU
         FnTyQ+QZ2ULTc8iCJ5swx4AOUhWhMXoO3hY9GeRGsXYqx8P9HnuUbj3PDXYcQ4QaXX6S
         C+0w==
X-Gm-Message-State: ACrzQf2PfKFrtPQigO/mM+q4VC65nKVlKeOozfUFpL+HK0VFgsl7HuCB
        98J7mNvjiVxWvEW9wWgBr6q1sv1J5B6i7ER1t3A=
X-Google-Smtp-Source: AMsMyM7b8iUi+DvEomO0ROqxGWkIS/jFSBlb2bMFzcRpPMTa3kzXuHm2Yns3m7v4wbph++ylSxZ2OQ==
X-Received: by 2002:a17:907:daa:b0:78d:9bc9:7d7a with SMTP id go42-20020a1709070daa00b0078d9bc97d7amr11254533ejc.567.1666278836956;
        Thu, 20 Oct 2022 08:13:56 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id kw8-20020a170907770800b007821f4bc328sm10641216ejc.178.2022.10.20.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:13:56 -0700 (PDT)
From:   Md Haris Iqbal <haris.phnx@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Md Haris Iqbal <haris.phnx@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: rxe_get_av always receives ahp hence no put is needed
Date:   Thu, 20 Oct 2022 17:13:45 +0200
Message-Id: <20221020151345.412731-1-haris.phnx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The function rxe_get_av is only used by rxe_requester, and the ahp double
pointer is always sent. Hence there is no need to do the check.
rxe_requester also always performs the put for ah, hence that is also not
needed.

Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 3b05314ca739..0780ffcf24a6 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -130,11 +130,7 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
 			rxe_put(ah);
 			return NULL;
 		}
-
-		if (ahp)
-			*ahp = ah;
-		else
-			rxe_put(ah);
+		*ahp = ah;
 
 		return &ah->av;
 	}
-- 
2.25.1

