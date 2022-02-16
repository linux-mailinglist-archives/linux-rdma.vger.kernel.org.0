Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3A4B84D8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 10:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiBPJtF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 04:49:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiBPJtE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 04:49:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723D2B4057
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 01:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2E0616FE
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 09:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEEEC004E1;
        Wed, 16 Feb 2022 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645004931;
        bh=0fpXWOXW+Xu30fP/wjgNguk7DxwplXzyGO5jDqEW9uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntH7ADYUDh8NChRTbefif4DPOwhGP6CBVZsi7WM/ur4ZALBgY20MmcdYTqM/qV2xP
         xazLJBL1NjNXVQ7FsEQHt3JNq6uMGChhHPZ4LUoorTQmyvLA7a3JRb9kJYJqGmVdtu
         XZkeJRQb2EL7zls2qi2f0nZ9gnPy1ABpX1EhAPKA6rA69ZIdKKDGHwBdnzIcNBOhAd
         nCGREvQqOCWjc8lPgmM6Lcl3CR5gPZfUq4bAGRMWrN/l/aiHbitKJNgkyeSRkyUVLC
         1Zgtm4HJSLt1fSxq/G2kAfSbQ46D5y4RoIlhLdri5hPQBt0anjZOQ+z3kIfsfKbpvq
         v1r0Ii0CcK1tg==
Date:   Wed, 16 Feb 2022 11:48:47 +0200
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
Message-ID: <YgzIfyx7WyGb39mV@unreal>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:

<...>

> > 
> > What is the use case for this virtio-rdma? Especially in context of RXE.
> 
> Hmm... yes, we didn’t find one. In passthrough case we can use RXE directly.

It doesn't sound like a good sales pitch.

> 
> Thanks.
