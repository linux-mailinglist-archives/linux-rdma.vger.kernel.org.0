Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5C5FAFA8
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Oct 2022 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJKJtx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Oct 2022 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKJtv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Oct 2022 05:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A6BC0E
        for <linux-rdma@vger.kernel.org>; Tue, 11 Oct 2022 02:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665F86116D
        for <linux-rdma@vger.kernel.org>; Tue, 11 Oct 2022 09:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6CEC433D6;
        Tue, 11 Oct 2022 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665481781;
        bh=qDxI6ToA8YiVvrU6hFF9ZiwO2zAQPnHGnkhgAJxBgs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ai6utFsek49St9Gs5GzMWisb4PNn9PO3lC664j3l7+m4+YelAfky0M4f6nn//40tz
         T1Q8aT6NiVS2BJPXnC8lXhr2dNNsxl3lAXqP8cfM2X+rNusU+8OHdEH+6PVhtaUDRJ
         AKB9RKBXQXIXFX9DubWQGJFTK1UYgLH7BWMRw206xyCqu9sChVOuiiUhJeB0i9rpTh
         zhTGA0BKo4ZW/P1fxapYVwy/YP5h4TgDHCrxQX3+da5kEHJ4CXW7B2xk46VYeP3LsZ
         z4orqPbu45r9f9LAVD+OtjLLkrR9w08SZoWY7WEfTxpMOu+LqTWRr27+oxb7uCIlmH
         q4Zpux+/uzFVA==
Date:   Tue, 11 Oct 2022 12:49:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <Y0U8McWLRJRTKqQ/@unreal>
References: <YzPkAGs60Kk4QCck@unreal>
 <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <1c6c286460ac6450d1ae7a93efd4c062@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c6c286460ac6450d1ae7a93efd4c062@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 09, 2022 at 10:20:53AM +0000, yanjun.zhu@linux.dev wrote:
> September 28, 2022 2:04 PM, "Leon Romanovsky" <leon@kernel.org> wrote:
> 
> > On Tue, Sep 27, 2022 at 06:58:50PM +0800, Yanjun Zhu wrote:
> > 
> >> 在 2022/9/27 18:34, Leon Romanovsky 写道:
> >> On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
> >>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>> 
> >>> When the net devices are moved to another net namespace, the command
> >>> "rdma link" should not dispaly the rdma link about this net device.
> >>> 
> >>> For example, when the net device eno12399 is moved to net namespace net0
> >>> from init_net, the rdma link of eno12399 should not display in init_net.
> >>> 
> >>> Before this change:
> >>> 
> >>> Init_net:
> >>> 
> >>> link roceo12399/1 state DOWN physical_state DISABLED <---should not display
> >>> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> >>> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> >>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> >>> 
> >>> net0:
> >>> 
> >>> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> >>> link roceo12409/1 state DOWN physical_state DISABLED <---should not display
> >>> link rocep202s0f0/1 state DOWN physical_state DISABLED <---should not display
> >>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP <---should not display
> >>> 
> >>> After this change
> >>> 
> >>> Init_net:
> >>> 
> >>> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> >>> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> >>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> >>> 
> >>> net0:
> >>> 
> >>> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> >>> 
> >>> Fixes: da990ab40a92 ("rdma: Add link object")
> >>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>> ---
> >>> rdma/link.c | 3 +++
> >>> 1 file changed, 3 insertions(+)
> >>> 
> >>> diff --git a/rdma/link.c b/rdma/link.c
> >>> index bf24b849..449a7636 100644
> >>> --- a/rdma/link.c
> >>> +++ b/rdma/link.c
> >>> @@ -238,6 +238,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
> >>> return MNL_CB_ERROR;
> >>> }
> >>> + if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] || !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])
> >>> + return MNL_CB_OK;
> >>> +
> >> Regarding your question where it should go in addition to RDMA, the answer
> >> is netdev ML. The rdmatool is part of iproute2 and the relevant maintainers
> >> should be CCed.
> >> Thanks. I will also send it to netdev ML and CC the maintainers.
> >> 
> >> Regarding the change, I don't think that it is right. User space tool is
> >> a simple viewer of data returned from the kernel. It is not a mistake to
> >> return device without netdev.
> >> 
> >> Normally a rdma link based on RoCEv2 should be with a NIC. This NIC device
> >> 
> >> will send/recv udp packets. With mellanox/intel NIC device, this net device
> >> also
> >> 
> >> do more work than sending/receiving packets.
> >> 
> >> From this perspective, a rdma link is dependent on a net device.
> >> 
> >> In this problem, net device is moved to another net namespace. So it can not
> >> be
> >> 
> >> obtained.  And this rdma link can also not work in this net namespace.
> >> 
> >> So this rdma link should not appear in this net namespace. Or else, it would
> >> confuse
> >> 
> >> the user.
> >> 
> >> In fact, net namespace is a concept in tcp/ip stack. And it does not exist
> >> in rdma stack.
> > 
> > RDMA has two different net namespace mode: shared and exclusive.
> > 
> > In shared mode, the IB devices are shared across all net namespaces and
> > "moving" net device into different namespace just "hides" it, but don't
> > disconnect.
> 
> Hi, Leon
> 
> About RDMA shared and exclusive mode, I am confusing about this scenario:
> 
> In shared mode, ib device A is in net namespace A1 while netdev device B is in net namespace B1.
> IB device A is dependent on netdev device B. How to make tests in the above scenario?
> Both rping and perftest need a IP address to work. But now ip address is in net namespace B1 while
> ib device A is in net namespace A1.
> 
> In the product environment, does the above scenario exist?

Yes and no at the same time.

Yes:
The whole net namespace support is needed for containers. In old
versions of rdma-core, libibverbs relied on /sys/class/infiniband/
structure. This is why we need "shared" mode, where IB exists without
relation to netdev.

No:
Like you said, it won't work for RoCE and iWARP.

Thanks

> 
> Thanks and Regards,
> Zhu Yanjun
> 
> > 
> > See comments around various usages of ib_devices_shared_netns variable.
> > 
> > Thanks
