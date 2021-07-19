Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0A3CD5E9
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbhGSNAk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 09:00:40 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:46583 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbhGSNAb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 09:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1626702072; x=1658238072;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VMssaUbPm4dE6gzbwHAeciAypZZXTn2UKCJM5wa7Mo8=;
  b=CfBZCu26JRYBRm1Uz/wAyyZ9z1lWDeFMjdEqBOvhQJ/FZZiULCiDuZRl
   XOGn8/dAh0EL9hLLXEH4mW0jAMB9/FLKXK4yKGr9E77TcTxYq86ZuaFOd
   MmB84P+bNlYLBxboI6YGVokQGKykxbRTHk/NBzpPgXaWlBE1MqHFu0S05
   o=;
X-IronPort-AV: E=Sophos;i="5.84,252,1620691200"; 
   d="scan'208";a="126337583"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 19 Jul 2021 13:40:55 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 897C5A212D;
        Mon, 19 Jul 2021 13:40:46 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.85) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 19 Jul 2021 13:40:35 +0000
Subject: Re: [PATCH rdma-next 3/9] RDMA/efa: Remove double QP type assignment
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1626609283.git.leonro@nvidia.com>
 <e678ec6cf38a529b0d09dd834f502e4b9d97433a.1626609283.git.leonro@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <57731df1-2c90-815a-d17c-452becca2dae@amazon.com>
Date:   Mon, 19 Jul 2021 16:40:29 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e678ec6cf38a529b0d09dd834f502e4b9d97433a.1626609283.git.leonro@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.85]
X-ClientProxiedBy: EX13D28UWB001.ant.amazon.com (10.43.161.98) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/07/2021 15:00, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The QP type is set by the IB/core and shouldn't be set in the driver.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks,
Acked-by: Gal Pressman <galpress@amazon.com>
