Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310C670EDA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jan 2023 01:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjARAl6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 19:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjARAl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 19:41:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE05528A
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 16:18:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so47454657edc.3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 16:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gya7PVrxzYQCqBi0OBnhRqGl+KY0hIq+kUBvLzo1fX0=;
        b=nN2pvpyqDO5KU2fPdgT88/QnUm2Uby+ADSeMDlaJlsccRT2nIfaO4VGG39r6G8xO0D
         2UdfrXlbpOwekGh6l9lYNUOBFVIqdWVJNi5bXLuHwb+D27TdsBdous3AjUt9+1vpczbU
         IRc5OZUAlWpo3BVC4zJclJUn3thto6dRcYGKME0UcnPL/nuZWtxGWi+WKF1E4TthSd2o
         tHT9t4qzUwGJrPpqkiSy/6GQW2m6UyL9PGp/vaK7ArfFlAn1RsSLfaqSMbjXCXBwJQhB
         Rhwke5FYEBBcNeRn0ADbqQIK7TXIjYclxr4msREiGXLQOTZVwk87gE8UoLURezjr80Ed
         cl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gya7PVrxzYQCqBi0OBnhRqGl+KY0hIq+kUBvLzo1fX0=;
        b=ntg18p2Kji8Pg9WkRZeCfERFQccgGJA6YVwBxFTAQvoYZDT10khDfqoZw1pjlXLGse
         UccO7Z6P4GBSGmeURGQ4th+tz4bdjcVF4N+FSmULA8lb6B/rS0PZsAw4HyMR9U6ZrgxR
         sObOBokNxUsiqZp9mmo+mHD+CnKWpcAjWwffSY0HeeC5rVfpi9xqRTZ/X+SuRYSA4VPf
         JTLddQw/98+jf74gyzl4HwaVD2OaiBAOVkdQoyHo5KUJojhZML7oA1hoDScfrhBFjbiS
         0rtLk/XpFhi8vdz8mW5bJ/HTmUx9UwZDUHBr/BNt9WvOl/yhzBV3mHh78fQL/IQR4X7v
         /MPA==
X-Gm-Message-State: AFqh2kq1tLE0IJjrjXMKtZ6lKmyKAd9X5m4HaaejHRiQy50Imj/vDIt5
        s59G2uuilymS5rnz3l3STKpIC2o5L1L6/bH4Ivk=
X-Google-Smtp-Source: AMrXdXsWQzijN+6qiQZsOcLIt1b/Rz9WlgAjMHEmjqodkJZg2DkVce6E6a6ePZQv7SNMgxC02VcAARFgTzeSTpr5kpg=
X-Received: by 2002:aa7:d448:0:b0:481:ca34:2e41 with SMTP id
 q8-20020aa7d448000000b00481ca342e41mr433678edr.62.1674001098449; Tue, 17 Jan
 2023 16:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20230113232704.20072-1-rpearsonhpe@gmail.com> <20230113232704.20072-5-rpearsonhpe@gmail.com>
 <CAD=hENc4W7ZXCa73oOnKbspf9TeVdZ096AYwHGp-HEtoT+m86g@mail.gmail.com>
 <Y8am/zTHUWDIhBos@nvidia.com> <f7916dca-960c-a722-cd2b-d9b330092670@gmail.com>
In-Reply-To: <f7916dca-960c-a722-cd2b-d9b330092670@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 18 Jan 2023 08:18:06 +0800
Message-ID: <CAD=hENcxhH_N-4SJ-MCXXR6Da9W4gLYoOvE7_DzcK_=mv4EVGQ@mail.gmail.com>
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com,
        linux-rdma@vger.kernel.org
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

On Wed, Jan 18, 2023 at 12:45 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 1/17/23 07:47, Jason Gunthorpe wrote:
> > On Tue, Jan 17, 2023 at 09:36:02AM +0800, Zhu Yanjun wrote:
> >> On Sat, Jan 14, 2023 at 7:28 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>
> >>> Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
> >>> a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
> >>> Check length for atomic write operation.
> >>> Make iova_to_vaddr() static.
> >>>
> >>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>> ---
> >>> v3:
> >>>   Fixed bug reported by kernel test robot. Ifdef'ed out atomic 8 byte
> >>>   write if CONFIG_64BIT is not defined as orignally intended by the
> >>>   developers of the atomic write implementation.
> >>> link: https://lore.kernel.org/linux-rdma/202301131143.CmoyVcul-lkp@intel.com/
> >>>
> >>>  drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
> >>>  drivers/infiniband/sw/rxe/rxe_mr.c   | 50 ++++++++++++++++++++++++
> >>>  drivers/infiniband/sw/rxe/rxe_resp.c | 58 +++++++++++-----------------
> >>>  3 files changed, 73 insertions(+), 36 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> >>> index bcb1bbcf50df..fd70c71a9e4e 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> >>> @@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
> >>>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
> >>>  int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> >>>                         u64 compare, u64 swap_add, u64 *orig_val);
> >>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
> >>>  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> >>>                          enum rxe_mr_lookup_type type);
> >>>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> >>> index 791731be6067..1e74f5e8e10b 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >>> @@ -568,6 +568,56 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> >>>         return 0;
> >>>  }
> >>>
> >>> +/**
> >>> + * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
> >>> + * @mr: memory region
> >>> + * @iova: iova in mr
> >>> + * @addr: source of data to write
> >>> + *
> >>> + * Returns:
> >>> + *      0 on success
> >>> + *     -1 for misaligned address
> >>> + *     -2 for access errors
> >>> + *     -3 for cpu without native 64 bit support
> >>> + */
> >>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
> >>> +{
> >>> +#if defined CONFIG_64BIT
> >>
> >> IS_ENABLED is better?
> >
> > is_enabled won't work here because the code doesn't compile.
> >

drivers/infiniband/sw/rxe/rxe_net.c:

 45
 46 #if IS_ENABLED(CONFIG_IPV6)
 47 static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 48                                          struct net_device *ndev,
 49                                          struct in6_addr *saddr,
 50                                          struct in6_addr *daddr)
 51 {
 52         struct dst_entry *ndst;
 53         struct flowi6 fl6 = { { 0 } };

Zhu Yanjun

> > Jason
>
> exactly.
