Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2A7A5C5E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjISIUR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjISIUH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 04:20:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A03137;
        Tue, 19 Sep 2023 01:20:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7426FC433C7;
        Tue, 19 Sep 2023 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695111602;
        bh=NQT6emoqUopWQG8nLcWMcdZH6R7kukhQWLpXWeF1of8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CY4mWCSGiuOopN+4f4no/yV9mut8/bGL1jv18xQf/viTmcqtNBnNN5zNgbyb28kJJ
         iZXi2YfOjY19HRUJWOixkCwOaEZxmIpn8igTTpjFhyVM9Ry7NyqeRspJFlAfwcN+xO
         NR2RY3si8NL27bwSIiWGaCU/TcXv7XymgzYQCen6OhegkybNdgh4Yh9//YSnsoQWI8
         ZoSrLPTbpH0uIZPFP0WAeOC30TXBZ0bHmIGeDE8pFA7rJiEej2359dcK1vcTN2IhhT
         AfPfYuH/VQ+07l0mSajRyQhpGxPwWq5KgGd/qdIljKADmILEnaGe3ja57evHcC+UJe
         iwMmQNCRwPKJQ==
Date:   Tue, 19 Sep 2023 11:19:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
Message-ID: <20230919081957.GE4494@unreal>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com>
 <20230918123710.GD103601@unreal>
 <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
 <CAD=hENfcbgNQxb2N1qXJa0pYkF_AYB2aua0smadwkgHtYXfeAw@mail.gmail.com>
 <0cd9103b-4411-700e-f8d1-94e8735f57e4@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cd9103b-4411-700e-f8d1-94e8735f57e4@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 19, 2023 at 03:25:00AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/09/2023 09:11, Zhu Yanjun wrote:
> > On Tue, Sep 19, 2023 at 8:57 AM Zhijian Li (Fujitsu)
> > <lizhijian@fujitsu.com> wrote:
> >>
> >>
> >>
> >> On 18/09/2023 20:37, Leon Romanovsky wrote:
> >>> On Mon, Sep 18, 2023 at 10:05:43AM +0800, Li Zhijian wrote:
> >>>> rxe_set_mtu() will call rxe_info_dev() to print message, and
> >>>> rxe_info_dev() expects dev_name(rxe->ib_dev->dev) has been assigned.
> >>>>
> >>>> Previously since dev_name() is not set, when a new rxe link is being
> >>>> added, 'null' will be used as the dev_name like:
> >>>>
> >>>> "(null): rxe_set_mtu: Set mtu to 1024"
> >>>>
> >>>> Move rxe_register_device() earlier to assign the correct dev_name
> >>>> so that it can be read by rxe_set_mtu() later.
> >>>
> >>> I would expect removal of that print line instead of moving
> >>> rxe_register_device().
> >>
> >>
> >> I also struggled with this point. The last option is keep it as it is.
> >> Once rxe is registered, this print will work fine.
> > 
> > I delved into the source code. About moving rxe_register_device, I
> > could not find any harm to the driver.
> 
> The point i'm struggling was that, it's strange/opaque to move rxe_register_device().
> There is no doubt that the original order was more clear.
> 
> In terms of the message content, is it valuable to print(pr_info) this message

I doubt if that print has any value in day-to-day use of RXE.

Thanks
