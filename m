Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A067F17A2
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjKTPl7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjKTPl5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502E9F
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40842752c6eso17350075e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494912; x=1701099712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k631je87x0ywnHSe3oqxeCpwviu14/Fn3Uc7rjWzxlY=;
        b=IfQDf9kBZrxnyUALKdQ+aL6BFTxdfwJXeUBXPzICYoJnBmi/MhNvObrZdQIVmyysoj
         NFwnG95uKEgZ2ui/2JDCaDn+MLs/E8Dg5/+8Ozg5auzWBqCKl/JB4pknVujdoE8fm5jT
         zvNtxd9xUMGp9zo8Ih/A1XrOMThrzyj8dTx8HuW8Q9TKq6H/lb9SHvOG3vXylS4guJCH
         jgbTmfes3MSqbkFLNEPlPG00oSGayOgc2Asl4/CSlC9WahbjNHGP5TSISF0Fmr7HDm4Y
         I3ELG8rWityXFwi11cIG2k3EK6y4gsUNb2CJe6rzYmqG6LuiRal3mhspH8NwuTN8gglq
         bOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494912; x=1701099712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k631je87x0ywnHSe3oqxeCpwviu14/Fn3Uc7rjWzxlY=;
        b=js4q8+EoYAVYSmbZB+C5sL6geDH7YoPtiLUUv/cFMnfoLjAmqgaVJonnuPLQd/j8Y/
         yBjNBuAx+SJyd18xlk6Eyo0eA0ZmFwWDRfqAi9nLuNyTCNgq+LB7AUktBeo8ows7t3QV
         8LDBdjtZujMLR6CqnDCVQY7WTkOsLoz8jakbhGkBFUSHrRTgnzOu3KBzAudQVv67wW7G
         1ANYG4OgY+xqIpPaA1IfbZQODxBFKqDry+PQndQdGDa77OzMSsojNa7qq2H0imw1iVdO
         iBQTKTKr1IeOfD9Pmi4bEvQCKy1umFxvQ/XS+CTSyWU9UYVELfm4XpzTkNktdU+Fetsv
         5oyw==
X-Gm-Message-State: AOJu0YwhhAFFBbNOOfYPwfkufyDjTuIZ7J4ZXJfmG83YwDOUH/oTpyWq
        9cG/o5k+6ZDTImVQ9ZjDMS6sSH/FyUL/SLkf1bc=
X-Google-Smtp-Source: AGHT+IEW+vhh457LEMUsasUI091vwtshAu2xdsQKt8fLn3rxX4vqOia2R2CoL9lutrozloU5i/ZIAg==
X-Received: by 2002:a5d:498f:0:b0:32f:7901:c462 with SMTP id r15-20020a5d498f000000b0032f7901c462mr4860850wrq.3.1700494912378;
        Mon, 20 Nov 2023 07:41:52 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:52 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 5/9] RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight
Date:   Mon, 20 Nov 2023 16:41:42 +0100
Message-Id: <20231120154146.920486-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120154146.920486-1-haris.iqbal@ionos.com>
References: <20231120154146.920486-1-haris.iqbal@ionos.com>
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

Destroying path files may lead to the freeing of rdma_stats. This creates
the following race.

An IO is in-flight, or has just passed the session state check in
process_read/process_write. The close_work gets triggered and the function
rtrs_srv_close_work() starts and does destroy path which frees the
rdma_stats. After this the function process_read/process_write resumes and
tries to update the stats through the function rtrs_srv_update_rdma_stats

This commit solves the problem by moving the destroy path function to a
later point. This point makes sure any inflights are completed. This is
done by qp drain, and waiting for all in-flights through ops_id.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 925b71481c62..1d33efb8fb03 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1532,7 +1532,6 @@ static void rtrs_srv_close_work(struct work_struct *work)
 
 	srv_path = container_of(work, typeof(*srv_path), close_work);
 
-	rtrs_srv_destroy_path_files(srv_path);
 	rtrs_srv_stop_hb(srv_path);
 
 	for (i = 0; i < srv_path->s.con_num; i++) {
@@ -1552,6 +1551,8 @@ static void rtrs_srv_close_work(struct work_struct *work)
 	/* Wait for all completion */
 	wait_for_completion(&srv_path->complete_done);
 
+	rtrs_srv_destroy_path_files(srv_path);
+
 	/* Notify upper layer if we are the last path */
 	rtrs_srv_path_down(srv_path);
 
-- 
2.25.1

