Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E127523A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 09:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIWHVh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 03:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWHVh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 03:21:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FAEC061755
        for <linux-rdma@vger.kernel.org>; Wed, 23 Sep 2020 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LBQKaCNrtgwPzo/pArwfTzXlWWcYkJp8YCrlC6oVvI4=; b=D0v8HnLxYOq0MivjqgMJPV8v0K
        y89NjV5NVhyqk1Re5uwohKxDJYL/mYeSArf3blbOWrbziyV78O3r/Awl95QCHJ/602LAmgd+8HPsi
        /o9f3L8EEjKq0rnBHRSoye/MlJdHqe9DPVkkhrTZv+XESnq/Myid1CxAEiDfEgBFbAzDUxqvtVgV+
        NZXdSfiqq/5Gkg8OxQ5YWhGoVwrxMUx+ht3HSWXk8mmdd641hPdlIepg1cQ/kcjWabHVJlN8YWfK2
        pm2q94tcXagtip12ctErzUAQMB/a6QCH6vXonAfRh7DfBDSQ8lWFk1sQ0OcFHk2xN+6U93Lo0jzCH
        IkTX6v2A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKz5T-0008IC-L1; Wed, 23 Sep 2020 07:21:11 +0000
Date:   Wed, 23 Sep 2020 08:21:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200923072111.GA31828@infradead.org>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org>
 <20200923064552.GG1223944@unreal>
 <20200923065416.GA25440@infradead.org>
 <20200923071035.GH1223944@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923071035.GH1223944@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 10:10:35AM +0300, Leon Romanovsky wrote:
> > If you touch this anyway I think you absolutely should move this setting
> > into the drivers, and not apply a random one in the core code.
> 
> I have no idea what will be the value for other drivers, because it was
> "global 2G size" before and no one complained.

Just lift it into all drivers into this series.  That increases the
chance that the driver maintainers will eventually notice it :)

> 
> Thanks
---end quoted text---
