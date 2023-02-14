Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17B36966F1
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 15:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjBNOeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 09:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjBNOeY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 09:34:24 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA4422E
        for <linux-rdma@vger.kernel.org>; Tue, 14 Feb 2023 06:34:23 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id RwNxpI8ETXjveRwNxpC96F; Tue, 14 Feb 2023 15:34:21 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Feb 2023 15:34:21 +0100
X-ME-IP: 86.243.2.178
Message-ID: <75480cf9-8d06-7a7d-4624-6ddbb7d6053a@wanadoo.fr>
Date:   Tue, 14 Feb 2023 15:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] RDMA/restrack: Reorder fields in 'struct
 rdma_restrack_entry'
Content-Language: fr, en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
References: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
 <Y+uH0k0OBzPip1P8@ziepe.ca>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y+uH0k0OBzPip1P8@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 14/02/2023 à 14:08, Jason Gunthorpe a écrit :
> On Tue, Feb 14, 2023 at 01:53:52PM +0100, Christophe JAILLET wrote:
>> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
>> index 8b7c46daeb07..da53fefe6f9e 100644
>> --- a/include/rdma/restrack.h
>> +++ b/include/rdma/restrack.h
>> @@ -80,6 +80,10 @@ struct rdma_restrack_entry {
>>   	 * query stage.
>>   	 */
>>   	u8			no_track : 1;
>> +	/**
>> +	 * @user: user resource
>> +	 */
>> +	bool			user;
> 
> Can we combine this into the bitfield above?
> 
> Jason
> 
Hi,

and even above, we have
	bool	valid;

I wanted to keep the changes as minimal as possible, but I can change 
them all in a single bitfield.


Do you want code such as:
static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
				      struct task_struct *task)
{
	if (WARN_ON_ONCE(!task))
		return;

	if (res->task)
		put_task_struct(res->task);
	get_task_struct(task);
	res->task = task;
	res->user = true;			<--------
}

to be changed with 0/1 instead of false/true?

Apparently gcc 11.3 is fine with using true with u8:1, but I don't find 
it really logical.

CJ
