Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2624694E40
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Feb 2023 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBMRlj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 12:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBMRli (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 12:41:38 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10682B468
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 09:41:37 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id bv2-20020a0568300d8200b0068dc615ee44so3954342otb.10
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9uodeBK3Qjz8R7HHkVSjR5xgVy0s0I7tbVawXh3bMc=;
        b=RQju5Mb0g9dfkMdvz+r52TdppPHr1Tg4H7gb8ZbqQek2Vc4NghimVgG0YQKX3nEHXZ
         nqSWJKpFY7bpihPX05qKffTjDM8iRkY4I0igZWM6w3h80B0wsoqmdbGVZxhuN9UARBC3
         wfK0g/ZMvzjrf0+sC8Ft6FcsCrW3y49lojhyddvnGEGBwL7XsRKk0X3BcGtGNlxyeQH8
         Oy7W+2qgYHVS8yYC+2zpVVGGkUFioh3Lv5ZVTqrgItVLV/g8t2BGeuGxlG/sc/jnBvA1
         q0df7GO02AMsi7HeMkcJVmcbAQT7Ppavesofig/5D37jj9m3UrLI6ym7sVGraPcMmi8d
         sbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9uodeBK3Qjz8R7HHkVSjR5xgVy0s0I7tbVawXh3bMc=;
        b=3e2ivG15aBAs314x21ebWZeIKZ+m2S+CZfhhwT2owfH70zCm5UqRQy/QvFUiJtM/Pn
         Xbjem3QvnuWgkwZa2pMiUISjfS1ZAA+2/3NnXTB5QzKChORHNDAGntDzG2gyQ6OvhTZb
         mK73OqiWquHT7DIOEH9narAEVqwPgJ7/2dkbsFAGhJgYUlVTCKIsP4TQ4ipTwRX+w/1e
         /rsuAvXhLVe0vKVQ+HT5rDzdOzGGUVt1htXGv3YjyLmC3ueHHA9+PtrHNhTgIaiB/j+F
         DP3fM9g3it/FcLPFwNzzWiLI7R0hJtCwTx+1cvkIsHWTbmdyIsWw2ozmz14aq/pNm/au
         NeMg==
X-Gm-Message-State: AO0yUKW/26FmKyPso5bC74IOCNU4p47Z98Ozn0sXt3QXEH8l9FnxIx9k
        Y97ecBAK4ki7NLDHUdoam5JFK2f7E3Q=
X-Google-Smtp-Source: AK7set+DrPbSiF5pGIf942NooqNHGziVx6y3WGDiZRyLqqletzDrLgL0MgR2xGDmeegDjsoGpKf/oQ==
X-Received: by 2002:a05:6830:390a:b0:68d:a31c:c381 with SMTP id br10-20020a056830390a00b0068da31cc381mr16774977otb.33.1676310096353;
        Mon, 13 Feb 2023 09:41:36 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id i8-20020a9d68c8000000b0068657984c22sm5408083oto.32.2023.02.13.09.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:41:35 -0800 (PST)
Message-ID: <cdafcc1d-7899-415c-6c49-08406cea6357@gmail.com>
Date:   Mon, 13 Feb 2023 11:41:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
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
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <cc570a6b-0702-72b7-c09e-fea45351c34f@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/9/23 04:20, lizhijian@fujitsu.com wrote:
> 
> 
> On 09/02/2023 16:14, Matsuda, Daisuke/松田 大輔 wrote:
>> On Wed, Feb 8, 2023 5:41 PM Li, Zhijian/李 智坚 wrote:
>>>
>>> On 02/02/2023 12:42, Bob Pearson wrote:
>>>> +/* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
>>>> + * if an invalid rkey is received or the rdma length is zero. For middle
>>>> + * or last packets use the stored value of mr.
>>>> + */
>>>>    static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>    				   struct rxe_pkt_info *pkt)
>>>>    {
>>>> @@ -473,10 +487,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>    		return RESPST_EXECUTE;
>>>>    	}
>>>>
>>>> -	/* A zero-byte op is not required to set an addr or rkey. See C9-88 */
>>>> +	/* A zero-byte read or write op is not required to
>>>> +	 * set an addr or rkey. See C9-88
>>>> +	 */
>>>>    	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
>>>> -	    (pkt->mask & RXE_RETH_MASK) &&
>>>> -	    reth_len(pkt) == 0) {
>>>> +	    (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
>>>> +		qp->resp.mr = NULL;
>>>
>>> You are making sure 'qp->resp.mr = NULL', but I doubt the previous qp->resp.mr will leak after this assignment when its
>>> value is not NULL.
>>
>> I do not see what you mean by " the previous qp->resp.mr ".
>> As far as I understand, 'qp->resp.mr' is set to NULL in cleanup()
>> before responder completes its work, so it is not supposed to be
>> reused unlike 'res->read.rkey' being retained for multi-packet Read
>> responses. Could you elaborate on your view?
> 
> IMO every 'qp->resp.mr' assignment will take a mr reference, so we should drop the this reference if we want to assign it a new mr again.
> 
> 
> Theoretically, it should be changed to something like
> if (qp->resp.mr) {
> 	rxe_put(qp->resp.mr)
>          qp->resp.mr = NULL;
> }
> 
Generally I agree with the idea that a (few) assignments like this, even if after minutes of looking
over the code can be shown to be unneeded because it is already NULL or will get deleted, are helpful
if it makes the code easier to understand and prevents later changes to unintentionally break things.

Bob
> 
> 
> 
>>>
>>>>    		return RESPST_EXECUTE;
>>>>    	}
>>>>
>>>> @@ -555,6 +571,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>    	return RESPST_EXECUTE;
>>>>
>>>>    err:
>>>> +	qp->resp.mr = NULL;
> 
> ditto
> 
> Thanks
> Zhijian
> 
>>>>    	if (mr)

