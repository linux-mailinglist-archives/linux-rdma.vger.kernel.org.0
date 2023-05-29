Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39782714CBE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE2PNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2PNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 11:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC59F
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685373167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAnwAcNdkTaMG5xzQCOFsYecrSLUVjR/QAtiXocAnXc=;
        b=PR29rgKrHgqKFOYAQyqgSVjj8EqND5R5/08yjRJYjbW+6Bl8uI9oFTfq7qR191CEPk+5DF
        XsOwZCZBcwNA2C7k2vV0Z1rPmi54e209uGzeBw82IDsPKQrLTowOqn1G5NlgGviVg44IFT
        Ukb+2+900PioNwvhosKyYMmGU5/GaRw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-RY5mH9_fO42SDPvNwXsAWQ-1; Mon, 29 May 2023 11:12:46 -0400
X-MC-Unique: RY5mH9_fO42SDPvNwXsAWQ-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-786fd44f625so1823392241.0
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373165; x=1687965165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAnwAcNdkTaMG5xzQCOFsYecrSLUVjR/QAtiXocAnXc=;
        b=WFQWgZy+BbGwCMdT6++TbJeVdh0zhjw5p4PN22YkRYl9Sj5PjWgG1JWiDlFRI6DEBL
         Wz/IDcfOWCnpEwyiqOKZtnuBC1/6wmf9A3PlNbfHe13PTJw5aiXL4dkbzi0rUhQLsNzj
         vP55vnI7yWZyote4IVI/miECS/7RPGckLHiKLyHMGoiCgLvYs41CkUlwgODI7ns/VAPr
         XjPIj8ejBtTE5GZ9nnkd5nl365ACNhBPH7mcMekQ7MV9nZW1axEYfx6fd4F9X4YmBjt0
         8OcXh1n4TXW1pcgaMBgghLPKsGle671xgxgL93V5TBNn49Em534+lALrJA5lfEmNwwco
         1ZTA==
X-Gm-Message-State: AC+VfDyxwXAVA6spBta12D2d1/jCk8LmS5ei94rSz0r8I8tXLgtQyxX/
        wqzX9ewZqDyuEuVVEbOZIPi3Iilrex2/2vn2OaI5ULQH5XQG0uIGzt54sZnR8RVoFhOA2mx3twP
        xcZ2Zjq3MG+lC452jAiq2vcVyeweYqLVpd1xGqg==
X-Received: by 2002:a67:ad13:0:b0:42c:3baa:b0d4 with SMTP id t19-20020a67ad13000000b0042c3baab0d4mr3548774vsl.9.1685373165572;
        Mon, 29 May 2023 08:12:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E7Y4TRm07rpeQaAz9Wl61Ne4kwFsoeDnDrA5omtuBBJP6hmIhBw3hcwAa+XeRIdbvbVdhaLfvM2rqXN2rPm8=
X-Received: by 2002:a67:ad13:0:b0:42c:3baa:b0d4 with SMTP id
 t19-20020a67ad13000000b0042c3baab0d4mr3548743vsl.9.1685373165315; Mon, 29 May
 2023 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230523155408.48594-1-mlombard@redhat.com> <20230523182815.GA2384059@unreal>
In-Reply-To: <20230523182815.GA2384059@unreal>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Mon, 29 May 2023 17:12:33 +0200
Message-ID: <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without WQ_MEM_RECLAIM"
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

=C3=BAt 23. 5. 2023 v 20:28 odes=C3=ADlatel Leon Romanovsky <leon@kernel.or=
g> napsal:
> > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> > [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_cor=
e]
>
> And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
> needed.

Adding Sagi Grimberg to cc, he probably knows and can explain it better tha=
n me.

Maurizio

