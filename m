Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA069D63D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Feb 2023 23:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjBTWQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Feb 2023 17:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBTWQn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Feb 2023 17:16:43 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF8F1ADD0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Feb 2023 14:16:37 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id UESYpyOTplrplUESYpdBva; Mon, 20 Feb 2023 23:16:35 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 Feb 2023 23:16:35 +0100
X-ME-IP: 86.243.2.178
Message-ID: <e92c7992-303a-0f71-13b2-f33efbba4b22@wanadoo.fr>
Date:   Mon, 20 Feb 2023 23:16:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] RDMA/restrack: Reorder fields in 'struct
 rdma_restrack_entry'
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
References: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
 <Y+uH0k0OBzPip1P8@ziepe.ca> <75480cf9-8d06-7a7d-4624-6ddbb7d6053a@wanadoo.fr>
 <Y+uiLCB7H2xVvQZW@ziepe.ca> <Y+zCkwTgevj0zDFK@unreal>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y+zCkwTgevj0zDFK@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 15/02/2023 à 12:31, Leon Romanovsky a écrit :
> On Tue, Feb 14, 2023 at 11:01:00AM -0400, Jason Gunthorpe wrote:
>> On Tue, Feb 14, 2023 at 03:34:21PM +0100, Christophe JAILLET wrote:
>>> Le 14/02/2023 à 14:08, Jason Gunthorpe a écrit :
>>>> On Tue, Feb 14, 2023 at 01:53:52PM +0100, Christophe JAILLET wrote:
>>>>> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
>>>>> index 8b7c46daeb07..da53fefe6f9e 100644
>>>>> --- a/include/rdma/restrack.h
>>>>> +++ b/include/rdma/restrack.h
>>>>> @@ -80,6 +80,10 @@ struct rdma_restrack_entry {
>>>>>    	 * query stage.
>>>>>    	 */
>>>>>    	u8			no_track : 1;
>>>>> +	/**
>>>>> +	 * @user: user resource
>>>>> +	 */
>>>>> +	bool			user;
>>>>
>>>> Can we combine this into the bitfield above?
>>>>
>>>> Jason
>>>>
>>> Hi,
>>>
>>> and even above, we have
>>> 	bool	valid;
>>>
>>> I wanted to keep the changes as minimal as possible, but I can change them
>>> all in a single bitfield.
>>
>> IIRC it needs to be checked, I vaugely remember valid can't be a
>> bitfield because it is an atomic
> 
> I don't remember anything like this.
> 
> Thanks
> 

If I understand code correctly, 'valid' is only used in 
rdma_restrack_add() and rdma_restrack_del().

I don't think that any atomic behavior is in place in these functions.


I'll send in the coming days a v2 which changes 'valid', 'no_track' and 
'user' as bool:1.

CJ
