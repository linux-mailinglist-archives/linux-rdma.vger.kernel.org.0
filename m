Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F27175D67
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCBOjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 09:39:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39339 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCBOjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 09:39:44 -0500
Received: by mail-io1-f67.google.com with SMTP id h3so11739076ioj.6
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5K5V10b3zmzbHGxJ8mvxWaKndtERoQvtnRDMNpTBGA=;
        b=Kw0yDXjSHy8q2H5TZkLpNs+ZS2bsFqtcR0hXiyeDBPyWEtupfWGV25c6Us68B9e8x7
         Xut0YgXwMREznB0rwuY5+xJsokXReM9k/GHHgACt+lLC+LJBBHGyN986cOpbDOd8k1zg
         8erERBGk7UzPrFSzMhe8YOXp8wsCOqtzFTPltFEaLMy0uDmlRvsyuYcDwtywS8A+Gd49
         hl3KBOgnjBkZCL2e8cOe/VfdwmMDiKhr87/Bd29RHElEY9UUroL19laVYkfqWdcpH2PX
         sjAwgk9w5shZJ4xt33e6n47yeUGee+P3tUBZBJDpvtgcyq/MA4w1RS4xP1drSRVOebQX
         qMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5K5V10b3zmzbHGxJ8mvxWaKndtERoQvtnRDMNpTBGA=;
        b=tLn4Q2V+kLMUy2jbIR+H0eOEDw2yJkQHfWHhuWta/2C1j3C4t8N9Hrv8cAOSsbm9uS
         GqP/Y7TfwGiVS7RZfFBBZmJBaCOa4WraDb/mNveKVqfaB8MzkpLYG70PwnySu102rvvf
         jedyE2xzt8MS+LmQ6hV7CYht2GNzOL5J2tINq66l4jYuVXGterV7hoIqygtIj3qhyA42
         FetBNG3iKXMNOCbuU8hOvhzty0HjBVMLdFPnKRbbz1ulBUEMKWov4YnLiEUV2eDGnCoe
         0x825u1VjuV1nlGbxsei4S7n61MtNGefJMIERtJjSquj/DuZYUoIcPoQWnCG1eQguBgK
         qlFw==
X-Gm-Message-State: APjAAAWVaKefxMPwfQ4/FZsO4+uqk85lK1TyFStGn6HV1wd+00nOnEEF
        1RQdiXqvgg4juSmMbGLHg9Gnpt/xFVPeJ7Vf749IaQ==
X-Google-Smtp-Source: APXvYqzPDwXk3WCzABHMvcgaPJJsWbrYSGIkg/3K/TRZsETJirhY4Lm7x3RDLsfTvFSiFlzA2avzIfjEv7sHBiZYmVw=
X-Received: by 2002:a6b:fc0b:: with SMTP id r11mr5949276ioh.298.1583159984321;
 Mon, 02 Mar 2020 06:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-11-jinpuwang@gmail.com>
 <c97843fa-84c4-ff7e-3b72-af3b916c059a@acm.org>
In-Reply-To: <c97843fa-84c4-ff7e-3b72-af3b916c059a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:39:33 +0100
Message-ID: <CAMGffEncP5NaQtHwQPO1WRKEvTrEmJXX6_UHA1R0++qgu-Nu=A@mail.gmail.com>
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 2:42 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
> > +{
> > +     struct rtrs_srv_sess *sess;
> > +     int err = -ENOTCONN;
> > +
> > +     mutex_lock(&srv->paths_mutex);
> > +     list_for_each_entry(sess, &srv->paths_list, s.entry) {
> > +             if (sess->state != RTRS_SRV_CONNECTED)
> > +                     continue;
> > +             memcpy(sessname, sess->s.sessname,
> > +                    min_t(size_t, sizeof(sess->s.sessname), len));
> > +             err = 0;
> > +             break;
> > +     }
> > +     mutex_unlock(&srv->paths_mutex);
> > +
> > +     return err;
> > +}
> > +EXPORT_SYMBOL(rtrs_srv_get_sess_name);
>
> Please make sure that the returned string is '\0'-terminated, e.g. by
> using strlcpy().
Ok.
>
> > +static int rtrs_rdma_do_accept(struct rtrs_srv_sess *sess,
> > +                            struct rdma_cm_id *cm_id)
> > +{
> > +     struct rtrs_srv *srv = sess->srv;
> > +     struct rtrs_msg_conn_rsp msg;
> > +     struct rdma_conn_param param;
> > +     int err;
> > +
> > +     param = (struct rdma_conn_param) {
> > +     .rnr_retry_count = 7,
> > +     .private_data = &msg,
> > +     .private_data_len = sizeof(msg),
> > +     };
> > +
> > +     msg = (struct rtrs_msg_conn_rsp) {
> > +     .magic = cpu_to_le16(RTRS_MAGIC),
> > +     .version = cpu_to_le16(RTRS_PROTO_VER),
> > +     .queue_depth = cpu_to_le16(srv->queue_depth),
> > +     .max_io_size = cpu_to_le32(max_chunk_size - MAX_HDR_SIZE),
> > +     .max_hdr_size = cpu_to_le32(MAX_HDR_SIZE),
> > +     };
> > +
> > +     if (always_invalidate)
> > +             msg.flags = cpu_to_le32(RTRS_MSG_NEW_RKEY_F);
> > +
> > +     err = rdma_accept(cm_id, &param);
> > +     if (err)
> > +             pr_err("rdma_accept(), err: %d\n", err);
> > +
> > +     return err;
> > +}
>
> Please indent the members in the structure assignments.
ok.
>
> > +static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
> > +{
> > +     struct rtrs_msg_conn_rsp msg;
> > +     int err;
> > +
> > +     msg = (struct rtrs_msg_conn_rsp) {
> > +     .magic = cpu_to_le16(RTRS_MAGIC),
> > +     .version = cpu_to_le16(RTRS_PROTO_VER),
> > +     .errno = cpu_to_le16(errno),
> > +     };
> > +
> > +     err = rdma_reject(cm_id, &msg, sizeof(msg));
> > +     if (err)
> > +             pr_err("rdma_reject(), err: %d\n", err);
> > +
> > +     /* Bounce errno back */
> > +     return errno;
> > +}
>
> Same comment for this function.
Ok, thanks Bart
>
> Thanks,
>
> Bart.
