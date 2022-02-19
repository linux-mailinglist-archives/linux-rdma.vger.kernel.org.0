Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9770D4BC7B8
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Feb 2022 11:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiBSKhz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Feb 2022 05:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiBSKhy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Feb 2022 05:37:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8286E55F
        for <linux-rdma@vger.kernel.org>; Sat, 19 Feb 2022 02:37:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5144760FD7
        for <linux-rdma@vger.kernel.org>; Sat, 19 Feb 2022 10:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2BC004E1;
        Sat, 19 Feb 2022 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645267054;
        bh=IDlF/g/GvKeEXGEfMkKgU/g/z70dxIC+ExVuxRNS61U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OehjLRyEU9TnCS+6rZMkUJw8nu/Z0VR/C1NB8L4rXzPjcEWqvYvtu+9IfknpTPM81
         ufUDGoUveLI+RZla1o+b4WT+TMjorj4QTcuSWVmG7IqC7EJyc+fqHMmxPngviGbNvR
         TKfZGDvigMDQ5YpMTFDEAhrX+jcpyu32SinNz8U1e+dR4Au6LL1rbipa2SbteXqel8
         Cy6ClFMwrQVpanyR75jLCGrwxgh559nlsqxkXSpPJ2nGWYAHwYBAvHCIxwLAi4fnG6
         +KXicxJHgH3kWgYg/ORAbZjNl11bj+28C2CcpizMq8d6L767zEPx/Ym08cB/iuX6be
         QJVXInmX8Y60A==
Date:   Sat, 19 Feb 2022 12:37:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <YhDIZhzO5ksxOKRA@unreal>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <e372156a-2859-f43d-6862-96cb4470a614@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e372156a-2859-f43d-6862-96cb4470a614@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 03:50:02AM +0000, yangx.jy@fujitsu.com wrote:
> On 2021/12/30 20:14, Xiao Yang wrote:
> > The IB SPEC v1.5[1][2] added new RDMA operations (Atomic Write and Flush).
> > This patchset makes SoftRoCE support new RDMA Atomic Write on RC service.
> >
> > I added RDMA Atomic Write API and a rdma_atomic_write example on my
> > rdma-core repository[3].  You can verify the patchset by building and
> > running the rdma_atomic_write example.
> > server:
> > $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
> > client:
> > $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
> 
> Hi Leon,
> 
> Do you think when I should post the userspace patchset to rdma-core?
> 
> I'm not sure if I should post it to rdma-core as a PR until the kernel 
> patchset is merged?

For any UAPI changes, we require to present actual user space part. So
the PR to rdma-core is needed in order to merge the kernel series.

In this PR, the first patch is created with "kernel-headers/update --not-final"
script against local version of kernel headers. Once the kernel part is merged,
you will update that first patch and force push the rdma-core PR.

Thanks

> 
> Best Regards,
> 
> Xiao Yang
> 
> >
> > [1]: https://www.infinibandta.org/ibta-specification/ # login required
> > [2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
> > [3]: https://github.com/yangx-jy/rdma-core
> >
> > BTW: This patchset also needs the following fix.
> > https://www.spinics.net/lists/linux-rdma/msg107838.html
> >
> > Xiao Yang (2):
> >    RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
> >      resp_res
> >    RDMA/rxe: Add RDMA Atomic Write operation
> >
> >   drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
> >   drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++
> >   drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
> >   drivers/infiniband/sw/rxe/rxe_qp.c     |  5 ++-
> >   drivers/infiniband/sw/rxe/rxe_req.c    | 10 +++--
> >   drivers/infiniband/sw/rxe/rxe_resp.c   | 59 ++++++++++++++++++++------
> >   drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
> >   include/rdma/ib_pack.h                 |  2 +
> >   include/rdma/ib_verbs.h                |  2 +
> >   include/uapi/rdma/ib_user_verbs.h      |  2 +
> >   10 files changed, 88 insertions(+), 19 deletions(-)
> >
