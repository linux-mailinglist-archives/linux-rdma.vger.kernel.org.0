Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0A7EC72D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjKOP2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKOP2F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174419D
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso10590265a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062080; x=1700666880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW7bALUgNM17QBq2CNcnNNwpzrRY3Ezp5tcU/Q9UywY=;
        b=efIk6KZyckCv46IfwFBOjwPd5rw4YGVFnhW0baWn8x29ZCSE/YTjJl40w2WWZG7ulz
         HeD39T/omyEvtCdmHQzA2l728pv1CoUhcjMlJl2hERSghzKA2h8hn9rs7cGn68GF3t67
         IPG10CfrRX7Ed+5TWYYFzDdiHE115mZ8FaIbgfTPMBmOWpcXNAMOTyxJFs6ahTu7me+X
         Rr84GdobUiYdgpX8A6MqjotiXKqwbCtLrMZn4QZBxu5zLLQ6A/6y0CjViIrntWmy2mj3
         5SqZ77nEvTcvNaMxt+CX35iNoABLeb8idIG+/v/FQudZgr3gbJIWmL4JaB50VMDWzm4E
         Cqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062080; x=1700666880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jW7bALUgNM17QBq2CNcnNNwpzrRY3Ezp5tcU/Q9UywY=;
        b=va2dMdZLOpaHyQgq1fv7dxeouw8YYNAUFuD9TMLqpnX6ylmZzdeTy9+yNSwMmioVCO
         l25gJQL88FjAzErXC2ZGIugw/pD8lGMH7Bny04ZS4sNcdnorzgLQaxr2SNDgWqmImdSj
         XXqhB01/6Esj/H1ErLDqJugKDNBbJQBD2liMhCuS+bG95cs0gr6rxs5zhCm7m+ucCdVU
         DrEGexdYfI/2kt5ygjGpEUaH/a9B7tq8dtm5TQPwkwPHyD1BepBT4G0yDLiRlsl0r8O+
         +B7W2EsbQxT1tklJQQtKJuLFGboBOu/1HocMXFzak73fnaYkWJ5nbTTUDaqzlaDfcfN/
         lbtw==
X-Gm-Message-State: AOJu0Yw9DmELtYUsbcLrKvtieo6SSsPxTfwgmp42e3COjB8dW7D3Kxrg
        9m2oUEV5IE5rKCmcgnAROjCBYHpxoCPm+D5QLls=
X-Google-Smtp-Source: AGHT+IGY3wozw7Qqci1EWIIG01Xmokcqppl1xVnIv4T8Nj+r/fYY5N5keHZf462VJ0kReqXdUhv4Ug==
X-Received: by 2002:aa7:d8d2:0:b0:53e:5957:aa4e with SMTP id k18-20020aa7d8d2000000b0053e5957aa4emr10425072eds.20.1700062080515;
        Wed, 15 Nov 2023 07:28:00 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:28:00 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 7/9] RDMA/rtrs-clt: Fix the max_send_wr setting
Date:   Wed, 15 Nov 2023 16:27:47 +0100
Message-Id: <20231115152749.424301-8-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

For each write request, we need Request, Response Memory Registration,
Local Invalidate.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 83ebd9be760e..df10d29c3fe9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1699,7 +1699,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		clt_path->s.dev_ref++;
 		max_send_wr = min_t(int, wr_limit,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
-			      clt_path->queue_depth * 3 + 1);
+			      clt_path->queue_depth * 4 + 1);
 		max_recv_wr = min_t(int, wr_limit,
 			      clt_path->queue_depth * 3 + 1);
 		max_send_sge = 2;
-- 
2.25.1

