Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E6A674CFB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 07:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjATGEj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 01:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjATGEi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 01:04:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466FF49940
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 22:04:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so11395587ejc.4
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 22:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJRvfq0hBo4SnTLFyMlvstj2NsS2P74yEUKCR962NpM=;
        b=IK/c9NC0/euguefJS33dB3PZebO4VVlYlkdaRUdyel6CcHjRZwGHlnQ6Uk5g0lsT6P
         335/p2nBykWa4mpAXvd/NtBKaGgQ0yDCAoeKnq2+reW1zMU6xtfUuJw5ESVFJ590HL5j
         kanfs6mTFyeyRftr/lZSRUsDoVLyq6X95GSdeJOrQSKivzMFtDBUfsTotScBjlCdq1LR
         uNQIkQGbCFBxoWzcyumfCR1pB9hP2b78XxMOT+oj/f6MYIbdDdd0d40jUx6kk5YI/gaE
         EgNgUAHdDZi9nRxvPgKGJJVXxbjakeSst+Zos4rK28VWI8FMTTaTbennDAX4v4plTcAi
         1vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJRvfq0hBo4SnTLFyMlvstj2NsS2P74yEUKCR962NpM=;
        b=6BFgbRG7GbGzWcST0HcApkrMhInraKNNOIqQT98yH89i/bkpIoeXCP3jKSceiRyJkQ
         vili7BXC9jEGFFokVmH4ifNwCP5qk1kotkf7nQf9MX3NNTKO7UdGUaXzwi8lao/p8MHE
         47H4vD0usDvDMZ3BAbL0Ri3HAByWxxHfqUvi+PJ6U6tepv1NvxbnemlqGnVyeCIvd52l
         zCNWlgF5O+is8McfzdYN0zxfYp0Vq+b5PFoZTPI0GbuhNWjTd14ZryNteMGuu8ArPOvU
         wwE5fFI5jkfYpc3C7D1WXrjCPEWiG1JWc8TMG7i6AzLe5QlqSJfIeVV2ILBwfiAB7kAs
         vlOg==
X-Gm-Message-State: AFqh2kqwrnXV/ajbzkXPoLlCmtFZymE4jmxkBxayQqnJDRwWg4i6Xgbv
        /bYylHiE147oGzb/K8xVlH3gxqrc2+My8rOxzJI=
X-Google-Smtp-Source: AMrXdXvkm9a7Py5nZILDjatw+euJkFPCDZ1T1TutJBNmoZX0cilVLVLIEkNvIhOwrXnLArYm5DO6wwwwej1hbG0y2ss=
X-Received: by 2002:a17:906:99c6:b0:863:f322:70df with SMTP id
 s6-20020a17090699c600b00863f32270dfmr1668503ejn.549.1674194674609; Thu, 19
 Jan 2023 22:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20230119190653.6363-1-rpearsonhpe@gmail.com> <CAD=hENcdkWchRrvH+KXLXZoaQcZPpnCdV9V9T9mmzkJ13DJKUA@mail.gmail.com>
 <20809b59-0d7f-b6b0-e51c-026a78f07a86@gmail.com>
In-Reply-To: <20809b59-0d7f-b6b0-e51c-026a78f07a86@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 20 Jan 2023 14:04:22 +0800
Message-ID: <CAD=hENd0HiapsN-iTkAamdy+diFYf4GhP+hnSsfOSwMvMjxY1A@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Handle zero length cases correctly
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org
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

On Fri, Jan 20, 2023 at 12:27 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 1/19/23 19:38, Zhu Yanjun wrote:
> > On Fri, Jan 20, 2023 at 3:09 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> Currently the rxe driver, in rare situations, can respond incorrectly
> >> to zero length operations which are retried. The client does not
> >> have to provide an rkey for zero length RDMA operations so the rkey
> >> may be invalid. The driver saves this rkey in the responder resources
> >> to replay the rdma operation if a retry is required so the second pass
> >> will use this (potentially) invalid rkey which may result in memory
> >> faults.

In this link:
https://lore.kernel.org/lkml/TYCPR01MB8455FC418FD61CAEE85D0D9FE5C19@TYCPR01MB8455.jpnprd01.prod.outlook.com/T/#m9ea28d1465dc2fb3469c21659e6b6c7349fc984f

Daisuke Matsuda (Fujitsu) made further investigations about this problem.

And Daisuke Matsuda (Fujitsu) has delved into this problem.

Let us wait for his comments.

Zhu Yanjun

> >>
> >> This patch corrects the driver to ignore the provided rkey if the
> >> reth length is zero and make sure to set the mr to NULL. In read_reply()
> >> if the length is zero the MR is set to NULL. Warnings are added in
> >> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
> >>
> >
> > There is a patch in the following link:
> >
> > https://patchwork.kernel.org/project/linux-rdma/patch/20230113023527.728725-1-baijiaju1990@gmail.com/
> >
> > Not sure whether it is similar or not.
> >
> > Zhu Yanjun
> >
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_mr.c   |  9 +++++++
> >>  drivers/infiniband/sw/rxe/rxe_resp.c | 36 +++++++++++++++++++++-------
> >>  2 files changed, 36 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> >> index 072eac4b65d2..134a74f315c2 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >> @@ -267,6 +267,9 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
> >>         int m, n;
> >>         void *addr;
> >>
> >> +       if (WARN_ON(!mr))
> >> +               return NULL;
> >> +
> >>         if (mr->state != RXE_MR_STATE_VALID) {
> >>                 rxe_dbg_mr(mr, "Not in valid state\n");
> >>                 addr = NULL;
> >> @@ -305,6 +308,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
> >>         if (length == 0)
> >>                 return 0;
> >>
> >> +       if (WARN_ON(!mr))
> >> +               return -EINVAL;
> >> +
> >>         if (mr->ibmr.type == IB_MR_TYPE_DMA)
> >>                 return -EFAULT;
> >>
> >> @@ -349,6 +355,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
> >>         if (length == 0)
> >>                 return 0;
> >>
> >> +       if (WARN_ON(!mr))
> >> +               return -EINVAL;
> >> +
> >>         if (mr->ibmr.type == IB_MR_TYPE_DMA) {
> >>                 u8 *src, *dest;
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> index c74972244f08..a528dc25d389 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> @@ -457,13 +457,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
> >>         return RESPST_CHK_RKEY;
> >>  }
> >>
> >> +/* if the reth length field is zero we can assume nothing
> >> + * about the rkey value and should not validate or use it.
> >> + * Instead set qp->resp.rkey to 0 which is an invalid rkey
> >> + * value since the minimum index part is 1.
> >> + */
> >>  static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
> >>  {
> >> +       unsigned int length = reth_len(pkt);
> >> +
> >>         qp->resp.va = reth_va(pkt);
> >>         qp->resp.offset = 0;
> >> -       qp->resp.rkey = reth_rkey(pkt);
> >> -       qp->resp.resid = reth_len(pkt);
> >> -       qp->resp.length = reth_len(pkt);
> >> +       qp->resp.resid = length;
> >> +       qp->resp.length = length;
> >> +       if (length)
> >> +               qp->resp.rkey = reth_rkey(pkt);
> >> +       else
> >> +               qp->resp.rkey = 0;
> >>  }
> >>
> >>  static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
> >> @@ -512,8 +522,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >>
> >>         /* A zero-byte op is not required to set an addr or rkey. See C9-88 */
> >>         if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
> >> -           (pkt->mask & RXE_RETH_MASK) &&
> >> -           reth_len(pkt) == 0) {
> >> +           (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
> >> +               qp->resp.mr = NULL;
> >>                 return RESPST_EXECUTE;
> >>         }
> >>
> >> @@ -592,6 +602,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >>         return RESPST_EXECUTE;
> >>
> >>  err:
> >> +       qp->resp.mr = NULL;
> >>         if (mr)
> >>                 rxe_put(mr);
> >>         if (mw)
> >> @@ -966,7 +977,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> >>         }
> >>
> >>         if (res->state == rdatm_res_state_new) {
> >> -               if (!res->replay) {
> >> +               if (qp->resp.length == 0) {
> >> +                       mr = NULL;
> >> +                       qp->resp.mr = NULL;
> >> +               } else if (!res->replay) {
> >>                         mr = qp->resp.mr;
> >>                         qp->resp.mr = NULL;
> >>                 } else {
> >> @@ -980,9 +994,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> >>                 else
> >>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
> >>         } else {
> >> -               mr = rxe_recheck_mr(qp, res->read.rkey);
> >> -               if (!mr)
> >> -                       return RESPST_ERR_RKEY_VIOLATION;
> >> +               if (qp->resp.length == 0) {
> >> +                       mr = NULL;
> >> +               } else {
> >> +                       mr = rxe_recheck_mr(qp, res->read.rkey);
> >> +                       if (!mr)
> >> +                               return RESPST_ERR_RKEY_VIOLATION;
> >> +               }
> >>
> >>                 if (res->read.resid > mtu)
> >>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
> >> --
> >> 2.37.2
> >>
>
> Zhu,
>
> It relates since he is checking for NULL MRs. But I don't think it addresses the root
> causes. The patch I sent should eliminate NULL MRs together with length != 0 in
> the copy routines. I added WARN_ON's in case someone changes things later and
> we hit this again. (A warning is more useful than a fault which can be very hard
> to diagnose.)
>
> The two changes I made that attack the cause of problems are
> (1) clearing qp->resp.mr in check_rkey() in the alternate paths. The primary
> path demands that it get set with a valid mr. But on the alternate paths it isn't
> set at all and can leave with a stale, invalid or wrong mr value.
> (2) in read_reply() there is an error path where a zero length read fails to get
> acked and the requester retries the operation and sends a second request. This
> will end up in read_reply and as currently written attempt to lookup the rkey and
> turn it into an MR but no valid rkey is required in a zero length operation so this
> is likely to fail. The fixes treats length == 0 as a special case and force a NULL mr.
> This should not trigger a fault in the mr copy/etc. routines since they always
> check for length == 0 and return or require a non zero length.
>
> Thanks,
>
> Bob
>
>
