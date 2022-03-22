Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364904E3826
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Mar 2022 05:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiCVE7r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Mar 2022 00:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiCVE7q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Mar 2022 00:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 967BC397
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 21:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647925098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QoePJSQbuVnvJh6L9HrarS4wgTWUo2BUYLqCrlMWPKo=;
        b=RG+RVcc1cGsDCiSF92AXQdr3nxH8iEx7l+0kURtj78jysNhyfsf61/S4QCDzPZBhcmQKZ4
        laJihxu7+FW9s0jMFUVhsh6ZmB+8kAn4j+uplCOP4Fe9T9UHOb5QNVE84xAN9rWxN91dY2
        983QKhtGCe0Z1QQ+BGjtCcHYQWQpOHQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-bCLFpjxfPeebZUIkI1U7nw-1; Tue, 22 Mar 2022 00:58:17 -0400
X-MC-Unique: bCLFpjxfPeebZUIkI1U7nw-1
Received: by mail-pl1-f199.google.com with SMTP id w14-20020a1709027b8e00b0015386056d2bso6580026pll.5
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 21:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoePJSQbuVnvJh6L9HrarS4wgTWUo2BUYLqCrlMWPKo=;
        b=ROSQTCjg/guQhCaucqbDjJZD9dvHTvAbhyJG/0af6P7RHqnoZVP7F5c9ncA+0rakC/
         m1a0QmjX9bT0w16jn9Jno/G9LK4q7/kqoygPbIkHY+gXPPCxbQXenuNiy7+swaZgj6oR
         Us4Z9ujKJ3IdFJUXJgc7c/eYoTC8cq3HfLJrS9LQ+ZBYay1GVOQ+xUmaZhjDv60GVri5
         VgC+xHyT6zhSsCLZtCEHSU8pJcJxfYY/S6rRAWml52ZAshs5aHM1wTcOR1CfqP/VCkzu
         n58WKXW5LmbtDzNXWQI62TYnAWU4+/hVsYGQRtwyaeMdd1av2jIilKX5dZKwEP/76bLl
         phiA==
X-Gm-Message-State: AOAM531TR4xa1Qn5ePPA7JKEtU811F5As5tF41J3RftbrRxOm1C6MyyV
        PCWp/MTDaixcWcSJXgeRMSNpt1ULoPpXCaJ0W4tqmpG7t+ueGh/708pnlRVbu3ukVVAKTn4COty
        wlH7j99pzxhI3EsocGiqI2JxkKnvk1ZXsA67LhA==
X-Received: by 2002:a05:6a00:1890:b0:4fa:a140:ffe with SMTP id x16-20020a056a00189000b004faa1400ffemr8588326pfh.33.1647925096276;
        Mon, 21 Mar 2022 21:58:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrtC54PwNRkWhxmA2w+tb8nEWGOmDTKuM0CgbxGGc8mimXEvtccWDFb7V3GEl7agC7tCAta1HdHNYfdNF9750=
X-Received: by 2002:a05:6a00:1890:b0:4fa:a140:ffe with SMTP id
 x16-20020a056a00189000b004faa1400ffemr8588322pfh.33.1647925096079; Mon, 21
 Mar 2022 21:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com> <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com> <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me> <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
 <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
In-Reply-To: <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 22 Mar 2022 12:58:04 +0800
Message-ID: <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 21, 2022 at 5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>>>> # nvme connect to target
> >>>>> # nvme reset /dev/nvme0
> >>>>> # nvme disconnect-all
> >>>>> # sleep 10
> >>>>> # echo scan > /sys/kernel/debug/kmemleak
> >>>>> # sleep 60
> >>>>> # cat /sys/kernel/debug/kmemleak
> >>>>>
> >>>> Thanks I was able to repro it with the above commands.
> >>>>
> >>>> Still not clear where is the leak is, but I do see some non-symmetric
> >>>> code in the error flows that we need to fix. Plus the keep-alive timing
> >>>> movement.
> >>>>
> >>>> It will take some time for me to debug this.
> >>>>
> >>>> Can you repro it with tcp transport as well ?
> >>>
> >>> Yes, nvme/tcp also can reproduce it, here is the log:
>
> Looks like the offending commit was 8e141f9eb803 ("block: drain file
> system I/O on del_gendisk") which moved the call-site for a reason.
>
> However rq_qos_exit() should be reentrant safe, so can you verify
> that this change eliminates the issue as well?

Yes, this change also fixed the kmemleak, thanks.

> --
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 94bf37f8e61d..6ccc02a41f25 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
>
>          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>
> +       rq_qos_exit(q);
>          blk_sync_queue(q);
>          if (queue_is_mq(q)) {
>                  blk_mq_cancel_work_sync(q);
> --
>


-- 
Best Regards,
  Yi Zhang

