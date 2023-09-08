Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DAC79868C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 13:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbjIHLoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjIHLoP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 07:44:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619781BE7
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 04:44:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4108a8f0de7so12492231cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 Sep 2023 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694173450; x=1694778250; darn=vger.kernel.org;
        h=user-agent:subject:references:in-reply-to:message-id:date
         :mime-version:content-disposition:content-transfer-encoding:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uKNx90XjYfeEnPfUnAQi04NJvPlLW/5xflta7l24tg=;
        b=ESZbVORg5rSssbL0SYn2qBKeOn76xzusc21Ob8/Jyq2KkA7Sa4OdHh2vXB5jNzwum0
         uXCMpGDaemoQrBAyHpmDj5zy8OimPdzPZcAHcozTV3UeG5l6GGqPXp8wBtcYUDnshjL2
         7CF2qMtFadBI6yyGQedmhaZw1yGhuTLUjCWkkt2EODNnwDNilrq3jIoOrEHFlgoCy8J8
         n9y0skvoyVEUi4h//J7SZmThmGymZ0RujJAGBybS3Rh5QSeRqhiqyOEgNSKeph8GZhJs
         ju5J3qtLYuV36VGUahspqbpxGEbCFugifmR4jQNAzO7f/tJtdbo8bF/d5kJ5WyNUFlzO
         3TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694173450; x=1694778250;
        h=user-agent:subject:references:in-reply-to:message-id:date
         :mime-version:content-disposition:content-transfer-encoding:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uKNx90XjYfeEnPfUnAQi04NJvPlLW/5xflta7l24tg=;
        b=FtShH1CXY+u9w0VmZP0y5s6t0Us42VlhRo20WIqW08TpkLx0PFkhJw1rl76hG6I4uH
         djoS7ZcwrW2xHWyWiAZJzV3DwhWV94k9Zyj8XWv5yrmOSJWtnJ3Qa4tOP3JginIN4n1y
         Ono2HFqLUVKvqatKIP2Eqo3NH8ye3GWaRO/woUqAhyBV7a/G2tS0SfYj3Wgf+zwJbeKX
         PgsRPMi7x5GPACi0K9VyICyDoz/KnYG1kabAJh0bCv7Ufs319BSQay9Xlgx0tkLl3DQ4
         AGZ0AvQ1hU+GLVfN4hexn1UCS0L0p7HTJZgaMyZpWGFouF/fdicM96P96bLRwzRHGLUh
         G1RA==
X-Gm-Message-State: AOJu0YzGfS+yOxC9fzAE8aVUaBMya/rkxN7zZ9W8XlnnvAGLk/zmGzxc
        ee0UpH+/zxt21iExRlgsMk3R+Ao9Frs=
X-Google-Smtp-Source: AGHT+IHuExdsS1zuLMuOgS87SGExwjebnprnrKlDwBWn8HhL0WIBdg5qtcfBMtGPg2yue5E0Rzv8zQ==
X-Received: by 2002:a05:622a:8d:b0:410:9626:f0c2 with SMTP id o13-20020a05622a008d00b004109626f0c2mr2748826qtw.11.1694173449880;
        Fri, 08 Sep 2023 04:44:09 -0700 (PDT)
Received: from MDEIGNAN.BLIDOMAIN.braintreelabs.com ([134.88.228.254])
        by smtp.gmail.com with ESMTPSA id u8-20020ac858c8000000b00403ff38d855sm558273qta.4.2023.09.08.04.44.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 04:44:09 -0700 (PDT)
From:   "Michael P. Deignan" <michael.p.deignan@gmail.com>
X-Google-Original-From: "Michael P. Deignan" <Michael.P.Deignan@gmail.com>
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
MIME-Version: 1.0
Date:   Fri, 8 Sep 2023 07:39:09 -0400
Message-ID: <1UemTrupdT.IdMQk9Gt7h3@mdeignan.blidomain.braintreelabs.com>
In-Reply-To: <1UemSoI5JF.EPU4Dkh77Fx@mdeignan.blidomain.braintreelabs.com>
References: <1UemSoI5JF.EPU4Dkh77Fx@mdeignan.blidomain.braintreelabs.com>
Subject: Re: Question on libibverbs "problem"
User-Agent: OEClassic/4.2 (Win11.22621; P; 2023-07-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I have a user who is running an mpi model using mvapich2, compiled with the=
 Intel OneAPI compiler (2023.1.0) on a Rocky 8.6 OpenHPC cluster. Bear with=
 me for a minute as I lay the foundation to get to rdma-core.

Periodically (randomly after X minutes, where X has been as few as 5 and as=
 much as 30) the model will crash and in the error log there will be thousa=
nds of messages:

[mv2_mcast_resend_window] Failed to post mcast send errno:0

Basically this message repeats until the disk fills up and the job terminat=
es with an out of disk space message.

I tracked the error to the mvapich2 source code at src/mpid/ch3/channels/co=
mmon/include/ibv_mcast.h:


    int ret;                                                    \=20
    ret =3D ibv_post_send(_mcast_ctx->ud_ctx->qp,                 \
                &(_v->desc.u.sr), &(_v->desc.y.bad_sr));        \
    if (ret) {                                                  \
        PRINT_ERROR("Failed to post mcast send errno:%d\n",     \
                                errno);                         \
    }                                                           \
    _mcast_ctx->ud_ctx->send_wqes_avail--;                      \
    while (_mcast_ctx->ud_ctx->send_wqes_avail <=3D 0) {          \
        MPIDI_CH3I_Progress(FALSE, NULL);                       \
    }                     =20

which leads me here, to the rdma-core group, as the ibv_post_send subroutin=
e is in include/infiniband/verbs.h:



/**=20
* ibv_post_send - Post a list of work requests to a send queue.
*
* If IBV_SEND_INLINE flag is set, the data buffers can be reused
* immediately after the call returns.
*/
static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
                                struct ibv_send_wr **bad_wr)
{
        return qp->context->ops.post_send(qp, wr, bad_wr);
}

For some reason, this function call (ibv_post_send) is returning zero back =
to the caller, and no error code is being set (errno =3D 0).

As the model does run for a random amount of time, this would seem to sugge=
st some type of hardware problem, but everything we've checked (system, ib =
card, ib switch, etc.,) doesn't show any errors.

Can anyone shed some light on under what circumstances a call to ibv_post_s=
end would, in fact, return zero when previously it didn't?

I realize I'm probably not giving much data to really help.. I suppose ther=
e could be some type of underlying operating system issue but even there I'=
m not sure how I would determine where the problem is, since everything els=
e is running fine (and it appears only this one model seems to cause this p=
roblem) with nothing abnormal in the event logs. I tried running the model =
on an older Rocks Centos 7.x cluster and likewise received the same error.
=20
Having some basic understanding of what would cause the post send call to r=
eturn zero and not set an error code might help.
