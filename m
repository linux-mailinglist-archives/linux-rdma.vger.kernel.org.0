Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325416955C7
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 02:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBNBNj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 20:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBNBNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 20:13:38 -0500
Received: from out-157.mta0.migadu.com (out-157.mta0.migadu.com [91.218.175.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1A1284B
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 17:13:36 -0800 (PST)
Message-ID: <e20aa648-d911-0fee-e42b-165f440405f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676337214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PP6CWfRhY6a/12o7lCgAQWqmPdxjoTyALsgqQ9Hw+9I=;
        b=s1qXRgqP8ghvvxOkH/sfp19zmowkk7JwYubW0QNRC8iIiuzKXvKiEKpSI3/HUkcLM3EEhN
        /wHqwIJPJzSwL55oZcxIA6WWylN7pmJ3MRahC65JkYg/EQ2ORL4Nm3Anonh8zYb383aF7w
        LnnYduxW0ucS18nA0MwvLKIs1nfuCnY=
Date:   Tue, 14 Feb 2023 09:13:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
 <dc4f034a-3cc8-fbaf-a5ba-2338c8fc8576@fujitsu.com>
 <TYCPR01MB8455CB23812E701AD1220CCDE5D99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <cc570a6b-0702-72b7-c09e-fea45351c34f@fujitsu.com>
 <cdafcc1d-7899-415c-6c49-08406cea6357@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cdafcc1d-7899-415c-6c49-08406cea6357@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/2/14 1:41, Bob Pearson 写道:
> On 2/9/23 04:20, lizhijian@fujitsu.com wrote:
>>
>>
>> On 09/02/2023 16:14, Matsuda, Daisuke/松田 大輔 wrote:
>>> On Wed, Feb 8, 2023 5:41 PM Li, Zhijian/李 智坚 wrote:
>>>>
>>>> On 02/02/2023 12:42, Bob Pearson wrote:
>>>>> +/* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
>>>>> + * if an invalid rkey is received or the rdma length is zero. For middle
>>>>> + * or last packets use the stored value of mr.
>>>>> + */
>>>>>     static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>>     				   struct rxe_pkt_info *pkt)
>>>>>     {
>>>>> @@ -473,10 +487,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>>     		return RESPST_EXECUTE;
>>>>>     	}
>>>>>
>>>>> -	/* A zero-byte op is not required to set an addr or rkey. See C9-88 */
>>>>> +	/* A zero-byte read or write op is not required to
>>>>> +	 * set an addr or rkey. See C9-88
>>>>> +	 */
>>>>>     	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
>>>>> -	    (pkt->mask & RXE_RETH_MASK) &&
>>>>> -	    reth_len(pkt) == 0) {
>>>>> +	    (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
>>>>> +		qp->resp.mr = NULL;
>>>>
>>>> You are making sure 'qp->resp.mr = NULL', but I doubt the previous qp->resp.mr will leak after this assignment when its
>>>> value is not NULL.
>>>
>>> I do not see what you mean by " the previous qp->resp.mr ".
>>> As far as I understand, 'qp->resp.mr' is set to NULL in cleanup()
>>> before responder completes its work, so it is not supposed to be
>>> reused unlike 'res->read.rkey' being retained for multi-packet Read
>>> responses. Could you elaborate on your view?
>>
>> IMO every 'qp->resp.mr' assignment will take a mr reference, so we should drop the this reference if we want to assign it a new mr again.
>>
>>
>> Theoretically, it should be changed to something like
>> if (qp->resp.mr) {
>> 	rxe_put(qp->resp.mr)
>>           qp->resp.mr = NULL;
>> }

Without "qp->resp.mr = NULL;", it is possible to cause use after free 
error if qp->resp.mr is used again.

Zhu Yanjun

>>
> Generally I agree with the idea that a (few) assignments like this, even if after minutes of looking
> over the code can be shown to be unneeded because it is already NULL or will get deleted, are helpful
> if it makes the code easier to understand and prevents later changes to unintentionally break things.
> 
> Bob
>>
>>
>>
>>>>
>>>>>     		return RESPST_EXECUTE;
>>>>>     	}
>>>>>
>>>>> @@ -555,6 +571,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>>     	return RESPST_EXECUTE;
>>>>>
>>>>>     err:
>>>>> +	qp->resp.mr = NULL;
>>
>> ditto
>>
>> Thanks
>> Zhijian
>>
>>>>>     	if (mr)
> 

