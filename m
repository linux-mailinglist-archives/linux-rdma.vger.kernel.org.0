Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECE4B8182
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 08:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiBPH1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 02:27:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiBPH1T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 02:27:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445522DD55
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 23:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D0061528
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 07:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE672C004E1;
        Wed, 16 Feb 2022 07:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644996424;
        bh=lUs3h58mpg8zLxv6o71kPUzSTzqRVUI+T786SaJxJvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNMsCBSgN0zvC85n+cxLqr1ZpBweITcbQaiYweEC/pC99rhJ1VIdwHB7bFO/5vtvl
         BUafSYf+UgweVN0nB4XblsPErfO0HntGHWDSp6dFrmREQ5ITZfT9dQPKtGNcv9NhuT
         LJQ08mSbU36qI6FXzs7vdlezahpfajdNGNbWYTlnJWVr6872ECbl7R4p6M2QegxAVY
         tStg36Gh8r49kMzm1VrZJBYq6bZ5Svt+NQ7YdcqKb4wuDnvNDPEnhtIq4umEgykISp
         iQdOcfmu0UPL9nNkA6UCHxmsLX56ADt+0AudhCIEZ/5t+tO7vItswpHUtfoxDAVam0
         Ag3zGq66Dj6OA==
Date:   Wed, 16 Feb 2022 09:26:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Junji Wei <weijunji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
Message-ID: <YgynQGK/xog1ugEd@unreal>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 03:13:11PM +0800, Junji Wei wrote:
> 

<...>

> >> We can't. So do you mean we can implement virtio-rdma only for IB in the future?
> > 
> > It's probably virtio-IB but we need to listen to others.
> 
> Agreed, one problem is that there might be some duplicated works.

Once it will be needed, the code can be refactored. IB and RoCE are
different from user perspective, so combining them into one virtio-rdma
module doesn't give too much advantage.

> 
> > 
> >> 
> >>>> And currently virtio-rdma doesn't have a strong dependency on
> >>>> virtio-net (except for gid and ah stuffs). Is it OK to mix them up?
> >>> 
> >>> There are a bunch of hardware vendors that ship a converged Ethernet
> >>> adapter. It simplifies the management and deployment.
> >> 
> >> Virtio-rdma is not depend on virtio-net, we can bind it to another ethernet device
> >> via mac address in the future. And is it too mass to mix up two different device
> >> in one spec?
> > 
> > So either should be fine, we just need to figure out which one is
> > better. What I meant is to extend the virtio-net to be capable of
> > converged ethernet.
> 
> Got it. One question is whether there will be some cases that user want
> to use virtio-rdma binding to other types of ethernet device such as
> passthroughed net device. In this case, we don’t need a virtio-net
> device actually.

What is the use case for this virtio-rdma? Especially in context of RXE.

Thanks

> 
> Thanks.
> 
