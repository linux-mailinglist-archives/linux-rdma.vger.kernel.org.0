Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8291D1E0F1A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403784AbgEYNJO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 09:09:14 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53957 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388757AbgEYNJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 09:09:13 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5A568CB0;
        Mon, 25 May 2020 09:09:12 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute7.internal (MEProxy); Mon, 25 May 2020 09:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=znu.io; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=34Dvjx1N6yLXISqrs7B9XCGeqLIuc2A
        oLH794rYeSFQ=; b=HvQFhavCEp1cqBh84htkKpKXDYfiTTAfodD2BzJE7QWdHUo
        nb3jCrJKDw7vjqXFuhvUC2/2/MPE9/7JrhZoqvHefXX4KpVQyeQUSJQdFOPxtXb9
        5Fy87PKw8Rs0Q6ds08sMKAnazhH+omYcGWA5cTSd6+s5OK74RF1/LKntUkcTDAoF
        hLggAXI6wleS277FeuehWTajLxp3Y9fI0uzulM+3ZfSzBFRq0P090sQUeD9HWQjX
        ISrOc5LEYXdRemZoxCIb6vUxSXVGh8jknzr0JvPCkB3AeFVEmOC/Ysf7xpDxytos
        E4DmHv8AcV/WgTtd1Dmt1NIqSeU4DhlfHXgA63A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=34Dvjx
        1N6yLXISqrs7B9XCGeqLIuc2AoLH794rYeSFQ=; b=JEh2bWZgqroDEVDgq9l2r3
        Zgc85Gs43hxHGK1gQIV2Hu00qjwc9hORQMJ+zxd/1BG3wBmKwSkV4S7TT5MSg6ju
        ssIYvLHOfNqztGKHHJRqAJ7C0SD3l7zkyvXLypF+nleGaP78E51wjnXokJm1hBsW
        j9TzLYAazas01cNxIjOUZ3UBapL9d4+UYha9/uIY/ExYHHqMMGiq6KpDLmYdfV+R
        QhOaPCNPCQra0+Tmyn0M+E6fwXqbkvLlzqgCppMh9tvqwuOWmagxzVFvn98WS6rF
        x3B/ULRIfH5if3uVBTxNJjtFTvb3qE9uICcYAB6qC63UadZQNjX1c1kR6PaKl3hw
        ==
X-ME-Sender: <xms:d8PLXm8nqxvvw59v-XaI60vQ0k5b7CUIQJKcPBEnqjO7JSWCpmPe5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdffrghv
    ihguucgkrghriiihtghkihdfuceouggrvhgvseiinhhurdhioheqnecuggftrfgrthhtvg
    hrnhepheekhfeltddtffefvefgueeuvefgveeiudefvdduheehtdfggfekgfeuveefuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvh
    gvseiinhhurdhioh
X-ME-Proxy: <xmx:d8PLXmugl3G7aKQcRBLWhfzKV-yAGYPuSe-X_HrL5BARxC8iWHFO8A>
    <xmx:d8PLXsDHszvI9ETBwqqsuziKVYL9l36jkqAvO59glKNxQmar-WQOrw>
    <xmx:d8PLXuf45do-GH--YYb9SyH1BZ8dNCJaO3fzXi36RtCSBQdJ3d54Cg>
    <xmx:d8PLXhZx6Q68KcjaLyvfmwDFIDCNwkZ8aeluEWHSJ-7I25EmMEaD-w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E5DEE00B0; Mon, 25 May 2020 09:09:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-488-g9249dd4-fm-20200522.001-g9249dd48
Mime-Version: 1.0
Message-Id: <ad6e4e63-9328-4341-8148-d6831316a855@www.fastmail.com>
In-Reply-To: <DBAPR05MB7093D9F64237F31DB615DA20CEB30@DBAPR05MB7093.eurprd05.prod.outlook.com>
References: <38bdd48f-d1ca-4bce-9c9c-30925b158664@www.fastmail.com>
 <DBAPR05MB7093D9F64237F31DB615DA20CEB30@DBAPR05MB7093.eurprd05.prod.outlook.com>
Date:   Mon, 25 May 2020 09:08:51 -0400
From:   "David Zarzycki" <dave@znu.io>
To:     "Vladimir Koushnir" <vladimirk@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: opensm and virt_enabled?
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Vladimir,

Thanks. I found it. Is this opensm closed source? I apparently wrongly assumed that this opensm would be in the source drop of MLNX OFED.

Dave

On Mon, May 25, 2020, at 8:41 AM, Vladimir Koushnir wrote:
> Hello,
> 
> "virt_enabled 2" is supported by MLNX subnet manager that is available 
> via UFM/MLNX OFED/MLNX Infiniband switch OS (MLNX OS).
> 
> Regards,
> Vladimir
> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org 
> <linux-rdma-owner@vger.kernel.org> On Behalf Of David Zarzycki
> Sent: Monday, May 25, 2020 3:30 PM
> To: linux-rdma@vger.kernel.org
> Subject: opensm and virt_enabled?
> 
> Hello,
> 
> I'm trying to track how to enable "virt_enabled 2" in opensm. Various 
> Mellanox docs refer to this change in opensm behavior in order to 
> support their socket direct cards. That being said, when I search the 
> opensm source and source history, I cannot find any reference this flag 
> ever existing. What am I missing?
> 
> For reference, I've connected two ConnectX-6 cards point to point. One 
> of the cards is "socket direct" but the aux card stays "down" despite 
> the link being up (see below).
> 
> Thanks for any help,
> Dave
> 
> 
> CA 'ibp2s0f0'
>         CA type: MT4123
>         Number of ports: 1
>         Firmware version: 20.27.2008
>         Hardware version: 0
>         Node GUID: 0x0c42a10300609810
>         System image GUID: 0x0c42a10300609810
>         Port 1:
>                 State: Active
>                 Physical state: LinkUp
>                 Rate: 100
>                 Base lid: 2
>                 LMC: 0
>                 SM lid: 1
>                 Capability mask: 0x2659e848
>                 Port GUID: 0x0c42a10300609810
>                 Link layer: InfiniBand
> CA 'ibp3s0f0'
>         CA type: MT4123
>         Number of ports: 1
>         Firmware version: 20.27.2008
>         Hardware version: 0
>         Node GUID: 0x0c42a10300609814
>         System image GUID: 0x0c42a10300609810
>         Port 1:
>                 State: Down
>                 Physical state: LinkUp
>                 Rate: 100
>                 Base lid: 65535
>                 LMC: 0
>                 SM lid: 1
>                 Capability mask: 0x2649e848
>                 Port GUID: 0x0c42a10300609814
>                 Link layer: InfiniBand
> CA 'ibp2s0f1'
>         CA type: MT4123
>         Number of ports: 1
>         Firmware version: 20.27.2008
>         Hardware version: 0
>         Node GUID: 0x0c42a10300609811
>         System image GUID: 0x0c42a10300609810
>         Port 1:
>                 State: Down
>                 Physical state: Disabled
>                 Rate: 10
>                 Base lid: 65535
>                 LMC: 0
>                 SM lid: 0
>                 Capability mask: 0x2659e848
>                 Port GUID: 0x0c42a10300609811
>                 Link layer: InfiniBand
> CA 'ibp3s0f1'
>         CA type: MT4123
>         Number of ports: 1
>         Firmware version: 20.27.2008
>         Hardware version: 0
>         Node GUID: 0x0c42a10300609815
>         System image GUID: 0x0c42a10300609810
>         Port 1:
>                 State: Down
>                 Physical state: Disabled
>                 Rate: 10
>                 Base lid: 65535
>                 LMC: 0
>                 SM lid: 0
>                 Capability mask: 0x2649e848
>                 Port GUID: 0x0c42a10300609815
>                 Link layer: InfiniBand
>
