Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFF36DCAE
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Apr 2021 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbhD1QIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhD1QIp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 12:08:45 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B1DC061573
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 09:08:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id m13so63522734oiw.13
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=EI2c7PPdQhWc6s1SxLxScUVmQR2TpxfQcGIX8XtSo1w=;
        b=Fc/VVzHgima7+L5ze/IgDsSpeC9aeJD5XHcwX3TCFoqyl0MZkSHAIa4EcuJQdsy9Bv
         IJFPPxrTjZoNqjMrXGW9sD5kj6rc7sqmOLA7UJ2QiuGIED0wX9UZqpFQADWv4JZIxm7w
         dHLRSA+6lj2e7+8LVcUTyAt3ySV0m3sCVOYUQMBAaonMBHifTPpT42nQ8AT2Q+1W7JCm
         KAmpY4zhG0ACW5FoagVWkfyYm2BNTUTdULPEhlNRv/qrZiuMsVPvCgejpjVkccPqbHDY
         qo5qIH1nOY+POxpo36pFIz+StGDlbaNTowwIwHWk//a01AJi06TAlvryptErir7WnMQ1
         R51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EI2c7PPdQhWc6s1SxLxScUVmQR2TpxfQcGIX8XtSo1w=;
        b=RsDTbkD0QulePXOU5EQoGf6YKXQGm0LZ40dRPPYgu+lJ77DK/V7hrQ9mC8TSAmFyop
         v2lT2ZJc4SsB5J/py8eKCqGhBJMGjoaZDMkOMDRKfAhsKC7UXOCuHvTPZ7GD4eW3gfij
         rQpZ2if5zJPaQI+P6EroYx/Ap4iAT/wM6qgzxK8fUh4Rrop+47fNH1I3WSJ6zKES3YQZ
         q+PLMwPNhTE2S2ROTbRQo1bPM7u1KtgAc7VkDyTl8dXisQvEonK/oHnvmeg5HHMChDkJ
         b2JsjD7jnyFF/pYkWjvswHA29JWmof44nRKL4x3JEJe+zE7IdjkMyxSeHm35BzFUEVBa
         mEmQ==
X-Gm-Message-State: AOAM531SCL2Tbr1hQBlCRmCP+RK3eBreHa4Lq5L2k7wD3r0y0BeZOA+a
        R1xqoeesKxIYKJFN2whP+kINXi7RpI1AAg==
X-Google-Smtp-Source: ABdhPJzks5tu5U6xl7szfp/QjB0vRM6nopzAd/bNC+2R9HaGWZDV66he1neQMlMkpVtmOOJfHLblQw==
X-Received: by 2002:a05:6808:1cc:: with SMTP id x12mr3478401oic.114.1619626079045;
        Wed, 28 Apr 2021 09:07:59 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:dcc:55b8:efe8:ecc6? (2603-8081-140c-1a00-0dcc-55b8-efe8-ecc6.res6.spectrum.com. [2603:8081:140c:1a00:dcc:55b8:efe8:ecc6])
        by smtp.gmail.com with ESMTPSA id u4sm85841ool.25.2021.04.28.09.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:07:58 -0700 (PDT)
Subject: Fwd: [PATCH for-next v5 09/10] RDMA/rxe: Implement memory access
 through MWs
References: <37e1d1ec-67fe-4878-3793-a324ac613f7f@gmail.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <37e1d1ec-67fe-4878-3793-a324ac613f7f@gmail.com>
Message-ID: <254c00b2-0a1d-b349-e964-11989905aacb@gmail.com>
Date:   Wed, 28 Apr 2021 11:07:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <37e1d1ec-67fe-4878-3793-a324ac613f7f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/24/2021 11:23 PM, Zhu Yanjun wrote:
> On Fri, Apr 23, 2021 at 12:13 AM Bob Pearson <rpearsonhpe@gmail.com> 
> wrote:
>> Add code to implement memory access through memory windows.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>> v3:
>> Adjusted patch for collisions with v3 of "RDMA/rxe: Implement
>> invalidate MW operations" patch.
>> v2:
>> Removed a copy of changes in ea4922518940 "Fix missing acks from 
>> responder"
>> that was submitted separately.
>> ---
>> drivers/infiniband/sw/rxe/rxe_loc.h | 1 +
>> drivers/infiniband/sw/rxe/rxe_mw.c | 23 +++++++++++
>> drivers/infiniband/sw/rxe/rxe_resp.c | 55 +++++++++++++++++++--------
>> drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++
>> 4 files changed, 75 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h 
>> b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index bc0e484f8cde..076e1460577f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -94,6 +94,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct 
>> ib_udata *udata);
>> int rxe_dealloc_mw(struct ib_mw *ibmw);
>> int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>> int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
>> +struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
>> void rxe_mw_cleanup(struct rxe_pool_entry *arg);
>>
>> /* rxe_net.c */
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c 
>> b/drivers/infiniband/sw/rxe/rxe_mw.c
>> index 00490f232fde..6ed36845c693 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
>> @@ -312,6 +312,29 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
>> return ret;
>> }
>>
>> +struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
> will this function lookup_mw be used outside of softroce?
> If not, how about changing the name from lookup_mw to rxe_lookup_mw?
>
> Thanks
> Zhu Yanjun

I would think the opposite is correct. If a name is used outside of the 
driver then the prefix reduces the chance

of a collision with some more global name. If it is only used locally in 
the driver this is less of an issue. Mostly

I have been following the rule that if a name is shared between files in 
rxe then add the prefix and if it is local

to a file (e.g. static) then drop it. Here I broke that and will make 
this change. If a routine is frequently used

for example to_rdev() then the prefix just gets in the way of clarity. 
The shared names are declared in rxe_loc.h.

The common names are defined in rxe_verbs.h.

Bob

>
>> +{
>> + struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>> + struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
>> + struct rxe_mw *mw;
>> + int index = rkey >> 8;
>> +
>> + mw = rxe_pool_get_index(&rxe->mw_pool, index);
>> + if (!mw)
>> + return NULL;
>> +
>> + if (unlikely((mw_rkey(mw) != rkey) || mw_pd(mw) != pd ||
>> + (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
>> + (mw->length == 0) ||
>> + (access && !(access & mw->access)) ||
>> + mw->state != RXE_MW_STATE_VALID)) {
>> + rxe_drop_ref(mw);
>> + return NULL;
>> + }
>> +
>> + return mw;
>> +}
>> +
>> void rxe_mw_cleanup(struct rxe_pool_entry *elem)
>> {
>> struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
>> b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 759e9789cd4d..9c8cbfbc8820 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -394,6 +394,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>> struct rxe_pkt_info *pkt)
>> {
>> struct rxe_mr *mr = NULL;
>> + struct rxe_mw *mw = NULL;
>> u64 va;
>> u32 rkey;
>> u32 resid;
>> @@ -405,6 +406,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>> if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
>> if (pkt->mask & RXE_RETH_MASK) {
>> qp->resp.va = reth_va(pkt);
>> + qp->resp.offset = 0;
>> qp->resp.rkey = reth_rkey(pkt);
>> qp->resp.resid = reth_len(pkt);
>> qp->resp.length = reth_len(pkt);
>> @@ -413,6 +415,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>> : IB_ACCESS_REMOTE_WRITE;
>> } else if (pkt->mask & RXE_ATOMIC_MASK) {
>> qp->resp.va = atmeth_va(pkt);
>> + qp->resp.offset = 0;
>> qp->resp.rkey = atmeth_rkey(pkt);
>> qp->resp.resid = sizeof(u64);
>> access = IB_ACCESS_REMOTE_ATOMIC;
>> @@ -432,18 +435,36 @@ static enum resp_states check_rkey(struct 
>> rxe_qp *qp,
>> resid = qp->resp.resid;
>> pktlen = payload_size(pkt);
>>
>> - mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
>> - if (!mr) {
>> - state = RESPST_ERR_RKEY_VIOLATION;
>> - goto err;
>> - }
>> + if (rkey_is_mw(rkey)) {
>> + mw = lookup_mw(qp, access, rkey);
>> + if (!mw) {
>> + pr_err("%s: no MW matches rkey %#x\n", __func__, rkey);
>> + state = RESPST_ERR_RKEY_VIOLATION;
>> + goto err;
>> + }
>>
>> - if (unlikely(mr->state == RXE_MR_STATE_FREE)) {
>> - state = RESPST_ERR_RKEY_VIOLATION;
>> - goto err;
>> + mr = mw->mr;
>> + if (!mr) {
>> + pr_err("%s: MW doesn't have an MR\n", __func__);
>> + state = RESPST_ERR_RKEY_VIOLATION;
>> + goto err;
>> + }
>> +
>> + if (mw->access & IB_ZERO_BASED)
>> + qp->resp.offset = mw->addr;
>> +
>> + rxe_drop_ref(mw);
>> + rxe_add_ref(mr);
>> + } else {
>> + mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
>> + if (!mr) {
>> + pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
>> + state = RESPST_ERR_RKEY_VIOLATION;
>> + goto err;
>> + }
>> }
>>
>> - if (mr_check_range(mr, va, resid)) {
>> + if (mr_check_range(mr, va + qp->resp.offset, resid)) {
>> state = RESPST_ERR_RKEY_VIOLATION;
>> goto err;
>> }
>> @@ -477,6 +498,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>> err:
>> if (mr)
>> rxe_drop_ref(mr);
>> + if (mw)
>> + rxe_drop_ref(mw);
>> +
>> return state;
>> }
>>
>> @@ -501,8 +525,8 @@ static enum resp_states write_data_in(struct 
>> rxe_qp *qp,
>> int err;
>> int data_len = payload_size(pkt);
>>
>> - err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt), 
>> data_len,
>> - RXE_TO_MR_OBJ, NULL);
>> + err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
>> + payload_addr(pkt), data_len, RXE_TO_MR_OBJ, NULL);
>> if (err) {
>> rc = RESPST_ERR_RKEY_VIOLATION;
>> goto out;
>> @@ -521,7 +545,6 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
>> static enum resp_states process_atomic(struct rxe_qp *qp,
>> struct rxe_pkt_info *pkt)
>> {
>> - u64 iova = atmeth_va(pkt);
>> u64 *vaddr;
>> enum resp_states ret;
>> struct rxe_mr *mr = qp->resp.mr;
>> @@ -531,7 +554,7 @@ static enum resp_states process_atomic(struct 
>> rxe_qp *qp,
>> goto out;
>> }
>>
>> - vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
>> + vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
>>
>> /* check vaddr is 8 bytes aligned. */
>> if (!vaddr || (uintptr_t)vaddr & 7) {
>> @@ -655,8 +678,10 @@ static enum resp_states read_reply(struct rxe_qp 
>> *qp,
>> res->type = RXE_READ_MASK;
>> res->replay = 0;
>>
>> - res->read.va = qp->resp.va;
>> - res->read.va_org = qp->resp.va;
>> + res->read.va = qp->resp.va +
>> + qp->resp.offset;
>> + res->read.va_org = qp->resp.va +
>> + qp->resp.offset;
>>
>> res->first_psn = req_pkt->psn;
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index 74fcd871757d..f426bf30f86a 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -183,6 +183,7 @@ struct rxe_resp_info {
>>
>> /* RDMA read / atomic only */
>> u64 va;
>> + u64 offset;
>> struct rxe_mr *mr;
>> u32 resid;
>> u32 rkey;
>> @@ -480,6 +481,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
>> return mr->ibmr.rkey;
>> }
>>
>> +static inline struct rxe_pd *mw_pd(struct rxe_mw *mw)
> rxe_mw_pd
No. See above.
>
>> +{
>> + return to_rpd(mw->ibmw.pd);
>> +}
>> +
>> +static inline u32 mw_rkey(struct rxe_mw *mw)
> rxe_mw_rkey
No.
>
>> +{
>> + return mw->ibmw.rkey;
>> +}
>> +
>> int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
>>
>> void rxe_mc_cleanup(struct rxe_pool_entry *arg);
>> --
>> 2.27.0
>>
