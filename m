Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2B398B62
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBOGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhFBOGN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 10:06:13 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96769C061574
        for <linux-rdma@vger.kernel.org>; Wed,  2 Jun 2021 07:04:30 -0700 (PDT)
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1622642668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yT6tGmLv/qtjQpwWyVZXRZm7/iMnZ+pe0GNzx4c45/s=;
        b=Ix5O7HJKC2iMlA+diI81srJly//1p3bRQMpCKK6Xxm70e+YM52JkuF64VX8CLOPQY3nyhI
        8f3sbDLVFeZEKKyBmj/2ZmcGzf/W5ydzZ0xa496D9qyvNvi7hbM1Yz6oe9CvxY47/pfqIP
        CYbRwpP+W6nMOkMtJbLePdEO0umd56c=
To:     Kamal Heib <kamalheib1@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
 <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
 <YLX5PLZjjoRiDNGN@kheib-workstation>
 <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
 <20210601170132.GN1096940@ziepe.ca> <YLeDL+Omy8QdI+Q+@kheib-workstation>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
Message-ID: <9d05b6fd-e9e5-f830-7b92-3b0428bc0711@linux.dev>
Date:   Wed, 2 Jun 2021 22:04:18 +0800
MIME-Version: 1.0
In-Reply-To: <YLeDL+Omy8QdI+Q+@kheib-workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yanjun.zhu@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2021/6/2 21:10, Kamal Heib 写道:
> On Tue, Jun 01, 2021 at 02:01:32PM -0300, Jason Gunthorpe wrote:
>> On Tue, Jun 01, 2021 at 11:59:44PM +0800, Zhu Yanjun wrote:
>>> On Tue, Jun 1, 2021 at 5:09 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>>>> On Tue, Jun 01, 2021 at 04:11:08PM +0800, Zhu Yanjun wrote:
>>>>> On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>> On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>>>>>>
>>>>>>> ﻿On Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>>>>>>>> To avoid the following failure when trying to load the rdma_rxe module
>>>>>>>> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
>>>>>>>> before trying to create the IPv6 UDP tunnel.
>>>>>>>>
>>>>>>>> $ modprobe rdma_rxe
>>>>>>>> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
>>>>>>> About this problem, this link:
>>>>>>> https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12209-1-yanjun.zhu@intel.com/
>>>>>>> also tries to solve ipv6 problem.
>>>>>>>
>>>>>>> Zhu Yanjun
>>>>>>>
>>>>>> Yes, but this patch is fixing the problem more cleanly and I’ve tested it.
>>> Please check this link
>>> https://lore.kernel.org/linux-rdma/20210326012723.41769-1-yanjun.zhu@intel.com/T/
>>> carefully.
>>>
>>> Please pay attention to the comments from Jason Gunthorpe
>> I think the comment still holds, the correct fix is to detect the -97
>> errno down in the call chain and just ignore ipv6 support in this
>> case.
>>
>> Jason
> OK, Could you please tell me what do you think about the following:
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..144d9e1c1c3d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -208,6 +208,11 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>          /* Create UDP socket */
>          err = udp_sock_create(net, &udp_cfg, &sock);
>          if (err < 0) {
> +               if (ipv6 && (err == -EAFNOSUPPORT)) {
> +                       pr_warn("IPv6 is not supported can not create UDP socket\n");
> +                       return NULL;

The returned value is changed.

Zhu Yanjun

> +               }
> +
>                  pr_err("failed to create udp socket. err = %d\n", err);
>                  return ERR_PTR(err);
>          }
>
>
> Thanks,
> Kamal
