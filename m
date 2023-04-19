Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E966E7787
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjDSKiN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjDSKhu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 06:37:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801517EE4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 03:37:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b16so5091816ejz.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681900663; x=1684492663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4OEHWAdjGNyouDp7WPzL5oQVIukKAIyvltvLfA8gEY=;
        b=D6Qxt3+Ivw863ySttSPj+hFVUT9Cotn/d1Z7ORCCbcBT5k7XgTCfttOtrF6WaynYcP
         zB3I2NYIpB/kTmDA0JN6aD6gSRfR7s8P1KCHU+3wCnR/dZ2rXboQBfSrOhtxKjkP9uYb
         U6Hmxn0HEiMXvGcwHiaawbnIv5fG+rz8ngwUIiLoq0jksJhEVrBXYmlYT0AVfpu2zjU+
         G73xvefT3L0/PQg3YaXUokKsx/FenLz8S9YWvb9M9SFWpZ0CTuJhvBAlx/JK1N1mP4YK
         nLuC2/h5GVkJRIKIZr6q+dq32risIClRD91yLMIYBs17YnFkqtF3hTacjaCV7aOx1Rq+
         oAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900663; x=1684492663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4OEHWAdjGNyouDp7WPzL5oQVIukKAIyvltvLfA8gEY=;
        b=ALeuiNMqWLGnc6tKudkS8fr5mj2JRt+oxpNkJBvpZoLL2+KNImEfDMABw+CaIEOE4s
         tNcA5ihontWPXFzJBAvIrcWFAVf60WrhfbmRjp77fU2wLxGU9Qw0HaUXb81Nwv7k9V+F
         +VBkxqXDQmoIU3047si7rI+JFG3bL5uDZDEfTU6lrEpEDh/ZPHMdNkkTua+kgsh/jTjR
         i/mq0LCRqgFGGQcJIHq6kNp9cycqDGW83T1MbetEVD6KN5xGewCfYgaEQ/qa1NxFE2y7
         WIrZiR7gibs6iVVN9Gtb9Z3OMeflS4EKr8hgzOzLTPT8IBvcQZjupJ7VrUsCXo91uKoc
         zQoA==
X-Gm-Message-State: AAQBX9ewPqgjHWTmQe9nN1Dz8WKU4w9ormwrwrmgOm2zaWAHgXvzHcvH
        7fZFTIlyjc9YJpToGHwulah+6TNz4KcdC94brsCNDg==
X-Google-Smtp-Source: AKy350bYIrvKBCApif+4KoIefqjSX8vwQ2VXrM3H4vDFyxzXVqeS39bQt64k12BEO1RDANZBIDIFGExdO5GIBAhML+4=
X-Received: by 2002:a17:906:3844:b0:93b:1ca6:6adc with SMTP id
 w4-20020a170906384400b0093b1ca66adcmr6904385ejc.7.1681900662939; Wed, 19 Apr
 2023 03:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com> <1681108984-2-2-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1681108984-2-2-git-send-email-lizhijian@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 12:37:31 +0200
Message-ID: <CAMGffEngGE=X3VYYcOg=mHhW+O71JUhwonrvY6YuugnxeoGeRg@mail.gmail.com>
Subject: Re: [PATCH for-next 1/3] RDMA/rtrs: Remove duplicate cq_num assignment
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 8:43=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> line 1701 and 1713 are duplicate:
> > 1701         cq_num =3D max_send_wr + max_recv_wr;
>  1702         /* alloc iu to recv new rkey reply when server reports flag=
s set */
>  1703         if (clt_path->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid =3D=
=3D 0) {
>  1704                 con->rsp_ius =3D rtrs_iu_alloc(cq_num, sizeof(*rsp)=
,
>  1705                                               GFP_KERNEL,
>  1706                                               clt_path->s.dev->ib_d=
ev,
>  1707                                               DMA_FROM_DEVICE,
>  1708                                               rtrs_clt_rdma_done);
>  1709                 if (!con->rsp_ius)
>  1710                         return -ENOMEM;
>  1711                 con->queue_num =3D cq_num;
>  1712         }
> > 1713         cq_num =3D max_send_wr + max_recv_wr;
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index 80abf45a197a..c2065fc33a56 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1710,7 +1710,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *co=
n)
>                         return -ENOMEM;
>                 con->queue_num =3D cq_num;
>         }
> -       cq_num =3D max_send_wr + max_recv_wr;
>         cq_vector =3D con->cpu % clt_path->s.dev->ib_dev->num_comp_vector=
s;
>         if (con->c.cid >=3D clt_path->s.irq_con_num)
>                 err =3D rtrs_cq_qp_create(&clt_path->s, &con->c, max_send=
_sge,
> --
> 2.29.2
>
