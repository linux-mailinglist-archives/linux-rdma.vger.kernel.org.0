Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5A4FE45C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiDLPNI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356854AbiDLPNG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 11:13:06 -0400
X-Greylist: delayed 547 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 08:10:46 PDT
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7EE5D664;
        Tue, 12 Apr 2022 08:10:46 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 84A41B00220; Tue, 12 Apr 2022 17:01:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 82CD5B001DF;
        Tue, 12 Apr 2022 17:01:36 +0200 (CEST)
Date:   Tue, 12 Apr 2022 17:01:36 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
cc:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Limit join multicast to UD QP type
 only
In-Reply-To: <20220412141134.GI2120790@nvidia.com>
Message-ID: <alpine.DEB.2.22.394.2204121653490.374115@gentwo.de>
References: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com> <20220408182440.GA3647277@nvidia.com> <YlLHjFlR8BtCc5Hu@unreal> <20220412141134.GI2120790@nvidia.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 12 Apr 2022, Jason Gunthorpe wrote:

> The only places setting non-default qkeys are SIDR, maybe nobody uses
> SIDR with multicast.


IP port numbers provided are ignored by the RDMA subsytem when doing
multicast joins. Thus no need to do SIDRs with RDMA multicast.

Some middleware solutions (like LLM by IBM and Confinity) are creating
their own custom MGID because of this problem. The custom MGID will then
contain the port number.

On the subject of this patch: There is a usecase for Multicast with
IBV_QPT_RAW_PACKET too. A multicast join is required to redirect traffic
for a multicast group to the raw socket.

