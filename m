Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1C54C820
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiFOMH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbiFOMHz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 08:07:55 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB71CFDC
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 05:07:53 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 5F650B00213; Wed, 15 Jun 2022 14:07:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1655294869; bh=NGM6j1UwVvID+seSPP+2pQj5wYV+JsuB6apoOeMIEHE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=e/uy1zGFCjOBAQbEvqGHhIG4me6QwS9H+hZifeB5cUbAw7CXMAwahNjH1VJD6wZ2D
         ZfwJ/gQiapE1DT1b50B7zEB8JEyU0Op2yPf2h8EtOOtrsW0yiMujdcMRZYISQkzuuf
         EIBx8lQT7Mf5LDQTCtEHm/Qr9FD/ZsBx1V3GBrzMR8E/fWroRY3OAX4KSUiletiRCg
         h6ZEJXSLgYuBPqeeZDlx0zmalrVNfkSjzNFWNbk6PSvuM3gFEvhwdD6wDpaUlzTaQH
         28ZYSEK8c1lMRxTii5tx0GNUkkXzEBHMoyN8IskbBODYEtf2q3o7bIJ/a6j+0aBi6c
         ATdVwfCxwgDyg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 5DF81B0017C;
        Wed, 15 Jun 2022 14:07:49 +0200 (CEST)
Date:   Wed, 15 Jun 2022 14:07:49 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Meng Wang <meng@hcdatainc.com>
cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Fail to establish RoCE connectivity after restarting network
 service
In-Reply-To: <BYAPR10MB2456DF1114106F49AB1A1A42CBAB9@BYAPR10MB2456.namprd10.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206151358300.460766@gentwo.de>
References: <BYAPR10MB2456DF1114106F49AB1A1A42CBAB9@BYAPR10MB2456.namprd10.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 13 Jun 2022, Meng Wang wrote:

> We found a RoCE connectivity problem in such environment:
> * two servers with ConnectX4 NICs (model: MCX414A-BCAT)

Thats pretty early ROCE hardware.

> * servers are connected to one SX6036 switch where flow control is enabled

An Ethernet to IB gateway. And we are doing ROCE???

So you are using the Ethernet ports on the SX6036? These tests are not
Infiniband but purely Ethernet?

> rping is used to test RoCE links connectivity between servers. At
> initial, they can establish RoCE connections (rping to each other
> works). However, after we did ifdown/ifup the interfaces, restart
> network services, or rebooted the two servers, the connectivity between
> the two servers may become abnormal: i.e. sometimes the active side was
> stuck at "rdma_connect" without any CM event generated later; sometimes,
> the connection can be established, but the sender side failed to send
> message to the receiver (with error 12: IBV_WC_RETRY_EXC_ERR). If we
> repeat ifdown/up the affected interface or restart the network service
> for several rounds, the connectivity between the two servers can
> eventually become normal. We repeated this test on various linux
> distributions, OFED drivers and kernel versions as listed above, and
> found that this problem can be reproduced on all these setups. TCP/IP
> connections are always working as expected. We are not sure whether it
> is a bug or a configuration problem. Is there any method to troubleshoot
> this problem? Any suggestion is appreciated.

The rping connections are using the RC logic with special MAD packet
handshakes via QP1 (even under ROCE). IP is based on UD packets and thus does
not use the MAD handshares to establish RC based connections. This points
to an issue in the ROCE MAD handshake logic to establish an RC connection
in the kernel.

The MAD packets on ROCE are encapsulated in UDP.


