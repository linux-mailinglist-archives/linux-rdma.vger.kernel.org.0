Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3BA6E8CA9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Apr 2023 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjDTIYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Apr 2023 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjDTIYh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Apr 2023 04:24:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC23592
        for <linux-rdma@vger.kernel.org>; Thu, 20 Apr 2023 01:24:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id eo4-20020a05600c82c400b003f05a99a841so700271wmb.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Apr 2023 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681979053; x=1684571053;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56VMIikki71Goe7HCg/RB1n3KoyHL9HAQOknx9Jd1ao=;
        b=icObyWo/jtRcEX6G2FXP55BTg7uD3go+oZT9mYBcGEm0fTW6e84x7bTV0QINASSwZp
         OooEQ4H0665KB8CDfV/syesC/6ZNsqZxnu1kkXL1RK42+xdBytrK581OXlyQY5d6dsyh
         8zmqQoQONWe+KHEdYMZykyH/zCnp8/VWshZrYI7seA62g0gJBEEwKlOWap186fNDmcCK
         7N4Nro0Rs9v96frFi7tB6whfCXwkaB1b6HLFmOMASJtcbFk+dO2s4FPXprL357Upej8W
         eodydgnWyJ5GQnyjyVGTRxheW1XSh8zmRgCnB3+dK/LImEyTsKtn/ZtLQYnevLPRCVdv
         zHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681979053; x=1684571053;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56VMIikki71Goe7HCg/RB1n3KoyHL9HAQOknx9Jd1ao=;
        b=THXWrBqtAHwRJqXiCGIC900W6TfaibmLp14GsK4vduiQKCkW+jYzC9MRDEWGY+1kKj
         bV3zOb1AhJe+gQRYl8PSfAqh/gEJZ3N9i6hEkfujokvz+0KMvkW5dLJsNY74tsfQSMdT
         YTfzTaFTtyg2h7aOlK3KfaQdInNQyAZYjrk8jOlTja6j//3BcyiJavH5E3T974zhZbR3
         mrMqi0q0gzYK54HH0JdQ6CHQI26TW7A0Pp9qUkRtSpuXHmfQh5vCi9Uhxi45/lX3wyZW
         pldFjxC9ecKjwtqMPdDwliVoyJ34UxCNCFrnuclH2t5ALKwB5FP1ISsu6qgmxUSWAKW7
         D9Fg==
X-Gm-Message-State: AAQBX9c5MvRaSjXr8do4Db5IROPgwtAgyuh4zmm+/26VX0R2X88kfJHh
        +fXS9hlIDIq9LAShgctyL+R8Kg==
X-Google-Smtp-Source: AKy350agfFhar2shHK3SIW0iD9WlYsJGjHLGLZu/hrqt5lm+hmwMD/2pQzP+p9hasjcXDxwEy/dqow==
X-Received: by 2002:a05:600c:3658:b0:3f0:3368:5f7f with SMTP id y24-20020a05600c365800b003f033685f7fmr551304wmq.31.1681979053397;
        Thu, 20 Apr 2023 01:24:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003f17b96793dsm4574397wmk.37.2023.04.20.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:24:12 -0700 (PDT)
Date:   Thu, 20 Apr 2023 11:24:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Generalize IPsec work structs
Message-ID: <9ef32c2b-8e07-486b-af8d-9d332d5426ab@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Leon Romanovsky,

This is a semi-automatic email about new static checker warnings.

The patch 4562116f8a56: "net/mlx5e: Generalize IPsec work structs"
from Mar 30, 2023, leads to the following Smatch complaint:

    drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:755 mlx5e_xfrm_free_state()
    error: we previously assumed 'sa_entry->work' could be null (see line 746)

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
   745	
   746		if (sa_entry->work)
                    ^^^^^^^^^^^^^^

   747			cancel_work_sync(&sa_entry->work->work);
   748	
   749		if (sa_entry->dwork)
                    ^^^^^^^^^^^^^^^
These checks can be deleted, right?

   750			cancel_delayed_work_sync(&sa_entry->dwork->dwork);
   751	
   752		mlx5e_accel_ipsec_fs_del_rule(sa_entry);
   753		mlx5_ipsec_free_sa_ctx(sa_entry);
   754		kfree(sa_entry->dwork);
   755		kfree(sa_entry->work->data);
                      ^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

   756		kfree(sa_entry->work);
   757	sa_entry_free:

regards,
dan carpenter
