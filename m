Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D618284C5A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFNPL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 09:15:11 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:47148 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNPL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 09:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601990111; x=1633526111;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ER9dznba7ZSP9/PBw/qDlR+7p5rNRt+Z3f6U0SG9NrE=;
  b=XxPXzd4pMd3b1jgMzrwf1VsBJX88r5tL1loVeRwxtrJBvJrwEOTRbwGA
   cAk26H+7q5pJI2gFzAJROsKbODikB5t+/Vkn6N2+Ig738Dkv7v53NGgfr
   eJdMZRg0Hzj5rLWS5tLe3sNnbI8FRfR0BMk+0wQctHQNLMYs046+zKBAV
   E=;
X-IronPort-AV: E=Sophos;i="5.77,343,1596499200"; 
   d="scan'208";a="58318697"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 06 Oct 2020 13:15:09 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 537F9A1885;
        Tue,  6 Oct 2020 13:15:07 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.221) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 6 Oct 2020 13:14:54 +0000
Subject: Re: [PATCH for-next] IB/mlx4: Convert rej_tmout radix-tree to XArray
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <eb71d8bf-d6d2-0583-d771-1bf837bd4045@amazon.com>
Date:   Tue, 6 Oct 2020 16:14:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.221]
X-ClientProxiedBy: EX13D37UWA002.ant.amazon.com (10.43.160.211) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06/10/2020 16:07, Håkon Bugge wrote:
> Fixes: b7d8e64fa9db ("IB/mlx4: Add support for REJ due to timeout")

There shouldn't be a blank line here, and the commit hash doesn't exist.

> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
