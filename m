Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F597F179D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjKTPlz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTPly (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627ACCD
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso17403725e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494909; x=1701099709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ew3aX+40gHu+GBvaQN0qcsLyWwoBfaO3pa0r+TG8mM=;
        b=YLPJpFExm+nmseVZYjBdxRliak2pfIn4KGlHeBV4jXipXlpcvcNyzViQN6HuBA3CnI
         +7BcbJ6SGCQU3a5/6FoeYVBxYU0b8OpOAu//uZSP4cI2dJNOPzAhyCBW9NcOGHrdvKx+
         AI5MZhUPP2A5nhWhhu1MkzS+Gjg2ySbvCYg7JRl+Y6MMb/6jgXcLAJffQFDUtkeNBGOp
         ARJkzeLQEq6rvAeXSBXdUX6XkJRWRGx3hqOR5b1mnn/IaSAuubdzB5mOG8kPW5foWxUx
         HO0LFFrpUUcLyynbQ5nkYvdaDgp7g6ZItq4thQTKI+D4WnK3eJhdNU27YYoIpw+HY8rI
         187Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494909; x=1701099709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ew3aX+40gHu+GBvaQN0qcsLyWwoBfaO3pa0r+TG8mM=;
        b=HvMel1CGrn4XIica2D6K+J8z/UPXzABly+liT3MFDF+OQW8DpwmSSCtDiIV6dLoG7Q
         cRWBR1nEFKu1HMo2aN4ErSAQqhHdJq2gDbRchwB5LqGoR4krj9nC9Pkse3Ic3QitCyh8
         Xlfm1h8xR8YhOiHOOicGDqNEm604Vf194xLuDja9yEvYKpXu+BGQgUKU97TvFJpic9i9
         ZbgLeEGMMWANSzreMeITfmbxo9ElqUClSwFfxKPGl+5ALpt3hlAZxM6sc7emfTccaN5D
         ZK7xYOw4ePIyqNtmQToSvtgzrrCzZTEB3GWL9i24AqufEtG32GtZnhn54qtQs+LRBJJs
         oHtA==
X-Gm-Message-State: AOJu0YwfTE5uObhIUyJHKj/6J6e++Obqdg7LycUhmVYRWcQ/zDTQPB1m
        dE/qb7eGATzjTeO6+u/SW+DOnUX0FIYDveToVbc=
X-Google-Smtp-Source: AGHT+IGtwIegdW7r27EC74xNlgByNnneEYLKXUwU6jn0WlHGuZp0hZrvTiryvSAbqSv3VnrC1wvzqw==
X-Received: by 2002:a05:6000:1449:b0:331:6ad1:81f7 with SMTP id v9-20020a056000144900b003316ad181f7mr6042489wrx.2.1700494908757;
        Mon, 20 Nov 2023 07:41:48 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:48 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 0/9] Misc patches for RTRS
Date:   Mon, 20 Nov 2023 16:41:37 +0100
Message-Id: <20231120154146.920486-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
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

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

Changes in V2 for all patches:
	Add Fixes: tag

Jack Wang (4):
  RDMA/rtrs-srv: Do not unconditionally enable irq
  RDMA/rtrs-clt: Start hb after path_up
  RDMA/rtrs-clt: Fix the max_send_wr setting
  RDMA/rtrs-clt: Remove the warnings for req in_use check

Md Haris Iqbal (3):
  RDMA/rtrs-srv: Check return values while processing info request
  RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
  RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Supriti Singh (2):
  RDMA/rtrs-clt: use %pe to print errors
  RDMA/rtrs: use %pe to print errors

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 13 +++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 37 +++++++++++++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs.c     |  4 +--
 3 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.25.1

