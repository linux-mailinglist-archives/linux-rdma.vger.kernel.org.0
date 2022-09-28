Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2625E5ED477
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Sep 2022 08:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiI1GFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Sep 2022 02:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiI1GE6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Sep 2022 02:04:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E65F10C
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 23:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0C0ECE1C63
        for <linux-rdma@vger.kernel.org>; Wed, 28 Sep 2022 06:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD1BC433D6;
        Wed, 28 Sep 2022 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664345092;
        bh=LdJL8EKXQcxlIpTxcJ0cx1Xcf1GfJSwTBRSXGqdHIuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwKVIKMubIch6k/eE5FSfwwffIwHXZM3MBuBIRPRtL0PKehZmQIi2sZRqJDFwUp1n
         /gIYrclADgNw9FxjEMic3LkpeMl08gk+3QD/z6F/HjEMmTm+k4f64l51wwerV+ye6k
         0L+Vth5z2tNN6rbS2m2RbQmKx0ENu0s3YelUmHclKWLvFNpaIZLS6WL0OuwN/b+RD6
         hi2PWyhZVrGxnbtpDB+BgJJUCYgYofMhSYVxb+wUwx7+GrbHsAtxtSAuxLAjTTuM4R
         IW8sZBig/qoIgR0aFf+ybbM5+Xw1/En/g2+jjaD1tFj9c6nzMNkckRqYZRWRiEfqyf
         7XSRa2fmyl9hQ==
Date:   Wed, 28 Sep 2022 09:04:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <YzPkAGs60Kk4QCck@unreal>
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 06:58:50PM +0800, Yanjun Zhu wrote:
> 
> 在 2022/9/27 18:34, Leon Romanovsky 写道:
> > On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > When the net devices are moved to another net namespace, the command
> > > "rdma link" should not dispaly the rdma link about this net device.
> > > 
> > > For example, when the net device eno12399 is moved to net namespace net0
> > > from init_net, the rdma link of eno12399 should not display in init_net.
> > > 
> > > Before this change:
> > > 
> > > Init_net:
> > > 
> > > link roceo12399/1 state DOWN physical_state DISABLED  <---should not display
> > > link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> > > link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> > > link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> > > 
> > > net0:
> > > 
> > > link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> > > link roceo12409/1 state DOWN physical_state DISABLED <---should not display
> > > link rocep202s0f0/1 state DOWN physical_state DISABLED <---should not display
> > > link rocep202s0f1/1 state ACTIVE physical_state LINK_UP <---should not display
> > > 
> > > After this change
> > > 
> > > Init_net:
> > > 
> > > link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> > > link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> > > link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> > > 
> > > net0:
> > > 
> > > link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> > > 
> > > Fixes: da990ab40a92 ("rdma: Add link object")
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   rdma/link.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/rdma/link.c b/rdma/link.c
> > > index bf24b849..449a7636 100644
> > > --- a/rdma/link.c
> > > +++ b/rdma/link.c
> > > @@ -238,6 +238,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
> > >   		return MNL_CB_ERROR;
> > >   	}
> > > +	if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] || !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])
> > > +		return MNL_CB_OK;
> > > +
> > Regarding your question where it should go in addition to RDMA, the answer
> > is netdev ML. The rdmatool is part of iproute2 and the relevant maintainers
> > should be CCed.
> Thanks. I will also send it to netdev ML and CC the maintainers.
> > 
> > Regarding the change, I don't think that it is right. User space tool is
> > a simple viewer of data returned from the kernel. It is not a mistake to
> > return device without netdev.
> 
> Normally a rdma link based on RoCEv2 should be with a NIC. This NIC device
> 
> will send/recv udp packets. With mellanox/intel NIC device, this net device
> also
> 
> do more work than sending/receiving packets.
> 
> From this perspective, a rdma link is dependent on a net device.
> 
> In this problem, net device is moved to another net namespace. So it can not
> be
> 
> obtained.  And this rdma link can also not work in this net namespace.
> 
> So this rdma link should not appear in this net namespace. Or else, it would
> confuse
> 
> the user.
> 
> In fact, net namespace is a concept in tcp/ip stack. And it does not exist
> in rdma stack.

RDMA has two different net namespace mode: shared and exclusive.

In shared mode, the IB devices are shared across all net namespaces and
"moving" net device into different namespace just "hides" it, but don't
disconnect.

See comments around various usages of ib_devices_shared_netns variable.

Thanks
