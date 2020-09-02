Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3652F25A85E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 11:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBJKY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 05:10:24 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44328 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBJKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 05:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599037807; x=1630573807;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=1sTEZX95W0n1SEjuap+DwXQAqVMKF3QHH1J5iXg/rEo=;
  b=phskSSgF+xoy4Lt8wg5EUlSOCgNmK72Yb3mQw06u3Ejwmn02FqJVYor5
   YsG6XeY7CDW8ctqo5g2s4iLMT2/hNluYUtAbkBppERp90wXWV24SOcDah
   K25/yQyph28cvkqmnqTUSJE6ARkWmqLWsPK1qLe82nFHPA2vBrpUAKZgy
   M=;
X-IronPort-AV: E=Sophos;i="5.76,381,1592870400"; 
   d="scan'208";a="51515142"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Sep 2020 09:10:04 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 13D34A18A4;
        Wed,  2 Sep 2020 09:10:01 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Sep 2020 09:09:46 +0000
Subject: Re: [PATCH 00/14] RDMA: Improve use of umem in DMA drivers
To:     Jason Gunthorpe <jgg@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8bb0555d-b2d4-8046-5e1a-5393d502adf9@amazon.com>
Date:   Wed, 2 Sep 2020 12:09:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D11UWC001.ant.amazon.com (10.43.162.151) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02/09/2020 3:43, Jason Gunthorpe wrote:
> This is the first series in an effort to modernize the umem usage in all
> the DMA drivers.

Can you please explain what are the next steps? What's the final goal?
