Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F054B8754
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiBPMHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 07:07:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiBPMHI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 07:07:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A6B2503
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 04:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C04861AA9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 12:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170E9C004E1;
        Wed, 16 Feb 2022 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645013214;
        bh=ykPLsLzu0GtvBRAL3pPs3MDhQ7pY/2XqmFLJKqVGZ9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooAxwvHXaBaj4ShT71fsc+PQhJjDEf/yZ+KI5SShbRfPqkImKux5SAFWP7It5jm2d
         BgPlRe6pFfBIHwcjovS6/UUIJ+ykVxgITN5IglNqxiXyazcun0Fe0Ehpc4EE7/DtfV
         nCbTrXyzuTPUxmMS2V5nwHoPQiyKJfhDXWRsCm3S1iN/XgcaDnDA5GG5TpZJlc7qIl
         NtWqERPzfjRsL9Zxf6VsYouxfWGVy7gh1HRm86e23R4xV4vKkieOqs0eddVPrOpYmz
         MvcgDIrjZT2Y11Y4F4hwXX3Pm5C4glpNe76VABiJ/zuFcD+dTxC+KxUi5duwXWAG0z
         gsXzdUkpGJmlg==
Date:   Wed, 16 Feb 2022 14:06:50 +0200
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
Message-ID: <Ygzo2nMVicb3jkAn@unreal>
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
 <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
> 
> > On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
> > 
> > <...>
> > 
> >>> 
> >>> What is the use case for this virtio-rdma? Especially in context of RXE.
> >> 
> >> Hmm... yes, we didn’t find one. In passthrough case we can use RXE directly.
> > 
> > It doesn't sound like a good sales pitch.
> 
> Maybe I misunderstanded what you mean. We mean we didn’t find a user case 
> for virtio-rdma with passthrough net device. Do you want to know the user
> case for our virtio-rdma(RoCE) proposal?

Yes, please.

> 
> Thanks.
> 
