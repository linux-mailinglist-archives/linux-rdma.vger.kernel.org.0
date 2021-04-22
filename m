Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200F8367E35
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhDVJ7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhDVJ7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 05:59:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C99C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 02:58:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x19so40835496lfa.2
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ug6pVBebcUZyNinZLsa61c6mjptJniJq6pOyDh6JJN4=;
        b=eAHua8CnytaMW/Ws+k6b9zcIZ3JEt04p1KNIFLIdt3VzFC9wBNWJ9m/rixgNLbFiIL
         eXspJWYUHRMc5Qj7Zz8R/+Berk1AIp7cIXVmOV+lzPZNdMUa3jkU1I87Lz2iayy2vD9x
         YuSJHVi8c26YFpQ1G5UD21CjdwD/OM2mqQo7FFooSompo4vliAy4b4ZDaGT0yRVX7i/l
         DuON+4E0UI9ZdsS/v8dUpgtrH0gYZE2S08Ljw0xgX6qBNFlIlKjnaUmopiY9sycJEedN
         Pq420AP0iW3/pQkCU82h8DsNOVzBw9vHBkDtTXa0OjWZj5js+NlT89ZIZfTGPDzKzdEJ
         l88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ug6pVBebcUZyNinZLsa61c6mjptJniJq6pOyDh6JJN4=;
        b=uK7TSNSCcaVhD6jTHn29WMvi9ApRpZSvW+BFY0bWGsnnWp35Kemy5YVEMDU8oGq4ZJ
         OGM47iNCIZRXor2ornGTy2pCozbznWty11sLZFahyOcmjNLtNtXhFA4dV0mIHEz2Znvi
         Wmz4ywqMxidFJswOWVLyEyX+3NIxYFKMF8ADLcbfo/JGz6Xwbfi+YJ2KsBATWuvfBPsz
         54uVdA4YRu4XtHMN4m1ghS7fxtbjHP2lu86REK+zyupQs1GNpxApY1heCJE+o3ep96zu
         yK914heqiPbwoJmyweyefO6MjnOLRDiCnI/tMIRUwX5EN8VccTuCR7yItKIlaLtRNuhD
         kcvQ==
X-Gm-Message-State: AOAM532YMPirIy1M/iEJ2mVV/LbDvDSkukpn0UMRRv/QLcTAZrXNZPEG
        TaoquQXGXB/NTUHD/45iCJYYEgGHvOZqjhv1zuk=
X-Google-Smtp-Source: ABdhPJz/ZeVxJ0u376kgZfwWip45T9/hQCnvu+ru0LXJzF8LW3mFAs05ch1GcpAtNW4s8CwV9QBS7B+NtomLVjWOvPY=
X-Received: by 2002:a05:6512:159:: with SMTP id m25mr2006008lfo.73.1619085537942;
 Thu, 22 Apr 2021 02:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <YH/rabHwkA8UgzH1@mwanda>
In-Reply-To: <YH/rabHwkA8UgzH1@mwanda>
From:   Jack Wang <xjtuwjp@gmail.com>
Date:   Thu, 22 Apr 2021 11:58:46 +0200
Message-ID: <CAD+HZHXuq7RRGkdDA0xTDRztZpbe=VLSC+hGty26Zhd_SY+hfg@mail.gmail.com>
Subject: Re: [bug report] block/rnbd-clt: Support polling mode for IO latency optimization
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Gi-Oh Kim <gi-oh.kim@cloud.ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:09=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hello Gioh Kim,
>
> The patch fa607fcb87f6: "block/rnbd-clt: Support polling mode for IO
> latency optimization" from Apr 19, 2021, leads to the following
> static checker warning:
>
>         drivers/infiniband/ulp/rtrs/rtrs-clt.c:2998 rtrs_clt_rdma_cq_dire=
ct()
>         error: uninitialized symbol 'cnt'.
>
> drivers/infiniband/ulp/rtrs/rtrs-clt.c
>   2977  int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int in=
dex)
>   2978  {
>   2979          int cnt;
>
> What about if no sessions are connected?
This indeed a bug, will fix it soon. cnt should be init to 0.
>
>   2980          struct rtrs_con *con;
>   2981          struct rtrs_clt_sess *sess;
>   2982          struct path_it it;
>   2983
>   2984          rcu_read_lock();
>   2985          for (path_it_init(&it, clt);
>   2986               (sess =3D it.next_path(&it)) && it.i < it.clt->paths=
_num; it.i++) {
>   2987                  if (READ_ONCE(sess->state) !=3D RTRS_CLT_CONNECTE=
D)
>   2988                          continue;
>   2989
>   2990                  con =3D sess->s.con[index + 1];
>   2991                  cnt =3D ib_process_cq_direct(con->cq, -1);
>   2992                  if (cnt)
>   2993                          break;
>
> I don't know any of this code but I would have expect use to add up
> cnt for the whole loop...  Something like:
>
>                         ret =3D ib_process_cq_direct(con->cq, -1);
ib_process_cq_direct does not return negative value AFAIK.
The idea is as we give -1 which means ib_process_cq_direct will poll
all pending cq.
when it returns positive value, we are done.
>                         if (ret < 0)
>                                 break;
>                         cnt +=3D ret;
>
>   2994          }
>   2995          path_it_deinit(&it);
>   2996          rcu_read_unlock();
>   2997
>   2998          return cnt;
>
>                 if (ret < 0)
>                         return ret;
>
>                 return cnt;
>
>   2999  }
>
> regards,
> dan carpenter
Thanks for the reporting.

Regards!
