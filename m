Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663546B81CF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Mar 2023 20:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMTns (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Mar 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMTnr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Mar 2023 15:43:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344682A84;
        Mon, 13 Mar 2023 12:43:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso7302379otk.3;
        Mon, 13 Mar 2023 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678736625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwEwSuTgSY520olxehs+hWgOHbsYCxg4NdwtSaatwno=;
        b=TBplKKKYOLZs3rZt79CeiMs0DDwMMNZqgucjt7b/VtVsd2TmNUsE45DWs6f6ORPMKM
         Y9RMCV8gww7lyO28fW1ogZmm4CWEfM8B4tCyJ3nb166phiDH9PwdJeg+G52UohtFFXS4
         SXanJLJv8ZRgKIP0yHbrdogDHsmlQGmKB2QiE8H8U1c/r3BHPXrt0ZqkRnnyE4pZp28L
         GGRmJzHavxpvxwF7PB7XRcbOqmi+y/NL+KHi/o85+en5MHirj4s1yVG49F84vzyGRUXF
         FjZjsFWOmOnBr6Ok++srHOYIJsXEnc601cr3uHWisBTso6EyJz+reUhgzWoULmMpU95S
         QLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwEwSuTgSY520olxehs+hWgOHbsYCxg4NdwtSaatwno=;
        b=csoh/dE8Bahz6imiFF2L1zOL+UEHQyUAnT4DRoL4L450cmfNVrXw2j7N9wpyUeBN+W
         Q87VlwO09M0kCQTHMhvznARGWqKN8lVtK3dRMX2MpJrBNfqBkjNSZ0+CZj3zViw9ky47
         2rYmrsRNXVguAxIxJMNjOo52fGjzghxJra9OPzD62ZOAOP2WpANuDBqiCvhM8sPvnvnk
         kDj0ctLh9VlpD+34SYtReo5UTPDIZVPZTWrdoftoqPkKvtoGYS72uQ1Y+CtdlkCcFfYz
         uo4XM4ZnfQvdDFAKfWrWEdYvz6QMtrNhWOWBRyK9MKwOWR+JiMz5tfBGrs1/M0qZlKGH
         E5yQ==
X-Gm-Message-State: AO0yUKWleiqjuznBjsoUZ8hqn8INMoxZno4kMvvWH1fnk1xNVy5ppAD+
        K5p7Juyys7JqOCD4UqGdBYa30JPGZiY=
X-Google-Smtp-Source: AK7set8kR4MhR64rwL9+eBJhAOzRfDmidoaOcFzg9u7LIqzIKXcyi2XX4z2TZztS0gOKlHmTyqdpeQ==
X-Received: by 2002:a9d:2a9:0:b0:693:d9a5:c5d with SMTP id 38-20020a9d02a9000000b00693d9a50c5dmr17026627otl.3.1678736625190;
        Mon, 13 Mar 2023 12:43:45 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1600:7c57:ec4f:7588? (2603-8081-140c-1a00-1600-7c57-ec4f-7588.res6.spectrum.com. [2603:8081:140c:1a00:1600:7c57:ec4f:7588])
        by smtp.gmail.com with ESMTPSA id p129-20020a4a4887000000b00524fe20aee5sm260970ooa.34.2023.03.13.12.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 12:43:44 -0700 (PDT)
Message-ID: <67fbe385-3682-be4e-15fe-f26cc56fd56b@gmail.com>
Date:   Mon, 13 Mar 2023 14:43:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
To:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-8-urezki@gmail.com> <ZAnjnRC1wY3RIFhM@pc636>
 <ZAnpdKV/VvvX0TZz@pc636> <20230310005529.GA339498@google.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230310005529.GA339498@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/9/23 18:55, Joel Fernandes wrote:
> On Thu, Mar 09, 2023 at 03:13:08PM +0100, Uladzislau Rezki wrote:
>>> On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote:
>>>> The kfree_rcu()'s single argument name is deprecated therefore
>>>> rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
>>>> underline that it is for sleepable contexts.
>>>>
>>>> Please check the RXE driver in a way that a single argument can
>>>> be used. Briefly looking at it and rcu_head should be embed to
>>>> free an obj over RCU-core. The context might be atomic.
>>>>
>>>> Cc: Bob Pearson <rpearsonhpe@gmail.com>
>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>> Could you please add you reviwed-by or Acked-by tags so we can bring
>>> our series with renaming for the next merge window?
>>>
>>> Thanks!
>>>
>> __rxe_cleanup() can be called in two contexts, sleepable and not.
>> Therefore usage of a single argument of the kvfree_rcu() is not correct
>> here.
>>
>> Could you please fix and check your driver? If my above statement
>> is not correct, please provide Acked-by or Reviwed-by tags to the
>> path that is in question.
>>
>> Otherwise please add an rcu_head in your data to free objects over
>> kvfree_rcu() using double argument API.
>>
>> Could you please support?
> 
> Also this one needs renaming? It came in because of the commit in 6.3-rc1:
> 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
> 
> It could be squashed into this patch itself since it is infiniband related.
> 
> Paul noticed that this breaks dropping the old API on -next, so it is
> blocking the renaming.
> 
> ---8<-----------------------
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index b10aa1580a64..ae3a100e18fb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  		return -EINVAL;
>  
>  	rxe_cleanup(mr);
> -	kfree_rcu(mr);
> +	kfree_rcu_mightsleep(mr);
>  	return 0;
>  }
>  
I just got back from a 1 week vacation and missed all this.

The "RDMA/rxe: Remove rxe_alloc()" patch just moved the memory allocation for MR (verbs) objects outside
of the rxe_pool code since it only applied to MRs and not the other verbs objects (AH, QP, CQ, ...).
That code has to handle a unique situation for AH objects which can be created or destroyed by connection
manager code in atomic context while all the other ones including MRs are always created/destroyed in process
context. All objects other than MR's are created/destroyed in the rdma-core code (drivers/infiniband/core).

The rxe driver keeps xarray's of pointers to the various objects which are protected by rcu locking and so
it made sense to use kfree_rcu to delete the object with a delay. In the MR case ..._mightsleep seems harmless
and should not be an issue.

However on reflection, all the references to the MR objects are ref counted and they have been dropped before
reaching the kfree and so there really never was a good reason to use kfree_rcu in the first place. So
a better solution would be to replace kfree_rcu with kfree. There is a timeout in completion_done() that
triggers a WARN_ON() and this is only seen if the driver is broken for some reason but that is equivalent to
getting a seg fault so no reason to further delay the kfree.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
