Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A823E53798B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 May 2022 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiE3LGC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 May 2022 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiE3LGA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 May 2022 07:06:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AC6B03F
        for <linux-rdma@vger.kernel.org>; Mon, 30 May 2022 04:05:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p4so16211386lfg.4
        for <linux-rdma@vger.kernel.org>; Mon, 30 May 2022 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EM+3IfKALlvkg3TfD+vsqfxbkYK0cUa7FrcUAMMQvHw=;
        b=LtmPAdpkr2H0qfCl4/adSz0Pq8wxiVkb8r4m5ONAC5WA4/4YKhyYEM5YYFYu5z00ei
         V7RxvLTxwgqw4y48UgaPU4R7GDNJui1gaRkfPeODS/ghMYYC32tF5TRQNCdCUGP85G/5
         wkrlE6ViReu+3jcLgxDT2FcT9ojlfQkWeY7nn2G3vRc3TH6XCEt3xJRPJvrAZbj+IUBw
         lF4edW+LMYcyaF7XwQaDRJ1auc0H10c30UBjsHBYQy7o/ZzWDgEfSQQT2ezN/InjOkzN
         fN0M9PLXkl8IATBG0Fi1iodFIhpiYOYrfoHpkgUWUyjvAAeY8PEZ4CHqSSCmDbMQ8UTq
         pT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EM+3IfKALlvkg3TfD+vsqfxbkYK0cUa7FrcUAMMQvHw=;
        b=reGOtroj2kc7K6cL/K0NSluvNMeFtqEiTtr3lu4z2soemIAMLSPSdKhLW4mfMo8jx3
         tDQG+mv9zMJa4va5s3a8lQHUqcnQwmjEPHTveMjfpaqHxIdQcsMaBJPZonHBhuS8pKDq
         7cZ2A0dfKL9Vm5wzwrFDMvOG6Epm4JtvaVZqjDwxO3NkilpDqxzV10v2xIQRcOvBhZlI
         tXlk8sFVAbt1vlGQEo7OpO9TEW4dJc/aRJEcFJfwEXbUjJcnGnKJs5QTQE0RgAJ3nSed
         PL/jTwL8kRAwbfy1zmhhEUqUrpvMRU3eBJwVLDPw7sUxOQGeAG+4kX16hR3u0AdhHtUP
         9CUQ==
X-Gm-Message-State: AOAM531Ug10WlCZW+73LA1G+Vi9iqwRFUGRdK1Ac4y99UFSRoNNNYzCW
        VwhYyaYHEL4klrqeXCm9a7am4yTuFnRz4YAnHW6w1w==
X-Google-Smtp-Source: ABdhPJwaEvOXKjYGJMYrjoL/TiJf/wm/PEILGrZXFa78Yg9+s/4nQBEApFsn4Yh5hhEW9Z8jgKcKH0szguY9Rk1OihU=
X-Received: by 2002:a05:6512:e9c:b0:478:e289:a911 with SMTP id
 bi28-20020a0565120e9c00b00478e289a911mr2168272lfb.589.1653908757254; Mon, 30
 May 2022 04:05:57 -0700 (PDT)
MIME-Version: 1.0
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 30 May 2022 13:05:46 +0200
Message-ID: <CAJpMwyjL4iWSSLh_pgWEqLT7oCLgMAFCAdZTJ0w1Rv-gkDNDFQ@mail.gmail.com>
Subject: RDME/rxe: Fast reg with local access rights and invalidation for that MR
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

I have a query. After the following patch,

https://marc.info/?l=linux-rdma&m=163163776430842&w=2

If I send a IB_WR_REG_MR wr with flag set to IB_ACCESS_LOCAL_WRITE,
rxe will set the mr->rkey to 0 (mr->lkey will be set to the key I send
in wr).

Afterwards, If I have to invalidate that mr with IB_WR_LOCAL_INV,
setting the .ex.invalidate_rkey to the key I sent previously in the
IB_WR_REG_MR wr, the invalidate would fail with the following error.

rkey (%#x) doesn't match mr->rkey
(function rxe_invalidate_mr)

Is this desired behaviour? If so, how would I go about invalidating
the above MR?

Regards
-Haris
