Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4D674A8A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 05:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjATE1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 23:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjATE1R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 23:27:17 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2113B2D2C
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 20:27:04 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x21-20020a056830245500b006865ccca77aso2434535otr.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 20:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHtqh6ofcJMK4QQ4cZYmYePxVtGG+yvnt4mXHNoqTfc=;
        b=PCwnBYJW8lrPDISsGnXhUDTZZ8q8YefF04eZTgr0Kx6c5zMYK5zUpIQLHBnCLtpLHB
         Cwnu54H2GPHZbqp/pKcBGyykLowh5VD6LRJoGHOpBEVNpxhFfjO+RdNKx9zgr9DKFEiR
         b5zC43/QuJ6HmSSn6q18oHPZtC3lV/DPMshARPJB4Mv0dOXAzL+TnSFesGEYlBCgOAr6
         jrujmlsL2wY4vSThccwLt/df/kbBROkSE5LmxxuQCArrA4dSEhw0Ly2LKDq7mojReW74
         xhnLrf5z+jFT7beDhOKoNyI4gCI9yACLzH6aJjmM5M8cWL0Y48FtmyBVLfsM+KMGRzSj
         3QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHtqh6ofcJMK4QQ4cZYmYePxVtGG+yvnt4mXHNoqTfc=;
        b=Ka/wpipQHO5Bt7TKdrQ9VGkGKlpQnrakceNNChsj3+aTJ2AIAt2pTkE+S0AOR63Cbz
         HLFotTWmn9F2JW1xuN8eBEu4GRgo3xEebEkMEkQUmcNyxbZ1QYGsfnVYmMAH45JtuRhA
         Q+oEHoWj1gJVSe54pLcrR+vBpLFt+/PBBmKpMfn6Cmg7U+nJi5YcC0s9l0R1NYrxatNf
         zKcLrb+QSG91Y9/WcHawrjcfVJcEV59oW4JZ1KLFqpFiIgH/hMaaekagradaZNYpc+go
         BxCWdksMBUSgWu9wwO2qw/d5HpZj1GpVPHPekXGiPjs5ZOl2CyI5b3E+hbiVSvlNTMg5
         2acA==
X-Gm-Message-State: AFqh2kr8NeMgMWyR6cpc1BwFIoqFX8INkkcCSj9WBCb/3rjcJD999tKi
        q6FDLRfxa1mfwJpgK9cWcA1fGUq8/jj68Q==
X-Google-Smtp-Source: AMrXdXs4v2rP7g0e2ZKeNOcRFuWpc9Eefd4AncFdloBAOH0JigLGi+8WHbXFF1/qJouZYZGT+F0fbg==
X-Received: by 2002:a05:6830:4107:b0:684:d383:396e with SMTP id w7-20020a056830410700b00684d383396emr7528796ott.35.1674188823752;
        Thu, 19 Jan 2023 20:27:03 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:d086:74d8:5274:c0f1? (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id b20-20020a056830105400b006865223e532sm4444079otp.51.2023.01.19.20.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 20:27:03 -0800 (PST)
Message-ID: <20809b59-0d7f-b6b0-e51c-026a78f07a86@gmail.com>
Date:   Thu, 19 Jan 2023 22:27:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next] RDMA/rxe: Handle zero length cases correctly
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org
References: <20230119190653.6363-1-rpearsonhpe@gmail.com>
 <CAD=hENcdkWchRrvH+KXLXZoaQcZPpnCdV9V9T9mmzkJ13DJKUA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENcdkWchRrvH+KXLXZoaQcZPpnCdV9V9T9mmzkJ13DJKUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/19/23 19:38, Zhu Yanjun wrote:
> On Fri, Jan 20, 2023 at 3:09 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Currently the rxe driver, in rare situations, can respond incorrectly
>> to zero length operations which are retried. The client does not
>> have to provide an rkey for zero length RDMA operations so the rkey
>> may be invalid. The driver saves this rkey in the responder resources
>> to replay the rdma operation if a retry is required so the second pass
>> will use this (potentially) invalid rkey which may result in memory
>> faults.
>>
>> This patch corrects the driver to ignore the provided rkey if the
>> reth length is zero and make sure to set the mr to NULL. In read_reply()
>> if the length is zero the MR is set to NULL. Warnings are added in
>> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
>>
> 
> There is a patch in the following link:
> 
> https://patchwork.kernel.org/project/linux-rdma/patch/20230113023527.728725-1-baijiaju1990@gmail.com/
> 
> Not sure whether it is similar or not.
> 
> Zhu Yanjun
> 
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_mr.c   |  9 +++++++
>>  drivers/infiniband/sw/rxe/rxe_resp.c | 36 +++++++++++++++++++++-------
>>  2 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index 072eac4b65d2..134a74f315c2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -267,6 +267,9 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>>         int m, n;
>>         void *addr;
>>
>> +       if (WARN_ON(!mr))
>> +               return NULL;
>> +
>>         if (mr->state != RXE_MR_STATE_VALID) {
>>                 rxe_dbg_mr(mr, "Not in valid state\n");
>>                 addr = NULL;
>> @@ -305,6 +308,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
>>         if (length == 0)
>>                 return 0;
>>
>> +       if (WARN_ON(!mr))
>> +               return -EINVAL;
>> +
>>         if (mr->ibmr.type == IB_MR_TYPE_DMA)
>>                 return -EFAULT;
>>
>> @@ -349,6 +355,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>>         if (length == 0)
>>                 return 0;
>>
>> +       if (WARN_ON(!mr))
>> +               return -EINVAL;
>> +
>>         if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>>                 u8 *src, *dest;
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index c74972244f08..a528dc25d389 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -457,13 +457,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>>         return RESPST_CHK_RKEY;
>>  }
>>
>> +/* if the reth length field is zero we can assume nothing
>> + * about the rkey value and should not validate or use it.
>> + * Instead set qp->resp.rkey to 0 which is an invalid rkey
>> + * value since the minimum index part is 1.
>> + */
>>  static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>  {
>> +       unsigned int length = reth_len(pkt);
>> +
>>         qp->resp.va = reth_va(pkt);
>>         qp->resp.offset = 0;
>> -       qp->resp.rkey = reth_rkey(pkt);
>> -       qp->resp.resid = reth_len(pkt);
>> -       qp->resp.length = reth_len(pkt);
>> +       qp->resp.resid = length;
>> +       qp->resp.length = length;
>> +       if (length)
>> +               qp->resp.rkey = reth_rkey(pkt);
>> +       else
>> +               qp->resp.rkey = 0;
>>  }
>>
>>  static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>> @@ -512,8 +522,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>
>>         /* A zero-byte op is not required to set an addr or rkey. See C9-88 */
>>         if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
>> -           (pkt->mask & RXE_RETH_MASK) &&
>> -           reth_len(pkt) == 0) {
>> +           (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
>> +               qp->resp.mr = NULL;
>>                 return RESPST_EXECUTE;
>>         }
>>
>> @@ -592,6 +602,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>         return RESPST_EXECUTE;
>>
>>  err:
>> +       qp->resp.mr = NULL;
>>         if (mr)
>>                 rxe_put(mr);
>>         if (mw)
>> @@ -966,7 +977,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>         }
>>
>>         if (res->state == rdatm_res_state_new) {
>> -               if (!res->replay) {
>> +               if (qp->resp.length == 0) {
>> +                       mr = NULL;
>> +                       qp->resp.mr = NULL;
>> +               } else if (!res->replay) {
>>                         mr = qp->resp.mr;
>>                         qp->resp.mr = NULL;
>>                 } else {
>> @@ -980,9 +994,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>                 else
>>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
>>         } else {
>> -               mr = rxe_recheck_mr(qp, res->read.rkey);
>> -               if (!mr)
>> -                       return RESPST_ERR_RKEY_VIOLATION;
>> +               if (qp->resp.length == 0) {
>> +                       mr = NULL;
>> +               } else {
>> +                       mr = rxe_recheck_mr(qp, res->read.rkey);
>> +                       if (!mr)
>> +                               return RESPST_ERR_RKEY_VIOLATION;
>> +               }
>>
>>                 if (res->read.resid > mtu)
>>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
>> --
>> 2.37.2
>>

Zhu,

It relates since he is checking for NULL MRs. But I don't think it addresses the root
causes. The patch I sent should eliminate NULL MRs together with length != 0 in
the copy routines. I added WARN_ON's in case someone changes things later and
we hit this again. (A warning is more useful than a fault which can be very hard
to diagnose.)

The two changes I made that attack the cause of problems are
(1) clearing qp->resp.mr in check_rkey() in the alternate paths. The primary
path demands that it get set with a valid mr. But on the alternate paths it isn't
set at all and can leave with a stale, invalid or wrong mr value.
(2) in read_reply() there is an error path where a zero length read fails to get
acked and the requester retries the operation and sends a second request. This
will end up in read_reply and as currently written attempt to lookup the rkey and
turn it into an MR but no valid rkey is required in a zero length operation so this
is likely to fail. The fixes treats length == 0 as a special case and force a NULL mr.
This should not trigger a fault in the mr copy/etc. routines since they always
check for length == 0 and return or require a non zero length.

Thanks,

Bob


