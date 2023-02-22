Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044B69FF9D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBVXfm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjBVXfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:40 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F67474E0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:31 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id l13-20020a0568301d6d00b0068f24f576c5so1831629oti.11
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/NN8eN0d3QNDkH2Exir7qGeXHhQcj3Oq77A75Cbf/Q=;
        b=Re4bgv4v8ISbib8KdNYb3ZxCzkvmjQ2RLqenS5hRJZMvyByYfrEZDhtZeY/lM84stJ
         Kfxy6n8bRGDer9DSRl+TVgPTxVzCWXgNXjjIbQz+MhA9FtfAEkWXm4gOZMKSWHgPVblz
         +lGUkc8U7OOrRjR+I8j3lASxLChwrWRqheBl2ourJOgLA8VXhkjV5zQRxeQoboYHR+c6
         DvMVUilnVVTcx/EGU9+uNtC409o/Q+CkDTHqxXoIKWcHtlskS89VjeO2LIpRuALSIfp0
         hyHPgr03HieKmNf11OSNUwC94DiGLpcNQr35Wq52c/X3RVkz25eVRop8VTqw6AxX9wj2
         Q+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/NN8eN0d3QNDkH2Exir7qGeXHhQcj3Oq77A75Cbf/Q=;
        b=3OP8BEtjUhAGz0A2F3Sd5RgIOozPUU3V7K0vFKjGxv3sbWhC7i1ORate6u6p+ST5gJ
         nSnNGpCC1iVn7K0Hp4ZzVF/C2xvh7A14ko6AkbpXamYtdccoP8uFXWRR795qvQw1M8MA
         S0A9ytISTSXZj3vC/mdOvkkwTQNrfEhyexas2BJab5KelP4R8lEA1C7u+uhXtJoYmMyD
         GZ3SKhAK5yj9sZLAjZKKU+j2hqyNZoWS56EAk3lXHKlkujvvwxOcmsDNsm4mtffw3tVg
         DvWQNaGaZYNBqWTjn2HhcufA7r9GpezJbyL6auFen5PtjuR71SUYveqU/kt0u1ueDvpZ
         BueA==
X-Gm-Message-State: AO0yUKXzSqXB9MdacZioq+1SSecJQQ6N+k/C77EGK1id5lsgS3jAU4qt
        Zl0VOEpUD7hcgCX3ngQrRVg=
X-Google-Smtp-Source: AK7set8ZIATldAqXCPNBna8/dUuSWhE0DJmM3vUbxm/W/7H5plqb0kc6HhA6O7IikI3FgW6TwngNCg==
X-Received: by 2002:a05:6830:441e:b0:68b:c67c:5d0b with SMTP id q30-20020a056830441e00b0068bc67c5d0bmr1365118otv.10.1677108930693;
        Wed, 22 Feb 2023 15:35:30 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:29 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/9] RDMA/rxe: Remove extra rxe_get(qp) in rxe_rcv_mcast_pkt
Date:   Wed, 22 Feb 2023 17:32:33 -0600
Message-Id: <20230222233237.48940-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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

The rxe driver implements UD multicast support by cloning an incoming
request packet to give one each to the qp's that belong to the multi-
cast group. If there are N qp's in the group N-1 clones are created
and for each one a reference is taken to the ib device and a reference
is taken to the destination qp. This matches the behavior of non
multicast packets. The packet itself which already has a reference
to the ib device and the qp is given to the last qp.

Incorrectly, rxe_rcv_mcast_pkt() takes an additional qp reference
which is not needed and will prevent the qp from being destroyed
without an error timeout. This patch removes that qp reference.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 434a693cd4a5..dd42c347301c 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -241,7 +241,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 			rxe_rcv_pkt(cpkt, cskb);
 		} else {
 			pkt->qp = qp;
-			rxe_get(qp);
 			rxe_rcv_pkt(pkt, skb);
 			skb = NULL;	/* mark consumed */
 		}
-- 
2.37.2

