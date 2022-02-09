Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C24AF8FB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 19:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiBISG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 13:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiBISG0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 13:06:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760ECC0613C9
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 10:06:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id e7so5606920ejn.13
        for <linux-rdma@vger.kernel.org>; Wed, 09 Feb 2022 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXgyg0xdy5ObnqB0XucGRteJF82d9E73y4J013V6ZCk=;
        b=cUCLiA/NYo9qbHzECeF7x5uJ9245J5MCSkgeIUmAujACc1BiO5gXNN3yPCzBZgWORe
         2czDeJvQF+o5sUM0EdPBQMamqo7zC8RjFNIGlYBoyqIaa9rUV2k4LuH7+MJUIHtLsv0f
         0kaWEQrT0IClsdYgsmV/e6unCod1dPGsAB8/6g/lON3w3AQCMnDFClA9gDnKXlAV472V
         Ml6nyQdMrKhkqNtaGqlWYxDMury7XejdUvhuvWn8zLIh17Qx5uVinNFHHAcdIZHZyEo3
         R7BmhvfYMTj3OX9B9OQpKCuNxfYA4cvdBV1upe8VCpr3jPIbdZWbuf0cCTyEVxHm9S8Q
         /saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXgyg0xdy5ObnqB0XucGRteJF82d9E73y4J013V6ZCk=;
        b=lSSVwaf10LW6URjsaaFeJOU2v1XT2L/KYLEOapOeLh06G7owa3ln5JftCHKPsGPvpC
         aGfVNdR6AGFXqEgwPwHV3mZuJaqwWI9bwXME2v7mslc39HfExlU65vTe2X/cqpTONKd/
         yH4PmZ1Ih+m/YIQYirXcVw/csMNtOIXbc1zylXt6qeEEiereBaLaPUxNTezOOCW5VvVP
         LJe65L0PLT3ZWaSwq/HF7lcNW/CG12qnme8fRw3Z47luu1OHbFhiui5gsUaTGSWEdrPQ
         WJ0/oA9ASwI3g1h88F4fiJsr9DHfbsgR7BUFzrpd8+UGqLQJXdCAZiRioMwxJff3d96Z
         o0/w==
X-Gm-Message-State: AOAM532DrQ5oarPOjinEjcFSnsPN/joR6+/H1x9NqJVBvtjpii5mujgJ
        YPDk5/0d+xjebhqzRIlTBAErXLBUwriJamrm7lbLPg==
X-Google-Smtp-Source: ABdhPJyE7w9ENdv/ngF5G6KP2vgnHiinVzkpc8EREcML1VOtLgNuGEfrUWJFPFXYUSzgI56yVy70yfE6PeAoWW5V7RQ=
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr3076668ejd.443.1644429987897;
 Wed, 09 Feb 2022 10:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20220209151425.142448-1-haris.iqbal@ionos.com> <20220209151425.142448-2-haris.iqbal@ionos.com>
In-Reply-To: <20220209151425.142448-2-haris.iqbal@ionos.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 9 Feb 2022 19:06:17 +0100
Message-ID: <CAMGffEkDHdW2=+F3WUCOOmWcS98rzQQHj3dNGBuSG-WnuoYBGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA/rtrs-clt: Move free_permit from free_clt to rtrs_clt_close
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jgg@ziepe.ca
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

On Wed, Feb 9, 2022 at 4:14 PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> Error path of rtrs_clt_open calls free_clt, where free_permit is called.
> This is wrong since error path of rtrs_clt_open does not need to call
> free_permit.
>
> Also, moving free_permits call to rtrs_clt_close, makes it more aligned
> with the call to alloc_permit in rtrs_clt_open.
>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index d20bad345eff..c2c860d0c56e 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2774,7 +2774,6 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>
>  static void free_clt(struct rtrs_clt_sess *clt)
>  {
> -       free_permits(clt);
>         free_percpu(clt->pcpu_path);
>
>         /*
> @@ -2896,6 +2895,7 @@ void rtrs_clt_close(struct rtrs_clt_sess *clt)
>                 rtrs_clt_destroy_path_files(clt_path, NULL);
>                 kobject_put(&clt_path->kobj);
>         }
> +       free_permits(clt);
>         free_clt(clt);
>  }
>  EXPORT_SYMBOL(rtrs_clt_close);
> --
> 2.25.1
>
