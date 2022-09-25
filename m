Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3ED5E9211
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Sep 2022 12:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiIYKWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Sep 2022 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIYKWd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Sep 2022 06:22:33 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361032B84
        for <linux-rdma@vger.kernel.org>; Sun, 25 Sep 2022 03:22:30 -0700 (PDT)
Message-ID: <08d68e02-1d32-9ca1-ac92-edeb20119f5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664101347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SU8d4MS1WoA/msqotcSke+2LgW64+f+eQWwsfe10yMI=;
        b=fiI4/DLkSfMpbuOw+fxdistQ09+KaFB78rKk9tG9vCKj13KDWo5xREuEwnPRXK8QPaRTVI
        M5A3bpDfgJKryDfgrr6GSCKkSBWNFDRGD0uQ151a/nEjOgYtc7/G6B/9kH21jI2erk0NvQ
        1zsLIgSgMTM123zmx+O/8z2Tn2Cs4RQ=
Date:   Sun, 25 Sep 2022 18:22:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
To:     yanjun.zhu@linux.dev, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, jgg@nvidia.com
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220926024033.284341-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/9/26 10:40, yanjun.zhu@linux.dev 写道:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> When the net devices are moved to another net namespace, the command
> "rdma link" should not dispaly the rdma link about this net device.
> 
> For example, when the net device eno12399 is moved to net namespace net0
> from init_net, the rdma link of eno12399 should not display in init_net.
> 
> Before this change:
> 
> Init_net:
> 
> link roceo12399/1 state DOWN physical_state DISABLED  <---should not display
> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> 
> net0:
> 
> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> link roceo12409/1 state DOWN physical_state DISABLED <---should not display
> link rocep202s0f0/1 state DOWN physical_state DISABLED <---should not display
> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP <---should not display
> 
> After this change
> 
> Init_net:
> 
> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> 
> net0:
> 
> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> 
> Fixes: da990ab40a92 ("rdma: Add link object")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Hi Leon

This commit is to fix a problem in "rdma link show" of iproute2.
I do not know the maillist of iproute2. So I send the commit here.
If you know the maillist, please let me know.

Thanks and Regards,
Zhu Yanjun

> ---
>   rdma/link.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/rdma/link.c b/rdma/link.c
> index bf24b849..449a7636 100644
> --- a/rdma/link.c
> +++ b/rdma/link.c
> @@ -238,6 +238,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
>   		return MNL_CB_ERROR;
>   	}
>   
> +	if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] || !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])
> +		return MNL_CB_OK;
> +
>   	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
>   	port = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
>   	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);

