Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39B65865D4
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiHAHsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHAHsI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 03:48:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE32CC99;
        Mon,  1 Aug 2022 00:48:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 130so2043397pfv.13;
        Mon, 01 Aug 2022 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMAYnU2EC+yqL1BUsnDtAht/Xj2YzS3sDG0zRP+tgoc=;
        b=ZCrFnl1/FKhMP2ChqtWUi4kLbjkrbbHxyaawhvgyc09rH8IXJ3XPFUeKkQNE7z4NT2
         YKtaDVqIgMnGxrFryUiTfiHndkOfd555EeBICDQEJrrLqMoGf6kqS0pp9t2N63pzuztJ
         2+85btwJlgKijZSBhfUww9vRycoEE4USDm9beI9R48BtMFo7KvWuPpMEHO882AIWklMd
         oc9KuvQpVr9s/QKBMQdaFO5jqHtQFtoXQc/tgSRv+k8kCtZghE2TE+DnblBcxs9rvF4T
         S1SmjNKI+d8sHSatamq4uuW+02e7yQ7sTX4coqVy1n+BXiELvxNkvY0WxnHvZR8En2OW
         3CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMAYnU2EC+yqL1BUsnDtAht/Xj2YzS3sDG0zRP+tgoc=;
        b=SosUesnqzQA21KCP6o5tTgxQWEPgYTwujy/ccx8YB2GpcbOfL6p3iaOo5D5QQ6V79O
         oPGKi6YVCJqROpCJyyn9j8SO5HaughK4UvTJyAu0nb4gvEM1/AB+tNHmgk10gTgkrqVD
         5hv6bmSbN0bgwK//eTZTC02hT56n/IerC/boTtuBXwd8A6XuMjbkEmpwojJXnaMS+p2O
         UvwJlHCUnz+ZiBEaotj55iaIUB5RmQ1ImqudSCzBpp6CdepQoRnR9mQpb1SwFwAwR3EH
         YxWnzkqlc4UpfNrchyOt54QEYqplUB3xYo3W0YNTnPxNcV7JD+TqbuiJ1AyOX9GyJcH8
         Uw1Q==
X-Gm-Message-State: AJIora/c0m51x4zc0cVvIS16XT3n5pevRFSJHIoQouLtKvODsBP1EKJ6
        66ijAT6Xn10G5bOI5WEYLcw3ZWK5U1ha12nTBQ0=
X-Google-Smtp-Source: AGRyM1vIjd6ogUzsZFjIlziUmE8zsnxUjq3jxREUPypb96difwUuV4PC6474WlweKI/Q1FB/KYbSm/RRNtNIjR6EfdY=
X-Received: by 2002:a05:6a00:17aa:b0:52a:e94b:67e5 with SMTP id
 s42-20020a056a0017aa00b0052ae94b67e5mr15280735pfg.76.1659340087358; Mon, 01
 Aug 2022 00:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENfqCKs3jk7pUNJq0Urqx1ZCSU2KpDcipgz_ORJs_43C=g@mail.gmail.com> <b47219be-b6e0-9a18-5d84-5546c08d721e@fujitsu.com>
In-Reply-To: <b47219be-b6e0-9a18-5d84-5546c08d721e@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 1 Aug 2022 15:47:55 +0800
Message-ID: <CAD=hENfZN43c4ZBmXwdru61=341bZgfYa8VJeKaBQYF5KKFA2A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/RXE: Add send_common_ack() helper
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Aug 1, 2022 at 3:28 PM lizhijian@fujitsu.com
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 01/08/2022 15:11, Zhu Yanjun wrote:
> > On Mon, Aug 1, 2022 at 2:16 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
> >> Most code in send_ack() and send_atomic_ack() are duplicate, move them
> >> to a new helper send_common_ack().
> >>
> >> In newer IBA SPEC, some opcodes require acknowledge with a zero-length read
> >> response, with this new helper, we can easily implement it later.
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe_resp.c | 43 ++++++++++++++----------------------
> >>   1 file changed, 17 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> index b36ec5c4d5e0..4c398fa220fa 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> @@ -1028,50 +1028,41 @@ static enum resp_states do_complete(struct rxe_qp *qp,
> >>                  return RESPST_CLEANUP;
> >>   }
> >>
> >> -static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
> >> +
> >> +static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
> > The function is better with rxe_send_common_ack?
> I'm not clear the exact rule about the naming prefix. if it has, please let me know :)
>
> IMHO, if a function is either a public API(export function) or a callback to a upper layer,  it's a good idea to a fixed prefix.
> Instead, if they are just static, no prefix is not too bad.

When debug, a rxe_ prefix can help us filter the functions whatever
the function static or public.

>
> BTW, current RXE are mixing the two rules, it should be another standalone patch to do the cleanup if needed.

Yes. Please make this standalone patch to complete this.

Thanks and Regards,
Zhu Yanjun

>
> Thanks
> Zhijian
>
>
> > So when debug, rxe_ prefix can help us.
> >
> >> +                                 int opcode, const char *msg)
> >>   {
> >> -       int err = 0;
> >> +       int err;
> >>          struct rxe_pkt_info ack_pkt;
> >>          struct sk_buff *skb;
> >>
> >> -       skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
> >> -                                0, psn, syndrome);
> >> -       if (!skb) {
> >> -               err = -ENOMEM;
> >> -               goto err1;
> >> -       }
> >> +       skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
> >> +       if (!skb)
> >> +               return -ENOMEM;
> >>
> >>          err = rxe_xmit_packet(qp, &ack_pkt, skb);
> >>          if (err)
> >> -               pr_err_ratelimited("Failed sending ack\n");
> >> +               pr_err_ratelimited("Failed sending %s\n", msg);
> >>
> >> -err1:
> >>          return err;
> >>   }
> >>
> >> -static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
> >> +static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
> > rxe_send_ack
> >
> >>   {
> >> -       int err = 0;
> >> -       struct rxe_pkt_info ack_pkt;
> >> -       struct sk_buff *skb;
> >> -
> >> -       skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE,
> >> -                                0, psn, syndrome);
> >> -       if (!skb) {
> >> -               err = -ENOMEM;
> >> -               goto out;
> >> -       }
> >> +       return send_common_ack(qp, syndrome, psn,
> >> +                       IB_OPCODE_RC_ACKNOWLEDGE, "ACK");
> >> +}
> >>
> >> -       err = rxe_xmit_packet(qp, &ack_pkt, skb);
> >> -       if (err)
> >> -               pr_err_ratelimited("Failed sending atomic ack\n");
> >> +static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
> > rxe_send_atomic_ack
> >
> > Thanks and Regards,
> > Zhu Yanjun
> >> +{
> >> +       int ret = send_common_ack(qp, syndrome, psn,
> >> +                       IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, "ATOMIC ACK");
> >>
> >>          /* have to clear this since it is used to trigger
> >>           * long read replies
> >>           */
> >>          qp->resp.res = NULL;
> >> -out:
> >> -       return err;
> >> +       return ret;
> >>   }
> >>
> >>   static enum resp_states acknowledge(struct rxe_qp *qp,
> >> --
> >> 1.8.3.1
> >>
