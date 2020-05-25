Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22C1E0E77
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390576AbgEYMa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 08:30:27 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:59429 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390492AbgEYMa1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 08:30:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 868A2C5A
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 08:30:26 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute7.internal (MEProxy); Mon, 25 May 2020 08:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=znu.io; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=ZRX/5XMLRNxG9ZpvC5PnBfP8FZSYnSZDMan/m4NAZ3A=; b=MHtZj+86
        40jvLysz5r0Kxab9WYyTy6Q0KVPSwgwxtUKFEf0fPOj27aWMC4z4218m/4+baoyr
        bshjcxCSOrXNTtUmkBZgqi3KUlQLIh8OfRaffzS+WPzTHHE22668KmWFEK907d5n
        FeJFgpJAO22ZagvljnVMjRHS0PwrrkRubUuYTyfnH1G4WalEo/TjTyyJYrSBpWqm
        xEtXJ0kT+hQCXmxQK9TkCJrFEGfJsm2gEkknAC52KH5elngqDHu6Ow9VknRSVsnd
        MjiArPXBDhdv+VjMhKMA2YB7xBm6yGcoGgKgojmVgS+EHt0T68nhB/P4BK6uOwb9
        +wlpw9Pjv5A2cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ZRX/5XMLRNxG9ZpvC5PnBfP8FZSYn
        SZDMan/m4NAZ3A=; b=CUSG4sNge13BEkO5IDoc4RwXHJ0F2XRSsxsN4aswCH3aR
        tMsZ2zo+PckoB8tawQ0T7cjkGr01051gP6GHPu4nr/5rM+F/a6uQHhIOTL0RDb5w
        BfPll0ydoAJ7sfNwITwXscI8fxumwo6/7Xl0dz2PKtGslDK/8IpE8M3mS62ZexrY
        P3mCpW29trNVYHXCgHbMZtoHxshJ+C83hMCbexqHIF7+25I/sbNLOp8WZCeJNzUi
        O8LsalrH+FLCmOILaUQpDdB8w3kGPN74ae5+A+mh1cMNbBq/XAzWWI0RDIUGegn8
        MleI8DrBOJ0Kr9clA97KeW+NGkB2rKFaWxaNF/BdA==
X-ME-Sender: <xms:YrrLXsM_X6RRGhzeJ_OBHZxwBOow2gvj8x-xxi6IrI6Fpdqt_QKebg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfffgrvhhiugcukggrrhiihigtkhhifdcuoegurghvvgesiihn
    uhdrihhoqeenucggtffrrghtthgvrhhnpeetheehkeeuueefieelhefgudetleelfeegke
    ejgfetffdvtdeukeefvdeluefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegurghvvgesiihnuhdrihho
X-ME-Proxy: <xmx:YrrLXi90kbnC1V77AptKUHD5lh_ZelEh2w_zgMesYg6DPgLIWg0UMQ>
    <xmx:YrrLXjQKBYbgdiM2GAH05T18YQYh9q8845AkSrbAh6dqGIVoIJsWWA>
    <xmx:YrrLXkt8I1zVx9Y5KdMyW76TsNFMmBsjg7qi6BgWxiJaWT2A0wylMQ>
    <xmx:YrrLXr_Ai46slzIcyZjwOTxif6M4saZOJREwplEB-kSGvUYnKpUiIA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E95F6E00B0; Mon, 25 May 2020 08:30:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-488-g9249dd4-fm-20200522.001-g9249dd48
Mime-Version: 1.0
Message-Id: <38bdd48f-d1ca-4bce-9c9c-30925b158664@www.fastmail.com>
Date:   Mon, 25 May 2020 08:30:05 -0400
From:   "David Zarzycki" <dave@znu.io>
To:     linux-rdma@vger.kernel.org
Subject: opensm and virt_enabled?
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I'm trying to track how to enable "virt_enabled 2" in opensm. Various Mellanox docs refer to this change in opensm behavior in order to support their socket direct cards. That being said, when I search the opensm source and source history, I cannot find any reference this flag ever existing. What am I missing?

For reference, I've connected two ConnectX-6 cards point to point. One of the cards is "socket direct" but the aux card stays "down" despite the link being up (see below).

Thanks for any help,
Dave


CA 'ibp2s0f0'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609810
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Active
                Physical state: LinkUp
                Rate: 100
                Base lid: 2
                LMC: 0
                SM lid: 1
                Capability mask: 0x2659e848
                Port GUID: 0x0c42a10300609810
                Link layer: InfiniBand
CA 'ibp3s0f0'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609814
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Down
                Physical state: LinkUp
                Rate: 100
                Base lid: 65535
                LMC: 0
                SM lid: 1
                Capability mask: 0x2649e848
                Port GUID: 0x0c42a10300609814
                Link layer: InfiniBand
CA 'ibp2s0f1'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609811
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Down
                Physical state: Disabled
                Rate: 10
                Base lid: 65535
                LMC: 0
                SM lid: 0
                Capability mask: 0x2659e848
                Port GUID: 0x0c42a10300609811
                Link layer: InfiniBand
CA 'ibp3s0f1'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609815
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Down
                Physical state: Disabled
                Rate: 10
                Base lid: 65535
                LMC: 0
                SM lid: 0
                Capability mask: 0x2649e848
                Port GUID: 0x0c42a10300609815
                Link layer: InfiniBand
