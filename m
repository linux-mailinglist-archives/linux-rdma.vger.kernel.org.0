Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6644FF157
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 10:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiDMIG5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiDMIGz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 04:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E6222B3;
        Wed, 13 Apr 2022 01:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A4760FFE;
        Wed, 13 Apr 2022 08:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0569EC385A3;
        Wed, 13 Apr 2022 08:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649837069;
        bh=UPOv6/ejqhEAowd2JOyxqFVDsijtYA9omOZSvvju9OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBtsRQEqe7JSUFTT9TrI5GsRcCVNSWIgkOOHER0Ypy06npFePK7EwDn74dKCp8ORa
         NOcGfGZ/Q0CTB8H8WaTR8HWWzXhtOAqa3doypFukq1F2qYz7ZSWC3s4SK9Q8o74QGg
         yNU40fMUQBrAiDE72x4+WUK4l/+KQsD+44eD1EwgypEd+CpKVEb3sDFneEKpS3l8/8
         r8YsHlxBJ296ore01JhaNFROuzKFNEzdqokHWx2sVmGunWD1BNLDRvqVDfyj5Lhnc/
         6+1gVIO6Ss8eJtXpKQUjuyR63cDlRzJ9qFamjE5fU7vY/Yz/oRzCtnPZK3WScxujb5
         X/t09LnH6As+Q==
Date:   Wed, 13 Apr 2022 11:04:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Limit join multicast to UD QP type only
Message-ID: <YlaECWTh+NDGMxsr@unreal>
References: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com>
 <20220408182440.GA3647277@nvidia.com>
 <YlLHjFlR8BtCc5Hu@unreal>
 <20220412141134.GI2120790@nvidia.com>
 <alpine.DEB.2.22.394.2204121653490.374115@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204121653490.374115@gentwo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 05:01:36PM +0200, Christoph Lameter wrote:
> On Tue, 12 Apr 2022, Jason Gunthorpe wrote:
> 
> > The only places setting non-default qkeys are SIDR, maybe nobody uses
> > SIDR with multicast.
> 
> 
> IP port numbers provided are ignored by the RDMA subsytem when doing
> multicast joins. Thus no need to do SIDRs with RDMA multicast.
> 
> Some middleware solutions (like LLM by IBM and Confinity) are creating
> their own custom MGID because of this problem. The custom MGID will then
> contain the port number.
> 
> On the subject of this patch: There is a usecase for Multicast with
> IBV_QPT_RAW_PACKET too. A multicast join is required to redirect traffic
> for a multicast group to the raw socket.

The qp_type in rdma-cm is a little bit misleading and represents
communication QP. It can be or RC or UD, which is hard coded in
almost all rdma-cm code.

The one of the places that receive it from the user space is ucma_get_qp_type()
for RDMA_PS_IB flow,  but librdmacm set it to RC too.

   790
   791 int rdma_create_id(struct rdma_event_channel *channel,
   792                    struct rdma_cm_id **id, void *context,
   793                    enum rdma_port_space ps)
   794 {
   795         enum ibv_qp_type qp_type;
   796
   797         qp_type = (ps == RDMA_PS_IPOIB || ps == RDMA_PS_UDP) ?
   798                   IBV_QPT_UD : IBV_QPT_RC;
   799         return rdma_create_id2(channel, id, context, ps, qp_type);
   800 }
   801


Thanks
