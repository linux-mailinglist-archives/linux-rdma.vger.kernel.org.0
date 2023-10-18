Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98F7CD338
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 06:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjJREqW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 00:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJREqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 00:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B659E7
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 21:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697604329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogrF28UkLl6HzwEXfjyPThU0/eShcHDH0ygvwFNYWI4=;
        b=iB4ZAoCZD0mVeihJF1UkJK2egsNZ1A2LGjImXmnGAb08Vkd2kU7a4irAGuG8/8imVnnlxf
        UpTMOOCion9Oq0hE71f4eFFKGrmLJhtKouxMwcX9jhHtMuNYTQFu9qmHVqCAmCgmxF8jnh
        Mqrtg96Cxd8T0gIzWjwRKM/nrID+mI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-gxse7bUCNDWEjxct1YEzqw-1; Wed, 18 Oct 2023 00:45:16 -0400
X-MC-Unique: gxse7bUCNDWEjxct1YEzqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E99D3C1CC2B;
        Wed, 18 Oct 2023 04:45:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4052492BEE;
        Wed, 18 Oct 2023 04:45:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id BBAA221E6A1F; Wed, 18 Oct 2023 06:45:13 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno
 on failure
References: <20231017053738.226069-1-lizhijian@fujitsu.com>
        <874jipd6e2.fsf@pond.sub.org>
        <c6f747e3-7e2a-41de-8ff4-63e00bbf1de8@fujitsu.com>
Date:   Wed, 18 Oct 2023 06:45:13 +0200
In-Reply-To: <c6f747e3-7e2a-41de-8ff4-63e00bbf1de8@fujitsu.com> (Zhijian Li's
        message of "Wed, 18 Oct 2023 01:11:25 +0000")
Message-ID: <875y3435eu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 17/10/2023 16:01, Markus Armbruster wrote:
>> Li Zhijian <lizhijian@fujitsu.com> writes:
>> 
>>> 'errno' is being widely used by applications when ibv_reg_mr returns NULL.
>>> They all believe errno indicates the error on failure, so let's document
>>> it explicitly.
>> 
>> Similar issue with ibv_open_device() .  Possibly more.
>
> You are right, ibv_open_device()'s call chains are more complicated,
> I have not figured out if it ought to set errno though QEMU relies on it.

I think a question to answer is for what purposes callers need errno.

The only callers I know are in QEMU.  There are three:

* qemu_rdma_reg_whole_ram_blocks() and qemu_rdma_register_and_get_keys()

  When ibv_reg_mr() fails, maybe try again with IBV_ACCESS_ON_DEMAND
  added to the protection attributes.

  "Maybe": if errno is ENOTSUP, and ibv_query_device_ex() reports
  IBV_ODP_SUPPORT.

* qemu_rdma_broken_ipv6_kernel()

  This function appears to probe the devices returned by
  ibv_get_device_list().

  For each device in the list, in order: try to ibv_open_device().  If
  it fails: ignore the device if errno is EPERM, else return failure.

I'm not familiar with RDMA, and I can't say whether any of this makes
sense.

If it doesn't, we need to talk about what problem the QEMU code is
trying to solve, and how to solve it properly.

If it does, we have legitimate uses of errno, and we need to talk how to
make errno usable safely, or else how to replace its use in QEMU.

