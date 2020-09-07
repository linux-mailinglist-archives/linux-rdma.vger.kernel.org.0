Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2B25FA52
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgIGMSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:18:45 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:53566 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgIGMRA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 08:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599481020; x=1631017020;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=GmZLaYehet2rhT9INd3WxR7miH/fWBHQgomzxF8VBtU=;
  b=TxVge9ShQDDmjLyGKsUxpzBropNmnyG041sN9V5y58+RzgL2kGIb2kT5
   0UvGG1wRHdfxE+cA9DXUqapUqecK2rmjITw57zohHtViogjrGQA6HeB5B
   HuIEkNzm8HRz48lTR57fG5InW48k4YdqxkPAaBFSOVt6P2blZjkxZItc8
   E=;
X-IronPort-AV: E=Sophos;i="5.76,401,1592870400"; 
   d="scan'208";a="66010422"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Sep 2020 12:16:21 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 0C79CA2290;
        Mon,  7 Sep 2020 12:16:19 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.38) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 7 Sep 2020 12:16:14 +0000
Subject: Re: [PATCH v2 06/17] RDMA/umem: Split ib_umem_num_pages() into
 ib_umem_num_dma_blocks()
To:     Jason Gunthorpe <jgg@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
References: <6-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <530c0a69-0477-ab2a-6fd4-016b938b0bb5@amazon.com>
Date:   Mon, 7 Sep 2020 15:16:08 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13P01UWB001.ant.amazon.com (10.43.161.59) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/09/2020 1:41, Jason Gunthorpe wrote:
> ib_num_pages() should only be used by things working with the SGL in CPU

Nit: ib_umem_num_pages().
