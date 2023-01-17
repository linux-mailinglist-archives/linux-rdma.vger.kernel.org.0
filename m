Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6F66E435
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjAQQ5g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 11:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAQQ5e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 11:57:34 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8AA39BA3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:57:33 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r9so2215145oig.12
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIoIz09ceCPs7l/8f+9jm2Ut99gsDfJtm2s+ECRahDQ=;
        b=jHnGP/eqzv2ZUXagRKd/ln99Z1YG1gKQgrhAS9YQTBZaSfyXc4xngWZ2gNAScxCAo2
         JF4jUVETiQaTFJ1a3aY3xqQnpEv0L3tl7Ei+O5l1Bj9czrm4zWjf8z5V1vSAiB0d1TJt
         HPXHZ2GELBApl4WqKJnmpPHhtxhjRILur6tdjeoDVWwm76R/H1+ElsoD24e+IrHiFtbf
         YHObSwOejRV+OqkkovoJj8ShjG1EEQMAUsYKpSjuZOS4HqldGe8Pkua0Q6EEKoGh98nf
         j3FxaRVMiwdX25M9SvOMJapmWUzC14W2s+AGNvdRhc/SLFCnJS3PVYpndW/HJdjgQhwA
         oVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIoIz09ceCPs7l/8f+9jm2Ut99gsDfJtm2s+ECRahDQ=;
        b=okPAHLkX8QEPLEkmmJ/weVtPG7V1eO6FfzAVa06ex+tqQqGXwUzwIWxBjcjVH/inuz
         /obYPyLOD/w96Bj9aqj70gsRvZAO8Jicy47i08/2Vb2yxuJsKCmZLiOwLFv/iEVxvKkh
         DNbU9xgYEnfyII0dgE2KKkiQFslza3QWcQihoDrxe8p2QmqD7zkkL9+NVck9laK0fGL/
         8aruB4yvRAjgXgIbhsgtUDisj47fuSh1lR0lTLUoXhzYqhc8dcoyQHpdvrFtRDySVcd8
         CJAXqq1hNcVdtiCbuVlshml+3KOtlfHqnM3HKRbp2tEGujLGvv+xJVHds02IE5L1uzAD
         bUZQ==
X-Gm-Message-State: AFqh2kqMlX2DyWXx7+faUgfPo6GFHjUTC5HWFmstUO7mEEgZ46HdFOj3
        PW9RYUaTBQ1PGw7azq94ivTrl9c/toCEKA==
X-Google-Smtp-Source: AMrXdXtBu88N0azyV2oaUt6HE8S3tg6HF3muX6Aur2lsYO5miC/0WvM4owmDx8Hik7BFvB3xjy5BEg==
X-Received: by 2002:a05:6808:1822:b0:364:9030:ca30 with SMTP id bh34-20020a056808182200b003649030ca30mr2500182oib.50.1673974652829;
        Tue, 17 Jan 2023 08:57:32 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:ea18:3ee9:26d1:7526? (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id ec13-20020a056808638d00b0035c21f1a570sm14923871oib.6.2023.01.17.08.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:57:32 -0800 (PST)
Message-ID: <9a701083-2268-dea5-fe4b-cd2de59fb647@gmail.com>
Date:   Tue, 17 Jan 2023 10:57:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-5-rpearsonhpe@gmail.com> <Y8a6mILrIxIwq4/m@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y8a6mILrIxIwq4/m@nvidia.com>
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

On 1/17/23 09:11, Jason Gunthorpe wrote:
> On Mon, Jan 16, 2023 at 05:56:01PM -0600, Bob Pearson wrote:
> 
>> +/* only implemented for 64 bit architectures */
>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>> +{
>> +#if defined CONFIG_64BIT
> 
> #ifdef
> 
> It is a little more typical style to provide an alternate version of
> the function when #ifdefing

I will do that.
> 
>> +	u64 *va;
>> +
>> +	/* See IBA oA19-28 */
>> +	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
>> +		rxe_dbg_mr(mr, "mr not in valid state");
>> +		return -EINVAL;
>> +	}
>> +
>> +	va = iova_to_vaddr(mr, iova, sizeof(value));
>> +	if (unlikely(!va)) {
>> +		rxe_dbg_mr(mr, "iova out of range");
>> +		return -ERANGE;
>> +	}
>> +
>> +	/* See IBA A19.4.2 */
>> +	if (unlikely((uintptr_t)va & 0x7 || iova & 0x7)) {
>> +		rxe_dbg_mr(mr, "misaligned address");
>> +		return -RXE_ERR_NOT_ALIGNED;
>> +	}
>> +
>> +	/* Do atomic write after all prior operations have completed */
>> +	smp_store_release(va, value);
>> +
>> +	return 0;
>> +#else
>> +	WARN_ON(1);
>> +	return -EINVAL;
>> +#endif
>> +}
>> +
>>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
>>  {
>>  	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 1e38e5da1f4c..49298ff88d25 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -764,30 +764,40 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>>  	return RESPST_ACKNOWLEDGE;
>>  }
>>  
>> -#ifdef CONFIG_64BIT
>> -static enum resp_states do_atomic_write(struct rxe_qp *qp,
>> -					struct rxe_pkt_info *pkt)
>> +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>> +					   struct rxe_pkt_info *pkt)
>>  {
>> -	struct rxe_mr *mr = qp->resp.mr;
>> -	int payload = payload_size(pkt);
>> -	u64 src, *dst;
>> -
>> -	if (mr->state != RXE_MR_STATE_VALID)
>> -		return RESPST_ERR_RKEY_VIOLATION;
>> +	struct resp_res *res = qp->resp.res;
>> +	struct rxe_mr *mr;
>> +	u64 value;
>> +	u64 iova;
>> +	int err;
>>  
>> -	memcpy(&src, payload_addr(pkt), payload);
>> +	if (!res) {
>> +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
>> +		qp->resp.res = res;
>> +	}
>>  
>> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
>> -	/* check vaddr is 8 bytes aligned. */
>> -	if (!dst || (uintptr_t)dst & 7)
>> -		return RESPST_ERR_MISALIGNED_ATOMIC;
>> +	if (res->replay)
>> +		return RESPST_ACKNOWLEDGE;
>>  
>> -	/* Do atomic write after all prior operations have completed */
>> -	smp_store_release(dst, src);
>> +	mr = qp->resp.mr;
>> +	value = *(u64 *)payload_addr(pkt);
>> +	iova = qp->resp.va + qp->resp.offset;
>>  
>> -	/* decrease resp.resid to zero */
>> -	qp->resp.resid -= sizeof(payload);
>> +#if defined CONFIG_64BIT
> 
> Shouldn't need a #ifdef here

This avoids a new special error (i.e. NOT_64_bit) and makes it clear we
won't call the code in mr.

I really don't understand why Fujitsu did it all this way instead of just
using a spinlock for 32 bit architectures as a fallback. But if I want to
keep to the spirit of their implementation this is fairly clear I think.

Bob
> 
>> +	err = rxe_mr_do_atomic_write(mr, iova, value);
>> +	if (unlikely(err)) {
>> +		if (err == -RXE_ERR_NOT_ALIGNED)
>> +			return RESPST_ERR_MISALIGNED_ATOMIC;
>> +		else
>> +			return RESPST_ERR_RKEY_VIOLATION;
> 
> Again why not return the RESPST directly then the stub can return
> RESPST_ERR_UNSUPPORTED_OPCODE?
> 
> Jason

