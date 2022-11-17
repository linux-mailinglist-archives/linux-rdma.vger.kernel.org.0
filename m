Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6131E62D307
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 06:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiKQF4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 00:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiKQF4P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 00:56:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D8466C85
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 21:56:11 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t10so1450477ljj.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 21:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ukCy+XhWjfZVFkJNU5Mv+aeFn25klEeXrnYqSOasMc=;
        b=Is5g/Re5LoaWrd85CVtGGtsO867C0qruxkhk9XBqGUkl3WZuNvX3TX6MdHZM8s/QmK
         Rbj55K8uKbuyFP6auOZ4LgMDVyaFVkHOBy2NIE05I5SvzRVGsRsPtcze9iHh3QPDmHfq
         bDsAMVy9XDU7KmnAx+uhwREUMiNSoegzzKG/9qfeCyYShbtYfd9gLe7+9ftr05dSL2bl
         0/h3/sLGgjQhPWg2yjmsZExv2LoFPLy+d9PHyvxTbrLPMIF4XLQnugG9ZQ3Y079Xxhae
         QoXiSxeKdaSTCRTXzkMSsCGvqoM/bg2K/e9DIDm2dOWobcH1QT+rmhCbxvw03/cSxRCp
         TZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ukCy+XhWjfZVFkJNU5Mv+aeFn25klEeXrnYqSOasMc=;
        b=zF6FiftWVJ1juH2GDAmlMfRhjE4P0uMp+lABpL5sKyPDzToxrse6k0qC0PQ7k4HVga
         5QxkrtGxS+lUd6lsEnVfniyywIjY34+OWz+i0/g4Xs+d3hp2Z3ACsbbCw4BYYuXrITmg
         JgXu2kQatnPmBVt9w8zstZ12qkE+rzcnTCzJIw9pIiAOVoLicjeLd+oHl0TdHzsSnWS2
         G8hqVhKU2n0DtlebPeP7/Bof0n2//oa8JrzfV5+30leS21VztAKS0D18YmlUmhdMOLsg
         RoAcqNt/hl5lgrkrQwFNZoUkIJMeqGBME7uXvp+hwIkK8e4gOMNp4hQ10r+EUOPlUO1+
         eX+g==
X-Gm-Message-State: ANoB5plM74mqwFrMSW5NvjlQqzr0XTKbIuFGbrmfaxUhtXF5v2xZEnNk
        qe+ZwdYHSY15nvZ2SO8VxwZhBC9p/CDj8MjvIxMb5Q==
X-Google-Smtp-Source: AA0mqf7fJ2VdrFOTHiSOuWpxP9rTvcgnBiQ2X23a9OdgETHfRFRhZKrjLzrSAzHOXqimNTLqGt6SBngScbLVSSVEoWc=
X-Received: by 2002:a05:651c:c8f:b0:26d:d196:d04 with SMTP id
 bz15-20020a05651c0c8f00b0026dd1960d04mr494632ljb.403.1668664570224; Wed, 16
 Nov 2022 21:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20221116111400.7203-1-guoqing.jiang@linux.dev> <20221116111400.7203-4-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-4-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 17 Nov 2022 06:55:59 +0100
Message-ID: <CAMGffEnSWffmPVzMkKx02s30-odEmqGPeUc2YYapAxAP+T21FQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 12:14 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> We should check with nr_sgt, also the only successful case is that
> all sg elements are mapped, so make it explict.
typo, s/explicit/explicitly.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index b877dd57b6b9..581c850e71d6 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -622,7 +622,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
>                 }
>                 nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
>                                   NULL, max_chunk_size);
> -               if (nr < 0 || nr < sgt->nents) {
> +               if (nr != nr_sgt) {
>                         err = nr < 0 ? nr : -EINVAL;
>                         goto dereg_mr;
>                 }
> --
> 2.31.1
>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
