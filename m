Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2431F5F1BDE
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Oct 2022 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJAKvB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Oct 2022 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJAKvA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Oct 2022 06:51:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED7D5B;
        Sat,  1 Oct 2022 03:50:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gf8so3723789pjb.5;
        Sat, 01 Oct 2022 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=902zAy6Vn6wh4uiLUnvbwF2NvhM+4Dk+0jWQAGP5110=;
        b=GeJYvI8SjMylNFlGT6aW3bAHhTuabf/LT8iyU66IEjxGux+cDbxHhXhIS2kVT6NYeh
         /Quxr3v3/sG1JBIN2/Ssm/03o7XaJzXBbcSvbLqPtJrhrRUbXXv0nLU8k9Ru0UQPmBsS
         dbmO50FTZV6Sih1ju6DEMgkWYstzoeStvgjreRgRXfa1RurTk+OFLy9ouWt3ig478CgR
         oxwgtq6yv56W33hrPBv1SqDGIOzxYXfABN6VHFc1qRFevrFlxwr/GDZY4vvY0SvDMWmU
         JGs3unyjKn4xz67yatisGk5GpbzMPkD7lKwIqbAYz3R5tE0HMoS94pd9WtmGnLZsTfB1
         f/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=902zAy6Vn6wh4uiLUnvbwF2NvhM+4Dk+0jWQAGP5110=;
        b=2q0koZE8f0Nzw7ZqD10zkG9bXh9j0o6IveIZMeYuEVCoWroLel/zbSoc+83cFRiYut
         gB+QQLbh3O5rMsi0/E5FIKSDrSU+nQ25vfLuZ0LqO6aRFMBfzQracelkSSbh7xTnUC5K
         t1MlA0qjqu7QI2DGuMqRzO3vWrbpCLFoYHRWE3OmIE6MAT3J9UaWt7gt0fQZU1pn3oUf
         U+B5YvDNbo2baAWHo74VWKbUjLBH0VarZcENJ4vU8tdI1sRp4/WSQfIAG0Spg0JoZyNR
         F6hnT/Jt0BdaK3A/7nWjyrVIxaSkXoep7QddvI4BWsmP/SsUNFmFtKlI+lG2QZSrNg7h
         W3Ng==
X-Gm-Message-State: ACrzQf06+v0OTDlp/KfQ6eHrI8Blw5EmXM1ltfeFs57eotufhSG3oyCe
        nMDi2mxY7ZApA12OdBO7+8WtAahu/ZAOd7j9a3U=
X-Google-Smtp-Source: AMsMyM5syCGrkuxycNAvt40JdD4s/zHSLiZSh3m8QlilysmJk1114r/wKlV+1sycEk5/6iGX7V5+2FfptbpbAst/fyU=
X-Received: by 2002:a17:902:da8a:b0:17b:df43:9235 with SMTP id
 j10-20020a170902da8a00b0017bdf439235mr9749353plx.137.1664621458490; Sat, 01
 Oct 2022 03:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221001020045.8324-1-lizhijian@fujitsu.com>
In-Reply-To: <20221001020045.8324-1-lizhijian@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 1 Oct 2022 18:50:47 +0800
Message-ID: <CAD=hENegJLuWZUvCVk66MFUE_m64PbqY7+mG2jZz3+Wyu4i6+w@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA: return -EOPNOSUPP for ODP unsupported device
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 1, 2022 at 10:00 AM Li Zhijian <lizhijian@fujitsu.com> wrote:
>
> ib_reg_mr(3) which is used to register a MR with specific access flags
> for specific HCA will set errno when something go wrong.
> So, here we should return the specific -EOPNOTSUPP when the being
> requested ODP access flag is unspported by the HCA(such as RXE).
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Thanks.
Zhu Yanjun
> ---
>  include/rdma/ib_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 975d6e9efbcb..a1f4d53a4bb6 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4334,7 +4334,7 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
>
>         if (flags & IB_ACCESS_ON_DEMAND &&
>             !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
> -               return -EINVAL;
> +               return -EOPNOTSUPP;
>         return 0;
>  }
>
> --
> 2.31.1
>
