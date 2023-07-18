Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34BA7571EC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGRCqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGRCqd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 22:46:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF513E
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 19:46:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5217bb5ae05so3608626a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689648390; x=1692240390;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBKmIJ/3do9KUR6hkjwuycrOlcr4domB5a2gM/KTdNE=;
        b=mb0gkIj1DCK0osnZrZdTW8l4IMo7J0PCnU3+t5SSLofPjoUtjtwFgJ6KH68dTX49NK
         AfT2UiurWmXpQcAc1mJRGEglPy/oF80eYgw4aEYQmONvPZjk5t6QzVjSShG1+29nsIXx
         ZrcJc5mFV1iSTDPg+6iZ15xZvoJKY1o6OAi2xj4gcaJpGhgL0QHyHyzon31Sd3kjj14q
         JyTetBFggPYzCplDhkwY2sfzAqf+K6j+CQtskNOFj6r3xnzoKx7HeZH9ghZMOa6XwLs+
         bxt1qYHJW4EmWULRBpxsab5a0mSnFbbQzjPbGaGfJPOXj90p9liQd3EKbSPcld+6V7yF
         E2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689648390; x=1692240390;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBKmIJ/3do9KUR6hkjwuycrOlcr4domB5a2gM/KTdNE=;
        b=RxEHQ0/lDNuKCAX1e/SN6rDoan+ieAUROV1iK/4fRqfktLwUPj3v03BqNqUwAqukh1
         BY8i43+0VBzCv6iPUercro5JTlRWw4O/9YdFIEKjqW3bMii85lXL9DKmPLTgoXlhqxQF
         5lVhAVmeIEBlsT2haRO8LuzNYlaWILlJ2o6dy8A68BSj+oQqocwdbjHA7p3r/sSYEMSz
         w/eTUlwJUC6WQtHfr6tg8n6aA/VRn85CWQJQC/4YYhBj0GOOcFtoa9eQaLM/BIL4owQe
         sd8hcBu8bySSUr232ZR3CH2nEMSI8ZFhIHWgNJEsk7QDBW39zVyWhfs7zm845RY+3ys4
         hXRA==
X-Gm-Message-State: ABy/qLaVWVP49i90w90w6Xk3+BsUFDbT+chEupW3uCd1YpXIwJxdCkMR
        677eavRxGWiloC9KCuKMCC8kk19HnXBI/5y79bDojSeQAFM=
X-Google-Smtp-Source: APBJJlF9+Dyx9nMEVAGqUnb0rev9f+0B9yDjRyMae283/PAmYWTeJhXHsTCV+N75/Oa2F6ErCm6D1Z6AmsJbyycxwi4=
X-Received: by 2002:aa7:c986:0:b0:521:6d39:7e45 with SMTP id
 c6-20020aa7c986000000b005216d397e45mr8394902edt.31.1689648389863; Mon, 17 Jul
 2023 19:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPO=kN3kRV1wGvkJazRWtt1LA-QtOP2Ja3C+GtLxgMJXoxeSJw@mail.gmail.com>
In-Reply-To: <CAPO=kN3kRV1wGvkJazRWtt1LA-QtOP2Ja3C+GtLxgMJXoxeSJw@mail.gmail.com>
From:   Arka Sharma <arka.sw1988@gmail.com>
Date:   Tue, 18 Jul 2023 08:16:19 +0530
Message-ID: <CAPO=kN3DG3Ro1CFU9bEf3-ccQKW5H36pmJ767UV+ozPFdJNxog@mail.gmail.com>
Subject: Re: Check if an MR is deregistered
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I have set /sys/module/mlx5_core/parameters/debug_mask but nothing is
coming to syslog. Do I need to enable anything else ?

Regards,
Arka

On Fri, Jul 14, 2023 at 8:42=E2=80=AFPM Arka Sharma <arka.sw1988@gmail.com>=
 wrote:
>
> Hi All,
>
> I am having two dual port mlx_5 and I am on Ubuntu 22.04. My use case
> is as follows
> 1. I allocated a large buffer using posix_memalign and registered it.
> 2. From the registered buffer I carved out smaller buffers and used
> them for usual RDMA communication over RC QP.
> 3. I have 4 cq, each corresponding to 2x2 RNIC interfaces. And these
> cq's can be shared across 1,2,3,4 QPs.
> 4. The communication works fine but when I run some load, I observe
> IBV_WC_LOC_PROT_ERR after some time while processing a cq entry
> corresponding to a receive WR. The size of the cq I sent to
> ibv_create_cq is 1024 but I checked the cqe field, it is 2047.
> I checked the buffers and the lkeys and found no discrepancies there
> so I doubt if by any chance the MRs got deregistered in the RNIC.
> Normally I deregister the MR and free the buffer while tearing down
> the entire connection, but I was wondering is there any way to find if
> the MR is valid through some IB API ? I can get the affected process
> in gdb and if any data item need to be looked at in userland I could
> do that.
>
> Regards,
> Arka
