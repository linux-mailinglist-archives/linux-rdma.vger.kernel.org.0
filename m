Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8550EE25
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbiDZBnj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiDZBni (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 21:43:38 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8401929E
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 18:40:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id l203so8304551oif.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W66sSMd0sELa7CqrfA5NTQaG270k27ro7hBkEuJ6FwM=;
        b=kaw/tYa3NLo3+xprnGiuhAmvZunLqdaNqIuXesoHH+6SOWaMxbgyh8kgqtd9E6+hVs
         RNlMfsOS+EYIPMt7mDYfxyVfJqCrtjIWXyjWLw0zPr9KLhvYNaXpx7Th8Hn44oR5IMaa
         k1abaPsa7WpKV/1a7eVxY61JEBV76izJgDDFwtqF7QJJz5JI+uVrp9MAA2oMmbgS+Htt
         FITq/aJv+/0dnQucFUYuV3GKWL+thoQVjxRjrSLrJHuW8WScdz5MVtb9c+Cl4GeWPlsx
         TrDgsZuB4AUFKOErje/xbVhiVwBzDvKKT3VgZICoGrlFZOMV5SvBu4rMCXJ0RRVzPMWG
         tNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W66sSMd0sELa7CqrfA5NTQaG270k27ro7hBkEuJ6FwM=;
        b=DN3StuUP/aPjnaojoqd3txoSGxy0Ab/+o4kyhjHU5xAJ2/hVy2Aox8NE5DHhwOkHLS
         lAFEcFseMX8sI53eMgaBkCW9sw3rdjz79+cKW/N7lZQpZRjlkmUJSlPK2N7wbkLnnQ8h
         2PtnDt/s4J3R79rzegaQZfjbqjZSSxd0TzXoplMeysMD+Mgq7H4wxr7N0s338nvvofKL
         lUgyX4cbcVDiW6H+kou3KvRBAkkSX7H/P7v+4vCGJeIo62ncTN172v7GcWkzFyfyQ1GL
         9pTDoNJoHTh7H5CoF9X+NKcmSYhgDItYYBlTxYd3IGx0mNayX3mViC7H3DCoIleuL0FH
         Pbig==
X-Gm-Message-State: AOAM533OfvdrbBx2pKjriRf+WHPDmpRZZZ9ctZR8GDRzUep+Z8QNrOlZ
        TdiTqLD0Y+DL9r5J7F1l/PcEji8d2NM=
X-Google-Smtp-Source: ABdhPJzLq4B0wlw164tlg6wtDDEP++CeCd6K1vlpO9fByliSmwpw4zDPkZTXf4TU8Bc9DvNobQp0HA==
X-Received: by 2002:a05:6808:23d1:b0:322:97f8:69d7 with SMTP id bq17-20020a05680823d100b0032297f869d7mr14091995oib.241.1650937231572;
        Mon, 25 Apr 2022 18:40:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:adc5:81a0:658f:84cd? (2603-8081-140c-1a00-adc5-81a0-658f-84cd.res6.spectrum.com. [2603:8081:140c:1a00:adc5:81a0:658f:84cd])
        by smtp.gmail.com with ESMTPSA id t3-20020a056870048300b000e686d1389fsm315860oam.57.2022.04.25.18.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:40:31 -0700 (PDT)
Message-ID: <2f84097e-b31c-52b4-80b3-9e275a3b83bc@gmail.com>
Date:   Mon, 25 Apr 2022 20:40:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: bug report for rdma_rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
 <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
 <20220425225831.GG2125828@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220425225831.GG2125828@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/25/22 17:58, Jason Gunthorpe wrote:
> On Mon, Apr 25, 2022 at 11:58:55AM -0500, Bob Pearson wrote:
>> On 4/24/22 19:04, Yanjun Zhu wrote:
>>> 在 2022/4/23 5:04, Bob Pearson 写道:
>>>> Local operations in the rdma_rxe driver are not obviously idempotent. But, the
>>>> RC retry mechanism backs up the send queue to the point of the wqe that is
>>>> currently being acknowledged and re-walks the sq. Each send or write operation is
>>>> retried with the exception that the first one is truncated by the packets already
>>>> having been acknowledged. Each read and atomic operation is resent except that
>>>> read data already received in the first wqe is not requested. But all the
>>>> local operations are replayed. The problem is local invalidate which is destructive.
>>>> For example
>>>
>>> Is there any example or just your analysis?
>>
>> I have a colleague at HPE who is testing Lustre/o2iblnd/rxe. They are testing over a
>> highly reliable network so do not expect to see dropped or out of order packets. But they
>> see multiple timeout flows. When working on rping a week ago I also saw lots of timeouts
>> and verified that the timeout code in rxe has the behavior that when a new RC operation is
>> sent the retry timer is modified to go off at jiffies + qp->timeout_jiffies but only if
>> there is not a currently pending timer. Once set it is never cleared so it will fire
>> typically a few msec later initiating a retry flow. If IO operations are frequent then
>> there will be a timeout every few msec (about 20 times a second for typical timeout values.)
>> o2iblnd uses fast reg MRs to write data to the target system and then local invalidate
>> operations to invalidate the MR and then increments the key portion of the rkey and resets
>> the map and then does a reg mr operation. Retry flows cause the local invalidate and reg MR
>> operations to be re-executed over and over again. A single retry can cause a half a dozen
>> invalidate operations to be run with various rkeys and they mostly fail because they don't
>> match the current MR. This results in Lustre crashing.
>>
>> Currently I am actually happy that the unneeded retries are happening because it makes
>> testing the retry code a lot easier. But eventually it would be good to clear or reset the timer
>> after the operation is completed which would greatly reduce the number of retries. Also
>> it will be important to figure out how the IBA intended for local invalidates and reg MRs to
>> work. The way they are now they cannot be successfully retried. Also marking them as done
>> and skipping them in the retry sequence does not work. (It breaks some of the blktests test
>> cases.)
> 
> local operations on a QP are not supposed to need retry because they
> are not supposed to go on the network, so backing up the sq past its
> current position should not re-execute any local operations until the
> sq passes its actual head.
> 
> Or, stated differently, you have a head/tail pointer for local work
> and a head/tail pointer for network work and the two track
> independently within the defined ordering constraints.
> 
> Jason

Imagine a very long RDMA read operation that times out several times before finally
getting all the data returned to the requester. Now imagine it is followed by some
small RDMA ops to a different node that use fast reg MRs and are executed by the
other node after receiving a small control message. E.g.

	node1					node2					node3

1:	Send: RDMA_READ(mr1 to node2)
						RDMA_READ_REPLY(mr1@node1, 1of2)
	ib_map_mr_sg(mr2a local)
	Send: IB_WR_REG_MR(mr2a local)
	Send: Control msg (mr2a to node3)
											Send: RDMA_WRITE(mr2a@node1)
	Send: IB_WR_LOCAL_INV(mr2a local)
	ib_update_fast_reg_key(mr2a->mr2b)
	ib_map_mr_sg(mr2b local)
	Send: Control msg (mr2b to node3)
											Send: RDMA_WRITE(mr2b@node1)
	Timeout: replay from 1 (w/o local ops)
	Send: RDMA_READ(mr1 to node2)
						RDMA_READ_REPLY(mr1@node1, 2of2)
	Send: Control msg (mr2a to node3)
											Send: RDMA_WRITE(mr2a@node1)
											FAILS because mr2a has been
											replaced by mr2b.
On the other hand if we replay the REG_MR local command that won't work either
because we didn't know to rerun the ib_map_mr_sg() call.

I don't see an easy way to fix this.

What does help is to always set the fence bit on all local operations.
Then will hold off until the prior op completes. But this is a lot
slower than just pipe-lining. This is cheating a little. Node 1 has to
know that the previous RDMA_WRITE to mr2a is done before reusing the mr.
And that implies that either they look at the data (not really OK) or
waited for the completion which implies the send queue is done up to
that point or the fence bit is set in the local invalidate op.

Bob
