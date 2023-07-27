Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E839A764762
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 08:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjG0G61 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 02:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjG0G60 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 02:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A12688;
        Wed, 26 Jul 2023 23:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D1B61D70;
        Thu, 27 Jul 2023 06:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB06C433C7;
        Thu, 27 Jul 2023 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690441104;
        bh=CNciP+/pNE5hEClaju1ZWb2DZJZqztngG2sT0T9at6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDu+dwv0ppc8/GEB1E9zVxsSHsPsJqh2ZoqZ+WVRF6kaqMrnrN14zcbpYTwcEBKRL
         jsK5wCnMBwVbLFtD1zJeRnD37YRZG82dDRmuT0HooLSG8YhH1v8ziPHdHBCrWMZtyl
         pqBaGkDr6/Bux3EUV7S+4RUif2ORFEFMXTwchOKHS2JHx5oMf0eecbJBV3lo095bK2
         sv7KRE6Xntc7qqSuzAOp9+SmVehfx+4gX1Y6VtF4d1zGkPWpkKnyaDpvrTaaKlw/8U
         Yw90InOuNKVtRtBSUy6TIn/g/R3QU+kFWLDLZBcqD1R5/vq3LL5cTgi6mqYOsBsgTi
         o45bktJ7U00pA==
Date:   Thu, 27 Jul 2023 09:58:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230727065820.GZ11388@unreal>
References: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
 <20230724111938.GB9776@unreal>
 <01d762f7-6388-9539-68ee-5425b4d56e58@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d762f7-6388-9539-68ee-5425b4d56e58@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 11:44:50AM +0800, Junxian Huang wrote:
> 
> 
> On 2023/7/24 19:19, Leon Romanovsky wrote:
> > On Fri, Jul 21, 2023 at 05:20:52PM +0800, Junxian Huang wrote:
> >> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> >>
> >> Previously, there was no way to query the number of lanes for a network
> >> card, so the same netdev_speed would result in a fixed pair of width and
> >> speed. As network card specifications become more diverse, such fixed
> >> mode is no longer suitable, so a method is needed to obtain the correct
> >> width and speed based on the number of lanes.
> >>
> >> This patch retrieves netdev lanes and speed from net_device and
> >> translates them to IB width and speed.
> >>
> >> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> >> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/core/verbs.c | 100 +++++++++++++++++++++++++-------
> >>  1 file changed, 79 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> >> index b99b3cc283b6..25367bd6dd97 100644
> >> --- a/drivers/infiniband/core/verbs.c
> >> +++ b/drivers/infiniband/core/verbs.c
> >> @@ -1880,6 +1880,80 @@ int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
> >>  }
> >>  EXPORT_SYMBOL(ib_modify_qp_with_udata);
> >>  
> >> +static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
> >> +				   u16 *speed, u8 *width)
> > 
> > <...>
> > 
> >> +	switch (netdev_speed / lanes) {
> >> +	case SPEED_2500:
> >> +		*speed = IB_SPEED_SDR;
> >> +		break;
> >> +	case SPEED_5000:
> >> +		*speed = IB_SPEED_DDR;
> >> +		break;
> >> +	case SPEED_10000:
> >> +		*speed = IB_SPEED_FDR10;
> >> +		break;
> >> +	case SPEED_14000:
> >> +		*speed = IB_SPEED_FDR;
> >> +		break;
> >> +	case SPEED_25000:
> >> +		*speed = IB_SPEED_EDR;
> >> +		break;
> >> +	case SPEED_50000:
> >> +		*speed = IB_SPEED_HDR;
> >> +		break;
> >> +	case SPEED_100000:
> >> +		*speed = IB_SPEED_NDR;
> >> +		break;
> >> +	default:
> >> +		*speed = IB_SPEED_SDR;
> >> +	}
> > 
> > How did you come to these translation values?
> > 
> > Thanks
> 
> The IB spec defines the mapping relationship between IB speed and transfer
> rate. For example, if the transfer rate of is 2.5Gbps(SPEED_2500), the IB
> speed will be set to IB_SPEED_SDR.

Are you referring to "Table 250 - Enumeration of the Rate"?

Thanks

> 
> Junxian
