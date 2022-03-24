Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B724E6044
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 09:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiCXIZj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiCXIZi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 04:25:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68341AF2B;
        Thu, 24 Mar 2022 01:24:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b24so4679850edu.10;
        Thu, 24 Mar 2022 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VjoE8BZJVN1iwPK7whmEd/UzvSJx78EIFvypyOblvMU=;
        b=iD1t79TR8oKBahp+V8Sy2/3GsPNaxDcNogaMNOUWGUjPVuM4ZB7mBrxURI8PjSfQ5s
         1k++OsLCCjbhgMUff4fCxXY0Ow82HGJpwowEukJAWstzEG8H1R3lye60SGC4NDUcrWFF
         UmmIfvk06isHhveJsA6fIEIgfORjJtV4R2jovSTf7SU176Sm9agB3G7zrpVAgPcRLF3G
         WIG0E6n8ASnfLXXTPoa9wZPVXT3Jii/L2UNMoMYRMNhZeY3BRgvNHbQN/bpIdTNgV3uX
         1/okEsHox2/jVsuDSOBQeQduF5wZIJdoMFmC2ymCZwA1+Ep/SSD04i4d93FBELXZF5IC
         T2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VjoE8BZJVN1iwPK7whmEd/UzvSJx78EIFvypyOblvMU=;
        b=KOc6UpOGSVjTK8LnB0XbjXa4MDb2iORK8e/KjHhZWeweGUZf51LazabunHPqb9d3M8
         4MTBgAKBrl2oNgmguuk5v8xV4MYVSu22Ycfk0EWWasieCC8pnD5WcrIK9zwdJCHeTp03
         9sb7+4ZynkF6WaClfzwSOnAEnCcvLftF0+KyT21v1hgcKCF+SvYECb7palGehAMYc+Re
         2jwvWLQRzN8iPPIIhuTGU0GFQX+3c4/9cbxUPoRduTpghB7rPVjBIu0ZlO5zXORi4Eze
         1NYHG9+hdwrp0+eD5AB6q48F0lK/FzXVD84uOdOOCkURRiaMItufU1BsOUpGGOTtkWno
         amZg==
X-Gm-Message-State: AOAM531hffsQz6NZKIC50Bsuh8aikHmlDxTegW58uS6CcP7aPqYGZ2Mn
        CdAV5902uMaT3VdoPx/mV28=
X-Google-Smtp-Source: ABdhPJw37yFct1HhmaDA4lugphic2JUaHogmb/7qUOhL1UjkHPzH0J4ikR8vtnKQQYUbNgwxFWnAIw==
X-Received: by 2002:a05:6402:84f:b0:419:638f:2bd5 with SMTP id b15-20020a056402084f00b00419638f2bd5mr5154017edz.283.1648110245364;
        Thu, 24 Mar 2022 01:24:05 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b006ce04bb8668sm820866ejh.184.2022.03.24.01.24.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 01:24:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] IB/SA: replace usage of found with dedicated list
 iterator variable
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <a06fef85-7b5c-b2ef-7965-2387cbc8f724@nvidia.com>
Date:   Thu, 24 Mar 2022 09:24:01 +0100
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA1E832C-2030-4344-97EA-E0E219DDDF6C@gmail.com>
References: <20220324071124.59849-1-jakobkoschel@gmail.com>
 <a06fef85-7b5c-b2ef-7965-2387cbc8f724@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
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



> On 24. Mar 2022, at 08:53, Mark Zhang <markzhang@nvidia.com> wrote:
>=20
> On 3/24/2022 3:11 PM, Jakob Koschel wrote:
>> External email: Use caution opening links or attachments
>> To move the list iterator variable into the list_for_each_entry_*()
>> macro in the future it should be avoided to use the list iterator
>> variable after the loop body.
>> To *never* use the list iterator variable after the loop it was
>> concluded to use a separate iterator variable instead of a
>> found boolean [1].
>> This removes the need to use a found variable and simply checking if
>> the variable was set, can determine if the break/goto was hit.
>> Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/infiniband/core/sa_query.c | 15 +++++++--------
>> 1 file changed, 7 insertions(+), 8 deletions(-)
>> diff --git a/drivers/infiniband/core/sa_query.c =
b/drivers/infiniband/core/sa_query.c
>> index 74ecd7456a11..74cd84045e5b 100644
>> --- a/drivers/infiniband/core/sa_query.c
>> +++ b/drivers/infiniband/core/sa_query.c
>> @@ -1035,10 +1035,9 @@ int ib_nl_handle_resolve_resp(struct sk_buff =
*skb,
>> struct netlink_ext_ack *extack)
>> {
>> unsigned long flags;
>> - struct ib_sa_query *query;
>> + struct ib_sa_query *query =3D NULL, *iter;
>> struct ib_mad_send_buf *send_buf;
>> struct ib_mad_send_wc mad_send_wc;
>> - int found =3D 0;
>> int ret;
>> if ((nlh->nlmsg_flags & NLM_F_REQUEST) ||
>> @@ -1046,20 +1045,20 @@ int ib_nl_handle_resolve_resp(struct sk_buff =
*skb,
>> return -EPERM;
>> spin_lock_irqsave(&ib_nl_request_lock, flags);
>> - list_for_each_entry(query, &ib_nl_request_list, list) {
>> + list_for_each_entry(iter, &ib_nl_request_list, list) {
>> /*
>> * If the query is cancelled, let the timeout routine
>> * take care of it.
>> */
>> - if (nlh->nlmsg_seq =3D=3D query->seq) {
>> - found =3D !ib_sa_query_cancelled(query);
>> - if (found)
>> - list_del(&query->list);
>> + if (nlh->nlmsg_seq =3D=3D iter->seq) {
>> + if (!ib_sa_query_cancelled(iter))
>> + list_del(&iter->list);
>> + query =3D iter;
>> break;
>=20
> Should it be:
>=20
> if (nlh->nlmsg_seq =3D=3D iter->seq) {
> 	if (!ib_sa_query_cancelled(iter)) {
> 		list_del(&iter->list);
> 		query =3D iter;
> 	}
> 	break;

yes you are right. Sorry about that, I'll send a fixed version with v2.

>=20
>> }
>> }
>> - if (!found) {
>> + if (!query) {
>> spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>> goto resp_out;
>> }
>> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
>> --
>> 2.25.1

