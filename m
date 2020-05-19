Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2E1D9AB5
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgESPHO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESPHO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 11:07:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83CEC08C5C0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 08:07:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u188so4036620wmu.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uChn9bc8OyccYuwS7mq8h6Pb7roUPV7UxFXt3BT13ds=;
        b=QN2mWHCgbOSygwtQQGP0shFkGpLdefSeP5q1P0+GELEqR6IovkQhkRGcvueyDb5fUA
         NDqMsuaFl0XfZPkut+sTKPbifI4ixrp6qUyUhS66S1BUPciyI4hs7ED17rV4DrvPa2K+
         +mL6nUrJr+OprA5DqowF1DIZabJ95aFYaWnaBOoEH3v8ihh2d0gen9qlKzuicBIx0F7l
         4qZjO6Ay0VrqccRS3g00O43D8ugKxjFLXCzMHtG6LCXRUBVTa8JWze0m0ZAQBz1CtvZR
         Hq95yDFLA+dwx2qzCksVwNLcCyBxPSqH8RniGwIW4DeoqXu9551oc332NxXn7vKJX+iF
         b5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uChn9bc8OyccYuwS7mq8h6Pb7roUPV7UxFXt3BT13ds=;
        b=ZazFBrpazVYTOfujbk3BKCRHtHZj9q/6Cf4tmky4e0c+8VxJwZKJf1+Tzs6Y9X//zJ
         G+bFV3iWp0cGd5nqLzR84ajxnHEUXmOvYHfjGj+VEFyrxlvnbrcqjLi8ffYUTgEQmSnF
         JEIgLiO79yp+t4RAYa3YYgBSyAaEOmFamaYUT4T8kBfwbtnJJHgmdpiv/YFmiQj6tpBq
         Hblwj7zqqv9z0P9dMTce2wlAjXOEeUHp6b1mJ7AO+XbV9asQa3lzjx0k73Mxo95IicKc
         gD21p2wZ/ysxlRtxZVWbujjownOUxbtAWBUUzicThGNW4M02t6XZz/UTni3pHD8k7pmr
         qxEA==
X-Gm-Message-State: AOAM530Th/YBgUMtyZvdQfCAg+aCxw9mCvnMV+makCdV83rmaWmzwBkW
        PeDCnJsbEYw9OPir24JIIeO+g1L/TxAl0h0mx+pJkhg=
X-Google-Smtp-Source: ABdhPJzQX7gKyxNfSchN3csQpLh+10C4SSfaqteekd9ABNbAcuBNmW6ogTIS3mJ+We+yY/vmRmrmZDAIQB8ZbJ43RA4=
X-Received: by 2002:a1c:5402:: with SMTP id i2mr6348786wmb.185.1589900831579;
 Tue, 19 May 2020 08:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200519120209.GA42765@mwanda>
In-Reply-To: <20200519120209.GA42765@mwanda>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 19 May 2020 17:07:00 +0200
Message-ID: <CAHg0Huz39q9nWwTrtCY=SgU=T9oZJQdchx6c1LOPbSQiywzrqw@mail.gmail.com>
Subject: Re: [bug report] RDMA/rtrs: server: main functionality
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dan,

On Tue, May 19, 2020 at 2:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Jack Wang,
>
> The patch 9cb837480424: "RDMA/rtrs: server: main functionality" from
> May 11, 2020, leads to the following static checker warning:
>
>         drivers/infiniband/ulp/rtrs/rtrs-srv.c:1224 rtrs_srv_rdma_done()
>         warn: array off by one? 'sess->mrs[msg_id]'
>
> drivers/infiniband/ulp/rtrs/rtrs-srv.c
>   1207                  }
>   1208                  rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
>   1209                                 &imm_type, &imm_payload);
>   1210                  if (likely(imm_type == RTRS_IO_REQ_IMM)) {
>   1211                          u32 msg_id, off;
>   1212                          void *data;
>   1213
>   1214                          msg_id = imm_payload >> sess->mem_bits;
>   1215                          off = imm_payload & ((1 << sess->mem_bits) - 1);
>   1216                          if (unlikely(msg_id > srv->queue_depth ||
>                                                     ^
> This should definitely be >=
Definitely, thank you.

>
>   1217                                       off > max_chunk_size)) {
>                                                  ^
> My only question is should "off" be >=.  I feel like probably it should
> but I'm not sure.
Here also, yes.

>
>   1218                                  rtrs_err(s, "Wrong msg_id %u, off %u\n",
>   1219                                            msg_id, off);
>   1220                                  close_sess(sess);
>   1221                                  return;
>   1222                          }
>   1223                          if (always_invalidate) {
>   1224                                  struct rtrs_srv_mr *mr = &sess->mrs[msg_id];
>                                                                  ^^^^^^^^^^^^^^^^^^
>   1225
>   1226                                  mr->msg_off = off;
>   1227                                  mr->msg_id = msg_id;
>   1228                                  err = rtrs_srv_inv_rkey(con, mr);
>   1229                                  if (unlikely(err)) {
>   1230                                          rtrs_err(s, "rtrs_post_recv(), err: %d\n",
>   1231                                                    err);
>   1232                                          close_sess(sess);
>   1233                                          break;
>   1234                                  }
>   1235                          } else {
>   1236                                  data = page_address(srv->chunks[msg_id]) + off;
>   1237                                  process_io_req(con, data, msg_id, off);
>   1238                          }
>   1239                  } else if (imm_type == RTRS_HB_MSG_IMM) {
>   1240                          WARN_ON(con->c.cid);
>   1241                          rtrs_send_hb_ack(&sess->s);
>   1242                  } else if (imm_type == RTRS_HB_ACK_IMM) {
>
> regards,
> dan carpenter
