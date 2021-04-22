Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4E367955
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhDVFdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhDVFdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:33:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D28C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:33:02 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso27032391otm.4
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhvnJBdckxYPgu7Mnwk4JrLhUIxYY9m37ukvTV7rD5w=;
        b=t4f+dFbbTGZZ6GeHWUmn9hau7h0/yIFvYnVLMnn3pQEjkgD31neatjwn84QrPNrEvC
         sGjuHrPcNqYSzfFbF4HjFRt64DM0me/2YetOvS0Na4mHbzGorn32HP72jZFm44egXr6f
         cr9YZjnaKbpyrfjCpAq98y30rVZpaQub0wHUghSUcSXlLtGBOKTHeMMGxWJnGWut0itd
         qfWLpT0r6G2GNmyP0FQa9cTWLDIUhHUxrwpk/wPhd/SQojh5t+ZL8YhmZ05TWfqBFUmn
         mIc2FH8jMraUAlZcMoBfk77FmSD2hF2pvprFMTODiKwMrx+dAtvAkXzWoWMt4YmnmV/U
         VcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhvnJBdckxYPgu7Mnwk4JrLhUIxYY9m37ukvTV7rD5w=;
        b=pK37R+rm+lmXVEwRlUTmEgQX9cllXguN++CtcjVIxKkCwkxrAGRlFxNk8QdwHKCSIP
         kRJEDIU7Ew729HbNAg22WD4IK9V9KBt0Tnhmdj2KlRQVvA8Efr/pGeBKf2eNuI51/LsA
         9uYu+oRi6yaMaJzG7V3L3ROspWTLcKf0lFnBgkQIPl+B3vWrS/FeoR/hpk1R79IzevIg
         hMtNv1l5F9txezCPTLhx1s2xZORUsZOXAgcyVO8ovV/5No41fLHwjDNy4ACK9hRYZOE9
         zxQbFQH8y2QnAMYhaOE0gY2kGDbOx7jVAbqRL3nbJbCYbuUGfwcze3UuH+7HwEGq2hxY
         DHvQ==
X-Gm-Message-State: AOAM532rQUZoYDg2gxmRlWGdrpEABJqfC49+5sO8pUNP/0yydlBOILzb
        z93YbDiymSmyPDxmj2sPt2JKCnBbzo8=
X-Google-Smtp-Source: ABdhPJygtdP376MpS4SnWx5EBI0Y2UibG9kAeszp/vOKN9/sxgWZaetZQVDSiFaQIyEXaXGtpGwkgA==
X-Received: by 2002:a9d:4e05:: with SMTP id p5mr1390418otf.264.1619069581727;
        Wed, 21 Apr 2021 22:33:01 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f? (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id u1sm433242otj.43.2021.04.21.22.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 22:33:01 -0700 (PDT)
Subject: Re: [PATCH for-next v3 7/9] RDMA/rxe: Add support for bind MW work
 requests
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210421052015.4546-1-rpearson@hpe.com>
 <20210421052015.4546-8-rpearson@hpe.com>
 <CAD=hENcq19ncF1bUnyY_Se0MW6R529-89UCEVwAu0QDBR9J1FA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <f92cdfd0-8a0a-477d-4235-bacccb9ea996@gmail.com>
Date:   Thu, 22 Apr 2021 00:33:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENcq19ncF1bUnyY_Se0MW6R529-89UCEVwAu0QDBR9J1FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/21/21 4:36 AM, Zhu Yanjun wrote:
> On Wed, Apr 21, 2021 at 1:20 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Add support for bind MW work requests from user space.
>> Since rdma/core does not support bind mw in ib_send_wr
>> there is no way to support bind mw in kernel space.
>>
>> Added bind_mw local operation in rxe_req.c
>> Added bind_mw WR operation in rxe_opcode.c
>> Added bind_mw WC in rxe_comp.c
>> Added additional fields to rxe_mw in rxe_verbs.h
>> Added do_dealloc_mw() subroutine to cleanup an mw
>> when rxe_dealloc_mw is called.
>> Added code to implement bind_mw operation in rxe_mw.c
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>> v3:
>>   do_bind_mw() in rxe_mw.c is changed to be a void instead of
>>   returning an int.
>> v2:
>>   Dropped kernel support for bind_mw in rxe_mw.c
>>   Replaced umw with mw in struct rxe_send_wr
>> ---
>>  drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
>>  drivers/infiniband/sw/rxe/rxe_loc.h    |   1 +
>>  drivers/infiniband/sw/rxe/rxe_mw.c     | 202 ++++++++++++++++++++++++-
>>  drivers/infiniband/sw/rxe/rxe_opcode.c |   7 +
>>  drivers/infiniband/sw/rxe/rxe_req.c    |   9 ++
>>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  15 +-
>>  6 files changed, 230 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index 2af26737d32d..bc5488af5f55 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -103,6 +103,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
>>         case IB_WR_RDMA_READ_WITH_INV:          return IB_WC_RDMA_READ;
>>         case IB_WR_LOCAL_INV:                   return IB_WC_LOCAL_INV;
>>         case IB_WR_REG_MR:                      return IB_WC_REG_MR;
>> +       case IB_WR_BIND_MW:                     return IB_WC_BIND_MW;
>>
>>         default:
>>                 return 0xff;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index edf575930a98..e6f574973298 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -110,6 +110,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>>  /* rxe_mw.c */
>>  int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>>  int rxe_dealloc_mw(struct ib_mw *ibmw);
>> +int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>>  void rxe_mw_cleanup(struct rxe_pool_entry *arg);
>>
>>  /* rxe_net.c */
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
>> index 69128e298d44..c018e8865876 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
>> @@ -29,6 +29,29 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
>>         return 0;
>>  }
>>
>> +static void do_dealloc_mw(struct rxe_mw *mw)
>> +{
>> +       if (mw->mr) {
>> +               struct rxe_mr *mr = mw->mr;
>> +
>> +               mw->mr = NULL;
>> +               atomic_dec(&mr->num_mw);
> 
> What is the usage of this num_mw?
> 
> Zhu Yanjun
> 

I added a 10th patch to the series as v4 to address this. The other 9 are identical to v3.

Just checked if mr->num_mw > 0 and return -EINVAL if so for dereg MR and invalidate MR.

Bob
