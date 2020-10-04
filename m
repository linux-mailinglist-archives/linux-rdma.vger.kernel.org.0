Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D07282A55
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgJDLEe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 07:04:34 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:48056 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDLEe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Oct 2020 07:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601809474; x=1633345474;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=M36lTVHZ2T8IMpGa+ebP+wZGp+UiU+eaVm83Rl3/OgM=;
  b=NjBtJV9YaJoZdEvq+mrLVfJgSpse5tg051RVznO3k0R4WKYKlm8wvHLg
   Js6yZ4UY5hhGzQBumUtkt806qzLgiV3z6nP1AudNuZpo1YuAFG/YETX9k
   B+LyxlXP5iGFlzrgjAtmHV/R0oK0jSgsrWzGeqEhIE4fq54x5OK0g6ZLx
   c=;
X-IronPort-AV: E=Sophos;i="5.77,335,1596499200"; 
   d="scan'208";a="57606201"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 04 Oct 2020 11:04:32 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 8A948A1B76;
        Sun,  4 Oct 2020 11:04:30 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.73) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 4 Oct 2020 11:04:22 +0000
Subject: Re: [PATCH 02/11] RDMA: Remove uverbs_ex_cmd_mask values that are
 linked to functions
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Lijun Ou <oulijun@huawei.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>
References: <2-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <52566b00-efd8-f797-abe8-2bdd11626213@amazon.com>
Date:   Sun, 4 Oct 2020 14:04:17 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D11UWB002.ant.amazon.com (10.43.161.20) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/10/2020 2:20, Jason Gunthorpe wrote:
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 418d133a8fb080..2f3f9b87922e92 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -3753,7 +3753,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
>  			IB_USER_VERBS_EX_CMD_MODIFY_CQ,
>  			ib_uverbs_ex_modify_cq,
>  			UAPI_DEF_WRITE_I(struct ib_uverbs_ex_modify_cq),
> -			UAPI_DEF_METHOD_NEEDS_FN(create_cq))),
> +			UAPI_DEF_METHOD_NEEDS_FN(modify_cq))),

Good catch, but is it related to this patch?
