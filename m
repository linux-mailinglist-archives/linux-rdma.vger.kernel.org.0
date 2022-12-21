Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C01652F14
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Dec 2022 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiLUKAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Dec 2022 05:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiLUKAC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Dec 2022 05:00:02 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE755220E0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Dec 2022 01:57:45 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5419A240101
        for <linux-rdma@vger.kernel.org>; Wed, 21 Dec 2022 10:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1671616664; bh=0SE2pIFPu1kPwESlbR+h5d7mIARIWSvOnvEjifJ0GbY=;
        h=Date:From:To:Cc:Subject:From;
        b=TIqDDGS3lIVOQVkAExmx37TcTDP328eW21gW5XC72f7pCHT4cNyDIFoKVvU6FfN8s
         Uq0supD1kOMT/vR5KVol51TgSe+62zW5qYoXsakOB5Sh5qHx4G2DURxfeHYwdJfLWa
         eZKobbNCfGvox5b75QGxx7IgPHu3C/6jlwcrf79tze39ZchELYHN2/F06dmwhUSFgP
         EJtjyGlqsNpIja0WjDvTfh4dLilFfISefEffAVnMIKZTeCtbHgtO3Z6i+/ozkGU7CV
         fDy/nRvDCNX5hndC5ZzWby+CWJvr6hQmWgU0yo/zBuGGomwJGcGBu7izJ+wJadhXYE
         T0Pu5/nPCbJEg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NcTQH2rPtz6tnY;
        Wed, 21 Dec 2022 10:57:43 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Dec 2022 09:57:43 +0000
From:   danil.kipnis@posteo.net
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        linux-block@vger.kernel.org, Aleksei Marov <alexv.marov@gmail.com>,
        Jinpu Wang <jinpu.wang@ionos.com>, leonro@nvidia.com,
        jgg@nvidia.com
Subject: Re: [RFC] Reliable Multicast on top of RTRS
In-Reply-To: <CAJpMwyh-cihwNyMyTFE-f2HQqOnLydNB+TiGcq5UTMkgwU0yNA@mail.gmail.com>
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org>
 <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
 <CAHg0Huw35m_WiwFqcTEHpCz94=JhaKZdEuV-F=aetQ_SEQgauA@mail.gmail.com>
 <CAJpMwyh-cihwNyMyTFE-f2HQqOnLydNB+TiGcq5UTMkgwU0yNA@mail.gmail.com>
Message-ID: <fff44726895096cc64079dae69a66f9e@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Haris,

Thanks for pushing RMR forward! Lutz Pogrell and Alexei and you did a 
huge amount of work. I'm honestly convinced RMR will be a very useful 
extension for the kernel. It is currently used with a block client and a 
block server. Haris already mentioned rbd and dm-thin as a different 
potential pair of users. I'm still of the opinion that sched and mm 
could be the most interesting users of rmr.

Looking forward to the github link,
Cheers,
Danil.

P.S. BTW, where is my beloved libtbl?!


On 21.11.2022 14:57, Haris Iqbal wrote:
> Hey there,
> 
> We've got a prototype version working in-house. We've also implemented
> a block device client and server. Another client and server could
> probably be rbd and dm-thin. Will update as soon as we have a github
> link.
> 
> Some technical details
> 
> - Ability to perform sync across storage nodes without the involvement
> of the client.
> 
> - This helps performing sync, extending/adding legs/members without
> the help of the client.
> 
> Candidate users
> 
> - We've implemented a stand-alone replicating block device. The client
> is similar to the rnbd-clt and our own corresponding "store"/server
> does linear mapping on the server side.
> 
> - rbd could be a client of rmr-clt. The rmr-srv (store) would talk to
> lvm. rbd would provide the block device (over multiple objects) on the
> client side. Lvm would function as the store on the server side. One
> object would be stored on one dm-thin volume. rmr would provide for
> the replication in the network.
> 
> Setups: RMR vs MD-RAID vs DRBD
> 
> - Active-active
> 
> - RMR as means of replication over network differs from the md-raid
> configuration because sync traffic goes directly between servers. The
> difference to the drbd setup is that the IO traffic goes to both legs
> in a single hop.
> 
> How does RMR solve the activity log issue
> 
> - Synchronous replication; much like Protocol C of DRBD.
> 
> - RMR tracks all successful queue_depth (max number of IOs that can be
> inflight at any moment) worth of last IOs on each storage node.
> 
> Best,
> Haris
> 
> Signed-off: alexv.marov@gmail.com
> Reviewed-by: danil.kipnis@posteo.net
> 
> On Sun, Nov 22, 2020 at 5:20 PM Danil Kipnis
> <danil.kipnis@cloud.ionos.com> wrote:
>> 
>> On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> 
>> wrote:
>> >
>> > On 2020-09-04 04:35, Danil Kipnis wrote:
>> > > On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> > >> How will it be guaranteed that the resulting software does
>> > >> not suffer from the problems that have been solved by the introduction
>> > >> of the DRBD activity log
>> > >> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
>> > >
>> > > The above would require some kind of activity log also, I'm afraid.
>> >
>> > How about collaborating with the DRBD team? My concern is that otherwise
>> > we will end up with two drivers in the kernel that implement block device
>> > replication between servers connected over a network.
>> 
>> Will take a closer look at drbd,
>> 
>> Thank you,
>> Danil.
>> 
>> >
>> > Thanks,
>> >
>> > Bart.
