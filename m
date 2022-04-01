Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F64EF77A
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbiDAP5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358261AbiDAPmJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 11:42:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1B2B3D42;
        Fri,  1 Apr 2022 08:16:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p15so6518208ejc.7;
        Fri, 01 Apr 2022 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9jSvmrcxa3BrthKf28LR6iQlwhB8Fp11bxqRJaDoPQ4=;
        b=c/MWb4ayrGBGC3GVIXfoAWO7GDWE/s9EEx/jK3E33PZRw4Hitr36dI810eMbHTokW+
         WKXmAQgUtWWEufkRmtpNtzgIvAIRxOTuyTcFF2Io0UJirLHrv4FQk6S8IXnYUGEYQ5Zm
         7T4/dvjor6irpAmhvDs9Tf5Pwfd1tE2tyTbL5LNb+OACADNLr3PmVYgQOnVJ3RWWIjIo
         DA55mX3hUIvea4KCK9BAlCXuQ0ZAyDo+pnFn7eo7O0gzrKWgan2TYPmtFMcnde3tjQBe
         +I/v88QEmf0bD7gktED1HOoQfZ7C47DE7wd/fo3FsDhxwsRISA2zoIKjNbg9MdwuNAcO
         YtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9jSvmrcxa3BrthKf28LR6iQlwhB8Fp11bxqRJaDoPQ4=;
        b=FliClmxM8WImDdwwz+RL/LnHPZEj29+Of0zF1Zv1Qza8aewg6VjY1ihvSr2CsFYz7/
         zQgkP3mg0JN2ckvRJI2BtIpkfz/Usvb5jHlCXJgNVLimXrc/tmihH911mHYZVezMlFGS
         KYw1U7kl1JYvddNhh8EfaEGSxekVVtahmNMFRo5bvTP1kmFFfeMoMjglK+kOQWSzr7tE
         pZbbEo/4w8VHr1SGfTusgip8+SXvUtU7ZIGArq3t/9ATGqc1WDt15PlYbKz/RLn9RhZ7
         dW07gJMFsod/tis0dCt39F5UdwoQsloD0yBmcTALKJc/VurQDieD3N7zQGUmjPUZSL1/
         3nog==
X-Gm-Message-State: AOAM532VlapR4YL8llsFTiBZOPI2d9NnU5CJWHIlhxmWrEAILYjnx9oP
        IbmvClQBKgX/hbRF/x5iKVs=
X-Google-Smtp-Source: ABdhPJyj1x5zxOKPhdW9FhcHdGg9CnDqeJtt+ellJDnNgz6FNFcycEZ2cWZwQljsY6IU7h7orVX+FQ==
X-Received: by 2002:a17:907:72c4:b0:6df:917c:df6f with SMTP id du4-20020a17090772c400b006df917cdf6fmr291481ejc.120.1648826190736;
        Fri, 01 Apr 2022 08:16:30 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402045800b0041614c8f79asm1285712edw.88.2022.04.01.08.16.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:16:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] IB/hfi1: remove check of list iterator against head past
 the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <0d3e61ea-b3b8-620a-f418-0c91b381b67d@cornelisnetworks.com>
Date:   Fri, 1 Apr 2022 17:16:29 +0200
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CBAC9B8-F675-41B8-AE72-C0A8B5FA0303@gmail.com>
References: <20220331224501.904039-1-jakobkoschel@gmail.com>
 <0d3e61ea-b3b8-620a-f418-0c91b381b67d@cornelisnetworks.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 1. Apr 2022, at 16:34, Dennis Dalessandro =
<dennis.dalessandro@cornelisnetworks.com> wrote:
>=20
> On 3/31/22 6:45 PM, Jakob Koschel wrote:
>> When list_for_each_entry() completes the iteration over the whole =
list
>> without breaking the loop, the iterator value will be a bogus pointer
>> computed based on the head element.
>>=20
>> While it is safe to use the pointer to determine if it was computed
>> based on the head element, either with list_entry_is_head() or
>> &pos->member =3D=3D head, using the iterator variable after the loop =
should
>> be avoided.
>>=20
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element =
[1].
>=20
> The code isn't searching the list. So there is no "found" element. It =
is walking
> a list of things and using each one it comes across.

Ok, I can see how this is confusing. I'll change the text accordingly.

>=20
>>=20
>> Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/ [1]
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/infiniband/hw/hfi1/tid_rdma.c | 16 +++++++++-------
>> 1 file changed, 9 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c =
b/drivers/infiniband/hw/hfi1/tid_rdma.c
>> index 2a7abf7a1f7f..b12abf83a91c 100644
>> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
>> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
>> @@ -1239,7 +1239,7 @@ static int kern_alloc_tids(struct tid_rdma_flow =
*flow)
>> 	struct hfi1_ctxtdata *rcd =3D flow->req->rcd;
>> 	struct hfi1_devdata *dd =3D rcd->dd;
>> 	u32 ngroups, pageidx =3D 0;
>> -	struct tid_group *group =3D NULL, *used;
>> +	struct tid_group *group =3D NULL, *used, *iter;
>> 	u8 use;
>>=20
>> 	flow->tnode_cnt =3D 0;
>> @@ -1248,13 +1248,15 @@ static int kern_alloc_tids(struct =
tid_rdma_flow *flow)
>> 		goto used_list;
>>=20
>> 	/* First look at complete groups */
>> -	list_for_each_entry(group, &rcd->tid_group_list.list, list) {
>> -		kern_add_tid_node(flow, rcd, "complete groups", group,
>> -				 group->size);
>> +	list_for_each_entry(iter, &rcd->tid_group_list.list, list) {
>> +		kern_add_tid_node(flow, rcd, "complete groups", iter,
>> +				 iter->size);
>>=20
>> -		pageidx +=3D group->size;
>> -		if (!--ngroups)
>> +		pageidx +=3D iter->size;
>> +		if (!--ngroups) {
>> +			group =3D iter;
>> 			break;
>> +		}
>> 	}
>=20
> The original code's intention was that if group is NULL we never =
iterated the
> list. If group !=3D NULL we either iterated the entire list and ran =
out or we had
> enough and hit the break.

This is however not correct. list_for_each_entry() always sets 'group'.
It needs to do so to check the terminating condition of the loop.
It does so even if the list is empty and the loop body is not even =
executed once.

>=20
> Under the proposed code, group is NULL if we never iterated the loop. =
It will
> also be NULL if we reach the end of the list. So the only time group =
!=3D NULL is
> when we iterated the list and found all the groups we needed.
>=20
>> 	if (pageidx >=3D flow->npagesets)
>> @@ -1277,7 +1279,7 @@ static int kern_alloc_tids(struct tid_rdma_flow =
*flow)
>> 	 * However, if we are at the head, we have reached the end of =
the
>> 	 * complete groups list from the first loop above
>> 	 */
>> -	if (group && &group->list =3D=3D &rcd->tid_group_list.list)
>> +	if (!group)
>=20
> So the problem here is group->list may point to gibberish if we =
iterated the
> entire loop?

In this case it would be &group->list =3D=3D &rcd->tid_group_list.list
So the second part of the check is correct whereas the check "if group =
=3D=3D true"
is just always true.

Since the intention is to move the scope of the list iterator into the =
macro
itself I'm removing the accesses to the list iterator after the loop =
body
('group' in this case).

>=20
> Perhaps instead of group, add a bool, call it "need_more" or =
something. Set it
> to True at init time. Then when/if we hit the break set it to False. =
Means we
> found enough groups. Then down here we check if (need_more)....

If I understand you correctly the condition here should be:

	if (!list_empty(&rcd->tid_group_list.list) && !group)

which will only be true if the list actually did at least one iteration =
but did not
break early.

>=20
> At the very least if you want to keep the code as it is, fix up the =
comments to
> make sense and explain the situation.

The code behaves exactly as it did before my patch.
Sorry I've missed that comment, I'll update it as well. As explain =
above, this
comment is a bit misleading since that's not actually what is executing =
and therefore
I got confused. group would be "at head" if the list being iterated
is empty, since the list iterator macros does not differentiate between
"not running any iteration of the loop since the list is empty" and=20
"running to the end of the loop with at least one iteration".

>=20
> -Denny

Sorry for the confusing terminology and missing the comment.

Thanks,
Jakob


