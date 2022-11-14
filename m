Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D86284EB
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiKNQTD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiKNQSo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 11:18:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9D219A
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:18:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so20096275lfv.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9d//YEd2RlGBKx5IEOJT+rFnybygx1SiLlfY4M1D5IM=;
        b=Il4nekJFAa7Mzz0i4TP51juPWhfcgflbM/H0KPnmiwn4s3KltXXT/vFsnSwNfFOUT0
         gI7bwxPmjOm9zF1ZeMkQlMYm4HVoHPUsp3qfmMHEGMODV7PrQxTrw8l4fX21EG2gL3Mt
         XgfyoEFpayT49uoAenB4Zs2Ul6GCbWLpDqEbWxhvPNDOqm2u8iaeSBOmqLHFc6KYERd4
         waxSb4s22IDq/4Vwql2PpPI4RKhT/jdPnRXIjEi6hfdxmh1kV/NBqzRxilTPrZN88A52
         uIe1mBnYjYxDOEpyhAXlj0VDEnWgYZI8Bo037kLpHcgRlb/rpMAw6WzC+EwiVNG8UYpg
         AoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9d//YEd2RlGBKx5IEOJT+rFnybygx1SiLlfY4M1D5IM=;
        b=6Pffz8OCZYe6HXstYLwOGw1Q7v/A8e9f64gqPezZEl9dC4DnqMB8lEOFy4zUQoqbcw
         rWA/GO9N6brq3sdhnSFJGxeZe/SiCSwza8gJv5AhOQenmiyUeYOmDDTqoS60uCsJcQMk
         yEFJxcFlX4V6QUlaTxo9XMislx9LfgONU+ysfuj9dlyOSH4nGvFtux7WKLcbD1TIcDxn
         yDF6+HiNPktoPknbtp/9uxzZmUT5NK6f7FVAsBZNfJEz/ca4tdcx9VWYchPDlEi5DREV
         pt8E1UCKsFcekr9tV7P5ilMxrj999XP5yKVJjUn1xgkg7T6e9wwZFddOPpau3Ejl6lBF
         7uGw==
X-Gm-Message-State: ANoB5pkn2Vuc1t6Sg6ZsZTY7DWEKgFaDCL6bVo+6qDMJK0cu9GnEYbOm
        TFA7T7FeNs/GhvMxe4+jSI9hdBhaZBKHwB0aWNSiVabRRSo=
X-Google-Smtp-Source: AA0mqf7E3/CgiRtqx/s9CAdMAs5tSvOVWKebwGUXYhprfwekgKh70LcAZRcGaOfP1RiL6KB5pzcFHQyR4QVFHclqv/U=
X-Received: by 2002:a05:6512:3a94:b0:4a2:3bbb:ad3f with SMTP id
 q20-20020a0565123a9400b004a23bbbad3fmr4265144lfu.524.1668442710710; Mon, 14
 Nov 2022 08:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-4-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-4-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 14 Nov 2022 17:18:19 +0100
Message-ID: <CAJpMwyhFo2PFMqtz1_BBdNDWyaYYPOMFj7kE0p=16uUQsvmUew@mail.gmail.com>
Subject: Re: [PATCH RFC 03/12] RDMA/rtrs-srv: Only close srv_path if it is
 just allocated
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
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

On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> RTRS creates several connections per nr_cpu_ids, it makes more sense
> to only close the path when it just allocated.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 2cc8b423bcaa..063082d29fc6 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1833,6 +1833,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>         u16 version, con_num, cid;
>         u16 recon_cnt;
>         int err = -ECONNRESET;
> +       bool alloc_path = false;
>
>         if (len < sizeof(*msg)) {
>                 pr_err("Invalid RTRS connection request\n");
> @@ -1906,6 +1907,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>                         pr_err("RTRS server session allocation failed: %d\n", err);
>                         goto reject_w_err;
>                 }
> +               alloc_path = true;
>         }
>         err = create_con(srv_path, cm_id, cid);
>         if (err) {
> @@ -1940,7 +1942,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>
>  close_and_return_err:
>         mutex_unlock(&srv->paths_mutex);
> -       close_path(srv_path);
> +       if (alloc_path)
> +               close_path(srv_path);

I think the way this is coded is, if there is a problem opening a
connection in that srv_path, then it closes that srv_path gracefully,
which results in all other connections in that path getting closed,
and the IOs being failover'ed to the other path (in case of
multipath), and then the client would trigger an auto reconnect.

@Jinpu can shed some more light, what would be the preferred course of
action if there is a failure in one connection. To keep the current
design or to avoid closing the path in case of a connection issue.

>
>         return err;
>  }
> --
> 2.31.1
>
