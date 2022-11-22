Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D046332CA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 03:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiKVCNR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Nov 2022 21:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiKVCNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Nov 2022 21:13:16 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687061759
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 18:13:15 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h24so8495896qta.9
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 18:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIRhDVWiab3bjDPVgRSMneOqOqqdAB0Fj+0SdzxoeH4=;
        b=K9/WYl+a/zA/3Bl3JMxOy+5d3Ranm4/09Q5QOUYmPL+W0lXz42G8zpyJNGRzMOzdXS
         E4WSrSA1DN2dJD0s+V/3FSjJdyPX9trb4FQbWFaSdL5kQiORd2yX+o3UhWfy0/zonEuF
         QIgy9V6AC47+aRbaCOfW7turbl5LERJRpytgieuUfzmfLUlgA30D8lb/5h6OoezM5MKX
         tmHHi5lZ/2dlKzpE0feihA0xoQsMsqiQDQLK9TVvcviwdLfJR0dKJdiHWZr95ilpWvEI
         /N+Q57aJbsJgU2APNZjNBI3/wphN+7jhTHfREzufA6PWz7pbB98tic7AEiqlJgledR22
         v8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIRhDVWiab3bjDPVgRSMneOqOqqdAB0Fj+0SdzxoeH4=;
        b=EoYeVbKM02n/wLw8wirprpp7X0T6dIhu1pPzINT0IYmUrqfpDLvggx17zQT4XYFrpu
         ml62cN7C7pjraA2+vYAsWTXUjJzFujOaO/CoE2wECK4XXDzPYxomUZvY4/+MNU24CAdQ
         5xFoQhFNiByAZBOrOZj2ZNVzvpcmFgIyZd/XgDzJ4ihtoFIasWNq4UsSVu8GzPDlRUVV
         l5KMnhc9/ohZZ4ikgaaGbrDJ0g2Mj0Pcq8Io3WxCWkkRFXCuFlXpQ232IPhU5Vw9ykiq
         tEfuqlAn41Qm4AlUgHIhEV5YRQPVgIbJWn5B/Lc+SndhDZ/vOs8mY2n6zLEjYgFX4xIF
         mAgg==
X-Gm-Message-State: ANoB5ploERTE0uSxpxVlB+bvrH5I+AtAo7W3iXb8yd1KgQRC1A7AbMgQ
        AmPOM+3HyP+WHFDWtv1SjOZgB0I+fUPkWQ==
X-Google-Smtp-Source: AA0mqf7ZUnS7zXBNzp66ZG4R9u/uDVqaGTLIoiFUGabn7Ga5y6kCmFkWwhn/fiyH+teiO3jguTs+zg==
X-Received: by 2002:a05:622a:5c8e:b0:3a5:5c9e:d453 with SMTP id ge14-20020a05622a5c8e00b003a55c9ed453mr20810640qtb.403.1669083194399;
        Mon, 21 Nov 2022 18:13:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id k7-20020ac84787000000b0039cc7ebf46bsm7463590qtq.93.2022.11.21.18.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:13:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxIme-009YhX-R6;
        Mon, 21 Nov 2022 22:13:12 -0400
Date:   Mon, 21 Nov 2022 22:13:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>,
        Leon Romanovsky <leon@kernel.org>, chenzhongjin@huawei.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [syzbot] unregister_netdevice: waiting for DEV to become free (7)
Message-ID: <Y3wwOPmH1WoRj0Uo@ziepe.ca>
References: <00000000000060c7e305edbd296a@google.com>
 <CACT4Y+a=HbyJE3A_SnKm3Be-kcQytxXXF89gZ_cN1gwoAW-Zgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a=HbyJE3A_SnKm3Be-kcQytxXXF89gZ_cN1gwoAW-Zgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 18, 2022 at 02:28:53PM +0100, Dmitry Vyukov wrote:
> On Fri, 18 Nov 2022 at 12:39, syzbot
> <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    9c8774e629a1 net: eql: Use kzalloc instead of kmalloc/memset
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17bf6cc8f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9eb259db6b1893cf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136d592f00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1193ae64f00000
> >
> > Bisection is inconclusive: the issue happens on the oldest tested release.
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167c33a2f00000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=157c33a2f00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=117c33a2f00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com
> >
> > iwpm_register_pid: Unable to send a nlmsg (client = 2)
> > infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98
> > unregister_netdevice: waiting for vlan0 to become free. Usage count = 2
> 
> +RDMA maintainers
> 
> There are 4 reproducers and all contain:
> 
> r0 = socket$nl_rdma(0x10, 0x3, 0x14)
> sendmsg$RDMA_NLDEV_CMD_NEWLINK(...)
> 
> Also the preceding print looks related (a bug in the error handling
> path there?):
> 
> infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98

I'm pretty sure it is an rxe bug

ib_device_set_netdev() will hold the netdev until the caller destroys
the ib_device

rxe calls it during rxe_register_device() because the user asked for a
stacked ib_device on top of the netdev

Presumably rxe needs to have a notifier to also self destroy the rxe
device if the underlying net device is to be destroyed?

Can someone from rxe check into this?

Jason
