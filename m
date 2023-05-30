Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1F715D26
	for <lists+linux-rdma@lfdr.de>; Tue, 30 May 2023 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjE3L03 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjE3L02 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 07:26:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1BB0
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 04:26:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30af56f5f52so354665f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685445985; x=1688037985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqdrqXNbfCgMI8+biRbceXwl0BZDruANq5DV83zV1yU=;
        b=kn28w4RqdmntYmPFf0GDvju5O92VtbOuwdPiXOWWOeBBPM69eqiK4Yhhmryf4o3iQd
         9rUlFUzKT6De40BlNv7jF5lZ6D6Byz7ibsslsuDz0HRIU6As1Sr9vl0qmZAxINgxTe7u
         CEZa3eVSymQIFi0ZyS1Mgl0A2iQbcIONhozgdR7O0TV9XCkAb/u6075uQ0JmM5EsjHLm
         3J1qRMHHwO+YuAGGpVeo82ggum0x+z2Tkq3tJtB7hwYdseRSJ2WkemCnjEJso+ymK2Mu
         qldmSwq1qYOj68hJ+6zmOCeq9WXFj1hS2nR9jx2zOK8ig7jr9tqN39r1aRun3mA+Jjfz
         BshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445985; x=1688037985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqdrqXNbfCgMI8+biRbceXwl0BZDruANq5DV83zV1yU=;
        b=aQei3+GNyobVa5u/RH4GLeqGcNJU6/vwsrG+LrAQdJHNhbzcVQ85ojJRfhplFZwZ7e
         jWLp9B9safbbbQtNHpHuHshfnmD/FqjemYmMbKFZR1R/Aqg2Kjm86cX248ApQtYV6j/L
         PzBi7PcFzIPhjibbntLzIdXFQHOUmsklH0309vU9ZHmJ1kNn4aLY/lUVJu0LSxicJD1S
         EZ6X5Ko1hnFm3mqwF4I0O76KGfpPxcb9zr6PttiBlPzA2zrQolhymtiyYN2z52f0734+
         IFur7Thld1h3wDFCkr10MoZswLPB7HRcq7003+0LH9/EJFWhzYVwyOrsFa73gpK+6KrJ
         nemQ==
X-Gm-Message-State: AC+VfDxD7aR7MWCbuNop3mrgoKfOl2xxZd2Ib5+6+4mJ28KmXy3U4fUp
        3fTWSh3B94O5ie2jNdq/1/KzPSBLGBwdqpcUZOs=
X-Google-Smtp-Source: ACHHUZ7eDbugNz+iSapUOEKg7EqbEoO7RlHyJZzKi56hB/bo3jnRPI6E7ZF8qOVOSFkh3OLDnN4MhQ==
X-Received: by 2002:adf:f647:0:b0:30a:9cb2:badd with SMTP id x7-20020adff647000000b0030a9cb2baddmr1502304wrp.46.1685445984764;
        Tue, 30 May 2023 04:26:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b003063db8f45bsm2994735wrv.23.2023.05.30.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:26:22 -0700 (PDT)
Date:   Tue, 30 May 2023 14:26:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Simulate missing IPsec TX limits hardware
 functionality
Message-ID: <3987af55-0068-4a06-acea-c281a59e273a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Leon Romanovsky,

The patch b2f7b01d36a9: "net/mlx5e: Simulate missing IPsec TX limits
hardware functionality" from Mar 30, 2023, leads to the following
Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:68 mlx5e_ipsec_handle_tx_limit()
	warn: sleeping in atomic context

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
    57 static void mlx5e_ipsec_handle_tx_limit(struct work_struct *_work)
    58 {
    59         struct mlx5e_ipsec_dwork *dwork =
    60                 container_of(_work, struct mlx5e_ipsec_dwork, dwork.work);
    61         struct mlx5e_ipsec_sa_entry *sa_entry = dwork->sa_entry;
    62         struct xfrm_state *x = sa_entry->x;
    63 
    64         spin_lock(&x->lock);

Holding a spinlock.

    65         xfrm_state_check_expire(x);
    66         if (x->km.state == XFRM_STATE_EXPIRED) {
    67                 sa_entry->attrs.drop = true;
--> 68                 mlx5e_accel_ipsec_fs_modify(sa_entry);

This function call will do some GFP_KERNEL allocations so it sleeps.

    69         }
    70         spin_unlock(&x->lock);
    71 
    72         if (sa_entry->attrs.drop)
    73                 return;
    74 
    75         queue_delayed_work(sa_entry->ipsec->wq, &dwork->dwork,
    76                            MLX5_IPSEC_RESCHED);
    77 }

regards,
dan carpenter
