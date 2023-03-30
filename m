Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27C56D112E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjC3VyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjC3VyF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 17:54:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23C10432
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 14:54:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j7so25377428ybg.4
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680213243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qFO8zqE1HD8ZXV4jIepLq36y3r9xuBKp48xFA1dRYA=;
        b=WKllgSHyne2OJsJPzoD+dXHsfEaQ4/LcJSD1xWOhYI1iBSdA+VU486N/3RUcu77c7j
         oHCPmdGHfqwxboW8Flz/0GxJ81zuw3eE/YHvroA0vqNvU02WUd6+wKDsYK546UNKdCRT
         UmteKpXatVHUOhPI1kR55VOcseHR+TpVLnbVLsS0iHIyzMj+6odLDsslsgra6SaBs3cX
         p0+Pv5VozGTCHgJKd4+jtgVdsgF476+6EkubYHMSEbV07o921mxb89uiE5NSOts3Dvp/
         1qqfWIDHXQh8yayll2VyOLcFLE6+eE1voYALOZzTuNyWHPzeQLYLfWr5wwiE18JWG31u
         QMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qFO8zqE1HD8ZXV4jIepLq36y3r9xuBKp48xFA1dRYA=;
        b=a/xccWSI5uW4Fhdxu9KpmMBOjs0vxBU9aLkA6m4wtTGFcUMhc6Z65Vt0Mo0yVsBVKC
         aKpAniNB7OCxiHVZgPe4HK2872v+nFCNpnkaHR819a8pSpJbomW+PBoNN0/fqnjqKDDf
         7H4p/8h1qh75IdaHKcaDezUnr0FNaNEZxpga46Y8/ClV13sb8vaHlccnlvb4JrRMH2/O
         aDTeT1xuIKlKfMXzAxumBdRC3zqlLAIoy9cdieI2mzpVMqePYr+psBh5BXlHS4ix2t9o
         R7avNcZ2UH9KOyXzCsB2x4uEn+8lM4LlMvWSUyLwDc48Tyoh898PlLlDwjZacMW9Z28h
         hZHw==
X-Gm-Message-State: AAQBX9enlj2f8NvFHOp6N8uqh3GKHzKE9lLvl7jwQRQaeKuCAEssC/F4
        bL2qaK9gtUu1qQQoWGxo7dkHxBH1XTxxC4B29Icm3A==
X-Google-Smtp-Source: AKy350YCcoZrk7hxqelLIR/cPBtZzXLYC7RtKiv34scraa77Z6qt77Dpkef0q92RdQZAPMlPrNUvg3vsmzQKi29KdOk=
X-Received: by 2002:a05:6902:120c:b0:b74:77fa:581d with SMTP id
 s12-20020a056902120c00b00b7477fa581dmr13323999ybu.4.1680213243518; Thu, 30
 Mar 2023 14:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com> <202303310254.tmWyQaZG-lkp@intel.com>
In-Reply-To: <202303310254.tmWyQaZG-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Mar 2023 23:53:52 +0200
Message-ID: <CACRpkdYpob6Si2ghXHqSD=6f_PO_gPbJhE_u4jNEcu1VbxO4pQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Add ib_virt_dma_to_page()
To:     kernel test robot <lkp@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 9:02=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:

> 0d1b756acf60da Linus Walleij   2022-09-02  536                           =
       /*
> 0d1b756acf60da Linus Walleij   2022-09-02  537                           =
        * Cast to an uintptr_t to preserve all 64 bits
> 0d1b756acf60da Linus Walleij   2022-09-02  538                           =
        * in sge->laddr.
> 0d1b756acf60da Linus Walleij   2022-09-02  539                           =
        */
> a10308d393288b Jason Gunthorpe 2023-03-30  540                           =
       u64 va =3D (uintptr_t)(sge->laddr + sge_off);

Oh now that becomes an u64

> b9be6f18cf9ed0 Bernard Metzler 2019-06-20  541
> a10308d393288b Jason Gunthorpe 2023-03-30  542                           =
       page_array[seg] =3D ib_virt_dma_to_page(va);
> b9be6f18cf9ed0 Bernard Metzler 2019-06-20  543                           =
       if (do_crc)
> b9be6f18cf9ed0 Bernard Metzler 2019-06-20  544                           =
               crypto_shash_update(
> b9be6f18cf9ed0 Bernard Metzler 2019-06-20  545                           =
                       c_tx->mpa_crc_hd,
> 0d1b756acf60da Linus Walleij   2022-09-02 @546                           =
                       (void *)va,

Then this cast needs to be (void *)(uintptr_t) again.

Not very elegant, possibly something more smooth can be done.

Yours,
Linus Walleij
